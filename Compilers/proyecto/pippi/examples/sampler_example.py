import random
import time
from pippi import dsp, sampler, tune, rhythm

start_time = time.time()
samp = sampler.Sampler('sounds/harpc2.wav', 'c2')

out = dsp.buffer(length=32)
chords = ['iii', 'vi', 'ii', 'V']

def arp(i):
    cluster = dsp.buffer()
    length = random.randint(44100, 44100 + 22050)
    numnotes = random.randint(3, 12)
    onsets = rhythm.curve(numnotes, dsp.RND, length)
    chord = chords[i % len(chords)]
    freqs = tune.chord(chord, octave=random.randint(1, 3))
    for i, onset in enumerate(onsets): 
        freq = freqs[i % len(freqs)]
        note = samp.play(freq)
        note = note.pan(random.random())
        note *= random.triangular(0, 0.125)
        cluster.dub(note, onset/cluster.samplerate)
    return cluster

pos = 0
for i in range(32):
    for _ in range(random.randint(1,3)):
        cluster = arp(i)
        out.dub(cluster, pos)

    pos += 1

out.write('sampler_example.wav')
elapsed_time = time.time() - start_time
print('Render time: %s seconds' % round(elapsed_time, 2))
print('Output length: %s seconds' % round(len(out)/44100, 2))
