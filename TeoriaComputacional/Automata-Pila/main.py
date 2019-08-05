from automata import Automata
def main():
	archivo=open("prueba.c","r")#Abrimos el archivo para leerlo
	tipos_primitivos={"char","float","double","long","short","int"}#Se podrían agregar más
	estados_aceptacion={"c0","c1"}
	auto=None
	texto=archivo.read()
	numero_linea=0
	texto=texto.replace(";",";\n")
	for linea in texto.splitlines():
		if linea=="":
			continue
		else:
			numero_linea+=1
		for tipo in tipos_primitivos:
			if linea.startswith(tipo+" "):
				#print("Si empieza con algun tipo")
				linea=linea[len(tipo)+1:len(linea)]
				auto=Automata(1)
		if auto is None:
			#print("No se ha inicializado el automata")
			auto=Automata(None)
		print ("\nLinea %d a evaluar: %s"% (numero_linea,linea))
		for letra in linea.replace(" ",""):
			auto.calcularEstado(letra)
			print (auto.estado)
			if auto.estado=="m":
				print("La cadena %d no pertenece a la gramatica" % numero_linea)
				break
		if auto.estado in estados_aceptacion and not auto.pila:
			print("La cadena %d pertenece a la gramatica" % numero_linea)
		elif auto.estado is not "m":
			print("La cadena %d no pertenece a la gramatica" % numero_linea)
		auto=None

main()