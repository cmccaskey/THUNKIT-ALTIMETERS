EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:DDPLY-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ATTINY841-MMH U5
U 1 1 59DA4DAD
P 4350 5900
F 0 "U5" H 3500 6650 50  0000 C CNN
F 1 "ATTINY841-MMH" H 5050 5150 50  0000 C CNN
F 2 "MOD:QFN-20-1EP_4x4mm_Pitch0.5mm" H 4350 5700 50  0001 C CIN
F 3 "" H 4350 5900 50  0000 C CNN
	1    4350 5900
	1    0    0    -1  
$EndComp
$Comp
L FT230XQ-R U2
U 1 1 59DA4E17
P 5000 2800
F 0 "U2" H 5000 2800 60  0000 C CNN
F 1 "FT230XQ-R" H 5000 2650 60  0000 C CNN
F 2 "MOD:QFN-16_4x4mm_Pitch0.65mm" H 5000 2800 60  0001 C CNN
F 3 "" H 5000 2800 60  0001 C CNN
	1    5000 2800
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 59DA500E
P 4200 3800
F 0 "C2" H 4225 3900 50  0000 L CNN
F 1 "C" H 4225 3700 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4238 3650 50  0001 C CNN
F 3 "" H 4200 3800 50  0000 C CNN
	1    4200 3800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 59DA5098
P 4200 4050
F 0 "#PWR01" H 4200 3800 50  0001 C CNN
F 1 "GND" H 4200 3900 50  0000 C CNN
F 2 "" H 4200 4050 50  0000 C CNN
F 3 "" H 4200 4050 50  0000 C CNN
	1    4200 4050
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 59DA50C8
P 3500 3800
F 0 "#PWR02" H 3500 3550 50  0001 C CNN
F 1 "GND" H 3500 3650 50  0000 C CNN
F 2 "" H 3500 3800 50  0000 C CNN
F 3 "" H 3500 3800 50  0000 C CNN
	1    3500 3800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 59DA5105
P 4400 4100
F 0 "#PWR03" H 4400 3850 50  0001 C CNN
F 1 "GND" H 4400 3950 50  0000 C CNN
F 2 "" H 4400 4100 50  0000 C CNN
F 3 "" H 4400 4100 50  0000 C CNN
	1    4400 4100
	1    0    0    -1  
$EndComp
Text GLabel 5700 3100 2    47   Output ~ 0
RX_AVR
Text GLabel 5700 3200 2    47   Input ~ 0
TX_AVR
$Comp
L CONN_02X03 P5
U 1 1 59DA5435
P 7600 1700
F 0 "P5" H 7600 1900 50  0000 C CNN
F 1 "ICSP" H 7600 1500 50  0000 C CNN
F 2 "MOD:LINEAR_ICSP" H 7600 500 50  0001 C CNN
F 3 "" H 7600 500 50  0000 C CNN
	1    7600 1700
	1    0    0    -1  
$EndComp
Text GLabel 7950 1700 2    47   Input ~ 0
MOSI_AVR
Text GLabel 7250 1600 0    47   Output ~ 0
MISO_AVR
Text GLabel 7250 1700 0    47   Output ~ 0
SCK_AVR
Text GLabel 7250 1800 0    47   Output ~ 0
RST_AVR
$Comp
L GND #PWR04
U 1 1 59DA55B6
P 7850 1900
F 0 "#PWR04" H 7850 1650 50  0001 C CNN
F 1 "GND" H 7850 1750 50  0000 C CNN
F 2 "" H 7850 1900 50  0000 C CNN
F 3 "" H 7850 1900 50  0000 C CNN
	1    7850 1900
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 59DA57CB
P 3300 5850
F 0 "C1" H 3325 5950 50  0000 L CNN
F 1 "C" H 3325 5750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 3338 5700 50  0001 C CNN
F 3 "" H 3300 5850 50  0000 C CNN
	1    3300 5850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR05
