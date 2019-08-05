import sys
class Sintactico(object):
	"""Analizador Sintáctico"""
	def __init__(self, token):
		#Token es la cadena de entrada
		self.token=token
		#Posición sirve para iterar por el token
		self.posicion=0
	def consume(self,caracter):
		if self.posicion==len(self.token):
			print("Cadena no valida")
			sys.exit()
		elif self.token[self.posicion]==caracter:
			self.posicion+=1
		else:
			print("Cadena no valida")
			sys.exit()
	def S(self):
		if self.token[self.posicion]=='a':
			self.consume('a')
			self.S()
			self.consume('b')
		elif self.token[self.posicion]=='c':
			self.consume('c')
		else:
			print ("Cadena no valida")
			sys.exit()
	def obtenerPosicion(self):
		if self.posicion==(len(self.token)):
			print("Cadena valida")
		else:
			print("Cadena no valida")
prueba=Sintactico("aaaabbbb")
prueba.S()
prueba.obtenerPosicion()
