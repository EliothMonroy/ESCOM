from flask import Flask, request, render_template, send_from_directory

app=Flask(__name__)

@app.route('/',methods=['GET','POST','HEAD','PUT','DELETE','CONNECT','OPTIONS','TRACE','PATCH'])
def hola():
	return "Hola mundo"


if __name__ == '__main__':
	# app.run(debug=True,port=5000,host='0.0.0.0',ssl_context=('cert.pem', 'key.pem'))
	app.debug=False
	app.run(debug=False,port=5000,host='0.0.0.0')