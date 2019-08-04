from flask import Flask
from flask_restful import reqparse, Api, Resource
from flask_cors import CORS, cross_origin
import json
#import codecs
app = Flask(__name__)
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0
CORS(app)
api = Api(app)

'''Usuarios={
    'e@gmail.com':{'Nombre':'Elioth','Apellidos':'Monroy Martos','Contra':'123'},
    'e2@gmail.com':{'Nombre':'Elioth','Apellidos':'Monroy Martos','Contra':'123'}
}'''

'''Quejas={
    '1':{'Contenido':"Prueba"}
}'''
Servicios={
    '1':{'Creador':'e@gmail.com','Nombre':'Prueba'},
    '2':{'Creador':'e@gmail.com','Nombre':'Prueba2'}
}
Frases={
    '1':{'Creador':'e@gmail.com','Categoria':'1','Nombre':'Prueba','Contenido':'Soy de prueba'},
    '2':{'Creador':'e@gmail.com','Categoria':'1','Nombre':'Prueba2','Contenido':'Soy de prueba 2'}
}

#otra forma: dato=request.form['nombre_campo']
parser = reqparse.RequestParser()
parser.add_argument('nombre')
parser.add_argument('correo')
parser.add_argument('apellidos')
parser.add_argument('contra')
parser.add_argument('creador')
parser.add_argument('categoria')
parser.add_argument('contenido')

#Usuario
class Usuario(Resource):
    #Obtener toda información de un usuario mediante su Id
    def get(self,id):
        with open('usuarios.txt', encoding='utf-8') as fi:
            Usuarios = json.load(fi)
        if id in Usuarios.keys():
            return Usuarios[id]
        else:
            return {'Mensaje':'Usuario no encontrado','Success':False}
    #Registrar Usuario
    def post(self):
        args = parser.parse_args()
        usuario_id = str(args['correo'])
        with open('usuarios.txt', encoding='utf-8') as fi:
            Usuarios = json.load(fi)
        if usuario_id in Usuarios.keys():
            return {'Mensaje':'Correo ya existente','Success':False}
        else:
            Usuarios[usuario_id] = {'Nombre': args['nombre'],'Apellidos':args['apellidos'],'Contra':args['contra']}
            with open('usuarios.txt', 'w',encoding='utf-8') as f:
                json.dump(Usuarios, f,ensure_ascii=False)
            return {'Mensaje':'Registro exitoso','Success':True}

#Clase para el Login de un usuario
class LoginUsuario(Resource):
    #Solo un método para el login
    def post(self):
        args=parser.parse_args()
        with open('usuarios.txt',encoding='utf-8') as fi:
            Usuarios = json.load(fi)
        if str(args['correo']) in Usuarios.keys():
            for correo in Usuarios.keys():
                if correo==args['correo'] and Usuarios[correo]['Contra']==args['contra']:
                    return Usuarios[args['correo']]
            return {'Mensaje':'Usuario o contraseña no válidos','Success':False}
        else:
            return {'Mensaje':'Usuario o contraseña no válidos','Success':False}

#Servicios
class Servicio(Resource):
    #Con get obtenemos todos los servicios que haya creado un usuario
    def get(self,id):
        aux=False
        ServiciosUsuario={}
        for servicio_id in Servicios.keys():
            if Servicios[servicio_id]['Creador']==id:
                aux=True
                ServiciosUsuario[servicio_id]=Servicios[servicio_id]
        if aux:
            return ServiciosUsuario
        else:
            return {'Mensaje':'El usuario no tiene servicios','Success':False}
    #Creación de un servicio
    def post(self):
        args=parser.parse_args()
        servicio_id = int(max(Servicios.keys())) + 1
        Servicios[servicio_id]={'Creador':args['correo'],'Nombre':args['nombre']}
        return {'Mensaje':'Servicio creado exitosamente','Success':True}
    #Eliminar un Servicio
    def delete(self,id):
        del Servicios[id]
        return {'Mensaje':'Servicio eliminado con exito','Success':True}

#Frases
class Frase(Resource):
    #Obtener las frases que tenga un usuario en alguna categoria
    def get(self,id,servicio_id):
        aux=False
        FrasesUsuario={}
        for frase_id in Frases.keys():
            if Frases[frase_id]['Creador']==id and Frases[frase_id]['Categoria']==servicio_id:
                aux=True
                FrasesUsuario[frase_id]=Frases[frase_id]
        if aux:
            return FrasesUsuario
        else:
            return {'Mensaje':'El usuario no tiene frases creadas en esta categoria','Success':False}
    #Eliminar una frase
    def delete(self,frase_id):
        del Frases[frase_id]
        return {'Mensaje':'Frase eliminada con éxito','Success':True}
    #Guardar una frase
    def post(Resource):
        args=parser.parse_args()
        id = int(max(Frases.keys())) + 1
        Frases[id]={'Creador':args['correo'],'Categoria':args['categoria'],'Nombre':args['nombre'],'Contenido':args['contenido']}
        return {'Mensaje':'Frase guardada con éxito','Success':True}
    #Editar una frase
    def set(Resource,frase_id):
        args=parser.parse_args()
        Frases[frase_id]={'Creador':Frases[frase_id]['Creador'],'Categoria':Frases[frase_id]['Categoria'],'Nombre':args['nombre'],'Contenido':args['contenido']}
        return {'Mensaje':'Frase editada con éxito','Success':True}

#Quejas
class Queja(Resource):
    #Obtener todas las quejas
    def get(self):
        with open('quejas.txt', encoding='utf-8') as fi:
            Quejas = json.load(fi)
        return Quejas
    #Guardar alguna queja
    def post(self):
        args=parser.parse_args()
        with open('quejas.txt', encoding='utf-8') as fi:
            Quejas = json.load(fi)
        queja_id = int(max(Quejas.keys())) + 1
        Quejas[queja_id]={'Contenido':args['contenido']}
        with open('quejas.txt', 'w',encoding='utf-8') as f:
            json.dump(Quejas, f,ensure_ascii=False)
        return {'Mensaje':'Queja guardada con exito','Success':True}

class Sincronizar(Resource):
    #Esto descarga la información de un usuario
    def get(self,id):
        with open('contenido.txt', encoding='utf-8') as fi:
            Contenidos = json.load(fi)
        if id in Contenidos.keys():
            return Contenidos[id]['Contenido']
        else:
            return {'Success':False}
    def post(self):
        args=parser.parse_args()
        id_usuario=str(args['correo'])
        print("Usuario: ", args['contenido'])
        with open('contenido.txt', encoding='utf-8') as fi:
            Contenidos = json.load(fi)
        Contenidos[id_usuario]={"Contenido":args['contenido']}
        print(Contenidos)
        with open('contenido.txt', 'w',encoding='utf-8') as f:
            json.dump(Contenidos, f,ensure_ascii=False)
        return {'Success':True}

## Actually setup the Api resource routing here
api.add_resource(Usuario,'/usuario/<id>','/usuario')
api.add_resource(LoginUsuario,'/login')
api.add_resource(Servicio,'/servicio/<id>','/servicio')
api.add_resource(Frase,'/frase/<id>/<servicio_id>','/frase/<frase_id>','/frase')
api.add_resource(Queja,'/queja')
api.add_resource(Sincronizar,'/sincronizar/<id>','/sincronizar')

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')
