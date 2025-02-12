#include "IVserver.h"

// Create web server instance on port 80
WebServer ivServer(80);

// Global variable to store current measurement data
IVData currentData;

// Handler function declarations
void handleRoot();
void handleData();

// Web Server setup
void setupIVserver() {
    ivServer.on("/", handleRoot);      // Handle root URL
    ivServer.on("/data", handleData);  // Handle data endpoint
    
    ivServer.begin();
    Serial.println("IV Curve HTTP server started");
    Serial.print("Use this URL: http://");
    Serial.print(WiFi.localIP());
    Serial.println("/");
}

// Handle client requests in the main loop
void handleIVserver() {
    ivServer.handleClient();
    delay(2);  // Allow the CPU to switch to other tasks
}

// Update the web server with new measurement data
void updateIVserverData(const IVData& data) {
    currentData = data;
}

// Root page handler - serves the main HTML page
void handleRoot() {
    String html = R"(
<!DOCTYPE html>
<html>
<head>
    <title>I-V Curve Analyzer</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            margin: 20px;
            background-color: #f0f0f0;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 { 
            color: #333;
            text-align: center;
        }
        .measurements {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .measurement-card {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
            text-align: center;
        }
        .measurement-value {
            font-size: 24px;
            font-weight: bold;
            color: #007bff;
        }
        #curve-container {
            margin-top: 20px;
            height: 400px;
        }
    </style>
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>I-V Curve Analyzer</h1>
        <div class="measurements" id="measurements"></div>
        <div id="curve-container"></div>
    </div>
    <script>
        function updateData() {
            fetch('/data')
                .then(response => response.json())
                .then(data => {
                    // Update measurement cards
                    document.getElementById('measurements').innerHTML = `
                        <div class="measurement-card">
                            <div>Maximum Power</div>
                            <div class="measurement-value">${(data.maxPower/1000).toFixed(3)} mW</div>
                        </div>
                        <div class="measurement-card">
                            <div>Maximum Current</div>
                            <div class="measurement-value">${data.maxCurrent.toFixed(3)} mA</div>
                        </div>
                        <div class="measurement-card">
                            <div>Maximum Voltage</div>
                            <div class="measurement-value">${(data.maxVoltage/1000).toFixed(3)} V</div>
                        </div>
                    `;

                    // Update plot
                    if (data.voltage && data.current) {
                        const trace1 = {
                            x: data.voltage.map(v => v/1000), // Convert millivolts to volts
                            y: data.current,
                            mode: 'lines+markers',
                            name: 'I-V Curve',
                            line: {color: '#007bff'}
                        };

                        const layout = {
                            title: 'I-V Curve',
                            xaxis: {
                                title: 'Voltage (V)',
                                rangemode: 'tozero',
                                autorange: true
                            },
                            yaxis: {
                                title: 'Current (mA)',
                                rangemode: 'tozero',
                                autorange: true
                            },
                            margin: {t: 40},
                            plot_bgcolor: '#f8f9fa',
                            paper_bgcolor: '#ffffff'
                        };

                        Plotly.newPlot('curve-container', [trace1], layout);
                    }
                });
        }

        // Update every second
        setInterval(updateData, 1000);
        updateData();  // Initial update
    </script>
</body>
</html>
    )";
    
    ivServer.send(200, "text/html", html);
}

// Data endpoint handler - serves JSON data
void handleData() {
    String json = "{";
    json += "\"maxPower\":" + String(currentData.maxPower, 3) + ",";
    json += "\"maxCurrent\":" + String(currentData.maxCurrent, 3) + ",";
    json += "\"maxVoltage\":" + String(currentData.maxVoltage, 3);
    
    // Add voltage and current arrays if available
    if (currentData.vocValues && currentData.icalValues && currentData.numPoints > 0) {
        json += ",\"voltage\":[";
        for (int i = 0; i < currentData.numPoints; i++) {
            if (i > 0) json += ",";
            json += String(currentData.vocValues[i], 3);
        }
        json += "],\"current\":[";
        for (int i = 0; i < currentData.numPoints; i++) {
            if (i > 0) json += ",";
            json += String(currentData.icalValues[i], 3);
        }
        json += "]";
    }
    
    json += "}";
    ivServer.send(200, "application/json", json);
}
