class Automata(object):
	"""Clase Automata"""
	#Respectivos elementos del Automata
	estados=set()
	alfabeto=set()
	funcion_transicion=set()#conjunto de tuplas
	estado_inicial=""
	estados_finales=set()

	def __init__(self, estados, alfabeto, funcion_transicion, estado_inicial, estados_finales):
		self.estados=estados
		self.alfabeto=alfabeto
		self.funcion_transicion=funcion_transicion
		self.estado_inicial=estado_inicial
		self.estados_finales=estados_finales
	def calcularEstado(self,simbolo):
		pass
	def validarCadena(self,cadena):
		pass