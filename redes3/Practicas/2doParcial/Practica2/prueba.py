from pysnmp.hlapi import *

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
print(consultav2SNMP("grupo4cm1","localhost",1,1,"IF-MIB","ifOutOctets",161))
print(consultav2SNMP("grupo4cm1","localhost",1,1,"IF-MIB","ifInOctets",161))