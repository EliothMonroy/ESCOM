#include<stdio.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include<time.h>
#include<stdlib.h>
#include<string.h>
#include<sys/wait.h>
#include<pthread.h>
#define TAM 10
void *sumaMatrices(void *arg);
void *restaMatrices(void *arg);
void *multiplicacionMatrices(void *arg);
void *transpuesta(void *arg);
void *hiloImprimir(void *arg);
void transponerMatriz(int matriz[TAM][TAM],int matrizresul[TAM][TAM]);
void imprimirMatriz(char archivo[100],int matriz[TAM][TAM]);
void imprimirMatrizT(int archivo_abierto,int matriz[TAM][TAM]);
void imprimir(char archivo[100]);
int main(int argc, char const *argv[])
{
	clock_t t_ini, t_fin;
	double secs;
	t_ini=clock();
	pthread_t id_hilo[5];
	//Creo un hilo para la suma
	pthread_create(&id_hilo[0],NULL,sumaMatrices,NULL);
	pthread_join(id_hilo[0],NULL);
	//Creo un hilo para la resta
	pthread_create(&id_hilo[1],NULL,restaMatrices,NULL);
	pthread_join(id_hilo[1],NULL);
	//Creo un hilo para la multiplicacion
	pthread_create(&id_hilo[2],NULL,multiplicacionMatrices,NULL);
	pthread_join(id_hilo[2],NULL);
	//Creo un hilo para la transpuesta
	pthread_create(&id_hilo[3],NULL,transpuesta,NULL);
	pthread_join(id_hilo[3],NULL);
	//Creo un hilo para la transpuesta
	pthread_create(&id_hilo[4],NULL,hiloImprimir,NULL);
	pthread_join(id_hilo[4],NULL);
	t_fin = clock();
	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
	printf("%.16g segundos\n", secs * 1000.0);
	return 0;
}
void *sumaMatrices(void *arg){
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
	int i,j=0;
	for(i=0;i<TAM;i++){
		for(j=0;j<TAM;j++){
			matrizresul[i][j]=matriz1[i][j]+matriz2[i][j];
		}
	}
	imprimirMatriz("Suma.txt",matrizresul);
}
void *restaMatrices(void *arg){
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
	int i,j=0;
	for(i=0;i<TAM;i++){
		for(j=0;j<TAM;j++){
			matrizresul[i][j]=matriz1[i][j]-matriz2[i][j];
		}
	}
	imprimirMatriz("Resta.txt",matrizresul);
}
void *multiplicacionMatrices(void *arg){
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
	imprimirMatriz("Multiplicacion.txt",matrizresul);
}
void *transpuesta(void *arg){
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
	transponerMatriz(matriz1,matrizresul);
	struct stat estatus;
	int archivo_abierto=0;
	char archivo[100]="Transpuesta.txt";
	archivo_abierto=open(archivo,O_RDWR|O_CREAT);
	imprimirMatrizT(archivo_abierto,matrizresul);
	transponerMatriz(matriz2,matrizresul);
	imprimirMatrizT(archivo_abierto,matrizresul);
	close(archivo_abierto);
}
void *hiloImprimir(void *arg){
	imprimir("Suma.txt");
	imprimir("Resta.txt");
	imprimir("Multiplicacion.txt");
	imprimir("Transpuesta.txt");
}

void transponerMatriz(int matriz[TAM][TAM],int matrizresul[TAM][TAM]){
	int i,j=0;
	for(i=0;i<TAM;i++){
		for(j=0;j<TAM;j++){
			matrizresul[i][j]=matriz[j][i];
		}
	}
}
void imprimirMatriz(char archivo[100],int matriz[TAM][TAM]){
	struct stat estatus;
	int archivo_abierto=0;
	char contenido[2];
	archivo_abierto=open(archivo,O_RDWR|O_CREAT);
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
void imprimirMatrizT(int archivo_abierto,int matriz[TAM][TAM]){
	//printf("%i\n", archivo_abierto);
	char contenido[2];	
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
}
void imprimir(char archivo[100]){
	struct stat estatus;
	int archivo_abierto=0;
	archivo_abierto=open(archivo,O_RDONLY);
	stat(archivo,&estatus);
	char contenido[estatus.st_size];
	read(archivo_abierto, contenido, estatus.st_size);
	int i=0;
	printf("Contenido de %s:\n", archivo);
	while ((*(contenido + i) != '\0') && i+1 <=estatus.st_size) {
		if(*(contenido +i) > 0){
			printf("%c", *(contenido+i));
			if(*(contenido+i)=='}'){
				puts("");
				break;
			}
		}
		i++;
	}
	close(archivo_abierto);
}