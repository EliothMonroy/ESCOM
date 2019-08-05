#Creamos los menus
def main():
	mensaje_entrada = "Inciso a) de la práctica\nHola, por favor ingresa el tipo de Alfabeto con el que trabajaré:\n"
	menu = ('1.- Ingresar alfabeto manualmente\n'
	'2- Alfabeto Espaniol\n'
	'3.- Números (0...9)\n')
	#Imprimimos el menu
	print (mensaje_entrada)
	#Creamos el alfabeto
	alfabeto=crear_alfabeto(menu)
	#Al final imprimimos el alfabeto
	print ("El alfabeto con el que trabajaré es:\n")
	print (alfabeto)
	print("\n")
	#Ahora solicitamos las palabras
	palabra1=ingresar_palabra(alfabeto)
	palabra2=ingresar_palabra(alfabeto)
	print("Las palabras con las que trabajaré son: w1 = "+palabra1+" y w2 = "+palabra2)
	#Ahora concatenamos las palabras
	concatenacion=concatenar_palabras(palabra1,palabra2)
	#Pedimos al usuario que ingrese n
	n=pedir_n()
	#Ejecutamos la potencia de la concatenacion
	potencia_palabra=potencia(concatenacion,n)
	print("El resultado de la potencia de la concatenacion es:\n"+potencia_palabra+"\n")
	print("La longitud de esta potencia es: \n")
	print(longitud_palabra(alfabeto,potencia_palabra))
	print("\n")
	#Inciso e de la práctica
	#Solicitamos al usuario el caracter a buscar
	x=ingresar_caracter(alfabeto)
	buscar_elemento(palabra1,x)
	#Inciso f de la práctica
	n=pedir_n()
	print("Con la palabra w1="+palabra1+" elevado a la: ",n,"\n")
	print("Obtenemos como resultado: "+potencia(palabra1,n))
	#Inciso g de la práctica
	print("Por favor ingrese z para decirle si es un subfijo o prefijo")
	z=ingresar_palabra(alfabeto)
	print("z es de w1:\n")
	que_es(palabra1,z)
	print("z es de w2:\n")
	que_es(palabra2,z)
	#Inciso h y ultimo de la práctica
	print("Por favor ingrese un valor para realizar la potencia del alfabeto")
	n=pedir_n()
	print("El resultado de la potencia del alfabeto es:\n")
	aux=set()
	print("E^",n," =\n")
	potencia_alfabeto(alfabeto,aux,n)
	es_palindromo(palabra1)
	es_palindromo(palabra2)

