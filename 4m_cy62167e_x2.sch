EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 8268 11693 portrait
encoding utf-8
Sheet 1 1
Title "Mega RAM-Cart 4MB SRAM for Sega Megadrive & 32X"
Date ""
Rev "1"
Comp ""
Comment1 "This documentation describes Open Hardware and is licensed under the CERN OHL v.1.2"
Comment2 "Copyright: MiGeRA (aka Th.K)"
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MegaDriveCart:smd_cart_connector_edge CON1
U 1 1 5B96D488
P 2850 4750
F 0 "CON1" H 2850 5587 60  0000 C CNN
F 1 "smd_cart_connector_edge" H 2850 5481 60  0000 C CNN
F 2 "MegaDriveCart:md_cart_edge_conn" H 2850 4750 60  0001 C CNN
F 3 "" H 2850 4750 60  0000 C CNN
	1    2850 4750
	1    0    0    -1  
$EndComp
Text Label 2000 4200 0    50   ~ 0
A0
Text Label 2000 4300 0    50   ~ 0
A1
Text Label 2000 4400 0    50   ~ 0
A2
Text Label 2000 4500 0    50   ~ 0
A3
Entry Wire Line
	1850 5900 1950 6000
Entry Wire Line
	1850 5800 1950 5900
Entry Wire Line
	1850 5700 1950 5800
Entry Wire Line
	1850 5600 1950 5700
Entry Wire Line
	1850 5500 1950 5600
Entry Wire Line
	1850 5400 1950 5500
Entry Wire Line
	1850 5300 1950 5400
Entry Wire Line
	1850 5200 1950 5300
Entry Wire Line
	1850 5100 1950 5200
Entry Wire Line
	1850 5000 1950 5100
Entry Wire Line
	1850 4900 1950 5000
Entry Wire Line
	1850 4800 1950 4900
Entry Wire Line
	1850 4700 1950 4800
Entry Wire Line
	1850 4600 1950 4700
Entry Wire Line
	1850 4500 1950 4600
Entry Wire Line
	1850 4400 1950 4500
Entry Wire Line
	1850 4300 1950 4400
Entry Wire Line
	1850 4200 1950 4300
Entry Wire Line
	1850 4100 1950 4200
Text Label 2000 4600 0    50   ~ 0
A4
Text Label 2000 4700 0    50   ~ 0
A5
Text Label 2000 4800 0    50   ~ 0
A6
Text Label 2000 4900 0    50   ~ 0
A7
Text Label 2000 5000 0    50   ~ 0
A8
Text Label 2000 5100 0    50   ~ 0
A9
Text Label 2000 5200 0    50   ~ 0
A10
Text Label 2000 5300 0    50   ~ 0
A11
Text Label 2000 5400 0    50   ~ 0
A12
Text Label 2000 5500 0    50   ~ 0
A13
Text Label 2000 5600 0    50   ~ 0
A14
Text Label 2000 5700 0    50   ~ 0
A15
Text Label 2000 5800 0    50   ~ 0
A16
Text Label 2000 5900 0    50   ~ 0
A17
Text Label 2000 6000 0    50   ~ 0
A18
Text Label 4600 4200 0    50   ~ 0
A0
Text Label 4600 4300 0    50   ~ 0
A1
Text Label 4600 4400 0    50   ~ 0
A2
Text Label 4600 4500 0    50   ~ 0
A3
Entry Wire Line
	4450 5900 4550 6000
Entry Wire Line
	4450 5800 4550 5900
Entry Wire Line
	4450 5700 4550 5800
Entry Wire Line
	4450 5600 4550 5700
Entry Wire Line
	4450 5500 4550 5600
Entry Wire Line
	4450 5400 4550 5500
Entry Wire Line
	4450 5300 4550 5400
Entry Wire Line
	4450 5200 4550 5300
Entry Wire Line
	4450 5100 4550 5200
Entry Wire Line
	4450 5000 4550 5100
Entry Wire Line
	4450 4900 4550 5000
Entry Wire Line
	4450 4800 4550 4900
