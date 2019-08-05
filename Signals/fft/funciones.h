#ifndef __FUNCIONES_H__
#define __FUNCIONES_H__
    //Librerías de C
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    //Librería que contiene los máximos y mínimos de los diferentes tipos de datos en c
    #include <limits.h>
    //Libreria para conocer tiempo de ejecución
    #include <time.h>
    //Metodos
    void leerCabeceras(char**);
    void escribirArchivo(short*,short*);
    void leerMuestras(short*);
    void leerMuestras2Canales(short*,short*);
    void convertirFloat(short*,float*,float*);
    void convertirShort(short*,short*,float*,float*);
    //Cabeceras
    int chunkid;
    int chunksize;
    int format;
    int subchunk1id;
    int subchunk1size;
    short audioformat;
    short numchannels;
    int samplerate;
    int byterate;
    short blockalign;
    short bitspersample;
    int subchunk2id;
    int subchunk2size;
    //Archivo
    FILE* entrada;
    FILE* salida;
    //Variables para muestras
    short muestra;
    int total_muestras_originales;
    int total_muestras;
    short headers[37];
    //Métodos TDF
    #define PI acos(-1.0)//Defino la constante PI
    void calcularFFT(short*);
    void calcularFFTI(short*,short*);
    int calcularNuevoNumeroMuestras(int);
    void intercambiar(float**,int,int);
    //Inversión de bits
    #define SWAP(x,y) do {typeof(x) _x = x;typeof(y) _y = y;x = _y;y = _x;} while(0)
    //Variables para obtener tiempo de ejecución
    clock_t inicio, final;
    double total;
#endif