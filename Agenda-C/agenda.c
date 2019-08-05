#include "agenda.h"

void obtenerFecha( struct fecha *actual){
	time_t tiempo = time(0);
	struct tm *local=localtime(&tiempo);

	actual->anio=local->tm_year+1900;
	actual->mes=local->tm_mon+1;
	actual->dia=local->tm_mday;
	actual->hora=local->tm_hour;
	actual->minuto=local->tm_min;
}

int comparar(struct tareas* auxiliar2, struct tareas* una_tarea){
	if(auxiliar2->limite.anio==una_tarea->limite.anio && auxiliar2->limite.mes==una_tarea->limite.mes && auxiliar2->limite.dia==una_tarea->limite.dia){
		return 1;
	}
	if(auxiliar2->limite.anio>una_tarea->limite.anio){
		return 2;
	}
	if(auxiliar2->limite.anio<una_tarea->limite.anio){
		return 3;
	}
	//Años iguales pero meses distintos
	if(auxiliar2->limite.anio==una_tarea->limite.anio && auxiliar2->limite.mes>una_tarea->limite.mes){
		return 2;
	}
	if(auxiliar2->limite.anio==una_tarea->limite.anio && auxiliar2->limite.mes<una_tarea->limite.mes){
		return 3;
	}
	//Años iguales meses iguales pero dias distintos
	if(auxiliar2->limite.anio==una_tarea->limite.anio && auxiliar2->limite.mes==una_tarea->limite.mes && auxiliar2->limite.dia>una_tarea->limite.dia){
		return 2;
	}
	if(auxiliar2->limite.anio==una_tarea->limite.anio && auxiliar2->limite.mes==una_tarea->limite.mes && auxiliar2->limite.dia<una_tarea->limite.dia){
		return 3;
	}
}

void crearCola(struct cola * una_cola){
	una_cola->primero=NULL;
	una_cola->ultimo=NULL;
}

void crearTarea(struct tareas *una_tarea){
	int validar_hora=-1;
	int validar_minuto=-1;
	int validar_prior=-1;
	int validar_mes=-1;
	int validar_dia=-1;


	printf("\nNombre: ");
	scanf("%s", una_tarea->nombre);
	fflush(stdin);
	printf("\nContenido: ");
	scanf("%s", una_tarea->contenido);
	fflush(stdin);
	while(validar_mes<0||validar_mes>12||validar_dia<0||validar_dia>31){
		printf("\nFecha Limite(aaaa mm dd)\nEjemplo: 2016 7 12");
		printf("\nFecha: ");
		scanf("%d %d %d",&una_tarea->limite.anio,&una_tarea->limite.mes,&una_tarea->limite.dia);
		validar_mes=una_tarea->limite.mes;
		validar_dia=una_tarea->limite.dia;
	}
	
	while(validar_hora<0 || validar_hora>24 || validar_minuto<0 || validar_minuto>60){
		printf("\nHora Limite(HH MM)\nEjemplo: 22 08");
		printf("\nHora: ");
		scanf("%d %d",&una_tarea->limite.hora,&una_tarea->limite.minuto);
		validar_hora=una_tarea->limite.hora;
		validar_minuto=una_tarea->limite.minuto;
	}

	while(validar_prior<1 || validar_prior>5){
		printf("\nPrioridad rango(1-5):");
		scanf("%d",&una_tarea->prioridad);
		validar_prior=una_tarea->prioridad;
	}

	una_tarea->siguiente=NULL;
	fflush(stdin);
}

void mostrarTodo(struct cola *una_cola){
	struct tareas *auxiliar;
	if(una_cola->primero==NULL){
		printf("Vacia\n");
		return;
	}
	auxiliar=una_cola->primero;
	do{
		puts(auxiliar->nombre);
		puts(auxiliar->contenido);
		printf("Fecha: %d %d %d \n",auxiliar->limite.anio, auxiliar->limite.mes, auxiliar->limite.dia);
		printf("Hora: %d %d \n",auxiliar->limite.hora, auxiliar->limite.minuto);
		printf("Prioridad: %d\n",auxiliar->prioridad);
		auxiliar=auxiliar->siguiente;
	}while(auxiliar!=NULL);
}

