#include<stdio.h>
#include<pthread.h>
void *hilo(void *arg);
int main(void)
{
	pthread_t id_hilo;
	char *mensaje="Hola a todos desde el hilo";
	int devolucion_hilo;
	pthread_create(&id_hilo,NULL,hilo,(void*)mensaje);//El último argumeto de esta funcion son parametros a pasar al hilo
	//Es un arreglo, apuntador o estructura, el (void*)hilo es obtativo, podría ser solo hilo
	pthread_join(id_hilo,(void*)&devolucion_hilo);//El segundo argumento cambia si esperamos que el hilo devuelva algún valor al programa principal
	//es sustituido por la variable a la que esperamos que devuelva el valor
	printf("Valor=%i\n",devolucion_hilo);
	return 0;
}
void *hilo(void *arg){
	char* men;
	int resultado_hilo=0;
	men=(char*)arg;//aquí mensaje ya se volvio arg
	printf("%s\n",men);
	resultado_hilo=100;
	pthread_exit((void*)resultado_hilo);
}