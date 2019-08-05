#http://flautadulcegratis.blogspot.mx/2009/06/himno-la-alegria.html
import os.path
import array
from pydub import AudioSegment
class ManejadorWav:
	def __init__(self,tempo,instrumento,sincronizacion,arreglo_notas):
		self.tempo=tempo
		self.instrumento=instrumento
		self.sincronizacion=sincronizacion
		self.arreglo_notas=arreglo_notas
		if os.path.exists("salida.wav"):
			self.salida=self.cargarWav("salida.wav")
		else:
			self.salida=AudioSegment.empty()
	def crearWav(self):
		nuevo=AudioSegment.empty()
		nuevo=self.crearNotas(nuevo)
		if nuevo==-1:
			return -1
		if self.sincronizacion:
			aux=nuevo
			aux3=((self.sincronizacion*1000)+len(nuevo))-len(self.salida)
			if aux3>0:
				self.salida=self.salida+self.insertarSilencio(aux3)
			else:
				nuevo=nuevo+self.insertarSilencio(-(aux3))
			parte1=self.salida[:(self.sincronizacion*1000)]
			parte2=self.salida[(self.sincronizacion*1000):]
			self.salida=parte1+self.tocarMismoTiempo(parte2,nuevo)
			self.exportarWav(self.salida,"salida.wav")
			#print("Sincronizacion 1")
			#print("Duracion: ",len(self.salida))
			#print("Duracion nuevo: ",len(nuevo))
			return self.obtenerDuracion(parte1+aux)
		else:
			aux=nuevo
			if len(self.salida)==0:
				self.salida=nuevo
			else:
				nuevo=nuevo+self.insertarSilencio(len(self.salida)-len(nuevo))
				self.salida=self.tocarMismoTiempo(self.salida,nuevo)
			self.exportarWav(self.salida,"salida.wav")
			#print("Sincronizacion 0")
			#print("Duracion salida: ",len(self.salida))
			#print("Duracion nuevo: ",len(aux))
			return self.obtenerDuracion(aux)
	def crearNotas(self,track):
		for elemento in self.arreglo_notas:
			cont=0
			aux=[None] * len(elemento.notas)
			aux2=AudioSegment.empty()
			for a in elemento.notas:
				aux[cont]=self.cargarWav(self.instrumento+"/"+str(a)+".wav")
				aux[cont]=self.ajustarTempo(aux[cont],self.tempo,elemento.duracion)
				#Se excedio la duración de los 8 segundos
				if aux[cont]==-1:
					return -1
				cont+=1
			if cont>1:
				for i in range(cont-1):
					aux2=self.tocarMismoTiempo(aux[i],aux[i+1])
			else:
				aux2=aux[0]
			if len(track)==0:
				track=aux2*elemento.repetir
			else:
				track+=aux2*elemento.repetir
		return track
	def cargarWav(self,nombre):
		return AudioSegment.from_wav(nombre)
	def concatenar(self,a,b):
		return a+b
	def obtenerSamples(self,a):
		return a.get_array_of_samples()
	def tocarMismoTiempo(self,a,b):
		muestras1 = a.get_array_of_samples()
		muestras2 = b.get_array_of_samples()
		muestras3=[None] * len(muestras2)
		count=0
		for i in muestras3:
			if muestras1[count]==0 or muestras2[count]==0:
				muestras3[count]=int(muestras1[count]+muestras2[count])
			else:
				muestras3[count]=int((muestras1[count]+muestras2[count])/1.3)
			count+=1
		muestras3_arreglo=array.array(a.array_type, muestras3)
		return a._spawn(muestras3_arreglo)
	def exportarWav(self,a,nombre):
		a.export(nombre,format="wav")
	def obtenerDuracion(self,a):
		return len(a)/1000 #Devuelve la duración en segundos de un wav
	def ajustarTempo(self,a,tempo,duracion):
		nota_negra=60*1000/tempo
		#print("Nota negra*duracion:",nota_negra*duracion)
		if nota_negra*duracion>8000:
			return -1
		return a[:int(nota_negra*duracion)]
	def insertarSilencio(self,tiempo):
		return AudioSegment.empty()+AudioSegment.silent(duration=tiempo)
#mi-mi-fa-sol-sol-fa-mi-re-do-do-re-mi-mi-rere
#mi-mi-fa-sol-sol-fa-mi-re-do #

#Notas para pruebas
# Notami=Nota()
# Notami.duracion=.5
# Notami.notas=['mi']
# Notami.repetir=1
# Notafa=Nota()
# Notafa.duracion=.5
# Notafa.notas=['fa']
# Notasol=Nota()
# Notasol.duracion=.5
# Notasol.notas=['sol']
# Notare=Nota()
# Notare.duracion=.5
# Notare.notas=['re']
# Notado=Nota()
# Notado.duracion=.5
# Notado.notas=['do']
# arreglo_notas=[Notami,Notami,Notafa,Notasol,Notasol,Notafa,Notami,Notare,Notado,Notado,Notare,Notami,Notami,Notare,Notare,Notami,Notami,Notafa,Notasol,Notasol,Notafa,Notami,Notare,Notado]
# instrumento="Piano"
# tempo=120
# wav=ManejadorWav(tempo,instrumento,0,arreglo_notas)
# print(wav.crearWav())