Entry Wire Line
	4450 4700 4550 4800
Entry Wire Line
	4450 4600 4550 4700
Entry Wire Line
	4450 4500 4550 4600
Entry Wire Line
	4450 4400 4550 4500
Entry Wire Line
	4450 4300 4550 4400
Entry Wire Line
	4450 4200 4550 4300
Entry Wire Line
	4450 4100 4550 4200
Text Label 4600 4600 0    50   ~ 0
A4
Text Label 4600 4700 0    50   ~ 0
A5
Text Label 4600 4800 0    50   ~ 0
A6
Text Label 4600 4900 0    50   ~ 0
A7
Text Label 4600 5000 0    50   ~ 0
A8
Text Label 4600 5100 0    50   ~ 0
A9
Text Label 4600 5200 0    50   ~ 0
A10
Text Label 4600 5300 0    50   ~ 0
A11
Text Label 4600 5400 0    50   ~ 0
A12
Text Label 4600 5500 0    50   ~ 0
A13
Text Label 4600 5600 0    50   ~ 0
A14
Text Label 4600 5700 0    50   ~ 0
A15
Text Label 4600 5800 0    50   ~ 0
A16
Text Label 4600 5900 0    50   ~ 0
A17
Text Label 4600 6000 0    50   ~ 0
A18
Text GLabel 1850 3950 1    50   Output ~ 0
ADDR
Text GLabel 4450 3950 1    50   Input ~ 0
ADDR
Text GLabel 3500 6200 2    30   Output ~ 0
~OE
Text GLabel 6350 5900 2    30   Input ~ 0
~OE
Text GLabel 3500 6300 2    30   Output ~ 0
~CE
Entry Wire Line
	3750 4200 3850 4100
Entry Wire Line
	3750 4300 3850 4200
Entry Wire Line
	3750 4400 3850 4300
Entry Wire Line
	3750 4500 3850 4400
Entry Wire Line
	3750 4600 3850 4500
Entry Wire Line
	3750 4700 3850 4600
Entry Wire Line
	3750 4800 3850 4700
Entry Wire Line
	3750 4900 3850 4800
Entry Wire Line
	3750 5000 3850 4900
Entry Wire Line
	3750 5100 3850 5000
Entry Wire Line
	3750 5200 3850 5100
Entry Wire Line
	3750 5300 3850 5200
Entry Wire Line
	3750 5400 3850 5300
Entry Wire Line
	3750 5500 3850 5400
Entry Wire Line
	3750 5600 3850 5500
Entry Wire Line
	3750 5700 3850 5600
Text GLabel 3850 3950 1    50   BiDi ~ 0
DATA
Text Label 3550 4200 0    50   ~ 0
D0
Text Label 3550 4300 0    50   ~ 0
D1
Text Label 3550 4400 0    50   ~ 0
D2
Text Label 3550 4500 0    50   ~ 0
D3
Text Label 3550 4600 0    50   ~ 0
D4
Text Label 3550 4700 0    50   ~ 0
D5
Text Label 3550 4800 0    50   ~ 0
D6
Text Label 3550 4900 0    50   ~ 0
D7
Text Label 3550 5000 0    50   ~ 0
D8
Text Label 3550 5100 0    50   ~ 0
D9
Text Label 3550 5200 0    50   ~ 0
D10
Text Label 3550 5300 0    50   ~ 0
D11
Text Label 3550 5400 0    50   ~ 0
D12
Text Label 3550 5500 0    50   ~ 0
D13
Text Label 3550 5600 0    50   ~ 0
D14
Text Label 3550 5700 0    50   ~ 0
D15
$Comp
L power:GND #PWR0104
U 1 1 5B9CF710
P 2000 7650
F 0 "#PWR0104" H 2000 7400 50  0001 C CNN
F 1 "GND" H 2005 7477 50  0000 C CNN
F 2 "" H 2000 7650 50  0001 C CNN
F 3 "" H 2000 7650 50  0001 C CNN
	1    2000 7650
	1    0    0    -1  
