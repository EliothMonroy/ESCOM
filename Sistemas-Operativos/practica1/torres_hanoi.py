#Voy a resolver torres de hanoi usando python y recursión
#Para resolver este problema necesitamos saber 3 datos
#El número de discos, la torre de inicio y la torre a donde queremos trasladar todos los discos
#Siempre contaremos con solo 3 torres, aquí consideraremos la 1 como el inicio. la 2 como auxilizar y 3 como el fin (la torre destino)
#Así que empezemos definiendo nuestra función hanoi
#Solo necesitamos estos parametros
def hanoi(numero_discos, inicio, final):
	if numero_discos: #Mientras haya discos podemos ejecutar lo siguiente
		hanoi(numero_discos-1, inicio,6-inicio-final)#From actual to auxiliar
		print ("Se mueve el disco %d de la torre %d hacia la torre %d" %(numero_discos,inicio,final))
		hanoi(numero_discos-1,6-inicio-final,final)
hanoi(3,1,3)#Enviamos el número de discos, el inicio y el destino
