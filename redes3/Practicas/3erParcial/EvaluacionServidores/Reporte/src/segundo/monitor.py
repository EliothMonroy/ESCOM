from tkinter import *
from PIL import Image, ImageTk
import threading, time, calendar
from agente import Agente
from SNMP import *
from notificador import Notificador
from logger import Logger
import rrdtool
from http_cliente import HTTPMonitor
from PDFM import PDF
from smtp_cliente import SENSOR
from Sensor_SSH import SSH
from ftp_cliente import FTPMonitor
from sensDNS import sensDNS

class Monitor(threading.Thread):
	"""docstring for Agente"""
	def __init__(self,id_agente):
		threading.Thread.__init__(self)
		self.agente=Agente(id_agente)
		self.data={}
		self.top=Toplevel()
		self.top.geometry("2100x800")
		self.top.resizable(0,0)
		self.b = Button(self.top, text="Salir", command=self.salir)
		self.b.grid(row=1, column=2, sticky=W+E+N+S)
		self.boton_pdf = Button(self.top, text="Generar reporte", command=self.generar_pdf)
		self.boton_pdf.grid(row=1, column=3, sticky=W+E+N+S)
		self.frame=Frame(self.top, width = 550, height = 150, relief = 'raised', borderwidth=3)
		self.frame.grid(row = 1, column = 0, columnspan=1,  sticky=W+E+N+S)
		self.continuar=True
		self.image=[""]*8
		self.photo=[""]*8
		self.label=[""]*8
		self.umbralCPU, self.umbralRAM, self.umbralHDD=self.obtenerUmbrales()
		self.notificacionCPU=self.notificacionRAM=self.notificacionHDD=False
		self.noti=Notificador(self.agente.hostname)
		self.log=Logger(self.agente.hostname)
		self.mostrarInfo()
		self.crearRRDs()
		#sensores
		self.monitorHTPP=HTTPMonitor(self.agente.ip,5000)
		self.monitorSMTP=SENSOR()
		#self.monitorSSH=SSH(self.agente.ip,"gabs","0001")
		self.monitorFTP=FTPMonitor(self.agente.ip,"gabs","0001")
		self.monitorDNS=sensDNS()
	def run(self):
		while self.continuar:

			#Monitorear HTTP
			self.monitorHTPP.actualizar()
			#self.monitorHTPP.imprimir()
			#Monitorear SMTP
			self.monitorSMTP.scan_smtp()

			#self.monitorSSH.SSHConnection()
			self.monitorFTP.actualizar_SensorFTP()
			self.monitorFTP.actualizar_SensorFTP_SFC()
			self.monitorDNS.dnsServer('lostani.ex.net')


			#Interfaces
			self.graficarRRD('IF-MIB','ifInOctets','ifOutOctets',"interfaz","Tráfico de red en interfaces ('ifInOctets,ifOutOctets')",2)
			#ICMP ->Deprecated
			self.graficarRRD('IP-MIB','icmpInMsgs','icmpOutMsgs',"icmp","Tráfico ICMP ('icmpInMsgs','icmpOutMsgs')",0)
			#TCP
			self.graficarRRD('TCP-MIB','tcpInSegs','tcpOutSegs',"tcp","Tráfico segmentos TCP ('tcpInSegs','tcpOutSegs')",0)
			#SNMP
			self.graficarRRD('SNMPv2-MIB','snmpInPkts','snmpOutPkts',"snmp", "Tráfico SNMP ('snmpInPkts','snmpOutPkts')",0)
			########################
			#LOS ULTIMOS VALORES PARA CPU, RAM Y HDD, VARIAN PARA WINDOWS Y LINUX
			#PARA WINDOWS LOS VALORES SON: 6,3,1
			#PARA LINUX SON: 196608,1,36
			##########################
			if self.agente.nombre_so=="Ubuntu":
				#UDP
				self.graficarRRD('UDP-MIB','udpInDatagrams','udpOutDatagrams',"udp","Tráfico UDP Datagramas ('udpInDatagrams','udpOutDatagrams')",0)
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu","Uso del Procesador",196608)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram", "Uso de RAM",1)
				#HDD
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd", "Uso de HHD",36)
			elif self.agente.nombre_so=="Windows":
				#UDP
				self.graficarRRD('UDP-MIB','udpInDatagrams','udpOutDatagrams',"udp","Tráfico UDP Datagramas ('udpInDatagrams','udpOutDatagrams')",0)
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu","Uso del Procesador",6)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram", "Uso de RAM",3)
				#HDD
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd", "Uso de HHD",1)
			elif self.agente.nombre_so=="MacOs":
				#UDP
				self.graficarRRD('UDP-MIB','udpInErrors','udpOutDatagrams',"udp","Tráfico UDP Datagramas ('udpInDatagrams','udpOutDatagrams')",0)
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu","Uso del Procesador",196608)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram", "Uso de RAM",1)
				#HDD->el 31 es tentativo
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd", "Uso de HDD",31)
			elif self.agente.nombre_so=="Linux":
				#UDP
				self.graficarRRD('UDP-MIB','udpInDatagrams','udpOutDatagrams',"udp","Tráfico UDP Datagramas ('udpInDatagrams','udpOutDatagrams')",0)
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu","Uso del Procesador",1281)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram", "Uso de RAM",1)
				#HDD
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd", "Uso de HHD",31)

			#Ahora actualizamos las imágenes
			self.actualizarImagen(0,self.agente.hostname+"_"+self.agente.id_agente+"_interfaz.png",2,0)

			self.actualizarImagen(1,self.agente.hostname+"_"+self.agente.id_agente+"_icmp.png",3,0)

			self.actualizarImagen(2,self.agente.hostname+"_"+self.agente.id_agente+"_tcp.png",2,1)

			self.actualizarImagen(3,self.agente.hostname+"_"+self.agente.id_agente+"_udp.png",3,1)

			self.actualizarImagen(4,self.agente.hostname+"_"+self.agente.id_agente+"_snmp.png",2,2)

			self.actualizarImagen(5,self.agente.hostname+"_"+self.agente.id_agente+"_cpu.png",2,3)

			self.actualizarImagen(6,self.agente.hostname+"_"+self.agente.id_agente+"_ram.png",3,3)

			self.actualizarImagen(7,self.agente.hostname+"_"+self.agente.id_agente+"_hdd.png",2,4)

			time.sleep(5)
		self.top.destroy()
	def salir(self):
		self.continuar=False
	def generar_pdf(self):
		PDF(self.agente.id_agente,self.monitorHTPP,self.monitorSMTP,self.monitorFTP,self.monitorDNS,self.agente.hostname+"_"+self.agente.id_agente+"_cpu.png",self.agente.hostname+"_"+self.agente.id_agente+"_ram.png",self.agente.hostname+"_"+self.agente.id_agente+"_hdd.png")
	def obtenerUmbrales(self):
		umbrales=[]
		with open("umbrales.txt") as f:
			for i, linea in enumerate(f):
				umbrales.append(linea.split(":")[1])
		return umbrales
	def mostrarInfo(self):
		image1=Image.open(self.agente.logo_so).resize((50,50),Image.ANTIALIAS)
		photo1=ImageTk.PhotoImage(image1)
		label1=Label(self.frame,image=photo1)
		label1.image=photo1
		label1.grid(row=1, column=1, sticky=W+E+N+S)
		Label(self.frame, text="ID agente: "+self.agente.id_agente).grid(row=2, column=1, sticky=W)
		Label(self.frame, text="Hostname: "+self.agente.hostname).grid(row=3, column=1, sticky=W)
		Label(self.frame, text="IP: "+self.agente.ip).grid(row=4, column=1, sticky=W)
		Label(self.frame, text="Comunidad: "+self.agente.comunidad).grid(row=5, column=1, sticky=W)
		Label(self.frame, text="Versión SNMP: "+str((int(self.agente.version))+1)).grid(row=6, column=1, sticky=W)
		Label(self.frame, text="Puerto: "+self.agente.puerto).grid(row=7, column=1, sticky=W)
		Label(self.frame, text="Nombre SO: "+self.agente.nombre_so).grid(row=2, column=2, sticky=W)
		Label(self.frame, text="Versión SO: "+self.agente.version_so).grid(row=3, column=2, sticky=W)
		Label(self.frame, text="Número de interfaces: "+self.agente.num_interfaces).grid(row=4, column=2, sticky=W)
		Label(self.frame, text="Ubicación física: "+self.agente.ubicacion).grid(row=5, column=2, sticky=W)
		Label(self.frame, text="Contacto: "+self.agente.contacto).grid(row=6, column=2, sticky=W)
	def crearRRDs(self):
		#Para tr{afico de red:
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_interfaz.rrd","N","1","60","1","1","100","100","COUNTER")
		#Para tr{afico de IP
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_icmp.rrd","N","1","60","1","1","100","100","GAUGE")
		#Para tr{afico de TCP segmentos
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_tcp.rrd","N","1","60","1","1","100","100","GAUGE")
		#Para tr{afico de Datagramas UDP
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_udp.rrd","N","1","60","1","1","100","100","COUNTER")
		#Para tr{afico de SNMP
		crearRRDDos(self.agente.hostname+"_"+self.agente.id_agente+"_snmp.rrd","N","1","60","1","1","100","100","COUNTER")
		#Para CPU
		crearRRDUno(self.agente.hostname+"_"+self.agente.id_agente+"_cpu.rrd","N","1","60","1","1","100","100","GAUGE")
		#Para Ram
		crearRRDTres(self.agente.hostname+"_"+self.agente.id_agente+"_ram.rrd","N","1","60","1","1","1","100","100","100","GAUGE")
		#Para HDD
		crearRRDTres(self.agente.hostname+"_"+self.agente.id_agente+"_hdd.rrd","N","1","60","1","1","1","100","100","100","GAUGE")

	def graficarRRD(self, grupo, oid1, oid2, archivo, header, numero):
		ultimo=rrdtool.last(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
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
	def graficarCPU(self, grupo, oid1, archivo, header, numero):
		umbral=int(self.umbralCPU)
		ultimo=rrdtool.last(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
		primero=rrdtool.first(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
		consulta=consultav2SNMP(self.agente.comunidad,self.agente.ip,int(self.agente.version),numero,grupo,oid1,int(self.agente.puerto))
		if consulta!="":
			valor = "N:" + str(consulta)
			rrdtool.update(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd", valor)
			rrdtool.dump(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd",self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".xml")
			ret = rrdtool.graphv(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".png",
		                     "--start",str(ultimo-100),
		                     "--end",str(ultimo+100),
		                     #"--end",str(ultimo+200),
		                     "--vertical-label=Porcentaje/s",
		                     "--title="+header,
						     "--lower-limit","0",
						     "--upper-limit","100",
		                     "DEF:usage="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:valor1:AVERAGE",
		                     "CDEF:umbral"+str(umbral-20)+"_1=usage,"+str(umbral-20)+",GT,usage,"+str(umbral-10)+",LT,EQ,usage,0,IF",
						     "CDEF:umbral"+str(umbral-10)+"_1=usage,"+str(umbral-10)+",GT,usage,"+str(umbral)+",LT,EQ,usage,0,IF",
						     "CDEF:umbral"+str(umbral)+"_1=usage,"+str(umbral)+",GT,usage,"+str(umbral+(100-umbral))+",LT,EQ,usage,0,IF",
						     "AREA:usage#FFBB0077:Uso de CPU",
		                     "VDEF:m=usage,LSLSLOPE",
		                     "VDEF:b=usage,LSLINT",
		                     "CDEF:avg=usage,POP,m,COUNT,*,b,+",
						     "CDEF:umbral"+str(umbral-20)+"=avg,"+str(umbral-20)+","+str(umbral-10)+",LIMIT",
						     "CDEF:umbral"+str(umbral-10)+"=avg,"+str(umbral-10)+","+str(umbral)+",LIMIT",
						     "CDEF:umbral"+str(umbral)+"=avg,"+str(umbral)+","+str(umbral+(100-umbral))+",LIMIT",
						     "VDEF:minUmbral"+str(umbral)+"=umbral"+str(umbral)+",FIRST",
						     "VDEF:last=usage,LAST",
						     "PRINT:last:%6.2lf %S",
						     "GPRINT:minUmbral"+str(umbral)+": Se alcanzará el "+str(umbral)+"% @ %c :strftime",
		                     "LINE1:avg#FF9F00",
     				    	 "LINE2:"+str(umbral-20),
						     "AREA:10#FF000022::STACK",
						     "AREA:10#FF000044::STACK",
						     "AREA:"+str(100-umbral)+"#FF000066::STACK",
					         "AREA:umbral"+str(umbral-20)+"#0077FF77:Tráfico de carga mayor que el "+str(umbral-20)+" y menor que el "+str(umbral-10)+" por ciento",
						     "AREA:umbral"+str(umbral-10)+"#00880077:Tráfico de carga mayor que el "+str(umbral-10)+" y menor que el "+str(umbral)+" por ciento",
						     "AREA:umbral"+str(umbral)+"#FF000088:Tráfico de carga mayor que el "+str(umbral)+" y menor que el "+str(umbral+(100-umbral))+" por ciento",
						     "AREA:umbral"+str(umbral-20)+"_1#0077FF77",
						     "AREA:umbral"+str(umbral-10)+"_1#00880077",
						     "AREA:umbral"+str(umbral)+"_1#FF000088")
			valor=float(ret["print[0]"])
			if valor>float(umbral):
				if not self.notificacionCPU:
					self.notificacionCPU=True
					#self.noti.enviarCorreo(0,self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".png")
					self.log.escribirLog(0)
			else:
				self.notificacionCPU=False

	def graficarHDD(self, grupo, oid1, oid2,oid3, archivo, header, numero):
		umbral=int(self.umbralHDD)
		ultimo=rrdtool.last(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
		primero=rrdtool.first(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
		consulta=consultav5SNMP(self.agente.comunidad,self.agente.ip,int(self.agente.version),numero,grupo,oid1,oid2,oid3,int(self.agente.puerto))
		if consulta[0]!="" or consulta[1]!="" or consulta[2]!="":
			valor = "N:" + str(consulta[0]) + ':' + str(consulta[1]) + ':' + str(consulta[2])
			rrdtool.update(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd", valor)
			rrdtool.dump(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd",self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".xml")
			ret = rrdtool.graphv(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".png",
		                     "--start",str(ultimo-100),
		                     "--end",str(ultimo+100),
		                     "--vertical-label=Porcentaje/s",
		                     "--title="+header,
		                     "--lower-limit","0",
				     		 "--upper-limit","100",
		                     "DEF:val1="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:size:AVERAGE",
		                     "DEF:val2="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:used:AVERAGE",
		                     "DEF:val3="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:all:AVERAGE",
		                     "CDEF:totalHDD=val1,val3,*",
		                     "CDEF:usoHDDporcentaje=val2,val3,*,100,*,totalHDD,/",
						     "CDEF:usoHDD=val2,val3,*",
						     "CDEF:umbral"+str(umbral-20)+"_1=usoHDDporcentaje,"+str(umbral-20)+",GT,usoHDDporcentaje,"+str(umbral-10)+",LT,EQ,usoHDDporcentaje,0,IF",
						     "CDEF:umbral"+str(umbral-10)+"_1=usoHDDporcentaje,"+str(umbral-10)+",GT,usoHDDporcentaje,"+str(umbral)+",LT,EQ,usoHDDporcentaje,0,IF",
						     "CDEF:umbral"+str(umbral)+"_1=usoHDDporcentaje,"+str(umbral)+",GT,usoHDDporcentaje,"+str(umbral+(100-umbral))+",LT,EQ,usoHDDporcentaje,0,IF",
				             "AREA:usoHDDporcentaje#FFBB0077:HDD en uso",
						     "VDEF:m=usoHDDporcentaje,LSLSLOPE",
		                     "VDEF:b=usoHDDporcentaje,LSLINT",
		                     "CDEF:avg=usoHDDporcentaje,POP,m,COUNT,*,b,+",
		                     "CDEF:umbral"+str(umbral-20)+"=avg,"+str(umbral-20)+","+str(umbral-10)+",LIMIT",
						     "CDEF:umbral"+str(umbral-10)+"=avg,"+str(umbral-10)+","+str(umbral)+",LIMIT",
						     "CDEF:umbral"+str(umbral)+"=avg,"+str(umbral)+","+str(umbral+(100-umbral))+",LIMIT",
						     "VDEF:minUmbral"+str(umbral)+"=umbral"+str(umbral)+",FIRST",
						     "VDEF:last=usoHDDporcentaje,LAST",
						     "PRINT:last:%6.2lf %S",
						     "GPRINT:minUmbral"+str(umbral)+": Se alcanzará el "+str(umbral)+"% @ %c :strftime",
						     "LINE1:avg#FF9F00",
					         "LINE3:"+str(umbral-20),
						     "AREA:10#FF000022::STACK",
						     "AREA:10#FF000044::STACK",
						     "AREA:"+str(100-umbral)+"#FF000066::STACK",
						     "AREA:umbral"+str(umbral-20)+"#0077FF77:Uso mayor que el "+str(umbral-20)+" y menor que el "+str(umbral-10)+" por ciento",
						     "AREA:umbral"+str(umbral-10)+"#00880077:Uso mayor que el "+str(umbral-10)+" y menor que el "+str(umbral)+" por ciento",
						     "AREA:umbral"+str(umbral)+"#FF000088:Uso mayor que el "+str(umbral)+" y menor que el "+str(umbral+(100-umbral))+" por ciento",
						     "AREA:umbral"+str(umbral-20)+"_1#0077FF77",
						     "AREA:umbral"+str(umbral-10)+"_1#00880077",
						     "AREA:umbral"+str(umbral)+"_1#FF000088")
			valor=float(ret["print[0]"])
			if valor>float(umbral):
				if not self.notificacionHDD:
					self.notificacionHDD=True
					#self.noti.enviarCorreo(2,self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".png")
					self.log.escribirLog(2)
			else:
				self.notificacionHDD=False

	def graficarRAM(self, grupo, oid1, oid2,oid3, archivo, header, numero):
		umbral=int(self.umbralRAM)
		ultimo=rrdtool.last(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
		primero=rrdtool.first(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd")
		consulta=consultav5SNMP(self.agente.comunidad,self.agente.ip,int(self.agente.version),numero,grupo,oid1,oid2,oid3,int(self.agente.puerto))
		if consulta[0]!="" or consulta[1]!="" or consulta[2]!="":
			valor = "N:" + str(consulta[0]) + ':' + str(consulta[1]) + ':' + str(consulta[2])
			rrdtool.update(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd", valor)
			rrdtool.dump(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd",self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".xml")
			ret = rrdtool.graphv(self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".png",
		                     "--start",str(ultimo-100),
		                     "--end",str(ultimo+100),
		                     "--vertical-label=Porcentaje/s",
		                     "--title="+header,
		                     "--lower-limit","0",
				     		 "--upper-limit","100",
		                     "DEF:val1="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:size:AVERAGE",
		                     "DEF:val2="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:used:AVERAGE",
		                     "DEF:val3="+self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".rrd:all:AVERAGE",
		                     "CDEF:totalRAM=val1,val3,*",
		                     "CDEF:usoRAMporcentaje=val2,val3,*,100,*,totalRAM,/",
						     "CDEF:usoRAM=val2,val3,*",
						     "CDEF:umbral"+str(umbral-20)+"_1=usoRAMporcentaje,"+str(umbral-20)+",GT,usoRAMporcentaje,"+str(umbral-10)+",LT,EQ,usoRAMporcentaje,0,IF",
						     "CDEF:umbral"+str(umbral-10)+"_1=usoRAMporcentaje,"+str(umbral-10)+",GT,usoRAMporcentaje,"+str(umbral)+",LT,EQ,usoRAMporcentaje,0,IF",
						     "CDEF:umbral"+str(umbral)+"_1=usoRAMporcentaje,"+str(umbral)+",GT,usoRAMporcentaje,"+str(umbral+(100-umbral))+",LT,EQ,usoRAMporcentaje,0,IF",
				             "AREA:usoRAMporcentaje#FFBB0077:En uso",
						     "VDEF:m=usoRAMporcentaje,LSLSLOPE",
		                     "VDEF:b=usoRAMporcentaje,LSLINT",
		                     "CDEF:avg=usoRAMporcentaje,POP,m,COUNT,*,b,+",
					         "CDEF:umbral"+str(umbral-20)+"=avg,"+str(umbral-20)+","+str(umbral-10)+",LIMIT",
						     "CDEF:umbral"+str(umbral-10)+"=avg,"+str(umbral-10)+","+str(umbral)+",LIMIT",
						     "CDEF:umbral"+str(umbral)+"=avg,"+str(umbral)+","+str(umbral+(100-umbral))+",LIMIT",
						     "VDEF:minUmbral"+str(umbral)+"=umbral"+str(umbral)+",FIRST",
						     "VDEF:last=usoRAMporcentaje,LAST",
						     "PRINT:last:%6.2lf %S",
						     "GPRINT:minUmbral"+str(umbral)+": Se alcanzará el "+str(umbral)+"% @ %c :strftime",
		                     "LINE1:avg#FF9F00",
					         "LINE3:"+str(umbral-20),
						     "AREA:10#FF000022::STACK",
						     "AREA:10#FF000044::STACK",
						     "AREA:"+str(100-umbral)+"#FF000066::STACK",
						     "AREA:umbral"+str(umbral-20)+"#0077FF77:Uso mayor que el "+str(umbral-20)+" y menor que el "+str(umbral-10)+" por ciento",
						     "AREA:umbral"+str(umbral-10)+"#00880077:Uso mayor que el "+str(umbral-10)+" y menor que el "+str(umbral)+" por ciento",
						     "AREA:umbral"+str(umbral)+"#FF000088:Uso mayor que el "+str(umbral)+" y menor que el "+str(umbral+(100-umbral))+" por ciento",
						     "AREA:umbral"+str(umbral-20)+"_1#0077FF77",
						     "AREA:umbral"+str(umbral-10)+"_1#00880077",
						     "AREA:umbral"+str(umbral)+"_1#FF000088")
			valor=float(ret["print[0]"])
			if valor>float(umbral):
				if not self.notificacionRAM:
					self.notificacionRAM=True
					#self.noti.enviarCorreo(1,self.agente.hostname+"_"+self.agente.id_agente+"_"+archivo+".png")
					self.log.escribirLog(1)
			else:
				self.notificacionRAM=False

	def actualizarImagen(self,index,archivo,fila,columna):
		self.image[index]=Image.open(archivo).resize((400,200),Image.ANTIALIAS)
		self.photo[index]=ImageTk.PhotoImage(self.image[index])
		self.label[index]=Label(self.top,image=self.photo[index])
		self.label[index].image=self.photo[index]
		self.label[index].grid(row=fila, column=columna, sticky=W)
