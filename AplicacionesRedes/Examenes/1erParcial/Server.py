#Para ejecutar, solo hay que hacer (como administrador):
# >python Server.py
#Importamos la librería para sockets de python
import socket
#importamos librería para medir tiempo
from time import time
#Para escoger aleatoriamente
from random import choice
#Librería 
from decimal import Decimal
TWOPLACES = Decimal(10) ** -2 
#Definimos el alfabeto
alfabeto=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
#Definimos los conceptos
conceptos=["FUTBOL","TECNOLOGIA","CIENCIA"]
#Definimos la forma de acomodar
#0:Horizontal, 1: Vertical, 2: Horizontal reversa, 3: Vertical reversa
#4: Diagonal derecha hacia abajo, 5: Diagonal derecha hacia arriba 
#6: Diagonal izquierda hacia abajo, 7: Diagonal izquierda hacia arriba
posiciones=[0,1,2,3,4,5,6,7]
#Matriz para la sopa de letras
array =[[0] * 15 for i in range(15)]
#Ya en uso
matriz=[[0] * 15 for i in range(15)]
#La llenamos de ceros
def limpiarMatriz():
	global matriz
	for i in range(15):
		for j in range(15):
			matriz[i][j]=0


#Horizontal
filas=[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14]

def obtenerSopa(dificultad):
	sopa=""
	print(dificultad)
	if dificultad=="facil"+"\n" or dificultad=="medio"+"\n":
		array1=llenarSopa(array)
		#Seleccionamos un concepto
		concepto=choice(conceptos)
		#Abrimos el archivo correspondiente
		lines=open(concepto+".txt","r").read().splitlines()
		#Recorremos el archivo linea por linea
		sopa,lines=arreglarLetras(array1,lines)
	else:
		#Dificultad dificil
		array1=llenarSopa(array)
		#Seleccionamos un concepto
		concepto="ANAGRAMA"
		#Abrimos el archivo correspondiente
		lines=open("ANAGRAMAS.txt","r").read().splitlines()
		#Recorremos el archivo linea por linea
		sopa, lines=arreglarLetras(array1,lines)
	return [sopa,concepto,lines]

def llenarSopa(array1):
	for i in range(15):
		for j in range(15):
			array1[i][j]=choice(alfabeto)
	return array1

def arreglarLetras(array1,lines):
	global matriz
	limpiarMatriz()
	# letras=[[0] * 15 for i in range(15)]
	for line in lines:
		esPrimera=True
		while esPrimera:
			#Obtenemos una posición
			posicion=choice(posiciones)
			centro_h=choice(filas)#j
			centro_v=choice(filas)#i
			#Verificamos el valor que hay en la matriz actualmente
			if matriz[centro_v][centro_h]==0 or array1[centro_v][centro_h]==line[0]:
				#Ahora verificamos el espacio
				#Horizontal
				if posicion==0:
					if (15-centro_h)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v][centro_h+(i+1)]==0 or array1[centro_v][centro_h+(i+1)]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v][centro_h+(i+1)]=1
								array1[centro_v][centro_h+(i+1)]=line[i+1]
				#Vertical
				elif posicion==1:
					if (15-centro_v)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v+(i+1)][centro_h]==0 or array1[centro_v+(i+1)][centro_h]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v+(i+1)][centro_h]=1
								array1[centro_v+(i+1)][centro_h]=line[i+1]
				#Horizontal reversa
				elif posicion==2:
					if (centro_h+1)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v][centro_h-(i+1)]==0 or array1[centro_v][centro_h-(i+1)]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v][centro_h-(i+1)]=1
								array1[centro_v][centro_h-(i+1)]=line[i+1]
				#Vertical reversa
				elif posicion==3:
					if (centro_v+1)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v-(i+1)][centro_h]==0 or array1[centro_v-(i+1)][centro_h]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v-(i+1)][centro_h]=1
								array1[centro_v-(i+1)][centro_h]=line[i+1]
				#Diagonal derecha hacia abajo
				elif posicion==4:
					if (15-centro_h)>=len(line) and (15-centro_v)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v+(i+1)][centro_h+(i+1)]==0 or array1[centro_v+(i+1)][centro_h+(i+1)]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v+(i+1)][centro_h+(i+1)]=1
								array1[centro_v+(i+1)][centro_h+(i+1)]=line[i+1]
				#Diagnoal derecha hacia arriba
				elif posicion==5:
					if (15-centro_h)>=len(line) and (centro_v+1)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v-(i+1)][centro_h+(i+1)]==0 or array1[centro_v-(i+1)][centro_h+(i+1)]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v-(i+1)][centro_h+(i+1)]=1
								array1[centro_v-(i+1)][centro_h+(i+1)]=line[i+1]
				#Diagonal izquierda hacia abajo
				elif posicion==6:
					if (centro_h+1)>=len(line) and (15-centro_v)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v+(i+1)][centro_h-(i+1)]==0 or array1[centro_v+(i+1)][centro_h-(i+1)]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v+(i+1)][centro_h-(i+1)]=1
								array1[centro_v+(i+1)][centro_h-(i+1)]=line[i+1]
				#Diagonal izquierda hacia arriba
				else:
					if (centro_h+1)>=len(line) and (centro_v+1)>=len(line):
						hayEspacio=0
						for i in range(len(line)-1):
							if matriz[centro_v-(i+1)][centro_h-(i+1)]==0 or array1[centro_v-(i+1)][centro_h-(i+1)]==line[i+1]:
								hayEspacio+=1
						if hayEspacio==len(line)-1:
							matriz[centro_v][centro_h]=1
							array1[centro_v][centro_h]=line[0]
							esPrimera=False
							for i in range(len(line)-1):
								matriz[centro_v-(i+1)][centro_h-(i+1)]=1
								array1[centro_v-(i+1)][centro_h-(i+1)]=line[i+1]	
	return [array1,lines]

