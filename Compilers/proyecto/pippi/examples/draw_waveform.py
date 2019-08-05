import random
from pippi import dsp, graph

out = dsp.buffer()

sounds = [ 
    dsp.read('sounds/snare.wav'), 
    dsp.read('sounds/boing.wav'), 
    dsp.read('sounds/hat.wav'), 
]

maxstart = 44100 * 5
numsounds = random.randint(3, 5)

# Put some sounds in a buffer to look at
for _ in range(numsounds):

    # Start anywhere between 0 and 5 seconds into the buffer
    start = random.randint(0, maxstart)

    sound = random.choice(sounds)
    sound = sound.pan(random.random()) * random.random()

    out.dub(sound, start)

graph.waveform(out, 'draw_waveform_example.png', width=600, height=300)
