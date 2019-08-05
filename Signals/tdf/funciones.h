#ifndef __FUNCIONES_H__
#define __FUNCIONES_H__
    //Librerías de C
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    //Librería que contiene los máximos y mínimos de los diferentes tipos de datos en c
    #include <limits.h>
    //Libreria para conocer tiempo de ejecución
    #include <time.h>
    //Metodos
    void leerCabeceras(char**);
    void escribirArchivo(short*,short*);
    void leerMuestras(short*);
    void leerMuestras2Canales(short*,short*);
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
    int modo;
    //Variables para muestras
    short muestra;
    int total_muestras;
    short headers[37];
    //Métodos TDF
    #define PI acos(-1.0)//Defino la constante PI
    void calcularTDF(short*);
    void calcularTDF1(short*);
    void calcularTDF2(short*);
    void calcularTDF3(short*);
    void calcularTDFI(short*,short*);
#endif