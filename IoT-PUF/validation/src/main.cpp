#include <Arduino.h>
#include <stdio.h>
#include <Tools.h>
#include <BCH.h>
#include <SRAM_CY62256N.h>
#include <SPI.h>
#include <SD.h>
#include <string.h>

#define PIN_POWER_ANALOG A8
#define PIN_POWER 9

SRAM_CY62256N sram;

String ssid = "DIR-615-9573";
String password = "90013416";

int identifier = 1;

String serverIP = "192.168.0.187";  // IP address of the UDP server
int serverPort = 18000;  // Port number of the UDP server


struct auth_hdr {
  uint8_t msgType;
  uint32_t challenge1;
  uint32_t challenge2;
  uint64_t randomnumber;
  uint32_t hash;
  uint32_t identifier;
  uint32_t prTime;
} __attribute__((packed));


boolean readBit(long location) {
  uint8_t result = sram.read(floor(location / 8));
  return result >> (7 - (location % 8)) & 0x1 == 1;
}

void connectToWiFi() {
  Serial1.println("AT+CWJAP=\"" + ssid + "\",\"" + password + "\"");
  delay(5000);

  if (Serial1.find("OK")) {
    Serial.println("Connected to Wi-Fi network: " + ssid);
  } else {
    Serial.println("Failed to connect to Wi-Fi network.");
  }
}

void set() {
  sram = SRAM_CY62256N();

  DDRB = 0b11100000; //Pin 13, 12, 11 set to output
  DDRA = 0b11111111; //Pins 22-29 Set as Output (Lower Byte of Address)
  DDRC = 0b01111111; //Pins 37-31 Set as Output (Upper Byte of Address)

  pinMode(PIN_POWER, OUTPUT);

  Serial.begin(115200);

  delay(1000);
}


void turn_on_sram() {
  analogWrite(PIN_POWER, 255);
}

void turn_off_sram() {
  analogWrite(PIN_POWER, 0);

  for (int i = 22; i <= 29; i++) {
    digitalWrite(i, LOW);
  }
  for (int i = 31; i <= 37; i++) {
    digitalWrite(i, LOW);
  }
  for (int i = 42; i <= 49; i++) {
    digitalWrite(i, LOW);
  }
  for (int i = 11; i <= 13; i++) {
    digitalWrite(i, LOW);
  }
}

void initializeSD() {
  Serial.print("Initializing SD card...");

  if (!SD.begin(7)) {
    Serial.println("initialization failed!");
    delay(2000);
    exit(0);
  }
  Serial.println("initialization done.");
}


String* readSRAMfromMicroSD(String challenge1_id,String challenge2_id) {

  String name = "CRPS.txt";
  String c1, c2;

  String r1="";
  String r2="";

  String out[2];
  out[0] = r1;
  out[1] = r2;

  return out;
  
}

String hashCompute(String challenge1_id,String challenge2_id)
{
    String responses[2];

    turn_on_sram();

    // responses = readSRAMfromMicroSD(challenge1_id,challenge2_id);

    turn_off_sram();
  
}

// Function to convert a 32-bit value to network byte order
uint32_t convertToNetworkByteOrder(uint32_t value) {
  return ((value >> 24) & 0xFF) |
         ((value >> 8) & 0xFF00) |
         ((value << 8) & 0xFF0000) |
         ((value << 24) & 0xFF000000);
}

bool sendRequest()
{
  auth_hdr auth_req;
  
  auth_req.msgType = 0x0;                     // Type is 0 for request packet
  auth_req.identifier = convertToNetworkByteOrder(identifier);

  // Calculate the total length of the header
  size_t headerLength = sizeof(auth_hdr);

  // Send the length of the header to the ESP8266
  Serial1.print("AT+CIPSEND=1,");
  Serial1.print(headerLength);
  Serial1.print("\r\n");
  delay(1000);

  // Send each byte of the header using SoftwareSerial
  uint8_t* headerBytes = reinterpret_cast<uint8_t*>(&auth_req);
  for (size_t i = 0; i < headerLength; i++) {
    Serial1.write(headerBytes[i]);
}

// Wait for the response from the ESP8266
delay(1000);
}

void setup(void)
{
  Serial.end();
  Serial.begin(115200);
  Serial1.begin(115200);
  delay(1000);

  
  //setting ARDUNIO IO PINS
  set();

  Serial.println("Set done");

  //intialising SD card
  initializeSD();

  Serial.println("Initializing ESP8266...");
  Serial1.println("AT");
  delay(1000);

  if (Serial1.find("OK")) {
    Serial.println("ESP8266 module is ready.");
  } else {
    Serial.println("Failed to initialize ESP8266 module.");
    return;
  }

    // Connect to Wi-Fi network
  connectToWiFi();

  // Initialize UDP socket
  Serial1.print("AT+CIPSTART=1,\"UDP\",\"");
  Serial1.print(serverIP);
  Serial1.print("\",");
  Serial1.print(serverPort);
  Serial1.print(",");
  Serial1.print(serverPort);
  Serial1.println(",0");
  delay(1000);

  if (Serial1.find("OK")) {
    Serial.println("UDP socket initialized.");
  } else {
    Serial.println("Failed to initialize UDP socket.");
    return;
  }


  //Initalising PUF protocol
  Serial.println("Sending Request");
  sendRequest();


}

void loop() {
  delay(1000);
  exit(0);
}
