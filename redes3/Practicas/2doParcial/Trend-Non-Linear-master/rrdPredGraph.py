import time
import rrdtool
from path import *

title="Deteccion de comportamiento anomalo, valor de Alpha 0.1"
endDate = rrdtool.last(rrdname) #ultimo valor del XML
begDate = endDate - 86000

rrdtool.tune(rrdname, '--alpha', '0.1')
ret = rrdtool.graph("netPalphaBajoFallas.png",
                        '--start', str(begDate), '--end', str(endDate), '--title=' + title,
                        "--vertical-label=Bytes/s",
                        '--slope-mode',
                        "DEF:obs=" + rrdname + ":inoctets:AVERAGE",
                        "DEF:outoctets=" + rrdname + ":outoctets:AVERAGE",
                        "DEF:pred=" + rrdname + ":inoctets:HWPREDICT",
                        "DEF:dev=" + rrdname + ":inoctets:DEVPREDICT",
                        "DEF:fail=" + rrdname + ":inoctets:FAILURES",

                    #"RRA:DEVSEASONAL:1d:0.1:2",
                    #"RRA:DEVPREDICT:5d:5",
                    #"RRA:FAILURES:1d:7:9:5""
                        "CDEF:scaledobs=obs,8,*",
                        "CDEF:upper=pred,dev,2,*,+",
                        "CDEF:lower=pred,dev,2,*,-",
                        "CDEF:scaledupper=upper,8,*",
                        "CDEF:scaledlower=lower,8,*",
                        "CDEF:scaledpred=pred,8,*",
                    "TICK:fail#FDD017:1.0:Fallas",
                    "LINE3:scaledobs#00FF00:In traffic",
                    "LINE1:scaledpred#FF00FF:Prediccion\\n",
                    #"LINE1:outoctets#0000FF:Out traffic",
                    "LINE1:scaledupper#ff0000:Upper Bound Average bits in\\n",
                    "LINE1:scaledlower#0000FF:Lower Bound Average bits in")