U 1 1 59DA586A
P 3300 6600
F 0 "#PWR05" H 3300 6350 50  0001 C CNN
F 1 "GND" H 3300 6450 50  0000 C CNN
F 2 "" H 3300 6600 50  0000 C CNN
F 3 "" H 3300 6600 50  0000 C CNN
	1    3300 6600
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 59DA5CB2
P 7300 3650
F 0 "R7" V 7380 3650 50  0000 C CNN
F 1 "10K" V 7300 3650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7230 3650 50  0001 C CNN
F 3 "" H 7300 3650 50  0000 C CNN
	1    7300 3650
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 P4
U 1 1 59DA5D97
P 7400 3050
F 0 "P4" H 7400 2900 50  0000 C CNN
F 1 "E-MATCH_1" H 7700 3050 50  0000 C CNN
F 2 "MOD:100MIL_ST" H 7400 3050 50  0001 C CNN
F 3 "" H 7400 3050 50  0000 C CNN
	1    7400 3050
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR06
U 1 1 59DA5F96
P 7600 3700
F 0 "#PWR06" H 7600 3450 50  0001 C CNN
F 1 "GND" H 7600 3550 50  0000 C CNN
F 2 "" H 7600 3700 50  0000 C CNN
F 3 "" H 7600 3700 50  0000 C CNN
	1    7600 3700
	1    0    0    -1  
$EndComp
$Comp
L CP1 C6
U 1 1 59DA6001
P 8200 3250
F 0 "C6" H 8225 3350 50  0000 L CNN
F 1 "100uF" H 8225 3150 50  0000 L CNN
F 2 "Capacitors_SMD:CP_Elec_5x5.3" H 8200 3250 50  0001 C CNN
F 3 "" H 8200 3250 50  0000 C CNN
	1    8200 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 3650 4200 3650
Wire Wire Line
	4400 3450 4400 3650
Connection ~ 4400 3550
Wire Wire Line
	4200 4050 4200 3950
Wire Wire Line
	3500 3800 3500 3700
Wire Wire Line
	4400 3800 4400 4100
Connection ~ 4400 4000
Connection ~ 4400 3900
Wire Wire Line
	5700 3200 5600 3200
Wire Wire Line
	5600 3100 5700 3100
Wire Wire Line
	7850 1500 7850 1600
Wire Wire Line
	7850 1900 7850 1800
Wire Wire Line
	7950 1700 7850 1700
Wire Wire Line
	7350 1700 7250 1700
Wire Wire Line
	7250 1600 7350 1600
Wire Wire Line
	7350 1800 7250 1800
Wire Wire Line
	3300 5200 3300 5700
Connection ~ 3300 5300
Wire Wire Line
	3300 6000 3300 6600
Connection ~ 3300 6500
Wire Wire Line
	7600 3700 7600 3600
$Comp
L +9V #PWR07
U 1 1 59DA6151
P 7600 2900
F 0 "#PWR07" H 7600 2750 50  0001 C CNN
F 1 "+9V" H 7600 3040 50  0000 C CNN
F 2 "" H 7600 2900 50  0000 C CNN
F 3 "" H 7600 2900 50  0000 C CNN
	1    7600 2900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 59DA62C1
P 7300 3900
F 0 "#PWR08" H 7300 3650 50  0001 C CNN
F 1 "GND" H 7300 3750 50  0000 C CNN
F 2 "" H 7300 3900 50  0000 C CNN
F 3 "" H 7300 3900 50  0000 C CNN
	1    7300 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7300 3900 7300 3800
Wire Wire Line
	7300 3500 7300 3400
Text GLabel 7200 3400 0    47   Input ~ 0
E-MATCH_1
Wire Wire Line
	7300 3400 7200 3400
Wire Wire Line
	7600 3000 8200 3000
Wire Wire Line
	8200 3000 8200 3100
Wire Wire Line
	7600 3100 7600 3200
