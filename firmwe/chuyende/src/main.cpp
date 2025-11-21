#include <Arduino.h>
#include "DHT.h"
#include "WiFi.h"
#include <EEPROM.h>

#define DHTPIN 15
#define DHTTYPE DHT11
#define pinbientro 34
#define button1 23 
#define button2 4

// Địa chỉ EEPROM
#define EEPROM_SIZE 64
#define ADDR_BUTTON_STATE 0      // 1 byte
#define ADDR_BUTTON1_STATE 1     // 1 byte
#define ADDR_RAW_MIN 2           // 4 bytes (int)
#define ADDR_RAW_MAX 6           // 4 bytes (int)
#define ADDR_INTERVAL_DHT 10     // 4 bytes (unsigned long)
#define ADDR_INTERVAL_SEND 14    // 4 bytes (unsigned long)
#define ADDR_INIT_FLAG 18        // 1 byte - check đã init chưa

#define EEPROM_INIT_VALUE 0xAB   // Giá trị để check lần đầu khởi động

unsigned long timerDHT = 0;
unsigned long intervalDHT = 1000;
unsigned long timerPot = 0;
unsigned long intervalPot = 200;
unsigned long timerWifi = 0;
unsigned long intervalWifi = 5000; 
unsigned long timerSend = 0;
unsigned long intervalSend = 100;  

volatile bool toggleState = false;
volatile bool toggle1State = false;
volatile unsigned long lastInterruptTime = 0;
volatile unsigned long lastInterruptTime1 = 0; 

float temp = 0;
float hum = 0;
int potValue = 0;
int mappedValue = 0;
String wifiList = "NONE";

bool wifiScanning = false;  

DHT dht(DHTPIN, DHTTYPE);

int buttonState = 0;
int button1State = 0;  
int rawMin = 0; 
int rawMax = 3009;   


void writeIntToEEPROM(int address, int value) {
  EEPROM.write(address, (value >> 24) & 0xFF);
  EEPROM.write(address + 1, (value >> 16) & 0xFF);
  EEPROM.write(address + 2, (value >> 8) & 0xFF);
  EEPROM.write(address + 3, value & 0xFF);
  EEPROM.commit();
}

int readIntFromEEPROM(int address) {
  return ((long)EEPROM.read(address) << 24) |
         ((long)EEPROM.read(address + 1) << 16) |
         ((long)EEPROM.read(address + 2) << 8) |
         (long)EEPROM.read(address + 3);
}

void writeULongToEEPROM(int address, unsigned long value) {
  EEPROM.write(address, (value >> 24) & 0xFF);
  EEPROM.write(address + 1, (value >> 16) & 0xFF);
  EEPROM.write(address + 2, (value >> 8) & 0xFF);
  EEPROM.write(address + 3, value & 0xFF);
  EEPROM.commit();
}

unsigned long readULongFromEEPROM(int address) {
  return ((unsigned long)EEPROM.read(address) << 24) |
         ((unsigned long)EEPROM.read(address + 1) << 16) |
         ((unsigned long)EEPROM.read(address + 2) << 8) |
         (unsigned long)EEPROM.read(address + 3);
}

void saveButtonStates() {
  EEPROM.write(ADDR_BUTTON_STATE, buttonState);
  EEPROM.write(ADDR_BUTTON1_STATE, button1State);
  EEPROM.commit();
}

void loadFromEEPROM() {
  buttonState = EEPROM.read(ADDR_BUTTON_STATE);
  button1State = EEPROM.read(ADDR_BUTTON1_STATE);
  toggleState = (buttonState == 1);
  toggle1State = (button1State == 1);
  
  rawMin = readIntFromEEPROM(ADDR_RAW_MIN);
  rawMax = readIntFromEEPROM(ADDR_RAW_MAX);
  
  intervalDHT = readULongFromEEPROM(ADDR_INTERVAL_DHT);
  intervalSend = readULongFromEEPROM(ADDR_INTERVAL_SEND);
  
  Serial.println("=== Loaded from EEPROM ===");
  Serial.print("Button States: BTN="); Serial.print(buttonState);
  Serial.print(" BTN1="); Serial.println(button1State);
  Serial.print("Calibration: Min="); Serial.print(rawMin);
  Serial.print(" Max="); Serial.println(rawMax);
  Serial.print("Intervals: DHT="); Serial.print(intervalDHT);
  Serial.print("ms Send="); Serial.print(intervalSend); Serial.println("ms");
}

