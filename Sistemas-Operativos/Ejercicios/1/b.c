#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
int main(void)
{
	int id_proc;
	char men[100];
	strcpy(men,"Hola");
	if((id_proc=fork())==0){
		strcat(men,"Como");
		if((id_proc=fork())==0){
			strcat(men,"Estas");
			printf("%s\n",men);
		}
		if((id_proc=fork())==0){
			strcat(men,"Hoy");
			printf("%s\n",men);
		}
	}
	strcat(men,"Dia");
	if((id_proc=fork())==0){
		if((id_proc=fork())==0){
			strcat(men,"Otro");
			printf("%s\n",men);
		}
	}
	strcpy(men,"Nuevo");
	if((id_proc=fork())==0){
		strcat(men,"Saludo");
		if((id_proc=fork())==0){
			if((id_proc=fork())==0){
				strcat(men,"Adios");
				printf("%s\n",men);
				exit(0);
			}
			if((id_proc=fork())==0){
				strcat(men,"Terminado");
				printf("%s\n",men);
			}
			if((id_proc=fork())==0){
				strcat(men,"Saliendo");
				printf("%s\n",men);
			}
		}
	}
	strcat(men,"Final");
	printf("%s\n",men);
	exit(0);
}