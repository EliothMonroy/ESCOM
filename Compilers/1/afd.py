from automata import Automata
class AFD(Automata):
	"""Automata Finito Determinista"""
	estado_actual=""

	#Constructor de la Clase AFD
	def __init__(self, estados, alfabeto, funcion_transicion,estado_inicial, estados_finales):
		#Llamamos al contructor de la clase padre
		Automata.__init__(self, estados, alfabeto,
		funcion_transicion, estado_inicial, estados_finales)
	#Método que permite calcula el estado actual del automata

	def calcularEstado(self, simbolo):
		#Variable auxiliar que nos permite saber si el estado actual esta
		#en alguna función de transición
		aux=0
		#Itero en cada una de las funciones de transición
		for transicion in sorted(self.funcion_transicion):
			#print(transicion)
			#Si fue encontrado el estado actual en alguna función de transición entonces:
			if transicion[0]==self.estado_actual:
				#Ahora evaluo si el simbolo corresponde a esa transición
				if transicion[1]==simbolo:
					#La bandera aux toma el valor de uno
					aux=1
					#En caso afirmativo, actualizo el estado actual del automata
					#Y termino el ciclo, ya que solo puede haber una función de transición que 
					#cumpla con esas caracteristicas (en un AFD)
					self.estado_actual=transicion[2]
					break
		#Si aux es cero, significa que ninguna función de transición uso ese simbolo y por lo tanto
		#la cadena es invalida
		if aux==0:
			self.estado_actual="muerto"

	#Método que permite evaluar una cadena con el automata
	def validarCadena(self,cadena):
		#Inicializo el estado actual del automata al estado inicial
		self.estado_actual=self.estado_inicial
		#Itero por cada simbolo en la cadena
		for simbolo in cadena:
			#print(simbolo)
			#Si el simbolo se encuentra en el alfabeto, entonces procedo a evaluarlo
			if simbolo in self.alfabeto:
				#print(self.estado_actual)
				#Calculo el estado actual del automata a partir del simbolo ingresado
				self.calcularEstado(simbolo)
			#Si el simbolo no pertenece al alfabeto entonces la cadena no es valida
			else:
				self.estado_actual="muerto"
		#Si el estado actual del automata esta entre los estados finales entonces
		#la cadena es valida
		if self.estado_actual in self.estados_finales:
			return "Cadena Valida"
		#En caso contrario, la cadena es invalida
		else:
			return "Cadena Invalida"

