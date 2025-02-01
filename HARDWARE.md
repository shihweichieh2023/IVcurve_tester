# I-V Curve Analyzer Hardware Documentation
=================================

## Overview
This I-V curve analyzer is designed for characterizing low-power energy sources using an ESP32-S3 Mini board. It uses a multiplexer to switch between different load resistors and can optionally use a MOSFET for additional low-resistance measurements. A voltage divider is implemented to ensure the input voltage stays within the ESP32's ADC range (0-3.3V), allowing measurement of higher voltage sources while maintaining accuracy.

## Block Diagram
```ascii
+-------------+     +----------+     +-----------+
|  Solar      |     | Resistor |     |   MUX    |
|  Cell       |---->|  Array   |---->| CD74HC   |
| (DUT)       |     | (R5-R20) |     | 4067     |
+-------------+     +----------+     +-----------+
       |                                  |
       |                                  |
       |                                  |
       |           +---------+            |
       +---------->| MOSFET  |            |
                   | Circuit |            |
                   +---------+            |
                        |                 |
                        |                 |
                        |                 v
                        |        +--------------+
                        +------->|  ESP32-S3    |
                                |    Mini      |
                                |   (ADC1)     |
                                +--------------+
                                      ^
                                      |
                                      |
                                +---------------+
                                | UI Controls   |
                                | OLED, Pots,   |
                                |   Button      |
                                +---------------+
```

## Detailed Connections
### ESP32-S3 Mini Pin Assignments
```markdown
GPIO1  -> MUX SIG (ADC input)
GPIO2  -> Potentiometer Y
GPIO3  -> Potentiometer X
GPIO4  -> MUX S0
GPIO5  -> MUX S1
GPIO6  -> MUX S2
GPIO7  -> MUX S3
GPIO8  -> MOSFET Gate (TPI)
GPIO9  -> OLED SDA
GPIO10 -> OLED SCL
GPIO0  -> Button (with pull-up)
```

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
R5  ->    83Ω
R6  ->    95Ω
R7  ->   114Ω
R8  ->   142Ω
R9  ->   165Ω
R10 ->   212Ω
R11 ->   278Ω
R12 ->   383Ω
R13 ->   516Ω
R14 ->   764Ω
R15 ->   972Ω
R16 ->  1878Ω
R17 ->  3211Ω
R18 ->  4723Ω
R19 ->  6856Ω
R20 -> 10317Ω
```

### MOSFET Circuit Configuration
```ascii
Solar Cell+
    |
    |------------+----------------+
    |            |                |
    |         Resistor         MOSFET
    |           Array         +-------+
    |            |           |Gate   |
    |            |           |       |<----GPIO8 (TPI)
    |            v           |       |      |
    |           MUX         |Drain  |      |
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
  - Connects to all resistors (R5-R20) in parallel
  - Connects to MOSFET drain
- **Negative Terminal**: 
  - Connects to MUX COM pin (9)
  - Connects to MOSFET source

### Power Supply
- ESP32-S3 Mini is powered via USB (5V)
- Solar cell or DUT is only connected to measurement inputs

### OLED Display (SSD1306)
- VCC -> 3.3V
- GND -> GND
- SCL -> GPIO10
- SDA -> GPIO9
- Uses I2C address 0x3C

### Control Interface
- POT Y -> GPIO2 (Vertical scaling)
- POT X -> GPIO3 (Horizontal scaling)
- Button -> GPIO0 (with internal pull-up)

## Operating Modes

### Current Implementation
- Uses resistor array only (R5-R20)
- MOSFET kept OFF (GPIO8 = LOW)
- Measures through each resistor sequentially

### Future Enhancement: MOSFET Integration
Can operate in three modes:
1. MOSFET only (very low resistance when ON)
2. Resistor only (R5-R20 through MUX)
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
1. Cycles through resistors R5-R20
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