$EndComp
NoConn ~ 2200 6800
NoConn ~ 2200 6900
NoConn ~ 2200 6700
NoConn ~ 2200 6600
NoConn ~ 2200 6400
NoConn ~ 2200 6300
NoConn ~ 3500 7400
NoConn ~ 3500 7300
NoConn ~ 3500 7200
NoConn ~ 3500 7100
NoConn ~ 3500 7000
NoConn ~ 3500 6900
NoConn ~ 3500 6800
NoConn ~ 3500 6700
NoConn ~ 3500 6600
NoConn ~ 3500 6500
Entry Wire Line
	6450 4200 6550 4100
Entry Wire Line
	6450 4300 6550 4200
Entry Wire Line
	6450 4400 6550 4300
Entry Wire Line
	6450 4500 6550 4400
Entry Wire Line
	6450 4600 6550 4500
Entry Wire Line
	6450 4700 6550 4600
Entry Wire Line
	6450 4800 6550 4700
Entry Wire Line
	6450 4900 6550 4800
Text GLabel 6550 3950 1    50   BiDi ~ 0
DATA
Text Label 6250 4200 0    50   ~ 0
D8
Text Label 6250 4300 0    50   ~ 0
D9
Text Label 6250 4400 0    50   ~ 0
D10
Text Label 6250 4500 0    50   ~ 0
D11
Text Label 6250 4600 0    50   ~ 0
D12
Text Label 6250 4700 0    50   ~ 0
D13
Text Label 6250 4800 0    50   ~ 0
D14
Text Label 6250 4900 0    50   ~ 0
D15
Text Label 6250 5700 0    50   ~ 0
A20
Text GLabel 6350 5800 2    30   Input ~ 0
~CE
Text GLabel 3500 6000 2    30   Output ~ 0
~HI
Text GLabel 6350 6000 2    30   Input ~ 0
~HI
NoConn ~ 3500 6400
Wire Wire Line
	6200 4200 6450 4200
Wire Wire Line
	6200 4300 6450 4300
Wire Wire Line
	6200 4400 6450 4400
Wire Wire Line
	6200 4500 6450 4500
Wire Wire Line
	6200 4600 6450 4600
Wire Wire Line
	6200 4700 6450 4700
Wire Wire Line
	6200 4800 6450 4800
Wire Wire Line
	6200 4900 6450 4900
Wire Wire Line
	6450 5700 6200 5700
Wire Wire Line
	4800 6300 4800 6400
Connection ~ 2000 7300
Wire Wire Line
	2000 7200 2000 7300
Wire Wire Line
	2200 7200 2000 7200
Wire Wire Line
	2000 7300 2000 7400
Wire Wire Line
	2200 7300 2000 7300
Wire Wire Line
	2200 7400 2000 7400
Wire Wire Line
	2000 7100 2200 7100
Wire Wire Line
	2000 7000 2000 7100
Wire Wire Line
	2000 7000 2200 7000
Wire Wire Line
	3500 4200 3750 4200
Wire Wire Line
	3500 4300 3750 4300
Wire Wire Line
	3500 4400 3750 4400
Wire Wire Line
	3500 4500 3750 4500
Wire Wire Line
	3500 4600 3750 4600
Wire Wire Line
	3500 4700 3750 4700
Wire Wire Line
	3500 4800 3750 4800
Wire Wire Line
	3500 4900 3750 4900
Wire Wire Line
	3500 5000 3750 5000
Wire Wire Line
	3500 5100 3750 5100
Wire Wire Line
	3500 5200 3750 5200
Wire Wire Line
	3500 5300 3750 5300
Wire Wire Line
	3500 5400 3750 5400
Wire Wire Line
	3500 5500 3750 5500
Wire Wire Line
	3500 5600 3750 5600
Wire Wire Line
	3750 5700 3500 5700
Wire Wire Line
	6350 5800 6200 5800
Wire Wire Line
	4800 4200 4550 4200
Wire Wire Line
	4550 6000 4800 6000
Wire Wire Line
	4550 5900 4800 5900
Wire Wire Line
	4550 5800 4800 5800
