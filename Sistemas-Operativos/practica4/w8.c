#include<stdio.h>
#include<windows.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include<time.h>
int main(int argc, char *argv[])
{
	clock_t t_ini, t_fin;
	double secs;
	t_ini=clock();
	//Estrucutra de información inicial para Windows
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	int i;
	ZeroMemory(&si, sizeof(si));
	si.cb=sizeof(si);
	ZeroMemory(&pi,sizeof(pi));
	//Creación del proceso hijo 1 suma
	if(!CreateProcess(NULL,"suma",NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)){
		printf("Fallo al invocar CreateProcess(%d)\n", GetLastError());
		return;
	}
	//Creación del proceso hijo 2 resta
	if(!CreateProcess(NULL,"resta",NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)){
		printf("Fallo al invocar CreateProcess(%d)\n", GetLastError());
		return;
	}
	//Creación del proceso hijo 3 multiplicacion
	if(!CreateProcess(NULL,"multi",NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)){
		printf("Fallo al invocar CreateProcess(%d)\n", GetLastError());
		return;
	}
	//Creación del proceso hijo 4 transpuesta
	if(!CreateProcess(NULL,"trans",NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)){
		printf("Fallo al invocar CreateProcess(%d)\n", GetLastError());
		return;
	}
	
	//Proceso Padre
	//WaitForSingleObject sirve para ejecutar al hijo primero
	WaitForSingleObject(pi.hProcess,INFINITE);
	//Creación del proceso hijo 5 mostrar
	if(!CreateProcess(NULL,"mostrar",NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)){
		printf("Fallo al invocar CreateProcess(%d)\n", GetLastError());
		return;
	}
	WaitForSingleObject(pi.hProcess,INFINITE);
	//Terminación controlada del proceso e hilo asociado a la ejecución
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
	//Parte final para obtener tiempos de ejecución
	t_fin = clock();
	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
	printf("%.16g milisegundos\n", secs * 1000.0);
}
