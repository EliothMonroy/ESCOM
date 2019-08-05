from expresiones_regulares import tokens
from tabla_simbolos import Tabla
from analizador_semantico import Nodo, Nota
from manejador_errores import ManejadorErrores


precedence = (
    ('left', 'OR'),
    ('left', 'AND'),
    ('left', 'OPERADOR_LOGICO'),
    ('left', 'SUMA', 'RESTA'),
    ('left', 'DIVISION', 'MULTI'),
    ('left', 'POST'),
    ('right', 'UMINUS', 'PRE'),
)


# FUNCION
def p_funcion(p):
    """funcion : FUNCION MAIN PAREN_IZQ PAREN_DER cuerpo"""
    aux = Nodo('main')
    aux.val = p[2]
    p[0] = Nodo('funcion', [aux, p[5]])
    p[0].linea = p.lineno(0)

    # funcion.type = void
# FINAL FUNCION


def p_cuerpo(p):
    """cuerpo : LLAVE_IZQ lista_declaraciones LLAVE_DER"""
    p[0] = Nodo('cuerpo', [p[2]])
    p[0].linea = p.lineno(0)

    # cuerpo.type = void


def p_declaracion(p):
    """declaracion : tocar
                   | declaracion_si
                   | declaracion_mientras
                   | declaracion_para
                   | dec_variable
                   | modificacion_var
                   | expresion PUNTO_COMA"""
    p[0] = p[1]

    # declaracion.type = void


def p_lista_declaraciones(p):
    """lista_declaraciones : lista_declaraciones declaracion
                           | declaracion"""
    if len(p) == 3:
        p[0] = Nodo('lista_declaraciones', [p[1], p[2]])
    else:
        p[0] = Nodo('lista_declaraciones', [p[1]])
    p[0].linea = p.lineno(0)

    # lista_declaraciones.type = void


# SI
def p_declaracion_si(p):
    """declaracion_si : SI PAREN_IZQ expresion PAREN_DER cuerpo"""
    p[0] = Nodo('si', [p[3], p[5]])
    p[0].linea = p.lineno(0)

    # declaracion_si.type = void
    # expresion.type == BOOL, si no, type_error
    # cuerpo.type = void


def p_declaracion_si_sino(p):
    """declaracion_si : SI PAREN_IZQ expresion PAREN_DER cuerpo SINO cuerpo"""
    p[0] = Nodo('si', [p[3], p[5], Nodo('sino', [p[7]])])
    p[0].linea = p.lineno(0)
    # declaracion_si.type = void
    # expresion.type == BOOL, si no, type_error
    # cuerpo1.type = void
    # cuerpo2.type = void

# FIN SI


# MIENTRAS
def p_declaracion_mientras(p):
    """declaracion_mientras : MIENTRAS PAREN_IZQ expresion PAREN_DER cuerpo"""
    p[0] = Nodo('mientras', [p[3], p[5]])
    p[0].linea = p.lineno(0)

    # declaracion_mientras.type = void
    # expresion.type == BOOL, si no type_error
    # cuerpo.type = void

# FIN MIENTRAS


# LOOP PARA
def p_declaracion_para(p):
    """declaracion_para : PARA PAREN_IZQ parametros_para PAREN_DER cuerpo"""
    p[0] = Nodo('para', [p[3], p[5]])
    p[0].linea = p.lineno(0)

    # declaracion_para.type = void
    # parametros_para.type = BOOL ... TENGO DUDA


# el parametros de incremento deberia de ser una expresion aritmetica
def p_parametros_para(p):
    """parametros_para : dec_asignacion COMA expresion COMA expresion"""
    p[0] = Nodo('parametros_para', [p[1], p[3], p[5]])
    p[0].linea = p.lineno(0)

    # parametros_para.type = BOOL
    #                   si asignacion.type = asignacion &&
    #                   expresion.type == BOOL && expresion.type = aritmetica
    #                   si no type_error

# FIN LOOP PARA


