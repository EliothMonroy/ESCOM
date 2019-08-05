from automata import Automata
class AFND(Automata):
	"""Automata Finito Determinista"""
	estado_actual=list()
	estado_actual_aux=list()
	#Constructor de la Clase AFD

	def __init__(self, estados, alfabeto, funcion_transicion, estado_inicial, estados_finales):
		#Llamamos al contructor de la clase padre
		Automata.__init__(self, estados, alfabeto, funcion_transicion, estado_inicial, estados_finales)

	#Método que permite calcula el estado actual del automata
	def calcularEstado(self, simbolo):
		#Variable auxiliar que nos permite saber si el estado actual esta
		#en alguna función de transición
		recursiva=0
		aux=0
		#Itero en cada una de las funciones de transición
		continuar=0
		for transicion in sorted(self.funcion_transicion):
			if recursiva==1:
				aux=1
				break
			#print(transicion)
			#Si fue encontrado el estado actual en alguna función de transición entonces:
			#print("Estado actual antes if:",self.estado_actual)
			if transicion[0] in self.estado_actual:
				#Ahora evaluo si el simbolo corresponde a esa transición
				#print("Simbolo",simbolo)
				if transicion[1]==simbolo:
					#La bandera aux toma el valor de uno
					aux=1
					#En caso afirmativo, actualizo el estado actual del automata
					#Y termino el ciclo, ya que solo puede haber una función de transición que 
					#cumpla con esas caracteristicas (en un AFD)
					#print("El simbolo pertence a la transición")
					self.estado_actual_aux.append(transicion[2])
					#print(self.estado_actual_aux)
				if transicion[1]=="$":
					aux=1
					continuar=1
					self.estado_actual_aux.append(transicion[2])
					#print("Estado actual auxiliar:",self.estado_actual_aux)
		if continuar==1:
			self.estado_actual.clear()
			self.estado_actual=list(self.estado_actual_aux)
			self.estado_actual_aux.clear()
			self.calcularEstado(simbolo)
			recursiva=1
		#Si aux es cero, significa que ninguna función de transición uso ese simbolo y por lo tanto
		#la cadena es invalida
		if recursiva==0:
			self.estado_actual.clear()
			self.estado_actual=list(self.estado_actual_aux)
			self.estado_actual_aux.clear()
		if aux==0:
			self.estado_actual.append("muerto")

	#Método que permite evaluar una cadena con el automata
	def validarCadena(self,cadena):
		#Inicializo el estado actual del automata al estado inicial
		self.estado_actual.append(self.estado_inicial)
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
				self.estado_actual.append("muerto")
		#Si el estado actual del automata esta entre los estados finales entonces
		#la cadena es valida
		#print("Estados al final:",self.estado_actual)
		for estado in self.estados_finales:
			if estado in self.estado_actual:
				return "Cadena Valida"
		return "Cadena Invalida"

