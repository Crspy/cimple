#include "cimple.h"

static Type type_int = {.kind = TYPE_INT, .size = 8};

Type *int_type()
{
  return &type_int;
}

bool is_integer(Type *type)
{
  return type->kind == TYPE_INT;
}

Type *copy_type(Type *type)
{
  Type *ret = malloc(sizeof(Type));
  *ret = *type;
  return ret;
}

Type *pointer_to(Type *base)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_PTR;
  type->size = 8;
  type->base = base;
  return type;
}

Type *func_type(Type *return_type)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_FUNC;
  type->return_type = return_type;
  return type;
}

Type *array_of(Type *base, int len)
{
  Type *ty = calloc(1, sizeof(Type));
  ty->kind = TYPE_ARRAY;
  ty->size = base->size * len;
  ty->base = base;
  ty->array_length = len;
  return ty;
}

void add_type(Node *node)
{
  if (!node || node->type)
    return;

  add_type(node->lhs);
  add_type(node->rhs);

  add_type(node->else_stmt);

  add_type(node->then_stmt);
  add_type(node->cond_expr);

  add_type(node->init_expr);
  add_type(node->inc_expr);

  for (Node *n = node->body; n; n = n->next)
  {
    add_type(n);
  }

  for (Node *n = node->args; n; n = n->next)
  {
    add_type(n);
  }

  switch (node->kind)
  {
  case NODE_ADD:
  case NODE_SUB:
  case NODE_MUL:
  case NODE_DIV:
  case NODE_NEG:
    // TODO: add warnings about incompatible (pointer?) types
    node->type = node->lhs->type;
    return;
  case NODE_ASSIGN:
    if (node->lhs->type->kind == TYPE_ARRAY)
    {
      error_tok(node->lhs->tok, "not an lvalue");
    }
    node->type = node->lhs->type;
    return;
  case NODE_EQ:
  case NODE_NE:
  case NODE_LT:
  case NODE_LE:
  case NODE_NUM:
  case NODE_FUNCALL:
    node->type = int_type();
    return;
  case NODE_VAR:
    node->type = node->var->type;
    break;
  case NODE_ADDR:
    if (node->lhs->type->kind == TYPE_ARRAY)
    {
      /*
      *   int arr[2];
      *   int* p = &arr;
      */
      node->type = pointer_to(node->lhs->type->base);
    }
    else
    {
      node->type = pointer_to(node->lhs->type);
    }
    return;
  case NODE_DEREF:
    // only pointer and array types have a base
    if (node->lhs->type->base == NULL)
    {
      error_tok(node->tok, "invalid pointer dereference");
    }
    node->type = node->lhs->type->base;
    return;
  }
}