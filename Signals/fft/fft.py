from scipy.fftpack import fft,ifft
# Ejemplo de transformada de fourier usando scipy
# #Ejecutarlo así:
# "C:/ProgramData/Anaconda3/"python.exe fft.py
x=[1.0,2.0,1.0,-1.0,1.0]
y=fft(x)
print("FFT: ",y)
print("\n")
yinv=ifft(y)
print("IFFT: ",yinv)
