import cv2
import threading, time
import socket
import select
#cap=cv2.VideoCapture(0);

# while(True):
# 	leido, frame=cap.read()
# 	if leido==True:
# 		cv2.imwrite("static/image.jpg",frame)
# 		#print("Foto tomada")
# 	else:
# 		pass
# 		#print("Error al acceder a la cámara")
# 	time.sleep(.8)

# cap.release()




server_addr = '127.0.0.1', 5555

# Create a socket with port and host bindings
def setupServer():
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    print("Socket created")
    try:
        s.bind(server_addr)
    except socket.error as msg:
        print(msg)
    return s


# Establish connection with a client
def setupConnection(s):
    s.listen(5)     # Allows five connections at a time
    print("Waiting for client")
    conn, addr = s.accept()
    return conn


# Get input from user
def GET():
    reply = input("Reply: ")
    return reply


def sendFile(filename, conn):
    f = open(filename, 'rb')
    line = f.read(1024)

    print("Beginning File Transfer")
    while line:
        conn.send(line)
        line = f.read(1024)
    f.close()
    print("Transfer Complete")


# Loop that sends & receives data
def dataTransfer(conn, s, mode):
    while True:
        # Send a File over the network
        if mode == "SEND":
            filename = conn.recv(1024)
            filename = filename.decode(encoding='utf-8')
            filename.strip()
            print("Requested File: ", filename)
            sendFile(filename, conn)
            # conn.send(bytes("DONE", 'utf-8'))
            break

        # Chat between client and server
        elif mode == "CHAT":
            # Receive Data
            print("Connected with: ", conn)
            data = conn.recv(1024)
            data = data.decode(encoding='utf-8')
            data.strip()
            print("Client: " + data)
            command = str(data)
            if command == "QUIT":
                print("Server disconnecting")
                s.close()
                break

            # Send reply
            reply = GET()
            conn.send(bytes(reply, 'utf-8'))

    conn.close()


sock = setupServer()
while True:
    try:
        connection = setupConnection(sock)
        dataTransfer(connection, sock, "SEND")
    except:
        break