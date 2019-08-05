%{
       #include <stdio.h>  /* For printf, etc. */
    #include <stdlib.h>
    #include <math.h>   /* For pow, used in the grammar.  */
    int yylex (void);
    void yyerror (char const *);
    extern FILE *yyin;
%}

%define api.value.type union /* Generate YYSTYPE from these types:  */
%token <double>  NUM PRINT STRING PI      /* Simple double precision number.  */
%token <double> READ BLTIN PROCEDURE PROC VAR FUNC FUNCTION ELSE WHILE IF RETURN  /* Symbol table pointer: variable and function.  */
%type <double> expr asig

%right '='
%left OR
%left AND
%left GT GE LT LE EQ NE
%left '-' '+'
%left '*' '/'
%left NEG NOT /* negation--unary minus */
%right '^'      /* exponentiation */

%% /* The grammar follows.  */
lista: %empty
     | lista '\n'
     | lista defunc '\n'        { printf("lista-defunc\n"); }
     | lista asig '\n'
     | lista stmt '\n'          { printf("lista-stmt\n"); }
     | lista expr '\n'          { printf("lista-expr %f\n", $2); }
     | lista error '\n'         { yyerrok; }
     ;

stmt: expr                                  { printf("stmt-expr\n"); }
    | RETURN
    | RETURN expr
    | PROCEDURE '(' arglist ')'
    | PRINT prlist                          { printf("print\n"); }
    | while condicion stmt end              { printf("Vi un while\n"); }
    | if condicion stmt end                 { printf("Vi un if\n"); }
    | if condicion stmt end ELSE stmt end   { printf("Vi un else\n"); }
    | '{' stmtlist '}'
    ;

stmtlist: %empty
        | stmtlist '\n'
        | stmtlist stmt
        ;

expr: NUM                                   { printf("Vi un numero\n"); }
    | VAR                                   { printf("Vi una variable\n"); }
    | PI
    | asig
    | READ '(' VAR ')'
    | BLTIN '(' expr ')'
    | '(' expr ')'                          { printf("parentesis expr\n"); }
    | expr '+' expr                         { 
                                                printf("MOV %f A\n", $1);
                                                printf("MOV %f A\n", $3);
                                                printf("ADD A B\n");
                                                $$ = $1 + $3;
                                            }
    | expr '-' expr                         { printf("Vi un menos\n"); }
    | expr '*' expr                         { printf("Vi una multiplicacion\n"); }
    | expr '/' expr                         { printf("Vi una division\n"); }
    | expr '^' expr                         { printf("Vi una potencia\n"); }
    | '-' expr  %prec NEG                   { printf("Vi un menos\n"); }
    | expr GT expr                          { printf("Vi un GT\n"); }
    | expr GE expr                          { printf("Vi un GE\n"); }
    | expr LT expr                          { printf("Vi un LT\n"); }
    | expr LE expr                          { printf("Vi un LE\n"); }
    | expr EQ expr                          { printf("Vi un EQ\n"); }
    | expr NE expr                          { printf("Vi un NE\n"); }
    | expr AND expr                         { printf("Vi una AND\n"); }
    | expr OR expr                          { printf("Vi una OR\n"); }
    | NOT expr                              { printf("Vi una NOT\n"); }
    | VAR '(' arglist ')'                   { printf("Vi una funcion\n"); }
    | FUNCTION '(' arglist ')'              { printf("Vi una funcion\n"); }
    ;

prlist: expr
      | STRING
      | prlist ',' expr
      | prlist ',' STRING
      ;

arglist: %empty
       | expr
       | arglist ',' expr
       ;


asig: VAR '=' expr      { printf("Vi una asignacion\n"); }
    ;

condicion: '(' expr ')' { printf("Vi una condicion\n"); }
         ;

while: WHILE
     ;

if: IF
  ;

end: %empty
   ;

defunc: FUNC procnombre     { printf("Vi un FUNC\n"); }
        '(' ')' stmt        { printf("stmt\n"); }
      | PROC procnombre     { printf("Vi un FUNC\n"); }
        '(' ')' stmt        { printf("stmt\n"); }
      ;

procnombre: VAR             { printf("VAR\n"); }
          ;

/* End of grammar.  */
%%

/* Called by yyparse on error.  */
     void
     yyerror (char const *s)
     {
       fprintf (stderr, "%s\n", s);
     }

int main (int argc, char const* argv[]) {
    if (argc < 2) {
        printf("Faltan parametros ./analizador <archivo>");
    }
    FILE *archivo = fopen(argv[1], "r");
    if (!archivo) {
        printf("No se inserto el archivo\n");
        return -1;
    }
    yyin = archivo;
    do {
        yyparse();
    } while(!feof(yyin));
    return 0;
}