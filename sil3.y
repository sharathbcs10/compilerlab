%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);

typedef enum {OPNODE, CONSTNODE,VARTYPE} NodeType;
struct Node{
	NodeType type;
	union {
		struct opnode {
			char *val;
			struct Node *ptr1;
			struct Node *ptr2;
			struct Node *ptr3;
		} op;
		int val;
		char *variable;
	};
};
struct Node * makenode(char *str, struct Node *next1,struct Node *next2, struct Node *next3);
void printtree(struct Node * ptr);
struct Node *makevarnode(char *variable);
struct Node *makeconstnode(int value);
%}

%union
{
 int ival;
char *cval;
struct Node *ptr;
};


%token <ival>NUMBER
%token <cval> IF DECL END WHILE ENDWHILE ENDIF RETURN READ WRITE ELSE BOOLEAN INTEGER ENDDECL RELOP LOGOP ID DO MAIN THEN BEG NOT 
%token <cval>AND OR
%type <ptr> main1 local_decl loc_decl loc_vars body statements statement assignment conditional iterative io expr arithexpr 
%type <ptr> logexpr ident

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
ident: ID						{$$=makevarnode($1);}
      ;
vars: ',' ident vars    
     |
     ;                     

main1: INTEGER MAIN '(' ')' '{' loc_decl body '}'    		{$$=makenode("MAIN",$6,$7,NULL); printtree($$);}
       ;
loc_decl: DECL local_decl ENDDECL                    		{$$=makenode("DECL",$2,NULL,NULL);}
         |                             				{$$=NULL;}
         ;
local_decl : INTEGER ID loc_vars ';' local_decl         	{$$=makenode("INT",$2,$3,$5);}
            |BOOLEAN ID loc_vars ';' local_decl			{$$=makenode("INT",$2,$3,$5);}
             | 							{$$=NULL;}
            ;                  
loc_vars: ',' ID loc_vars					{$$=makenode(NULL,$2,$3,NULL);}
         | 							{$$=NULL;}
         ; 
body: BEG statements RETURN NUMBER ';' END			{$$=makenode("STATMENTS",$2,NULL,NULL);}
     ;
statements: statement ';' statements            		{$$=makenode(NULL,$1,$3,NULL);}
          |							{$$=NULL;}
          ;
statement: assignment	
          |conditional
          |iterative
          |io
          |							{$$=NULL;}
          ;
          
assignment: ident '=' expr					{$$=makenode("ASSIGN",$1,$3,NULL);}
          ;
conditional: IF logexpr THEN  statements ENDIF  		{$$=makenode("IF",$2,$4,NULL);}
             |IF logexpr THEN statements ELSE statements ENDIF	{$$=makenode("IFelse",$2,$4,$6);}
             ;
iterative :WHILE logexpr DO statements ENDWHILE			{$$=makenode("WHILE",$2,$4,NULL);}
            ;
io: READ '(' ident ')' 						{$$=makenode("READ",$3,NULL,NULL);}
    | WRITE '(' arithexpr   ')'					{$$=makenode("WRITE",$3,NULL,NULL);}
    ;
expr :arithexpr
      |logexpr   
      ;
arithexpr: arithexpr '+' arithexpr				{$$=makenode("+", $1, $3, NULL);}
          |arithexpr '-' arithexpr				{$$=makenode("-", $1, $3, NULL);}
          |arithexpr '*' arithexpr				{$$=makenode("*", $1, $3, NULL);}
          |arithexpr '/' arithexpr				{$$=makenode("/", $1, $3, NULL);}
          |ID							{$$=makevarnode($1);}
          |NUMBER						{$$=makeconstnode($1);}
          |ID '[' arithexpr ']'					{$$=makenode("ARITH [ ]", $1, $3, NULL);}
           ;
logexpr: '(' logexpr AND logexpr')'				{$$=makenode("LOG AND",$2,$4,NULL);}
         | '('logexpr OR logexpr')'				{$$=makenode("LOG OR",$2,$4,NULL);}
        | '('NOT logexpr')'					{$$=makenode("LOG NOT",$3,NULL,NULL);}
        | '('arithexpr RELOP arithexpr')'			{$$=makenode("RELATIONAL",$2,$4,NULL);}
         ;                     
%%

void yyerror(char *s) {
fprintf(stderr, "%s\n", s);
}
int main(void) {
yyparse();
return 0;
}

struct Node * makenode(char *str, struct Node *next1,struct Node *next2, struct Node *next3)
{
	struct Node *node = malloc(sizeof(struct Node));

	node->type=OPNODE;
	node->op.val=str;
	node->op.ptr1=next1;
	node->op.ptr2=next2;
	node->op.ptr3=next3;
	
	return node;
}
struct Node *makevarnode(char *variable)
{
struct Node *node = malloc(sizeof(struct Node));
node->type=VARTYPE;
node->variable=variable;
return node;
}
struct Node *makeconstnode(int value)
{
struct Node *node = malloc(sizeof(struct Node));
node->type=CONSTNODE;
node->val=value;

return node;
}

void printtree(struct Node * ptr)
{
	if(ptr==NULL)
		return;
	
	
	if(ptr->op.val!=NULL)
 	{printf(" ( ");
 	   switch(ptr->type)
	{
     	case OPNODE: 
		printf("%s", ptr->op.val);
		printtree(ptr->op.ptr1);
		printtree(ptr->op.ptr2);
		printtree(ptr->op.ptr3);
		printf(" ) ");
		break;
	case CONSTNODE:
		printf("%d",ptr->val);
		break;
	case VARTYPE:
		printf("%s",ptr->variable);
		break;
	}
	}
	else{
	printtree(ptr->op.ptr1);
	printtree(ptr->op.ptr2);
	printtree(ptr->op.ptr3);
	
}}



