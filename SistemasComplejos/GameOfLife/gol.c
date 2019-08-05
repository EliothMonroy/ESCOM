#include"funciones.h"
void rellenarArray(short array[tam][tam]){
	short aux;
	for (int i = 0; i < tam; ++i){
		for (int j = 0; j < tam; ++j){
			aux=rand()%2;
			// printf("Random: %d\n", aux);
			array[i][j]=aux;
			if(aux==1){
				numero_vivos++;
			}else{
				numero_muertos++;
			}
		}
	}
}
void evaluar(short array[tam][tam], short array2[tam][tam], int i, int j){
	//Comparo con array2 y modifico en array
	short estado=array2[i][j];
	short vecindad[8];
	short cantidad_vivos=0;
	short cantidad_muertos=0;
	if (i==0){
		vecindad[0]=array2[tam-1][j];//superior
		vecindad[1]=array2[i+1][j];//inferior
		if (j==0){
			vecindad[2]=array2[tam-1][tam-1];//superior izquierdo
			vecindad[3]=array2[tam-1][j+1];//superior derecho
			vecindad[4]=array2[i][tam-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][tam-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
		else if (j==tam-1){
			vecindad[2]=array2[tam-1][j-1];//superior izquierdo
			vecindad[3]=array2[tam-1][0];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][0];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][0];//inferior derecho
		}
		else{
			vecindad[2]=array2[tam-1][j-1];//superior izquierdo
			vecindad[3]=array2[tam-1][j+1];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
	}
	else if (i==tam-1){
		vecindad[0]=array2[i-1][j];//superior
		vecindad[1]=array2[0][j];//inferior
		if (j==0){
			vecindad[2]=array2[i-1][tam-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][tam-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[0][tam-1];//inferior izquierdo
			vecindad[7]=array2[0][j+1];//inferior derecho
		}
		else if (j==tam-1){
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][0];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][0];//derecho
			vecindad[6]=array2[0][j-1];//inferior izquierdo
			vecindad[7]=array2[0][0];//inferior derecho
		}
		else{
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[0][j-1];//inferior izquierdo
			vecindad[7]=array2[0][j+1];//inferior derecho
		}
	}
	else{
		vecindad[0]=array2[i-1][j];//superior
		vecindad[1]=array2[i+1][j];//inferior
		if (j==0){
			vecindad[2]=array2[i-1][tam-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][tam-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][tam-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
		else if (j==tam-1){
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][0];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][0];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][0];//inferior derecho
		}
		else{
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
	}
	for(int k=0;k<8;k++){
		if(vecindad[k]==1){
			cantidad_vivos++;
		}else{
			cantidad_muertos++;
		}
	}
	// printf("cantidad_vivos: %d\n", cantidad_vivos);
	if(estado==1){
		if (!((cantidad_vivos >= regla1) && (cantidad_vivos <= regla2))){
			array[i][j]=0;
			numero_vivos--;
			numero_muertos++;
		}
	}else{
		if ((cantidad_vivos >= regla3) && (cantidad_vivos <= regla4)){
			array[i][j]=1;
			numero_vivos++;
			numero_muertos--;
		}
	}
}
int main(int argc, char *argv[]){
	srand((unsigned)time(&t));
	regla1=2, regla2=3, regla3=3, regla4=3;
	tam=1000;
	proba=50;
	numero_vivos=0;
	numero_muertos=0;
	generacion=0;
	short array[tam][tam];
	short array2[tam][tam];
	rellenarArray(array);
	salida=fopen("historico_c.txt","w");
	fprintf(salida, "%d,%d\n", numero_vivos, generacion);
	fflush(salida);
	while(1){
		//Necesito tener dos arreglos, para modificar uno y el otro solo consultarlo
		memcpy(array2, array, sizeof (short) * tam * tam);
		printf("%d\n", generacion);
		generacion++;
		for(int i=0;i<tam;i++){
			for(int j=0;j<tam;j++){
				evaluar(array,array2,i,j);
			}
		}
		fprintf(salida, "%d,%d\n", numero_vivos, generacion);
		fflush(salida);
	}
}
