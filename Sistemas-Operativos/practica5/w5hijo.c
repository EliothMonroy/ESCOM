#include<stdio.h>
#include<windows.h>
DWORD WINAPI hilos1(LPVOID lpParam);//WINAPI no es un tipo de dato es una convención
DWORD WINAPI hilos2(LPVOID lpParam);
DWORD WINAPI imprimir(LPVOID lpParam);
int main(void)
{
	DWORD idHilo[15]; //Idenfiticador del Hilo long unsigned
	HANDLE manHilo[15]; //Manejador del hilo
	int i=0;
	//Creación del hilo
	for(i=0;i<15;i++){
		manHilo[i]=CreateThread(NULL,0,hilos1,NULL,0,&idHilo[i]);
		printf("Hilo del proceso hijo: %lu\n",idHilo[i]);
	}
	//Espera la finalización del hilo
	for(i=0;i<15;i++){
		WaitForSingleObject(manHilo[i],INFINITE);
	}
	//Cierre del manejador del hilo creado
	for(i=0;i<15;i++){
		CloseHandle(manHilo[i]);
	}
	return 0;
}
DWORD WINAPI hilos1(LPVOID lpParam){
	DWORD idHilo[10]; //Idenfiticador del Hilo long unsigned
	HANDLE manHilo[10]; //Manejador del hilo
	int i=0;
	//Creación del hilo
	for(i=0;i<10;i++){
		manHilo[i]=CreateThread(NULL,0,hilos2,NULL,0,&idHilo[i]);
		printf("Hijo de los 15 primeros hilos:%lu\n",idHilo[i]);
	}
	//Espera la finalización del hilo
	for(i=0;i<10;i++){
		WaitForSingleObject(manHilo[i],INFINITE);
	}
	//Cierre del manejador del hilo creado
	for(i=0;i<10;i++){
		CloseHandle(manHilo[i]);
	}
	return 0;
}
DWORD WINAPI hilos2(LPVOID lpParam){
	DWORD idHilo[5]; //Idenfiticador del Hilo long unsigned
	HANDLE manHilo[5]; //Manejador del hilo
	int i=0;
	//Creación del hilo
	for(i=0;i<5;i++){
		manHilo[i]=CreateThread(NULL,0,imprimir,NULL,0,&idHilo[i]);
		printf("Hijo de los 10 segundos hilos:%lu\n",idHilo[i]);
	}
	//Espera la finalización del hilo
	for(i=0;i<5;i++){
		WaitForSingleObject(manHilo[i],INFINITE);
	}
	//Cierre del manejador del hilo creado
	for(i=0;i<5;i++){
		CloseHandle(manHilo[i]);
	}
	return 0;
}
DWORD WINAPI imprimir(LPVOID lpParam){
	printf("Practica 5\n");
	return 0;
}