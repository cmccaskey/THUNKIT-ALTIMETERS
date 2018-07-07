#include "BMP280.c"
#include <math.h>

#define BMP280_S32_t int32_t
#define BMP280_U32_t uint32_t

//#define altitudeOffset

unsigned short dig_T1, dig_P1;
signed short dig_T2, dig_T3, dig_P2, dig_P3, dig_P4, dig_P5, dig_P6, dig_P7, dig_P8, dig_P9;

BMP280_S32_t t_fine;
uint32_t BMP_Air_Density_Cal;

char SPI_RW_8(unsigned char, unsigned char);
int16_t BMP_Burst_Read_16(char);
int32_t BMP_Read_Temp(void);
void BMP_Set_Calib_Vars(void);
void BMP_Normal_Mode(void);
int32_t BMP_Burst_Read_20(char);

int32_t BMP_Temperature(void);
uint32_t BMP_Pressure(void);
int32_t BMP_Air_Density(void);
