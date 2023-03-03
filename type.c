#include "ast_node.h"
#include "cimple.h"
#include "type.h"


Type *enum_type(void)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_ENUM;
  type->size = 4;
  type->align = 4;
  return type;
}

Type *void_type(void)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_VOID;
  type->size = 1;
  type->align = 1;
  return type;
}
Type *bool_type(void)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_BOOL;
  type->size = 1;
  type->align = 1;
  return type;
}
Type *char_type(void)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_CHAR;
  type->size = 1;
  type->align = 1;
  return type;
}
Type *short_type(void)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_SHORT;
  type->size = 2;
  type->align = 2;
  return type;
}

Type *int_type(void)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_INT;
  type->size = 4;
  type->align = 4;
  return type;
}
Type *long_type(void)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_LONG;
  type->size = 8;
  type->align = 8;
  return type;
}

Member *new_struct_union_member(Type *type, const Token *name)
{
  Member *member = calloc(1, sizeof(Member));
  member->type = type;
  member->name = type->name;
  return member;
}

Type *new_struct_type(Member *members, size_t size, size_t align)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_STRUCT;
  type->members = members;
  type->size = size;
  type->align = align;
  return type;
}
Type *new_union_type(Member *members, size_t size, size_t align)
{
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_UNION;
  type->members = members;
  type->size = size;
  type->align = align;
  return type;
}

bool is_integer(Type *type)
{
  switch(type->kind)
  {
  case TYPE_BOOL:
  case TYPE_CHAR:
  case TYPE_SHORT:
  case TYPE_INT:
  case TYPE_LONG:
  case TYPE_ENUM:
    return true;
  default:
    return false;
  }
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
  type->align = 8;
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

Type *array_of(Type *base, size_t len)
{
  Type *ty = calloc(1, sizeof(Type));
  ty->kind = TYPE_ARRAY;
  ty->size = base->size * len;
  ty->align = base->align;
  ty->base = base;
  ty->array_length = len;
  return ty;
}

static Type *get_common_type(Type *ty1, Type *ty2)
{
  if (ty1->base)
    return pointer_to(ty1->base);

  if (ty1->size == 8 || ty2->size == 8)
    return long_type();

  return int_type();
}

// For many binary operators, we implicitly promote operands so that
// both operands have the same type. Any integral type smaller than
// int is always promoted to int. If the type of one operand is larger
// than the other's (e.g. "long" vs. "int"), the smaller operand will
// be promoted to match with the other.
//
// This operation is called the "usual arithmetic conversion".
static void usual_arith_conv(Node **lhs, Node **rhs)
{
  Type *ty = get_common_type((*lhs)->type, (*rhs)->type);
  *lhs = new_cast_node(*lhs, ty);
  *rhs = new_cast_node(*rhs, ty);
}

void add_type(struct Node *node)
{
  if (!node || node->type)
    return;

  switch (node->tag)
  {
  case NODE_TAG_UNARY:
  {
    struct UnaryNode *unary = (struct UnaryNode *)node;
    add_type(unary->expr);

    switch (unary->kind)
    {
    case NODE_NEG:
    {
      Type *type = get_common_type(int_type(), unary->expr->type);
      unary->expr = new_cast_node(unary->expr, type);
      node->type = type;
      return;
    }
    case NODE_ADDR:
      if (unary->expr->type->kind == TYPE_ARRAY)
      {
        /*
         *   int arr[2];
         *   int* p = &arr;
         */
        node->type = pointer_to(unary->expr->type->base);
      }
      else
      {
        node->type = pointer_to(unary->expr->type);
      }
      return;
    case NODE_DEREF:
      // only pointer and array types have a base
      if (unary->expr->type->base == NULL)
      {
        error_tok(node->tok, "invalid pointer dereference");
      }
      node->type = unary->expr->type->base;
      return;
    case NODE_STMT_EXPR:
    {
      if (unary->expr)
      {
        Node *stmt = unary->expr;
        while (stmt->next)
          stmt = stmt->next;
        if (stmt->tag == NODE_TAG_UNARY)
        {
          struct UnaryNode *last_node = (struct UnaryNode *)stmt;
          if (last_node->kind == NODE_EXPR_STMT)
          {
            node->type = last_node->expr->type;
            return;
          }
        }
      }
      error_tok(node->tok,
                "statement expression returning void is not supported");
      return;
    }
    default:
      break;
    }

    break;
  }
  case NODE_TAG_BINARY:
  {
    struct BinaryNode *binary = (struct BinaryNode *)node;
    add_type(binary->lhs);
    add_type(binary->rhs);

    switch (binary->kind)
    {
    case NODE_ADD:
    case NODE_SUB:
    case NODE_MUL:
    case NODE_DIV:
      usual_arith_conv(&binary->lhs, &binary->rhs);
      node->type = binary->lhs->type;
      return;
    case NODE_EQ:
    case NODE_NE:
    case NODE_LT:
    case NODE_LE:
      usual_arith_conv(&binary->lhs, &binary->rhs);
      node->type = int_type();
      return;
    case NODE_ASSIGN:
      if (binary->lhs->type->kind == TYPE_ARRAY)
      {
        error_tok(binary->lhs->tok, "not an lvalue");
      }
      if (binary->lhs->type->kind != TYPE_STRUCT)
      {
        binary->rhs = new_cast_node(binary->rhs, binary->lhs->type);
      }
      node->type = binary->lhs->type;
      return;
    case NODE_COMMA:
      node->type = binary->rhs->type;
      return;
    }
    break;
  }
  case NODE_TAG_MEMBER:
  {
    struct MemberNode *member_node = (struct MemberNode *)node;
    node->type = member_node->member->type;
    break;
  }
  case NODE_TAG_IF:
  {
    struct IfNode *if_node = (struct IfNode *)node;
    add_type(if_node->cond_expr);
    add_type(if_node->then_stmt);
    add_type(if_node->else_stmt);
    break;
  }
  case NODE_TAG_FOR:
  {
    struct ForNode *for_node = (struct ForNode *)node;
    add_type(for_node->init_expr);
    add_type(for_node->cond_expr);
    add_type(for_node->inc_expr);
    add_type(for_node->body_stmt);
    break;
  }
  case NODE_TAG_BLOCK:
  {
    struct BlockNode *block_node = (struct BlockNode *)node;
    for (Node *n = block_node->body; n; n = n->next)
    {
      add_type(n);
    }
    break;
  }
  case NODE_TAG_FUNCALL:
  {
    struct FunCallNode *fun_call = (struct FunCallNode *)node;
    for (Node *n = fun_call->args; n; n = n->next)
    {
      add_type(n);
    }
    node->type = long_type();
    return;
  }
  case NODE_TAG_VAR:
  {
    struct VarNode *var_node = (struct VarNode *)node;
    node->type = var_node->var->type;
    return;
  }
  case NODE_TAG_NUM:
  {
    struct NumNode *num_node = (struct NumNode *)node;
    if (num_node->val == (int)num_node->val)
    {
      node->type = int_type();
    }
    else
    {
      node->type = long_type();
    }
    return;
  }
  }
}