import rrdtool
ret = rrdtool.create("test.rrd",
                     "--start", '920804400',
                     "DS:speed:COUNTER:600:U:U",
                     "RRA:AVERAGE:0.5:1:24",
                     "RRA:AVERAGE:0.5:6:10")

upd = rrdtool.update('test.rrd','920804700:12345',
                     '920805000:12357','920805300:12363',
                     '920805600:12363','920805900:12363',
                     '920806200:12373','920806500:12383',
                     '920806800:12393', '920807100:12399',
                     '920807400:12405', '920807700:12411',
                     '920808000:12415','920808300:12420',
                     '920808600:12422','920808900:12423')
rrdtool.dump('test.rrd','test.xml');
print (rrdtool.fetch('test.rrd','AVERAGE',
                    "--start", '920804400',
                    "--end",'920809200'))

gra= rrdtool.graph("speed.png",
                   "--start", "920804400",
                   "--end", "920808000",
                   "DEF:myspeed=test.rrd:speed:AVERAGE",
                   "LINE1:myspeed#FF0000")