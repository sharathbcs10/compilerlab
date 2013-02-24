%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
%}
relop   <|>|<=|>=|!=|==
keywords  decl|enddecl|integer|boolean|begin|if|else|endif|return|end|while|read|write|endwhile|
%%
[0-9]+  {
         yylval = atoi(yytext);
         return INTEGER;
         }
AND|OR|NOT     {return *yytext;}
{keywords}      {return *yytext;}

{letter}({letter}|{digit})*   {yylval=*yytext;
                                 return ID;
                               }
{relop}  {return *yytext;}
[-+()=/*] { return *yytext; }

[;,]       {return *yytext;}
[\[\]]  {return *yytext;}
[ \t\n] ;  /* skip whitespace */
.     yyerror("invalid character");
%%
int yywrap(void) {
return 1;
}

