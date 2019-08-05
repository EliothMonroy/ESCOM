from automata import Automata
def main():
	texto=open("texto.txt","r")
	auto=Automata()
	for letra in texto.read():
		if letra=="\n":
			letra=" "
		print(auto.estado)
		print(letra)
		auto.calcular_estado(letra)
	if "c0" in auto.estado or "c1" in auto.estado:
		print("No hay errores en tu escritura")
	else:
		print("Hay un error en el texto")
main()