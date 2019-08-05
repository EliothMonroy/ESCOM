#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
int main(void)
{
	int id_proc, x=10, y=20, z=5;
	y*=z;
	if ((id_proc=fork())==0){
		x+=y;
		if((id_proc=fork())==0){
			z*=x;
			printf("z: %i\n", z);
			if((id_proc=fork())==0){
				x*=y;
				printf("x: %i\n", x);
			}
			y-=x;
			printf("y: %i\n", y);
			if((id_proc=fork())==0){
				z*=y;
				printf("z: %i\n", z);
				if((id_proc=fork())==0){
					y-=z;
					printf("y: %i\n", y);
				}
			}
			if((id_proc=fork())==0){
				if((id_proc=fork())==0){
					x+=y;
					printf("x: %i\n", x);
				}
			}
		}
		z*=x;
		if((id_proc=fork())==0){
			y+=z;
			printf("y: %i\n", y);
			exit(0);
		}
		if((id_proc=fork())==0){
			x*=y;
			printf("x: %i\n", x);
		}
	}
	if((id_proc=fork())==0){
		z+=x;
		printf("z: %i\n", z);
	}
	y-=z;
	printf("y: %i\n", y);
	exit(0);
}