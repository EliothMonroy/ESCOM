#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void rombov(int n);
int main() {
	int n;
	printf("Introduzca un valor para n:\n");
	scanf("%d", &n);	//Capturamos el valor de n
	rombov(n);	//llamamos a la funcion
	return 0;
}
void rombov(int n){
	int i,j,k;
	for(i=0;i<n;i++){	//Es la parte de arriba
		for(k=n;k>i;k--){	//Para los espacion que hay entre el primer asterisco y el inicio del renglon
			printf(" ");
		}
		for(j=0;j<=i;j++){	//Para imprimir los asteriscos 
			if(j==0 || j==i){
				printf("* ");
			}
			else{
				printf("  ");
			}
		}
		for(k=n;k>i+1;k--){	//Para los espacion que hay entre el primer asterisco y el inicio del renglon
			printf("  ");
		}
		for(j=0;j<=i;j++){	//Para imprimir los asteriscos 
			printf("* ");
		}
		printf("\n");	//Para cambiar de renglon
	}
	for(i=n-1;i>0;i--){	//Para la parte de abajo
		for(k=i;k<n;k++){	//Imprime los espacios que hay entre el primer asterisco y el inicio del renglon
			printf(" ");
		}
		for(j=i;j>0;j--){	//Imprime los asteriscos, pero ahora va de mayor a menor
			if(j==i || j==1){
				printf(" *");
			}
			else{
				printf("  ");
			}
		}
		for(k=i+1;k<=n;k++){	//Imprime los espacios que hay entre el primer asterisco y el inicio del renglon
			printf("  ");
		}
		for(j=i;j>0;j--){	//Imprime los asteriscos, pero ahora va de mayor a menor
			printf(" *");
		}
		printf("\n");	//Para cambiar de renglon
	}
}