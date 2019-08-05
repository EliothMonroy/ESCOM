from pippi import dsp, rhythm
import random

# Create an empty buffer to dub sounds into
out = dsp.buffer()

# Load a snare drum sample from the `sounds` directory
snare = dsp.read('sounds/snare.wav')

# Make a random number of passes dubbing into the 
# output buffer. On each pass...
numpasses = random.randint(4, 8)

for _ in range(numpasses):
    # Set the length of the 
    length = random.randint(44100, 44100 * 30)

    # Pick a random number of beats / events
    numbeats = random.randint(16, 64)

    # If `rhythm.curve` get reverse=True, the window function will be 
    # read in reverse -- high to low.
    reverse = random.choice([True, False])

    # Randomly choose a window function for `rhythm.curve`
    wintype = random.choice(['sine', 'tri', 'kaiser', 'hann', 'blackman', None])

    # If wintype is None, generate a random list of values to use as a wavetable
    wavetable = None if wintype is not None else [ random.random() for _ in range(random.randint(3, 10)) ]

    # Create a list of onset times for the above params, which we'll use as positions 
    # to dub the snare sound into the output buffer.
    pattern = rhythm.curve(numbeats=numbeats, wintype=wintype, length=length, reverse=reverse, wavetable=wavetable)

    # Set the base speed for the sound -- the snare will be pitch shifted by this amount + some jitter
    minspeed = random.triangular(0.15, 2)

    # Pick a random place in the stereo field for this pass of snare hits
    pan = random.random()

    for onset in pattern:
        # Loop through the pattern and make a pass through the output buffer, 
        # dubbing snares into it at the given onset positions

        # Copy the snare and scale its amplitude (the * operation will return a copy of the sound)
        hit = snare * random.triangular(0, 0.5)

        # Change the pitch of the snare using the base rate with a little jitter
        hit = hit.speed(random.triangular(minspeed, minspeed + 0.08))

        # Pan the snare
        hit = hit.pan(pan)

        # Finally, actually dub the snare into the output buffer at the desired location
        pos = onset / out.samplerate # convert frames to seconds
        out.dub(hit, pos)

# Write the sound to disk
out.write('multi_snare_bounce_example.wav')
