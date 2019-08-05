#include"funciones.h"
int main(int argc, char *argv[])
{
    //Leo las cabeceras
    //leerCabeceras(argv);
    //Defino variables
    int i=0;
    //total_muestras=subchunk2size/blockalign;
    //short *muestras=(short *)malloc(total_muestras * sizeof(short));
    //Leo las muestras
    //leerMuestras(muestras);
    calcularFiltro();
    //calcularNuevasMuestras(muestras);
    //Escribo el archivo
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
        if(i<total_muestras){
            fread(&muestra,sizeof(short),1,entrada);
            muestras[i]=muestra;
            i++;
            //printf("Muestra %s: %d\n",i,muestras[i-1]);
        }else{
            fread(&headers,sizeof(short),37,entrada);
            break;
        }
    }
}
void escribirArchivo(short* muestras){
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
        fwrite(&muestras[i],sizeof(short),1,salida);
    }
    //Y por último los headers de goldwave
    for(i=0;i<37;i++){
        fwrite(&headers[i],sizeof(short),1,salida);
    }
}
void calcularFiltro(){
    e=exp(1);//Aquí obtengo el valor de e 
    int i;
    float fc=3000;
    for (i= 0; i < TOTAL_COEFICIENTES; i++)//
    {
        //t=t+(1/44100);
        filtro[i]=(2*fc*PI)*pow(e,((-1)*2*fc*PI*i)/16000);
        suma_filtro+=filtro[i];
        printf("%f\n", filtro[i]);
    }
}
void calcularNuevasMuestras(short* muestras){
    //Algoritmo para la convolución usando Input Side Algorithm
    //int total_muestras_entrada=total_muestras;
    //total_muestras=total_muestras+(TOTAL_COEFICIENTES-1);
    short *nuevas_muestras=(short *)malloc(total_muestras * sizeof(short));
    int i,j;
    //Primero inicializar a cero el arreglo
    for (i = 0; i < total_muestras; i++)
    {
        nuevas_muestras[i]=0;
    }
    //Ahora si el algoritmo
    for (i = 0; i < total_muestras; i++)
    {
        for (j = 0; j < TOTAL_COEFICIENTES; j++)
        {
            nuevas_muestras[i+j]+=(muestras[i]*filtro[j])/suma_filtro;
        }
    }
    //Escribo el archivo
    escribirArchivo(nuevas_muestras);
}