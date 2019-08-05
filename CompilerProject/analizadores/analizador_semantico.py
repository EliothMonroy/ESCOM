from wav import ManejadorWav
import math


class ManejadorSGC:
    def __init__(self, arbol, manejador_e):
        if type(arbol) != Nodo:
            print('Error al cargar el arbol')
            exit()

        self.arbol = arbol
        self.ultimo_tocar = 0
        self.tabla = None
        self.manejador_errores = manejador_e

    def imprimir_arbol(self, hijo=None):
        if hijo == None:
            hijo = self.arbol

        print(hijo.clase)

        for x in hijo.hijos:
            self.imprimir_arbol(x)

    def obtenerID(self, nombre):
        if self.tabla.existe(nombre):
            return self.tabla.info[nombre]
        else:
            return None

    def operar(self, s1, s2, op):
        if op == '+':
            return s1 + s2
        elif op == '-':
            return s1 - s2
        elif op == '*':
            return s1 * s2
        elif op == '/':
            return s1 / s2

    def comparar(self, s1, s2, op, linea):
        if type(s1) == str:
            if op != '==' and op != '!=':
                self.manejador_errores.error(21, hijo.linea)

        if op == '==':
            return self.resultado_comparacion(s1 == s2)
        elif op == '!=':
            return self.resultado_comparacion(s1 != s2)
        elif op == '<=':
            return self.resultado_comparacion(s1 <= s2)
        elif op == '>=':
            return self.resultado_comparacion(s1 >= s2)
        elif op == '>':
            return self.resultado_comparacion(s1 > s2)
        elif op == '<':
            return self.resultado_comparacion(s1 < s2)


    def resultado_comparacion(self, booleano):
        if booleano:
            return 'verdadero'
        else:
            return 'falso'

    def incrementar_decrementar(self, op, val):
        if op == '--':
            return val - 1
        elif op == '++':
            return val + 1


    def generar_wav(self, hijo=None, opcional=None):
        if hijo == None:
            hijo = self.arbol

        if hijo.clase == 'funcion':
            self.generar_wav(hijo.hijos[1])

        elif hijo.clase == 'cuerpo':
            self.generar_wav(hijo.hijos[0])

        elif hijo.clase == 'lista_declaraciones':
            for x in hijo.hijos:
                self.generar_wav(x)

