import random
import time
from pippi import dsp, oscs, tune

start_time = time.time()

def make_wavetable():
    wtsize = random.randint(2, random.randint(3, 50))
    wavetable = [0] + [ random.triangular(-1, 1) for _ in range(wtsize-2) ] + [0]
    return wavetable


out = dsp.buffer()

chords = 'ii vi V7 I69'

dubhead = 0
for chord in chords.split(' ') * 8:
    chordlength = random.triangular(2, 3) # in seconds
    freqs = tune.chord(chord, key='e', octave=2)
    numnotes = random.randint(3, 6)

    notes = []

    for _ in range(numnotes):
        notelength = random.triangular(0.1, 2)
        freq = random.choice(freqs)
        amp = random.triangular(0.1, 0.25)

        note = oscs.Osc(wavetable=make_wavetable()).play(notelength, freq, amp)
        note = note.env(dsp.RND)
        note = note.taper(0.01)
        note = note.pan(random.random())

        out.dub(note, dubhead + random.triangular(0, 0.1))

    dubhead += chordlength - (chordlength * 0.1)

out.write('synth_chords.wav')
elapsed_time = time.time() - start_time
print('Render time: %s seconds' % round(elapsed_time, 2))
print('Output length: %s seconds' % round(out.dur, 2))
