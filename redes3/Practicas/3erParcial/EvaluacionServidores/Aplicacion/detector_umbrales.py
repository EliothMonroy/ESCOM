from agente import Agente
from SNMP import *
import rrdtool
import time
class DetectorUmbrales():
	def __init__(self,id_agente,tiempo,intervalo):
		self.agente=Agente(id_agente)
		self.umbralCPU=self.umbralRAM=self.umbralHDD=90
		self.tiempo_inicio = float(0)
		self.tiempo=tiempo
		self.intervalo=intervalo
		self.crearRDDs()
	def crearRDDs(self):
		#Para CPU
		crearRRDUno(self.agente.hostname+"_"+self.agente.id_agente+"_cpu_umbral.rrd","N","1",str(self.tiempo*60),"1","1",str(self.tiempo*60),str(self.tiempo*60),"GAUGE")
		#Para Ram
		crearRRDTres(self.agente.hostname+"_"+self.agente.id_agente+"_ram_umbral.rrd","N","1",str(self.tiempo*60),"1","1","1",str(self.tiempo*60),str(self.tiempo*60),str(self.tiempo*60),"GAUGE")
		#Para HDD
		crearRRDTres(self.agente.hostname+"_"+self.agente.id_agente+"_hdd_umbral.rrd","N","1",str(self.tiempo*60),"1","1","1",str(self.tiempo*60),str(self.tiempo*60),str(self.tiempo*60),"GAUGE")
		with open("umbral_CPU.txt","w") as f:
			pass
		with open("umbral_RAM.txt","w") as f:
			pass
		with open("umbral_HDD.txt","w") as f:
			pass
	def obtenerUmbrales(self):
		self.tiempo_inicio=time.time()
		while float((time.time()-self.tiempo_inicio))<(float(self.tiempo*60)):
			if self.agente.nombre_so=="Ubuntu":
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu_umbral","Uso del Procesador",196608)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram_umbral", "Uso de RAM",1)
				#HDD
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd_umbral", "Uso de HHD",36)
			elif self.agente.nombre_so=="Windows":
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu_umbral","Uso del Procesador",6)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram_umbral", "Uso de RAM",3)
				#HDD
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd_umbral", "Uso de HHD",1)
			elif self.agente.nombre_so=="MacOs":
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu_umbral","Uso del Procesador",196608)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram_umbral", "Uso de RAM",1)
				#HDD->el 31 es tentativo
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd_umbral", "Uso de HDD",31)
			elif self.agente.nombre_so=="Linux":
				#CPU
				self.graficarCPU("HOST-RESOURCES-MIB","hrProcessorLoad","cpu_umbral","Uso del Procesador",1281)
				#RAM
				self.graficarRAM("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","ram_umbral", "Uso de RAM",1)
				#HDD
				self.graficarHDD("HOST-RESOURCES-MIB","hrStorageSize","hrStorageUsed","hrStorageAllocationUnits","hdd_umbral", "Uso de HHD",31)
			time.sleep(self.intervalo)
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
		                     "--end","+100",
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
			with open("umbral_CPU.txt","a") as f:
				f.write(str(valor)+"\n")
				f.flush()
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
		                     "--end","+100",
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
			with open("umbral_HDD.txt","a") as f:
				f.write(str(valor)+"\n")
				f.flush()

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
		                     "--end","+100",
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
			with open("umbral_RAM.txt","a") as f:
				f.write(str(valor)+"\n")
				f.flush()

detector=DetectorUmbrales("4",10,0)
detector.obtenerUmbrales()
