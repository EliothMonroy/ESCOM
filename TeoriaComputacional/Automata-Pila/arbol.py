class Arbol:
	'Arbolito'
	def __init__(self,valor):
		self.valor=valor
		self.izquierda=None
		self.centro=None
		self.derecha=None
	def agregarIzquierda(self,valor):
		if self.izquierda is not None:
			self.izquierda.agregarIzquierda(valor)
		elif self.centro is not None:
			self.centro.agregarIzquierda(valor)
		elif self.derecha is not None:
			self.derecha.agregarIzquierda(valor)
		else:
			self.izquierda=Arbol(valor)
	def agregarCentro(self,valor):
		self.centro=Arbol(valor)
	def agregarDerecha(self,valor):
		self.derecha=Arbol(valor)

