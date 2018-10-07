#define F_CPU 8000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/eeprom.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <avr/sleep.h>
#include <stdbool.h>
#include <avr/power.h>
#include "Libraries/BMP280.h"

#define LED_OUTPUT DDRA |= (1 << DDA0)
#define LED_ON PORTA |= (1 << PA0)
#define LED_OFF PORTA &= ~(1 << PA0)

#define BMP_CS_OUTPUT  DDRA |= (1 << DDA7)
#define BMP_CS_LOW PORTA &= ~(1 << PA7)
#define BMP_CS_HIGH PORTA |= (1 << PA7)

//these set the launch threshold to 5 meters in 1 second
//5 meters (launchTrigger), 200mS (pollingDelay + loop time) x 5 samples (num. elements in altitudeLog)
#define launchTrigger 5 //meters between altitudeLog
#define pollingDelay 191 //mS
uint32_t altitudeLog[] = {0, 0, 0, 0, 0};

#define bootDelay 5000 //delay in mS

#define altitudeOffset 1000 //instead of logging signed values to eeprom, log unsigned with a small offset to prevent negatives

#define expWeight 1.0 //closer to 0 favors old var, closer to 1 favors new var

bool LED = false;
bool lowBattery = false;
int LEDTimer = 0;
bool launch = false;

void SPI_Master_Init(void) {
  DDRA |= (1 << DDA4) | (1 << DDA6);
  SPCR = (1 << SPE) | (1 << MSTR) | (1 << SPR0);
  BMP_CS_OUTPUT;
  BMP_CS_HIGH;
}

void uart0_putchar(char c) {
  while (!(UCSR0A & (1 << UDRE0)));
  UDR0 = c;
}

void uart0_init(void) {
  UCSR0C |= ((1 << UCSZ01) | (1 << UCSZ00));
  UCSR0B |= ((1 << RXEN0) | (1 << TXEN0)); //enable UART
  UBRR0L = 51; //from Table 18-8 in ATTiny841 datasheet 9600 baud at 8MHz
  //UBRR0L = 26; //from Table 18-8 in ATTiny841 datasheet 1200 baud at 512KHz
  //UCSR0A |= (1 << U2X0);
}

char uart0_getchar(void) {
  while (!(UCSR0A & (1 << RXC0)));
  return UDR0;
}

void uart0_printInt(uint16_t c) {
  char buffer[5] = {}; //max size of int is 65535 or 5 digits
  itoa(c, buffer, 10);
  int i;
  for (i = 0; i < 5; i++) {
    if (buffer[i])
      uart0_putchar(buffer[i]);
  }
}

void uart0_printInt20_t(int32_t c) {
  int temp = c / 10000;
  uart0_printInt(temp);
  c -= temp * 10000;
  if (c == 0) {
    uart0_putchar('0');
    uart0_putchar('0');
    uart0_putchar('0');
    uart0_putchar('0');
  } else {
    uart0_printInt(c);
  }
  uart0_putchar('\n');
}

uint16_t measureVcc(void) {
  ADCSRA |= (1 << ADSC); //start reading
  while (ADCSRA & (1 << ADSC));
  int adcLow = ADCL;
  int adcHigh = ADCH;
  return (adcHigh << 8) | adcLow;
}

void blinkAltitude(void){
	int maxAltitude = 0;
	int i;
	for (i = 12; i < 512; i  += 2){
		int currentAltitude = eeprom_read_word((uint16_t * ) i);
		if (currentAltitude > maxAltitude){
			maxAltitude = currentAltitude;
		}
	}
	maxAltitude -= eeprom_read_word((uint16_t * ) 12);
	int altitudeBlinks[] = {-1, -1, -1, -1, -1};
	for (i = 4; i >= 0; i --){
		if (maxAltitude % 10 == 0){
			altitudeBlinks[i] = 10;
		} else {
			altitudeBlinks[i] = maxAltitude % 10;
		}
		maxAltitude /= 10;
	}
	for (i = 0; i <= 4; i ++){
		int j;
		for (j = 0; j < altitudeBlinks[i]; j ++){
			LED_ON;
			_delay_ms(200);
			LED_OFF;
			_delay_ms(200);
		}
		_delay_ms(1500);
	}
}

void altitudeLogPush(uint32_t push){
	int i;
	for (i = 0; i < 4; i ++){
		altitudeLog[i] = altitudeLog[i + 1];
	}
	altitudeLog[4] = push;
}

