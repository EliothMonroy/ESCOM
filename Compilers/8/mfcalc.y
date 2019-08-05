%{
 #include <stdio.h>  /* For printf, etc. */
 #include <math.h>   /* For pow, used in the grammar.  */
 int yylex (void);
 void yyerror (char const *);
%}

%define api.value.type union /* Generate YYSTYPE from these types:  */
%token <double>  NUM         /* Simple double precision number.  */
%token <double> VAR FNCT    /* Symbol table pointer: variable and function.  */
%type  <double>  exp

%precedence '='
%left '-' '+'
%left '*' '/'
%precedence NEG /* negation--unary minus */
%right '^'      /* exponentiation */
%% /* The grammar follows.  */
input:
   %empty
 | input line
 ;

line:
   '\n'
 | exp '\n'   { printf ("%.10g\n", $1); }
 | error '\n' { yyerrok;                }
 ;
exp:
   NUM                { $$ = $1;                          }
 | VAR                { $$ = $1;             }
 | VAR '=' exp        { $$ = $3; printf("Estoy asignando\n");   }
 | FNCT '(' exp ')'   { $$ = $3; printf("Vi una funcion\n");}
 | exp '+' exp        { printf("MOV %f A\n",$1);
                        printf("MOV %f B\n",$3);
                        printf("add A B\n");
                        $$=$1+$3;
                      }
 | exp '-' exp        { $$ = $1 - $3;  printf("Estoy restando\n");                   }
 | exp '*' exp        { $$ = $1 * $3;                    }
 | exp '/' exp        { $$ = $1 / $3;                    }
 | '-' exp  %prec NEG { $$ = -$2;                        }
 | exp '^' exp        { $$ = pow ($1, $3);               }
 | '(' exp ')'        { $$ = $2;                         }
 ;
/* End of grammar.  */
%%
/* Called by yyparse on error.  */
void yyerror (char const *s)
{
 fprintf (stderr, "%s\n", s);
}
int main (int argc, char const* argv[])
{

 return yyparse ();
}
