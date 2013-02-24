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

struct sym{
	char *name;
	char *type;
	struct sym* next;
	};

struct sym* head=NULL;
char *lookup(char *);
void addtype(char *,char *);
struct nodeinfo * makenode(char *name, char *type);
%}

%union{
struct nodeinfo *ptr;
};
%token <ptr> ID INTEGER BOOLEAN SEMICOLON DIGIT
%type <ptr> prog d e f type 


%%
prog: d f
	;
d :  d type ID SEMICOLON  {if(lookup($3->name))
					{printf("Redeclaration of the variable %s\n",$3->name);
					}
				else
				addtype($3->name,$2->type);}
	|  {$$=NULL;}
	;

type: INTEGER	{$$=makenode(NULL,"int");}
	|BOOLEAN	{$$=makenode(NULL,"bool");}
	;
f:f e
 |e
e: e '+' ID	{if($1->type==lookup($3->name))
		 $$->type=$1->type;
		else 
			yyerror("type mismatch in line number");}
  |ID		{$$->type=lookup($1->name);}
  |e '+' DIGIT	{if($1->type=="int")
		 $$->type=$1->type;
		else 
			yyerror("type mismatch in line number");}	
  ;
%%


void yyerror(char *s) {
fprintf(stderr, "%s %d\n", s,yylineno);
}
int main(void) {


yyparse();
return 0;
}
void addtype(char *name,char *type)
{
if(head==NULL)
{
head =(struct sym*)malloc(sizeof(struct nodeinfo));
head->name=name;
head->type=type;
head->next=NULL;

}

else
{
	struct sym *ptr=head;
	while(ptr->next!=NULL)
	{
		ptr=ptr->next;
	}
ptr->next=(struct sym*)malloc(sizeof(struct nodeinfo));
ptr=ptr->next;	
ptr->name=name;
ptr->type=type;
ptr->next=NULL;
}
}

char *lookup(char *name)
{
struct sym *ptr=(struct sym*)malloc(sizeof(struct sym));
ptr=head;

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









	