$Comp
L GND #PWR09
U 1 1 59DA64F4
P 8200 3500
F 0 "#PWR09" H 8200 3250 50  0001 C CNN
F 1 "GND" H 8200 3350 50  0000 C CNN
F 2 "" H 8200 3500 50  0000 C CNN
F 3 "" H 8200 3500 50  0000 C CNN
	1    8200 3500
	1    0    0    -1  
$EndComp
Wire Wire Line
	8200 3500 8200 3400
$Comp
L R R8
U 1 1 59DA6843
P 9250 3650
F 0 "R8" V 9330 3650 50  0000 C CNN
F 1 "10K" V 9250 3650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 9180 3650 50  0001 C CNN
F 3 "" H 9250 3650 50  0000 C CNN
	1    9250 3650
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X02 P6
U 1 1 59DA6849
P 9350 3050
F 0 "P6" H 9350 2900 50  0000 C CNN
F 1 "E-MATCH_2" H 9650 3050 50  0000 C CNN
F 2 "MOD:100MIL_ST" H 9350 3050 50  0001 C CNN
F 3 "" H 9350 3050 50  0000 C CNN
	1    9350 3050
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR010
U 1 1 59DA684F
P 9550 3700
F 0 "#PWR010" H 9550 3450 50  0001 C CNN
F 1 "GND" H 9550 3550 50  0000 C CNN
F 2 "" H 9550 3700 50  0000 C CNN
F 3 "" H 9550 3700 50  0000 C CNN
	1    9550 3700
	1    0    0    -1  
$EndComp
Wire Wire Line
	9550 3700 9550 3600
$Comp
L +9V #PWR011
U 1 1 59DA685C
P 9550 2900
F 0 "#PWR011" H 9550 2750 50  0001 C CNN
F 1 "+9V" H 9550 3040 50  0000 C CNN
F 2 "" H 9550 2900 50  0000 C CNN
F 3 "" H 9550 2900 50  0000 C CNN
	1    9550 2900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 59DA6862
P 9250 3900
F 0 "#PWR012" H 9250 3650 50  0001 C CNN
F 1 "GND" H 9250 3750 50  0000 C CNN
F 2 "" H 9250 3900 50  0000 C CNN
F 3 "" H 9250 3900 50  0000 C CNN
	1    9250 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9250 3900 9250 3800
Wire Wire Line
	9250 3500 9250 3400
Text GLabel 9150 3400 0    47   Input ~ 0
E-MATCH_2
Wire Wire Line
	9250 3400 9150 3400
Wire Wire Line
	9550 3100 9550 3200
$Comp
L CONN_01X02 P2
U 1 1 59DA6EC6
P 5550 1500
F 0 "P2" H 5550 1350 50  0000 C CNN
F 1 "PWR" H 5700 1500 50  0000 C CNN
F 2 "MOD:100MIL_ST" H 5550 1500 50  0001 C CNN
F 3 "" H 5550 1500 50  0000 C CNN
	1    5550 1500
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR013
U 1 1 59DA712D
P 5750 1900
F 0 "#PWR013" H 5750 1650 50  0001 C CNN
F 1 "GND" H 5750 1750 50  0000 C CNN
F 2 "" H 5750 1900 50  0000 C CNN
F 3 "" H 5750 1900 50  0000 C CNN
	1    5750 1900
	1    0    0    -1  
$EndComp
$Comp
L +9V #PWR014
U 1 1 59DA719F
P 5750 1350
F 0 "#PWR014" H 5750 1200 50  0001 C CNN
F 1 "+9V" H 5750 1490 50  0000 C CNN
F 2 "" H 5750 1350 50  0000 C CNN
F 3 "" H 5750 1350 50  0000 C CNN
	1    5750 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	5750 1350 5750 1450
