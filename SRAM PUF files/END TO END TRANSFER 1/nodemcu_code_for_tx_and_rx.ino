#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

const char* ssid = "Sandy";
const char* password = "Sandysandyyy";
const IPAddress serverIP(192,168,195,111);
const unsigned int serverPort = 5201;
const unsigned int nodeMCUPort = 8888;

WiFiUDP udp;

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

  udp.begin(nodeMCUPort);
  Serial.print("UDP server started at port: ");
  Serial.println(nodeMCUPort);
}

void loop() {
  if (Serial.available() > 0) {
    String packetData = Serial.readStringUntil('\n');
    Serial.println("" + packetData); // Print received data for debugging

    // Send the received data to the server over UDP
    udp.beginPacket(serverIP, serverPort);
    udp.print(packetData);
    udp.endPacket();
  }

  // Wait for a response from the server
  int packetSize = udp.parsePacket();
  if (packetSize) {
    byte buffer[1024];
    int bytesRead = udp.read(buffer, sizeof(buffer));

    // Null-terminate the buffer
    buffer[bytesRead] = '\0';

    // Display the received response from the server
    //Serial.print("Response from server: ");
    Serial.println((char*)buffer);
  }

  delay(500); // Add a small delay for stability
}
