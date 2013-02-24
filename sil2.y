%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);

typedef struct Node{
 Node *ptr1,*ptr,*ptr3;
 char *value;
  }Node;
%}

%union{
 Node *ptr;
};
%token <ptr> NUMBER IF DECL END WHILE ENDWHILE ENDIF RETURN READ WRITE ELSE BOOLEAN INTEGER ENDDECL RELOP LOGOP ID DO MAIN THEN BEG NOT
%token <ptr> AND OR
%type <ptr> main1 loc_decl local_decl expr arithexpr logexpr loc_vars body statement assignment iterative conditional io
%left '+' '-'
%left '*' '/'
%left OR
%left AND
%%

program: global main1
        ;
global : DECL declarations  ENDDECL
        |
        ;
declarations:sdeclare declarations
            |
            ;        
sdeclare: var vars ';'
         ;
var: INTEGER ident
     |BOOLEAN  ident
      ;
ident: ID
      | ID '[' NUMBER ']'
      ;
vars: ',' ident vars
     |
     ;                     

main1: INTEGER MAIN '(' ')' '{' loc_decl body '}'
       ;
loc_decl: DECL local_decl ENDDECL
         |
         ;
local_decl : INTEGER ID loc_vars ';' local_decl
            |BOOLEAN ID loc_vars ';' local_decl
             |
            ;                  
loc_vars: ',' ID loc_vars
         |
         ;
body: BEG statements RETURN NUMBER ';' END
     ;
statements: statement ';' statements
          |
          ;
statement: assignment
          |conditional
          |iterative
          |io
          |
          ;
          
assignment: ident '=' expr
          ;
conditional: IF logexpr THEN  statements ENDIF  
             |IF logexpr THEN statements ELSE statements ENDIF
             ;
iterative :WHILE logexpr DO statements ENDWHILE
            ;
io: READ '(' ident ')' 
    | WRITE '(' arithexpr   ')'
    ;
expr :arithexpr
      |logexpr   
      ;
arithexpr: arithexpr '+' arithexpr
          |arithexpr '-' arithexpr
          |arithexpr '*' arithexpr
          |arithexpr '/' arithexpr
          |ID
          |NUMBER
          |ID '[' arithexpr ']'
           ;
logexpr: '(' logexpr AND logexpr')'
         | '('logexpr OR logexpr')'
        | '('NOT logexpr')'
        | '('arithexpr RELOP arithexpr')'
         ;                     
%%

void yyerror(char *s) {
fprintf(stderr, "%s\n", s);
}
int main(void) {
yyparse();
return 0;
}




