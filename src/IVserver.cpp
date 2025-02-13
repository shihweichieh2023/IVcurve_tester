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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solar Cell I-V Curve Scanner</title>
    <script src="https://cdn.plot.ly/plotly-latest.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --neon-pink: #ff2e88;
            --neon-blue: #00fff9;
            --dark-bg: #0a0a0f;
            --darker-bg: rgba(5, 5, 10, 0.8);
            --text-glow: 0 0 10px rgba(255, 46, 136, 0.7);
            --blue-glow: 0 0 10px rgba(0, 255, 249, 0.7);
            --scale-factor: 0.8;
        }

        body {
            font-family: 'Orbitron', sans-serif;
            background: var(--dark-bg);
            color: var(--neon-blue);
            margin: 0;
            padding: 20px;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .container {
            width: 100%;
            max-width: 600px;
        }

        h1 {
            color: var(--neon-pink);
            text-align: center;
            text-shadow: var(--text-glow);
            font-size: 2em;
            margin-bottom: 20px;
        }

        #measurements {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-bottom: 20px;
        }

        .measurement-row {
            display: flex;
            justify-content: space-around;
            margin-bottom: 15px;
            gap: 15px;
        }

        .measurement-card {
            background: var(--darker-bg);
            padding: 12px;
            border-radius: 6px;
            flex: 1;
            text-align: center;
            border: 1px solid var(--neon-blue);
            box-shadow: var(--blue-glow);
            transition: all 0.3s ease;
        }

        .measurement-card div:first-child {
            font-size: 0.8em;
            color: var(--neon-blue);
            margin-bottom: 8px;
            text-shadow: var(--blue-glow);
        }

        .measurement-card div:last-child {
            color: var(--neon-pink);
            font-size: 0.9em;
            font-weight: bold;
            text-shadow: var(--text-glow);
        }

        #curve-container {
            width: 100%;
            height: 400px;
            background: var(--darker-bg);
            border: 1px solid var(--neon-blue);
            border-radius: 5px;
            box-shadow: var(--blue-glow);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Solar Cell I-V Curve Scanner</h1>
        <div id="measurements"></div>
        <div id="curve-container"></div>
    </div>
    <script>
        function updateData() {
            fetch('/data')
                .then(response => response.json())
                .then(data => {
                    // Update measurements with exactly 2 decimal places
                    document.getElementById('measurements').innerHTML = `
                        <div class="measurement-row">
                            <div class="measurement-card">
                                <div>Maximum power point</div>
                                <div class="measurement-value">${(data.maxPower/1000).toFixed(2)} mW</div>
                            </div>
                            <div class="measurement-card">
                                <div>MPP current</div>
                                <div class="measurement-value">${data.maxCurrent.toFixed(2)} mA</div>
                            </div>
                            <div class="measurement-card">
                                <div>MPP voltage</div>
                                <div class="measurement-value">${(data.maxVoltage/1000).toFixed(2)} V</div>
                            </div>
                        </div>
                        <div class="measurement-row">
                            <div class="measurement-card">
                                <div>Short circuit current (Isc)</div>
                                <div class="measurement-value">${data.Isc.toFixed(2)} mA</div>
                            </div>
                            <div class="measurement-card">
                                <div>Open circuit voltage (Voc)</div>
                                <div class="measurement-value">${(data.Voc/1000).toFixed(2)} V</div>
                            </div>
                        </div>
                    `;

                    // Create traces for I-V curve and power curve
                    const trace1 = {
                        x: data.voltage.map(v => v/1000),  // Convert to V
                        y: data.current,
                        name: 'I-V Curve',
                        line: {color: '#00fff9', width: 2},  // Blue
                        type: 'scatter'
                    };

                    // Add (0,0) point and connect to the last measurement point (Voc)
                    const lastIndex = data.voltage.length - 1;
                    const voltageWithZero = [...data.voltage.map(v => v/1000), 0];
                    const powerWithZero = [...data.power.map(p => p/1000), 0];

                    const trace2 = {
                        x: voltageWithZero,
                        y: powerWithZero,
                        name: 'Power',
                        yaxis: 'y2',
                        line: {color: '#ff2e88', width: 2},  // Pink
                        type: 'scatter'
                    };

                    const layout = {
                        plot_bgcolor: 'rgba(5, 5, 10, 0.8)',
                        paper_bgcolor: 'rgba(5, 5, 10, 0)',
                        font: {
                            family: 'Orbitron, sans-serif',
                            color: '#00fff9'
                        },
                        xaxis: {
                            title: 'Voltage (V)',
                            gridcolor: '#1a1a1f',
                            zerolinecolor: '#2a2a2f',
                            range: [0, Math.max(...data.voltage)/1000 * 1.1]  // Convert to V
                        },
                        yaxis: {
                            title: 'Current (mA)',
                            gridcolor: '#1a1a1f',
                            zerolinecolor: '#2a2a2f'
                        },
                        yaxis2: {
                            title: 'Power (mW)',
                            overlaying: 'y',
                            side: 'right',
                            showgrid: false
                        },
                        showlegend: true,
                        legend: {
                            x: 0.5,
                            y: 1.1,
                            xanchor: 'center',
                            orientation: 'h',
                            font: {size: 12}
                        },
                        margin: {t: 50}
                    };

                    Plotly.newPlot('curve-container', [trace1, trace2], layout);
                })
                .catch(console.error);
        }

        // Update every 500ms
        setInterval(updateData, 500);
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
    json += "\"maxVoltage\":" + String(currentData.maxVoltage, 3) + ",";
    json += "\"Voc\":" + String(currentData.vocValues[0], 3) + ",";      // Open circuit voltage
    json += "\"Isc\":" + String(currentData.icalValues[15], 3) + ",";    // Short circuit current
    json += "\"voltage\":[";
    for (int i = 0; i < currentData.numPoints; i++) {
        if (i > 0) json += ",";
        json += String(currentData.vocValues[i], 3);
    }
    json += "],\"current\":[";
    for (int i = 0; i < currentData.numPoints; i++) {
        if (i > 0) json += ",";
        json += String(currentData.icalValues[i], 3);
    }
    json += "],\"power\":[";
    for (int i = 0; i < currentData.numPoints; i++) {
        if (i > 0) json += ",";
        json += String(currentData.powValues[i], 3);
    }
    json += "]";
    json += "}";
    ivServer.send(200, "application/json", json);
}
