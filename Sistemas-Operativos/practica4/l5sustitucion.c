#include<stdio.h>
//#include<windows.h>
#include<sys/stat.h>
#include<fcntl.h>
#include<unistd.h>
#include<time.h>
#include<stdlib.h>
#include<sys/wait.h>
int main(int argc, char *argv[])
{
	clock_t t_ini, t_fin;
	double secs;
	t_ini=clock();
	pid_t pid;
	if((pid=fork())==0){
		execv("./suma",argv);
	}else{
		if((pid=fork())==0){
			execv("./resta",argv);
		}else{
			if((pid=fork())==0){
				execv("./multiplicacion",argv);
			}else{
				if((pid=fork())==0){
					execv("./transpuesta",argv);
				}else{
					if((pid=fork())==0){
						execv("./mostrar",argv);
					}
				}
			}
		}
	}
	for(int i=0;i<5;i++){
		wait(NULL);
	}
	//Parte final para obtener tiempos de ejecución
	t_fin = clock();
	secs = (double)(t_fin - t_ini) / CLOCKS_PER_SEC;
	printf("%.16g milisegundos\n", secs * 1000.0);
	exit(0);
}