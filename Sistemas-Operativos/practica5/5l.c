#include<stdio.h>
#include<unistd.h>
#include<stdlib.h>
#include<sys/types.h>
#include<sys/wait.h>
#include<pthread.h>
int main(int argc, char *argv[])
{
	pid_t id_proc;
	id_proc=fork();
	if (id_proc==0){
		//Proceso hijo
		execv("./hijo.out",argv);
	}else{
		wait(0);
		exit(0);
	}
}