Wire Wire Line
	4550 5700 4800 5700
Wire Wire Line
	4550 5600 4800 5600
Wire Wire Line
	4550 5500 4800 5500
Wire Wire Line
	4550 5400 4800 5400
Wire Wire Line
	4550 5300 4800 5300
Wire Wire Line
	4550 5200 4800 5200
Wire Wire Line
	4550 5100 4800 5100
Wire Wire Line
	4550 5000 4800 5000
Wire Wire Line
	4550 4900 4800 4900
Wire Wire Line
	4550 4800 4800 4800
Wire Wire Line
	4550 4700 4800 4700
Wire Wire Line
	4550 4600 4800 4600
Wire Wire Line
	4550 4500 4800 4500
Wire Wire Line
	4550 4400 4800 4400
Wire Wire Line
	4550 4300 4800 4300
Wire Wire Line
	2200 4200 1950 4200
Wire Wire Line
	1950 6000 2200 6000
Wire Wire Line
	1950 5900 2200 5900
Wire Wire Line
	1950 5800 2200 5800
Wire Wire Line
	1950 5700 2200 5700
Wire Wire Line
	1950 5600 2200 5600
Wire Wire Line
	1950 5500 2200 5500
Wire Wire Line
	1950 5400 2200 5400
Wire Wire Line
	1950 5300 2200 5300
Wire Wire Line
	1950 5200 2200 5200
Wire Wire Line
	1950 5100 2200 5100
Wire Wire Line
	1950 5000 2200 5000
Wire Wire Line
	1950 4900 2200 4900
Wire Wire Line
	1950 4800 2200 4800
Wire Wire Line
	1950 4700 2200 4700
Wire Wire Line
	1950 4600 2200 4600
Wire Wire Line
	1950 4500 2200 4500
Wire Wire Line
	1950 4400 2200 4400
Wire Wire Line
	1950 4300 2200 4300
Wire Wire Line
	6200 5900 6350 5900
Entry Wire Line
	1850 6000 1950 6100
Entry Wire Line
	1850 6100 1950 6200
Wire Wire Line
	1950 6100 2200 6100
Wire Wire Line
	1950 6200 2200 6200
Text Label 2000 6100 0    50   ~ 0
A19
Text Label 2000 6200 0    50   ~ 0
A20
Entry Wire Line
	4450 6000 4550 6100
Wire Wire Line
	4550 6100 4800 6100
Text Label 4600 6100 0    50   ~ 0
A19
$Comp
L power:GND #PWR0102
U 1 1 5B986988
P 4250 6400
F 0 "#PWR0102" H 4250 6150 50  0001 C CNN
F 1 "GND" H 4255 6227 50  0000 C CNN
F 2 "" H 4250 6400 50  0001 C CNN
F 3 "" H 4250 6400 50  0001 C CNN
	1    4250 6400
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 6400 4250 6400
Connection ~ 4800 6400
$Comp
L MegaDriveCart:cy62167e-TSOP48 U1
U 1 1 65992D57
P 5500 5200
F 0 "U1" H 5500 6465 50  0000 C CNN
F 1 "cy62167e-TSOP48" H 5500 6374 50  0000 C CNN
F 2 "MegaDriveCart:TSOP-I-48" H 7350 7750 50  0001 C CNN
F 3 "" H 7350 7750 50  0001 C CNN
	1    5500 5200
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0101
U 1 1 61A870F5
P 7000 6400
F 0 "#PWR0101" H 7000 6150 50  0001 C CNN
F 1 "GND" H 7005 6227 50  0000 C CNN
F 2 "" H 7000 6400 50  0001 C CNN
F 3 "" H 7000 6400 50  0001 C CNN
	1    7000 6400
	1    0    0    -1  
$EndComp
Text GLabel 3500 5900 2    30   Output ~ 0
~LO
Wire Wire Line
	7000 6100 7000 6400
Wire Wire Line
	6200 6100 6300 6100
Wire Wire Line
	6200 6000 6350 6000
Wire Wire Line
	6200 6200 6300 6200
