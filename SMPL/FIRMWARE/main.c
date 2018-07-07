// avrdude -U lfuse:w:0xE2:m -c usbtiny -p attiny43u

#define F_CPU 8000000UL

#define LED_ON PORTB |= (1 << PB2)
#define LED_OFF PORTB &= ~(1 << PB2)

#define launchTrigger 2 // feet in pollingDelay
#define bootDelay 5000   // delay in mS
#define pollingDelay 100 // mS

#define altitudeOffset 1000

#define expWeight 0.5 // closer to 0 favors old var, closer to 1 favors new var

#include <avr/eeprom.h>
#include <avr/io.h>
#include <stdbool.h>
#include <util/delay.h>
#include "Libraries/BMP280.h" //this must go after all other #includes

void blinkAltitude(void) {
  int maxAltitude = 0;
  int i;
  for (i = 0; i < 62; i += 2) {
    int currentAltitude = eeprom_read_word((uint16_t *)i);
    if (eeprom_read_word((uint16_t *)i) > maxAltitude) {
      maxAltitude = currentAltitude;
    }
  }
  if (maxAltitude == 0){
    return;
  }
  char altitudeBlinks;
  for (i = 4; i >= 0; i--) {
    if (maxAltitude % 10 == 0) {
      altitudeBlinks = 10;
    } else {
      altitudeBlinks = maxAltitude % 10;
    }
    maxAltitude /= 10;
    int j;
    for (j = 0; j < altitudeBlinks; j++) {
      LED_ON;
      _delay_ms(200);
      LED_OFF;
      _delay_ms(200);
    }
    _delay_ms(1500);
  }
}

int main() {
  bool LED = false;
  bool launch = false;
  DDRB |= (1 << PB2) | (1 << PB5) | (1 << PB6) |
          (1 << PB3); // LED SCK MOSI CS output 5 6 3
  USICR |= (1 << USIWM0) | (1 << USICS1) | (1 << USICS0) | (1 << USITC); //| (1 << USICS1)
  LED_ON;
  /*    CHECK BMP280 ID    */
    PORTB |= (1 << PB3);

  _delay_ms(500);
  char ID;
  ID = SPI_RW_8(0xD0, 0x00);

  while (ID != 0x58) {
    LED_ON;
  }
  LED_OFF;
  LED = false;

  _delay_ms(100);
  BMP_Normal_Mode();
  _delay_ms(100);
  BMP_Set_Calib_Vars();
  //blinkAltitude();
  _delay_ms(bootDelay); //give time for things to settle
  // sei();
  BMP_Pressure_Cal = BMP_Pressure();
  uint32_t altitudeOld = BMP_Altitude(); // init this variable
  int eepromIndex = 0;
  while (1) {
    /*    EXPONENTIAL FILTER    */
    uint32_t altitudeNew =
        expWeight * BMP_Altitude() + (1.0 - expWeight) * altitudeOld;

    /*    DETECT LAUNCH    */
    if (!launch) {
      if (altitudeNew > altitudeOld + launchTrigger) {
        launch = true;
        int i;
        for (i = 0; i < 62; i += 2) {
          eeprom_write_word((uint16_t *)i, (uint16_t)1000);
        }
        eeprom_write_word((uint16_t *)0, (uint16_t)altitudeOld);
      }
    }

    altitudeOld = altitudeNew;

    if (launch) {
      if (eepromIndex < 62) {
        eeprom_write_word((uint16_t *)eepromIndex, (uint16_t)altitudeNew);
        eepromIndex += 2;
      }
    }

    if (!launch && !LED) {
      LED_ON;
      LED = true;
    } else if (LED){
      LED_OFF;
      LED = false;
    }
    if (launch){
      LED_OFF;
    }
    _delay_ms(pollingDelay);
  }
}
