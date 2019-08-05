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
		ObjectType(ObjectIdentity('SNMPv2-MIB','sysUpTime',0).addAsn1MibSource('file:///usr/share/snmp','http://mibs.snmplabs.com/asn1/@mib@')),
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

#Funcion para crear el archivo .rrd con un valor
def crearRRDUno(nombre,inicio,step,tiempo,steps1,steps2,row1,row2):
	ret=rrdtool.create(nombre,'--start',inicio,'--step',step,
		"DS:valor1:COUNTER:"+tiempo+":U:U",
		"RRA:AVERAGE:0.5:"+steps1+":"+row1,
		"RRA:AVERAGE:0.5:"+steps2+":"+row2)
	if ret:
		print(rrdtool.error())

#FUncion para crear el archivo .rrd con dos valores
def crearRRDDos(nombre,inicio,step,tiempo,steps1,steps2,row1,row2):
	ret=rrdtool.create(nombre,'--start',inicio,'--step',step,
		"DS:in:COUNTER:"+tiempo+":U:U",
		"DS:out:COUNTER:"+tiempo+":U:U",
		"RRA:AVERAGE:0.5:"+steps1+":"+row1,
		"RRA:AVERAGE:0.5:"+steps2+":"+row2)
	if ret:
		print(rrdtool.error())

"""
crearRRD("prueba.rrd","N","1","60","1","1","100","100")
while 1:

	consulta=consultav3SNMP("variation/virtualtable","10.100.71.200",1,1,"IF-MIB","ifOutOctets",1024)
	valor = "N:" + str(consulta)
	print (valor)
	rrdtool.update('prueba.rrd', valor)
	rrdtool.dump('prueba.rrd','prueba.xml')
	ultimo=rrdtool.last('prueba.rrd')
	ret = rrdtool.graph( "prueba.png",
                     "--start",str(ultimo-100),
                    "--end","+100",
                     "--vertical-label=Bytes/s",
                     "DEF:valor1=prueba.rrd:valor1:AVERAGE",
                     "AREA:valor1#00FF00:In traffic")
if ret:
    print (rrdtool.error())
    time.sleep(300)
"""#

"""
			ESTE ES UNA PRUEBA QUE HICE PARA VER SI GRAFICABA, Y SI GRAFICA :v
consulta3=0
crearRRD("prueba.rrd","-700","1","60","1","1","100","100")
while 1:
	consulta=consultaSNMP('grupo4cm1','localhost',0,2,'IF-MIB','ifInOctets','ifOutOctets')
	valor = "N:" + str(consulta[0]) + ':' + str(consulta[1])
	print (valor)
	rrdtool.update('prueba.rrd', valor)
	rrdtool.dump('prueba.rrd','prueba.xml')
	ret = rrdtool.graph( "prueba.png",
                     "--start",'-300',
                    "--end","+100",
                     "--vertical-label=Bytes/s",
                     "DEF:valor1=prueba.rrd:valor1:AVERAGE",
                     "DEF:valor2=prueba.rrd:valor2:AVERAGE",
                     "AREA:valor1#00FF00:In traffic",
                     "LINE1:valor2#0000FF:Out traffic")
if ret:
    print (rrdtool.error())
    time.sleep(300)
"""

"""

			PRUEBA DE LAS FUNCIONES PARA VER SU FUNCIONAMIENTO


interfaces=getInterfaces('grupo4cm1','localhost',0)
print(interfaces)
estado=getStatus('grupo4cm1','localhost',0,2)
print(estado)
res=getInfo('grupo4cm1','localhost',1)
for element in res:
	print(element)
consulta=consultaSNMP('grupo4cm1','localhost',0,2,'IF-MIB','ifInOctets','ifOutOctets')
for element in consulta:
	print(element)
consulta2=consultaSNMP('grupo4cm1','localhost',0,0,'IP-MIB','icmpInMsgs','icmpOutMsgs')
for element in consulta2:
	print(element)
consulta3=consultav2SNMP('grupo4cm1','localhost',0,'1.3.6.1.2.1.2.2.1.10.2')
print(consulta3)

			LISTA DE LAS 5 OPCIONES CON LAS QUE VAMOS A TRABAJAR, QUIEN SE VAYA A ENCARGAR DE HACER LAS CONSULTAS DEL MODO GRAFICO PUES SOLO HAY QUE MANDAR A LLAMAR LA FUNCION CON LOS PARAMETROS SIGUIENTES

'IF-MIB','ifInOctets','ifOutOctets'
'IP-MIB','icmpInMsgs','icmpOutMsgs'
'TCP-MIB','tcpInSegs','tcpOutSegs'
'UDP-MIB','udpInDatagrams','udpOutDatagrams'
'SNMPv2-MIB','snmpInPkts','snmpOutPkts'
"""#
