import expresiones_regulares
from ply.lex import lex


class AnalizadorLexico:

    def __init__(self):
        self.lexer = lex(module=expresiones_regulares)

    def analizar(self, cadena):
        self.lexer.input(cadena)

        for token in self.lexer:
            print(token)