def p_instrumento(p):
    """instrumento : PIANO
                   | GUITARRA
                   | FLAUTA"""
    p[0] = Nodo('instrumento')
    p[0].val = p[1].lower()
    p[0].linea = p.lineno(0)

    # instrumento.type = instrumento
    # instrumento.val = valor de la produccion usada (PIANO | GUITARRA | FLAUTA)


def p_numero(p):
    """numero : CONSTANTE_ENTERA
              | CONSTANTE_FLOTANTE"""
    p[0] = Nodo('numero')
    p[0].val = p[1]
    if type(p[1]) == int:
        p[0].tipo = 'ENTERO'
    else:
        p[0].tipo = 'FLOTANTE'
    p[0].linea = p.lineno(0)

    # numero.val = valor de CONSTANTE_ENTERA | CONSTANTE_FLOTANTE
    # numero.type = typo de CONSTANTE_ENTERA | CONSTANTE_FLOTANTE


def p_lista_notas(p):
    """lista_notas : lista_notas COMA nota
                   | nota"""
    if (len(p) == 4):
        p[0] = Nodo('lista_notas', [p[1], p[3]])
    else:
        p[0] = Nodo('lista_notas', [p[1]])
    p[0].linea = p.lineno(0)

    # lista_notas.type = nota
    # ... TENGO DUDA


def p_nota(p):
    """nota : DO
            | RE
            | MI
            | FA
            | SOL
            | LA
            | SI"""
    p[0] = Nodo('nota')
    p[0].val = Nota()
    p[0].val.notas.append(p[1])
    p[0].tipo = 'nota'
    p[0].linea = p.lineno(0)

    # nota.type = notas
    # nota.val = valor de la nota


# PARENTESIS NOTAS
def p_parentesis_notas(p):
    """paren_notas : PAREN_IZQ lista_notas PAREN_DER"""
    p[0] = Nodo('paren_notas', [p[2]])
    p[0].tipo = 'nota'
    p[0].linea = p.lineno(0)

    # paren_notas.type = lista_notas.type

# FINAL PARENTESIS NOTAS


# LLAVES NOTAS
def p_llaves_notas(p):
    """llaves_notas : LLAVE_IZQ lista_notas LLAVE_DER"""
    p[0] = Nodo('llaves_notas', [p[2]])
    p[0].tipo = 'nota'
    p[0].linea = p.lineno(0)

    # llaves_notas.type = lista_notas.type

# FIN LLAVES NOTAS


def p_elemento(p):
    """elemento : paren_notas
                | llaves_notas
                | nota
                | ID"""
    if type(p[1]) == Nodo:
        p[0] = p[1]
    else:
        p[0] = Nodo('id')
        p[0].val = p[1]
    p[0].linea = p.lineno(0)

    # elemento.type = produccion.type


def p_tiempo_nota(p):
    """tiempo_nota : numero elemento
                   | numero modificador_nota"""
    p[0] = Nodo('tiempo_nota', [p[1], p[2]])
    p[0].tipo = 'nota'
    p[0].linea = p.lineno(0)

    # 1.- si elemento.type = nota, entonces tiempo_nota.type = nota, si no type_error
    # 2.- si modificador_nota.type = nota, entonces tiempo_nota.type = nota, si no type_error


# POTENCIA
def p_elemento_potencia(p):
    """elemento_potencia : tiempo_nota
                         | modificador_nota
                         | elemento"""
    p[0] = p[1]

    # 1.- elemento_potencia.type = tiempo_nota.type
    # 2.- elemento_potencia.type = modificador_nota.type
    # 3.- elemento_potencia.type = elemento.type


def p_potencia_nota(p):
    """potencia_nota : elemento_potencia POTENCIA numero"""
    p[0] = Nodo('potencia_nota', [p[1], p[3]])
    p[0].tipo = 'nota'
    p[0].linea = p.lineno(0)

    # potencia_nota.type = elemento_potencia.type