$Comp
L +3.3V #PWR015
U 1 1 59DA72ED
P 7850 1500
F 0 "#PWR015" H 7850 1350 50  0001 C CNN
F 1 "+3.3V" H 7850 1640 50  0000 C CNN
F 2 "" H 7850 1500 50  0000 C CNN
F 3 "" H 7850 1500 50  0000 C CNN
	1    7850 1500
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR016
U 1 1 59DA7494
P 3300 5200
F 0 "#PWR016" H 3300 5050 50  0001 C CNN
F 1 "+3.3V" H 3300 5340 50  0000 C CNN
F 2 "" H 3300 5200 50  0000 C CNN
F 3 "" H 3300 5200 50  0000 C CNN
	1    3300 5200
	1    0    0    -1  
$EndComp
$Comp
L AP1117 U1
U 1 1 59DA76B4
P 4600 1600
F 0 "U1" H 4700 1350 50  0000 C CNN
F 1 "AP2210" H 4600 1850 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4600 1250 50  0001 C CNN
F 3 "" H 4700 1350 50  0000 C CNN
	1    4600 1600
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR017
U 1 1 59DA7725
P 4600 2000
F 0 "#PWR017" H 4600 1750 50  0001 C CNN
F 1 "GND" H 4600 1850 50  0000 C CNN
F 2 "" H 4600 2000 50  0000 C CNN
F 3 "" H 4600 2000 50  0000 C CNN
	1    4600 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4600 1900 4600 2000
$Comp
L C C3
U 1 1 59DA779D
P 4300 1850
F 0 "C3" H 4325 1950 50  0000 L CNN
F 1 "C" H 4325 1750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4338 1700 50  0001 C CNN
F 3 "" H 4300 1850 50  0000 C CNN
	1    4300 1850
	-1   0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 59DA78F4
P 4900 1850
F 0 "C4" H 4925 1950 50  0000 L CNN
F 1 "C" H 4925 1750 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 4938 1700 50  0001 C CNN
F 3 "" H 4900 1850 50  0000 C CNN
	1    4900 1850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR018
U 1 1 59DA799D
P 4300 2100
F 0 "#PWR018" H 4300 1850 50  0001 C CNN
F 1 "GND" H 4300 1950 50  0000 C CNN
F 2 "" H 4300 2100 50  0000 C CNN
F 3 "" H 4300 2100 50  0000 C CNN
	1    4300 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 2100 4300 2000
$Comp
L GND #PWR019
U 1 1 59DA7A1B
P 4900 2100
F 0 "#PWR019" H 4900 1850 50  0001 C CNN
F 1 "GND" H 4900 1950 50  0000 C CNN
F 2 "" H 4900 2100 50  0000 C CNN
F 3 "" H 4900 2100 50  0000 C CNN
	1    4900 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 2100 4900 2000
$Comp
L +9V #PWR020
U 1 1 59DA7A9A
P 3800 1450
F 0 "#PWR020" H 3800 1300 50  0001 C CNN
F 1 "+9V" V 3800 1650 50  0000 C CNN
F 2 "" H 3800 1450 50  0000 C CNN
F 3 "" H 3800 1450 50  0000 C CNN
	1    3800 1450
	0    -1   -1   0   
$EndComp
$Comp
L +5V #PWR021
U 1 1 59DA7AFE
P 3800 1600
F 0 "#PWR021" H 3800 1450 50  0001 C CNN
F 1 "+5V" V 3800 1800 50  0000 C CNN
F 2 "" H 3800 1600 50  0000 C CNN
F 3 "" H 3800 1600 50  0000 C CNN
	1    3800 1600
	0    -1   -1   0   
$EndComp
$Comp
L +5V #PWR022
U 1 1 59DA7C56
P 3900 3000
F 0 "#PWR022" H 3900 2850 50  0001 C CNN
F 1 "+5V" H 3900 3140 50  0000 C CNN
F 2 "" H 3900 3000 50  0000 C CNN
F 3 "" H 3900 3000 50  0000 C CNN
	1    3900 3000
	1    0    0    -1  
