#include<stdio.h>
#include<string.h>
#include<unistd.h>
int main(int argc, char const *argv[])
{
	char mensaje[100];
	strcpy(mensaje,"Hola Mundo ");
	strcat(mensaje,argv[1]);
	printf("%s\n",mensaje);
	return 0;
}