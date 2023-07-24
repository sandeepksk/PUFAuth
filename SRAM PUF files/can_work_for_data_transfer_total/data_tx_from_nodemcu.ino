#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <SD.h> // Include the SD library

const char* ssid = "Sandy";      // Replace with your Wi-Fi network SSID
const char* password = "Sandysandy";  // Replace with your Wi-Fi network password
const IPAddress serverIP(192, 168, 50, 111);  // Replace with your laptop's IP address
const unsigned int serverPort = 5201;         // Port to communicate with the laptop
const unsigned int nodeMCUPort = 8889;        // Port to communicate with the laptop

WiFiUDP udp;
File dataFile; // File object to read data from SD card

void setup() {
  Serial.begin(9600);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.print("Connected to WiFi: ");
  Serial.println(ssid);
  Serial.println("IP address is: ");
  Serial.println(WiFi.localIP());

  // Initialize the SD card
  if (!SD.begin(7)) {
    Serial.println("SD card initialization failed!");
    while (1);
  }

  udp.begin(nodeMCUPort);
}

void receiveFileData() {
  while (Serial.available() > 0) {
    String packetData = Serial.readStringUntil('\n');
    Serial.println("Received: " + packetData); // Print received data for debugging

    // Write the data to the file on the SD card
    dataFile = SD.open("NOW.txt", FILE_WRITE);
    if (dataFile) {
      dataFile.println(packetData);
      dataFile.close();
    } else {
      Serial.println("Error opening data file!");
    }
  }
}

void loop() {
  receiveFileData();

  // Read data from the file on the SD card
  dataFile = SD.open("NOW.txt", FILE_READ);
  if (dataFile) {
    // Read the file line by line and send it over UDP
    while (dataFile.available()) {
      String line = dataFile.readStringUntil('\n');
      udp.beginPacket(serverIP, serverPort);
      udp.print(line);
      udp.endPacket();
      Serial.println("Sent: " + line);
      delay(10); // Add a small delay between packets to avoid overwhelming the server
    }
    dataFile.close();
    // Remove the file after sending the data
    SD.remove("NOW.txt");
  } else {
    Serial.println("Error opening data file!");
  }

  // Wait for a response from the server
  int packetSize = udp.parsePacket();
  if (packetSize) {
    byte buffer[256];
    int bytesRead = udp.read(buffer, sizeof(buffer));

    // Display the server's response
    Serial.print("Response from server: ");
    for (int i = 0; i < bytesRead; i++) {
      Serial.write(buffer[i]);
    }
    Serial.println();
  }

  delay(5000); // Send data every 5 seconds (adjust as needed)
}
