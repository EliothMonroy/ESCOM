class Automata():
	#Definimos el automata
	mayusculas=("A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z")
	minusculas=("a","b","c","d","e","f","g","h","i","j","k","l","m","n","ñ","o","p","q","r","s","t","u","v","w","x","y","z","á","é","í","ó","ú")
	estado=["q0"]
	estado_aux=[]
	def calcular_estado(self,q):
		if "q0" in self.estado:
			self.estado.remove("q0")
			self.estado_q0(q)
		if "q1" in self.estado:
			self.estado.remove("q1")
			self.estado_q1(q)
		if "q2" in self.estado:
			self.estado.remove("q2")
			self.estado_q2(q)
		if "q3" in self.estado:
			self.estado.remove("q3")
			self.estado_q3(q)
		if "q4" in self.estado:
			self.estado.remove("q4")
			self.estado_q4(q)
		if "q5" in self.estado:
			self.estado.remove("q5")
			self.estado_q5(q)
		if "q6" in self.estado:
			self.estado.remove("q6")
			self.estado_q6(q)
		if "q7" in self.estado:
			self.estado.remove("q7")
			self.estado_q7(q)
		if "q8" in self.estado:
			self.estado.remove("q8")
			self.estado_q8(q)
		if "q9" in self.estado:
			self.estado.remove("q9")
			self.estado_q9(q)
		if "c0" in self.estado:
			self.estado.remove("c0")
			self.estado_c0(q)
		if "c1" in self.estado:
			self.estado.remove("c1")
			self.estado_c1(q)
		print("Estado",self.estado)
		print("Estado aux",self.estado_aux)
		self.estado.clear()
		self.estado=list(self.estado_aux)
		self.estado_aux.clear() 
	def estado_q0(self,q):
		print("Estado q0")
		if q in self.mayusculas:
			self.estado_aux.append("q1")
		else:
			self.estado_aux.append("m")
	def estado_q1(self,q):
		print("Estado q1")
		if q in self.minusculas:
			self.estado_aux.append("q1")
			self.estado_aux.append("q6")
		elif q==" ":
			self.estado_aux.append("q2")
		elif q==".":
			self.estado_aux.append("c0")
			self.estado_aux.append("q4")
		elif q==",":
			self.estado_aux.append("q8")
		elif q==";":
			self.estado_aux.append("q9")
		else:
			return "m"
	def estado_q2(self,q):
		print("Estado q2")
		if q in self.minusculas:
			self.estado_aux.append("q1")
		else:
			self.estado_aux.append("m")
	def estado_q3(self,q):
		print("Estado q3")
		if q in self.mayusculas:
			self.estado_aux.append("q1")
		else:
			self.estado_aux.append("m")
	def estado_q4(self,q):
		print("Estado q4")
		if q==".":
			self.estado_aux.append("q5")
		else:
			self.estado_aux.append("m")
	def estado_q5(self,q):
		print("Estado q5")
		if q==".":
			self.estado_aux.append("c1")
		else:
			self.estado_aux.append("m")
	def estado_q6(self,q):
		print("Estado q6")
		if q=="-":
			self.estado_aux.append("q7")
		else:
			self.estado_aux.append("m")
	def estado_q7(self,q):
		print("Estado q7")
		if q in self.minusculas:
			self.estado_aux.append("q1")
		else:
			self.estado_aux.append("m")
	def estado_q8(self,q):
		print("Estado q8")
		if q==" ":
			self.estado_aux.append("q2")
		else:
			self.estado_aux.append("m")
	def estado_q9(self,q):
		print("Estado q9")
		if q==" ":
			self.estado_aux.append("q2")
		else:
			self.estado_aux.append("m")
	def estado_c0(self,q):
		print("Estado c0")
		if q==" ":
			self.estado_aux.append("q3")
		else:
			self.estado_aux.append("m")
	def estado_c1(self,q):
		print("Estado c1")
		if q==" ":
			self.estado_aux.append("q3")
		else:
			self.estado_aux.append("m")