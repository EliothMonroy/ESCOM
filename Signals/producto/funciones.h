#ifndef __FUNCIONES_H__
#define __FUNCIONES_H__
    //Librerías de C
    #include <stdio.h>
    #include <stdlib.h>
    //Librería que contiene los máximos y mínimos de los diferentes tipos de datos en c
    #include <limits.h>
    //Metodos
    void leerCabeceras(char**);
    void leerMuestras(short*,short*);
    void leerMuestras2Canales(short*,short*,short*,short*);
    void escribirArchivo(short*,int);
    void escribirArchivo2Canales(short*,short*,int);
    void calcularProducto(short*,short*);
    void calcularProductoComplejos(short*,short*,short*,short*);
    //Cabeceras primer archivo
    int chunkid1;
    int chunksize1;
    int format1;
    int subchunk1id1;
    int subchunk1size1;
    short audioformat1;
    short numchannels1;
    int samplerate1;
    int byterate1;
    short blockalign1;
    short bitspersample1;
    int subchunk2id1;
    int subchunk2size1;
    //Cabeceras segundo archivo
    int chunkid2;
    int chunksize2;
    int format2;
    int subchunk1id2;
    int subchunk1size2;
    short audioformat2;
    short numchannels2;
    int samplerate2;
    int byterate2;
    short blockalign2;
    short bitspersample2;
    int subchunk2id2;
    int subchunk2size2;
    //Archivo
    FILE* entrada1;
    FILE* entrada2;
    FILE* salida;
    //Variables para muestras primer archivo
    int total_muestras1;
    //Variables segundo archivo
    int total_muestras2;
    //Variables que se pueden reutilizar
    short muestra;
    short headers[37];

#endif