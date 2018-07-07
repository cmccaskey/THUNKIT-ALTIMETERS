char SPITransferUSI(char regOut) {
  USIDR = regOut;
  int j;
  for (j = 0; j < 16; j ++){
     USICR |= (1 << USITC) | (1 << USICLK); //strobe sck and counter
     //_delay_us(5); //slow down sck freq.
  }
  return USIDR;
}

char SPI_RW_8(unsigned char reg_A, unsigned char reg_B) {
  char SPDR;
  PORTB &= ~(1 << PB3); // SS low
  SPITransferUSI(reg_A);
  SPDR = SPITransferUSI(reg_B);
  PORTB |= (1 << PB3); // SS high
  return SPDR;
}

int16_t BMP_Burst_Read_16(char startReg) {
  char SPDR;
  int16_t data = 0;
  PORTB &= ~(1 << PB3); // SS low
  SPITransferUSI(startReg);
  SPITransferUSI(0x00);
  data |= SPITransferUSI(0x00);
  int16_t SPDRShift = SPITransferUSI(0x00);
  SPDRShift <<= 8;
  data |= SPDRShift;   // MSB
  PORTB |= (1 << PB3); // SS high
  return data;
}

unsigned short dig_T1, dig_P1;
signed short dig_T2, dig_T3, dig_P2, dig_P3, dig_P4, dig_P5, dig_P6, dig_P7,
    dig_P8, dig_P9;

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
  SPI_RW_8(0xF4 & ~0x80, 0b01010111); // normal mode 16X pressure 2X temperature
  SPI_RW_8(0xF5 & ~0x80, 0b00010000); // IIR coeff. 16
}

char SPI_Transfer(char c) {
  char SPDR;
  SPDR = SPITransferUSI(c);
  return SPDR;
}

int32_t BMP_Burst_Read_20(char start) {
  char SPDR;
  int32_t data = 0;
  PORTB &= ~(1 << PB3); // SS low
  SPITransferUSI(start | 0x80);
  data |= SPITransferUSI(0x00);
  data <<= 8;
  data |= SPITransferUSI(0x00);
  data <<= 8;
  data |= SPITransferUSI(0x00);
  data >>= 4;
  PORTB |= (1 << PB3); // SS high
  return data;
}

BMP280_S32_t t_fine;
int BMP_Pressure_Cal;

//int32_t t_fine = 800;
int32_t BMP_Temperature(void){
    int32_t adc_T = BMP_Burst_Read_20(0xFA);
  BMP280_S32_t var1, var2, T;
  var1 = ((((adc_T >> 3) - ((BMP280_S32_t)dig_T1 << 1))) *
((BMP280_S32_t)dig_T2)) >> 11; var2 = (((((adc_T >> 4) - ((BMP280_S32_t)dig_T1))
* ((adc_T >> 4) - ((BMP280_S32_t)dig_T1))) >> 12) * ((BMP280_S32_t)dig_T3)) >>
14; t_fine = var1 + var2; T = (t_fine * 5 + 128) >> 8; return T;
}

uint32_t BMP_Pressure(void) {
   BMP_Temperature(); //set t_fine
  int32_t adc_P = BMP_Burst_Read_20(0xF7);
  BMP280_S32_t var1, var2;
  BMP280_U32_t p;
  var1 = (((BMP280_S32_t)t_fine) >> 1) - (BMP280_S32_t)64000;
  var2 = (((var1 >> 2) * (var1 >> 2)) >> 11) * ((BMP280_S32_t)dig_P6);
  var2 = var2 + ((var1 * ((BMP280_S32_t)dig_P5)) << 1);
  var2 = (var2 >> 2) + (((BMP280_S32_t)dig_P4) << 16);
  var1 = (((dig_P3 * (((var1 >> 2) * (var1 >> 2)) >> 13)) >> 3) +
          ((((BMP280_S32_t)dig_P2) * var1) >> 1)) >>
         18;
  var1 = ((((32768 + var1)) * ((BMP280_S32_t)dig_P1)) >> 15);
  if (var1 == 0) {
    return 0;
  }
  p = (((BMP280_U32_t)(((BMP280_S32_t)1048576) - adc_P) - (var2 >> 12))) * 3125;
  if (p < 0x80000000) {
    p = (p << 1) / ((BMP280_U32_t)var1);
  } else {
    p = (p / (BMP280_U32_t)var1) * 2;
  }
  var1 = (((BMP280_S32_t)dig_P9) *
          ((BMP280_S32_t)(((p >> 3) * (p >> 3)) >> 13))) >>
         12;
  var2 = (((BMP280_S32_t)(p >> 2)) * ((BMP280_S32_t)dig_P8)) >> 13;
  p = (BMP280_U32_t)((BMP280_S32_t)p + ((var1 + var2 + dig_P7) >> 4));
  return p;
}

int32_t BMP_Air_Density(void) { // returns in kg/m^3
 float T = (float)BMP_Temperature() / 100 + 273.15; //degrees K
  //float T = (float)16 + 273.15; // degrees K
  float P = BMP_Pressure();     // Pascals
  float p = P / (287.05 * T);
  return p * 100;
}

int poweri(int x, unsigned int y) { // https://stackoverflow.com/questions/24566232/computing-fractional-exponents-in-c
                                    // Thanks David!
  int temp;
  if (y == 0)
    return 1;
  temp = poweri(x, y / 2);
  if ((y % 2) == 0)
    return temp * temp;
  else
    return x * temp * temp;
}

int32_t BMP_Altitude(void) {
  float pressure = (float)BMP_Pressure();
  float altitude = 145340 * (1.0 - poweri(pressure / BMP_Pressure_Cal,
                                         0.1903)); // reports in meters :)
  int32_t altitude_uint32_t = altitude;
  return altitude_uint32_t + altitudeOffset;
}
