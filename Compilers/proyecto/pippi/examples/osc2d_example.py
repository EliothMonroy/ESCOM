import random
import time
from pippi import dsp, oscs, tune

start_time = time.time()

tlength = 30
out = dsp.buffer(length=tlength)
pos = 0
beat = 0.2
count = 0

def make_note(freq, lfo_freq, amp, length):
    length = random.triangular(length, length * 2)
    numtables = random.randint(1, random.randint(3, 12))
    lfo = random.choice([dsp.SINE, dsp.RSAW, dsp.TRI, dsp.PHASOR])
    wavetables = [ random.choice([dsp.SINE, dsp.SQUARE, dsp.TRI, dsp.SAW]) for _ in range(numtables) ]

    osc = oscs.Osc(wavetables, lfo=lfo)

    freq = freq * random.choice([0.5, 1])
    note = osc.play(length=length, freq=freq, amp=amp, mod_freq=lfo_freq)
    note = note.env(dsp.RND).env(dsp.PHASOR).pan(random.random())

    return note

def get_freqs(count):
    chords = ['II', 'V9', 'vii*', 'IV7']
    return tune.chord(chords[count % len(chords)])

freqs = get_freqs(0)

while pos < tlength:
    print('Swell %s, pos %s' % (count, round(pos/44100, 2)))

    length = random.triangular(1, 2)
    freqs = get_freqs(count // 4)
    params = []

    for freq in freqs:
        lfo_freq = random.triangular(0.001, 10)
        amp = random.triangular(0.001, 0.1)
        params += [ (freq, lfo_freq, amp, length) ]

    notes = dsp.pool(make_note, params)

    for note in notes:
        out.dub(note, pos + random.triangular(0, 0.1))

    count += 1
    pos += beat * random.randint(1, 4) * random.randint(1,3)

out.write('osc2d_out.wav')

elapsed_time = time.time() - start_time
print('Render time: %s seconds' % round(elapsed_time, 2))
print('Output length: %s seconds' % out.dur)
