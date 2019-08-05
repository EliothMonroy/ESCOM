#https://www.tutorialspoint.com/python/python_gui_programming.htm
from tkinter import *
from agregar_agente import AgregarAgente
from agente import obtenerAgentes, obtenerInfoPrincipalAgente, eliminar
from monitor import Monitor
from functools import partial

class Gestor():
	"""Clase principal del programa"""
	def __init__(self):
		#Creamos la ventana y sus medidas
		self.top=Tk()
		self.top.geometry("800x600")
		self.top.resizable(0,0)
		#Definimos los elementos de la misma y a cada uno le hacemos un pack
		self.b = Button(self.top, text="Agregar agente", command=self.agregarAgente)
		self.b.grid(row=0, column=3, sticky=W+E+N+S)
		self.obtenerAgentes()
		#Final
		self.top.mainloop()
	def agregarAgente(self):
		#Destruimos la ventana actual y traemos a AgregarAgente
		self.top.destroy()
		self.agente=AgregarAgente()
	def monitorearAgente(self,id_agente):
		monitor=Monitor(id_agente)
		monitor.start()

	def eliminarAgente(self,id_agente):
		self.top.destroy()
		eliminar(id_agente)

	def obtenerAgentes(self):
		ids_agentes=obtenerAgentes()
		if len(ids_agentes)>0:
			Label(self.top, text="Total de agentes registrados: "+ str(len(ids_agentes))).grid(row=0, sticky=W)
		else:
			Label(self.top, text="No hay agentes registrados").grid(row=0, sticky=W)
		for id_agente in ids_agentes:
			info=obtenerInfoPrincipalAgente(id_agente)
			frame=Frame(self.top, width = 600, height = 200, relief = 'raised', borderwidth=2)
			frame.grid(row = int(id_agente), column = 0, columnspan=6,  sticky=W+E+N+S)
			Label(frame, text="ID agente: "+id_agente).grid(row=1, column=0, sticky=W)
			Label(frame, text="Hostname: "+info[0]).grid(row=2, column=0, sticky=W)
			Label(frame, text="IP: "+info[1]).grid(row=3, column=0, sticky=W)
			if info[2]==0:
				Label(frame, text="Estado de conexión: Desconectado").grid(row=4, column=0, sticky=W)
				Button(frame, text="Monitorear", state=DISABLED, command=partial(self.monitorearAgente,id_agente)).grid(row=2, column=3, sticky=E)
			else:
				Label(frame, text="Estado de conexión: Conectado").grid(row=4, column=0, sticky=W)
				Button(frame, text="Monitorear", command=partial(self.monitorearAgente,id_agente)).grid(row=2, column=3, sticky=E)
			#Label(frame, text="").grid(row=1, column=0, sticky=W)
			Button(frame, text="Eliminar", command=partial(self.eliminarAgente,id_agente)).grid(row=4, column=3, sticky=E)






