import rrdtool
valor_alpha=".1"
valor_beta=".0035"
valor_gamma=".1"
rrdtool.tune("predict.rrd","--alpha",valor_alpha)
rrdtool.tune("predict.rrd","--beta",valor_beta)
rrdtool.tune("predict.rrd","--gamma",valor_gamma)

rrdtool.dump("predict.rrd","predict.xml")

#alpha original: 1.0000000000e-01
#beta original: 3.5000000000e-03
#gamma original: 1.0000000000e-01
