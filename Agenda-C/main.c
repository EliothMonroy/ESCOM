#include "agenda.h"
int main(){
	struct cola micolita;
	struct tareas tareita;
	struct tareas tareita2;
	struct tareas tareita3;

	int opcion=0;
	int flujo=1;
	int tareas=1;
	int j=0;

	printf("ESCUELA SUPERIOR DE CÓMPUTO \n");
	printf("Estructuras de Datos - Agenda de Prioridades\n");
	crearCola(&micolita);

	while(flujo!=0){
		while(opcion>4 || opcion<1){
			imprimirMenu();
			scanf("%d", &opcion);
		}
		switch(opcion){
			case 1:
				crearTarea(&tareita);
				crearTarea(&tareita2);
				crearTarea(&tareita3);		
				int i=formarse(&micolita, &tareita);
				i=formarse(&micolita, &tareita2);
				i=formarse(&micolita, &tareita3);
			break;
			case 2:
				mostrarTodo(&micolita);
			break;
			case 3:
				mostrarDia(&micolita);
			break;
			case 4:
				j=desformarse(&micolita);
			break;
			default:
				printf("5\n");
			break;
		}
		opcion=0;
		printf("\n Salir: 0-Si | 1-No \n Selecciona:");
		scanf("%d", &flujo);
	}
	return 0;
}
