#include <WiFi.h>
#include <ThingSpeak.h>
#include <Wire.h> // Add this line for Wire library

const char* ssid = "DAV";
const char* password = "1234567809qpt";
const unsigned long channelNumber = 2455669;
const char* apiKey = "RYDCFQ5P0DPA3AZQ";
int maxVoltage = 4095;

const int freq[] = {500, 700, 900, 1100, 1300, 1500, 1750};

const int dustSensorPin = 34;
const int mq6SensorPin = 32;
const int mq135SensorPin = 35;

const int redLED = 21;
const int greenLED = 23;
const int blueLED = 22;
const int buzzerPin = 19;

WiFiClient client;

// Function prototype
int convertToNumerical(int voltage, int maxVoltage);

void setup() {
  pinMode(redLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  pinMode(blueLED, OUTPUT);
  pinMode(buzzerPin, OUTPUT);
  pinMode(mq6SensorPin, INPUT);
  pinMode(dustSensorPin, INPUT);
  pinMode(mq135SensorPin, INPUT);
  Serial.begin(9600);

  tone(buzzerPin, 1000, 2000);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    wifi_not_connected();
  }
  ThingSpeak.begin(client);
}

void loop() {
  int dustLevels = analogRead(dustSensorPin);
  int mq6Values = analogRead(mq6SensorPin);
  int mq135Values = analogRead(mq135SensorPin);

  int converted = convertToNumerical(dustLevels, maxVoltage);


  Serial.println(dustLevels);
  Serial.println(mq6Values);
  Serial.println(mq135Values);

  int dustLevel = map(converted, 0, 4095, 0, 500);
  int mq6Value = map(mq6Values, 0, 4095, 200, 10000);
  int mq135Value = map(mq135Values, 0, 4095, 0, 1000);

  Serial.println("Mapped Values");

  Serial.println(dustLevel);
  Serial.println(mq6Value);
  Serial.println(mq135Value);

  if ((dustLevel >= 301 && dustLevel <= 500) || (mq6Value >= 6901 && mq6Value <= 10000) || (mq135Value >= 151 && mq135Value <= 1000)) {
    high();
  } else if ((dustLevel >= 101 && dustLevel < 301) || (mq6Value >= 5501 && mq6Value < 6901) || (mq135Value >= 51 && mq135Value < 151)) {
    average();
  } else if (dustLevel < 101 || mq6Value < 5500 || mq135Value < 50) {
    low();
  } else {
    // If none of the conditions above are met, turn off the buzzer
    noTone(buzzerPin);
  }

  ThingSpeak.setField(1, dustLevel);
  ThingSpeak.setField(2, mq135Value);
  ThingSpeak.setField(3, mq6Value);

  ThingSpeak.writeFields(channelNumber, apiKey);

  delay(20000);
}

void wifi_not_connected() { // Corrected function name
  digitalWrite(greenLED, HIGH);
  delay(100);
  digitalWrite(greenLED, LOW);
  digitalWrite(blueLED, HIGH);
  delay(100);
  digitalWrite(blueLED, LOW);
  digitalWrite(redLED, HIGH);
  delay(100);
  digitalWrite(redLED, LOW);
}

void low() {
  digitalWrite(redLED, LOW);
  digitalWrite(blueLED, LOW);
  digitalWrite(greenLED, HIGH);
  noTone(buzzerPin); // Turn off the buzzer
  delay(500);
}

void average() {
  digitalWrite(redLED, LOW);
  digitalWrite(blueLED, HIGH);
  digitalWrite(greenLED, LOW);
  noTone(buzzerPin); // Turn off the buzzer
  delay(500);
}

void high() {
  digitalWrite(redLED, HIGH);
  digitalWrite(blueLED, LOW);
  digitalWrite(greenLED, LOW);
  buzzer();
  delay(500);
  
  
 
}

int convertToNumerical(int voltage, int maxVoltage) {
  int invertedVoltage = maxVoltage - voltage;
  return invertedVoltage;
}
void buzzer(){
   for(int i=0; i<sizeof(freq)/sizeof(freq[0]); i++){
    tone(buzzerPin, freq[i]);
    delay(200);
  }
}
