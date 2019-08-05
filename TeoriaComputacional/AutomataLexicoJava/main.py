from automata import Automata
def main():
	archivo=open("prueba.java","r")
	linea=1
	estados_aceptacion=("c0","c1","c2","c3","c4")
	imprimir_error=False
	conteo_errores=0
	for line in archivo.readlines():
		if ("0" in line or "1" in line or "2" in line or "3" in line or "4" in line or "5" in line or "6" in line or "7" in line or "8" in line or "9" in line):
			palabras=line.split(" ")
			for pal in palabras:
				if ("0" in pal or "1" in pal or "2" in pal or "3" in pal or "4" in pal or "5" in pal or "6" in pal or "7" in pal or "8" in pal or "9" in pal):
					auto=Automata()
					#pal=pal.replace("\n","")
					for c in pal:
						#print(auto.estado)
						#print(c)
						auto.calcular_estado(c.lower())
					if (auto.estado not in estados_aceptacion):
						#print(auto.estado)
						imprimir_error=True
						conteo_errores+=1
		if imprimir_error:
			print ("Error en linea: ",linea)
		imprimir_error=False
		linea+=1
	if conteo_errores==0:
		print("No hay errores lexicos en el programa")
main()