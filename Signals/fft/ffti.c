#include"funciones.h"
int main(int argc, char *argv[]){
    //Leo las cabeceras
    leerCabeceras(argv);
    //Defino variables    
    total_muestras=subchunk2size/blockalign;
    printf("Total muestras %d\n",total_muestras);
    short *muestrasRe=(short *)malloc(total_muestras * sizeof(short));
    short *muestrasIm=(short *)malloc(total_muestras * sizeof(short));
    //Leo las muestras
    leerMuestras2Canales(muestrasRe,muestrasIm);
    //Calculo la TDF
    calcularFFTI(muestrasRe,muestrasIm);
}
void leerCabeceras(char ** argv){
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
    while (feof(entrada) == 0){
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
void calcularFFTI(short *Re, short *Im){
    //Aquí va el algoritmo para la FFT
    int i;
    float *Xre=(float *)malloc(total_muestras * sizeof(float));
    float *Xim=(float *)malloc(total_muestras * sizeof(float));
    for (i = 0; i < total_muestras; i++){
    	Xre[i]=(float)Re[i]/(float)SHRT_MAX;
    	Xim[i]=(float)Im[i]/(float)SHRT_MAX;
    	//printf("Muestra real: %f\n", Xre[i]);
    	//printf("Muestra imaginaria: %f\n", Xim[i]);
    }
    //Inicio relog
    inicio = clock();
    //FFTI
    int j, k, fk, m, n, ce, c, w;
    float arg, seno, coseno, tempr, tempi;
    //Bit reversal
    m=log((float)total_muestras)/log(2.0);
    j=w=0;
    for (i = 0; i < total_muestras; i++){
        if (j>i){
            SWAP(Xre[i],Xre[j]);
            SWAP(Xim[i],Xim[j]);
        }
        w=total_muestras/2;
        while(w>=2 && j>=w){
            j-=w;
            w>>=1;
        }
        j+=w;
    }
    ce=m;
    c=0;
    //Mariposas
    for (i = 0; i < m; i++) {
        for(j = 0; j < (int)pow(2,ce-1); j++){
            n = (int)pow(2,i);
            for(k = 0; k < n; k++){
                fk=k*(int)pow(2,ce-1);
                coseno=cos(2*PI*fk/total_muestras);
                seno=sin(2*PI*fk/total_muestras);
                tempr=Xre[c+n];
                Xre[c+n]=(Xre[c+n]*coseno) - (Xim[c+n]*seno);
                Xim[c+n]=(Xim[c+n]*coseno) + (tempr*seno);
                tempr=(Xre[c]+Xre[c+n]);
                tempi=(Xim[c]+Xim[c+n]);
                Xre[c+n]=(Xre[c]-Xre[c+n]);
                Xim[c+n]=(Xim[c]-Xim[c+n]);
                Xre[c]=tempr;
                Xim[c]=tempi;
                c++;
            }
            c += n;
        }
        c = 0;
        ce -= 1;
    }
    //Obtener tiempo e imprimir
    final = clock();
    total = (double)(final - inicio) / CLOCKS_PER_SEC;
    printf("Tiempo de ejecucion: %f\n", total);
    short *Reales=(short *)malloc(total_muestras * sizeof(short));
    short *Imaginarias=(short *)malloc(total_muestras * sizeof(short));
    convertirShort(Reales,Imaginarias,Xre,Xim);
    //Escribo el resultado en el archivo
    escribirArchivo(Reales,Imaginarias);
}
void convertirFloat(short *muestras, float *Xre, float *Xim){
    int i;
    for (i = 0; i < total_muestras; i++){
        Xre[i]=(float)muestras[i]/(float)SHRT_MAX;
        Xim[i]=0.0;
    }
}
void convertirShort(short *Reales, short *Imaginarias, float *Xre, float *Xim){
    int i;
    for (i = 0; i < total_muestras; i++){
        Reales[i]=Xre[i]*SHRT_MAX;
        Imaginarias[i]=Xim[i]*SHRT_MAX;
    }
}