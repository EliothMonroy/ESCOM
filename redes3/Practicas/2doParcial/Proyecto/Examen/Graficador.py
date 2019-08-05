from pysnmp.hlapi import *
import rrdtool
import time
from convertidor import convertir_a_numero
from notificador import Notificador
from logger import Logger

archivo_rdd="predict.rrd"
ultimo=rrdtool.last(archivo_rdd)
inicio=ultimo-86400
ayerInicio=(inicio-40000)
ayerFinal=ultimo-40000
ret = rrdtool.graphv( "predict.png",
                 "--start",str(inicio),
                "--end",str(ultimo),
                 "--vertical-label=Bytes/s",
                    '--slope-mode',
                    "DEF:obs="+archivo_rdd+":inoctets:AVERAGE",
                    "DEF:pred="+archivo_rdd+":inoctets:HWPREDICT",
                    "DEF:dev="+archivo_rdd+":inoctets:DEVPREDICT",
                    "DEF:fail="+archivo_rdd+":inoctets:FAILURES",
                    "DEF:yvalue="+archivo_rdd+":inoctets:AVERAGE:start=" + str(ayerInicio) + ":end=" + str(ayerFinal),
              		'SHIFT:yvalue:40000',
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
                "TICK:fail#FDD017:1.0:FFallas",
                "LINE1:scaledobs#00FF00:In traffic",
                "LINE1:scaledpred#FF00FF:Prediccion\\n",
                #"LINE1:outoctets#0000FF:Out traffic",
                "LINE1:scaledupper#ff0000:Upper Bound Average bits in\\n",
                "LINE1:scaledlower#0000FF:Lower Bound Average bits in")