from tkinter import *
from tkinter import font as tkfont
import time
from maquina import MaquinaTuring

entrada = input("Ingrese la cadena a duplicar: ")
estados=["q0","q1","q2","q3"]
alfabeto=["1","Y","X","B"]
transiciones={
	("q0", "1"): ("q1", "X", "R"),
	("q0", "Y"): ("q3", "1", "R"),
	("q1", "1"): ("q1", "1", "R"),
	("q1", "Y"): ("q1", "Y", "R"),
	("q1", "B"): ("q2", "Y", "L"),
	("q2", "1"): ("q2", "1", "L"),
	("q2", "X"): ("q0", "1", "R"),
	("q2", "Y"): ("q2", "Y", "L"),
	("q3", "Y"): ("q3", "1", "R"),
}

maquina = MaquinaTuring(estados, alfabeto, transiciones, estados[0], estados[3], entrada)

master = Tk()
master.title("Turing")
c = Canvas(master, width=400, height=300)
c.pack()
tipo_letra = tkfont.Font(family="Helvetica", size=20)

flecha = c.create_line(175, 150, 175, 175, arrow=LAST, width=2)
texto = c.create_text(165, 200, text="".join(maquina.cadena), font=tipo_letra, anchor=W)
estado = c.create_text(120, 150, text=maquina.estado_actual, font=tipo_letra, anchor=W)

archivo = open("salida.txt", "w")
while not maquina.esFinal():
	print("Cadena: "+"".join(maquina.cadena))
	print("Estado actual: "+str(maquina.estado_actual)+", apuntador: "+str(maquina.apuntador+1)+"\n")

	archivo.write("Cadena: "+"".join(maquina.cadena)+"\n")
	archivo.write("Estado actual: "+str(maquina.estado_actual)+", apuntador: "+str(maquina.apuntador+1)+"\n")
	if not maquina.evaluar():
		print("-------------")
		archivo.write("---------------------")
		archivo.write("\n")
	print("Siguiente estado: "+str(maquina.estado_actual))
	print("-------------------")

	archivo.write("Siguiente estado: "+str(maquina.estado_actual))
	archivo.write("\n")
	archivo.write("-----------------")
	archivo.write("\n")

	master.update()
	time.sleep(.8)
	c.itemconfigure(texto, text="".join(maquina.cadena))
	c.itemconfigure(estado, text=str(maquina.estado_actual))
	if maquina.direccion == 'R':
		c.move(flecha, 10, 0)
	else:
		c.move(flecha, -10, 0)

print("Resultado: "+"".join(maquina.cadena))
archivo.write("Resultado: "+"".join(maquina.cadena)+"\n")
archivo.flush()
master.mainloop()