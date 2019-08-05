import time
from pippi import dsp

start_time = time.time()

# Load some boinging into a SoundBuffer. Or:
#   from pippi.soundbuffer import SoundBuffer
#   snd = SoundBuffer(filename='sounds/boing.wav')
snd = dsp.read('sounds/boing.wav')

# Returns an empty SoundBuffer instance that 
# we can dub our grains into. Or:
#   from pippi.soundbuffer import SoundBuffer
#   out = SoundBuffer()
out = dsp.buffer() 
assert out.frames is None # Empty buffers have a None internal framebuffer
assert not out # and they are falsey

# Make several passes over the sound, 
# layering grains into the buffer
num_passes = 4

for i in range(num_passes):
    # Split the sound into fixed sized grains 
    # 400 frames long and loop over them to 
    # process and dub into the output buffer

    grain_size = 0.02
    recordhead = 0
    for grain in snd.grains(grain_size):
        # Apply a sine window to the grain and attenuate 
        # to 25% of original amplitude
        grain = grain.env(dsp.SINE) * 0.25

        # Dub the grain into the current recordhead postion
        out.dub(grain, pos=recordhead)

        # Move the recordhead forward
        recordhead += i * 0.01 + 0.01

# Write the output buffer to a WAV file
out.write('simple_grains.wav')
elapsed_time = time.time() - start_time
print('Render time: %s seconds' % round(elapsed_time, 2))
print('Output length: %s seconds' % round(out.dur, 2))
