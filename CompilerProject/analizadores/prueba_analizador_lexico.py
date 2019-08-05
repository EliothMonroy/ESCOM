from analizador_lexico import AnalizadorLexico
import sys


class Main:

    def iniciar(self):

        analizador_lexico = AnalizadorLexico()

        if int(sys.argv[1]) == 0:
            archivo_prueba = open('mi_cancion.dje', 'r')
            analizador_lexico.analizar(archivo_prueba.read())
        else:
            while True:
                cadena = input('Ingresa una cadena: ')
                analizador_lexico.analizar(cadena)
                if input('otra? s/N') != 's':
                    break

main = Main()
main.iniciar()