void initEEPROM() {
  
  EEPROM.write(ADDR_BUTTON_STATE, 0);
  EEPROM.write(ADDR_BUTTON1_STATE, 0);
  writeIntToEEPROM(ADDR_RAW_MIN, 0);
  writeIntToEEPROM(ADDR_RAW_MAX, 3009);
  writeULongToEEPROM(ADDR_INTERVAL_DHT, 1000);
  writeULongToEEPROM(ADDR_INTERVAL_SEND, 100);
  EEPROM.write(ADDR_INIT_FLAG, EEPROM_INIT_VALUE);
  EEPROM.commit();
  Serial.println("EEPROM initialized with default values");
}


void IRAM_ATTR buttonISR() {
  unsigned long interruptTime = millis();
  
  if (interruptTime - lastInterruptTime > 200) {
    toggleState = !toggleState;
    buttonState = toggleState ? 1 : 0;
    saveButtonStates();  
  }
  
  lastInterruptTime = interruptTime;
}

void IRAM_ATTR button1ISR() {
  unsigned long interruptTime = millis();
  
  if (interruptTime - lastInterruptTime1 > 200) {
    toggle1State = !toggle1State;
    button1State = toggle1State ? 1 : 0;
    saveButtonStates();  
  }
  
  lastInterruptTime1 = interruptTime;
}


void setup() {
  Serial.begin(115200);
  delay(100);
  

  EEPROM.begin(EEPROM_SIZE);
  
  if (EEPROM.read(ADDR_INIT_FLAG) != EEPROM_INIT_VALUE) {
    Serial.println("First boot detected - initializing EEPROM");
    initEEPROM();
  } else {
    Serial.println("Loading settings from EEPROM");
    loadFromEEPROM();
  }
  
  WiFi.mode(WIFI_STA);
  WiFi.disconnect(true);
  delay(100);
  dht.begin();
  

  pinMode(button1, INPUT_PULLUP);
  pinMode(button2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(button1), buttonISR, FALLING);
  attachInterrupt(digitalPinToInterrupt(button2), button1ISR, FALLING);
  

  WiFi.scanNetworks(true);  
  wifiScanning = true;
  
  Serial.println("System ready!");
}


void loop() {
  unsigned long now = millis();


  if (now - timerDHT >= intervalDHT) {
    hum = dht.readHumidity();
    temp = dht.readTemperature();
    timerDHT = now;
  }


  if (now - timerPot >= intervalPot) {
    int raw = analogRead(pinbientro);
    raw = constrain(raw, rawMin, rawMax);
    mappedValue = map(raw, rawMin, rawMax, 0, 200);
    timerPot = now;
  }


  if (wifiScanning) {
    int n = WiFi.scanComplete();
    if (n >= 0) {  
      wifiList = "";
      if (n == 0) {
        wifiList = "NONE";
      } else {
        int maxNetworks = min(n, 4); 
        for (int i = 0; i < maxNetworks; i++) {
          wifiList += WiFi.SSID(i);
          if (i < maxNetworks - 1) wifiList += "|";
        }
      }
      WiFi.scanDelete(); 
      wifiScanning = false;
      timerWifi = now;
    }
  } else if (now - timerWifi >= intervalWifi) {
    WiFi.scanNetworks(true);
    wifiScanning = true;
  }

 
  if (now - timerSend >= intervalSend) {
    Serial.print("DATA:");
    Serial.print("T=");
    Serial.print(temp, 1); 
    Serial.print(";H=");
    Serial.print(hum, 1);
    Serial.print(";P=");
    Serial.print(mappedValue);
    Serial.print(";BTN=");
    Serial.print(buttonState);
    Serial.print(";BTN1=");
    Serial.print(button1State);
    Serial.print(";W=");
    Serial.print(wifiList);
    Serial.println(";");
    
    timerSend = now;
  }
  
  
}