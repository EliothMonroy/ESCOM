int pinLED[] = {2,3,4,5,6,7,8,9,10};
int values[] = {1,2,4,8,16,32,64,128,256};

String data;
char dataArray[50];
int value, value2;

void setup() {
  Serial.begin(9600);

  for(int i = 0; i < 9; i++){
    pinMode(pinLED[i], OUTPUT);
    digitalWrite(pinLED[i], HIGH);
    delay(110);
    digitalWrite(pinLED[i], LOW);
  }
}

void loop(){
  if(Serial.available() > 0)  // Si la conexión serial esta disponible activaremos o no el LED
  {
    char buffer[60]=" ";
  
    data = Serial.readString();      //Leemos los datos

    value = data.substring(1).toInt();
    value2 = data.substring(0,1).toInt();

    
    if(value2 > 0){
      digitalWrite(pinLED[4], HIGH);
    }else{
      digitalWrite(pinLED[4], LOW);
    }

    for(int i = 0; i < 9; i++){
      check(value, i, values[i]);
    }

    // Lineas de impresión de datos en la consola
    Serial.print("1 - "+data+" - "+(value2 > 0));
    Serial.print("\n");
    Serial.flush();
  }                            
}

void check(int value, int i, int expected){
  if(i != 4){
    if(value & expected){
    digitalWrite(pinLED[i], HIGH);
  }else{
    digitalWrite(pinLED[i], LOW);
  } 
  }
}
