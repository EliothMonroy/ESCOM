import string
from arbol import Arbol
class Automata:
	'Automata'
	def __init__(self, inicio):
		self.letras=list(string.ascii_letters)
		self.digitos=list(string.digits)
		self.operadores=("+","-","*","/","%")
		self.estado="q0"
		self.parentesis={"(",")"}
		self.pila=[]
		if inicio is not None:
			self.estado="q1"
	def calcularEstado(self,q):
		if q=="(":
			self.pila.append(q)
		elif q==")":
			if not self.pila:
				#La pila esta vacia, entonces hay un error
				self.estado="m"
			else:
				self.pila.pop()
		if self.estado=="q0":
			self.estado=self.estado_q0(q)
		elif self.estado=="q1":
			self.estado=self.estado_q1(q)
		elif self.estado=="q2":
			self.estado=self.estado_q2(q)
		elif self.estado=="q3":
			self.estado=self.estado_q3(q)
		elif self.estado=="q4":
			self.estado=self.estado_q4(q)
		elif self.estado=="q5":
			self.estado=self.estado_q5(q)
		elif self.estado=="q6":
			self.estado=self.estado_q6(q)
		elif self.estado=="q7":
			self.estado=self.estado_q7(q)
		elif self.estado=="q8":
			self.estado=self.estado_q8(q)
		elif self.estado=="q9":
			self.estado=self.estado_q9(q)
		elif self.estado=="q10":
			self.estado=self.estado_q10(q)
		elif self.estado=="q11":
			self.estado=self.estado_q11(q)
		elif self.estado=="q12":
			self.estado=self.estado_q12(q)
		elif self.estado=="q13":
			self.estado=self.estado_q13(q)
		elif self.estado=="c0":
			self.estado=self.estado_c0(q)
		elif self.estado=="c1":
			self.estado=self.estado_c1(q)
	def estado_q0(self,q):
		if q in self.letras:
			return "q2"
		elif q=="_":
			return "q3"
		else:
			return "m"
	def estado_q1(self,q):
		if q in self.letras:
			return "q2"
		elif q =="_":
			return "q3"
		else:
			return "m"
	def estado_q2(self,q):
		if q in self.letras or q in self.digitos:
			return "q2"
		elif q==";":
			return "c0"
		elif q==",":
			return "q6"
		elif q=="=":
			return "q5"
		else:
			return "m"
	def estado_q3(self,q):
		if q in self.letras or q in self.digitos:
			return "q4"
		else:
			return "m"
	def estado_q4(self,q):
		if q in self.letras or q in self.digitos:
			return "q4"
		elif q==";":
			return "c0"
		elif q==",":
			return "q6"
		elif q=="=":
			return "q5"
		else:
			return "m"
	def estado_q5(self,q):
		if q in self.letras:
			return "q7"
		elif q in self.digitos:
			return "q13"
		elif q in self.parentesis:
			return "q8"
		elif q =="_":
			return "q9"
		else:
			return "m"
	def estado_q6(self,q):
		if q in self.letras:
			return "q2"
		elif q=="_":
			return "q3"
		else:
			return "m"
	def estado_q7(self,q):
		if q in self.letras or q in self.digitos or q in self.parentesis or q =="_":
			return "q7"
		elif q in self.operadores:
			return "q12"
		elif q ==";":
			return "c1"
		else:
			return "m"
	def estado_q8(self,q):
		if q in self.parentesis:
			return "q8"
		elif q in self.letras or q in self.digitos or q in self.parentesis or q=="_":
			return "q10"
		else:
			return "m"
	def estado_q9(self,q):
		if q in self.letras or q in self.digitos or q in self.parentesis:
			return "q11"
		else:
			return "m"
	def estado_q10(self,q):
		if q in self.letras or q in self.digitos or q in self.parentesis or q=="_":
			return "q10"
		elif q in self.operadores:
			return "q12"
		elif q==";":
			return "c1"
		else:
			return "m"
	def estado_q11(self,q):
		if q in self.letras or q in self.digitos or q in self.parentesis or q=="_":
			return "q11"
		elif q==";":
			return "c1"
		else:
			return "m"
	def estado_q12(self,q):
		if q in self.digitos:
			return "q13"
		elif q in self.letras:
			return "q7"
		elif q in self.parentesis:
			return "q8"
		elif q =="_":
			return "q9"
		else:
			return "m"
	def estado_q13(self,q):
		if q in self.digitos:
			return "q13"
		elif q in self.operadores:
			return "q12"
		if q==";":
			return "c1"
		else:
			return "m"
	def estado_c0(self,q):
		if q in self.letras:
			return "q2"
		if q =="_":
			return "q3"
		else:
			return "m"
	def estado_c1(self,q):
		return "m"