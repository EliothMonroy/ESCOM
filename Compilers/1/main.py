from afd import AFD
from afnd import AFND
from archivo import ArchivoAutomata
def main():
	ejecutar="1"
	while ejecutar=="1":
		seleccion=input("Por favor indique el tipo de automata a crear:\n(1)AFD\t(2)AFND\n")
		if seleccion=="1":
			nombre_archivo=input("Por favor ingrese el nombre del archivo de entrada: \nEjem: entrada.txt\n")
			print("El automata se construira con base al archivo: "+nombre_archivo)
			archivo=ArchivoAutomata(nombre_archivo)
			automata=AFD(archivo.obtenerAlfabeto(),archivo.obtenerAlfabeto(),archivo.obtenerFuncionTransicion(),archivo.obtenerEstadoInicial(),archivo.obtenerEstadosFinales())
			print("<> Automata Finito Determinista Creado <>\n")
			continuar="1"
			while continuar=="1":
				cadena=input("Por favor ingrese una cadena para validarla:\n")
				print(automata.validarCadena(cadena))
				continuar=input("Desea probar otra cadena?\n (1)Si\t(2)No:\n")
		else:
			nombre_archivo=input("Por favor ingrese el nombre del archivo de entrada: \nEjem: entrada.txt\n")
			print("El automata se construira con base al archivo: "+nombre_archivo)
			archivo=ArchivoAutomata(nombre_archivo)
			automata=AFND(archivo.obtenerAlfabeto(),archivo.obtenerAlfabeto(),archivo.obtenerFuncionTransicion(),archivo.obtenerEstadoInicial(),archivo.obtenerEstadosFinales())
			print("<> Automata Finito No Determinista Creado <>\n")
			continuar="1"
			while continuar=="1":
				cadena=input("Por favor ingrese una cadena para validarla:\n")
				print(automata.validarCadena(cadena),"\n")
				continuar=input("Desea probar otra cadena?\n (1)Si\t(2)No:\n")
		ejecutar=input("Desea Continuar?:\n(1)Si\t(2)No:\n")
main()