int main() {
  /*    TIMER 0 SETUP    */
  TCCR0B |= (1 << CS02) | (1 << CS00); //Table 11-9 clk/1024 prescale
  TIMSK0 |= (1 << TOIE0); //timer 0 overflow interrupt enable

  LED_OUTPUT;
  LED_ON;
  _delay_ms(1000);
  LED_OFF;
  ADCSRA |= (1 << ADEN); //enable ADC Vcc as reference
  ADMUXA = 0b00001101; //1.1V MUX selection, calibrated below
  power_usart1_disable(); //save power
  uart0_init();
  SPI_Master_Init();

  /*    CHECK BMP280 ID    */
  char ID = SPI_RW_8(0xD0, 0x00);
  while (ID != 0x58) {
    LED_ON;
  }

  _delay_ms(100);
  BMP_Normal_Mode();
  _delay_ms(100);
  BMP_Set_Calib_Vars();
  blinkAltitude();
  _delay_ms(bootDelay); //give time for things to settle
  sei();
  int vccCal = eeprom_read_word((uint16_t * ) 0);
  BMP_Pressure_Cal = (float) BMP_Pressure();
  uint32_t altitudeOld = BMP_Altitude(); //init this variable
  int eepromIndex = 20;
  while (1) {
    //uart0_putchar('\n');
    /*    CHECK UART    */
    if ((UCSR0A & (1 << RXC0))) {
      char UDRData = UDR0;
      if (UDRData == 'f') { //Flash EEPROM
        uint16_t vcc = measureVcc(); //vccCal
        uart0_printInt(vcc);
        uart0_putchar('\n');
        eeprom_write_word((uint16_t * ) 0, vcc);
				_delay_ms(100);

        char data = uart0_getchar(); //firmware version
        eeprom_write_word((uint16_t * ) 2, data);
        uart0_printInt(data);
        uart0_putchar('\n');
				_delay_ms(100);

        data = uart0_getchar(); //month
        eeprom_write_word((uint16_t * ) 4, data);
        uart0_printInt(data);
        uart0_putchar('\n');
				_delay_ms(100);

        data = uart0_getchar(); //day
        eeprom_write_word((uint16_t * ) 6, data);
        uart0_printInt(data);
        uart0_putchar('\n');
				_delay_ms(100);

        data = uart0_getchar(); //year
        eeprom_write_word((uint16_t * ) 8, data);
        uart0_printInt(data);
        uart0_putchar('\n');
				_delay_ms(100);
      }
      if (UDRData == 'd') { //download flight data
        int i;
        for (i = 12; i < 512; i += 2) {
          uint16_t altitudeData = eeprom_read_word((uint16_t * ) i);
          uart0_printInt(altitudeData);
          uart0_putchar('\n');
          _delay_ms(5);
        }
      }
    }

    /*    EXPONENTIAL FILTER    */
    uint32_t altitudeNew = expWeight * BMP_Altitude() + (1.0 - expWeight) * altitudeOld;

    /*    DETECT LAUNCH AVERAGE    */
    if (!launch) {
      altitudeLogPush(altitudeNew); //push altitudeNew into the pre launch buffer
      if (altitudeLog[4] > altitudeLog[0] + launchTrigger) {
        LED_OFF; //turn LED off
        cli(); //disable LED ISR
        launch = true;
        int i;
        for (i = 12; i < eepromIndex; i += 2){ //write altitudeLog
      	   eeprom_write_word((uint16_t * ) i, (uint16_t) altitudeLog[(i - 12) / 2]);
        }
        //for (i = eepromIndex; i < 512; i += 2) {//this code can cause brownouts
        //eeprom_write_word((uint16_t * ) i, (uint16_t) altitudeLog[0]);
        //}
        //eeprom_write_word((uint16_t * ) 12, (uint16_t) altitudeOld);
      }
    }

    /*    LOG DATA DURING LAUNCH    */
    if (launch) {
      if (eepromIndex < 512) {
        eeprom_write_word((uint16_t * ) eepromIndex, (uint16_t) altitudeNew);
        eepromIndex += 2;
      } else {
		    set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  		  sleep_mode();
	    }
    }

    altitudeOld = altitudeNew;

    /*    LOW BATTERY WARNING    */
    if (!launch) {
      int vcc = measureVcc();
      if (vcc >= vccCal) { //low battery (1.1V / 2.2V) * 1023 = 563
        lowBattery = true;
      }
    }
    _delay_ms(pollingDelay);
  }
}

ISR(TIMER0_OVF_vect) { //blinks status LED
  cli();
  LEDTimer++;
  if (LED && (!launch && (LEDTimer > 5 && !lowBattery)) || !LED && (!launch && (LEDTimer > 50 && !lowBattery)) || (LEDTimer > 10 && lowBattery)) {
    LEDTimer = 0;
    if (LED) {
      LED = false;
      LED_OFF;
    } else {
      LED = true;
      LED_ON;
    }
  }
  sei();
}
