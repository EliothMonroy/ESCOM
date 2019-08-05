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
    if(total_muestras_originales<total_muestras){
        for (i = total_muestras_originales; i < total_muestras; i++){
            muestras[i]=0;
            //printf("Muestra[%d]: %d\n", i, muestras[i]);
        }
    }
    fclose(entrada);
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
    fclose(salida);
}
void calcularFFT(short *muestras){
    //Aquí va el algoritmo para la FFT
    float *Xre=(float *)malloc(total_muestras * sizeof(float));
    float *Xim=(float *)malloc(total_muestras * sizeof(float));
    int i;
    for (i = 0; i < total_muestras; i++){
        Xre[i]=(float)muestras[i];
        Xim[i]=0.0;
        //printf("Muestra real: %f\n", Xre[i]);
        //printf("Muestra imaginaria: %f\n", Xim[i]);
    }
    //Convierto las muestras de short a float
    convertirFloat(muestras, Xre, Xim);
    //Iniciar relog
    inicio = clock();
    //FFT
    int j, k, j1, m, n;
    float arg, s, c, w, tempr, tempi;
    //Bit reversal
    m=log((float)total_muestras)/log(2.0);
    for (i = 0; i < total_muestras; i++){
		j=0;
		for (k = 0; k < m; k++){
			j=(j<<1)|(1&(i>>k));
		}
		if (j<i){
			//a=a^b;
			//b=a^b;
			//a=b^a;
			//Xre[i]=Xre[i]^Xre[j];
			//Xre[j]=Xre[i]^Xre[j];
            //Xre[i]=Xre[j]^Xre[i];
            //Xim[i]=Xim[i]^Xim[j];
            //Xim[j]=Xim[i]^Xim[j];
			//Xim[i]=Xim[j]^Xim[i];
			SWAP(Xre[i],Xre[j]);
			SWAP(Xim[i],Xim[j]);
		}
    }
    for (i = 0; i < m; i++){
    	n=w=pow(2.0,(float)i);
    	w=PI/n;
    	k=0;
    	while(k<total_muestras-1){
    		for ( j = 0; j < n; j++){
    			arg=-j*w;
    			c=cos(arg);
    			s=sin(arg);
    			j1=k+j;
    			tempr=Xre[j1+n]*c-Xim[j1+n]*s;
    			tempi=Xim[j1+n]*c+Xre[j1+n]*s;
    			Xre[j1+n]=Xre[j1]-tempr;
    			Xim[j1+n]=Xim[j1]-tempi;
    			Xre[j1]=Xre[j1]+tempr;
    			Xim[j1]=Xim[j1]+tempi;
    		}
    		k+=2*n;
    	}
    }
    arg=1.0/sqrt((float)total_muestras);
    short *Reales=(short *)malloc(total_muestras * sizeof(short));
    short *Imaginarias=(short *)malloc(total_muestras * sizeof(short));
    for (i = 0; i < total_muestras; i++){
    	Xre[i]*=arg;
    	Xim[i]*=arg;
        //Xre[i]*=(.6035);
        //Xim[i]*=(.6035);
        //Reales[i]=(short)Xre[i]*(.6035);
        //Imaginarias[i]=(short)Xim[i]*(.6035);
        //printf("Muestra real: %d\n", Reales[i]);
        //printf("Muestra imaginaria: %d\n", Imaginarias[i]);
        //Reales[i]=(short)Xre[i]*(.6035);
        //Imaginarias[i]=(short)Xim[i]*(.6035);
        /*
        if ((short)Xre[i]*(.6035)>SHRT_MAX){
            Reales[i]=SHRT_MAX;
        }else{
            Reales[i]=(short)Xre[i]*(.6035);
        }
        if((short)Xim[i]*(.6035)>SHRT_MAX){
            Imaginarias[i]=SHRT_MAX;
        }else{
            Imaginarias[i]=(short)Xim[i]*(.6035);
        }
        */
    }
    //Obtener tiempo e imprimir
    final = clock();
    total = (double)(final - inicio) / CLOCKS_PER_SEC;
    printf("Tiempo de ejecucion: %f\n", total);
    //Regreso las muestras calculadas a short
    convertirShort(Reales,Imaginarias,Xre,Xim);
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
        puts("Ya es potencia de 2");
    }else{
        puts("No es potencia de 2");
        int i;
        i=log(total_muestras)/log(2);
        total=pow(2,i);
    }
    return total;
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
        if(((short)(Xre[i]*SHRT_MAX))>SHRT_MAX){
            Reales[i]=SHRT_MAX;
        }else{
            Reales[i]=((short)(Xre[i]*SHRT_MAX))*(.6035);
        }
        if(((short)(Xim[i]*SHRT_MAX))>SHRT_MAX){
            Imaginarias[i]=SHRT_MAX;
        }else{
            Imaginarias[i]=((short)(Xim[i]*SHRT_MAX))*(.6035);
        }
        printf("Muestra real: %d\n", Reales[i]);
        printf("Muestra imaginaria: %d\n", Imaginarias[i]);
    }
}
