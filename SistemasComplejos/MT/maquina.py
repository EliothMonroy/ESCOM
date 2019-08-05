class MaquinaTuring(object):
	def __init__(self, estados, alfabeto, transiciones, inicial, final,cadena):
		self.estados=estados
		self.alfabeto=alfabeto
		self.transiciones=transiciones
		self.inicial=inicial
		self.estado_actual=self.inicial
		self.final=final
		self.apuntador=0
		self.blanco="B"
		self.cadena=list(cadena)
		self.direccion=""
	def evaluar(self):
		if len(self.cadena)-1<self.apuntador:
			caracter=self.blanco
		else:
			caracter=self.cadena[self.apuntador]

		if caracter in self.alfabeto:
			transicion=(self.estado_actual,caracter)
			if transicion in self.transiciones:
				siguiente=self.transiciones[transicion]
				if len(self.cadena)-1<self.apuntador:
					self.cadena.append(self.blanco)
				if self.apuntador<0:
					self.cadena.insert(0,self.blanco)
				self.cadena[self.apuntador]=siguiente[1]
				if siguiente[2]=="R":
					self.apuntador+=1
				else:
					self.apuntador=self.apuntador-1

				self.estado_actual=siguiente[0]
				self.direccion=siguiente[2]
				if self.estado_actual in self.estados:
					return True
				else:
					return False
			else:
				return False
		else:
			return False
	def esFinal(self):
		if self.estado_actual in self.final:
			if len(self.cadena)-1<self.apuntador:
				return True
		return False