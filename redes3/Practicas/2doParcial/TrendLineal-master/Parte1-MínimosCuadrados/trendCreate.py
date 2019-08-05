import rrdtool
from path import *

ret = rrdtool.create(rrdpath+rrdname,
                     "--start",'N',
                     "--step",'60',
                     "DS:CPUload:GAUGE:600:U:U",
                     "RRA:AVERAGE:0.5:1:24")
if ret:
    print (rrdtool.error())
