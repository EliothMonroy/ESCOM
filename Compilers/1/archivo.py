class ArchivoAutomata(object):
	"""Clase para leer el archivo de entrada para el automata"""
	lineas=""
	def __init__(self, archivo):
		aux=open(archivo,"r")
		self.lineas=aux.readlines()
	def obtenerEstados(self):
		return set((self.lineas[0].replace("\n","")).split(","))
	def obtenerAlfabeto(self):
		return set((self.lineas[1].replace("\n","")).split(","))
	def obtenerFuncionTransicion(self):
		transiciones=set()
		lista=list()#Pueden ser modificadas, por lo cual necesitamos una tupla
		aux=(self.lineas[2].replace("\n","")).split("-")
		for tran in aux:
			tran=tran.replace("(","").replace(")","")
			for elemento in tran.split(","):
				lista.append(elemento)
			transiciones.add(tuple(lista))
			lista=list()
		return transiciones
	def obtenerEstadoInicial(self):
		return (self.lineas[3].replace("\n",""))
	def obtenerEstadosFinales(self):
		return set((self.lineas[4].replace("\n","")).split(","))