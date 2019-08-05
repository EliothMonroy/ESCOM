#include<stdio.h>
#include<unistd.h>
#include<string.h>
#define VALOR 1
int main(void){
	int desc_arch[2];
	char buffer[100];
	if(pipe(desc_arch)!=0){
		exit(1);
	}
	if(fork()==0){
		while(VALOR){
			read(desc_arch[0],buffer,sizeof(buffer));
			printf("Se recibio: %s\n", buffer);
		}
	}
	while(VALOR){
		gets(buffer);
		write(desc_arch[1],buffer,strlen(buffer)+1);
	}
}