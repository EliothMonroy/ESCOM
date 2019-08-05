class Validador(object):
	alfabeto={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
	otros_caracteres={'(',')','E','+','|','*'}#La E es epsilon
	cadena=''
	"""Clase que valida que una expresión regular tenga carácteres permitido"""
	def __init__(self, cadena):
		self.cadena = cadena
	def esValida(self):
		for caracter in self.cadena:
			#print("Caracter: ",caracter)
			if caracter not in (self.alfabeto|self.otros_caracteres):
				return 'Expresión Regular No Valida'
		return 'Expresión Regular Valida'