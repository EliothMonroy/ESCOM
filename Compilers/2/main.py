from afd import AFD
from afnd import AFND
from validador import Validador
#from archivo import ArchivoAutomata
def main():
	continuar=1
	while continuar:
		expresion=input("Por favor ingrese una expresión regular para generar el automata:\nEjemplo:ab*\n")
		validador=Validador(expresion)
		print(validador.esValida())
		
		continuar=int(input("Desea ingresar una nueva cadena?\nSi(1)\t No(0)\n"))
main()