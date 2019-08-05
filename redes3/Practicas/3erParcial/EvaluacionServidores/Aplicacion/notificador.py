import smtplib
from email.mime.image import MIMEImage
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import datetime

class Notificador():
	def __init__(self,agente):
		self.remitente = "admiredes3.4CM1@gmail.com"
		self.destinatario = "admiredes3.4CM1@gmail.com"
		self.servidor = 'smtp.gmail.com: 587'
		self.contra = 'fidha5-dykdYx-dexqir'
		self.agente=agente
	def enviarCorreo(self,tipo,imagen=""):
		asunto,texto=self.obtenerContenido(tipo)
		hora=self.obtenerHora()
		texto="El agente: "+self.agente+" "+texto+hora
		#Definimos contenido del correo
		mensaje = MIMEMultipart()
		mensaje['Subject'] = asunto
		mensaje['From'] = self.remitente
		mensaje['To'] = self.destinatario
		mensaje.attach(MIMEText(texto, "plain"))
		#Verificamos si hay que enviar una imagen
		if imagen!="":
			with open(imagen, 'rb') as f:
				img = MIMEImage(f.read())
				f.close()
				mensaje.attach(img)
		#Enviamos el correo
		servidor_correo = smtplib.SMTP(self.servidor)
		servidor_correo.starttls()
		servidor_correo.login(self.remitente, self.contra)
		servidor_correo.sendmail(self.remitente, self.destinatario, mensaje.as_string())
		servidor_correo.quit()
	def obtenerContenido(self,tipo):
		with open("mensajes.txt") as f:
			for i, linea in enumerate(f):
				if i==tipo:
					return linea.split(";")
			else:
				return ["",""]
	def obtenerHora(self):
		return str(datetime.datetime.now())