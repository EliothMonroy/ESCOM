tokens = [
    'URL',
    'COMENTARIO',
    'CONSTANTE_FLOTANTE',
    'RESTA',
    'SUMA',
    'GOOD',
    'IDENTIFICADOR',
]

def t_CONSTANTE_FLOTANTE(t):
    r'(-|\u002B)?\d*\.\d+'
    return t

def t_URL(t):
    r'^(http)://.*/(inicio)$'
    return t

def t_COMENTARIO(t):
    r'//.*|/\*(.|\n)*\*/'
    return t

def t_RESTA(t):
    r'-'
    return t

def t_GOOD(t):
    r'(go{1,2}d)'
    return t

def t_SUMA(t):
    r'\+'
    return t

def t_IDENTIFICADOR(t):
    r'[a-zA-Z_]\w*'
    return t

t_ignore = ' \t'

def t_error(t):
    print ("Caracter ilegal '%s'" % t.value[0])
    t.lexer.skip(1)
