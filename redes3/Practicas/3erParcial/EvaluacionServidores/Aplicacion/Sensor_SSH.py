#!/usr/bin/env python3
import paramiko
import sys
import array
import time

class SSH():
	def __init__(self,host_address, username, password):
		self.initTime = float(time.time())
		self.totalTime = 0.0
		self.finalTime = 0.0
		self.stdout = {}
		self.num_conexiones=0

		self.host_address = host_address
		self.username = username
		self.password = password
		self.status = "Down"

	def SSHConnection(self):
		ssh = paramiko.SSHClient()
		ssh.load_system_host_keys()
		ssh.set_missing_host_key_policy(paramiko.WarningPolicy())
		try:
			ssh.connect(self.host_address, 22, self.username, self.password)
			#print ("\n-----------------------------------------")
			#print ("\nConnection established")
			#getNUmberofConnections(ssh)
			stdin, self.stdout, stderr=ssh.exec_command('echo $SSH_CONNECTION')
			if self.stdout:
				self.num_conexiones=len(self.stdout)
				linenum = 1
				self.status = "Up"
				for line in self.stdout:
					#print ("Connection #%i: "%linenum + line)
					linenum = linenum + 1
			else:
				self.status = "Down"
				#print ("Server Down")
				sys.exit(1)
			#END#getNUmberofConnections(ssh)

			#getConnectionTIme(ssh) CHECAR CUANDO SE DESCONECTE


			#print("Time connected: " + str(self.totalTime))
			#ENDgetConnectionTIme(ssh) CHECAR CUANDO SE DESCONECTE

			#getTrafficIN, Out(ssh)
			stdin, self.stdout, stderr=ssh.exec_command('lsof -i -n -P')
			if self.stdout:
				linenum = 1
				for line in self.stdout:
					self.status = "Up"
					#print ("Connection #%i: "%linenum + line)
					linenum = linenum + 1
			else:
				#print ("Server Down")
				self.status = "Down"
				sys.exit(1)
			self.finalTime = float(time.time())
			self.totalTime= float(self.finalTime - self.initTime)

		except:
			print ("Login failed: %s")
			sys.exit(1)