def guardarTiempo(dificultad,final):
	if dificultad=="facil\n":
		archivo=open("facil.txt","a")
		archivo.write(str(Decimal(final).quantize(TWOPLACES)))
		archivo.write("\n")
		archivo.flush()
	elif dificultad=="medio\n":
		archivo=open("medio.txt","a")
		archivo.write(str(Decimal(final).quantize(TWOPLACES)))
		archivo.write("\n")
		archivo.flush()
	else:
		archivo=open("dificil.txt","a")
		archivo.write(str(Decimal(final).quantize(TWOPLACES)))
		archivo.write("\n")
		archivo.flush()

	

#Definimos el host
HOST="localhost"
#Definimos el puerto
PORT=8080
#Creamos un serversocket
#indicando el INET (IPV4 y el tipo de socket, para este caso de flujo)
serverSocket=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
#Luego ligamos el socket
serverSocket.bind((HOST,PORT))
#Luego pedimos que escuche
serverSocket.listen(1)
print("Servidor creado")
#Ahora esperamos conexiones
while True:
	#Aceptamos una conexion 
	cliente, addr=serverSocket.accept()
	print("Se tiene una conexión de %s" % str(addr))
	#Ahora esperamos que nos manden el modo de juego
	#El 1024 es el máximo de bytes a recibir
	#Ahora esperamos que nos manden la dificultad
	dificultad=(cliente.recv(1024)).decode("ascii")
	#Ahora que tenemos el modo juego y dificultad, calculamos lo que hay que enviar
	sopa,concepto,lines=obtenerSopa(dificultad)
	print("Ya obtuve la sopa")
	# dificultad=(cliente.recv(2048)).decode("ascii")
	# print(dificultad)
	print("Voy a empezar a enviar")
	prueba=open("prueba.txt","w")
	cliente.send((concepto+"\n").encode("ascii"))
	for line in lines:
		cliente.send((line+"\n").encode("ascii"))
	for i in range(15):
		for j in range(15):
			prueba.write(str(matriz[i][j]))
			prueba.flush()
			cliente.send((sopa[i][j]+"\n").encode("ascii"))
			cliente.send((str(matriz[i][j])+"\n").encode("ascii"))
		prueba.write("\n")
		prueba.flush()
	final=cliente.recv(4000)
	print("Recibi un mensaje: "+final.decode("ascii"))
	#Guargamos el tiempo en el que el cliente inicio el juego
	tiempo1=time()
	final=cliente.recv(4000)
	tiempo2=time()
	print("Tiempo de juego: "+str(tiempo2-tiempo1))
	guardarTiempo(dificultad,tiempo2-tiempo1)
	cliente.close()
	prueba.close()

