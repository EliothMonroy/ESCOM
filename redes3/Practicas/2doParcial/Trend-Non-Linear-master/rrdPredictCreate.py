#!/usr/bin/env python
from path import *
import rrdtool
ret = rrdtool.create(rrdpath+rrdname,
                     "--start",'N',
                     "--step",'60',
                     "DS:inoctets:COUNTER:600:U:U",
                     "RRA:AVERAGE:0.5:1:100",
            #RRA:HWPREDICT:rows:alpha:beta:seasonal period[:rra - num]
                     "RRA:HWPREDICT:300:0.1:0.0035:50:3",
              #RRA:SEASONAL:seasonal period:gamma:rra-num
                     "RRA:SEASONAL:50:0.1:2", #Hasta aquí debería de funcionar
              #RRA:DEVSEASONAL:seasonal period:gamma:rra-num
                     "RRA:DEVSEASONAL:50:0.1:2",
                #RRA:DEVPREDICT:rows:rra-num
                     "RRA:DEVPREDICT:300:4",
            #RRA:FAILURES:rows:threshold:window length:rra-num
                     "RRA:FAILURES:300:7:9:4")

#HWPREDICT rra-num is the index of the SEASONAL RRA.
#SEASONAL rra-num is the index of the HWPREDICT RRA.
#DEVSEASONAL rra-num is the index of the HWPREDICT RRA.
#DEVPREDICT rra-num is the index of the DEVSEASONAL RRA.
#FAILURES rra-num is the index of the DEVSEASONAL RRA.

#gamma valor entre [0,1]

if ret:
    print (rrdtool.error())

