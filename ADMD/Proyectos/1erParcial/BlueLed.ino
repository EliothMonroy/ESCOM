char data = 0;                // Aqui se almacena lo que llega del bluethood (solo un byte)
int botonEncendido=8;
int botonApagado = 9;
int pinLED = 13;
unsigned long debounce = 500;
unsigned long tiempoActual;
unsigned long lastTiempo;

void setup() {
  Serial.begin(9600);         //Bits por segundo usados en la transmision del bluetooth
  pinMode(pinLED, OUTPUT);        // Indicamos que pinLED sera de salida
  pinMode(botonEncendido, INPUT); // Indicamos que el boton de encendido sera para recibir datos
  pinMode(botonApagado, INPUT); // Indicamos que el boton de apagado sera para recibir datos
}
void loop(){
  // Recuperamos el estado de los dos botones
  int estadoBtnEncendido = digitalRead(botonEncendido);
  int estadoBtnApagado = digitalRead(botonApagado);
  tiempoActual = millis();
  int lastEstado = 1;
  // Checamos si fueron precionados, de serlo se prende o apaga el LED respectivamente
  
  if(estadoBtnEncendido && ((tiempoActual-lastTiempo)> debounce)){
    digitalWrite(pinLED, HIGH); 
    Serial.write("1");
    lastTiempo = tiempoActual;
  }

  if(estadoBtnApagado && ((tiempoActual-lastTiempo)> debounce)){
    digitalWrite(pinLED, LOW);
    Serial.write("0");
    lastTiempo = tiempoActual;
  }
  
  if(Serial.available() > 0)  // Si la conexion serial esta disponible activaremos o no el LED
  {
    data = Serial.read();      //Leemos los datos
    // Lineas de impresion de datos en la consola
    Serial.print(data);
    Serial.print("\n");
    // Si nos llega un 1 encendemos, si llega un cero apagamos
    if(data == '1'){
      digitalWrite(pinLED, HIGH);
    }
    else if(data == '0'){
      digitalWrite(pinLED, LOW);
    }
  }                            
}