$EndComp
$Comp
L +5V #PWR023
U 1 1 59DA7C92
P 4400 3000
F 0 "#PWR023" H 4400 2850 50  0001 C CNN
F 1 "+5V" H 4400 3140 50  0000 C CNN
F 2 "" H 4400 3000 50  0000 C CNN
F 3 "" H 4400 3000 50  0000 C CNN
	1    4400 3000
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 3000 4400 3100
Wire Wire Line
	3900 3000 3900 3100
Wire Wire Line
	4300 1700 4300 1600
Wire Wire Line
	4900 1500 4900 1700
$Comp
L +3.3V #PWR024
U 1 1 59DA7E8A
P 4900 1500
F 0 "#PWR024" H 4900 1350 50  0001 C CNN
F 1 "+3.3V" H 4900 1640 50  0000 C CNN
F 2 "" H 4900 1500 50  0000 C CNN
F 3 "" H 4900 1500 50  0000 C CNN
	1    4900 1500
	1    0    0    -1  
$EndComp
Connection ~ 4900 1600
$Comp
L D_Schottky D1
U 1 1 59DA7FF9
P 4050 1450
F 0 "D1" H 3950 1400 50  0000 C CNN
F 1 "D_Schottky" H 4050 1350 50  0001 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 4050 1450 50  0001 C CNN
F 3 "" H 4050 1450 50  0000 C CNN
	1    4050 1450
	-1   0    0    1   
$EndComp
$Comp
L D_Schottky D2
U 1 1 59DA80D0
P 4050 1600
F 0 "D2" H 3950 1550 50  0000 C CNN
F 1 "D_Schottky" H 4050 1500 50  0001 C CNN
F 2 "Diodes_SMD:D_SOD-123F" H 4050 1600 50  0001 C CNN
F 3 "" H 4050 1600 50  0000 C CNN
	1    4050 1600
	-1   0    0    1   
$EndComp
Wire Wire Line
	3800 1450 3900 1450
Wire Wire Line
	4200 1450 4200 1600
Wire Wire Line
	4200 1600 4300 1600
Wire Wire Line
	3900 1600 3800 1600
$Comp
L GND #PWR025
U 1 1 59DA8647
P 3900 3600
F 0 "#PWR025" H 3900 3350 50  0001 C CNN
F 1 "GND" H 3900 3450 50  0000 C CNN
F 2 "" H 3900 3600 50  0000 C CNN
F 3 "" H 3900 3600 50  0000 C CNN
	1    3900 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 3600 3900 3500
$Comp
L USB_OTG P1
U 1 1 59DA892B
P 3600 3300
F 0 "P1" H 3925 3175 50  0000 C CNN
F 1 "USB_OTG" H 3600 3500 50  0000 C CNN
F 2 "Connectors_USB:USB_Micro-B_Molex_47346-0001" V 3550 3200 50  0001 C CNN
F 3 "" V 3550 3200 50  0000 C CNN
	1    3600 3300
	0    -1   1    0   
$EndComp
NoConn ~ 3900 3400
NoConn ~ 5600 3350
NoConn ~ 5600 3450
NoConn ~ 5600 3900
NoConn ~ 5600 3600
$Comp
L CONN_01X02 P3
U 1 1 59DA9E20
P 5550 1750
F 0 "P3" H 5550 1900 50  0000 C CNN
F 1 "SW" H 5700 1750 50  0000 C CNN
F 2 "MOD:100MIL_ST" H 5550 1750 50  0001 C CNN
F 3 "" H 5550 1750 50  0000 C CNN
	1    5550 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	5750 1800 5750 1900
Wire Wire Line
	5750 1700 5750 1550
