//Librerias a usar
//Links revisados:
//http://pubs.opengroup.org/onlinepubs/009695399/functions/opendir.html
//http://pubs.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html
//http://pubs.opengroup.org/onlinepubs/009695399/functions/stat.html
#include <sys/stat.h>
#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
int main(int argc, char const *argv[])
{
    //Las estructuras a usar
    struct stat estatus;
    int archivo_abierto=0;
    char archivo[100];
    printf("Ingrese el nombre del archivo para mostrar su contenido\n");
    scanf("%s",&archivo);
    archivo_abierto=open(archivo,O_RDONLY);
    stat(archivo,&estatus);
    char contenido[estatus.st_size];
    read(archivo_abierto, contenido, estatus.st_size);
    int i=0;
    printf("Contenido de %s:\n", archivo);
    while (((contenido + i) != '\0') && i+1 <=estatus.st_size) {
		if((contenido +i) > 0)
			printf("%c", *(contenido +i));
		i++;
	}
	close(archivo_abierto);
    return 0;
}