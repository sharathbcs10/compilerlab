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
digit  [0-9]
id    {letter}({letter}|{digit})*
number  {digit}+

%%
{reference}  cout<<"reference operator"<<yytext;




%%
