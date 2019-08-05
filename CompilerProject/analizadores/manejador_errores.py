
class ManejadorErrores:

    def __init__(self):
        self.lexico = 'ERROR LEXICO'
        self.sintactico = 'ERROR SINTACTICO'
        self.semantico = 'ERROR SEMANTICO'

    def error(self, tipo, linea, extras=[]):
        if tipo == 1:
            print(self.lexico, ' (linea '+str(linea)+'): el simbolo:', extras[0], ', no pertenece al lenguaje.')
        elif tipo == 2:
            print(self.sintactico, '(linea '+str(linea)+'): algo no cuadra con la sintaxis, simbolo = <', extras[0]+' > .')
        elif tipo == 3:
            print(self.semantico, '(linea '+str(linea)+'): la sincronizacion, solo puede ser entero o flotante.')
        elif tipo == 4:
            print(self.semantico, '(linea '+str(linea)+'): la variable:', extras[0], ', no ha sido declarada.')
        elif tipo == 5:
            print(self.semantico, '(linea '+str(linea)+'): el tempo, solo puede ser entero.')
        elif tipo == 6:
            print(self.semantico, '(linea '+str(linea)+'): en los parametros de los if, solo pueden haber expresiones booleanas.')
        elif tipo == 7:
            print(self.semantico, '(linea '+str(linea)+'): los tipos de datos no coinciden.')
        elif tipo == 8:
            print(self.semantico, '(linea '+str(linea)+'): la variable:', extras[0],',ya estaba declarada.')
        elif tipo == 9:
            print(self.semantico, '(linea '+str(linea)+'): no es posible declarar un arreglo con un numero.')
        elif tipo == 10:
            print(self.semantico, '(linea '+str(linea)+'): las dimensiones no coinciden.')
        elif tipo == 11:
            print(self.semantico, '(linea '+str(linea)+'): variable simple intentando ser declarada como arreglo.')
        elif tipo == 12:
            print(self.semantico, '(linea '+str(linea)+'): no es posible asignar arreglos a arreglos ya existentes.')
        elif tipo == 13:
            print(self.semantico, '(linea '+str(linea)+'): las llaves no se pueden colocar en los arreglos.')
        elif tipo == 14:
            print(self.semantico, '(linea '+str(linea)+'): el arreglo contiene diferentes tipos de datos.')
        elif tipo == 15:
            print(self.semantico, '(linea '+str(linea)+'): operacion invalida.')
        elif tipo == 16:
            print(self.semantico, '(linea '+str(linea)+'): los booleanos no se pueden operar asi.')
        elif tipo == 17:
            print(self.semantico, '(linea '+str(linea)+'): no se pueden operar aritmeticamente a los arreglos.')
        elif tipo == 18:
            print(self.semantico, '(linea '+str(linea)+'): las comparaciones logicas, no aplican para los arreglos.')
        elif tipo == 19:
            print(self.semantico, '(linea '+str(linea)+'): los booleanos no se pueden usar con los incrementos.')
        elif tipo == 20:
            print(self.semantico, '(linea '+str(linea)+'): solo se pueden incrementar o decrementar tipos de datos enteros o flotantes.')
        elif tipo == 21:
            print(self.semantico, '(linea '+str(linea)+'): los booleanos, solo pueden compararse con == o !=.')
        elif tipo == 22:
            print(self.semantico, '(linea '+str(linea)+'): el tempo, no puede ser menor o igual a 0.')
        elif tipo == 23:
            print(self.semantico, '(linea '+str(linea)+'): ocurrio un error al momento de generar el archivo.')
        elif tipo == 24:
            print(self.semantico, '(linea '+str(linea)+'): un arreglo no puede ser igualado a una variable simple.')

        exit()



# CODIGOS DE ERROR

# LEXICO
# 1 = El simbolo no pertenece al alfabeto

# SINTACTICO
# 2 = Error de sintaxis
