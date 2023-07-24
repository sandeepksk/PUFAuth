#include <SPI.h>
#include <SD.h>
#include <SoftwareSerial.h>

const int chipSelect = 7; // CS pin for the SD card reader

void setup() {
    Serial.begin(9600); // Initialize Serial communication

    if (!SD.begin(chipSelect)) {
        Serial.println("SD card initialization failed!");
        while (1);
    }
}

void sendFileData(File file) {
    while (file.available()) {
        String packetData = file.readStringUntil('\n'); // Read data line by line from the file
        Serial.println(packetData);
        delay(1000); // Add a short delay to prevent flooding the receiver
    }
}

void loop()
 {
    File dataFile = SD.open("NOW.txt", FILE_READ); // Open the text file

    if (dataFile)
     {
       // Serial.println("Sending file data to NodeMCU...");
        sendFileData(dataFile);
        dataFile.close();
        Serial.println("File data sent successfully.");
    }
    else
     {
        Serial.println("Error opening file!");
     }

    delay(5000); // Wait for a few seconds before sending the file again
}