#Función que crea el alfabeto dependiendo de la opción del usuario
def crear_alfabeto(menu):
	opcion_valida=True
	while opcion_valida:
		#Imprimimos el menu y obtenemos la opción
		opcion = input(menu)
		#Esto es un Set en python
		alfabeto = set()
		#Dependiendo la opción es el menu a usar
		# 1- Alfabeto dinamico ingresado por el usuario
		if opcion == '1':
			opcion_valida=False
			seguir = True
			while seguir:
				simbolo=input("Ingrese un simbolo\n")
				if simbolo != "" and (" " in simbolo)==False:
					alfabeto.add(simbolo)
				else:
					print("Caracter no valido\n")
				if len(alfabeto)>2:
					seguir_agregando=True
					while seguir_agregando:	
						opcion2 = input("Desea ingresar más elementos? s/n \n")
						if opcion2=='s':
							seguir_agregando=False
						elif opcion2=='n':
							seguir=False
							seguir_agregando=False
							return alfabeto
						else:
							pass
		#Alfabeto español
		elif opcion == '2':
			opcion_valida=False
			print ("El alfabeto es español")
			alfabeto={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','ñ','o','p','q','r','s','t','u','v','w','x','y','z'}
			return alfabeto
		#Alfabeto númerico
		elif opcion == '3':
			opcion_valida=False
			print ("El alfabeto es númerico")
			alfabeto={'0','1','2','3','4','5','6','7','8','9'}
			return alfabeto
		#Opción invalida se repite el ciclo
		else:
			print('Opción no valida, debe ser alguna de las siguientes\n')

#Función para verificar dos palabras con respecto al alfabeto
def ingresar_palabra(alfabeto):
	palabra=""
	while validar_palabra(alfabeto, palabra):
		palabra=input("Por favor ingrese una palabra (w) :\n")
	return palabra

#Función que valida si una palabra pertenece al alfabeto o no
def validar_palabra(alfabeto,palabra):
	if len(palabra)>0:
		if " " in palabra:
			print("No se permiten espacios entre los simbolos")
			return True
		variable_auxiliar=0
		for i in alfabeto:
			for j in range(len(palabra)):
				if i==palabra[j:len(i)+j]:
					variable_auxiliar=variable_auxiliar+len(i)
		if variable_auxiliar==len(palabra):
			print ("Palabra valida\n")
			return False
		else:
			print ("Palabra invalida\n")
			return True
	else:
		return True

#Funcion que le pide al usuario ingresar una n entera
def pedir_n():
	n=""
	while n_valida(n):
		n=input("Ingrese un entero al que se elevara\n")
	#La función input siempre devuelve un string, así que lo convertimos a int
	return int(n)

#Función que verifica si n es un numero entero valido o no
def n_valida(n):
	try:
		int(n)
		return False
	except ValueError:
		return True

#Funcion que concatena dos palabras
def concatenar_palabras(palabra1,palabra2):
	return palabra1+palabra2

#Funcion que le aplica la n potencia a alguna palabra
def potencia(palabra,n):
	potencia=""
	#Tenemos que evaluar para los 3 distintos caso de n
	if n==0:
		return "Cadena vacia"
	elif n>0:
		for i in range(n):
			potencia=potencia+palabra
	#Por default, debe ser n negativa
	else:
		#Hay que voltear la cadena
		palabra=palabra[::-1]
		for i in range(abs(n)):
			potencia=potencia+palabra 
	return potencia

#Funcion que imprime la longitud de una palabra
def longitud_palabra(alfabeto,palabra):
	variable_auxiliar=0
	print("Calculando la longitud ...\n")
	if palabra == "Cadena vacia":
		return variable_auxiliar
	for i in alfabeto:
		for j in range(len(palabra)):
			if i==palabra[j:len(i)+j]:
				variable_auxiliar=variable_auxiliar+1
	return variable_auxiliar

#Función para verificar dos palabras con respecto al alfabeto
def ingresar_caracter(alfabeto):
	caracter=""
	while validar_caracter(alfabeto, caracter):
		caracter=input("Por favor ingrese un caracter el cual buscare en w1:\n")
	return caracter

#Función que valida si una palabra pertenece al alfabeto o no
def validar_caracter(alfabeto,caracter):
	if len(caracter)>0:
		variable_auxiliar=0
		print("Estoy validando el caracter ...\n")
		if " " in caracter:
			print("No se permiten espacios entre los simbolos")
			return True
		for i in alfabeto:
			for j in range(len(caracter)):
				if i == caracter[j:len(i)+j]:
					variable_auxiliar=variable_auxiliar+len(i)
		if variable_auxiliar == len(caracter):
			print ("Caracter valido\n")
			return False
		else:
			print ("Caracter invalido\n")
			return True
	else:
		return True

#Funcion que busca un elemento del alfabeto dentro de una palabra
def buscar_elemento(palabra,caracter):
	contador=0
	for i in range(len(palabra)):
		if caracter == palabra[i:len(caracter)+i]:
			contador+=1
	print("En w1="+palabra+"\n")
	print("Encontre este elemento: "+caracter+"\n")
	print("Número de veces: ",contador,"\n")

#Funcion que nos dira que es una cadena z con respecto a 
def que_es(palabra,z):
	if palabra==z:
		print ("Es un subfijo, prefijo y subcadena\n")
	else:
		if es_prefijo_propio(palabra,z):
			print ("Es un prefijo propio\n")
		if es_subfijo_propio(palabra,z):
			print ("Es un subfijo propio\n")
		if es_subcadena_propia(palabra,z):
			print ("Es una subcadena propia\n")
		else:
			print("z: "+z+" no es nada de la palabra: "+palabra)

#Funcion que verifica dos cadenas y dice si es un prefijo propio o no
def es_prefijo_propio(palabra,z):
	for i in range(len(palabra)):
		if z==palabra[0:i]:
				return True
	return False

#Funcion que verifica si es subfijo propio
def es_subfijo_propio(palabra,z):
	for i in range(len(palabra)):
		if z==palabra[len(palabra)-i:len(palabra)]:
				return True
	return False

#Funcion que determina si es una subcadena propia
def es_subcadena_propia(palabra,z):
	if z in palabra:
		return True

#Funcion que calcula la potencia n de un alfabeto
def potencia_alfabeto(alfabeto,aux,n):
	#Distintos casos de n
	n=abs(n)
	potencia=set()
	lista_alfabeto=list(alfabeto)
	if n==0:
		potencia.add("Cadena vacia")
		print (potencia)
	#n mayor o igual 1
	else:
		auxiliar=list(aux)
		if len(auxiliar) == 0:
			auxiliar=list(alfabeto)
			aux=alfabeto
		if len(auxiliar) == (len(lista_alfabeto)**n):
			print("Numero de elementos:\n")
			print(len(auxiliar))
			print("\nElementos:\n")
			print(aux)
		else:
			for i in range(len(auxiliar)):
				for j in range(len(lista_alfabeto)):
					potencia.add(auxiliar[i]+lista_alfabeto[j])
			potencia_alfabeto(alfabeto,potencia,n)

#Funcion que verifica si una palabra es un palindromo
def es_palindromo(palabra):
	if palabra == palabra[::-1]:
		print ("\n"+palabra+" es un palindromo\n")

#Iniciamos el programa
main()