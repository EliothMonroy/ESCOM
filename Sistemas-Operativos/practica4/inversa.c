#include<stdio.h>
#include<windows.h>
#define TAM 10
void invertirMatriz(int matriz[TAM][TAM],int matrizresul[TAM][TAM]);
void imprimirMatriz(int matriz[TAM][TAM]);
//
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
	int matrizIdentidad[TAM][TAM]={
		{1,0,0,0,0,0,0,0,0,0},
		{0,1,0,0,0,0,0,0,0,0},
		{0,0,1,0,0,0,0,0,0,0},
		{0,0,0,1,0,0,0,0,0,0},
		{0,0,0,0,1,0,0,0,0,0},
		{0,0,0,0,0,1,0,0,0,0},
		{0,0,0,0,0,0,1,0,0,0},
		{0,0,0,0,0,0,0,1,0,0},
		{0,0,0,0,0,0,0,0,1,0},
		{0,0,0,0,0,0,0,0,0,1}
	};
	int matrizresul[TAM][TAM];
	invertirMatriz(matriz1,matrizIdentidad);
	imprimirMatriz(matriz1);
	imprimirMatriz(matrizIdentidad);
	invertirMatriz(matriz2,matrizIdentidad);
	imprimirMatriz(matriz2);
	imprimirMatriz(matrizIdentidad);
	exit(0);
}
void invertirMatriz(int matriz[TAM][TAM],int matrizIdentidad[TAM][TAM]){
	int i,j=0;
	for(i=0;i<TAM;i++){
		for(j=0;j<TAM;j++){
			matrizIdentidad[i][j]=matriz[j][i];
		}
	}
}
void imprimirMatriz(int matriz[TAM][TAM]){
	puts("{");
	int i,j=0;
	for(i=0;i<TAM;i++){
		for(j=0;j<TAM;j++){
			printf("%i", matriz[i][j]);
			printf(",");
		}
		puts("\n");
	}
	puts("}");
}