

typedef enum {OPNODE, CONSTNODE} NodeType;

struct Node	
{ 
  NodeType type;
  struct Node *left,*right;
  int val;
  char op;
};


struct Node *makenode( struct Node *leftoper, char oper, struct Node *rightoper);
struct Node *makeconstnode(int value);
void printtree(struct Node *tree, int level);
