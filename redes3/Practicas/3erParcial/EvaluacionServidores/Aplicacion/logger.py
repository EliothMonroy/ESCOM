import datetime
class Logger():
	def __init__(self,agente):
		self.agente=agente
	def escribirLog(self,tipo):
		contenido=self.obtenerContenido(tipo)
		hora=self.obtenerHora()
		with open('log.txt','a') as f:
			f.write(self.agente+contenido.replace("\n","")+hora+"\n")
			f.flush()
			print("Problema detectado, revisar archivo de log o correo electrónico")
	def obtenerContenido(self,tipo):
		with open("mensajes.txt") as f:
			for i, linea in enumerate(f):
				if i==tipo:
					return linea.split(";")[1]
			else:
				return ""
	def obtenerHora(self):
		return str(datetime.datetime.now())