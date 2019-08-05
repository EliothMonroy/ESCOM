import json
import os.path
from SNMP import getInfo, consultav2SNMP, consultav3SNMP
def obtenerAgentes():
	print("Voy a obtener los agentes")
	with open('agentes.json','r') as f:
		if os.path.getsize('agentes.json') > 0:
			#print("Existe al menos un agente")
			data=json.load(f)
			return list(data.keys())
		else:
			pass
			#print("No hay agentes registrados")
	return []
def obtenerInfoPrincipalAgente(id):
	data={}
	info=[]
	with open('agentes.json','r') as f:
		if os.path.getsize('agentes.json') > 0:
			data=json.load(f)
	#0->hostname
	info.append(data[id]["hostname"])
	#1->ip
	info.append(data[id]["ip"])
	#2-> estado conexión
	res=consultav2SNMP(data[id]["comunidad"],data[id]["ip"],int(data[id]["version"]),0,'SNMPv2-MIB','sysName',int(data[id]["puerto"]))
	if res=="":
		info.append(0)
	else:
		info.append(1)
	#info.append(consultav2SNMP(data[id]["comunidad"],data[id]["ip"],int(data[id]["version"]),0,'SNMPv2-MIB','sysUpTime',int(data[id]["puerto"])))
	#info.append(consultav3SNMP(data[id]["comunidad"],data[id]["ip"],int(data[id]["version"]),'1.3.6.1.2.1.1.3',int(data[id]["puerto"])))
	info.append(data[id]["comunidad"])
	info.append(data[id]["version"])
	info.append(data[id]["puerto"])
	return info

def obtenerInfoAgente(id):
	data={}
	info=[]
	with open('agentes.json','r') as f:
		if os.path.getsize('agentes.json') > 0:
			data=json.load(f)

	aux=getInfo(data[id]["comunidad"],data[id]["ip"],int(data[id]["version"]),int(data[id]["puerto"]))
	#obtener nombre versión y logo SO, número de interfaces de red, tiempo de actividad desde último reinicio,
	#ubicación física e información de contacto del administrador
	#0->nombre so
	if "Ubuntu" in aux[1]:
		info.append("Ubuntu")
		info.append("ubuntu.png")
	elif "Windows" in aux[1]:
		info.append("Windows")
		info.append("windows.png")
	elif "Darwin" in aux[1]:
		info.append("MacOs")
		info.append("macos.png")
	else:
		info.append("Linux")
		info.append("linux.png")
	continuar=0
	info.append("Sin especificar")
	for a in aux[1].split():
		if continuar==1:
			info[2]=a
			break
		if "Version" in a:
			continuar=1
	info.append(aux[2])
	#info.append(int(aux[3])/100)
	info.append(aux[3])
	info.append(aux[4])
	#print (info)
	return info

def eliminar(id_agente):
	data={}
	with open('agentes.json','r+') as f:
		if os.path.getsize('agentes.json') > 0:
			data=json.load(f)
			data.pop(id_agente,None)
			#print(data)
			f.seek(0)
	with open('agentes.json','w') as f:
		json.dump(data,f,sort_keys="True",indent=4)
	from gestor import Gestor
	gestor=Gestor()

class Agente():
	def __init__(self,id_agente):
		self.id_agente=id_agente
		self.hostname, self.ip, self.conexion, self.comunidad, self.version, self.puerto = obtenerInfoPrincipalAgente(id_agente)
		self.nombre_so, self.logo_so, self.version_so, self.num_interfaces, self.ubicacion, self.contacto=obtenerInfoAgente(id_agente)
		#Falta obtener tiempo de reinicio

