#include"funciones.h"
int main(int argc, char *argv[])
{
    //Leo las cabeceras
    leerCabeceras(argv);
    //Defino variables    
    total_muestras_originales=subchunk2size/blockalign;
    printf("Total muestras originales:%d\n",total_muestras_originales);
    //Necesitamos que el total de muestras sea una potencia de 2
    total_muestras=calcularNuevoNumeroMuestras(total_muestras_originales);
    printf("Nuevo total de muestras:%d\n", total_muestras);
    //puts("Voy a crear el arreglo de muestras");
    short *muestras=(short *)malloc(total_muestras * sizeof(short));
    //puts("Ya cree el arreglo de muestras");
    //Leo las muestras
    //puts("Voy a leer las muestras del archivo");
    leerMuestras(muestras);
    //puts("Ya lei las muestras del archivo");
    //Calculo la FFT
    calcularFFT(muestras);
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
void leerMuestras(short *muestras){
    int i=0;
    while (feof(entrada) == 0)
    {
        if(i<total_muestras_originales){
            fread(&muestra,sizeof(short),1,entrada);
            muestras[i]=muestra;
            i++;
            //printf("Muestra %s: %d\n",i,muestras[i-1]);
        }else{
            fread(&headers,sizeof(short),37,entrada);
            break;
        }
    }
    //Ajuste por si las muestras originales no fueron potencia de dos
    for (i = total_muestras_originales; i < total_muestras; i++){
        muestras[i]=0;
        //printf("Muestra[%d]: %d\n", i, muestras[i]);
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
void calcularFFT(short *muestras){
    //Aquí va el algoritmo para la FFT
    short *Xre=(short *)malloc(total_muestras * sizeof(short));
    short *Xim=(short *)malloc(total_muestras * sizeof(short));
    int nh=total_muestras/2;
    int i;
    for (i = 0; i < nh; i++){
        Xre[i]=muestras[i*2];
        Xim[i]=muestras[(2*i)+1];
    }
    int n=total_muestras/2;
    //FFT libro
    int m=log(n)/log(2);
    int j=n/2;
    int tr,ti,k;
    for (i = 1; i < n-1; i++){
        if (i<j){
            tr=Xre[j];
            ti=Xim[j];
            Xre[j]=Xre[i];
            Xim[j]=Xim[i];
            Xre[i]=tr;
            Xim[i]=ti;
        }else{
            k=n/2;
            if (k<=j){
                while(k<=j){
                    j=j+k;
                    k=k/2;
                }
            }else{
                j=j+k;
            }
        }
    }
    int l,le,le2,ur,ui;
    float sr,si;
    for (l = 1; l <= m; l++){
        le=pow(2,l);
        le2=le/2;
        ur=1;
        ui=0;
        sr=cos(PI/le2);
        si=-sin(PI/le2);
        for (j = 1; j <= le2; j++){
            for (i = j-1; i < n; i+=le){
                //1370
            }
        }
    }
    //La salida ahora sera un archivo tipo estereo (2 canales)
    //Por lo cual hay que cambiar el numero de canales del archivo 
    //y todas las demas cabeceras que dependan de esta
    chunksize-=subchunk2size;
    numchannels*=2;
    byterate*=numchannels;
    blockalign*=numchannels;
    subchunk2size=total_muestras*blockalign;
    chunksize+=subchunk2size;
    escribirArchivo(Reales,Imaginarias);
}
int calcularNuevoNumeroMuestras(int total){
    if ((total & (total-1))==0){
        return total;
    }else{
        puts("No es potencia de 2");
        int i;
        for (i = 0; i < 32; i++){
            if(pow(2,i)>total){
                total=pow(2,i);
                break;
            }
        }
        return total;
    }
}
void convertirFloat(short *muestras, float *Xre, float *Xim){
    int i;
    for (i = 0; i < total_muestras; i++){
        Xre[i]=(float)muestras[i]/(float)SHRT_MAX;
        Xim[i]=0.0;
        //printf("Muestra real: %f\n", Xre[i]);
        //printf("Muestra imaginaria: %f\n", Xim[i]);
    }
}
void convertirShort(short *Reales, short *Imaginarias, float *Xre, float *Xim){
    int i;
    for (i = 0; i < total_muestras; i++){
        Reales[i]=Xre[i]*SHRT_MAX;
        Imaginarias[i]=Xim[i]*SHRT_MAX;
        //printf("Muestra real: %d\n", Reales[i]);
        //printf("Muestra imaginaria: %d\n", Imaginarias[i]);
    }
}