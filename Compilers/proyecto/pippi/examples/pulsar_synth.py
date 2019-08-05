import random
import time
from pippi import dsp, oscs, tune

start_time = time.time()

out = dsp.buffer(length=40)
freqs = tune.fromdegrees([1,2,3,4,5,6,7,8,9], octave=1, root='d')

print('Creating 5,000 1ms - 100ms long pulsar notes in a 40 second buffer...')
for _ in range(1000):
    pos = random.triangular(0, 39.5)
    length = random.triangular(0.001, 0.1)

    # Pulsar wavetable constructed from a random set of linearly interpolated points & a randomly selected window
    # Frequency modulated between 1% and 300% with a randomly generated wavetable LFO between 0.01hz and 30hz
    # with a random, fixed-per-note pulsewidth
    wavetable = [0] + [ random.triangular(-1, 1) for _ in range(random.randint(3, 100)) ] + [0]
    mod = [ random.triangular(0, 1) for _ in range(random.randint(3, 20)) ]
    osc = oscs.Osc(wavetable, window=dsp.RND, mod=mod)
    pulsewidth = random.random()

    freq = random.choice(freqs) * 2**random.randint(0, 10)
    mod_freq = random.triangular(0.01, 30)
    mod_range = random.triangular(0, random.choice([0.03, 0.02, 0.01, 3]))
    amp = random.triangular(0.05, 0.1)

    if mod_range > 1:
        amp *= 0.5

    note = osc.play(length, freq, amp, pulsewidth, mod_freq=mod_freq, mod_range=mod_range)
    note = note.env(dsp.RND)
    note = note.pan(random.random())

    out.dub(note, pos)

out.write('pulsar_synth.wav')
elapsed_time = time.time() - start_time
print('Render time: %s seconds' % round(elapsed_time, 2))
print('Output length: %s seconds' % out.dur)