#TRABAJANDO EN ESTO
        elif hijo.clase == 'tocar':
            self.generar_wav(hijo.hijos[0])
            self.generar_wav(hijo.hijos[1])

            sincronizacion = 0
            instrumento = hijo.hijos[0].hijos[1].val # este es tipo str
            tempo = hijo.hijos[0].hijos[0].val
            arreglo_notas = hijo.hijos[1].val # un arreglo del objeto Nota

            if hijo.hijos[0].hijos[2].val != -1:
                sincronizacion = hijo.hijos[0].hijos[2].val
            else:
                sincronizacion = self.ultimo_tocar

            if tempo <= 0:
                self.manejador_errores.error(22, hijo.linea)

            #=====================================================#
            # En este apartado es donde va la funcion que agrega el arreglo_notas al archivo generar_wav
            # los parametros son: el tempo, instrumento, sincronizacion (segundos), arreglo_notas
            # la funcion debera retornar la duracion en segundos de lo que se agrego, esto con el fin de
            # igualarlo a self.ultimo_tocar que sera la futura variable sincronizacion de aquellos tocar
            # que no la tengan

            wav = ManejadorWav(tempo, instrumento, sincronizacion, arreglo_notas)
            self.ultimo_tocar = wav.crearWav()

            if self.ultimo_tocar < 0:
                self.manejador_errores.error(23, hijo.linea)

            # para hacer pruebas yo imprimo en consola las notas tocadas
            #for n in arreglo_notas:
            #    print(n)

            #=====================================================#


        elif hijo.clase == 'parametros_tocar':
            # analizamos el tempo
            self.generar_wav(hijo.hijos[0])

            #analizamos la sincronizacion
            self.generar_wav(hijo.hijos[2])

        elif hijo.clase == 'sincronizacion':
            if type(hijo.val) == str:
                if hijo.val != 'nada':
                    if self.tabla.existe(hijo.val):
                        aux_id = self.tabla.info[hijo.val]
                        if aux_id.tipo.lower() == 'entero' or aux_id.tipo.lower() == 'flotante':
                            hijo.val = aux_id.val
                            hijo.tipo = aux_id.tipo
                        else:
                            self.manejador_errores.error(3, hijo.linea)
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.val])
                else:
                    hijo.val = -1

        elif hijo.clase == 'tempo':
            if type(hijo.val) == str:
                if self.tabla.existe(hijo.val):
                    aux_id = self.tabla.info[hijo.val]
                    if aux_id.tipo.lower() == 'entero':
                        hijo.val = aux_id.val
                        hijo.tipo = aux_id.tipo
                    else:
                        self.manejador_errores.error(5, hijo.linea)
                else:
                    self.manejador_errores.error(4, hijo.linea, [hijo.val])


        elif hijo.clase == 'si':
            self.generar_wav(hijo.hijos[0])

            s1 = None

            if type(hijo.hijos[0].val) == str:
                s1 = self.obtenerID(hijo.hijos[0].val)
                if s1 == None:
                    if hijo.hijos[0].val == 'verdadero' or hijo.hijos[0].val == 'falso':
                        s1 = hijo.hijos[0]
                        s1.tipo = 'booleano'
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[0].val])
            else:
                s1 = hijo.hijos[0]

            if s1.tipo.lower() == 'booleano':
                if s1.val == 'verdadero':
                    self.generar_wav(hijo.hijos[1])
                else:
                    if len(hijo.hijos) == 3:
                        self.generar_wav(hijo.hijos[2].hijos[0])
            else:
                self.manejador_errores.error(6, hijo.linea)


        elif hijo.clase == 'para':
            self.generar_wav(hijo.hijos[0], 2)

            #print(hijo.hijos[0].hijos[1])
            while hijo.hijos[0].hijos[1].val == 'verdadero':
                self.generar_wav(hijo.hijos[1])
                self.generar_wav(hijo.hijos[0].hijos[2])
                self.generar_wav(hijo.hijos[0])


        elif hijo.clase == 'parametros_para':
            if opcional == 2:
                self.generar_wav(hijo.hijos[0])
            self.generar_wav(hijo.hijos[1])


        elif hijo.clase == 'mientras':
            self.generar_wav(hijo.hijos[0])

            while hijo.hijos[0].val == 'verdadero':
                self.generar_wav(hijo.hijos[1])
                self.generar_wav(hijo.hijos[0])


        elif hijo.clase == 'lista_tocar':
            if len(hijo.hijos) == 1:
                self.generar_wav(hijo.hijos[0])
                if hijo.hijos[0].clase == 'id':
                    if self.tabla.existe(hijo.hijos[0].val):
                        aux_id = self.tabla.info[hijo.hijos[0].val]
                        if aux_id.tipo.lower() == 'nota':
                            #### RECUERDA QUE AQUI FALTA HACER QUE LOS PUNTEROS NO SEAN LOS MISMOS
                            hijo.tipo = aux_id.tipo
                            hijo.val = aux_id.val
                        else:
                            self.manejador_errores.error(7, hijo.linea)
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[0].val])
                else:
                    if type(hijo.hijos[0].val) != list:
                        hijo.tipo = hijo.hijos[0].tipo
                        hijo.val = [hijo.hijos[0].val]
                    else:
                        hijo.tipo = hijo.hijos[0].tipo
                        hijo.val = hijo.hijos[0].val
            else:
                self.generar_wav(hijo.hijos[0])
                if hijo.hijos[1].clase == 'id':
                    if self.tabla.existe(hijo.hijos[1].val):
                        aux_id = self.tabla.info[hijo.hijos[1].val]
                        if aux_id.tipo.lower() == 'nota':
                            #### RECUERDA QUE AQUI FALTA HACER QUE LOS PUNTEROS NO SEAN LOS MISMOS
                            hijo.tipo = aux_id.tipo
                            hijo.val = hijo.hijos[0].val + aux_id.val
                        else:
                            self.manejador_errores.error(7, hijo.linea)
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[1].val])
                else:
                    self.generar_wav(hijo.hijos[1])
                    hijo.tipo = hijo.hijos[0].tipo
                    if type(hijo.hijos[1].val) != list:
                        hijo.val = hijo.hijos[0].val + [hijo.hijos[1].val]
                    else:
                        hijo.val = hijo.hijos[0].val + hijo.hijos[1].val

        elif hijo.clase == 'dec_asignacion':
            tipo_dato = hijo.hijos[0].tipo
            self.generar_wav(hijo.hijos[1], opcional=1)
            #print(tipo_dato, hijo.hijos[1].tipo)
            if tipo_dato.lower() != hijo.hijos[1].tipo.lower():
                self.manejador_errores.error(7, hijo.linea)
            else:
                hijo.val = hijo.hijos[1].val
                #print('mira:', hijo.val)


        elif hijo.clase == 'asignacion':
            self.generar_wav(hijo.hijos[1])

            if opcional == 1:
                if not self.tabla.existe(hijo.hijos[0].val[0]):
                    self.tabla.agregar(hijo.hijos[0].val[0])
                else:
                    self.manejador_errores.error(8, hijo.linea, hijo.hijos[0].val[0])
            else:
                if not self.tabla.existe(hijo.hijos[0].val[0]):
                    self.manejador_errores.error(4, hijo.linea, [hijo.hijos[0].val[0]])

            if hijo.hijos[1].clase == 'numero' or hijo.hijos[1].clase == 'booleano' or hijo.hijos[1].clase == '+' or hijo.hijos[1].clase == '-' or hijo.hijos[1].clase == '*' or hijo.hijos[1].clase == '/':
                if len(hijo.hijos[0].val) != 1:
                    self.manejador_errores.error(9, hijo.linea)

                if opcional == None:
                    if self.tabla.info[hijo.hijos[0].val[0]].tipo != hijo.hijos[1].tipo:
                        self.manejador_errores.error(7, hijo.linea)

                hijo.tipo = hijo.hijos[1].tipo
                hijo.val = hijo.hijos[0].val[0]
                self.tabla.info[hijo.hijos[0].val[0]].val = hijo.hijos[1].val
                self.tabla.info[hijo.hijos[0].val[0]].tipo = hijo.hijos[1].tipo

            elif hijo.hijos[1].clase == 'id':
                if self.tabla.existe(hijo.hijos[1].val):
                    id_simbolo = self.tabla.info[hijo.hijos[1].val]
                    if type(id_simbolo.val) != list:
                        if opcional == 1:
                            hijo.tipo = id_simbolo.tipo
                            hijo.val = hijo.hijos[0].val[0]
                            self.tabla.info[hijo.hijos[0].val[0]].val = id_simbolo.val
                            self.tabla.info[hijo.hijos[0].val[0]].tipo = id_simbolo.tipo
                        else:
                            if id_simbolo.tipo == self.tabla.info[hijo.hijos[0].val[0]].tipo:
                                if type(self.tabla.info[hijo.hijos[0].val[0]].val) != list:
                                    self.tabla.info[hijo.hijos[0].val[0]].val = id_simbolo.val
                                else:
                                    self.manejador_errores.error(24, hijo.linea)
                            else:
                                self.manejador_errores.error(7, hijo.linea)
                                #print('ERROR: las variables:', hijo.hijos[0].val[0], 'y', hijo.hijos[1].val, ', no son del mismo tipo')
                    else:
                        if len(hijo.hijos[0].val) == 2:
                            if hijo.hijos[0].val[1] == id_simbolo.longitud:
                                hijo.tipo = id_simbolo.tipo
                                hijo.val = hijo.hijos[0].val[0]
                                self.tabla.info[hijo.hijos[0].val[0]].val = id_simbolo.val
                                self.tabla.info[hijo.hijos[0].val[0]].tipo = id_simbolo.tipo
                                self.tabla.info[hijo.hijos[0].val[0]].longitud = id_simbolo.longitud
                            else:
                                self.manejador_errores.error(10, hijo.linea)
                        else:
                            self.manejador_errores.error(11, hijo.linea)
                else:
                    self.manejador_errores.error(4, hijo.linea, [hijo.hijos[1].val])

            elif hijo.hijos[1].clase == 'arreglo':
                if len(hijo.hijos[0].val) == 2:
                    self.generar_wav(hijo.hijos[1].hijos[0])
                    if opcional == 1:
                        #print(hijo.hijos[0].val[1], len(hijo.hijos[1].hijos[0].val))
                        if hijo.hijos[0].val[1] == len(hijo.hijos[1].hijos[0].val):
                            self.tabla.info[hijo.hijos[0].val[0]].tipo = hijo.hijos[1].hijos[0].tipo
                            self.tabla.info[hijo.hijos[0].val[0]].val = hijo.hijos[1].hijos[0].val
                            self.tabla.info[hijo.hijos[0].val[0]].longitud = len(hijo.hijos[1].hijos[0].val)
                            hijo.tipo = hijo.hijos[1].hijos[0].tipo
                            hijo.val = hijo.hijos[0].val[0]
                        else:
                            self.manejador_errores.error(10, hijo.linea)
                    else:
                        self.manejador_errores.error(12, hijo.linea)
                else:
                    self.manejador_errores.error(11, hijo.linea)



        elif hijo.clase == 'lista_arreglos':
            if len(hijo.hijos) == 1:
                if hijo.hijos[0].clase == 'numero' or hijo.hijos[0].clase == 'booleano':
                    hijo.tipo = hijo.hijos[0].tipo
                    hijo.val = [hijo.hijos[0].val]
                else:
                    if hijo.hijos[0].clase == 'llaves_notas':
                        self.manejador_errores.error(13, hijo.linea)
                    #print(hijo.hijos[0].clase)
                    self.generar_wav(hijo.hijos[0])
                    if hijo.hijos[0].clase == 'id':
                        if self.tabla.existe(hijo.hijos[0].val):
                            aux_id = self.tabla.info[hijo.hijos[0].val]
                            if aux_id.tipo.lower() == 'nota':
                                #### RECUERDA QUE AQUI FALTA HACER QUE LOS PUNTEROS NO SEAN LOS MISMOS
                                hijo.tipo = aux_id.tipo
                                hijo.val = aux_id.val
                            else:
                                self.manejador_errores.error(7, hijo.linea)
                        else:
                            self.manejador_errores.error(4, hijo.linea, [hijo.hijos[0].val])
                    else:
                        hijo.tipo = hijo.hijos[0].tipo
                        hijo.val = [hijo.hijos[0].val]

            else:
                self.generar_wav(hijo.hijos[0])
                if hijo.hijos[1].clase == 'numero' or hijo.hijos[1].clase == 'booleano':
                    if hijo.hijos[0].tipo != hijo.hijos[1].tipo:
                        self.manejador_errores.error(14, hijo.linea)
                    hijo.tipo = hijo.hijos[0].tipo
                    hijo.val = hijo.hijos[0].val + [hijo.hijos[1].val]
                else:
                    if hijo.hijos[1].clase == 'llaves_notas':
                        self.manejador_errores.error(13, hijo.linea)
                        return None
                    #print(hijo.hijos[1].clase)
                    self.generar_wav(hijo.hijos[1])
                    if hijo.hijos[1].clase == 'id':
                        if self.tabla.existe(hijo.hijos[1].val):
                            aux_id = self.tabla.info[hijo.hijos[1].val]
                            if aux_id.tipo.lower() == 'nota':
                                #### RECUERDA QUE AQUI FALTA HACER QUE LOS PUNTEROS NO SEAN LOS MISMOS
                                hijo.tipo = aux_id.tipo
                                hijo.val = hijo.hijos[0].val + aux_id.val
                            else:
                                self.manejador_errores.error(7, hijo.linea)
                        else:
                            self.manejador_errores.error(4, hijo.linea, [hijo.hijos[1].val])
                    else:
                        hijo.tipo = hijo.hijos[0].tipo
                        hijo.val = hijo.hijos[0].val + [hijo.hijos[1].val]

        elif hijo.clase == 'paren_notas':
            self.generar_wav(hijo.hijos[0])
            hijo.val = Nota()
            for x in hijo.hijos[0].val:
                hijo.val.notas.append(x.notas[0])

        elif hijo.clase == 'llaves_notas':
            self.generar_wav(hijo.hijos[0])
            hijo.val = hijo.hijos[0].val

        elif hijo.clase == 'lista_notas':
            if len(hijo.hijos) == 1:
                hijo.val = [hijo.hijos[0].val]
            else:
                self.generar_wav(hijo.hijos[0])
                hijo.val = hijo.hijos[0].val + [hijo.hijos[1].val]

        elif hijo.clase == 'tiempo_nota':
            self.generar_wav(hijo.hijos[1])
            if type(hijo.hijos[1].val) == str:
                self.manejador_errores.error(15, hijo.linea)
            if type(hijo.hijos[1].val) == list:
                tiempo = hijo.hijos[0].val / len(hijo.hijos[1].val)
                for x in range(0,len(hijo.hijos[1].val)):
                    hijo.hijos[1].val[x].duracion = tiempo
            else:
                #print('MM:', str(hijo.hijos[1].val.duracion), str(hijo.hijos[0].val))
                hijo.hijos[1].val.duracion = hijo.hijos[0].val

            hijo.val = hijo.hijos[1].val

        elif hijo.clase == 'potencia_nota':
            self.generar_wav(hijo.hijos[0])

            if type(hijo.hijos[1].val) == str:
                self.manejador_errores.error(15, hijo.linea)

            if type(hijo.hijos[0].val) == list:
                aux = list(hijo.hijos[0].val)
                for x in range(1,hijo.hijos[1].val):
                    hijo.hijos[0].val += aux
            else:
                #print(hijo.hijos[0].clase)
                hijo.hijos[0].val.repetir = hijo.hijos[1].val

            hijo.val = hijo.hijos[0].val

        elif hijo.clase == '+' or hijo.clase == '-' or hijo.clase == '*' or hijo.clase == '/':
            self.generar_wav(hijo.hijos[0])
            self.generar_wav(hijo.hijos[1])

            s1 = None
            s2 = None
            #print(hijo.hijos[0].clase)
            #print(hijo.hijos[1].val)
            if type(hijo.hijos[0].val) == str:
                s1 = self.obtenerID(hijo.hijos[0].val)
                if s1 == None:
                    if hijo.hijos[0].val == 'verdadero' or hijo.hijos[0].val == 'falso':
                        self.manejador_errores.error(16, hijo.linea)
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[0].val])
            else:
                s1 = hijo.hijos[0]

            if type(hijo.hijos[1].val) == str:
                s2 = self.obtenerID(hijo.hijos[1].val)
                if s2 == None:
                    if hijo.hijos[1].val == 'verdadero' or hijo.hijos[1].val == 'falso':
                        self.manejador_errores.error(16, hijo.linea)
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[1].val])
            else:
                s2 = hijo.hijos[1]

            if s1.tipo.lower() == s2.tipo.lower():
                if type(s1.val) != list and type(s2.val) != list:
                    hijo.val = self.operar(s1.val, s2.val, hijo.clase)
                    hijo.tipo = s1.tipo
                    if hijo.tipo.lower() == 'entero':
                        hijo.val = int(hijo.val)
                else:
                    self.manejador_errores.error(17, hijo.linea)
            else:
                self.manejador_errores.error(7, hijo.linea)


        elif hijo.clase == '==' or hijo.clase == '>=' or hijo.clase == '<=' or hijo.clase == '<' or hijo.clase == '>' or hijo.clase == '!=':
            self.generar_wav(hijo.hijos[0])
            self.generar_wav(hijo.hijos[1])

            s1 = None
            s2 = None

            if type(hijo.hijos[0].val) == str:
                s1 = self.obtenerID(hijo.hijos[0].val)
                if s1 == None:
                    if hijo.hijos[0].val == 'verdadero' or hijo.hijos[0].val == 'falso':
                        s1 = hijo.hijos[0]
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[0].val])
            else:
                s1 = hijo.hijos[0]

            if type(hijo.hijos[1].val) == str:
                s2 = self.obtenerID(hijo.hijos[1].val)
                if s2 == None:
                    if hijo.hijos[1].val == 'verdadero' or hijo.hijos[1].val == 'falso':
                        s2 = hijo.hijos[1]
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[1].val])
            else:
                s2 = hijo.hijos[1]

            if s1.tipo.lower() == s2.tipo.lower():
                if type(s1.val) != list and type(s2.val) != list:
                    hijo.tipo = 'booleano'
                    hijo.val = self.comparar(s1.val, s2.val, hijo.clase, hijo.linea)
                else:
                    self.manejador_errores.error(18, hijo.linea)
            else:
                self.manejador_errores.error(7, hijo.linea)


        elif hijo.clase == 'post' or hijo.clase == 'pre':
            self.generar_wav(hijo.hijos[0])

            s1 = None

            if type(hijo.hijos[0].val) == str:
                s1 = self.obtenerID(hijo.hijos[0].val)
                if s1 == None:
                    if hijo.hijos[0].val == 'verdadero' or hijo.hijos[0].val == 'falso':
                        self.manejador_errores.error(19, hijo.linea)
                    else:
                        self.manejador_errores.error(4, hijo.linea, [hijo.hijos[0].val])
            else:
                s1 = hijo.hijos[0]

            if s1.tipo.lower() == 'entero' or s1.tipo.lower() == 'flotante':
                self.tabla.info[hijo.hijos[0].val].val = self.incrementar_decrementar(hijo.interesante, self.tabla.info[hijo.hijos[0].val].val)
            else:
                self.manejador_errores.error(20, hijo.linea)

        elif hijo.clase == '||':
            self.generar_wav(hijo.hijos[0])
            self.generar_wav(hijo.hijos[1])

            if hijo.hijos[0].tipo.lower() != 'booleano':
                self.manejador_errores(6, hijo.linea)

            if hijo.hijos[1].tipo.lower() != 'booleano':
                self.manejador_errores(6, hijo.linea)

            if hijo.hijos[0].val == 'verdadero' or hijo.hijos[1].val == 'verdadero':
                hijo.val = 'verdadero'
            else:
                hijo.val = 'falso'

            hijo.tipo = 'booleano'


        elif hijo.clase == '&&':
            self.generar_wav(hijo.hijos[0])
            self.generar_wav(hijo.hijos[1])

            if hijo.hijos[0].tipo.lower() != 'booleano':
                self.manejador_errores(6, hijo.linea)

            if hijo.hijos[1].tipo.lower() != 'booleano':
                self.manejador_errores(6, hijo.linea)

            if hijo.hijos[0].val == 'verdadero' and hijo.hijos[1].val == 'verdadero':
                hijo.val = 'verdadero'
            else:
                hijo.val = 'falso'

            hijo.tipo = 'booleano'



class Nota:
    def __init__(self):
        self.duracion = 1
        self.notas = list()
        self.repetir = 1

    def __str__(self):
        imprimir = str(self.duracion) + str(self.notas) + '^' + str(self.repetir)
        return imprimir


class Nodo:
    def __init__(self, clase, hijos=[]):
        self.clase = clase
        self.hijos = hijos
        self.tipo = None
        self.val = None
        self.interesante = None
        self.linea = 0