Wire Wire Line
	6300 6200 6300 6100
Connection ~ 6300 6100
Wire Wire Line
	6300 6100 7000 6100
Wire Wire Line
	6200 6300 6300 6300
Wire Wire Line
	6300 6300 6300 6200
Connection ~ 6300 6200
Connection ~ 4250 6400
Wire Wire Line
	4250 6200 4800 6200
$Comp
L Device:C_Small C1
U 1 1 5BA2E721
P 4250 6300
F 0 "C1" H 4300 6350 50  0000 L CNN
F 1 "104" H 4300 6250 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4250 6300 50  0001 C CNN
F 3 "~" H 4250 6300 50  0001 C CNN
	1    4250 6300
	1    0    0    -1  
$EndComp
Wire Bus Line
	6550 5600 6550 5500
Text GLabel 6550 5500 1    50   Input ~ 0
ADDR
Entry Wire Line
	6450 5700 6550 5600
Text Label 4600 7250 0    50   ~ 0
A0
Text Label 4600 7350 0    50   ~ 0
A1
Text Label 4600 7450 0    50   ~ 0
A2
Text Label 4600 7550 0    50   ~ 0
A3
Entry Wire Line
	4450 8950 4550 9050
Entry Wire Line
	4450 8850 4550 8950
Entry Wire Line
	4450 8750 4550 8850
Entry Wire Line
	4450 8650 4550 8750
Entry Wire Line
	4450 8550 4550 8650
Entry Wire Line
	4450 8450 4550 8550
Entry Wire Line
	4450 8350 4550 8450
Entry Wire Line
	4450 8250 4550 8350
Entry Wire Line
	4450 8150 4550 8250
Entry Wire Line
	4450 8050 4550 8150
Entry Wire Line
	4450 7950 4550 8050
Entry Wire Line
	4450 7850 4550 7950
Entry Wire Line
	4450 7750 4550 7850
Entry Wire Line
	4450 7650 4550 7750
Entry Wire Line
	4450 7550 4550 7650
Entry Wire Line
	4450 7450 4550 7550
Entry Wire Line
	4450 7350 4550 7450
Entry Wire Line
	4450 7250 4550 7350
Entry Wire Line
	4450 7150 4550 7250
Text Label 4600 7650 0    50   ~ 0
A4
Text Label 4600 7750 0    50   ~ 0
A5
Text Label 4600 7850 0    50   ~ 0
A6
Text Label 4600 7950 0    50   ~ 0
A7
Text Label 4600 8050 0    50   ~ 0
A8
Text Label 4600 8150 0    50   ~ 0
A9
Text Label 4600 8250 0    50   ~ 0
A10
Text Label 4600 8350 0    50   ~ 0
A11
Text Label 4600 8450 0    50   ~ 0
A12
Text Label 4600 8550 0    50   ~ 0
A13
Text Label 4600 8650 0    50   ~ 0
A14
Text Label 4600 8750 0    50   ~ 0
A15
Text Label 4600 8850 0    50   ~ 0
A16
Text Label 4600 8950 0    50   ~ 0
A17
Text Label 4600 9050 0    50   ~ 0
A18
Text GLabel 4450 7000 1    50   Input ~ 0
ADDR
Text GLabel 6350 8950 2    30   Input ~ 0
~OE
Entry Wire Line
	6450 7250 6550 7150
Entry Wire Line
	6450 7350 6550 7250
Entry Wire Line
	6450 7450 6550 7350
Entry Wire Line
	6450 7550 6550 7450
Entry Wire Line
	6450 7650 6550 7550
Entry Wire Line
	6450 7750 6550 7650
Entry Wire Line
	6450 7850 6550 7750
Entry Wire Line
	6450 7950 6550 7850
