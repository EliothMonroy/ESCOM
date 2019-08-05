#include<stdio.h>
#include<windows.h>
DWORD WINAPI funcionHilo(LPVOID lpParam);//WINAPI no es un tipo de dato es una convención
typedef struct Informacion info;
struct Informacion
{
	int val_1;
	int val_2;
};
int main(void)
{
	DWORD idHilo; //Idenfiticador del Hilo long unsigned
	HANDLE manHilo; //Manejador del hilo
	info argumentos;
	argumentos.val_1=10;
	argumentos.val_2=100;
	//Creación del hilo
	manHilo=CreateThread(NULL,0,funcionHilo,&argumentos,0,&idHilo);
	//Espera la finalización del hilo
	WaitForSingleObject(manHilo,INFINITE);
	printf("Valores al salir del Hilo: val_1=%i y val_2=%i\n",argumentos.val_1,argumentos.val_2);
	printf("%lu\n", idHilo);
	//Cierre del manejador del hilo creado
	CloseHandle(manHilo);
	return 0;
}
DWORD WINAPI funcionHilo(LPVOID lpParam){
	info *datos=(info*)lpParam;
	printf("Valores al entrar al hilo: val_1=%i y val_2=%i\n",datos->val_1,datos->val_2);
	datos->val_1*=2;
	datos->val_2*=2;
	return 0;
}