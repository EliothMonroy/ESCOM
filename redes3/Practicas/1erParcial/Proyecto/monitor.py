from tkinter import *
from PIL import Image, ImageTk
import threading, time, calendar
from agente import Agente
from SNMP import crearRRDDos, consultaSNMP
import rrdtool
class Monitor(threading.Thread):
	"""docstring for Agente"""
	def __init__(self,id_agente):
		threading.Thread.__init__(self)
		self.agente=Agente(id_agente)
		self.data={}
		self.top=Toplevel()
		self.top.geometry("1500x800")
		self.top.resizable(0,0)
		self.b = Button(self.top, text="Salir", command=self.salir)
		self.b.grid(row=1, column=2, sticky=W+E+N+S)
		self.frame=Frame(self.top, width = 600, height = 200, relief = 'raised', borderwidth=2)
		self.frame.grid(row = 1, column = 0, columnspan=1,  sticky=W+E+N+S)
		self.continuar=True
		self.image=[""]*5
		self.photo=[""]*5
		self.label=[""]*5
		self.mostrarInfo()
		self.crearRRDs()
	def run(self):
		while self.continuar:
			#Interfaces
			self.graficarRRD('IF-MIB','ifInOctets','ifOutOctets',"interfaz","Tráfico de red en interfaces ('ifInOctets,ifOutOctets')",2)
			#ICMP ->Deprecated
			self.graficarRRD('IP-MIB','icmpInMsgs','icmpOutMsgs',"icmp","Tráfico ICMP ('icmpInMsgs','icmpOutMsgs')",0)
			#TCP
			self.graficarRRD('TCP-MIB','tcpInSegs','tcpOutSegs',"tcp","Tráfico segmentos TCP ('tcpInSegs','tcpOutSegs')",0)
			#UDP
			self.graficarRRD('UDP-MIB','udpInDatagrams','udpOutDatagrams',"udp","Tráfico UDP Datagramas ('udpInDatagrams','udpOutDatagrams')",0)
			#SNMP
			self.graficarRRD('SNMPv2-MIB','snmpInPkts','snmpOutPkts',"snmp", "Tráfico SNMP ('snmpInPkts','snmpOutPkts')",0)

			#Ahora actualizamos las imagenes
			self.actualizarImagen(0,self.agente.hostname+"_"+self.agente.id_agente+"_interfaz.png",3,2)

			self.actualizarImagen(0,self.agente.hostname+"_"+self.agente.id_agente+"_icmp.png",4,2)

			self.actualizarImagen(0,self.agente.hostname+"_"+self.agente.id_agente+"_tcp.png",3,0)

			self.actualizarImagen(0,self.agente.hostname+"_"+self.agente.id_agente+"_udp.png",3,3)

			self.actualizarImagen(0,self.agente.hostname+"_"+self.agente.id_agente+"_snmp.png",4,3)

			time.sleep(5)
		self.top.destroy()
	def salir(self):
		self.continuar=False
	def mostrarInfo(self):
		image1=Image.open(self.agente.logo_so).resize((60,60),Image.ANTIALIAS)
		photo1=ImageTk.PhotoImage(image1)
		label1=Label(self.frame,image=photo1)
		label1.image=photo1
		label1.grid(row=1, column=1, sticky=W+E+N+S)
		Label(self.frame, text="ID agente: "+self.agente.id_agente).grid(row=2, column=1, sticky=W)
		Label(self.frame, text="Hostname: "+self.agente.hostname).grid(row=3, column=1, sticky=W)
		Label(self.frame, text="IP: "+self.agente.ip).grid(row=4, column=1, sticky=W)
		Label(self.frame, text="Comunidad: "+self.agente.comunidad).grid(row=5, column=1, sticky=W)
		Label(self.frame, text="Version: "+str((int(self.agente.version))+1)).grid(row=6, column=1, sticky=W)
		Label(self.frame, text="Puerto: "+self.agente.puerto).grid(row=7, column=1, sticky=W)
		Label(self.frame, text="Nombre SO: "+self.agente.nombre_so).grid(row=2, column=2, sticky=W)
		Label(self.frame, text="Versión SO: "+self.agente.version_so).grid(row=3, column=2, sticky=W)
		Label(self.frame, text="Número de interfaces: "+self.agente.num_interfaces).grid(row=4, column=2, sticky=W)
		Label(self.frame, text="Ubicación física: "+self.agente.ubicacion).grid(row=5, column=2, sticky=W)
		Label(self.frame, text="Contacto: "+self.agente.contacto).grid(row=6, column=2, sticky=W)
	def crearRRDs(self):
		#Para tr{afico de red:
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_interfaz.rrd","N","1","60","1","1","100","100")
		#Para tr{afico de IP
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_icmp.rrd","N","1","60","1","1","100","100")
		#Para tr{afico de TCP segmentos
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_tcp.rrd","N","1","60","1","1","100","100")
		#Para tr{afico de Datagramas UDP
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_udp.rrd","N","1","60","1","1","100","100")
		#Para tr{afico de SNMP
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_snmp.rrd","N","1","60","1","1","100","100")
	def graficarRRD(self, grupo, oid1, oid2, archivo, header, numero):
		tiempo_actual=calendar.timegm(time.gmtime())
		ultimo=rrdtool.last(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
		#Graficar 
		consulta=consultaSNMP(self.agente.comunidad,self.agente.ip,int(self.agente.version),numero,grupo,oid1,oid2,int(self.agente.puerto))
		if consulta[0]!="" or consulta[1]!="":
			valor = "N:" + str(consulta[0]) + ':' + str(consulta[1])
			#print (valor)
			rrdtool.update(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd", valor)
			rrdtool.dump(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd",self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".xml")
			ret = rrdtool.graph(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".png",
		                     "--start",str(ultimo-100),
		                     "--end","+100",
		                     "--vertical-label=Bytes/s",
		                     "--title="+header,
		                     "DEF:in="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:in:AVERAGE",
		                     "DEF:out="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:out:AVERAGE",
		                     "LINE1:in#00FF00:In traffic",
		                     "LINE1:out#0000FF:Out traffic")
		else:
			pass
	def actualizarImagen(self,index,archivo,fila,columna):
		self.image[index]=Image.open(archivo).resize((400,200),Image.ANTIALIAS)
		self.photo[index]=ImageTk.PhotoImage(self.image[index])
		self.label[index]=Label(self.top,image=self.photo[index])
		self.label[index].image=self.photo[index]
		self.label[index].grid(row=fila, column=columna, sticky=W)


