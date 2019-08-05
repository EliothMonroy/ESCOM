//DEFINICIONES DE CONSTANTES
#define TRUE	1
#define FALSE	0

//DEFINICIONES DE TIPOS DE DATO

//Definir un boolean (Se modela con un "char")
typedef unsigned char boolean;

//Definir un elemento (Se modela con una estructura "elemento")
typedef struct elemento
{
	//Variables de la estructura "elemento" (El usuario puede modificar)
	char c;
	float v;
	//***
	//***
}elemento;

//Definir un nodo que será utilizado para almacenar una posición de la pila (Nodo), lo que incluira a un elemento y a un apuntador al siguiente nodo
typedef struct nodo
{
	//Elemento a almacenar en cada nodo de la pila	
	elemento e;	
	//Apuntador al elemento de debajo (Requerido por ser una implementación dinámica -Usuario: No modificar)
	struct nodo *abajo;
}nodo;

//Definir una pila (Se modela con una estructura que unicamente incluye un puntero a "elemento")
typedef struct pila
{		
	nodo *tope;
}pila;

//DECLARACIÓN DE FUNCIONES
void Initialize(pila *s);			//Inicializar pila (Iniciar una pila para su uso)
void Push(pila *s, elemento e);		//Empilar (Introducir un elemento a la pila)
elemento Pop (pila *s);				//Desempilar (Extraer un elemento de la pila)
boolean Empty(pila *s);				//Vacia (Preguntar si la pila esta vacia)
elemento Top(pila *s);				//Tope (Obtener el "elemento" del tope de la pila si extraerlo de la pila)
int Value_Top(pila *s);				//Tamaño de la pila (Obtener el número de elementos en la pila)
void Destroy(pila *s);				//Elimina pila (Borra a todos los elementos y a la pila de memoria)


//DEFINICIÓN DE FUNCIONES

void Initialize(pila *s)
{
	s->tope=NULL; //(*s).tope=NULL;
	return;
}


void Push(pila *s, elemento e)
{
	nodo *aux;
	aux=malloc(sizeof(nodo));
	(*aux).e=e;  //aux->e=e;
	aux->abajo=s->tope;
	s->tope=aux;
	return;
}



elemento Pop (pila *s)
{
	elemento r;
	nodo *aux;
	r=s->tope->e;
	aux=s->tope;
	s->tope=s->tope->abajo;
	free(aux);
	return r;	
}


boolean Empty(pila *s)
{
	boolean r;
	if(s->tope==NULL)
	{
		r=TRUE;
	}	
	else
	{
		r=FALSE;
	}
	return r;	
}


elemento Top(pila *s)
{
	return s->tope->e;
}


int Value_Top(pila *s)
{
	nodo *aux;
	int tam_pila=0;
	aux=s->tope;
	if(aux!=NULL)
	{
		tam_pila++;
		while(aux->abajo!=NULL)
		{
			tam_pila++;
			aux=aux->abajo;
		}
	}	
	else
	{
		tam_pila=-1;
	}
	return tam_pila;
}


void Destroy(pila *s)
{
	nodo *aux;
	if(s->tope!=NULL)
	{
		while(s->tope!=NULL)
		{				
			aux=s->tope->abajo;
			free(s->tope);
			s->tope=aux;
		}		
	}
	return;
}
