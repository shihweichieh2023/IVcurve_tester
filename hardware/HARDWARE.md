# I-V Curve Analyzer Hardware Documentation
=================================

## Overview
This I-V curve analyzer is designed for characterizing low-power energy sources using either an ESP32-S3 Mini or ESP32-C3 Super Mini board. It uses a multiplexer (CD74HC4067, with planned upgrade to ADG706) to switch between different load resistors and can optionally use a MOSFET for additional low-resistance measurements. A voltage divider is implemented to ensure the input voltage stays within the ESP32's ADC range (0-3.3V), allowing measurement of higher voltage sources while maintaining accuracy.

## Supported Hardware
The firmware supports two board configurations:
1. ESP32-S3 Mini (default)
2. ESP32-C3 Super Mini

To select your board, edit the `include/board_config.h` file and uncomment the appropriate board definition.

## Block Diagram
```ascii
+-------------+     +----------+     +-----------+
|  Solar      |     | Resistor |     |    MUX    |
|  Cell       |---->|  Array   |---->|  CD74HC   |
| (DUT)       |     | (R1-R16) |     |   4067    |
+-------------+     +----------+     +-----------+
       |                                  |
       |                                  |
       |                                  |
       |           +---------+            |
       +---------->| MOSFET  |            v
       |           | Circuit |           GND
       |           +---------+            
       |                |                 
       |                |                 
       |                |                 
       |                |        +--------------+
       +----------------+------->|  ESP32-S3    |
                                 |    Mini      |
                                 |   (ADC1)     |
                                 +--------------+
                                      ^
                                      |
                                      |
                                +---------------+
                                | UI Controls   |
                                | OLED, Pots,   |
                                | Button,E-ink  |
                                +---------------+
```

## Pin Assignments

### ESP32-S3 Mini
```markdown
PIN_MUX_S0  (2)  -> MUX control pin S0
PIN_MUX_S1  (6)  -> MUX control pin S1
PIN_MUX_S2  (4)  -> MUX control pin S2
PIN_MUX_S3  (5)  -> MUX control pin S3
PIN_SIG     (1)  -> ADC input for voltage measurement
PIN_POT_Y   (16) -> ADC input for Y-axis scaling
PIN_POT_X   (18) -> ADC input for X-axis scaling
PIN_BUTTON  (35) -> Digital input for mode button
PIN_TPI     (10) -> Test Point Input control
```

### ESP32-C3 Super Mini
```markdown
PIN_MUX_S0  (2) -> MUX control pin S0
PIN_MUX_S1  (3) -> MUX control pin S1
PIN_MUX_S2  (4) -> MUX control pin S2
PIN_MUX_S3  (5) -> MUX control pin S3
PIN_SIG     (1) -> ADC input for voltage measurement
PIN_POT_Y   (6) -> ADC input for Y-axis scaling
PIN_POT_X   (7) -> ADC input for X-axis scaling
PIN_BUTTON  (8) -> Digital input for mode button
PIN_TPI     (9) -> Test Point Input control
```

## Components List

- ESP32-S3 Mini development board
- CD74HC4067 16-channel multiplexer
- SSD1306 OLED display (128x64)
- Adafruit 2.9" Tri-Color eInk Display FeatherWing (IL0373)
- 16 precision resistors for measurement array
- MOSFET circuit for low-resistance measurements
- Push button for measurement control
- Various connectors and headers

## Display Connections

### OLED Display (SSD1306)
- VCC → 3.3V
- GND → GND
- SCL → GPIO22
- SDA → GPIO21

### E-ink Display (IL0373)
- VIN → 3.3V
- GND → GND
- SCK → GPIO36
- MOSI → GPIO35
- DC → GPIO37
- CS → GPIO38
- RST → GPIO39
- BUSY → GPIO40

## Detailed Connections
### CD74HC4067 Multiplexer
```ascii
      +-----U-----+
CH7   |1  []   24| VCC
CH6   |2       23| CH8
CH5   |3       22| CH9
CH4   |4       21| CH10
CH3   |5       20| CH11
CH2   |6       19| CH12
CH1   |7       18| CH13
CH0   |8       17| CH14
COM   |9       16| CH15
S0    |10      15| EN
S1    |11      14| S2
GND   |12      13| S3
      +-----------+
```

### Resistor Array
Connected to MUX channels, values in ohms:
```markdown
R1  ->  10317Ω
R2  ->   6856Ω
R3  ->   4723Ω
R4  ->   3211Ω
R5  ->   1878Ω
R6  ->    972Ω
R7  ->    764Ω
R8  ->    516Ω
R9  ->    383Ω
R10 ->    278Ω
R11 ->    212Ω
R12 ->    165Ω
R13 ->    142Ω
R14 ->    114Ω
R15 ->     95Ω
R16 ->     83Ω
```

### MOSFET Circuit Configuration
```ascii
Solar Cell+
    |
    |------------+----------------+
    |            |                |
    |         Resistor         MOSFET
    |           Array        +-------+
    |            |           |Gate   |
    |            |           |       |<----GPIO8 (TPI)
    |            v           |       |      |
    |           MUX          |Drain  |      |
    |            |           |       |      |
    |            |           |Source |      |
    |            |           +-------+      |
    |            |               |          |
    |            |               |          |
    +------------+---------------+----------+
                                 |
                                GND
```

## Connection Details

### Solar Cell / Device Under Test (DUT)
- **Positive Terminal**: 
  - Connects to all resistors (R1-R16) in parallel
  - Connects to MOSFET drain
- **Negative Terminal**: 
  - Connects to MUX COM pin (9)
  - Connects to MOSFET source

### Power Supply
- ESP32-S3 Mini is powered via USB (5V)
- Solar cell or DUT is only connected to measurement inputs

## Operating Modes

### Current Implementation
- Uses resistor array only (R1-R16)
- MOSFET kept OFF (GPIO8 = LOW)
- Measures through each resistor sequentially

### Future Enhancement: MOSFET Integration
Can operate in three modes:
1. MOSFET only (very low resistance when ON)
2. Resistor only (R1-R16 through MUX)
3. MOSFET + Resistor in parallel (for intermediate values)

This would triple the measurement points, particularly useful in the low-resistance region where maximum power often occurs.

## Safety Considerations

### Voltage Protection
1. Maximum input voltage should not exceed 3.3V
2. Use voltage dividers if input might exceed 3.3V
3. Add protection diodes for unknown voltage sources

### General Safety
1. Keep all grounds connected
2. Add bypass capacitors near ICs
3. Use appropriate power ratings for resistors
4. Consider MOSFET heat dissipation during parallel operation

## Measurement Process
1. Cycles through resistors R1-R16
2. Measures voltage across each load
3. Calculates current using measured resistance values
4. Computes power and identifies Maximum Power Point (MPP)
5. Displays results on OLED:
   - Maximum Power (mW)
   - Voltage at MPP (mV)
   - Current at MPP (µA)

## Notes
- Resistor values shown are actual measured values through MUX
- Values form roughly logarithmic progression
- MOSFET circuit is prepared for future enhancements
- Button press triggers detailed serial output
- Display updates in real-time with measurements
