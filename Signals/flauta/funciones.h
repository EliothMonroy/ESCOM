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
    void convertirFloat(short*,float*,float*,int);
    void convertirShort(short*,short*,float*,float*,int);
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
    int aux_conteo=0;
    int total_muestras_originales;
    int total_muestras;
    int hayheaders=0;
    short headers[37];
    //Métodos TDF
    #define PI acos(-1.0)//Defino la constante PI
    void calcularFFT(short*,int);
    void calcularFFTI(short*,short*);
    int calcularNuevoNumeroMuestras(int);
    void obtenerNota(short*,int);
    //Inversión de bits
    #define SWAP(x,y) do {typeof(x) _x = x;typeof(y) _y = y;x = _y;y = _x;} while(0)
    //Variables para obtener tiempo de ejecución
    clock_t inicio, final;
    double total;
    //Notas
    float duracion;
    int aux1;
    int amp=3000;
    int bandera=0;
    //Arreglos de frecuencias
    int f_do[3] = {262,523,1046};
    int f_doG[3] = {277,554,1108};
    int f_re[3] = {294,587,1174};
    int f_reG[3] = {311,622,1244};
    int f_mi[3] = {330,659,1318};
    int f_fa[3] = {349,698,1396};
    int f_faG[3] = {370,740,1480};
    int f_sol[3] = {392,784,1568};
    int f_solG[3] = {416,831,1662};
    int f_la[3] = {440,880,1760};
    int f_laG[3] = {466,932,1864};
    int f_si[3] = {494,988,1976};
    //Métodos detectar nota
    void esDo3(short*);
    void esDoG3(short*);
    void esRe3(short*);
    void esReG3(short*);
    void esMi3(short*);
    void esFa3(short*);
    void esFaG3(short*);
    void esSol3(short*);
    void esSolG3(short*);
    void esLa3(short*);
    void esLaG3(short*);
    void esSi3(short*);
    void esDo4(short*);
    void esDoG4(short*);
    void esRe4(short*);
    void esReG4(short*);
    void esMi4(short*);
    void esFa4(short*);
    void esFaG4(short*);
    void esSol4(short*);
    void esSolG4(short*);
    void esLa4(short*);
    void esLaG4(short*);
    void esSi4(short*);
    void esDo5(short*);
    void esDoG5(short*);
    void esRe5(short*);
    void esReG5(short*);
    void esMi5(short*);
    void esFa5(short*);
    void esFaG5(short*);
    void esSol5(short*);
    void esSolG5(short*);
    void esLa5(short*);
    void esLaG5(short*);
    void esSi5(short*);
#endif