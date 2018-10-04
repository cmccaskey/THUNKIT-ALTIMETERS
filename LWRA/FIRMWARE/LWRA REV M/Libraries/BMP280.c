#define F_CPU 8000000UL

#include <avr/io.h>
#include <util/delay.h>
#include <avr/eeprom.h>
#include <avr/interrupt.h>
#include <util/delay.h>
#include <avr/sleep.h>
#include <stdbool.h>
#include <avr/power.h>

#define altitudeOffset 1000

char SPI_RW_8(unsigned char reg_A, unsigned char reg_B) {
  PORTA &= ~(1 << PA7); //SS low
  SPDR = reg_A;
  while (!(SPSR & (1 << SPIF)));
  SPDR = reg_B;
  while (!(SPSR & (1 << SPIF)));
  PORTA |= (1 << PA7); //SS high
  //_delay_ms(15);
  return SPDR;
}

int16_t BMP_Burst_Read_16(char startReg) {
  int16_t data = 0;
  PORTA &= ~(1 << PA7); //SS low
  SPDR = startReg;
  while (!(SPSR & (1 << SPIF)));
  SPDR = 0x00; //shift clock
  while (!(SPSR & (1 << SPIF)));
  data |= SPDR; //LSB
  SPDR = 0x00; //shift clock
  while (!(SPSR & (1 << SPIF)));
  int16_t SPDRShift = SPDR;
  SPDRShift <<= 8;
  data |= SPDRShift; //MSB
  PORTA |= (1 << PA7); //SS high
  return data;
}

unsigned short dig_T1, dig_P1;
signed short dig_T2, dig_T3, dig_P2, dig_P3, dig_P4, dig_P5, dig_P6, dig_P7, dig_P8, dig_P9;

void BMP_Set_Calib_Vars(void) {
  dig_T1 = BMP_Burst_Read_16(0x88);
  dig_T2 = BMP_Burst_Read_16(0x8A);
  dig_T3 = BMP_Burst_Read_16(0x8C);
  dig_P1 = BMP_Burst_Read_16(0x8E);
  dig_P2 = BMP_Burst_Read_16(0x90);
  dig_P3 = BMP_Burst_Read_16(0x92);
  dig_P4 = BMP_Burst_Read_16(0x94);
  dig_P5 = BMP_Burst_Read_16(0x96);
  dig_P6 = BMP_Burst_Read_16(0x98);
  dig_P7 = BMP_Burst_Read_16(0x9A);
  dig_P8 = BMP_Burst_Read_16(0x9C);
  dig_P9 = BMP_Burst_Read_16(0x9E);
}

#define BMP280_S32_t int32_t
#define BMP280_U32_t uint32_t

void BMP_Normal_Mode(void) {
  SPI_RW_8(0xF4 & ~0x80, 0b01010111); //normal mode 16X pressure 2X temperature
  SPI_RW_8(0xF5 & ~0x80, 0b00010000); //IIR coeff. 16
}

char SPI_Transfer(char c) {
  SPDR = c;
  while (!(SPSR & (1 << SPIF)));
  return SPDR;
}

int32_t BMP_Burst_Read_20(char start) {
  int32_t data = 0;
  PORTA &= ~(1 << PA7); //SS low
  SPDR =  start | 0x80; //temp MSB
  while (!(SPSR & (1 << SPIF)));
  SPDR = 0x00;
  while (!(SPSR & (1 << SPIF)));
  data |= SPDR;
  data <<= 8;
  SPDR = 0x00;
  while (!(SPSR & (1 << SPIF)));
  data |= SPDR;
  data <<= 8;
  SPDR = 0x00;
  while (!(SPSR & (1 << SPIF)));
  data |= SPDR;
  data >>= 4;
  PORTA |= (1 << PA7); //SS high
  //_delay_ms(15);
  return data;
}


BMP280_S32_t t_fine; 
float BMP_Pressure_Cal;

int32_t BMP_Temperature(void){
    int32_t adc_T = BMP_Burst_Read_20(0xFA);
  BMP280_S32_t var1, var2, T;
  var1 = ((((adc_T >> 3) - ((BMP280_S32_t)dig_T1 << 1))) * ((BMP280_S32_t)dig_T2)) >> 11;
  var2 = (((((adc_T >> 4) - ((BMP280_S32_t)dig_T1)) * ((adc_T >> 4) - ((BMP280_S32_t)dig_T1))) >> 12) * ((BMP280_S32_t)dig_T3)) >> 14;
  t_fine = var1 + var2;
  T = (t_fine * 5 + 128) >> 8;
  return T;
}

uint32_t BMP_Pressure(void) {
BMP_Temperature(); //set t_fine
delay_ms(1);
int32_t adc_P = BMP_Burst_Read_20(0xF7);
  BMP280_S32_t var1, var2;
  BMP280_U32_t p;
  var1 = (((BMP280_S32_t) t_fine) >> 1) - (BMP280_S32_t) 64000;
  var2 = (((var1 >> 2) * (var1 >> 2)) >> 11) * ((BMP280_S32_t) dig_P6);
  var2 = var2 + ((var1 * ((BMP280_S32_t) dig_P5)) << 1);
  var2 = (var2 >> 2) + (((BMP280_S32_t) dig_P4) << 16);
  var1 = (((dig_P3 * (((var1 >> 2) * (var1 >> 2)) >> 13)) >> 3) + ((((BMP280_S32_t) dig_P2) * var1) >> 1)) >> 18;
  var1 = ((((32768 + var1)) * ((BMP280_S32_t) dig_P1)) >> 15);
  if (var1 == 0) {
    return 0;
  }
  p = (((BMP280_U32_t)(((BMP280_S32_t) 1048576) - adc_P) - (var2 >> 12))) * 3125;
  if (p < 0x80000000) {
    p = (p << 1) / ((BMP280_U32_t) var1);
  } else {
    p = (p / (BMP280_U32_t) var1) * 2;
  }
  var1 = (((BMP280_S32_t) dig_P9) * ((BMP280_S32_t)(((p >> 3) * (p >> 3)) >> 13))) >> 12;
  var2 = (((BMP280_S32_t)(p >> 2)) * ((BMP280_S32_t) dig_P8)) >> 13;
  p = (BMP280_U32_t)((BMP280_S32_t) p + ((var1 + var2 + dig_P7) >> 4));
  return p;
}

int32_t BMP_Air_Density(void) { //returns in kg/m^3
  float T = (float)BMP_Temperature() / 100 + 273.15; //degrees K
  float P = BMP_Pressure(); //Pascals
  float p = P / (287.05 * T);
  return p * 100;
}

int32_t BMP_Altitude(void) {
  float pressure = (float)BMP_Pressure();
  float altitude = 44300 * (1.0 - pow(pressure / BMP_Pressure_Cal, 0.1903)); //reports in meters :)
  int32_t altitude_uint32_t = altitude;
  return altitude_uint32_t + altitudeOffset;
}
