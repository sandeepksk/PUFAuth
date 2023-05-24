#include <Arduino.h>
#include <stdio.h>
#include <Tools.h>
#include <BCH.h>
#include <SRAM_CY62256N.h>
#include <SPI.h>
#include <SD.h>
#include <Crypto.h>
#include <SHA3.h>
#include <string.h>
#include <AES.h>
#include <ArduinoJson.h>

#define PIN_POWER_ANALOG A8
#define PIN_POWER 9

SRAM_CY62256N sram;


boolean readBit(long location) {
  uint8_t result = sram.read(floor(location / 8));
  return result >> (7 - (location % 8)) & 0x1 == 1;
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

  String name = "CRPS.json";
  String c1, c2;

  String r1="";
  String r2="";

  File jsonFile = SD.open("CRPS.json"); // Replace "data.json" with your JSON file's name
  if (!jsonFile) {
    Serial.println("Failed to open JSON file.");
    return;
  }

  StaticJsonDocument<bufferSize> jsonDocument;
  DeserializationError error = deserializeJson(jsonDocument, jsonFile);
  if (error) {
    Serial.print("Failed to parse JSON file: ");
    Serial.println(error.c_str());
    return;
  }

  jsonFile.close();

  // Retrieve challenges for a specific key
  const char* challengesStr1 = jsonDocument[String(challenge1_id)]["challenges"];
  const char* challengesStr2 = jsonDocument[String(challenge2_id)]["challenges"];

  if (challengesStr1 && challengesStr2) 
  {
    // Split the challenges string by comma and convert each value to an integer
    const char* delim = ", ";
    char* challengeToken1 = strtok(const_cast<char*>(challengesStr1), delim);
    char* challengeToken2 = strtok(const_cast<char*>(challengesStr2), delim);

    while ((challengeToken1 != NULL) && (challengeToken2 != NULL)) {
      c1 = atoi(challengeToken1);
      c2 = atoi(challengeToken2);

      if(readBit(c1))
      {
        r1 += "1";
      }
      else
      {
        r1 += "0";
      }

      if(readBit(c2))
      {
        r2 += "1";
      }
      else
      {
        r2 += "0";
      }

      challengeToken1 = strtok(NULL, delim);
      challengeToken2 = strtok(NULL, delim);
    }
  }

  else 
  {
    Serial.println("Invalid key index.");
  }

  String out[2];
  out[0] = r1;
  out[1] = r2;

  return out;
  
}

String hashCompute(String challenge1_id,String challenge2_id)
{
    String responses[2];

    turn_on_sram();

    responses = readSRAMfromMicroSD(challenge1_id,challenge2_id);

    turn_off_sram();

    Serial.println(responses[0]);
    Serial.println(responses[1]);
  
}

void setup(void)
{
  Serial.end();
  Serial.begin(115200);
  delay(1000);

  String challenge1_id = "";
  String challenge2_id = "";
  
  //setting ARDUNIO IO PINS
  set();

  //intialising SD card
  initializeSD();

  hashCompute(challenge1_id,challenge2_id);

}

void loop() {
  delay(1000);
  exit(0);
}
