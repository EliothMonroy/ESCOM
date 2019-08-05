//For low power mode
#include <avr/sleep.h>
#include <avr/power.h>
//OLED libraries
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#define OLED_RESET 4
Adafruit_SSD1306 display(OLED_RESET);
//In and Out
int in = 2;
float rev=0.0;
long rpm;
int oldtime=0;
int tiempo;
String cadena;
void interrupcion(){
    rev++;
}

void setup()   {
  attachInterrupt(digitalPinToInterrupt(in),interrupcion,FALLING);                
  Serial.begin(9600);
  pinMode(in,INPUT);
  // by default, we'll generate the high voltage from the 3.3v line internally! (neat!)
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  // initialize with the I2C addr 0x3D (for the 128x64)
  // init done  
  // Clear the buffer.
  display.clearDisplay();

  // text display tests
  display.clearDisplay();
  display.setTextSize(1);
  display.setTextColor(WHITE);
  display.setCursor(0,0);
  display.println("ELECTRONOOBS RPMmeter");
  display.display();
  display.setTextSize(2);
  display.setTextColor(WHITE);
  display.setCursor(0,19);
  display.println("RPM:");
  display.setCursor(80,19);
  display.println(String(rpm));  
  display.display();
}
void loop() {
    //Motor
    detachInterrupt(digitalPinToInterrupt(in));//quita interrupción
    tiempo=millis()-oldtime;        //encuentra tiempo
    rpm=(rev/tiempo)*60000/3;         //calcula rpm
    oldtime=millis();             //salvamos nuevo tiempo
    rev=0;
    // text display tests
    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0,19);
    display.println("RPM:");
    display.setCursor(80,19);
    display.println(String(rpm));  
    display.display();
    
    if (Serial.available()){
      cadena=String(rpm);
      Serial.println(cadena);
      Serial.flush();
    }
    attachInterrupt(digitalPinToInterrupt(in),interrupcion,FALLING);
    delay(100);
}
