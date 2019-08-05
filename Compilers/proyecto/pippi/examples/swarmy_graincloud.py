from pippi import dsp, grains, interpolation
import random

snd = dsp.read('sounds/linus.wav')

def makecloud(density):
    return grains.GrainCloud(snd * 0.125, 
                win=dsp.HANN, 
                read_lfo=dsp.PHASOR, 
                speed_lfo_wt=interpolation.linear([ random.random() for _ in range(random.randint(10, 1000)) ], 4096), 
                density_lfo_wt=interpolation.linear([ random.random() for _ in range(random.randint(10, 1000)) ], 4096), 
                grainlength_lfo_wt=interpolation.linear([ random.random() for _ in range(random.randint(10, 500)) ], 4096), 
                minspeed=0.25, 
                maxspeed=random.triangular(0.25, 10),
                density=density,
                minlength=1, 
                maxlength=random.triangular(60, 100),
                spread=random.random(),
                jitter=random.triangular(0, 0.1),
            ).play(30)

numclouds = 10
densities = [ (random.triangular(0.1, 2),) for _ in range(numclouds) ]

clouds = dsp.pool(makecloud, densities)
out = dsp.buffer(length=20)
for cloud in clouds:
    out.dub(cloud)

out.write('swarmy_graincloud.wav')
