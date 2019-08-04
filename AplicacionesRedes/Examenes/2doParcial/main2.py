# imported the requests library 
import requests

def manejarArchivo(contenido):
	lineas=contenido.split("\n")
	for linea in lineas:
		if "<a" in linea:
			pass
		elif "<link" in lineas:
			pass
		elif "<script" in lineas:
			pass
	return contenido


url = "https://abs.twimg.com/a/1541650383/css/t1/twitter_core.bundle.css"

# URL of the image to be downloaded is defined as image_url
r = requests.get(url) # create HTTP response object
# send a HTTP request to the server and save
# the HTTP response in a response object called r
with open("prueba.css",'w') as f:
	# Saving received content as a png file in
	# binary format

	# write the contents of the response (r.content)
	# to a new file in binary mode.
	contenido=manejarArchivo(r.content.decode("utf-8"))
	f.write(contenido)

