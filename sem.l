%{
#include <stdlib.h>
void yyerror(char *);
#include "y.tab.h"
int yylineno;

#include<stdio.h>
%}

%%
[;] 	{return SEMICOLON;}
int {return INTEGER;}
bool {return BOOLEAN;}
[0-9]   {return DIGIT;}
[a-zA-Z]+ {char *temp=(char *)malloc(sizeof(char));
		
		strcpy(temp,yytext);
		yylval.ptr=makenode(temp,NULL);
		return ID;}
[ \t] ;
[\n]  yylineno++;
[+]	return *yytext;

%%
int yywrap(void) {
return 1;
}
