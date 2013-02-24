

typedef enum {OPNODE, CONSTNODE} NodeType;
typedef struct Nod1 *Node;
struct Nod1
{ 
  NodeType type;
  Node left,right;
  int val;
  char op;
};


Node makenode( Node leftoper, char oper, Node rightoper);
Node makeconstnode(int value);
void printtree(Node tree, int level);
