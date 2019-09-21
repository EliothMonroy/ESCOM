#include "function.h"

int manejar_fft(int opcion, FILE * archivo){
    if(archivo == NULL){return -1;}

    if(opcion == 1){
        calcular_fft(-1, archivo);
    }
    else if(opcion == 2){
        calcular_fft(1, archivo);
    }
    else{
        printf("%s\n", "Seleccione una opcion valida.");
        exit(3);
    }

    return 0;
}

int calcular_fft(int signo, FILE * archivo){
    iniciar_cabecera(&archivo);
    ajustar_archivo(&archivo);
    calcular_numero_muestras();

    ajustar_exponente();

        FILE * nuevo_archivo;

    float * real = (float *)malloc(potencias_dos_resultado * sizeof(float));
    float * imaginaria = (float *)malloc(potencias_dos_resultado * sizeof(float));

    short aux_conversion = 0;
    float maxValor = 32768;

    int auxiliar_k = 0;
    int divisor = 1;
    int contador = 0;
    int factor_k = 0;
    int contador_exponente = exponente;
    float temp_real = 0;
    float temp_img = 0;

    if(signo < 0){
        divisor = 2;
        int i = 0;
        //FILE * muestras_papu = fopen("ventaneado.wav", "wb");
        for(i = 0; i < numSamples; ++i){
                fread(&aux_conversion, 1, 2, archivo);
                real[i] = (aux_conversion / maxValor);
                imaginaria[i] = 0;
                //aux_conversion = aux_conversion * (0.54 + 0.46 * cos(2*PI*i/numSamples)) ;
                //fwrite(&(aux_conversion), 2, 1, muestras_papu);
        }
        //fclose(muestras_papu);
    }
    else{
        for(i = 0; i < numSamples; ++i){
                fread(&aux_conversion, 1, 2, archivo);
                real[i] = (aux_conversion / maxValor);

                fread(&aux_conversion, 1, 2, archivo);
                imaginaria[i] = (aux_conversion / maxValor);
        }
    }

    reordenar_muestras(&real, &imaginaria);

    for (i = 0; i < exponente; i++) {
        int j;
        for(j = 0; j < (int)pow(2,contador_exponente-1); j++){
            auxiliar_k = (int)pow(2,i);
            int k;
            for(k = 0; k < auxiliar_k; k++){
                factor_k = k * (int)pow(2, contador_exponente - 1);

                temp_real  = real[contador + auxiliar_k];
                real[contador + auxiliar_k] =( (real[contador + auxiliar_k] * cos(signo*2*PI*factor_k / potencias_dos_resultado)) - (imaginaria[contador + auxiliar_k] * sin(signo*2*PI*factor_k / potencias_dos_resultado)) );
                imaginaria[contador + auxiliar_k] = ( (imaginaria[contador + auxiliar_k] * cos(signo*2*PI*factor_k / potencias_dos_resultado)) + (temp_real* sin(signo*2*PI*factor_k / potencias_dos_resultado)) );

                temp_real = (real[contador] + real[contador + auxiliar_k]) / divisor;
                temp_img = (imaginaria[contador] + imaginaria[contador + auxiliar_k]) / divisor;

                real[contador + auxiliar_k] = (real[contador] -real[contador + auxiliar_k]) / divisor;
                imaginaria[contador + auxiliar_k] = (imaginaria[contador] - imaginaria[contador + auxiliar_k]) / divisor;

                real[contador] = temp_real;
                imaginaria[contador] = temp_img;

                contador++;
            }
            contador += auxiliar_k;
        }
        contador = 0;
        contador_exponente -= 1;
    }

    if(signo < 0){
        nuevo_archivo = fopen("fft.wav", "wb");
    }
    else{
        nuevo_archivo = fopen("ffit.wav", "wb");
    }
    if(archivo == NULL){
        printf("%s\n", "No pude abrir el archivo.");
        exit(1);
    }

    numSamples = potencias_dos_resultado;
    iniciar_cabecera_nuevo_archivo(&nuevo_archivo);
    for (i = 0; i < potencias_dos_resultado; i++) {
        real[i] *= 0.99;
        aux_conversion = real[i] * maxValor;
        fwrite(&(aux_conversion), 2, 1, nuevo_archivo);

        imaginaria[i] *= 0.99;
        aux_conversion = imaginaria[i] * maxValor;
        fwrite(&(aux_conversion), 2, 1, nuevo_archivo);
    }

    fclose(archivo);
    fclose(nuevo_archivo);
    return 0;
}

short absoluto(short x){
    if(x < 0){
        x = x * (-1);
    }
    return x;
}

