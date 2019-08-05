#https://github.com/jiaaro/pydub
import array,funciones
from pydub import AudioSegment
song = AudioSegment.from_wav("doFlauta.wav")
song2= AudioSegment.from_wav("doGuitarra.wav")

samples = song.get_array_of_samples()
samples2 = song2.get_array_of_samples()
# then modify samples...
print ("Numero samples: "+str(len(samples)))
samples3=[None] * len(samples)
count=0
for i in samples:
	samples3[count]=int((samples[count]+samples2[count])/2)
	count+=1
samples3_arreglo= array.array(song.array_type, samples3)
new_sound = song._spawn(samples3_arreglo)
song3=song+song+song
new_sound.export("doFlauta_Guitarra.wav",format="wav")