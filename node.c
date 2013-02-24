#include<stdio.h>
#include<stdlib.h>
#include "node.h"
Node makenode( Node leftoper, char oper, Node rightoper)
{
Node newnode;
newnode =malloc(sizeof(*newnode));

newnode->type=OPNODE;
newnode->op=oper;
newnode->left=leftoper;
newnode->right=rightoper;
return newnode;
}


Node makeconstnode(int value)
{
Node newnode;
newnode = malloc(sizeof(*newnode));
newnode->type=CONSTNODE;
newnode->val=value;

return newnode;
}

void printtree(Node tree, int level)
{
 int i;
  

  for(i=0;i<level;i++)
  printf(" ");
 

  if (tree == NULL) {
	    printf("(null)\n");
	    return;
	}

 switch(tree->type)
{
  case OPNODE : printf("%c\n",tree->op);
                printtree(tree->left,level+1);
                printttree(tree->right,level+1);
               break;
 case CONSTNODE: printf("%d\n", tree->val);
                 break;
}
}






















