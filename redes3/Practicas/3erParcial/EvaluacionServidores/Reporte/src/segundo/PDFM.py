from reportlab.platypus import (SimpleDocTemplate, PageBreak, Image, Spacer,
Paragraph, Table, TableStyle)
from reportlab.lib.styles import getSampleStyleSheet,ParagraphStyle
from reportlab.lib.pagesizes import A4
from reportlab.lib import colors
from agente import Agente
from http_cliente import HTTPMonitor
#from Sensor_SSH import SSH
from ftp_cliente import FTPMonitor

class PDF():
	def __init__(self,id_agente, http, smtp, ftp, dns, imagen_cpu, imagen_ram, imagen_hdd):
		self.http_monitor = http
		self.smtp_monitor = smtp
		#self.ssh_monitor=ssh
		self.ftp_monitor=ftp
		self.dns_monitor=dns

		self.agente=Agente(id_agente)
		doc = SimpleDocTemplate("Evaluacion5.pdf", pagesize = A4)
		pdf=[]
		estiloTabla = TableStyle([
			('GRID',(0,0),(-1,-1),0.5,colors.grey),
			('ALIGN', (0,0), (-1, -1), 'CENTER'),
			('ALIGN', (0,0), (1, 1), 'LEFT'),
			('VALIGN', (0,0), (-1, -1), 'MIDDLE'),
			('BOX',(0,0),(-1,-1),2,colors.black),
			])

		estiloGraficas = TableStyle([
			('VALIGN', (0,0), (-1, -1), 'MIDDLE'),
			])

		estiloSensores = TableStyle([
			('GRID',(0,0),(-1,-1),0.5,colors.grey),
			('VALIGN', (0,0), (-1, -1), 'MIDDLE'),
			('BOX',(0,0),(-1,-1),2,colors.black),
			])

		estiloTexto = ParagraphStyle(name ='encabezado',fontSize = 18)
		Encabezado1 = Paragraph('Rendimiento de Servidor',estiloTexto)
		Encabezado2 = Paragraph('Supervisión de Sensores',estiloTexto)

		datosGenerales = (
			('No. de Equipo: 4', 'Integrantes\nHernández Pineda Miguel Angel\nMonroy Martos Elioth\nOrta Cisneros Sabrina\nRamírez Centeno Hugo Enrique\nSaldaña Aguilar Andrés Arnulfo\nZuñiga Hernández Carlos', 'Fecha\n08/05/2019'),
			('Sistema Operativo:'+self.agente.nombre_so, 'Tiempo de Actividad: VALUE', 'Numero de Interfaces:' +self.agente.num_interfaces))

		graficaCPU= Image(imagen_cpu,width=200,height=100)
		graficaRAM= Image(imagen_ram,width=200,height=100)
		graficaHDD= Image(imagen_hdd,width=200,height=100)

		datosGraficas =(
			('Uso de CPU',graficaCPU),
			('Uso de RAM',graficaRAM),
			('Uso de HDD',graficaHDD))

		datosSensores = (
			('Sensor SMTP & IMAP/POP3', 'Tiempo de Respuesta SMTP-IMAP: '+str(self.smtp_monitor.smtp_imap_time)+'\nTiempo de Respuesta IMAP:'+str(self.smtp_monitor.imap_time)+'\nTiempo de Respuesta SUMA:'+str(self.smtp_monitor.imap_total)+'\nTiempo de Respuesta SMTP-POP3: '+str(self.smtp_monitor.smtp_pop_time)+'\nTiempo de Respuesta POP3:'+str(self.smtp_monitor.pop_time)+'\nTiempo de Respuesta SUMA:'+str(self.smtp_monitor.pop_total)+'\nStatus:'+str(self.smtp_monitor.status)),
			('Sensor HTTP', 'Tiempo de Respuesta: '+self.http_monitor.tiempo_respuesta+'\nBytes Recibidos: '+self.http_monitor.tam+'\nAncho de Banda de descarga: '+self.http_monitor.ancho_banda+' Kb/s\nStatus: '+self.http_monitor.status),
			('Sensor FTP', 'Tiempo de Respuesta: '+str(self.ftp_monitor.tiempo_respuesta)+'\nRespuesta del Servidor: '+self.ftp_monitor.respuesta+'\nStatus: '+self.ftp_monitor.status),
			('Sensor FTP Server File Count', 'No. de Archivos: '+str(self.ftp_monitor.conteo)),
			('Sensor DNS', 'Tiempo de Respuesta:'+str(self.dns_monitor.getTiempo())+'\nStatus:'+self.dns_monitor.getStatus()))
			#('Sensor de Acceso Remoto', 'No. de Conexiones: '+self.ssh_monitor.num_conexiones+'\nTiempo de Actividad: '+self.ssh_monitor.totalTime+'\nStatus: '+self.ssh_monitor.status))


		TablaPrincipal = Table(data = datosGenerales, style = estiloTabla, colWidths=180)
		TablaGraficas = Table(data = datosGraficas, style = estiloGraficas, colWidths=210)
		TablaSensores = Table(data = datosSensores, style = estiloSensores, colWidths=270)
		pdf.append(TablaPrincipal)
		pdf.append(Spacer(0,30))
		pdf.append(Encabezado1)
		pdf.append(Spacer(0,25))
		pdf.append(TablaGraficas)
		pdf.append(PageBreak())
		pdf.append(Encabezado2)
		pdf.append(Spacer(0,25))
		pdf.append(TablaSensores)
		doc.build(pdf)
