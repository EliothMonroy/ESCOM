#include"funciones.h"
int main(int argc, char *argv[]){
    //Leo las cabeceras
    leerCabeceras(argv);
    //Defino variables
    total_muestras_originales=subchunk2size/blockalign;
    printf("Total muestras originales:%d\n",total_muestras_originales);
    //Necesitamos que el total de muestras sea una potencia de 2
    total_muestras=calcularNuevoNumeroMuestras(total_muestras_originales);
    printf("Nuevo total de muestras:%d\n", total_muestras);
    short *muestras=(short *)malloc(total_muestras * sizeof(short));
    //Leo las muestras
    int t=256;
    leerMuestras(muestras);
    short *aux_muestras=(short *)malloc(t * sizeof(short));
    int i;
    int j;
    for (i = 0; i < total_muestras/t; i++){
        for(j=0;j<t;j++){
            aux_muestras[j]=muestras[aux_conteo];
            aux_conteo+=1;
        }
        calcularFFT(aux_muestras,t);
    }
}
void leerCabeceras(char ** argv){
    entrada = fopen(argv[1], "rb");
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
    while (feof(entrada) == 0){
        if(i<total_muestras_originales){
            fread(&muestra,sizeof(short),1,entrada);
            muestras[i]=muestra;
            i++;
        }else{
            hayheaders=1;
            fread(&headers,sizeof(short),37,entrada);
            break;
        }
    }
    //Ajuste por si las muestras originales no fueron potencia de dos
    if(total_muestras_originales<total_muestras){
        for (i = total_muestras_originales; i < total_muestras; i++){
            muestras[i]=0;
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
    if(hayheaders){
        for(i=0;i<37;i++){
            fwrite(&headers[i],sizeof(short),1,salida);
        }
    }
    fclose(salida);
}
void calcularFFT(short *muestras_recibidas, int total_muestras_recibidas){
    //Aquí va el algoritmo para la FFT
    float *Xre=(float *)malloc(total_muestras_recibidas * sizeof(float));
    float *Xim=(float *)malloc(total_muestras_recibidas * sizeof(float));
    int i;
    //Convierto las muestras de short a float
    convertirFloat(muestras_recibidas, Xre, Xim,total_muestras_recibidas);
    //FFT
    int j, k, fk, m, n, ce, c, w;
    float arg, seno, coseno, tempr, tempi;
    //Bit reversal
    m=log((float)total_muestras_recibidas)/log(2.0);
    j=w=0;
    for (i = 0; i < total_muestras_recibidas; i++){
        if (j>i){
            SWAP(Xre[i],Xre[j]);
            SWAP(Xim[i],Xim[j]);
        }
        w=total_muestras_recibidas/2;
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
                coseno=cos((-1)*2*PI*fk/total_muestras_recibidas);
                seno=sin((-1)*2*PI*fk/total_muestras_recibidas);
                tempr=Xre[c+n];
                Xre[c+n]=(Xre[c+n]*coseno) - (Xim[c+n]*seno);
                Xim[c+n]=(Xim[c+n]*coseno) + (tempr*seno);
                tempr=(Xre[c]+Xre[c+n])/2;
                tempi=(Xim[c]+Xim[c+n])/2;
                Xre[c+n]=(Xre[c]-Xre[c+n])/2;
                Xim[c+n]=(Xim[c]-Xim[c+n])/2;
                Xre[c]=tempr;
                Xim[c]=tempi;
                c++;
            }
            c += n;
        }
        c = 0;
        ce -= 1;
    }
    short *Reales=(short *)malloc(total_muestras_recibidas * sizeof(short));
    short *Imaginarias=(short *)malloc(total_muestras_recibidas * sizeof(short));
    //Regreso las muestras calculadas a short
    convertirShort(Reales,Imaginarias,Xre,Xim,total_muestras_recibidas);
    obtenerNota(Reales,total_muestras_recibidas);
}
int calcularNuevoNumeroMuestras(int total){
    if ((total & (total-1))==0){
        puts("Ya es potencia de 2");
    }else{
        puts("No es potencia de 2");
        int i;
        i=(int)ceil((float)log(total_muestras_originales)/(float)log(2));
        printf("i:%d\n", i);
        total=pow(2,i);
    }
    return total;
}
void convertirFloat(short *muestras, float *Xre, float *Xim, int total_muestras_recibidas){
    int i;
    for (i = 0; i < total_muestras_recibidas; i++){
        Xre[i]=(float)muestras[i]/(float)(SHRT_MAX);
        Xim[i]=0.0;
        //printf("Muestra Xre: %f\n", Xre[i]);
        //printf("Muestra Xim: %f\n", Xim[i]);
    }
}
void convertirShort(short *Reales, short *Imaginarias, float *Xre, float *Xim, int total_muestras_recibidas){
    int i;
    for (i = 0; i < total_muestras_recibidas; i++){
        Reales[i]=Xre[i]*(SHRT_MAX);
        Imaginarias[i]=Xim[i]*(SHRT_MAX);
    }
}
void obtenerNota(short *Xre,int muestras_recibidas){
    //Obtengo la duración del archivo
    duracion=(float)muestras_recibidas/(float)samplerate;
    //printf("Duracion del archivo: %f\n", duracion);
    int i;
    for(i=0;i<muestras_recibidas/2;i++){
        if(Xre[i]>amp)
            printf("Xre[%d] = %d\n", i, Xre[i]);
    }
    //Aquí reviso que notas fueron identificadas
    esDo3(Xre);
    esDoG3(Xre);
    esRe3(Xre);
    esReG3(Xre);
    esMi3(Xre);
    esFa3(Xre);
    esFaG3(Xre);
    esSol3(Xre);
    esSolG3(Xre);
    esLa3(Xre);
    esLaG3(Xre);
    esSi3(Xre);
    esDo4(Xre);
    esDoG4(Xre);
    esRe4(Xre);
    esReG4(Xre);
    esMi4(Xre);
    esFa4(Xre);
    esFaG4(Xre);
    esSol4(Xre);
    esSolG4(Xre);
    esLa4(Xre);
    esLaG4(Xre);
    esSi4(Xre);
    esDo5(Xre);
    esDoG5(Xre);
    esRe5(Xre);
    esReG5(Xre);
    esMi5(Xre);
    esFa5(Xre);
    esFaG5(Xre);
    esSol5(Xre);
    esSolG5(Xre);
    esLa5(Xre);
    esLaG5(Xre);
    esSi5(Xre);
}
void esDo3(short *Xre){
    aux1=round((float)f_do[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un do3");
        bandera=1;
    }
}
void esDoG3(short *Xre){
    aux1=round((float)f_doG[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un do#3");
        bandera=1;
    }
}
void esRe3(short *Xre){
    aux1=round((float)f_re[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un re3");
        bandera=1;
    }
}
void esReG3(short *Xre){
    aux1=round((float)f_reG[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un re#3");
        bandera=1;
    }
}
void esMi3(short *Xre){
    aux1=round((float)f_mi[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un mi3");
        bandera=1;
    }
}
void esFa3(short *Xre){
    aux1=round((float)f_fa[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un fa3");
        bandera=1;
    }
}
void esFaG3(short *Xre){
    aux1=round((float)f_faG[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un fa#3");
        bandera=1;
    }
}
void esSol3(short *Xre){
    aux1=round((float)f_sol[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un sol3");
        bandera=1;
    }
}
void esSolG3(short *Xre){
    aux1=round((float)f_solG[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un sol#3");
        bandera=1;
    }
}
void esLa3(short *Xre){
    aux1=round((float)f_la[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un la3");
        bandera=1;
    }
}
void esLaG3(short *Xre){
    aux1=round((float)f_laG[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un la#3");
        bandera=1;
    }
}
void esSi3(short *Xre){
    aux1=round((float)f_si[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un si3");
        bandera=1;
    }
}
void esDo4(short *Xre){
    aux1=round((float)f_do[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un do4");
        bandera=1;
    }
}
void esDoG4(short *Xre){
    aux1=round((float)f_doG[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un do#4");
        bandera=1;
    }
}
void esRe4(short *Xre){
    aux1=round((float)f_re[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un re4");
        bandera=1;
    }
}
void esReG4(short *Xre){
    aux1=round((float)f_re[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un re#4");
        bandera=1;
    }
}
void esMi4(short *Xre){
    aux1=round((float)f_mi[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un mi4");
        bandera=1;
    }
}
void esFa4(short *Xre){
    aux1=round((float)f_fa[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un fa4");
        bandera=1;
    }
}
void esFaG4(short *Xre){
    aux1=round((float)f_faG[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un fa#4");
        bandera=1;
    }
}
void esSol4(short *Xre){
    aux1=round((float)f_sol[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un sol4");
        bandera=1;
    }
}
void esSolG4(short *Xre){
    aux1=round((float)f_solG[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un sol#4");
        bandera=1;
    }
}
void esLa4(short *Xre){
    aux1=round((float)f_la[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un la4");
        bandera=1;
    }
}
void esLaG4(short *Xre){
    aux1=round((float)f_laG[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un la#4");
        bandera=1;
    }
}
void esSi4(short *Xre){
    aux1=round((float)f_si[1]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un si4");
        bandera=1;
    }
}
void esDo5(short *Xre){
    aux1=round((float)f_do[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un do5");
        bandera=1;
    }
}
void esDoG5(short *Xre){
    aux1=round((float)f_doG[0]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un do#5");
        bandera=1;
    }
}
void esRe5(short *Xre){
    aux1=round((float)f_re[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un re5");
        bandera=1;
    }
}
void esReG5(short *Xre){
    aux1=round((float)f_reG[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un re#5");
        bandera=1;
    }
}
void esMi5(short *Xre){
    aux1=round((float)f_mi[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un mi5");
        bandera=1;
    }
}
void esFa5(short *Xre){
    aux1=round((float)f_fa[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un fa5");
        bandera=1;
    }
}
void esFaG5(short *Xre){
    aux1=round((float)f_faG[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un fa#5");
        bandera=1;
    }
}
void esSol5(short *Xre){
    aux1=round((float)f_sol[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un sol5");
        bandera=1;
    }
}
void esSolG5(short *Xre){
    aux1=round((float)f_solG[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un sol#5");
        bandera=1;
    }
}
void esLa5(short *Xre){
    aux1=round((float)f_la[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un la5");
        bandera=1;
    }
}
void esLaG5(short *Xre){
    aux1=round((float)f_laG[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un la#5");
        bandera=1;
    }
}
void esSi5(short *Xre){
    aux1=round((float)f_si[2]*duracion);
    if(Xre[aux1]>amp || Xre[aux1+1]>amp){
        puts("La nota corresponde a un si5");
        bandera=1;
    }
}