$Comp
L BMP280 U4
U 1 1 59DAAF69
P 7300 5400
F 0 "U4" H 7100 5450 47  0000 C CNN
F 1 "BMP280" H 7350 4800 47  0000 C CNN
F 2 "MOD:LGA-8_NO_DOT" H 7050 5700 47  0001 C CNN
F 3 "" H 7050 5700 47  0001 C CNN
	1    7300 5400
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR026
U 1 1 59DAB058
P 7800 5400
F 0 "#PWR026" H 7800 5250 50  0001 C CNN
F 1 "+3.3V" H 7800 5540 50  0000 C CNN
F 2 "" H 7800 5400 50  0000 C CNN
F 3 "" H 7800 5400 50  0000 C CNN
	1    7800 5400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 5400 7800 5600
Connection ~ 7800 5500
$Comp
L GND #PWR027
U 1 1 59DAB17E
P 7800 5950
F 0 "#PWR027" H 7800 5700 50  0001 C CNN
F 1 "GND" H 7800 5800 50  0000 C CNN
F 2 "" H 7800 5950 50  0000 C CNN
F 3 "" H 7800 5950 50  0000 C CNN
	1    7800 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 5750 7800 5950
Connection ~ 7800 5850
$Comp
L C C8
U 1 1 59DAB2A8
P 7900 5650
F 0 "C8" H 7925 5750 50  0000 L CNN
F 1 "C" H 7925 5550 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 7938 5500 50  0001 C CNN
F 3 "" H 7900 5650 50  0000 C CNN
	1    7900 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	7900 5500 7800 5500
Wire Wire Line
	7900 5850 7900 5800
Wire Wire Line
	7800 5850 7900 5850
Text GLabel 6750 5500 0    47   Input ~ 0
CS_BMP
Wire Wire Line
	6750 5500 6850 5500
Text GLabel 6750 5750 0    47   Input ~ 0
MOSI_AVR
Wire Wire Line
	6750 5750 6850 5750
Text GLabel 6750 5650 0    47   Output ~ 0
MISO_AVR
Wire Wire Line
	6850 5650 6750 5650
Text GLabel 6750 5850 0    47   Input ~ 0
SCK_AVR
Wire Wire Line
	6750 5850 6850 5850
Text GLabel 5500 5500 2    47   Input ~ 0
RX_AVR
Text GLabel 5500 5400 2    47   Output ~ 0
TX_AVR
Text GLabel 5500 5800 2    47   Input ~ 0
MISO_AVR
Text GLabel 5500 5700 2    47   BiDi ~ 0
SCK_AVR
Text GLabel 5500 6500 2    47   Input ~ 0
RST_AVR
Text GLabel 5500 5900 2    47   Output ~ 0
MOSI_AVR
Wire Wire Line
	5500 6500 5400 6500
Wire Wire Line
	5500 5900 5400 5900
Wire Wire Line
	5400 5800 5500 5800
Wire Wire Line
	5500 5700 5400 5700
Wire Wire Line
	5500 5400 5400 5400
Wire Wire Line
	5400 5500 5500 5500
Text GLabel 5500 6400 2    47   Output ~ 0
E-MATCH_1
Text GLabel 5500 6300 2    47   Output ~ 0
E-MATCH_2
Wire Wire Line
	5400 6300 5500 6300
Wire Wire Line
	5400 6400 5500 6400
Text GLabel 5500 6000 2    47   Output ~ 0
CS_BMP
Wire Wire Line
	5500 6000 5400 6000
$Comp
L Q_NJFET_GSD Q3
U 1 1 59DB36AB
P 9050 1850
F 0 "Q3" H 9250 1900 50  0000 L CNN
F 1 "Q_NJFET_GSD" H 9250 1800 50  0001 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 9250 1950 50  0001 C CNN
F 3 "" H 9050 1850 50  0000 C CNN
	1    9050 1850
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR030
U 1 1 59DB39E1
P 9150 2150
F 0 "#PWR030" H 9150 1900 50  0001 C CNN
F 1 "GND" H 9150 2000 50  0000 C CNN
F 2 "" H 9150 2150 50  0000 C CNN
F 3 "" H 9150 2150 50  0000 C CNN
	1    9150 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 2050 9150 2150
