%{
	#include<stdio.h>
	int yylex(void);
	void yyerror(char *);
	extern int yylineno;
	
	struct Node{
	
	char *str;
	struct Node *next1;
	struct Node *next2;
	struct Node *next3;
	};
	
	struct Node * makenode(char *str, struct Node *next1,struct Node *next2, struct Node *next3);
	void printtree(struct Node * ptr);
%}

%token <ptr> IF ELSE ENDIF DECL ENDDECL BEG END WHILE DO ENDWHILE RETURN READ WRITE TYPE MAIN THEN NOT BOOLEAN AND OR INTEGER ID MATHOP RELOP

%token <ptr> NUMBER



%left OR
%left AND
%left '+' '-'
%left '*' '/'

%type <ptr> main local_decl local_declarations loc_vars body statements statement assignment conditional iterative io expr arith_expr log_expr var

%union {
	struct Node *ptr;
};

%%

program : global_decl main
	;

global_decl : DECL declarations ENDDECL		
	    | 
	    ;

declarations : INTEGER var vars ';' declarations
	     | BOOLEAN var vars ';' declarations
	     |
	     ;

var : ID				
    | ID'['NUMBER']'			{$$=makenode("ARR", $1, $3, NULL);}
    ;

vars : ',' var vars
     |
     ;


main : INTEGER MAIN '('')' '{' local_decl body '}' 		{$$=makenode("MAIN", $6, $7, NULL); printtree($$);}
     ;


local_decl : DECL local_declarations ENDDECL 			{$$=makenode("DECLS",$2, NULL, NULL);}
	   |							{$$=NULL;}
	   ;

local_declarations : INTEGER ID loc_vars ';' local_declarations	{$$=makenode("INTEGER", $2, $3, $5);}
		   | BOOLEAN ID loc_vars ';' local_declarations	{$$=makenode("BOOLEAN", $2, $3, $5);}
		   |						{$$=NULL;}
		   ;

loc_vars : ',' ID loc_vars					{$$=makenode("ARGS", $2, $3, NULL);}
	   | 							{$$=NULL;}
	   ;

body : BEG statements RETURN NUMBER ';' END 			{$$=$2;}
     ;

statements : statement ';' statements				{$$=makenode("STMT", $1, $3, NULL);}
	   |							{$$=NULL;}
	   ;

statement : assignment 						
	  | conditional 
	  | iterative
	  | io 
	  |							{$$=NULL;}
	  ;

assignment : var '=' expr					{$$=makenode("ASSN", $1, $3, NULL);}
	   ;

conditional : IF log_expr THEN statements ENDIF			{$$=makenode("IF", $2, $4, NULL);}
	    | IF log_expr THEN statements ELSE statements ENDIF	{$$=makenode("IFELSE", $2, $4, $6);}
	    ;

iterative : WHILE log_expr DO statements ENDWHILE		{$$=makenode("ITER", $2, $4, NULL);}
	  ;

io : READ '(' var ')'						{$$=makenode("READ", $3, NULL, NULL);}
   | WRITE '(' arith_expr ')'					{$$=makenode("WRITE", $3, NULL, NULL);}
   ;


expr : arith_expr
     | log_expr
     ;

arith_expr : arith_expr MATHOP arith_expr			{$$=makenode("ARITH", $1, $3, NULL);}
	   | ID							
	   | NUMBER
	   | ID'['arith_expr']'					{$$=makenode("ARITH", $1, $3, NULL);}
	   | '(' arith_expr ')'					{$$=$2;}
	   ;


log_expr : log_expr AND log_expr				{$$=makenode("AND", $1, $3, NULL);}
	 | log_expr OR log_expr					{$$=makenode("OR", $1, $3, NULL);}
	 | NOT log_expr						{$$=makenode("NOT", $2, NULL, NULL);}
	 | arith_expr RELOP arith_expr				{$$=makenode("REL", $1, $3, NULL);}
	 | '(' log_expr ')'					{$$=$2;}
	 ;



%%

int main()
{
	yyparse();
	return 0;
}
void yyerror(char *s)
{
	fprintf(stderr, "%s in line no : %d\n", s, yylineno);
}
int yywrap(void)
{
	
}

struct Node * makenode(char *str, struct Node *next1,struct Node *next2, struct Node *next3)
{
	struct Node *node = malloc(sizeof(struct Node));
	node->str=str;
	node->next1=next1;
	node->next2=next2;
	node->next3=next3;
	
	return node;
}

void printtree(struct Node * ptr)
{
	if(ptr==NULL)
		return;
	
	printf(" ( ");
	if(ptr->str!=NULL)
		printf("%s", ptr->str);
	printtree(ptr->next1);
	printtree(ptr->next2);
	printf(" ) ");
}
	

