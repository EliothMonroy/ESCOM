#ifndef __FUNCIONES_H__
#define __FUNCIONES_H__
    //Librerías de C
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    //Métodos
    void leerCabeceras(char**);
    void leerMuestras(short*);
    void escribirArchivo(short*);
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
    short headers[37];
    //Filtro
    #define PI acos(-1.0)//Defino la constante PI
    #define TOTAL_COEFICIENTES 10
    double filtro[TOTAL_COEFICIENTES];//Arreglo para el filtro
    double suma_filtro;
    double e;
    void calcularFiltro();
    void calcularNuevasMuestras(short*);
#endif