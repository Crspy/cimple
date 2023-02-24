#include "ast_node.h"
#include "cimple.h"

/*static Type type_int = {.kind = TYPE_INT, .size = 8};*/

Type *char_type() {
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_CHAR;
  type->size = 1;
  type->align = 1;
  return type;
}

Type *int_type() {
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_INT;
  type->size = 8;
  type->align = 8;
  return type;
}

Member *new_struct_member(Type *type, const Token *name) {
  Member *member = calloc(1, sizeof(Member));
  member->type = type;
  member->name = type->name;
  return member;
}

Type *new_struct_type(Member *members, size_t size, size_t align) {
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_STRUCT;
  type->members = members;
  type->size = size;
  type->align = align;
  return type;
}

bool is_integer(Type *type) {
  return type->kind == TYPE_INT || type->kind == TYPE_CHAR;
}

Type *copy_type(Type *type) {
  Type *ret = malloc(sizeof(Type));
  *ret = *type;
  return ret;
}

Type *pointer_to(Type *base) {
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_PTR;
  type->size = 8;
  type->align = 8;
  type->base = base;
  return type;
}

Type *func_type(Type *return_type) {
  Type *type = calloc(1, sizeof(Type));
  type->kind = TYPE_FUNC;
  type->return_type = return_type;
  return type;
}

Type *array_of(Type *base, size_t len) {
  Type *ty = calloc(1, sizeof(Type));
  ty->kind = TYPE_ARRAY;
  ty->size = base->size * len;
  ty->align = base->align;
  ty->base = base;
  ty->array_length = len;
  return ty;
}

void add_type(struct Node *node) {
  if (!node || node->type)
    return;

  switch (node->tag) {
  case NODE_TAG_UNARY: {
    struct UnaryNode *unary = (struct UnaryNode *)node;
    add_type(unary->expr);

    switch (unary->kind) {
    case NODE_NEG:
      node->type = unary->expr->type;
      return;
    case NODE_ADDR:
      if (unary->expr->type->kind == TYPE_ARRAY) {
        /*
         *   int arr[2];
         *   int* p = &arr;
         */
        node->type = pointer_to(unary->expr->type->base);
      } else {
        node->type = pointer_to(unary->expr->type);
      }
      return;
    case NODE_DEREF:
      // only pointer and array types have a base
      if (unary->expr->type->base == NULL) {
        error_tok(node->tok, "invalid pointer dereference");
      }
      node->type = unary->expr->type->base;
      return;
    case NODE_STMT_EXPR: {
      if (unary->expr) {
        Node *stmt = unary->expr;
        while (stmt->next)
          stmt = stmt->next;
        if (stmt->tag == NODE_TAG_UNARY) {
          struct UnaryNode *last_node = (struct UnaryNode *)stmt;
          if (last_node->kind == NODE_EXPR_STMT) {
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
  case NODE_TAG_BINARY: {
    struct BinaryNode *binary = (struct BinaryNode *)node;
    add_type(binary->lhs);
    add_type(binary->rhs);

    switch (binary->kind) {
    case NODE_ADD:
    case NODE_SUB:
    case NODE_MUL:
    case NODE_DIV:
      node->type = binary->lhs->type;
      return;
    case NODE_EQ:
    case NODE_NE:
    case NODE_LT:
    case NODE_LE:
      node->type = int_type();
      return;
    case NODE_ASSIGN:
      if (binary->lhs->type->kind == TYPE_ARRAY) {
        error_tok(binary->lhs->tok, "not an lvalue");
      }
      node->type = binary->lhs->type;
      return;
    case NODE_COMMA:
      node->type = binary->rhs->type;
      return;
    }
    break;
  }
  case NODE_TAG_MEMBER: {
    struct MemberNode *member_node = (struct MemberNode *)node;
    node->type = member_node->member->type;
    break;
  }
  case NODE_TAG_IF: {
    struct IfNode *if_node = (struct IfNode *)node;
    add_type(if_node->cond_expr);
    add_type(if_node->then_stmt);
    add_type(if_node->else_stmt);
    break;
  }
  case NODE_TAG_FOR: {
    struct ForNode *for_node = (struct ForNode *)node;
    add_type(for_node->init_expr);
    add_type(for_node->cond_expr);
    add_type(for_node->inc_expr);
    add_type(for_node->body_stmt);
    break;
  }
  case NODE_TAG_BLOCK: {
    struct BlockNode *block_node = (struct BlockNode *)node;
    for (Node *n = block_node->body; n; n = n->next) {
      add_type(n);
    }
    break;
  }
  case NODE_TAG_FUNCALL: {
    struct FunCallNode *fun_call = (struct FunCallNode *)node;
    for (Node *n = fun_call->args; n; n = n->next) {
      add_type(n);
    }
    node->type = int_type();
    return;
  }
  case NODE_TAG_VAR: {
    struct VarNode *var_node = (struct VarNode *)node;
    node->type = var_node->var->type;
    return;
  }
  case NODE_TAG_NUM:
    node->type = int_type();
    return;
  }
}