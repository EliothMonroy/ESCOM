#tutorial https://docs.python.org/3.4/library/http.client.html
import http.client
import ssl, time

def conectarse(url,puerto):
	i=0
	for i in range(1000):
		try:
			conn = http.client.HTTPSConnection(url,puerto,context=ssl._create_unverified_context())
			start = time.time()
			conn.request("GET", "/file")
			r1 = conn.getresponse()
			end=time.time()
			#print(r1.getheaders())
			#print("Status",r1.status)
			#print("Reason",r1.reason)
			data1=r1.read()
			#print(data1)
			tam=len(data1)
			tiempo_diferencia=end-start
			#print("---------------")
			#print("Tiempo de respuesta: "+str(tiempo_diferencia)+" segundos")
			#print("Tamaño bytes respuesta: "+str(tam)+" bytes")
			#print("Ancho de banda de descarga: "+str((tam/1000)/tiempo_diferencia)+" Kb/s")
			print("Status: Up")
		except:
			print("Status: Down")
	print ("Termine")
conectarse("localhost",5000)