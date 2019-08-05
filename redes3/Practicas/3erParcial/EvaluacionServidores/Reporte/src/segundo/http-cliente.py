#tutorial https://docs.python.org/3.4/library/http.client.html
import http.client
import ssl, time

class HTTPMonitor():
	def __init__(self,url,puerto):
		self.url=url
		self.puerto=puerto
		self.status="Down"
		self.tiempo_respuesta="No disponible"
		self.tam="No disponible"
		self.ancho_banda="No disponible"
	def actualizar(self):
		try:
			#print (self.url)
			conn = http.client.HTTPSConnection(self.url,self.puerto,context=ssl._create_unverified_context())
			start = time.time()
			conn.request("GET", "/file")
			r1 = conn.getresponse()
			end=time.time()
			#print(r1.getheaders())
			#print("Status",r1.status)
			#print("Reason",r1.reason)
			data1=r1.read()
			#print(data1)
			self.tam=str(len(data1))
			self.tiempo_respuesta=str(end-start)
			self.status="Up"
			self.ancho_banda=str((len(data1)/1000)/(end-start))
			#print("---------------")
			#print("Tiempo de respuesta: "+self.tiempo_respuesta+" segundos")
			#print("Tamaño bytes respuesta: "+str(tam)+" bytes")
			#print("Ancho de banda de descarga: "++" Kb/s")
			#print("Status: Up")
		except Exception as e:
			#print(e)
			self.status="Down"
			self.tiempo_respuesta="No disponible"
			self.tam="No disponible"
			self.ancho_banda="No disponible"
	def imprimir(self):
		print("Tiempo de respuesta: "+self.tiempo_respuesta+" segundos")
		print("Tamaño bytes respuesta: "+self.tam+" bytes")
		print("Ancho de banda de descarga: "+self.ancho_banda+" Kb/s")
		print("Status: "+self.status)