# FIN POTENCIA


# MODIFICADOR
def p_modificador_nota(p):
    """modificador_nota : MODIFICADOR elemento"""
    p[0] = Nodo('modificador', [p[2]])
    p[0].linea = p.lineno(0)

    # modificador_nota.type = elemento.type

# FIN MODIFICADOR


# TOCAR
def p_tocar(p):
    """tocar : TOCAR PAREN_IZQ parametros_tocar PAREN_DER cuerpo_tocar"""
    p[0] = Nodo('tocar', [p[3], p[5]])
    p[0].linea = p.lineno(0)

    # tocar.type = void


def p_parametros_tocar(p):
    """parametros_tocar : tempo COMA instrumento sincronizacion"""
    p[0] = Nodo('parametros_tocar', [p[1], p[3], p[4]])
    p[0].linea = p.lineno(0)

    # parametros_tocar.type = void
    #       si tempo.type = entero o flotante
    #       && instrumento.type = instrumento
    #       && sincronizacion.type = entero o flotante o void


def p_tempo(p):
    """tempo : CONSTANTE_ENTERA
             | ID"""
    p[0] = Nodo('tempo')
    p[0].val = p[1]
    p[0].linea = p.lineno(0)

    # 1.- tempo.type = entero
    # 2.- tempo.type = id.type


def p_sinconizacion(p):
    """sincronizacion : COMA CONSTANTE_ENTERA
                      | COMA CONSTANTE_FLOTANTE
                      | COMA ID
                      | vacio"""
    p[0] = Nodo('sincronizacion')
    if (p[1] == ','):
        p[0].val = p[2]
    else:
        p[0].val = 'nada'
    p[0].linea = p.lineno(0)

    # 1.- sincronizacion.type = entero
    # 2.- sincronizacion.type = id.type
    # 3.- sincronizacion.type = void


def p_cuerpo_tocar(p):
    """cuerpo_tocar : LLAVE_IZQ lista_tocar LLAVE_DER"""
    p[0] = p[2]

    # cuerpo_tocar.type = lista_tocar.type


def p_lista_tocar(p):
    """lista_tocar : lista_tocar COMA elemento_tocar
                   | elemento_tocar"""
    if len(p) == 4:
        p[0] = Nodo('lista_tocar', [p[1], p[3]])
    else:
        p[0] = Nodo('lista_tocar', [p[1]])

    p[0].tipo = 'nota'
    p[0].linea = p.lineno(0)

    # 1.- lista_tocar.type = nota si lista_tocar1.type = nota && elemento_tocar.type = nota
    # 2.- lista_tocar.type = nota si elemento_tocar = nota


def p_elemento_tocar(p):
    """elemento_tocar : tiempo_nota
                      | potencia_nota
                      | modificador_nota
                      | elemento """

                      # """elemento : paren_notas
                      #             | llaves_notas
                      #             | nota
                      #             | ID"""
    p[0] = p[1]

    # 1.- elemento_tocar.type = tiempo_nota.type
    # 2.- elemento_tocar.type = potencia_nota.type
    # 3.- elemento_tocar.type = modificador_nota.type
    # 4.- elemento_tocar.type = elemento.type

# FINAL TOCAR


# ARREGLO revisado
def p_arreglo(p):
    """arreglo : CORCHETE_IZQ lista_arreglos CORCHETE_DER"""
    p[0] = Nodo('arreglo', [p[2]])
    p[0].linea = p.lineno(0)

    # arreglo.type


def p_indice_arreglo(p):
    """indice_arreglo : ID CORCHETE_IZQ CONSTANTE_ENTERA CORCHETE_DER"""

    p[0] = Nodo('indice_arreglo')
    p[0].val = p[1]
    p[0].interesante = p[3]
    p[0].linea = p.lineno(0)


