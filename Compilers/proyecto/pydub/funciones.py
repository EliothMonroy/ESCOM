import array
from pydub import AudioSegment
def cargarWav(nombre):
	return AudioSegment.from_wav(nombre)
def concatenar(a,b):
	return a+b
def obtenerSamples(a):
	return a.get_array_of_samples()
def tocarMismoTiempo(a,b):
	muestras1 = a.get_array_of_samples()
	muestras2 = b.get_array_of_samples()
	muestras3=[None] * len(samples)
	count=0
	for i in samples:
		samples3[count]=int((muestras1[count]+muestras2[count])/2)
		count+=1
	samples3_arreglo=array.array(a.array_type, muestras3)
	return a._spawn(samples3_arreglo)
def exportarWav(a,nombre):
	a.export(nombre,format="wav")
