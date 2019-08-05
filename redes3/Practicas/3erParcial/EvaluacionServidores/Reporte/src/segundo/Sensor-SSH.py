#!/usr/bin/env python3
import paramiko
import sys
import keyboard
import array
import time

class SSH():
	def __init__(self,host_address, username, password):
		self.initTime = float(time.time())
		self.totalTime = 0.0
		self.stdout = {}

		self.host_address = host_address
		self.username = username
		self.password = password
		self.status = ""
		
	def SSHConnection(self):
		ssh = paramiko.SSHClient()
		#ssh.load_system_host_keys()
		ssh.set_missing_host_key_policy(paramiko.WarningPolicy())
		try:
			ssh.connect(self.host_address, 22, self.username, self.password)
			print ("\n-----------------------------------------")
			print ("\nConnection established")
			#getNUmberofConnections(ssh)
			stdin, self.stdout, stderr=ssh.exec_command('echo $SSH_CONNECTION')
			if self.stdout:
				linenum = 1
				for line in self.stdout:
					print ("Connection #%i: "%linenum + line)
					linenum = linenum + 1
			else:
				self.status = "Down"
				print ("Server Down")
				sys.exit(1)
			#END#getNUmberofConnections(ssh)

			#getConnectionTIme(ssh) CHECAR CUANDO SE DESCONECTE
			
			#ENDgetConnectionTIme(ssh) CHECAR CUANDO SE DESCONECTE

			#getTrafficIN, Out(ssh)
			stdin, self.stdout, stderr=ssh.exec_command('ifstat -t -i lo 1')
			if self.stdout or stderr:
				for line in self.stdout:
					print (line)
					if keyboard.is_pressed('q'):
						#print ("Key pressed")
						ssh.close()
						#getConnectionTIme()
						self.finalTime = float(time.time())
						self.totalTime= float(self.finalTime - self.initTime)
						print("Time connected: " + str(self.totalTime))
						break
					else:
						pass

			else:
				self.status = "Down"
				print ("Server Down")
				sys.exit(1)


		except paramiko.ssh_exception as e:
			print ("Login failed: %s" % e)
			sys.exit(1)

SSHClient = SSH("localhost","bri","SWS0810")
SSHClient.SSHConnection()