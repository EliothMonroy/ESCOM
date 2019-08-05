//Librerias a usar
//Links revisados:
//http://pubs.opengroup.org/onlinepubs/009695399/functions/opendir.html
//http://pubs.opengroup.org/onlinepubs/009695399/basedefs/sys/stat.h.html
//http://pubs.opengroup.org/onlinepubs/009695399/functions/stat.html
#include <sys/stat.h>
#include <dirent.h>
#include <time.h>
#include <stdio.h>
#include <string.h>
int main(int argc, char const *argv[])
{
    //Las estructuras a usar
    struct stat estatus;
    struct dirent *archivo;
    DIR *directorio;
    struct tm *tiempo;
    char dir[10]="./";
    //Abrimos el directorio actual
    directorio=opendir(dir);
    printf("Nombre del archivo\t\tTamano (En Bytes)\tFecha de ultimo acceso\n" );
    //Ciclo que nos permite revisar cada uno de los archivos o directorios
    while((archivo=readdir(directorio))!=NULL){
        //Esta condicional la usamos para evitar que nos aparezcan
        //"." y ".." como archivos
        if(strcmp(archivo->d_name,".") && (strcmp(archivo->d_name,".."))){
            //Primero imprimimos el nombre del archivo
            printf("%s\t\t\t\t", archivo->d_name);
            //Ahora vemos cual es su estatus
            stat(archivo->d_name, &estatus);
            //Por último imprimimos su tamaño y fecha de ultimo acceso
            printf("%ld \t\t\t", estatus.st_size);
            printf("%s\n", ctime(&estatus.st_atime));
        }
    }
    return 0;
}