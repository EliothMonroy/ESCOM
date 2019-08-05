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

//DEFINICION DE FUNCIONES
void TomaValores(char *cadena, value *val); //Funcion que recibe los valores de las letras
void Evaluar(char *cadena,value *val);      //Funcion que evalua la expresion con los valores asignados

//PROGRAMA PRINCIPAL
int main(void)
{
	
	char posfija[TAM_CADENA],ecuacion[TAM_CADENA];
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
	
		//Inicialización de "operador"
		Initialize(&operador);
		i = 0;
	
		//Recorrer cada caracter de la cadena
		while(i<tam_cadena)
		{
			if(ecuacion[i])
			//Evalua el caracter de la cadena ecuacion en u Switch
			switch(ecuacion[i])
			{
			
				case '(':
			
					e2.c = '(';
					if(Empty(&operador))
					{
				
						Push(&operador,e2);
						prioridad[j]=0;
						i++;
					}
					else
					{
					
						j++;
						Push(&operador,e2);
						prioridad[j]=0;
						i++;
					}
						break;
					
				case ')':
				
					e2.c = ')';
					
					while(prioridad[j]!=0)
					{

						e3 = Pop(&operador);
						posfija[k] = e3.c;
						k++;
						prioridad[j]=-1;
						j--;
					}
					e3 = Pop(&operador);
					if(j!=0){j--;}
				
					i++;
						break;
					
				case '-':
				case '+':
				
					e2.c = ecuacion[i];
				
					if(Empty(&operador))
					{
					
						prioridad[j] = 1;
						Push(&operador,e2);
						i++;
					
					} 
				
					else
					{
					
						while(prioridad[j]>1)
						{
			
							prioridad[j] = -1;
							e3 = Pop(&operador);
							posfija[k] = e3.c;
							k++;
							if(j!=0){j--;}
						}
					
						if(prioridad[j]==1)
						{
					
						e3 = Pop(&operador);
						posfija[k] = e3.c;
						k++;
						Push(&operador,e2);
						i++;
					
						} 
					
						else
						{
				
							j++;
							prioridad[j] = 1;
							Push(&operador,e2);
							i++;
						}
					}
				
							break;
					
				case '*':
				case '/':
			
					e2.c = ecuacion[i];
				
					if(Empty(&operador))
					{
					
						prioridad[j] = 2;
						Push(&operador,e2);
						i++;
					
					}

					else
					{
					
						while(prioridad[j]>2)
						{
					
							prioridad[j] = -1;
							e3 = Pop(&operador);
							posfija[k] = e3.c;
							k++;
							if(j!=0)
							{j--;}							
						}
						
						if(prioridad[j]==2)
						{
						
							e3 = Pop(&operador);
							posfija[k] = e3.c;
							k++;
							Push(&operador,e2);
							i++;
						
						}

						else
						{
						
							j++;
							prioridad[j] = 2;
							Push(&operador,e2);
							i++;
						}
					}
				
							break;
							
				case '^':
				
					e2.c = ecuacion[i];
				
					if(Empty(&operador))
					{
					
						prioridad[j] = 3;
						Push(&operador,e2);
						i++;
						
					} 
				
					else
					{
							
						if(prioridad[j]==3)
						{
						
							e3 = Pop(&operador);
							posfija[k] = e3.c;
							k++;
							Push(&operador,e2);
							i++;
						
						} 
						
						else
						{
						
							j++;
							prioridad[j] = 3;
							Push(&operador,e2);
							i++;
						}
					}
				
						break;
					
				default:
				
					posfija[k]=ecuacion[i];
					k++;
					i++;
			}	
		}
	
		while (Empty(&operador)==FALSE)
		{
		
			e4 = Pop(&operador);
			posfija[k] = e4.c;
			k++;
		}
		posfija[k]='\0';
	
		//Destruir los elementos de la pila
		Destroy(&operador);
		
			i=k;
			printf("\n\t\t\t   ");
			for(k=0;k<i;k++)
			{
				printf("%c",posfija[k]);
			}
			printf("\n\n");
			
		TomaValores(posfija, valores);
		Evaluar(posfija,valores);
		exit(0);
}

void TomaValores(char *cadena, value *val)
{
	int i;
	for(i=0;i<TAM_CADENA;i++)
	{
		val[i].uso='N';
	}
	for(i=0;cadena[i]!='\0';i++)
	{
		if(cadena[i]>='A' && cadena[i]<='Z' && val[cadena[i]-'A'].uso=='N')
		{
			scanf("\t\t%f", &(val[cadena[i]-'A'].valor)); 
			val[cadena[i]-'A'].uso='S';
		}
	}
	printf("\n");
	
	
}


void Evaluar(char *cadena,value *val)
{
  int i,j=0;
  
  //declaración de la pila "resultado"
  pila resultado;
  elemento e5;
  float valor1, valor2;
 
  Initialize(&resultado);
  
  for(i=0;i<cadena[i];i++)
  {
    if(cadena[i]!='^'&& cadena[i]!='*'&&cadena[i]!='/'&&cadena[i]!='+'&&cadena[i]!='-')
    {
			e5.v=val[cadena[i]-'A'].valor;
			Push(&resultado,e5);
    }
    else
    { //obtener los ultimos dos elementos en la pila
      e5=Pop(&resultado);
      valor1=e5.v;
      e5=Pop(&resultado);
      valor2=e5.v;
      //cada operador que se encuentre el arreglo definira la operacion a realizar entre los valores obtenidos
      if(cadena[i]=='^')
      {
        e5.v=pow(valor2,valor1);
        Push(&resultado,e5);
      }
      if(cadena[i]=='*')
      {
        e5.v=valor2*valor1;
        Push(&resultado,e5);
      }
      if(cadena[i]=='/')
      {
        e5.v=valor2/valor1;
        Push(&resultado,e5);
      }
      if(cadena[i]=='+')
      {
        e5.v=valor2+valor1;
        Push(&resultado,e5);
      }
      if(cadena[i]=='-')
      {
        e5.v=valor2-valor1;
        Push(&resultado,e5);
      }
      
       }
       
  }
  e5=Pop(&resultado);
       printf("\t\t   El resultado es:%.3f\n\n",e5.v);
  
}
