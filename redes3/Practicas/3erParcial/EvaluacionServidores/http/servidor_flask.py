#pip3 install flask
#openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365
#pip3 install Flask-SSLify
#http --verify=no POST https://example.org
from flask import Flask, request, render_template, send_from_directory
from flask_sslify import SSLify

app=Flask(__name__)
sslify = SSLify(app)

@app.route('/',methods=['GET','POST','HEAD','PUT','DELETE','CONNECT','OPTIONS','TRACE','PATCH'])
def hola():
	if request.method=='POST':
		return "Hola, mundo POST"
	elif request.method=='GET':
		return "Hola, mundo GET"
	elif request.method=='HEAD':
		return "Hola, mundo HEAD"
	elif request.method=='PUT':
		return "Hola, mundo PUT"
	elif request.method=='DELETE':
		return "Hola, mundo DELETE"
	elif request.method=='CONNECT':
		return "Hola, mundo CONNECT"
	elif request.method=='OPTIONS':
		return "Hola, mundo OPTIONS"
	elif request.method=='TRACE':
		return "Hola, mundo TRACE"
	elif request.method=='PATCH':
		return "Hola, mundo PATCH"
	else:
		return "Hola, mundo método que no debería de existir"

@app.route('/inicio',methods=['GET'])
def inicio():
	return render_template('inicio.html')

@app.route('/file')
def download_file():
	return send_from_directory('', "test100k.db")

if __name__ == '__main__':
	# app.run(debug=True,port=5000,host='0.0.0.0',ssl_context=('cert.pem', 'key.pem'))
	app.debug=False
	app.run(debug=False,port=5000,host='0.0.0.0',ssl_context=('cert.pem', 'key.pem'))