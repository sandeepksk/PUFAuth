#include <SD.h>
#include <SoftwareSerial.h>

//SoftwareSerial serial(2, 3); // RX, TX pins on Arduino
File file;

void setup() {
  Serial.begin(9600); // Serial monitor baud rate
 // serial.begin(9600); // Serial communication with PC baud rate

  // Initialize the SD card
  if (!SD.begin(7)) {
    Serial.println("SD card initialization failed!");
    while (1);
  }

  // Open the file for reading
  file = SD.open("NOW.txt"); // Replace with your file name
  if (!file) {
    Serial.println("File not found!");
    while (1);
  }
}

void loop() {
  if (file.available()) {
    String line = file.readStringUntil('\n');
    Serial.println(line);
    delay(10); // Adjust as needed
  } else {
    file.close();
    Serial.println("END_OF_FILE");
    while (1); // Stop the Arduino after the file is sent
  }
}
