#include<stdio.h>
#include<pthread.h>
//Para compilar esto, es necesario escribir la libreria pthread
//gcc file.c -pthread -o file.out
void *hilo(void *arg);
int main(void)
{
	pthread_t id_hilo;
	pthread_create(&id_hilo,NULL,(void*)hilo,NULL);//El último argumeto de esta funcion son parametros a pasar al hilo
	//Es un arreglo, apuntador o estructura, el (void*)hilo es obtativo, podría ser solo hilo
	pthread_join(id_hilo,NULL);//El segundo argumento cambia si esperamos que el hilo devuelva algún valor al programa principal
	//es sustituido por la variable a la que esperamos que devuelva el valor
	return 0;
}
void *hilo(void *arg){
	printf("Hola mundo desde un hilo en UNIX\n");
	return NULL;
}