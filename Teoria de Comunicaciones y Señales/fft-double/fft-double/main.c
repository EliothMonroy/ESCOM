#include "function.h"

int main(int num_args, char ** args){
    if(num_args < 3){
        printf("%s\n", "No hay sufucientes parametros.");
        exit(1);
    }

    clock_t inicio, final;
    double total;

    inicio = clock();

    FILE * archivo = fopen(args[2], "rb");
    if(archivo == NULL){
        printf("%s\n", "Hubo un problema con la lectura del archivo.");
        exit(2);
    }

    int opcion = atoi(args[1]);

    manejar_fft(opcion, archivo);

    final = clock();
    total = (double)(final - inicio) / CLOCKS_PER_SEC;
    printf("Tiempo empleado: %f\n", total);

    return 0;
}
