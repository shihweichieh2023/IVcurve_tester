#ifndef IVSERVER_H
#define IVSERVER_H

#include <Arduino.h>
#include <WiFi.h>
#include <WebServer.h>

// Data structure for I-V measurements
struct IVData {
    float maxPower;
    float maxCurrent;
    float maxVoltage;
    float vocValues[16];    // Fixed size array of voltage measurements
    float icalValues[16];   // Fixed size array of current measurements
    float powValues[16];    // Fixed size array of power measurements
    int numPoints;       // Number of measurement points
};

// Function declarations
void setupIVserver();
void handleIVserver();
void updateIVserverData(const IVData& data);

// Declare the server as external
extern WebServer ivServer;

#endif
