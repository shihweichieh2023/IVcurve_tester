#ifndef CONFIG_H
#define CONFIG_H

// WiFi Configuration
#define WIFI_NETWORK_COUNT 5  // Update this when adding/removing networks

struct WifiCreds {
    const char* ssid;
    const char* password;
};

const WifiCreds WIFI_NETWORKS[WIFI_NETWORK_COUNT] = {
    {"network1", "password1"},        // Primary network
    {"network2", "password2"},        // Second network
    {"network3", "password3"},        // Third network
    {"network4", "password4"},        // Fourth network
    {"network5", ""}                  // Fifth network (no password)
};

// ThingSpeak Configuration
#define THINGSPEAK_CHANNEL_ID 0000000        // Your channel ID
#define THINGSPEAK_API_KEY "YOUR-API-KEY"    // Your write API key

// DeepSeek API Configuration
#define DEEPSEEK_API_KEY "your_api_key_here"
#define DEEPSEEK_API_ENDPOINT "https://api.deepseek.com/v1"

// Other configuration settings...

#endif
