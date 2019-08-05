# http://www.dabeaz.com/ply/ply.html
from manejador_errores import ManejadorErrores

tokens = [
    'COMENTARIO',
    'dje',
    'BOOLEANO',
    'ID',
    'OR',
    'AND',
    'CONSTANTE_FLOTANTE',
    'CONSTANTE_ENTERA',
    'POST',
    'PRE',
    'MULTI',
    'DIVISION',
    'RESTA',
    'SUMA',
    'OPERADOR_LOGICO',
    'ASIGNACION',
    'COMA',
    'PAREN_IZQ',
    'PAREN_DER',
    'LLAVE_IZQ',
    'LLAVE_DER',
    'CORCHETE_IZQ',
    'CORCHETE_DER',
    'MODIFICADOR',
    'POTENCIA',
    'PUNTO_COMA',
]

reservado = {
   'si': 'SI',
   'sino': 'SINO',
   'para': 'PARA',
   'mientras': 'MIENTRAS',
   'tocar': 'TOCAR',
   'funcion': 'FUNCION',
   'do': 'DO',
   're': 'RE',
   'mi': 'MI',
   'fa': 'FA',
   'sol': 'SOL',
   'la': 'LA',
   'si': 'SI',
   'piano': 'PIANO',
   'guitarra': 'GUITARRA',
   'flauta': 'FLAUTA',
   'entero': 'ENTERO',
   'flotante': 'FLOTANTE',
   'booleano': 'BOOL',
   'nota': 'NOTA',
   'main': 'MAIN',
}

states = (
    ('dje', 'exclusive'),
)

tokens += list(reservado.values())

# Parentesis izq
t_PAREN_IZQ = r'\('
# Parentesis der
t_PAREN_DER = r'\)'
# Parentesis izq
t_LLAVE_IZQ = r'\{'
# Parentesis der
t_LLAVE_DER = r'\}'
# Parentesis izq
t_CORCHETE_IZQ = r'\['
# Parentesis der
t_CORCHETE_DER = r'\]'
# Coma
t_COMA = r','
# Modificador
t_MODIFICADOR = r'\\'
t_POTENCIA = r'\^'
t_PUNTO_COMA = r';'
t_AND = r'&&'


# Las siguientes son las expresiones regulares de cada clase lexica,
# con el comportamiento por default de lex
def t_COMENTARIO(t):
    r'(/\*(.|\n)*\*/)|(//.*)'
    t.lineno += t.value.count('\n')
    t.lexer.lexliterals = [t.type]


def t_BOOLEANO(t):
    r'verdadero|falso'
    t.lexer.lexliterals = [t.type]
    return t


def t_ID(t):
    r'[a-zA-Z_]\w*'
    t.lexer.lexliterals = [t.type]
    t.type = reservado.get(t.value, 'ID')
    return t


def t_CONSTANTE_FLOTANTE(t):
    r'[\d]*[.][\d]+'
    t.lexer.lexliterals = [t.type]
    t.value = float(t.value)
    return t


def t_CONSTANTE_ENTERA(t):
    r'\d+'
    t.lexer.lexliterals = [t.type]
    t.value = int(t.value)
    return t

def t_OR(t):
    r'\|\|'
    t.lexer.lexliterals = [t.type]
    return t

def t_MULTI(t):
    r'\*'
    t.lexer.lexliterals = [t.type]
    return t

def t_DIVISION(t):
    r'/'
    t.lexer.lexliterals = [t.type]
    return t


def t_OPERADOR_LOGICO(t):
    r'==|<=|>=|!=|[<>]'
    t.lexer.lexliterals = [t.type]
    return t


def t_ASIGNACION(t):
    r'='
    t.lexer.lexliterals = [t.type]
    return t


def t_newline(t):
    r'\n+'
    t.lexer.lexliterals = [t.type]
    t.lexer.lineno += len(t.value)

t_ignore = ' \t'


# Aqui comienzan las reglas que no usan las operaciones por default de lex
def t_dje(t):
    r'[-|+]'

    aux = t.lexer.lexdata[t.lexer.lexpos-1:t.lexer.lexpos+1]
    if aux == '--' or aux == '++':
        if len(t.lexer.lexliterals) > 0 and t.lexer.lexliterals[0] == 'ID':
            t.type = 'POST'
        else:
            t.type = 'PRE'
        t.value = aux
        t.lexer.lexpos = t.lexer.lexpos+1
        t.lexer.begin('INITIAL')
        return t

    if type(t.lexer.lexliterals) is str:
        t.lexer.lexliterals = ['NADA']

    t.lexer.code_start = t.lexer.lexpos
    t.lexer.lexliterals.append(t.value)
    t.lexer.begin('dje')


def t_dje_OPERADOR_ARITMETICO(t):
    r'[+|-]|\('
    t.value = t.lexer.lexliterals[1]
    if t.value == '-':
        t.type = 'RESTA'
    else:
        t.type = 'SUMA'
    t.lexer.lexpos = t.lexer.code_start
    t.lexer.lexliterals = [t.type]
    t.lexer.begin('INITIAL')
    return t

id = - 4
def t_dje_CONSTANTE_FLOTANTE(t):
    r'[\d]*[.][\d]+'

    aux = t.lexer.lexliterals[0]
    if aux == 'CONSTANTE_ENTERA' or aux == 'CONSTANTE_FLOTANTE' or aux == 'ID' or aux == ')':
        t.value = t.lexer.lexliterals[1]
        if t.value == '-':
            t.type = 'RESTA'
        else:
            t.type = 'SUMA'
        t.lexer.begin('INITIAL')
        t.lexer.lexpos = t.lexer.code_start
        return t

    t.type = 'CONSTANTE_FLOTANTE'
    t.value = float(t.lexer.lexliterals[1] + t.value)
    t.lexer.begin('INITIAL')
    return t


def t_dje_CONSTANTE_ENTERA(t):
    r'\d+'

    aux = t.lexer.lexliterals[0]
    if aux == 'CONSTANTE_ENTERA' or aux == 'CONSTANTE_FLOTANTE' or aux == 'ID' or aux == ')':
        t.value = t.lexer.lexliterals[1]
        if t.value == '-':
            t.type = 'RESTA'
        else:
            t.type = 'SUMA'
        t.lexer.begin('INITIAL')
        t.lexer.lexpos = t.lexer.code_start
        return t

    t.type = 'CONSTANTE_ENTERA'
    t.value = int(t.lexer.lexliterals[1] + t.value)
    t.lexer.begin('INITIAL')
    return t


def t_dje_ID(t):
    r'[a-zA-Z_]\w*'
    t.value = t.lexer.lexliterals[1]
    if t.value == '-':
        t.type = 'RESTA'
    else:
        t.type = 'SUMA'
    t.lexer.begin('INITIAL')
    t.lexer.lexpos = t.lexer.code_start
    return t

t_dje_ignore = " \t\n"


'''
    Estos metodos son invocados cuando el analizador lexico encuentra un error,
    no obstante el manejador de errores aun no esta programado,
    por lo que solo se imprime un caracter ilegal, mas adelante
    estos metodos mandaran a llamar al manejador de errores
'''


def t_error(t):
    #print("Caracter ilegal '%s'" % t.value[0])
    #t.lexer.skip(1)
    m = ManejadorErrores()
    m.error(1, t.lineno, t.value)


def t_dje_error(t):
    #print("Caracter ilegal '%s'" % t.value[0])
    #t.lexer.skip(1)
    m = ManejadorErrores()
    m.error(1, t.lineno, t.value)