$Comp
L R R9
U 1 1 59DB3ACE
P 8850 2100
F 0 "R9" V 8930 2100 50  0000 C CNN
F 1 "10K" V 8850 2100 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 8780 2100 50  0001 C CNN
F 3 "" H 8850 2100 50  0000 C CNN
	1    8850 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 1850 8850 1950
$Comp
L GND #PWR031
U 1 1 59DB3CB5
P 8850 2350
F 0 "#PWR031" H 8850 2100 50  0001 C CNN
F 1 "GND" H 8850 2200 50  0000 C CNN
F 2 "" H 8850 2350 50  0000 C CNN
F 3 "" H 8850 2350 50  0000 C CNN
	1    8850 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 2350 8850 2250
Wire Wire Line
	9150 1550 9150 1650
$Comp
L +9V #PWR032
U 1 1 59DB4986
P 9150 1350
F 0 "#PWR032" H 9150 1200 50  0001 C CNN
F 1 "+9V" H 9150 1490 50  0000 C CNN
F 2 "" H 9150 1350 50  0000 C CNN
F 3 "" H 9150 1350 50  0000 C CNN
	1    9150 1350
	1    0    0    -1  
$EndComp
Wire Wire Line
	9150 1350 9150 1450
Text GLabel 8500 1850 0    47   Input ~ 0
PIEZO
Wire Wire Line
	8500 1850 8850 1850
Text GLabel 5500 5300 2    47   Output ~ 0
PIEZO
Wire Wire Line
	5500 5300 5400 5300
$Comp
L Q_NJFET_GSD Q2
U 1 1 59DAB0B6
P 9450 3400
F 0 "Q2" H 9500 3400 50  0000 L CNN
F 1 "Q_NJFET_GSD" H 9650 3350 50  0001 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 9650 3500 50  0001 C CNN
F 3 "" H 9450 3400 50  0000 C CNN
	1    9450 3400
	1    0    0    -1  
$EndComp
$Comp
L Q_NJFET_GSD Q1
U 1 1 59DAB2B0
P 7500 3400
F 0 "Q1" H 7550 3400 50  0000 L CNN
F 1 "Q_NJFET_GSD" H 7700 3350 50  0001 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 7700 3500 50  0001 C CNN
F 3 "" H 7500 3400 50  0000 C CNN
	1    7500 3400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 2900 7600 3000
Wire Wire Line
	9550 2900 9550 3000
$Comp
L CONN_01X02 P7
U 1 1 59DACB7D
P 8950 1500
F 0 "P7" H 8950 1350 50  0000 C CNN
F 1 "PIEZO" H 9150 1500 50  0000 C CNN
F 2 "MOD:100MIL_ST" H 8950 1500 50  0001 C CNN
F 3 "" H 8950 1500 50  0000 C CNN
	1    8950 1500
	-1   0    0    1   
$EndComp
$Comp
L R R11
U 1 1 5B0C7252
P 7750 3650
F 0 "R11" V 7830 3650 50  0000 C CNN
F 1 "10K" V 7750 3650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7680 3650 50  0001 C CNN
F 3 "" H 7750 3650 50  0000 C CNN
	1    7750 3650
	1    0    0    -1  
$EndComp
$Comp
L R R10
U 1 1 5B0C7680
P 7750 3250
F 0 "R10" V 7830 3250 50  0000 C CNN
F 1 "100K" V 7750 3250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7680 3250 50  0001 C CNN
F 3 "" H 7750 3250 50  0000 C CNN
	1    7750 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 3400 7750 3500
$Comp
L GND #PWR033
U 1 1 5B0C7987
P 7750 3900
F 0 "#PWR033" H 7750 3650 50  0001 C CNN
F 1 "GND" H 7750 3750 50  0000 C CNN
F 2 "" H 7750 3900 50  0000 C CNN
F 3 "" H 7750 3900 50  0000 C CNN
	1    7750 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7750 3800 7750 3900