void mostrarDia(struct cola *una_cola){
	int existe=0;
	struct fecha actual;
	obtenerFecha(&actual);

	printf("La fecha actual es: %d - %d - %d   Hora: %d : %d \n",actual.anio,actual.mes, actual.dia, actual.hora, actual.minuto);

	struct tareas *auxiliar;
	if(una_cola->primero==NULL){
		printf("Vacia\n");
		return;
	}
	auxiliar=una_cola->primero;
	do{
		if(actual.anio==auxiliar->limite.anio&&actual.mes==auxiliar->limite.mes&&actual.dia==auxiliar->limite.dia){
			puts(auxiliar->nombre);
			puts(auxiliar->contenido);
			printf("Fecha: %d %d %d \n",auxiliar->limite.anio, auxiliar->limite.mes, auxiliar->limite.dia);
			printf("Hora: %d %d \n",auxiliar->limite.hora, auxiliar->limite.minuto);
			printf("Prioridad: %d\n",auxiliar->prioridad);
			existe=1;
		}
		auxiliar=auxiliar->siguiente;
	}while(auxiliar!=NULL);
	if(existe==0){
		printf("El día de hoy esta vacío\n");
	}
}

int desformarse(struct cola* una_cola){
	struct tareas *auxiliar;
	if(una_cola==NULL){
		return 0;
	}
	auxiliar=una_cola->primero;
	una_cola->primero=auxiliar->siguiente;
	return 1;	
}

int formarse(struct cola* una_cola,struct tareas *una_tarea){

	struct tareas *auxiliar1;
	struct tareas *auxiliar2;
	struct tareas *auxiliar_recorrer;

	struct tareas *auxiliar;
	auxiliar=(struct tareas *)malloc(sizeof(struct tareas));
	auxiliar=una_tarea;
	if(auxiliar==NULL || una_cola==NULL){
		return 0;
	}
	if(una_cola->primero==NULL){
		una_cola->primero=auxiliar;		
		una_cola->ultimo=auxiliar;
	}else{
		auxiliar_recorrer=una_cola->primero;
		auxiliar1=NULL;
		auxiliar2=una_cola->primero;
		do{
			int compara=comparar(auxiliar2, una_tarea);
			switch(compara){
				case 1:
					if(auxiliar2->prioridad>=una_tarea->prioridad){
						una_tarea->siguiente=auxiliar2;
						auxiliar1->siguiente=una_tarea;
						auxiliar1=NULL;
						auxiliar2=NULL;
					}else{
						auxiliar1=auxiliar2;
						auxiliar2=auxiliar2->siguiente;
						if(auxiliar2==NULL){
							auxiliar1->siguiente=una_tarea;							
						}
					}
					break;
				case 2://La fecha sea menor
					if(auxiliar2=una_cola->primero){
						una_cola->primero=una_tarea;
					}
					una_tarea->siguiente=auxiliar2;
					//auxiliar1->siguiente=una_tarea;
					auxiliar2=NULL;
					break;
				case 3://La fecha es mayor
					auxiliar1=auxiliar2;
					auxiliar2=auxiliar2->siguiente;
					if(auxiliar2==NULL){
						auxiliar1->siguiente=una_tarea;							
					}
					break;
				default:
					printf("Dato no guardado\n");
					break;
			}	
		}while(auxiliar2!=NULL);	
	}
	return 1;
}

void imprimirMenu(){
	printf("MENU: \n");
	printf("1. Agregar tarea. \n");
	printf("2. Todas las tareas. \n");
	printf("3. Tareas para hoy. \n");
	printf("4. Vaciar tareas pasadas. \n");
	printf("Selecciona:");
}