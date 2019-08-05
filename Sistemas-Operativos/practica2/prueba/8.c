#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include<string.h>
#include<time.h>
#include<fcntl.h>
int main(int argc, char* argv[]){
	char c[50];
 	strcpy(c,argv[argc-1]);
	strcat(c,"/");
	char cad[][50]={"hola como te llamas",
		"Las llamadas al sistema ",
		"procesador transfiera el",
		"Esto permite al código",
		"privilegiado especifica",
		"donde va a ser conectad",
		"Cuando una llamada ",
		"al sistema es invocada",
		"la ejecución del ",		
		"para poder continuar ejecutándose",
		"El procesador entonces comienza",
		"instrucciones de código de ",
		"para realizar la tarea requerida.",
		"obligatoriamente es inmediato",
		"depende del tiempo de ejecución",
		};
	int i;
	//se calcula la cantidad de archivos
	srand(time(NULL));
	int numero;
	numero= (rand()%15)+1;
	printf("%d",numero);
	
	int ficheros[numero];
	char nombres[][50]={"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16"};
	int j;char ruta[16][50];
	for(j=0;j<16;j++ ){
	strcpy(ruta[j],c);
	
	puts(ruta[j]);
	}
	printf("\n");
	for(i=0;i<numero; i++){
	strcat(ruta[i],nombres[i]);
	ficheros[i]= open(ruta[i],O_CREAT|O_WRONLY,0644);
	

	
		if (ficheros[i]==-1){
		perror("Error al abrir fichero:");
		exit(1);
	   	}
		else{
			printf("\nArchivo generado con exito en ruta: %s",ruta[i]);
		}

	int numero= rand()%15;
	write(ficheros[i], cad[numero], strlen(cad[numero]));
	close(ficheros[i]);
	}
	printf("\n");

}




