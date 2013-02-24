%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
extern int yylineno;
#include<string.h>
#include<stdlib.h>

struct nodeinfo{

	char *name;
	char *type;
	};

struct Gsym{
	char *name;
	char *type;
	struct sym* next;
	};
struct lsym{
	char *name;
	char *type;
	struct sym* next;
	};

struct sym* Ghead=NULL;
struct sym* Lhead=NULL;
char *Glookup(char *);
char *Llookup(char *);
void Gaddtype(char *,char *);
void Laddtype(char *,char *);
struct nodeinfo * makenode(char *name, char *type);
%}

%union{
 struct nodeinfo *ptr;
};
%token <ptr> NUMBER IF DECL END WHILE ENDWHILE ENDIF RETURN READ WRITE ELSE BOOLEAN INTEGER ENDDECL RELOP LOGOP ID DO MAIN THEN BEG NOT
%token <ptr> AND OR
%type <ptr> main1 loc_decl local_decl expr arithexpr logexpr loc_vars body statement assignment iterative conditional io type
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
var: type  ident
       ;
type :INTEGER 			{$$=makenode(NULL,"int");}	
	|BOOLEAN		{$$=makenode(NULL,"bool");}
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
void Gaddtype(char *name,char *type)
{
if(Ghead==NULL)
{
Ghead =(struct Gsym*)malloc(sizeof(struct Gsym));
Ghead->name=name;
Ghead->type=type;
Ghead->next=NULL;

}

else
{
	struct Gsym *ptr=Ghead;
	while(ptr->next!=NULL)
	{
		ptr=ptr->next;
	}
ptr->next=(struct Gsym*)malloc(sizeof(struct Gsym));
ptr=ptr->next;	
ptr->name=name;
ptr->type=type;
ptr->next=NULL;
}
}

char *Glookup(char *name)
{
struct Gsym *ptr=(struct Gsym*)malloc(sizeof(struct Gsym));
ptr=Ghead;

while(ptr!=NULL)
{
 	if(strcmp(ptr->name,name)==0)
		return ptr->type;
	else 
	ptr=ptr->next;
}
}

struct nodeinfo * makenode(char *name, char *type)
{
struct nodeinfo *node = (struct nodeinfo *)malloc(sizeof(struct nodeinfo));

	node->name=name;
	node->type=type;

	
	return node;
}

char *Llookup(char *name)
{
struct Lsym *ptr=(struct Lsym*)malloc(sizeof(struct Lsym));
ptr=Lhead;

while(ptr!=NULL)
{
 	if(strcmp(ptr->name,name)==0)
		return ptr->type;
	else 
	ptr=ptr->next;
}
}

void Laddtype(char *name,char *type)
{
if(Lhead==NULL)
{
Lhead =(struct Lsym*)malloc(sizeof(struct Lsym));
Lhead->name=name;
Lhead->type=type;
Lhead->next=NULL;

}

else
{
	struct Lsym *ptr=Lhead;
	while(ptr->next!=NULL)
	{
		ptr=ptr->next;
	}
ptr->next=(struct Lsym*)malloc(sizeof(struct Lsym));
ptr=ptr->next;	
ptr->name=name;
ptr->type=type;
ptr->next=NULL;
}
}





