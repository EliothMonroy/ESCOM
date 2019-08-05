class Automata():
	#Definimos el estado del automata como el inicial q0
	e1=("0","1","2","3","4","5","6","7","8","9")
	e2=("1","2","3","4","5","6","7","8","9")
	e3=("0","1","2","3","4","5","6","7")
	e4=("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f")
	signos=("+","-")
	otros_signos=("+","-","*","/",",",";","(",")","\n")
	estado="q0"
	def calcular_estado(self, q):
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
		elif self.estado=="c0":
			self.estado=self.estado_c0(q)
		elif self.estado=="c1":
			self.estado=self.estado_c1(q)
		elif self.estado=="c2":
			self.estado=self.estado_c2(q)
		elif self.estado=="c3":
			self.estado=self.estado_c3(q)
		elif self.estado=="c4":
			self.estado=self.estado_c4(q)
		else:
			self.estado=self.estado
	def estado_q0(self,q):
		if q in self.signos:
			return "q1"
		elif q in self.e2:
			return "c0"
		elif q=="0":
			return "c2"
		else:
			return "q0"
	def estado_q1(self,q):
		if q in self.e2:
			return "c0"
		elif q=="0":
			return "c2"
		elif q in self.otros_signos:
			return "q0"
		else:
			return "m"
	def estado_q2(self,q):
		if q in self.e1:
			return "c3"
		elif q in self.otros_signos:
			return "q0"
		else:
			return "m"
	def estado_q3(self,q):
		if q in self.signos:
			return "q4"
		elif q in self.e1:
			return "q5"
		elif q in self.otros_signos:
			return "q0"
		else:
			return "m"
	def estado_q4(self,q):
		if q in self.e1:
			return "q5"
		elif q in self.otros_signos:
			return "q0"
		else:
			return "m"
	def estado_q5(self,q):
		if q in self.e1:
			return "c4"
		elif q in self.otros_signos:
			return "q0"
		else:
			return "m"
	def estado_q6(self,q):
		if q in self.e4:
			return "c1"
		elif q in self.otros_signos:
			return "q0"
		else:
			return "m"
	def estado_c0(self,q):
		if q in self.e1:
			return "c0"
		elif q==".":
			return "q2"
		elif q in self.otros_signos:
			return "c0"
		else:
			return "m"
	def estado_c1(self,q):
		if q in self.e4:
			return "c1"
		elif q in self.otros_signos:
			return "c1"
		else:
			return "m"
	def estado_c2(self,q):
		if q in self.e3:
			return "c2"
		elif q in self.otros_signos:
			return "c2"
		elif q=="x":
			return "q6"
		else:
			return "m"
	def estado_c3(self,q):
		if q in self.e2:
			return "c3"
		elif q in self.otros_signos:
			return "c3"
		elif q=="e":
			return "q3"
		else:
			return "m"
	def estado_c4(self,q):
		if q in self.otros_signos:
			return "c4"
		else:
			return "m"