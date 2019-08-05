%{
    #include"hoc.tab.h"
    #include <stdlib.h>
%}

%%

"PI" { return PI; }
"if"    { return IF; }
"else"  { return ELSE; }
"while" { return WHILE; }
"return" { return RETURN; }


">"     { return GT; }
"<"     { return LT; }
"!="    { return NE; }
"=="    { return EQ; }
">="    { return GE; }
"<="    { return LE; }

 /* FUNCIONES */
"sqrt"  { return FUNCTION; }
"log"   { return FUNCTION; }
"print" { return PRINT; }
"bltin" { return BLTIN; }
"read" { return READ; }

"func" {return FUNC;}
"proc" {return PROC;}
[a-zA-Z$][a-zA-Z$0-9]* {return VAR;}

\"[^"\n]*["\n] { return STRING;} 

[0-9]+ {yylval.NUM = (double) atoi(yytext); return NUM;}
'-' {return NEG;}
[ \t]+ 
. {return *yytext;}
\n {return '\n';}

%%
