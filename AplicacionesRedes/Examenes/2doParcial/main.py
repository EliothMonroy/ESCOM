#Importamos la librería para sockets de python
import socket
#Definimos el host
HOST="https://github.com/"
#Definimos el puerto
PORT=80
peticion = b"GET / HTTP/1.1\nHost: eliothmonroy.xyz\n\n"
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("eliothmonroy.xyz", PORT))
s.send(peticion)
resultado = s.recv(100000000).decode("utf-8")
print(resultado)
prueba=open("github.html","w")
prueba.write(resultado)
prueba.flush()
