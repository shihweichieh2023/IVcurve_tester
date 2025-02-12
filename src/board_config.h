#ifndef BOARD_CONFIG_H
#define BOARD_CONFIG_H

// Choose your board by uncommenting one of these:
#define BOARD_ESP32S3_MINI
//#define BOARD_ESP32C3_SUPER_MINI

#ifdef BOARD_ESP32S3_MINI
    #define PIN_MUX_S0      2   // MUX control pin S0
    #define PIN_MUX_S1      6   // MUX control pin S1
    #define PIN_MUX_S2      4   // MUX control pin S2
    #define PIN_MUX_S3      5   // MUX control pin S3
    #define PIN_SIG         1   // ADC input for voltage measurement
    #define PIN_POT_Y       16  // ADC input for Y-axis scaling
    #define PIN_POT_X       18  // ADC input for X-axis scaling
    #define PIN_BUTTON      35  // Digital input for mode button
    #define PIN_TPI         10  // Test Point Input control
#endif

#ifdef BOARD_ESP32C3_SUPER_MINI
    #define PIN_MUX_S0      21   // MUX control pin S0
    #define PIN_MUX_S1      10   // MUX control pin S1
    #define PIN_MUX_S2      2   // MUX control pin S2
    #define PIN_MUX_S3      1   // MUX control pin S3
    #define PIN_SIG         0   // ADC input for voltage measurement
    #define PIN_POT_Y       4   // ADC input for Y-axis scaling
    #define PIN_POT_X       3   // ADC input for X-axis scaling
    #define PIN_BUTTON      7   // Digital input for mode button
    #define PIN_TPI         20   // Test Point Input control
#endif

// Verify that a board is selected
#if !defined(BOARD_ESP32S3_MINI) && !defined(BOARD_ESP32C3_SUPER_MINI)
    #error "Please select a board by uncommenting its definition in board_config.h"
#endif

#endif // BOARD_CONFIG_H
