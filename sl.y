%{
#include<stdio.h>
#include<stdlib.h>
int yylex(void);
void yyerror(const char *);
#include <sys/types.h>

 struct Node
{ 
  
  struct Node *left,*right;
  
  char *op;
};
struct Node *root =NULL;
struct Node *makenode(struct Node *, char *, struct Node *);

void printtree(struct Node *tree);

%}


%union {
 struct Node *ptr;
 };
%token DIGIT
%type <ptr> program expr digit

%%

program:  expr { root=$1;}
        ;
expr:digit {$$=$1;}
     |digit'+' expr {$$=makenode($1,"+",$3);}
     ;

digit: DIGIT { $$=makenode(NULL,"DIGIT",NULL);}
        ;

%%
void yyerror(const char *s) {
fprintf(stderr, "%s\n", s);
}
int main(void)
{
if (yyparse() == 0) {
		printf("parsing succeeded\n");
		printtree(root);
	} 
else
		printf("parsing failed\n");
return 0;
}
struct Node *makenode(struct Node * left, char *val, struct Node* right)
{

struct Node *temp;

temp=malloc(sizeof(struct Node));

temp->left=left;
temp->right=right;
temp->op=val;

return temp;
}

void printtree(struct Node *tree)
{

if (tree == NULL) {
	    printf("(null)\n");
	    return;
	}

else
{
   printf("(");
   printf("%s\t", tree->op);
   
   printtree(tree->left);
   
   printtree(tree->right);
   printf(")");
 }
}











