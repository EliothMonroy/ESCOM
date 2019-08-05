%{
	#include"mfcalc.tab.h"
	#include<stdlib.h>
%}
%%
"log"  {return FNCT;}
[a-z]+ {return VAR;}
[0-9]+ {yylval.NUM=(double)atoi(yytext); return NUM;}
'-' {return NEG;}
[ \t]+
. {return *yytext;}
\n {return '\n';}
%%
