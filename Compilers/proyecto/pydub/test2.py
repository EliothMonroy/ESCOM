import array
from funciones import *
from pydub import AudioSegment
wav1=cargarWav("doFlauta.wav")
wav2=cargarWav("doGuitarra.wav")
suma=concatenar(wav1,wav2)
exportarWav(suma,"suma.wav")