def p_lista_arreglos(p):
    """lista_arreglos : lista_arreglos COMA elemento_arreglo
                      | elemento_arreglo"""
    if len(p) == 4:
        p[0] = Nodo('lista_arreglos', [p[1], p[3]])
    else:
        p[0] = Nodo('lista_arreglos', [p[1]])
    p[0].linea = p.lineno(0)


def p_elementos_arreglo(p):
    """elemento_arreglo : elemento_tocar"""

    if type(p[1]) == Nodo:
        p[0] = p[1]
    else:
        p[0] = Nodo('booleano')
        p[0].val = p[1]
        p[0].tipo = 'BOOLEANO'
    p[0].linea = p.lineno(0)
# FIN ARREGLO


# VARIABLES revisado
def p_lista_variables(p):
    """lista_variables : expresion
                       | arreglo"""
    p[0] = p[1]


def p_tipo_dato(p):
    """tipo_dato : ENTERO
                | FLOTANTE
                | BOOL
                | NOTA"""

    p[0] = Nodo('tipo_dato')
    p[0].tipo = p[1].upper()
    p[0].linea = p.lineno(0)


def p_tipo_var(p):
    """tipo_var : ID
                | ID CORCHETE_IZQ CONSTANTE_ENTERA CORCHETE_DER"""
    if len(p) == 2:
        p[0] = Nodo('tipo_var')
        p[0].val = [p[1]]
    else:
        p[0] = Nodo('tipo_var')
        p[0].val = [p[1], p[3]]
    p[0].linea = p.lineno(0)


def p_dec_variable(p):
    """dec_variable : dec_asignacion PUNTO_COMA"""
    p[0] = p[1]


def p_dec_asignacion(p):
    """dec_asignacion : tipo_dato asignacion"""
    p[0] = Nodo('dec_asignacion', [p[1], p[2]])
    p[0].linea = p.lineno(0)


def p_asignacion(p):
    """asignacion : tipo_var ASIGNACION lista_variables"""
    p[0] = Nodo('asignacion', [p[1], p[3]])
    p[0].linea = p.lineno(0)


def p_modificacion_var(p):
    """modificacion_var : asignacion PUNTO_COMA"""
    p[0] = p[1]
# FIN VARIABLES


# EXPRESIONES revisado
def p_expresion(p):
    """expresion : PAREN_IZQ expresion PAREN_DER
                 | ID
                 | numero
                 | BOOLEANO
                 | indice_arreglo"""
    if len(p) == 2:
        if type(p[1]) != Nodo:
            if p[1] == 'verdadero' or p[1] == 'falso':
                p[0] = Nodo('booleano')
                p[0].tipo = 'BOOLEANO'
            else:
                p[0] = Nodo('id')
            p[0].val = p[1]
        else:
            p[0] = p[1]
    else:
        p[0] = p[2]
    p[0].linea = p.lineno(0)


def p_expr_binaria(p):
    """expresion : expresion OPERADOR_LOGICO expresion
                | expresion SUMA expresion
                | expresion RESTA expresion
                | expresion MULTI expresion
                | expresion DIVISION expresion
                | expresion OR expresion
                | expresion AND expresion"""
    p[0] = Nodo(p[2].lower(), [p[1], p[3]])
    p[0].linea = p.lineno(0)


def p_expr_unaria(p):
    """expresion : '-' expresion %prec UMINUS"""
    p[0] = Nodo('menos', [p[1]])
    p[0].linea = p.lineno(0)



def p_expr_incremento(p):
    """expresion : expresion POST
                 | PRE expresion"""
    if p[1] == '++' or p[1] == '--':
        p[0] = Nodo('pre', [p[2]])
        p[0].interesante = p[1]
    else:
        p[0] = Nodo('post', [p[1]])
        p[0].interesante = p[2]
    p[0].linea = p.lineno(0)

# FIN EXPRESIONES


def p_vacio(p):
    """vacio :"""
    pass


def p_error(p):
    #print(p)
    #raise Exception("ERROR SINTACTICO")
    m = ManejadorErrores()
    m.error(2, p.lineno, p.value)
