#ifndef __FUNCIONES_H__
#define __FUNCIONES_H__

    //Librerías de C
    #include <stdio.h>
    #include <stdlib.h>
    //Métodos
    void leerCabeceras(char**);
    void leerMuestras(short*);
    void dividirMuestras(short*,float);
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
    //Archivos
    FILE* entrada;
    FILE* salida;
    //Variables para muestras
    short muestra;
    int total_muestras;
    short headers[37];

#endif