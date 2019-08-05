//LIBRERAS
#include <stdio.h>
#include <math.h> //Para usar pow()
#include <stdlib.h>	//Para usar exit()
#include <string.h> //Para usar strlen()
#include "TADPilaDin.h" //Inclusión de la libreria del TAD Pila Estática (Si se desea usar una pila estática)

//DEFINICIONES
#define TAM_CADENA 100 //Tamaño maximo de la cadena a evaluar considerando el '\0'

//Estructura para asignar valores de las letras
typedef struct value
{
	float valor;
	char uso;
}value;


//PROGRAMA PRINCIPAL
int main(void)
{
	
	char ecuacion[TAM_CADENA];
	int prioridad[TAM_CADENA],tam_cadena,tam_posfija,i,j=0,k=0,repetida;
	value valores[TAM_CADENA];
	
	//Se declaran unas pila "operador y parentesis"
	pila operador,parentesis;
	
	//Declaro unos elemento "e1->evaluacion parentesis,e2->detectar si es operador,e3->prioridades de operadores y e4->vaciar la pila"
	elemento e1,e2,e3,e4;
	prioridad[0]=-1;
	
	//Leer cadena a evaluar
	scanf("%s",ecuacion);
	
	//Medir el tamaño de la cadena
	tam_cadena=strlen(ecuacion);
	
	//Inicialización de "parentesis"
	Initialize(&parentesis);
	
	//Recorrer cada caracter de la cadena
	for(i=0;i<tam_cadena;i++)
	{
		
		//Si el caracter es ( introducirlo a la pila
		if(ecuacion[i]=='(')
		{
			
				e1.c='(';
				Push(&parentesis,e1);
		}
			
		//Si el caracter es ) realizar un Pop a la pila
		if(ecuacion[i]==')')
		{
				
			//Si se intenta extraer un elemento y la pila es vacia Error: P.g. (a+b)*c)
			if(Empty(&parentesis))
			{
					
				printf("ERROR: Existen mas parentesis que cierran de los que abren\n");
				exit(1); //Salir del programa con error
			}
			e1=Pop(&parentesis);
		}

		//Si el caracter es [ introducirlo a la pila
		if(ecuacion[i]=='[')
		{
			
				e1.c='[';
				Push(&parentesis,e1);
		}
			
		//Si el caracter es ] realizar un Pop a la pila
		if(ecuacion[i]==']')
		{
				
			//Si se intenta extraer un elemento y la pila es vacia Error: P.g. (a+b)*c)
			if(Empty(&parentesis))
			{
					
				printf("ERROR: Existen mas corchetes que cierran de los que abren\n");
				exit(1); //Salir del programa con error
			}
			e1=Pop(&parentesis);
		}

		//Si el caracter es ( introducirlo a la pila
		if(ecuacion[i]=='{')
		{
			
				e1.c='{';
				Push(&parentesis,e1);
		}
			
		//Si el caracter es ) realizar un Pop a la pila
		if(ecuacion[i]=='}')
		{
				
			//Si se intenta extraer un elemento y la pila es vacia Error: P.g. (a+b)*c)
			if(Empty(&parentesis))
			{
					
				printf("ERROR: Existen mas llaves que cierran de los que abren\n");
				exit(1); //Salir del programa con error
			}
			e1=Pop(&parentesis);
		}
	}
	
	//Si al terminar de revisar la expresión aún hay elementos en la pila Error: P.g. (a+b)*c(a-c}
	if(!Empty(&parentesis))
		{
		
			printf("ERROR: Existen mas parentesis que abren de los que cierran\n");
			exit(1); //Salir del programa con error
		}
	
		//Si la ejecución termina de manera correcta
		printf("\n\t\tEXCELENTE: Expresion correcta\n");
		
		//Destruir los elementos de la pila
		Destroy(&parentesis);
}