Text GLabel 5500 6200 2    47   Input ~ 0
CONT_1
Text GLabel 5500 5600 2    47   Input ~ 0
CONT_2
Wire Wire Line
	5500 6200 5400 6200
Wire Wire Line
	5500 5600 5400 5600
Text GLabel 7850 3450 2    47   Output ~ 0
CONT_1
Text GLabel 9800 3450 2    47   Output ~ 0
CONT_2
$Comp
L R R13
U 1 1 5B0C9235
P 9700 3650
F 0 "R13" V 9780 3650 50  0000 C CNN
F 1 "10K" V 9700 3650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 9630 3650 50  0001 C CNN
F 3 "" H 9700 3650 50  0000 C CNN
	1    9700 3650
	1    0    0    -1  
$EndComp
$Comp
L R R12
U 1 1 5B0C923B
P 9700 3250
F 0 "R12" V 9780 3250 50  0000 C CNN
F 1 "100K" V 9700 3250 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 9630 3250 50  0001 C CNN
F 3 "" H 9700 3250 50  0000 C CNN
	1    9700 3250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 3400 9700 3500
$Comp
L GND #PWR034
U 1 1 5B0C9242
P 9700 3900
F 0 "#PWR034" H 9700 3650 50  0001 C CNN
F 1 "GND" H 9700 3750 50  0000 C CNN
F 2 "" H 9700 3900 50  0000 C CNN
F 3 "" H 9700 3900 50  0000 C CNN
	1    9700 3900
	1    0    0    -1  
$EndComp
Wire Wire Line
	9700 3800 9700 3900
Wire Wire Line
	7750 3100 7600 3100
Wire Wire Line
	7850 3450 7750 3450
Connection ~ 7750 3450
Wire Wire Line
	9700 3100 9550 3100
Wire Wire Line
	9800 3450 9700 3450
Connection ~ 9700 3450
$Comp
L R_Pack02 R1
U 1 1 5B0CA474
P 4150 3300
F 0 "R1" V 3950 3300 50  0000 C CNN
F 1 "22" V 4250 3300 50  0000 C CNN
F 2 "Resistors_SMD:R_Array_Concave_2x0603" V 4325 3300 50  0001 C CNN
F 3 "" H 4150 3300 50  0000 C CNN
	1    4150 3300
	0    1    1    0   
$EndComp
Wire Wire Line
	3950 3300 3900 3300
Wire Wire Line
	3900 3200 3950 3200
Wire Wire Line
	4400 3200 4350 3200
Wire Wire Line
	4350 3300 4400 3300
NoConn ~ 5600 3800
NoConn ~ 5600 3700
$Comp
L LED D3
U 1 1 5B0CB0B0
P 8600 2400
F 0 "D3" H 8600 2500 50  0000 C CNN
F 1 "RED" H 8600 2300 50  0000 C CNN
F 2 "Diodes_SMD:D_0603" H 8600 2400 50  0001 C CNN
F 3 "" H 8600 2400 50  0000 C CNN
	1    8600 2400
	0    -1   -1   0   
$EndComp
$Comp
L R R2
U 1 1 5B0CB27F
P 8600 2100
F 0 "R2" V 8680 2100 50  0000 C CNN
F 1 "330" V 8600 2100 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 8530 2100 50  0001 C CNN
F 3 "" H 8600 2100 50  0000 C CNN
	1    8600 2100
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR035
U 1 1 5B0CB53A
P 8600 2550
F 0 "#PWR035" H 8600 2300 50  0001 C CNN
F 1 "GND" H 8600 2400 50  0000 C CNN
F 2 "" H 8600 2550 50  0000 C CNN
F 3 "" H 8600 2550 50  0000 C CNN
	1    8600 2550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 1950 8600 1850
Connection ~ 8600 1850
Text Notes 7900 4150 0    60   ~ 0
Add Tantalum capacitor\nMaybe remov elec.\n
$EndSCHEMATC
