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
    int total_muestras;
    int total_muestras_originales;
    short headers[37];
    //Métodos TDF
    #define PI acos(-1.0)//Defino la constante PI
    void calcularTDF(short*,int);
    void obtenerMensaje(short*);
    int calcularNuevoNumeroMuestras(int);
    float duracion;
    int aux1,aux2;
    int amp=10;
    int aux_conteo=0;
    int bandera=0;
    //Arreglos de frecuencias
    int f_1[2] = {697,1209};
    int f_2[2] = {697,1336};
    int f_3[2] = {697,1477};
    int f_A[2] = {697,1633};
    int f_4[2] = {770,1209};
    int f_5[2] = {770,1336};
    int f_6[2] = {770,1477};
    int f_B[2] = {770,1633};
    int f_7[2] = {852,1209};
    int f_8[2] = {852,1336};
    int f_9[2] = {852,1477};
    int f_C[2] = {852,1633};
    int f_ASTE[2] = {941,1209};
    int f_0[2] = {941,1336};
    int f_GATO[2] = {941,1477};
    int f_D[2] = {941,1633};
#endif