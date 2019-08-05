import time
import rrdtool
from getSNMP import consultaSNMP
from Notify import check_aberration
total_input_traffic = 0
total_output_traffic = 0
from path import *
title="Deteccion de comportamiento anomalo"
# Generate charts for last 24 hours
endDate = rrdtool.last(rrdname) #ultimo valor del XML
begDate = endDate - 86000

while 1:
    total_input_traffic = int(consultaSNMP('grupo_4cm3','localhost','1.3.6.1.2.1.2.2.1.10.1'))
    total_output_traffic = int(consultaSNMP('grupo_4cm3','localhost','1.3.6.1.2.1.2.2.1.16.1'))

    valor = "N:" + str(total_input_traffic) + ':' + str(total_output_traffic)
    print (valor)
    ret = rrdtool.update(rrdname, valor)
    rrdtool.dump(rrdname,'pred.xml')
    time.sleep(1)
    print (check_aberration(rrdpath,rrdname))

if ret:
    print (rrdtool.error())
    time.sleep(300)
