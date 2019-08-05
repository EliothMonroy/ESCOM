from pippi import dsp, rhythm
import random

out = dsp.buffer()

snare = dsp.read('sounds/snare.wav')

pattern = rhythm.curve(numbeats=64, wintype=dsp.SINE, length=44100 * 4)

for onset in pattern:
    out.dub(snare * random.random(), onset/out.samplerate)

out.write('simple_snare_bounce.wav')
