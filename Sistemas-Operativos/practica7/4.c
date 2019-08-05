#include <math.h>
#include <sys/ipc.h>
#include <string.h>
#include <errno.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>

#define FK "/bin/cat"

#define MAX 300

void error(char* error);
void Signal(int sem_id, int numSem);
void Wait(int sem_id, int numSem);
void iniciarSemaforo(int sem_id, int numSem, int valor);
int i, j, l, m, k; //Variables para loops

int main (void) {
  int matriz1 [10][10]={
                  {0,2,0,1,3,3,0,3,2,0},
                  {1,0,3,2,3,0,1,5,4,1},
                  {0,1,0,2,3,3,0,3,2,0},
                  {1,0,0,2,3,3,0,3,2,2},
                  {1,2,3,4,3,0,1,5,4,1},
                  {1,0,2,0,3,3,0,3,5,0},
                  {1,1,3,2,3,0,1,3,0,2},
                  {3,0,5,2,3,3,0,3,2,2},
                  {0,2,2,3,3,6,1,0,5,2},
                  {0,1,2,2,3,3,0,3,2,2}};
  int matriz2 [10][10]={{1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},
                   {1,1,1,1,1,1,1,1,1,1},};

   int KEY[3]={1301,1302,1303};
   int key[3],memc_id[3];
    int *buffer[3];
    for(i=0;i<3;i++){
       key[i] = ftok(FK, KEY[i]);
       if (key[i] == -1) {
          fprintf (stderr, "Error llave %i.\n",i);
          return -1;
       }
       memc_id[i] = shmget (key[i], sizeof(int)*MAX, 0777 | IPC_CREAT);
       if (memc_id[i] == -1) {
          fprintf (stderr, "Error Memoria. %i\n",i);
          return -1;
       }
    
    
       buffer[i] = shmat (memc_id[i], (char *)0, 0);
       if (buffer[i] == NULL) {
          fprintf (stderr, "Error reservando memoria.\n");
          return -1;
       }
   }
  int semaforo1;
  if((semaforo1=semget(IPC_PRIVATE,1,IPC_CREAT | 0700))<0) {
      perror(NULL);
      error("Semaforo: semget.\n");
  }
  iniciarSemaforo(semaforo1,0,1);
  Wait(semaforo1,0);
  printf("Entro el padre, el hijo espera.\n");

  int contador_padre=0;
  for(i=0;i<10;i++){
    for (j=0; j < 10; j++){
       buffer[0][contador_padre] = matriz1[i][j];
       contador_padre++;
    }
  }
  for(k=0;k<10;k++){
    for (l=0; l < 10; l++){
       buffer[0][contador_padre] = matriz2[k][l];
       contador_padre++;
    }
  }
  puts("El padre sale.");
  Signal(semaforo1,0);
  int idproc;
  if((idproc=fork())==0){

    int semaforo2;
    if((semaforo2=semget(IPC_PRIVATE,1,IPC_CREAT | 0700))<0) {
        perror(NULL);
        error("Semaforo: semget\n");
    }
    iniciarSemaforo(semaforo2,0,1);
    Wait(semaforo2,0);
    puts("Entro el hijo, el nieto espera.");

    printf("Soy el hijo\n");
    int matriz1n1 [10][10], matriz2n1 [10][10], mmult [10][10];
    int aux=0;
    for(i=0;i<10;i++){
      for (j=0; j < 10; j++){
           matriz1n1[i][j]=buffer[0][aux];
           aux++;
      }
    }
    for(l=0;l<10;l++){
      for (m=0; m < 10; m++){
           matriz2n1[l][m]=buffer[0][aux];
           aux++;
      }
    }
    for(i=0;i<10;i++){
      for(j=0;j<10;j++){
          mmult[i][j]=matriz1n1[i][j]*matriz2n1[i][j];
      }
    }
    printf("Matriz 1  del hijo:\n");
    for(i=0;i<10;i++){
      for(j=0;j<10;j++){
          printf("%i, ",matriz1n1[i][j]);
          if(j==9){
            printf("\n");
          }
      }
    }
    printf("Matriz 2 del hijo:\n");
    for(i=0;i<10;i++){
      for(j=0;j<10;j++){
          printf("%i, ",matriz2n1[i][j]);
          if(j==9){
            printf("\n");
          }
      }
    }
    int contador_hijo_padre=0;
    for(i=0;i<10;i++){
      for (j=0;j<10;j++){
         buffer[0][contador_hijo_padre] = mmult[i][j];
         contador_hijo_padre++;
      }
    }
    int matriz1buffer [10][10]={
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},
                       {0,0,0,0,0,0,0,0,0,0},};
    //matriz 2
    int matriz2buffer [10][10]={
                        {0,2,0,1,3,3,0,3,2,0},
                        {1,0,3,2,3,0,1,5,4,1},
                        {0,1,0,2,3,3,0,3,2,0},
                        {1,0,0,2,3,3,0,3,2,2},
                        {1,2,3,4,3,0,1,5,4,1},
                        {1,0,2,0,3,3,0,3,5,0},
                        {1,1,3,2,3,0,1,3,0,2},
                        {3,0,5,2,3,3,0,3,2,2},
                        {0,2,2,3,3,6,1,0,5,2},
                        {0,1,2,2,3,3,0,3,2,2}};
    int contador_hijo=0;
    for(i=0;i<10;i++){
        for (j=0; j < 10; j++){
            buffer[1][contador_hijo] = matriz1buffer[i][j];
            contador_hijo++;
        }
    }

    for(k=0;k<10;k++){
        for (l=0; l < 10; l++){
             buffer[1][contador_hijo] = matriz2buffer[k][l];
             contador_hijo++;
        }
    }
    puts("El hijo sale.");
    Signal(semaforo1,0);
    if((idproc=fork())==0){
      printf("Soy el nieto\n");
      int matriz1n1 [10][10], matriz2n1 [10][10], msuma [10][10];
      int aux=0;
      for(i=0;i<10;i++){
        for (j=0; j < 10; j++){
             matriz1n1[i][j]=buffer[1][aux];
             aux++;
        }
      }
      for(l=0;l<10;l++){
        for (m=0; m < 10; m++){
             matriz2n1[l][m]=buffer[1][aux];
             aux++;
        }
      }
      for(i=0;i<10;i++){
        for(j=0;j<10;j++){
            msuma[i][j]=matriz1n1[i][j]+matriz2n1[i][j];
        }
      }
      printf("Matriz 1 de nieto:\n");
      for(i=0;i<10;i++){
        for(j=0;j<10;j++){
            printf("%i, ",matriz1n1[i][j]);
            if(j==9){
              printf("\n");
            }
        }
      }
      printf("Matriz 2 de nieto:\n");
      for(i=0;i<10;i++){
        for(j=0;j<10;j++){
            printf("%i, ",matriz2n1[i][j]);
            if(j==9){
              printf("\n");
            }
        }
      }
      int contador_nieto_padre=0;
      for(i=0;i<10;i++){
        for (j=0; j < 10; j++){
           buffer[2][contador_nieto_padre] = msuma[i][j];
           contador_nieto_padre++;
        }
      }
      exit(0);
    }
    exit(0);
  }
  printf("Soy el Padre.\n");
  int p1matriz1 [10][10], p1matriz2 [10][10];
  int contador_padre1,contador_padre2;
  for(i=0;i<10;i++){
    for (j=0; j < 10; j++){
         p1matriz1[i][j]=buffer[2][contador_padre1];
         contador_padre1++;
    }
  }
  printf("Resultado Suma de nieto:\n");
  for(i=0;i<10;i++){
    for(j=0;j<10;j++){
        printf("%i, ",p1matriz1[i][j]);
        if(j==9){
          printf("\n");
        }
    }
  }
  for(i=0;i<10;i++){
    for (j=0; j < 10; j++){
         p1matriz2[i][j]=buffer[0][contador_padre2];
         contador_padre2++;
    }
  }
  printf("Resultado Multiplicacion de Hijo:\n");
  for(i=0;i<10;i++){
    for(j=0;j<10;j++){
        printf("%i, ",p1matriz2[i][j]);
        if(j==9){
          printf("\n");
        }
    }
  }

  float a[25][25],b[25][25];
  for(i=0;i<10;i++){
    for(j=0;j<10;j++){
        a[i][j]=(float)p1matriz1[i][j];
    }
  }
  for(i=0;i<10;i++){
    for(j=0;j<10;j++){
        b[i][j]=(float)p1matriz2[i][j];
    }
  }
  return 0;
}
void error(char* error) {
    fprintf(stderr,"%s",error);
    exit(1);
}
void Signal(int sem_id, int numSem) {
    struct sembuf sops; 
    sops.sem_num = numSem;
    sops.sem_op = 1;
    sops.sem_flg = 0;

    if (semop(sem_id, &sops, 1) == -1) {
        perror(NULL);
        error("Error Signal");
    }
}
void Wait(int sem_id, int numSem) {
    struct sembuf sops;
    sops.sem_num = numSem; 
    sops.sem_op = -1;
    sops.sem_flg = 0;

    if (semop(sem_id, &sops, 1) == -1) {
        perror(NULL);
        error("Error Wait");
    }
}
void iniciarSemaforo(int sem_id, int numSem, int valor) {

    if (semctl(sem_id, numSem, SETVAL, valor) < 0) {
    perror(NULL);
        error("Error iniciando semaforo");
    }
}
void CreaArchivo(int matriz1[10][10],char *fn){
  int fd;
  char int2Str[1];
  char aux[10];
  char c;
  if ((fd = creat(fn, S_IRUSR | S_IWUSR)) < 0){
    perror("creat() error");
  }
  else {
    for (i=0;i<10;i++) {
        *aux='0';
        *int2Str='0';
        for(j=0;j<10;j++){
          c=matriz1[i][j]+'0';
          sprintf(int2Str,"%c",c);
          write(fd,int2Str,sizeof(int2Str));
        }
    }
        close(fd);
  }
}
void LeeArchivo(char *cadena){
  int fd;
  char c;

  fd = open(cadena,O_RDONLY);
  if(fd!=-1)
    {
      i=0;
      while(read(fd,&c,sizeof(c)!=0)){
        if(i==90||i==80||i==70||i==60||i==50||i==40||i==30||i==20||i==10||i==100){
          printf("\n");
        }
        printf("%c ",c);
        i++;
    }
      close(fd);
    }
  else{
    printf("\nEl archivo no existe.\n");
  }
}