Text GLabel 6550 7000 1    50   BiDi ~ 0
DATA
Text Label 6250 7250 0    50   ~ 0
D0
Text Label 6250 7350 0    50   ~ 0
D1
Text Label 6250 7450 0    50   ~ 0
D2
Text Label 6250 7550 0    50   ~ 0
D3
Text Label 6250 7650 0    50   ~ 0
D4
Text Label 6250 7750 0    50   ~ 0
D5
Text Label 6250 7850 0    50   ~ 0
D6
Text Label 6250 7950 0    50   ~ 0
D7
Text Label 6250 8750 0    50   ~ 0
A20
Text GLabel 6350 8850 2    30   Input ~ 0
~CE
Text GLabel 6350 9050 2    30   Input ~ 0
~LO
Wire Wire Line
	6200 7250 6450 7250
Wire Wire Line
	6200 7350 6450 7350
Wire Wire Line
	6200 7450 6450 7450
Wire Wire Line
	6200 7550 6450 7550
Wire Wire Line
	6200 7650 6450 7650
Wire Wire Line
	6200 7750 6450 7750
Wire Wire Line
	6200 7850 6450 7850
Wire Wire Line
	6200 7950 6450 7950
Wire Wire Line
	6450 8750 6200 8750
Wire Wire Line
	4800 9350 4800 9450
Wire Wire Line
	6350 8850 6200 8850
Wire Wire Line
	4800 7250 4550 7250
Wire Wire Line
	4550 9050 4800 9050
Wire Wire Line
	4550 8950 4800 8950
Wire Wire Line
	4550 8850 4800 8850
Wire Wire Line
	4550 8750 4800 8750
Wire Wire Line
	4550 8650 4800 8650
Wire Wire Line
	4550 8550 4800 8550
Wire Wire Line
	4550 8450 4800 8450
Wire Wire Line
	4550 8350 4800 8350
Wire Wire Line
	4550 8250 4800 8250
Wire Wire Line
	4550 8150 4800 8150
Wire Wire Line
	4550 8050 4800 8050
Wire Wire Line
	4550 7950 4800 7950
Wire Wire Line
	4550 7850 4800 7850
Wire Wire Line
	4550 7750 4800 7750
Wire Wire Line
	4550 7650 4800 7650
Wire Wire Line
	4550 7550 4800 7550
Wire Wire Line
	4550 7450 4800 7450
Wire Wire Line
	4550 7350 4800 7350
Wire Wire Line
	6200 8950 6350 8950
Entry Wire Line
	4450 9050 4550 9150
Wire Wire Line
	4550 9150 4800 9150
Text Label 4600 9150 0    50   ~ 0
A19
$Comp
L power:GND #PWR0109
U 1 1 65AC719F
P 4250 9450
F 0 "#PWR0109" H 4250 9200 50  0001 C CNN
F 1 "GND" H 4255 9277 50  0000 C CNN
F 2 "" H 4250 9450 50  0001 C CNN
F 3 "" H 4250 9450 50  0001 C CNN
	1    4250 9450
	1    0    0    -1  
$EndComp
Wire Wire Line
	4800 9450 4250 9450
Connection ~ 4800 9450
$Comp
L MegaDriveCart:cy62167e-TSOP48 U2
U 1 1 65AC71AB
P 5500 8250
F 0 "U2" H 5500 9515 50  0000 C CNN
F 1 "cy62167e-TSOP48" H 5500 9424 50  0000 C CNN
F 2 "MegaDriveCart:TSOP-I-48" H 7350 10800 50  0001 C CNN
F 3 "" H 7350 10800 50  0001 C CNN
	1    5500 8250
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0110
U 1 1 65AC71B5
P 7000 9450
F 0 "#PWR0110" H 7000 9200 50  0001 C CNN
F 1 "GND" H 7005 9277 50  0000 C CNN
F 2 "" H 7000 9450 50  0001 C CNN
F 3 "" H 7000 9450 50  0001 C CNN
	1    7000 9450
	1    0    0    -1  
$EndComp
Wire Wire Line
	7000 9150 7000 9450
Wire Wire Line
	6200 9150 6300 9150
Wire Wire Line
	6200 9050 6350 9050
Wire Wire Line
	6200 9250 6300 9250
Wire Wire Line
	6300 9250 6300 9150
