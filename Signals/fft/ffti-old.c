#include"funciones.h"
int main(int argc, char *argv[])
{
    //Leo las cabeceras
    leerCabeceras(argv);
    //Defino variables    
    total_muestras=subchunk2size/blockalign;
    printf("Total muestras %d",total_muestras);
    short *muestrasRe=(short *)malloc(total_muestras * sizeof(short));
    short *muestrasIm=(short *)malloc(total_muestras * sizeof(short));
    //Leo las muestras
    leerMuestras2Canales(muestrasRe,muestrasIm);
    //Calculo la TDF
    calcularFFTI(muestrasRe,muestrasIm);
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
    	Xre[i]=(float)Re[i];
    	Xim[i]=(float)Im[i];
    	//printf("Muestra real: %f\n", Xre[i]);
    	//printf("Muestra imaginaria: %f\n", Xim[i]);
    }
    //Inicio relog
    inicio = clock();
    //FFT
    int nmax, setp, j, k, j1, m, n;
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
        w=-w;
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
    //short *Reales=(short *)malloc(total_muestras * sizeof(short));
    //short *Imaginarias=(short *)malloc(total_muestras * sizeof(short));
    for (i = 0; i < total_muestras; i++){
    	Xre[i]*=arg;
    	Xim[i]*=arg;
    	Re[i]=(short)Xre[i]*(5.65763109);
    	Im[i]=(short)Xim[i]*(5.65763109);
        //printf("Muestra real: %d\n", Re[i]);
        //printf("Muestra imaginaria: %d\n", Im[i]);
    }
    //Obtener tiempo e imprimir
    final = clock();
    total = (double)(final - inicio) / CLOCKS_PER_SEC;
    printf("Tiempo de ejecucion: %f\n", total);
    //Escribo el resultado en el archivo
    escribirArchivo(Re,Im);
}
