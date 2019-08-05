#include<sys/types.h> /*Servidor de memoria compartida*/
#include<sys/ipc.h>
#include<sys/shm.h>
#include<stdio.h>
#define TAM_MEM 27 /*Tamaño de la memoria compartida en bytes*/
int main(){
	char c;
	int shmid;
	key_t llave;
	char *shm,*s;
	llave=5678;
	if((shmid=shmget(llave,TAM_MEM,IPC_CREAT|0666))<0){
		perror("Error al obtener memoria compartida: shmget");
		exit(-1);
	}
	if((shm=shmat(shmid,NULL,0))==(char*)-1){
		perror("Error al enlazar la memoria compartida: shmat");
		exit(-1);
	}
	s=shm;
	for(c='a';c<='z';c++){
		*s++=c;
	}
	*s='\0';
	while(*shm!='*'){
		sleep(1);
	}
	exit(0);
}