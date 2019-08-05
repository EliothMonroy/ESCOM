const int pinTemperatura=A5;
const int pinPote=A4;
const int pinHall=A3;
const int pinMotor=2;

float valorTemperatura;
float valorPote;
float valorHall;
float rev=0.0;
long rpm;
int oldtime=0;
int tiempo;
int empiezo=0;
int serial = 0;
char a;
char arreglo[20];
String cadena;
void interrupcion(){
    rev++;
}

void setup(){
   pinMode(pinTemperatura,INPUT);
   pinMode(pinPote,INPUT);
   pinMode(pinHall,INPUT);
   Serial.begin(9600);
   attachInterrupt(digitalPinToInterrupt(pinMotor),interrupcion,FALLING);
   
}
void loop(){
    delay(1000);
    //Motor
    detachInterrupt(digitalPinToInterrupt(pinMotor));//quita interrupción
    tiempo=millis()-oldtime;        //encuentra tiempo
    rpm=(rev/tiempo)*60000/3;         //calcula rpm
    oldtime=millis();             //salvamos nuevo tiempo
    rev=0;

    //Temperatura
    valorTemperatura=analogRead(pinTemperatura);
    valorTemperatura=(5.0*valorTemperatura*100.0)/1023.0;//Fahrenheit
    valorTemperatura=(valorTemperatura-32.0)*(5.0/9.0);

    //Potenciometro
    valorPote=analogRead(pinPote);
    valorPote=(5.0*valorPote)/1023.0;

    //Sensor efecto hall
    valorHall=analogRead(pinHall);
    valorHall=(5.0*valorHall*500.0)/1023.0;
    valorHall=valorHall*53.33-133.33;

    if (Serial.available()){
        cadena=String((int)valorTemperatura)+";"+String(valorPote)+";"+String(valorHall)+";"+String(rpm);
        Serial.println(cadena);
        Serial.flush();
    }
    attachInterrupt(digitalPinToInterrupt(pinMotor),interrupcion,FALLING);
}
