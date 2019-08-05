import time
import rrdtool
from getSNMP import consultaSNMP
from path import *
carga_CPU = 0

while 1:
    carga_CPU = int(consultaSNMP('SNMPcom','localhost','1.3.6.1.2.1.25.3.3.1.2.196608'))
    valor = "N:" + str(carga_CPU)
    print (valor)
    ret=rrdtool.update(rrdpath+rrdname, valor)
    rrdtool.dump(rrdpath+ rrdname,'trend.xml')
    time.sleep(1)

if ret:
    print (rrdtool.error())
    time.sleep(300)
