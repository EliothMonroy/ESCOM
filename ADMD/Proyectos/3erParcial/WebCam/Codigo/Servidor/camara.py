import cv2
import threading, time
import pickle
cap=cv2.VideoCapture(0);
while(True):
	leido, frame=cap.read()
	if leido==True:
		cv2.imwrite("static/image.jpg",frame)
		#print(len(frame))
	else:
		passå
		#print("Error al acceder a la cámara")
	time.sleep(.8)
cap.release()