Connection ~ 6300 9150
Wire Wire Line
	6300 9150 7000 9150
Wire Wire Line
	6200 9350 6300 9350
Wire Wire Line
	6300 9350 6300 9250
Connection ~ 6300 9250
Wire Wire Line
	4250 9250 4800 9250
Wire Bus Line
	6550 8650 6550 8550
Text GLabel 6550 8550 1    50   Input ~ 0
ADDR
Entry Wire Line
	6450 8750 6550 8650
$Comp
L Switch:SW_DIP_x02 SW1
U 1 1 65B57215
P 2850 8050
F 0 "SW1" H 2850 8417 50  0000 C CNN
F 1 "SW_DIP_x02" H 2850 8326 50  0000 C CNN
F 2 "Button_Switch_THT:SW_DIP_SPSTx02_Slide_9.78x7.26mm_W7.62mm_P2.54mm" H 2850 8050 50  0001 C CNN
F 3 "~" H 2850 8050 50  0001 C CNN
	1    2850 8050
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR0105
U 1 1 61ABFCBA
P 2000 10200
F 0 "#PWR0105" H 2000 9950 50  0001 C CNN
F 1 "GND" H 2005 10027 50  0000 C CNN
F 2 "" H 2000 10200 50  0001 C CNN
F 3 "" H 2000 10200 50  0001 C CNN
	1    2000 10200
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell BT1
U 1 1 65B933BF
P 2000 8250
F 0 "BT1" H 2118 8346 50  0000 L CNN
F 1 "Battery_Cell" H 2118 8255 50  0000 L CNN
F 2 "Battery:BatteryHolder_Keystone_1058_1x2032" V 2000 8310 50  0001 C CNN
F 3 "~" V 2000 8310 50  0001 C CNN
	1    2000 8250
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 6100 3500 6100
NoConn ~ 6200 5000
NoConn ~ 6200 5100
NoConn ~ 6200 5200
NoConn ~ 6200 5300
NoConn ~ 6200 5400
NoConn ~ 6200 5500
NoConn ~ 6200 5600
NoConn ~ 6200 8050
NoConn ~ 6200 8150
NoConn ~ 6200 8250
NoConn ~ 6200 8350
NoConn ~ 6200 8450
NoConn ~ 6200 8550
NoConn ~ 6200 8650
$Comp
L power:+5V #PWR01
U 1 1 65A16315
P 3850 5850
F 0 "#PWR01" H 3850 5700 50  0001 C CNN
F 1 "+5V" H 3865 6023 50  0000 C CNN
F 2 "" H 3850 5850 50  0001 C CNN
F 3 "" H 3850 5850 50  0001 C CNN
	1    3850 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small R1
U 1 1 65C5C570
P 3850 5950
F 0 "R1" H 3909 5996 50  0000 L CNN
F 1 "472" H 3909 5905 50  0000 L CNN
F 2 "Resistor_SMD:R_0805_2012Metric" H 3850 5950 50  0001 C CNN
F 3 "~" H 3850 5950 50  0001 C CNN
	1    3850 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3850 6100 3850 6050
Connection ~ 3850 6100
$Comp
L MegaDriveCart:BA6162 U3
U 1 1 65CA87CF
P 1350 9150
F 0 "U3" H 1594 9196 50  0001 L CNN
F 1 "BA6162" H 1594 9105 50  0001 L CNN
F 2 "Package_SO:SSOP-8_3.9x5.05mm_P1.27mm" H 1350 9150 50  0001 C CIN
F 3 "" H 1350 9150 50  0001 C CNN
	1    1350 9150
	1    0    0    -1  
$EndComp
$Comp
L MegaDriveCart:BA6162 U4
U 1 1 65CA9BA2
P 2900 9150
F 0 "U4" H 3144 9196 50  0001 L CNN
F 1 "BA6162" H 3144 9105 50  0001 L CNN
F 2 "Package_SO:SSOP-8_3.9x5.05mm_P1.27mm" H 2900 9150 50  0001 C CIN
F 3 "" H 2900 9150 50  0001 C CNN
	1    2900 9150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 10050 1350 9450
