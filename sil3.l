%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
int yylineno;
%}
letter [A-Za-z]
digit  [0-9]

relop   <|>|<=|>=|!=|==



%%
decl     {return DECL;}
enddecl  {return ENDDECL;}

integer   return INTEGER;
boolean return BOOLEAN;
            
do       { return DO;}            
then      return THEN;
if       {return IF;}
else     {return ELSE;}
endif    {return ENDIF;}
return    {return RETURN;}
end   {return END;}
while  {return WHILE;}
read   {return READ;}
write  {return WRITE;}
endwhile {return ENDWHILE;}
begin {return BEG;}
main return MAIN;
AND  return AND;
OR return OR;

[0-9]+  {return NUMBER;
         }
NOT  {return NOT;}       



{letter}({letter}|{digit})*   {char *temp=(char *)malloc(sizeof(char));
		
				strcpy(temp,yytext);
				yylval.ptr=makenode(temp,NULL);
				return ID;}
                               

                               
{relop}  {return RELOP;}
              
[-+/*] { return *yytext; 
               }
              
=     {return *yytext;}
[()]   {return *yytext;}
[{}]   {return *yytext;}

[;,]       {return *yytext;}
[\[\]]  {return *yytext;}
[ \t\n]+ ;  /* skip whitespace */
.     yyerror("invalid character");
%%
int yywrap(void) {
return 1;
}

