import reglas_parseo
import expresiones_regulares
import os
import sys

from ply.lex import lex
from ply.yacc import yacc
from analizador_semantico import ManejadorSGC, Nodo
from tabla_simbolos import Tabla
from manejador_errores import ManejadorErrores

nombre_archivo = sys.argv[1]

try:
    validador = nombre_archivo.split('.')
    if validador[1] != 'dje':
        print('El archivo no contiene la extension .dje')
        exit()
except:
    print('Error al abrir el archivo')
    exit()

if os.path.isfile('salida.wav'):
    os.remove('salida.wav')

lexer = lex(module=expresiones_regulares)
parseo = yacc(module=reglas_parseo)
archivo_prueba = open(nombre_archivo, 'r')


ast = parseo.parse(archivo_prueba.read(), lexer, tracking=True)

sgc = ManejadorSGC(ast, ManejadorErrores())
#sgc.imprimir_arbol()

sgc.tabla = Tabla()
sgc.generar_wav()

#print(sgc.tabla.info['a'].val[1].notas)
print(sgc.tabla)
