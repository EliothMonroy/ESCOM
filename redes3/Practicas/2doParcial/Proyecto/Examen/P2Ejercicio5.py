from pysnmp.hlapi import *
import rrdtool
import time
from convertidor import convertir_a_numero
from notificador import Notificador
from logger import Logger
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
		"DS:valor1:COUNTER:"+tiempo+":U:U",
		"DS:valor2:COUNTER:"+tiempo+":U:U",
		"RRA:AVERAGE:0.5:"+steps1+":"+row1,
		"RRA:AVERAGE:0.5:"+steps2+":"+row2)
	if ret:
		print(rrdtool.error())

def crearRRDHW(nombre,inicio,step,tiempo,steps1,row1):
	ret=rrdtool.create(nombre,'--start',inicio,'--step',step,
		"DS:inoctets:COUNTER:"+tiempo+":U:U",
		"RRA:AVERAGE:0.5:"+steps1+":"+row1,
		"RRA:HWPREDICT:300:0.1:0.0035:10:3",
		"RRA:SEASONAL:10:0.1:2",
		"RRA:DEVSEASONAL:10:0.1:2",
		"RRA:DEVPREDICT:300:4",
		"RRA:FAILURES:300:3:5:4")
	if ret:
		print(rrdtool.error())

#crearRRDHW("prueba.rrd","N","1","600","1","600")
final=False
fecha_inicio=fecha_final=""
noti=Notificador("Compu Profa")
log=Logger("Compu Profa")
archivo_rdd="predict.rrd"
while 1:
	# consulta=consultav2SNMP("public","localhost",1,1,'IF-MIB','ifInOctets',161)
	consulta=consultav2SNMP("variation/virtualtable","10.100.71.200",1,1,'IF-MIB','ifInOctets',1024)
	valor = "N:" + str(consulta)
	# print (valor)
	ultimo=rrdtool.last(archivo_rdd)
	inicio=ultimo-3600
	ayerInicio=(inicio-86400)
	ayerFinal=ultimo-86400
	primero=rrdtool.first(archivo_rdd)
	rrdtool.update(archivo_rdd, valor)
	rrdtool.dump(archivo_rdd,'prueba.xml')
	ret = rrdtool.graphv( "prueba.png",
                 "--start",str(inicio),
                "--end",str(ultimo),
                 "--vertical-label=Bytes/s",
                    '--slope-mode',
                    "DEF:obs="+archivo_rdd+":inoctets:AVERAGE",
                    "DEF:pred="+archivo_rdd+":inoctets:HWPREDICT",
                    "DEF:dev="+archivo_rdd+":inoctets:DEVPREDICT",
                    "DEF:fail="+archivo_rdd+":inoctets:FAILURES",
                    "DEF:yvalue="+archivo_rdd+":inoctets:AVERAGE:start=" + str(ayerInicio) + ":end=" + str(ayerFinal),
              		'SHIFT:yvalue:86400',
                #"RRA:DEVSEASONAL:1d:0.1:2",
                #"RRA:DEVPREDICT:5d:5",
                #"RRA:FAILURES:1d:7:9:5""
                    "CDEF:scaledobs=obs,8,*",
                    "CDEF:upper=pred,dev,2,*,+",
                    "CDEF:lower=pred,dev,2,*,-",
                    "CDEF:scaledupper=upper,8,*",
                    "CDEF:scaledlower=lower,8,*",
                    "CDEF:scaledh=yvalue,8,*",
                    "CDEF:scaledpred=pred,8,*",
                    "VDEF:lastfail=fail,LAST",
					"PRINT:lastfail:%6.2lf %S ",
					"PRINT:lastfail: %c :strftime",
                    # "VDEF:lastobs=obs,LAST",
                    # "VDEF:lastmax=upper,LAST",
                    # "VDEF:lastmin=lower,LAST",
					# "PRINT:lastmax:%6.2lf %S",
					# "PRINT:lastmin:%6.2lf %S",
					# "PRINT:lastobs:%6.2lf %S",
                "AREA:scaledh#C9C9C9:Ayer",
                "TICK:fail#FDD017:1.0:Fallas",
                "LINE1:scaledobs#00FF00:In traffic",
                "LINE1:scaledpred#FF00FF:Prediccion\\n",
                #"LINE1:outoctets#0000FF:Out traffic",
                "LINE1:scaledupper#ff0000:Upper Bound Average bits in\\n",
                "LINE1:scaledlower#0000FF:Lower Bound Average bits in")
	# print("Máximo: "+ret["print[0]"])
	# print("Mínimo: "+ret["print[1]"])
	# print("Medido: "+ret["print[2]"])
	# print("Fecha: "+ret["print[3]"])
	# print(float(ret["print[0]"]))
	if "nan" not in ret["print[0]"]:
		ultima_falla=float(ret["print[0]"])
		if ultima_falla==0:
			# print("No soy una falla")
			if final:
				final=not final
				# print("Fecha inicio: "+fecha_inicio)
				# print("Fecha final: "+fecha_final)
				noti.enviarCorreo(4,fecha_final,"prueba.png")
				log.escribirLog(4,fecha_final)
		else:
			# print("Soy una falla")
			fecha_final=ret["print[1]"]
			if not final:
				# print("Falla detectada")
				fecha_inicio=ret["print[1]"]
				final=not final
				noti.enviarCorreo(3,fecha_inicio,"prueba.png")
				log.escribirLog(3,fecha_inicio)

if ret:
    print (rrdtool.error())
    time.sleep(300)
