#include <Arduino.h>

// Define the SRAM control pins
#define SRAM_CE_PIN 20
#define SRAM_WE_PIN 27
#define SRAM_OE_PIN 22

// Define address pins
#define SRAM_ADDRESS_PINS 15  // Number of address lines (32K address space)
#define SRAM_A0_PIN 1
#define SRAM_A1_PIN 2
#define SRAM_A2_PIN 3
#define SRAM_A3_PIN 4
#define SRAM_A4_PIN 5
#define SRAM_A5_PIN 6
#define SRAM_A6_PIN 7
#define SRAM_A7_PIN 8
#define SRAM_A8_PIN 9
#define SRAM_A9_PIN 10
#define SRAM_A10_PIN 21
#define SRAM_A11_PIN 23
#define SRAM_A12_PIN 24
#define SRAM_A13_PIN 25
#define SRAM_A14_PIN 26

// Define data pins
#define SRAM_DATA_PINS 8  // Number of data lines
#define SRAM_DATA_PIN_0 11
#define SRAM_DATA_PIN_1 12
#define SRAM_DATA_PIN_2 13
#define SRAM_DATA_PIN_3 15
#define SRAM_DATA_PIN_4 16
#define SRAM_DATA_PIN_5 17
#define SRAM_DATA_PIN_6 18
#define SRAM_DATA_PIN_7 19

const int arduinoBaudRate = 9600; // Baud rate for communication with NodeMCU
const char endMarker = '\n';      // Character marking the end of a message
char receivedData[1024];          // Buffer to store received data
boolean newData = false;          // Flag to indicate new data received

// Function to read data from SRAM at a specific address with data selection
uint8_t readSRAM(uint32_t address) {
  // Extract the first 3 bits for data selection
  uint8_t dataSelect = (address >> 15) & 0x07;

  // Set address lines (last 15 bits)
  for (int i = 0; i < SRAM_ADDRESS_PINS; i++) {
    pinMode(SRAM_A0_PIN + i, OUTPUT); // Set address pins as outputs
    digitalWrite(SRAM_A0_PIN + i, (address >> i) & 0x01);
  }

  // Enable SRAM (Chip Enable)
  digitalWrite(SRAM_CE_PIN, LOW);

  // Enable output (Output Enable)
  digitalWrite(SRAM_OE_PIN, LOW);

  // Read data from the selected data pin
  uint8_t dataBit = digitalRead(SRAM_DATA_PIN_0 + dataSelect);

  // Disable output (Output Enable)
  digitalWrite(SRAM_OE_PIN, HIGH);

  // Disable SRAM (Chip Disable)
  digitalWrite(SRAM_CE_PIN, HIGH);

  // Set address pins back to inputs
  for (int i = 0; i < SRAM_ADDRESS_PINS; i++) {
    pinMode(SRAM_A0_PIN + i, INPUT);
  }

  return dataBit;
}

void setup() {
  // Initialize control pins as outputs
  pinMode(SRAM_CE_PIN, OUTPUT);
  pinMode(SRAM_WE_PIN, OUTPUT);
  pinMode(SRAM_OE_PIN, OUTPUT);

  // Deselect the SRAM chip initially
  digitalWrite(SRAM_CE_PIN, HIGH);

  // Start Serial communication
  Serial.begin(arduinoBaudRate);
}

void loop() {
  // Handle data from NodeMCU via serial communication
  if (Serial.available() > 0) {
    String packetData = Serial.readStringUntil('\n');
    uint32_t address = packetData.toInt();

    // Ensure the address is within the valid range (0-262143) and not 0
    if (address > 0 && address <= 262143) {
      // Read data from SRAM at the specified address
      uint8_t sramData = readSRAM(address);

      // Print the received challenge and SRAM data
     // Serial.print(" ");
      //Serial.print(address);
     // Serial.print(": ");
      Serial.println(sramData, DEC);
    }
  }
}