Wire Wire Line
	2900 10050 2900 9450
Wire Wire Line
	1350 8850 1350 8700
Connection ~ 2000 7000
Wire Wire Line
	2000 8350 2000 10050
Wire Wire Line
	2900 8700 2900 8850
Connection ~ 1350 8700
Wire Wire Line
	1350 8700 1350 7000
Wire Wire Line
	6200 9450 6350 9450
Text GLabel 6350 9450 2    30   Input ~ 0
PEL
Text GLabel 2300 9150 0    30   Input ~ 0
PEL
Text GLabel 6350 6400 2    30   Input ~ 0
PEH
Wire Wire Line
	6200 6400 6350 6400
Text GLabel 3250 9150 2    30   Input ~ 0
PWL
Text GLabel 4150 9250 0    30   Input ~ 0
PWL
Text GLabel 1700 9150 2    30   Input ~ 0
PWH
Wire Wire Line
	1550 9150 1700 9150
Text GLabel 4150 6200 0    30   Input ~ 0
PWH
Wire Wire Line
	4150 6200 4250 6200
Connection ~ 4250 6200
Connection ~ 4250 9450
$Comp
L Device:C_Small C2
U 1 1 65AC71D6
P 4250 9350
F 0 "C2" H 4300 9400 50  0000 L CNN
F 1 "104" H 4300 9300 50  0000 L CNN
F 2 "Capacitor_SMD:C_0805_2012Metric" H 4250 9350 50  0001 C CNN
F 3 "~" H 4250 9350 50  0001 C CNN
	1    4250 9350
	1    0    0    -1  
$EndComp
Wire Wire Line
	4150 9250 4250 9250
Connection ~ 4250 9250
Wire Wire Line
	2300 9150 2500 9150
NoConn ~ 2500 9050
NoConn ~ 2500 9250
NoConn ~ 950  9050
NoConn ~ 950  9250
Wire Wire Line
	2000 10200 2000 10050
Wire Wire Line
	1350 8700 2900 8700
Wire Wire Line
	3850 6100 3850 7950
Wire Wire Line
	2000 7400 2000 7500
Connection ~ 2000 7400
Wire Wire Line
	3150 7950 3850 7950
Wire Wire Line
	2550 7950 2150 7950
Wire Wire Line
	2150 7950 2150 7500
Wire Wire Line
	2150 7500 2000 7500
Connection ~ 2000 7500
Wire Wire Line
	2000 7500 2000 7650
Connection ~ 2000 10050
Wire Wire Line
	2000 10050 2900 10050
Wire Wire Line
	1350 10050 2000 10050
Wire Wire Line
	2000 8050 2550 8050
Wire Wire Line
	3100 9150 3250 9150
Text GLabel 750  9150 0    30   Input ~ 0
PEH
Wire Wire Line
	750  9150 950  9150
Wire Wire Line
	3150 8050 3550 8050
Connection ~ 1350 7000
Wire Wire Line
	1350 7000 2000 7000
$Comp
L power:+5V #PWR0103
U 1 1 5B9C93DD
P 1350 7000
F 0 "#PWR0103" H 1350 6850 50  0001 C CNN
F 1 "+5V" H 1365 7173 50  0000 C CNN
F 2 "" H 1350 7000 50  0001 C CNN
F 3 "" H 1350 7000 50  0001 C CNN
	1    1350 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 9450 1250 9700
Wire Wire Line
	1250 9700 2800 9700
Wire Wire Line
	3550 9700 3550 8050
Wire Wire Line
	2800 9450 2800 9700
Connection ~ 2800 9700
Wire Wire Line
	2800 9700 3550 9700
Wire Bus Line
	6550 7000 6550 7850
Wire Bus Line
	6550 3950 6550 4800
Wire Bus Line
	1850 3950 1850 6100
Wire Bus Line
	3850 3950 3850 5600
Wire Bus Line
	4450 3950 4450 6000
Wire Bus Line
	4450 7000 4450 9050
$EndSCHEMATC
