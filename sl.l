%{
 #include<stdlib.h>
 void yyerror(char *);
 #include "y.tab.h"
%}


digit  [0-9]

%%
[ \t\n] ;

{digit}   return DIGIT;
          

\+ { return *yytext;}

%%

int yywrap(void)
{
return 1;
}
 
