
#include "ast_node.h"
#include "cimple.h"

Node *new_unary_node(UnaryKind kind, Node *expr, const Token *tok) {
  struct UnaryNode *node = calloc(1, sizeof(struct UnaryNode));
  node->node.tag = NODE_TAG_UNARY;
  node->node.tok = tok;
  node->kind = kind;
  node->expr = expr;
  return (Node *)node;
}
Node *new_binary_node(BinaryKind kind, Node *lhs, Node *rhs,
                             const Token *tok) {
  struct BinaryNode *node = calloc(1, sizeof(struct BinaryNode));
  node->node.tag = NODE_TAG_BINARY;
  node->node.tok = tok;
  node->kind = kind;
  node->lhs = lhs;
  node->rhs = rhs;
  return (Node *)node;
}
Node *new_member_node(Node *lhs, Member *member,
                             const Token *tok) {
  MemberNode *node = calloc(1, sizeof(struct MemberNode));
  node->node.tag = NODE_TAG_MEMBER;
  node->node.tok = tok;
  node->lhs = lhs;
  node->member = member;
  return (Node *)node;
}
Node *new_if_node(Node *cond_expr, Node *then_stmt, Node *else_stmt,
                         const Token *tok) {
  struct IfNode *node = calloc(1, sizeof(struct IfNode));
  node->node.tag = NODE_TAG_IF;
  node->node.tok = tok;
  node->cond_expr = cond_expr;
  node->then_stmt = then_stmt;
  node->else_stmt = else_stmt;
  return (Node *)node;
}
Node *new_for_node(Node *init_expr, Node *cond_expr, Node *inc_expr,
                          Node *body_stmt, const Token *tok) {
  struct ForNode *node = calloc(1, sizeof(struct ForNode));
  node->node.tag = NODE_TAG_FOR;
  node->node.tok = tok;
  node->init_expr = init_expr;
  node->cond_expr = cond_expr;
  node->inc_expr = inc_expr;
  node->body_stmt = body_stmt;
  return (Node *)node;
}
BlockNode *new_block_node(Node *body, const Token *tok) {
  struct BlockNode *node = calloc(1, sizeof(struct BlockNode));
  node->node.tag = NODE_TAG_BLOCK;
  node->node.tok = tok;
  node->body = body;
  return node;
}
Node *new_fun_call_node(const char *funcname, int funcname_len,
                               Node *args, const Token *tok) {
  struct FunCallNode *node = calloc(1, sizeof(struct FunCallNode));
  node->node.tag = NODE_TAG_FUNCALL;
  node->node.tok = tok;
  node->funcname = funcname;
  node->funcname_length = funcname_len;
  node->args = args;
  return (Node *)node;
}
Node *new_var_node(const Obj *var, const Token *tok) {
  struct VarNode *node = calloc(1, sizeof(struct VarNode));
  node->node.tag = NODE_TAG_VAR;
  node->node.tok = tok;
  node->var = var;
  return (Node *)node;
}
Node *new_num_node(int val, const Token *tok) {
  struct NumNode *node = calloc(1, sizeof(struct NumNode));
  node->node.tag = NODE_TAG_NUM;
  node->node.tok = tok;
  node->val = val;
  return (Node *)node;
}
