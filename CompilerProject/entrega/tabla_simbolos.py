class Tabla:
    def __init__(self):
        self.info = dict()

    def agregar(self, simbolo):
        if simbolo not in self.info:
            self.info[simbolo] = Simbolo()
            return True
        return False

    def existe(self, simbolo):
        if simbolo in self.info:
            return True
        else:
            return False

    def __str__(self):
        impresion = ''
        for elemento, simbolo in self.info.items():
            impresion += elemento + ' -> ' + str(simbolo) + '\n'
        return impresion


class Simbolo:
    def __init__(self):
        self.tipo = None
        self.val = None
        self.longitud = None
        self.simple = True

    def __str__(self):
        return str(self.tipo) + ', ' + str(self.val) + ', ' + str(self.longitud) + ', ' + str(self.simple)
