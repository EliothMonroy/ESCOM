#include<stdio.h>
#include<windows.h>
int main(int argc, char *argv[])
{
	//Estrucutra de información inicial para Windows
	STARTUPINFO si;
	PROCESS_INFORMATION pi;
	int i;
	ZeroMemory(&si, sizeof(si));
	si.cb=sizeof(si);
	ZeroMemory(&pi,sizeof(pi));
	if(argc<2){
		printf("El programa actual: %s, espera el nombre de un hijo\n", argv[0]);
		return;
	}
	//Creación del proceso hijo 1
	if(!CreateProcess(NULL,argv[1],NULL,NULL,FALSE,0,NULL,NULL,&si,&pi)){
		printf("Fallo al invocar CreateProcess(%d)\n", GetLastError());
		return;
	}
	//Proceso Padre
	//WaitForSingleObject sirve para ejecutar al hijo primero
	WaitForSingleObject(pi.hProcess,INFINITE);
	//En este caso, el mensaje soy el padre se ejecuta después del hijo
	printf("Soy el proceso Padre\n");
	//WaitForSingleObject(pi.hProcess,INFINITE);
	//Terminación controlada del proceso e hilo asociado a la ejecución
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
}