void ajustar_exponente(){
    exponente = 0;
    potencias_dos_resultado = 0;
    exponente = ceil(log(numSamples)/log(2));
    potencias_dos_resultado = pow(2, exponente);
}

void reordenar_muestras(float ** x, float ** y){
    if(x == NULL){return;}
    int j = 0;
    int aux = 0;
    int i;
    for(i = 0; i < potencias_dos_resultado; i++){
        if(j > i){
            intercambiar(x, i, j);
            intercambiar(y, i, j);
        }
        aux = potencias_dos_resultado / 2;
        while(aux >= 2 && j >= aux){
            j -= aux;
            aux >>= 1;
        }
        j += aux;
    }
}

void intercambiar(float ** x, int a, int b){
    if(x == NULL){return;}
    float temp = 0;
    temp = *(x[0] + a);
    *(x[0] + a) = *(x[0] + b);
    *(x[0] + b) = temp;
}

void calcular_numero_muestras(){
    numSamples = (8 * subChunk2Size) / (numChannels * bitsPerSample);
}

void iniciar_cabecera(FILE ** archivo){
    if(archivo == NULL){return;}
    fread(&chunkID, 1, 4, *archivo);
    fread(&chunkSize, 1, 4, *archivo);
    fread(&format, 1, 4, *archivo);
    fread(&subChunk1ID, 1, 4, *archivo);
    fread(&subChunk1Size, 1, 4, *archivo);
    fread(&audioFormat, 1, 2, *archivo);
    fread(&numChannels, 1, 2, *archivo);
    fread(&sampleRate, 1, 4, *archivo);
    fread(&byteRate, 1, 4, *archivo);
    fread(&blockAlign, 1, 2, *archivo);
    fread(&bitsPerSample, 1, 2, *archivo);
    fread(&subChunk2ID, 1, 4, *archivo);
    fread(&subChunk2Size, 1, 4, *archivo);
}

void imprimir_cabecera(){
    printf("chunkID %x\n", chunkID);
    printf("chunkSize %x\n", chunkSize);
    printf("format %x\n", format);
    printf("subChunk1ID %x\n", subChunk1ID);
    printf("subChunk1Size %x\n", subChunk1Size);
    printf("audioFormat %x\n", audioFormat);
    printf("numChannels %x\n", numChannels);
    printf("sampleRate %x\n", sampleRate);
    printf("byteRate %x\n", byteRate);
    printf("blockAlign %x\n", blockAlign);
    printf("bitsPerSample %x\n", bitsPerSample);
    printf("subChunk2ID %x\n", subChunk2ID);
    printf("subChunk2Size %x\n", subChunk2Size);
}

void ajustar_archivo(FILE ** archivo){
    if(archivo == NULL){return;}

    if(subChunk2ID == 1414744396){
        listID = subChunk2ID;
        subChunkList = subChunk2Size;
        subChunk2ID = 0;
        subChunk2Size = 0;
        bandera = 1;

        informacion_extra = (char *)malloc(sizeof(char)*subChunkList*2);
        fread(informacion_extra, 1, subChunkList, *archivo);

        fread(&subChunk2ID, 1, 4, *archivo);
        fread(&subChunk2Size, 1, 4, *archivo);
    }
    else{
        bandera = 0;
    }
}

void iniciar_cabecera_nuevo_archivo(FILE ** archivo){
    if(archivo == NULL){return;}

    numChannels = 2;
    byteRate = (sampleRate * numChannels * bitsPerSample)/8;
    blockAlign = (numChannels * bitsPerSample)/8;
    subChunk2Size = (numSamples * numChannels * bitsPerSample)/8;
    chunkSize = 4 + (8 + subChunk1Size) + (8 + subChunk2Size);

    fwrite(&chunkID, 4, 1, *archivo);
    fwrite(&chunkSize, 4, 1, *archivo);
    fwrite(&format, 4, 1, *archivo);
    fwrite(&subChunk1ID, 4, 1, *archivo);
    fwrite(&subChunk1Size, 4, 1, *archivo);
    fwrite(&audioFormat, 2, 1, *archivo);
    fwrite(&numChannels, 2, 1, *archivo);
    fwrite(&sampleRate, 4, 1, *archivo);
    fwrite(&byteRate, 4, 1, *archivo);
    fwrite(&blockAlign, 2, 1, *archivo);
    fwrite(&bitsPerSample, 2, 1, *archivo);

    if(bandera == 1){
        fwrite(&listID, 4, 1, *archivo);
        fwrite(&subChunkList, 4, 1, *archivo);
        fwrite(informacion_extra, 1, subChunkList, *archivo);
    }

    fwrite(&subChunk2ID, 4, 1, *archivo);
    fwrite(&subChunk2Size, 4, 1, *archivo);
}
