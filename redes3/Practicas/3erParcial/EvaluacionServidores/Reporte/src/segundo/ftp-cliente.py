from os import system
from urllib.request import urlopen
from sys import argv
from time import asctime
import string
from ftplib import FTP
from threading import Timer
import time

TIMEOUT = 5;

class FTPMonitor():
	def __init__(self, url, usr, pwd, arch_rem="/home/ftp/usuarioftp/archivo.txt", arch_loc="archivo_ftp.txt", direct="/home/ftp/usuarioftp/"):
		self.url = url
		self.usr = usr
		self.pwd = pwd
		self.status = "Down"
		self.tiempo_respuesta = -1
		self.respuesta = "No disponible"
		self.arch_rem = arch_rem
		self.arch_loc = arch_loc
		self.direct = direct
		self.conteo = -1

	def actualizar_SensorFTP(self):
		try:
			ftp = FTP(self.url, self.usr, self.pwd, None, TIMEOUT)
			
			inst_arch_l = open(self.arch_loc, 'wb')

			start = time.time()
			self.respuesta = ftp.retrbinary('RETR %s' % self.arch_rem, inst_arch_l.write)
			end = time.time()
			
			self.tiempo_respuesta = (end-start)
			
			self.status = "Up"

			ftp.quit()
		except Exception as e:
			self.status = "Down"
			self.tiempo_respuesta = -1
			self.respuesta = "No disponible"

			ftp.quit()

	def actualizar_SensorFTP_SFC(self):
		try:
			ftp = FTP(self.url, self.usr, self.pwd, None, TIMEOUT)

			#print(ftp.nlst('/home/ftp/usuarioftp/'))#Prueba del contenido de archivos
			self.conteo = len(ftp.nlst(self.direct))
			#print(self.conteo)#Prueba del valor de self.conteo

			ftp.quit()
		except Exception as e:
			self.conteo = -1
			ftp.quit()

	def imprimir(self):
		print ('Tiempo de respuesta: %.0f' % self.tiempo_respuesta)
		print ('Respuesta: '+self.respuesta)
		print ('Status: '+self.status)
		#print ('Archivo remoto: '+self.arch_rem)#Descomentar si se desea visualizar el nombre del archivo remoto
		#print ('Archivo local: '+self.arch_loc)#Descomentar si se desea visualizar el nombre del archivo local
		print ('Conteo: %d' % self.conteo)

#Prueba de la clase#
#if __name__ == '__main__':
#	monitorFTP = FTPMonitor('192.168.100.11','usuarioftp','usuarioftp','archivo.txt','hola2.txt','/home/ftp/usuarioftp/')
#	monitorFTP.actualizar_SensorFTP()
#	monitorFTP.actualizar_SensorFTP_SFC()
#	monitorFTP.imprimir()
#Prueba de la clase#

