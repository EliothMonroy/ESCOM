from ply.lex import lex
import reglas
import sys

class AnalizadorLexico:

    def __init__(self):
        self.lexer = lex(module=reglas)

    def analizar(self, cadena):
        self.lexer.input(cadena)
        token = self.lexer.token()

        while token is not None:
            print(token)
            token = self.lexer.token()

class Main:

    def iniciar(self):

        analizador_lexico = AnalizadorLexico()

        if int(sys.argv[1]) == 0:
            archivo_prueba = open('mi_cancion.dje','r')
            analizador_lexico.analizar(archivo_prueba.read())
        else:
            while True:
                cadena = input('Ingresa una cadena: ')
                analizador_lexico.analizar(cadena)
                if input('otra? s/N') != 's':
                    break

main = Main()
main.iniciar()
