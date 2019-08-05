#include"funciones.h"
int main(int argc, char *argv[]){
    //Leo las cabeceras
    leerCabeceras(argv);
    //Defino variables    
    total_muestras=subchunk2size/blockalign;
    //printf("Total Muestras: %d\n", total_muestras);
    short *muestrasRe=(short *)malloc(total_muestras * sizeof(short));
    short *muestrasIm=(short *)malloc(total_muestras * sizeof(short));
    //short muestrasRe[total_muestras],muestrasIm[total_muestras];
    //Leo las muestras
    leerMuestras2Canales(muestrasRe,muestrasIm);
    //Calculo la TDF
    calcularTDFI(muestrasRe,muestrasIm);
}
void leerCabeceras(char ** argv){
    //Primero voy a recordar a leer archivos
    entrada = fopen(argv[1], "rb");
    salida=fopen(argv[2],"wb");
    if(!entrada) {
        perror("\nFile opening failed");
        exit(0);
    }
    fread(&chunkid,sizeof(int),1,entrada);
    fread(&chunksize,sizeof(int),1,entrada);
    fread(&format,sizeof(int),1,entrada);
    fread(&subchunk1id,sizeof(int),1,entrada);
    fread(&subchunk1size,sizeof(int),1,entrada);
    fread(&audioformat,sizeof(short),1,entrada);
    fread(&numchannels,sizeof(short),1,entrada);
    fread(&samplerate,sizeof(int),1,entrada);
    fread(&byterate,sizeof(int),1,entrada);
    fread(&blockalign,sizeof(short),1,entrada);
    fread(&bitspersample,sizeof(short),1,entrada);
    fread(&subchunk2id,sizeof(int),1,entrada);
    fread(&subchunk2size,sizeof(int),1,entrada);
}
void leerMuestras2Canales(short *muestrasRe,short* muestrasIm){
    int i=0;
    while (feof(entrada) == 0)
    {
        if(i<total_muestras){
            fread(&muestrasRe[i],sizeof(short),1,entrada);
            fread(&muestrasIm[i],sizeof(short),1,entrada);
            i++;
            //printf("Muestra %s: %d\n",i,muestras[i-1]);
        }else{
            fread(&headers,sizeof(short),37,entrada);
            break;
        }
    }
}
void escribirArchivo(short* muestrasRe,short* muestrasIm){
    //Escribo el archivo
    fwrite(&chunkid,sizeof(int),1,salida);
    fwrite(&chunksize,sizeof(int),1,salida);
    fwrite(&format,sizeof(int),1,salida);
    fwrite(&subchunk1id,sizeof(int),1,salida);
    fwrite(&subchunk1size,sizeof(int),1,salida);
    fwrite(&audioformat,sizeof(short),1,salida);
    fwrite(&numchannels,sizeof(short),1,salida);
    fwrite(&samplerate,sizeof(int),1,salida);
    fwrite(&byterate,sizeof(int),1,salida);
    fwrite(&blockalign,sizeof(short),1,salida);
    fwrite(&bitspersample,sizeof(short),1,salida);
    fwrite(&subchunk2id,sizeof(int),1,salida);
    fwrite(&subchunk2size,sizeof(int),1,salida);
    //Ahora escribo las muestras
    int i=0;
    for(i=0;i<total_muestras;i++){
        fwrite(&muestrasRe[i],sizeof(short),1,salida);
        fwrite(&muestrasIm[i],sizeof(short),1,salida);
    }
    //Y por último los headers de goldwave
    for(i=0;i<37;i++){
        fwrite(&headers[i],sizeof(short),1,salida);
    }
}
void calcularTDFI(short* muestrasRe,short* muestrasIm){
    //Aquí va el algoritmo para la TDF
    short *Xre=(short *)malloc(total_muestras * sizeof(short));
    short *Xim=(short *)malloc(total_muestras * sizeof(short));
    //Variables para obtener tiempo de ejecución
    clock_t inicio, final;
    double total;
    inicio = clock();
    //Algoritmo TDFI
    int n,k;
    double algo;
    for (k = 0; k < total_muestras; k++)
    {
        Xre[k]=0;
        Xim[k]=0;
        for (n = 0; n < total_muestras; n++)
        {
            //Lo que va dentro del coseno y seno.
            algo=(2*k*n*PI)/(total_muestras);
            //Calculo las partes real e imaginarias
            Xre[k]+=muestrasRe[n]*cos(algo)-muestrasIm[n]*sin(algo);
            Xim[k]+=muestrasRe[n]*sin(algo)+muestrasIm[n]*cos(algo);
        }
    }
    //Obtener tiempo e imprimir
    final = clock();
    total = (double)(final - inicio) / CLOCKS_PER_SEC;
    printf("Tiempo de ejecucion: %f\n", total);
    //La salida seguirá siendo un archivo tipo estereo (2 canales) por lo cual no hay que alinear nada
    escribirArchivo(Xre,Xim);
}