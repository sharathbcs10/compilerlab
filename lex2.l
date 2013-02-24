%{ /* analyser for sil*/
%}

/* definitions*/

delim  [ \t\n]
ws    {delim}+
reference  &
equality ==
assignment =  
multi  "/*"[^"*/"]*"*/"
comments "//"[^"\n"]*
logical AND|OR|NOT
parenthesis [\(\)\{\}\[\]]
punctuations [,;'\"]
keywords  decl|enddecl|integer|boolean|begin|if|else|endif|return|end|while|read|write|endwhile|typedef
arithop [+\-/*]
relop   <|>|<=|>=|<>
letter [A-Za-z] 
digit [0-9]
id    {letter}({letter}|{digit})*
number  {digit}+
undefined   .     
%%

{reference}  printf("reference operator %s\n",yytext);
{comments}    printf("comments %s\n",yytext);
{multi}      printf("multiline comment %s\n",yytext);
{logical}    printf("logical operator %s\n",yytext);
{keywords}   {printf("keyword %s\n",yytext);}
{id}    {printf("identifier %s \n",yytext);}
{arithop} {printf("arithmetic operator %s\n",yytext);}
{relop}    {printf("relational operator %s\n",yytext);}
{number}   {printf("number %s\n", yytext);}
{parenthesis}  printf("bracket %s\n",yytext);
{assignment}  printf("assignemnt %s\n",yytext);
{punctuations}   printf("punctuations %s\n",yytext);
{equality}  printf("equality %s\n",yytext);
{undefined}  printf("undefined symbol %s\n",yytext);
%%
