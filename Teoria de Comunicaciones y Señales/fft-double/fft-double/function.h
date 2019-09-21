#ifndef __FUNCIONES_H__
#define __FUNCIONES_H__

    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    #include <time.h>

    #define E 2.718281828459
    #define PI 3.1415926535

    unsigned int chunkID;
    unsigned int chunkSize;
    unsigned int format;
    unsigned int subChunk1ID;
    unsigned int subChunk1Size;
    unsigned short audioFormat;
    unsigned short numChannels;
    unsigned int sampleRate;
    unsigned int byteRate;
    unsigned short blockAlign;
    unsigned short bitsPerSample;
    unsigned int subChunk2ID;
    unsigned int subChunk2Size;
    unsigned int listID;
    unsigned int subChunkList;
    unsigned int numSamples;
    unsigned long potencias_dos_resultado;
    int exponente;
    int bandera;
    char * informacion_extra;

    int calcular_fft(int, FILE *);
    short absoluto(short);
    void reordenar_muestras(float **, float **);
    void intercambiar(float **, int, int);
    void ajustar_exponente();
    int manejar_fft(int, FILE *);

    void iniciar_cabecera(FILE **);
    void imprimir_cabecera();
    void ajustar_archivo(FILE **);
    void iniciar_cabecera_nuevo_archivo(FILE **);
    void calcular_numero_muestras();

#endif
