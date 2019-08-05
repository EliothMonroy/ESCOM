#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/wait.h>
#include<pthread.h>
void *hilo1(void *arg);
void *hilo2(void *arg);
void *imprimir(void *arg);
int main(int argc, char const *argv[])
{
	pthread_t id_hilo[15];
	int i=0;
	//Creación del hilo
	for(i=0;i<15;i++){
		pthread_create(&id_hilo[i],NULL,hilo1,NULL);
		printf("Hilo del proceso hijo: %lu\n",id_hilo[i]);
	}
	//Espera la finalización del hilo
	for(i=0;i<15;i++){
		pthread_join(id_hilo[i],NULL);
	}
	return 0;
}
void *hilo1(void *arg){
	pthread_t id_hilo[10];
	int i=0;
	//Creación del hilo
	for(i=0;i<10;i++){
		pthread_create(&id_hilo[i],NULL,hilo2,NULL);
		printf("Hijo de los primeros 15 hilos: %lu\n",id_hilo[i]);
	}
	//Espera la finalización del hilo
	for(i=0;i<10;i++){
		pthread_join(id_hilo[i],NULL);
	}
	return 0;
}
void *hilo2(void *arg){
	pthread_t id_hilo[5];
	int i=0;
	//Creación del hilo
	for(i=0;i<5;i++){
		pthread_create(&id_hilo[i],NULL,imprimir,NULL);
		printf("Hijo de los segundos 10 hilos: %lu\n",id_hilo[i]);
	}
	//Espera la finalización del hilo
	for(i=0;i<5;i++){
		pthread_join(id_hilo[i],NULL);
	}
	return 0;
}
void *imprimir(void *arg){
	printf("Practica 5\n");
	return NULL;
}