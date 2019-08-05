from tkinter import *
from tkinter import messagebox
import json
import os.path
#from main import Main

class AgregarAgente():
	"""docstring for Agente"""
	def __init__(self):
		#Creamos la ventana y sus medidas
		self.data={}
		self.top=Tk()
		self.top.geometry("500x500")
		self.top.resizable(0,0)
		#Definimos los elementos de la misma y a cada uno los acomodamos en el grid
		self.b = Button(self.top, text="Regresar", command=self.cancelar)
		self.b.grid(row=10, column=2, sticky=W+E+N+S)
		self.b = Button(self.top, text="Agregar agente", command=self.crearAgente)
		self.b.grid(row=10, column=1, sticky=W+E+N+S)

		Label(self.top, text="Hostname").grid(row=1, sticky=W)
		self.hostname=Entry(self.top)
		self.hostname.grid(row=1, column=1)
		Label(self.top, text="IP").grid(row=2, sticky=W)
		self.ip=Entry(self.top)
		self.ip.grid(row=2, column=1)
		Label(self.top, text="Versión SNMP").grid(row=3, sticky=W)
		self.version=Entry(self.top)
		self.version.grid(row=3, column=1)
		Label(self.top, text="Puerto").grid(row=4, sticky=W)
		self.puerto=Entry(self.top)
		self.puerto.insert(0, '161')
		self.puerto.grid(row=4, column=1)
		Label(self.top, text="Comunidad").grid(row=5, sticky=W)
		self.comunidad=Entry(self.top)
		self.comunidad.grid(row=5, column=1)
		#Final
		self.top.mainloop()
	#Regresar a la pantalla anterior
	def cancelar(self):
		self.top.destroy()
		#El import lo puse aquí por que si no marca un error extraño
		from gestor import Gestor
		self.gestor=Gestor()
	#Crear un agente nuevo
	def crearAgente(self):
		agente_id=1
		with open('agentes.json','r+') as f:
			if os.path.getsize('agentes.json') > 0:
				#print("No estoy vació")
				self.data = json.load(f)
				f.seek(0)
				llaves=list(self.data.keys())
				lista = [int(x) for x in llaves]
				lista.sort()
				agente_id=int(llaves[len(lista)-1])+1
			nuevo_agente={
				'hostname': self.hostname.get(),
				'ip': self.ip.get(),
				'version': self.version.get(),
				'puerto': self.puerto.get(),
				'comunidad': self.comunidad.get()
			}
			self.data[str(agente_id)]=nuevo_agente
			json.dump(self.data,f,sort_keys="True",indent=4)
		messagebox.showinfo("Éxito", "Agente registrado exitosamente")


