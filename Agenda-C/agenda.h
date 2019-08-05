#ifndef __AGENDA_H__
#define __AGENDA_H__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/*Código de colas modificado para esta problemática*/
struct fecha{
	 int anio;
	 int mes;
	 int dia;
	 int hora;
	 int minuto;
};

struct tareas{
	char nombre[20];
	char contenido[20];
	struct fecha limite;
	int prioridad;
	struct tareas *siguiente;
};

struct cola{
	struct tareas *ultimo;
	struct tareas *primero;
};

/*crearTarea(nombre,contenido, dia, mes, año, prioridad);*/
void crearTarea(struct tareas *);
void obtenerFecha(struct fecha*);
int comparar(struct tareas*, struct tareas*);

/*Funciones para la cola*/
void crearCola(struct cola*);
int formarse(struct cola*, struct tareas*);
int desformarse(struct cola*);
void mostrarDia(struct cola*);
void mostrarTodo(struct cola*);

void imprimirMenu();

#endif