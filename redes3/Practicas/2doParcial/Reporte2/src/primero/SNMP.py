from pysnmp.hlapi import *
import rrdtool
import time
#Funcion para obtener las interfaces
def getInterfaces(comunidad,host,version,puerto):
	resultado=""
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity('IF-MIB','ifNumber',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@'))))

	if errorIndication:
	    print(errorIndication)
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado=VarB.partition(' = ')[2]
	return resultado

#Funcion para obtener el estatus de una interfaz
def getStatus(comunidad,host,version,interfaz,puerto):
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity('IF-MIB','ifAdminStatus',interfaz).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@'))))

	if errorIndication:
	    print(errorIndication)
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado=VarB.partition(' = ')[2]
	return resultado

#Funcion para obtener informacion del estado del dispositivo
def getInfo(comunidad,host,version,puerto):
	resultado=[]
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity('SNMPv2-MIB','sysName',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		ObjectType(ObjectIdentity('SNMPv2-MIB','sysDescr',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		ObjectType(ObjectIdentity('IF-MIB','ifNumber',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		#ObjectType(ObjectIdentity('SNMPv2-MIB','sysUpTime',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		ObjectType(ObjectIdentity('SNMPv2-MIB','sysLocation',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		ObjectType(ObjectIdentity('SNMPv2-MIB','sysContact',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@'))))

	if errorIndication:
	    print(errorIndication)
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado.append(VarB.partition(' = ')[2])
	return resultado


def getInfo2(comunidad,host,version,puerto,oids):
	resultado=[]
	for element in oids:
		errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),ObjectType(ObjectIdentity(element))))
		if errorIndication:
		    print(errorIndication)
		elif errorStatus:
		    print('%s at %s' % (errorStatus.prettyPrint(),
		                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
		else:
		    for varBind in varBinds:
		        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
		        resultado.append(VarB.partition(' = ')[2])
	return resultado	

#Funcion para hacer consultas version facil (entrada y salida)
def consultaSNMP(comunidad,host,version,interfaz,grupo,objeto1,objeto2,puerto):
	resultado=[]
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity(grupo,objeto1,interfaz).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		ObjectType(ObjectIdentity(grupo,objeto2,interfaz).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@'))))

	if errorIndication:
	    print(errorIndication)
	    resultado.append("")
	    resultado.append("")
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado.append(VarB.partition(' = ')[2])
	return resultado

#Funcion para hacer consultas a un solo objeto con referencias al nombre
def consultav2SNMP(comunidad,host,version,interfaz,grupo,objeto,puerto):
	resultado=""
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity(grupo,objeto,interfaz).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@'))))

	if errorIndication:
	    print(errorIndication)
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado=VarB.partition(' = ')[2]
	return resultado

#Funcion para hacer consultas de un objeto con el OID
def consultav3SNMP(comunidad,host,version,oid,puerto):
	resultado=""
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity(oid))))

	if errorIndication:
	    print(errorIndication)
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado=VarB.partition(' = ')[2]
	return resultado

#Funcion para hacer consultas de dos objetos con OID
def consultav4SNMP(comunidad,host,version,oid1,oid2,puerto):
	resultado=[]
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity(oid1)),
		ObjectType(ObjectIdentity(oid2))))

	if errorIndication:
	    print(errorIndication)
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado.append(VarB.partition(' = ')[2])
	return resultado

#Funcion para ram y HHD
def consultav5SNMP(comunidad,host,version,interfaz,grupo,objeto1,objeto2,objeto3,puerto):
	resultado=[]
	errorIndication, errorStatus, errorIndex, varBinds = next(getCmd(SnmpEngine(),CommunityData(comunidad,mpModel=version),UdpTransportTarget((host, puerto)),ContextData(),
		ObjectType(ObjectIdentity(grupo,objeto1,interfaz).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		ObjectType(ObjectIdentity(grupo,objeto2,interfaz).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
		ObjectType(ObjectIdentity(grupo,objeto3,interfaz).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@'))))

	if errorIndication:
	    print(errorIndication)
	    resultado.append("")
	    resultado.append("")
	elif errorStatus:
	    print('%s at %s' % (errorStatus.prettyPrint(),
	                        errorIndex and varBinds[int(errorIndex) - 1][0] or '?'))
	else:
	    for varBind in varBinds:
	        VarB=(' = '.join([x.prettyPrint() for x in varBind]))
	        resultado.append(VarB.partition(' = ')[2])
	return resultado

#Funcion para crear el archivo .rrd con un valor
def crearRRDUno(nombre,inicio,step,tiempo,steps1,steps2,row1,row2,tipo):
	ret=rrdtool.create(nombre,'--start',inicio,'--step',step,
		"DS:valor1:"+tipo+":"+tiempo+":U:U",
		"RRA:AVERAGE:0.5:"+steps1+":"+row1,
		"RRA:AVERAGE:0.5:"+steps2+":"+row2)
	if ret:
		print(rrdtool.error())

#FUncion para crear el archivo .rrd con dos valores
def crearRRDDos(nombre,inicio,step,tiempo,steps1,steps2,row1,row2,tipo):
	ret=rrdtool.create(nombre,'--start',inicio,'--step',step,
		"DS:in:"+tipo+":"+tiempo+":U:U",
		"DS:out:"+tipo+":"+tiempo+":U:U",
		"RRA:AVERAGE:0.5:"+steps1+":"+row1,
		"RRA:AVERAGE:0.5:"+steps2+":"+row2)
	if ret:
		print(rrdtool.error())

def crearRRDTres(nombre,inicio,step,tiempo,steps1,steps2,steps3,row1,row2,row3,tipo):
	ret=rrdtool.create(nombre,'--start',inicio,'--step',step,
		"DS:size:"+tipo+":"+tiempo+":U:U",
		"DS:used:"+tipo+":"+tiempo+":U:U",
		"DS:all:"+tipo+":"+tiempo+":U:U",
		"RRA:AVERAGE:0.5:"+steps1+":"+row1,
		"RRA:AVERAGE:0.5:"+steps2+":"+row2,
		"RRA:AVERAGE:0.5:"+steps3+":"+row3)
	if ret:
		print(rrdtool.error())
