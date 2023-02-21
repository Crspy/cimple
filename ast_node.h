#ifndef AST_NODE_HEADER_GUARD
#define AST_NODE_HEADER_GUARD

#include "tokenizer.h"

typedef struct Node Node;


// AST node
struct Node {
  enum NodeTag {
    NODE_TAG_UNARY,
    NODE_TAG_BINARY,
    NODE_TAG_IF,
    NODE_TAG_FOR,
    NODE_TAG_BLOCK,
    NODE_TAG_FUNCALL,
    NODE_TAG_VAR,
    NODE_TAG_NUM
  } tag;
  Node *next;         // Next node
  struct Type *type;  // Type, e.g. int or pointer to int
  const Token *tok;   // Representative token
};

typedef enum {
  NODE_NEG,       // unary -
  NODE_ADDR,      // unary &
  NODE_DEREF,     // unary *
  NODE_EXPR_STMT, // Expression statement
  NODE_RETURN,    // "return"
} UnaryKind;
struct UnaryNode {
  Node node;
  UnaryKind kind;
  Node *expr;
};

typedef enum {
  NODE_ADD,    // +
  NODE_SUB,    // -
  NODE_MUL,    // *
  NODE_DIV,    // /
  NODE_EQ,     // ==
  NODE_NE,     // !=
  NODE_LT,     // <
  NODE_LE,     // <=
  NODE_ASSIGN, // =
} BinaryKind;
struct BinaryNode {
  Node node;
  BinaryKind kind;
  Node *lhs; // Left-hand side
  Node *rhs; // Right-hand side
};
struct IfNode {
  Node node;
  Node *cond_expr;
  Node *then_stmt;
  Node *else_stmt;
};
struct ForNode {
  Node node;
  Node *init_expr;
  Node *cond_expr;
  Node *inc_expr;
  Node *body_stmt;
};
struct BlockNode {
  Node node;
  Node *body;
};
struct FunCallNode {
  Node node;
  Node *args;
  const char *funcname;
  int funcname_length;
};
struct VarNode {
  Node node;
  struct Obj *var;
};
struct NumNode {
  Node node;
  int val;
};

Node *new_unary_node(UnaryKind kind, Node *expr, const Token *tok);
Node *new_binary_node(BinaryKind kind, Node *lhs, Node *rhs, const Token *tok);
Node *new_if_node(Node *cond_expr, Node *then_stmt, Node *else_stmt,
                  const Token *tok);
Node *new_for_node(Node *init_expr, Node *cond_expr, Node *inc_expr,
                   Node *body_stmt, const Token *tok);
Node *new_block_node(Node *body, const Token *tok);
Node *new_fun_call_node(const char *funcname, int funcname_len, Node *args,
                        const Token *tok);
Node *new_var_node(struct Obj *var, const Token *tok);
Node *new_num_node(int val, const Token *tok);

#endif /* AST_NODE_HEADER_GUARD */