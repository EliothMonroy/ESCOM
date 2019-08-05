#include<stdio.h>
//#include<windows.h>
#include<stdlib.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<string.h>
#include<unistd.h>
#define TAM 10
void multiplicacionMatrices(int matriz1[TAM][TAM], int matriz2[TAM][TAM], int matrizresul[TAM][TAM]);
void imprimirMatriz(int matriz[TAM][TAM]);
//int array[fila][columna];
//info:http://www.ditutor.com/matrices/multiplicacion_matrices.html
int main(void)
{
	int matriz1[TAM][TAM]={
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1},
		{10,9,8,7,6,5,4,3,2,1}
	};
	int matriz2[TAM][TAM]={
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10},
		{1,2,3,4,5,6,7,8,9,10}
	};
	int matrizresul[TAM][TAM];
	multiplicacionMatrices(matriz1,matriz2,matrizresul);
	imprimirMatriz(matrizresul);
	exit(0);
}
void multiplicacionMatrices(int matriz1[TAM][TAM], int matriz2[TAM][TAM], int matrizresul[TAM][TAM]){
	int i,j,k=0;
	for(i=0;i<TAM;i++){
		for(j=0;j<TAM;j++){
			//Hago cero el valor del array porque si no no sale, quien sabe en que inicializa el valor
			matrizresul[i][j]=0;
			for(k=0;k<10;k++){
				matrizresul[i][j]+=matriz1[i][k]*matriz2[k][j];
			}
		}
	}
}
void imprimirMatriz(int matriz[TAM][TAM]){
	struct stat estatus;
	int archivo_abierto=0;
	char archivo[100]="Multiplicacion.txt";
	char contenido[2];
	archivo_abierto=open(archivo,O_RDWR|O_CREAT|O_TRUNC|O_APPEND);
	write(archivo_abierto, "{\n", strlen("{\n"));
	//puts("{");
	int i,j=0;
	for(i=0;i<TAM;i++){
		for(j=0;j<TAM;j++){
			sprintf(contenido, "%i", matriz[i][j]);
			write(archivo_abierto, contenido, strlen(contenido));
			//printf("%i", matriz[i][j]);
			if(i==9 && j==9){
			}else{
				//printf(",");
				write(archivo_abierto, ",", strlen(","));
			}
		}
		write(archivo_abierto, "\n", strlen("\n"));
		//puts("\n");
	}
	//puts("}");
	write(archivo_abierto, "}\n", strlen("}\n"));
	close(archivo_abierto);
}