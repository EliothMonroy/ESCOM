#include<sys/stat.h>
#include<stdio.h>
#include<string.h>
#include<fcntl.h>
#include<unistd.h>
#include<stdlib.h>
void imprimir(char archivo[100]);
int main(int argc, char const *argv[])
{
	//Las estructuras a usar
	imprimir("Suma.txt");
	imprimir("Resta.txt");
	imprimir("Multiplicacion.txt");
	imprimir("Transpuesta.txt");
	return 0;
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