import cv2
import threading, time
import pickle
import socket
cap=cv2.VideoCapture(0);

HOST='0.0.0.0'
PORT=8485

s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)
print('Socket created')

s.bind((HOST,PORT))
print('Socket bind complete')
s.listen(10)
print('Socket now listening')

conn,addr=s.accept()

print('Conexión aceptada')

#encode_param = [int(cv2.IMWRITE_JPEG_QUALITY), 90]


while(True):
	leido, frame=cap.read()
	if leido==True:
		data = pickle.dumps(frame, 0)
		#size = len(data)
		conn.send(data)
		#cv2.imwrite("static/image.jpg",frame)
		#print(len(frame))
	else:
		pass
		#print("Error al acceder a la cámara")
	#time.sleep(.8)

cap.release()