from pysnmp.hlapi import *
import rrdtool
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

for i in range(1000):
	ultimo1=rrdtool.last("CPU.rrd")
	ultimo2=rrdtool.last("HDD.rrd")
	ultimo3=rrdtool.last("RAM.rrd")
	rrdtool.dump('CPU.rrd','CPU.xml')
	ret = rrdtool.graph("CPU.png",
	             "--start",str(ultimo1-100),
	             "--end",str(ultimo1+100),
	             "--vertical-label=Porcentaje/s",
	             "--title=Uso de CPU",
			     "--lower-limit","0",
			     "--upper-limit","100",
	             "DEF:usage=CPU.rrd:valor1:AVERAGE",
	             #"CDEF:umb70=usage,70,GT,usage,85,LT,EQ,usage,0,IF",
			     #"CDEF:umb85=usage,85,GT,usage,95,LT,EQ,usage,0,IF",
			     #"CDEF:umb95=usage,95,GT,usage,100,LT,EQ,usage,0,IF",
			     "AREA:usage#FFBB0077:Uso de CPU",
	             "VDEF:m=usage,LSLSLOPE",
	             "VDEF:b=usage,LSLINT",
	             "CDEF:avg=usage,POP,m,COUNT,*,b,+",
			     "CDEF:umbral70=avg,70,85,LIMIT",
			     "CDEF:umbral85=avg,85,95,LIMIT",
			     "CDEF:umbral95=avg,95,100,LIMIT",
	             "LINE1:avg#FF9F00",
	             "LINE2:70",
			     "AREA:15#FF000022::STACK",
			     "AREA:10#FF000044::STACK",
			     "AREA:5#FF000066::STACK",
		         "AREA:umbral70#0077FF77:Tráfico de carga mayor que el 75 y menor que el 85 por ciento",
			     "AREA:umbral85#00880077:Tráfico de carga mayor que el 85 y menor que el 95 por ciento",
			     "AREA:umbral95#FF000088:Tráfico de carga mayor que el 95 y menor que el 100 por ciento")
	ret = rrdtool.graph("HDD.png",
	             "--start",str(ultimo2-100),
	             "--end","+100",
	             "--vertical-label=Porcentaje/s",
	             "--title=Uso de Disco Duro",
	             "--lower-limit","0",
	     		 "--upper-limit","100",
	             "DEF:val1=HDD.rrd:size:AVERAGE",
	             "DEF:val2=HDD.rrd:used:AVERAGE",
	             "DEF:val3=HDD.rrd:all:AVERAGE",
	             "CDEF:totalHDD=val1,val3,*",
	             "CDEF:usoHDDporcentaje=val2,val3,*,100,*,totalHDD,/",
			     "CDEF:usoHDD=val2,val3,*",
			     #"CDEF:umbral65=usoHHDporcentaje,65,GT,usoHHDporcentaje,75,LT,EQ,usoHDDporcentaje,0,IF",
			     #"CDEF:umbral75=usoHHDporcentaje,75,GT,usoHHDporcentaje,85,LT,EQ,usoHDDporcentaje,0,IF",
			     #"CDEF:umbral85=usoHHDporcentaje,85,GT,usoHHDporcentaje,100,LT,EQ,usoHDDporcentaje,0,IF",
	             "AREA:usoHDDporcentaje#FFBB0077:En uso",
			     "VDEF:m=usoHDDporcentaje,LSLSLOPE",
	             "VDEF:b=usoHDDporcentaje,LSLINT",
	             "CDEF:avg=usoHDDporcentaje,POP,m,COUNT,*,b,+",
	             "CDEF:umbral65=avg,65,75,LIMIT",
			     "CDEF:umbral75=avg,75,85,LIMIT",
			     "CDEF:umbral85=avg,85,100,LIMIT",
			     "LINE1:avg#FF9F00",
		         "LINE3:65",
			     "AREA:10#FF000022::STACK",
			     "AREA:10#FF000044::STACK",
			     "AREA:15#FF000066::STACK",
			     "AREA:umbral65#0077FF77:Uso mayor que el 65 y menor que el 75 por ciento",
			     "AREA:umbral75#00880077:Uso mayor que el 75 y menor que el 85 por ciento",
			     "AREA:umbral85#FF000088:Uso mayor que el 85 y menor que el 100 por ciento")
	ret = rrdtool.graph("RAM.png",
	             "--start",str(ultimo3-100),
	             "--end","+100",
	             "--vertical-label=Porcentaje/s",
	             "--title=Uso de RAM",
	             "--lower-limit","0",
	     		 "--upper-limit","100",
	             "DEF:val1=RAM.rrd:size:AVERAGE",
	             "DEF:val2=RAM.rrd:used:AVERAGE",
	             "DEF:val3=RAM.rrd:all:AVERAGE",
	             "CDEF:totalRAM=val1,val3,*",
	             "CDEF:usoRAMporcentaje=val2,val3,*,100,*,totalRAM,/",
			     "CDEF:usoRAM=val2,val3,*",
			     #"CDEF:umbral70=usoRAMporcentaje,70,GT,usoRAMporcentaje,75,LT,EQ,usoRAMporcentaje,0,IF",
			     #"CDEF:umbral75=usoRAMporcentaje,75,GT,usoRAMporcentaje,80,LT,EQ,usoRAMporcentaje,0,IF",
			     #"CDEF:umbral80=usoRAMporcentaje,80,GT,usoRAMporcentaje,100,LT,EQ,usoRAMporcentaje,0,IF",
	             "AREA:usoRAMporcentaje#FFBB0077:En uso",
			     "VDEF:m=usoRAMporcentaje,LSLSLOPE",
	             "VDEF:b=usoRAMporcentaje,LSLINT",
	             "CDEF:avg=usoRAMporcentaje,POP,m,COUNT,*,b,+",
	             "LINE1:avg#FF9F00",
		         "CDEF:umbral70=avg,70,75,LIMIT",
			     "CDEF:umbral75=avg,75,80,LIMIT",
			     "CDEF:umbral80=avg,80,100,LIMIT",
		         "LINE3:70",
			     "AREA:5#FF000022::STACK",
			     "AREA:5#FF000044::STACK",
			     "AREA:20#FF000066::STACK",
			     "AREA:umbral70#0077FF77:Uso mayor que el 70 y menor que el 75 por ciento",
			     "AREA:umbral75#00880077:Uso mayor que el 75 y menor que el 80 por ciento",
			     "AREA:umbral80#FF000088:Uso mayor que el 80 y menor que el 100 por ciento")

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
