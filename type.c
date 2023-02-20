#include "cimple.h"

Type *type_int = &(Type){TY_INT};

bool is_integer(Type *ty) {
  return ty->kind == TY_INT;
}

Type *pointer_to(Type *base) {
  Type *ty = calloc(1,sizeof(Type));
  ty->kind = TY_PTR;
  ty->base = base;
  return ty;
}

Type *func_type(Type *return_type) {
  Type *type = calloc(1, sizeof(Type));
  type->kind = TY_FUNC;
  type->return_type = return_type;
  return type;
}

void add_type(Node *node) {
  if (!node || node->type)
    return;

  add_type(node->lhs);
  add_type(node->rhs);
  add_type(node->cond_expr);
  add_type(node->then_stmt);
  add_type(node->else_stmt);
  add_type(node->init_expr);
  add_type(node->inc_expr);

  for (Node *n = node->body; n; n = n->next)
    add_type(n);

  switch (node->kind) {
  case ND_ADD:
  case ND_SUB:
  case ND_MUL:
  case ND_DIV:
  case ND_NEG:
  case ND_ASSIGN:
    // TODO: add warnings about incompatible (pointer?) types
    node->type = node->lhs->type;
    return;
  case ND_EQ:
  case ND_NE:
  case ND_LT:
  case ND_LE:
  case ND_NUM:
  case ND_FUNCALL:
    node->type = type_int;
    return;
  case ND_VAR:
    node->type = node->var->type;
    break;
  case ND_ADDR:
    node->type = pointer_to(node->lhs->type);
    return;
  case ND_DEREF:
    if (node->lhs->type->kind != TY_PTR)
    {
      error_tok(node->tok, "invalid pointer dereference");
    }
    node->type = node->lhs->type->base;
    return;
  }
}