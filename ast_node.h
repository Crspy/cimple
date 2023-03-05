#ifndef AST_NODE_HEADER_GUARD
#define AST_NODE_HEADER_GUARD

#include "tokenizer.h"

// AST node
typedef struct Node Node;
struct Node
{
  enum NodeTag
  {
    NODE_TAG_UNARY,
    NODE_TAG_BINARY,
    NODE_TAG_MEMBER,
    NODE_TAG_IF,
    NODE_TAG_FOR,
    NODE_TAG_BLOCK,
    NODE_TAG_FUNCALL,
    NODE_TAG_VAR,
    NODE_TAG_NUM
  } tag;
  Node *next;        // Next node
  struct Type *type; // Type, e.g. int or pointer to int
  const Token *tok;  // Representative token
};

const char* node_tag_to_str(enum NodeTag tag);

typedef enum
{
  NODE_POST_INC,
  NODE_POST_DEC,
  NODE_NEG,       // unary -
  NODE_ADDR,      // unary &
  NODE_DEREF,     // unary *
  NODE_EXPR_STMT, // Expression statement
  NODE_STMT_EXPR, // Statement expression
  NODE_RETURN,    // "return"
  NODE_CAST,      // Type cast
} UnaryKind;
typedef struct UnaryNode
{
  Node node;
  UnaryKind kind;
  Node *expr;
} UnaryNode;

typedef enum
{
  NODE_ADD,    // +
  NODE_SUB,    // -
  NODE_MUL,    // *
  NODE_DIV,    // /
  NODE_EQ,     // ==
  NODE_NE,     // !=
  NODE_LT,     // <
  NODE_LE,     // <=
  NODE_ASSIGN, // =
  NODE_COMMA,  // ,
} BinaryKind;
typedef struct BinaryNode
{
  Node node;
  BinaryKind kind;
  Node *lhs; // Left-hand side
  Node *rhs; // Right-hand side
} BinaryNode;
typedef struct MemberNode
{
  Node node;
  Node *lhs;             // Left-hand side
  struct Member *member; // Right-hand side
} MemberNode;
typedef struct IfNode
{
  Node node;
  Node *cond_expr;
  Node *then_stmt;
  Node *else_stmt;
} IfNode;
typedef struct ForNode
{
  Node node;
  Node *init_expr;
  Node *cond_expr;
  Node *inc_expr;
  Node *body_stmt;
} ForNode;
typedef struct BlockNode
{
  Node node;
  Node *body;
} BlockNode;
typedef struct FunCallNode
{
  Node node;
  Node *args;
  struct Type *func_type;
  const char *funcname;
  int funcname_length;
} FunCallNode;
typedef struct VarNode
{
  Node node;
  const struct Obj *var;
} VarNode;
typedef struct NumNode
{
  Node node;
  int64_t val;
} NumNode;

Node *new_unary_node(UnaryKind kind, Node *expr, const Token *tok);
Node *new_cast_node(Node *expr, struct Type *type);
Node *new_binary_node(BinaryKind kind, Node *lhs, Node *rhs, const Token *tok);
Node *new_member_node(Node *lhs, struct Member *member, const Token *tok);
Node *new_if_node(Node *cond_expr, Node *then_stmt, Node *else_stmt,
                  const Token *tok);
Node *new_for_node(Node *init_expr, Node *cond_expr, Node *inc_expr,
                   Node *body_stmt, const Token *tok);
BlockNode *new_block_node(Node *body, const Token *tok);
Node *new_fun_call_node(const char *funcname, int funcname_len, Node *args,
                        const Token *tok, struct Type* func_type);
Node *new_var_node(const struct Obj *var, const Token *tok);
Node *new_num_node(int64_t val, const Token *tok);

#endif /* AST_NODE_HEADER_GUARD */