#include "cimple.h"

static int depth;
static char *argreg8[] = {"%dil", "%sil", "%dl", "%cl", "%r8b", "%r9b"};
static char *argreg64[] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};
static Obj *current_fn;

static void gen_expr(Node *node);

static int count(void) {
  static int i = 1;
  return i++;
}

static void push(void) {
  printf("\tpush %%rax\n");
  depth++;
}

static void pop(char *arg) {
  printf("\tpop %s\n", arg);
  depth--;
}

bool isPowerofTwo(int n) { return (n != 0) && ((n & (n - 1)) == 0); }

// Round up `n` to the nearest multiple of `align` (where align is a power of 2)
// For instance, align_to(5, 8) returns 8 and align_to(11, 8) returns 16.
static int align_to(int n, int align) {
  assert(isPowerofTwo(align));
  return ((n - 1) & -align) + align;
}

// Compute the absolute address of a given node.
// It's an error if a given node does not reside in memory.
static void gen_addr(Node *node) {
  switch (node->tag) {
  case NODE_TAG_VAR: {
    struct VarNode *var_node = (struct VarNode *)node;
    if (var_node->var->is_local) {
      // Local variable
      printf("\tlea %d(%%rbp), %%rax\n", var_node->var->offset);
    } else {
      // Global variable
      printf("\tlea %s(%%rip), %%rax\n", var_node->var->name);
    }
    return;
  }
  case NODE_TAG_UNARY: {
    struct UnaryNode *unary = (struct UnaryNode *)node;
    if (unary->kind == NODE_DEREF) {
      gen_expr(unary->expr);
    }
    return;
  }
  default:
    break;
  }

  error_tok(node->tok, "not an lvalue");
}

// Load a value from where %rax is pointing to.
static void load(Type *type) {
  if (type->kind == TYPE_ARRAY) {
    // If it is an array, do not attempt to load a value to the
    // register because in general we can't load an entire array to a
    // register. As a result, the result of an evaluation of an array
    // becomes not the array itself but the address of the array.
    // This is where "array is automatically converted to a pointer to
    // the first element of the array in C" occurs.
    return;
  }

  if (type->size == 1)
    printf("\tmovsbq (%%rax), %%rax\n");
  else
    printf("\tmov (%%rax), %%rax\n");
}

// Store %rax to an address that the stack top is pointing to.
static void store(Type *type) {
  pop("%rdi");

  if (type->size == 1)
    printf("\tmov %%al, (%%rdi)\n");
  else
    printf("\tmov %%rax, (%%rdi)\n");
}

static void gen_expr(Node *node) {
  switch (node->tag) {
  case NODE_TAG_UNARY: {
    struct UnaryNode *unary = (struct UnaryNode *)node;

    switch (unary->kind) {
    case NODE_NEG:
      gen_expr(unary->expr);
      printf("\tneg %%rax\n");
      return;
    case NODE_ADDR:
      gen_addr(unary->expr);
      return;
    case NODE_DEREF:
      gen_expr(unary->expr);
      load(node->type);
      return;
    default:
      break;
    }

    break;
  }
  case NODE_TAG_BINARY: {
    struct BinaryNode *binary = (struct BinaryNode *)node;

    if (binary->kind == NODE_ASSIGN) {
      gen_addr(binary->lhs);
      push(); // push the address of the local variable
      gen_expr(binary->rhs);
      store(node->type);
      return;
    }

    gen_expr(binary->rhs);
    push();
    gen_expr(binary->lhs);
    pop("%rdi");

    switch (binary->kind) {
    case NODE_ADD:
      printf("\tadd %%rdi, %%rax\n");
      return;
    case NODE_SUB:
      printf("\tsub %%rdi, %%rax\n");
      return;
    case NODE_MUL:
      printf("\timul %%rdi, %%rax\n");
      return;
    case NODE_DIV:
      printf("\tcqo\n");
      printf("\tidiv %%rdi\n");
      return;
    case NODE_EQ:
    case NODE_NE:
    case NODE_LT:
    case NODE_LE:
      printf("\tcmp %%rdi, %%rax\n");

      if (binary->kind == NODE_EQ)
        printf("\tsete %%al\n");
      else if (binary->kind == NODE_NE)
        printf("\tsetne %%al\n");
      else if (binary->kind == NODE_LT)
        printf("\tsetl %%al\n");
      else if (binary->kind == NODE_LE)
        printf("\tsetle %%al\n");

      printf("\tmovzb %%al, %%rax\n");
      return;
    default:
      break;
    }
    break;
  }
  case NODE_TAG_FUNCALL: {
    struct FunCallNode *fun_call = (struct FunCallNode *)node;
    int nargs = 0;
    for (Node *arg = fun_call->args; arg; arg = arg->next) {
      gen_expr(arg);
      push();
      nargs++;
    }

    for (int i = nargs - 1; i >= 0; i--)
      pop(argreg64[i]);

    printf("\tmov $0, %%rax\n");
    printf("\tcall %s\n", fun_call->funcname);
    return;
  }
  case NODE_TAG_VAR: {
    // struct VarNode *var_node = (struct VarNode *)node;
    gen_addr(node);
    load(node->type);
    return;
  }
  case NODE_TAG_NUM:
    printf("\tmov $%d, %%rax\n", ((struct NumNode *)node)->val);
    return;
  default:
    break;
  }

  error_tok(node->tok, "invalid expression");
}

static void gen_stmt(Node *node) {
  switch (node->tag) {
  case NODE_TAG_UNARY: {
    struct UnaryNode *unary = (struct UnaryNode *)node;
    switch (unary->kind) {
    case NODE_EXPR_STMT:
      gen_expr(unary->expr);
      return;
    case NODE_RETURN:
      gen_expr(unary->expr);
      printf("\tjmp .L.return.%s\n", current_fn->name);
      return;
    default:
      break;
    }
    break;
  }
  case NODE_TAG_IF: {
    struct IfNode *if_node = (struct IfNode *)node;
    const int c = count();
    gen_expr(if_node->cond_expr);
    printf("\tcmp $0, %%rax\n");
    printf("\tje  .L.else.%d\n", c);
    gen_stmt(if_node->then_stmt);
    printf("\tjmp .L.end.%d\n", c);
    printf(".L.else.%d:\n", c);
    if (if_node->else_stmt) {
      gen_stmt(if_node->else_stmt);
    }
    printf(".L.end.%d:\n", c);
    return;
  }
  case NODE_TAG_FOR: {
    struct ForNode *for_node = (struct ForNode *)node;
    int c = count();
    if (for_node->init_expr)
      gen_stmt(for_node->init_expr);
    printf(".L.begin.%d:\n", c);
    if (for_node->cond_expr) {
      gen_expr(for_node->cond_expr);
      printf("\tcmp $0, %%rax\n");
      printf("\tje  .L.end.%d\n", c);
    }
    gen_stmt(for_node->body_stmt);
    if (for_node->inc_expr)
      gen_expr(for_node->inc_expr);
    printf("\tjmp .L.begin.%d\n", c);
    printf(".L.end.%d:\n", c);
    return;
  }
  case NODE_TAG_BLOCK: {
    struct BlockNode *block_node = (struct BlockNode *)node;
    for (Node *n = block_node->body; n; n = n->next) {
      gen_stmt(n);
    }
    return;
  }
  default:
    break;
  }

  error_tok(node->tok, "invalid statement");
}

// Assign offsets to local variables.
static void assign_lvar_offsets(Obj *prog) {
  for (Obj *fn = prog; fn; fn = fn->next) {
    if (!fn->is_function)
      continue;

    int offset = 0;
    for (Obj *var = fn->locals; var; var = var->next) {
      offset += var->type->size;
      var->offset = -offset;
    }
    fn->stack_size = align_to(offset, 16);
  }
}

static void emit_data(Obj *prog) {
  for (Obj *var = prog; var; var = var->next) {
    if (var->is_function)
      continue;

    printf(".data\n");
    printf(".globl %s\n", var->name);
    printf("%s:\n", var->name);
    if (var->init_data) {
      for (int i = 0; i < var->type->size; i++) {
        printf("\t.byte %d\n", var->init_data[i]);
      }
    } else {
      printf("\t.zero %d\n", var->type->size);
    }
  }
}

static void emit_text(Obj *prog) {
  for (Obj *fn = prog; fn; fn = fn->next) {
    if (!fn->is_function)
      continue;

    printf(".text\n");
    printf(".globl %s\n", fn->name);
    printf("%s:\n", fn->name);
    current_fn = fn;

    // Prologue
    if (fn->stack_size != 0) {
      printf("\tpush %%rbp\n");
      printf("\tmov %%rsp, %%rbp\n");

      printf("\tsub $%d, %%rsp\n", fn->stack_size);
    }

    // Save passed-by-register arguments to the stack
    int i = 0;
    for (Obj *var = fn->params; var; var = var->next) {
      if (var->type->size == 1)
        printf("\tmov %s, %d(%%rbp)\n", argreg8[i++], var->offset);
      else
        printf("\tmov %s, %d(%%rbp)\n", argreg64[i++], var->offset);
    }

    // Emit code
    gen_stmt(fn->body);
    assert(depth == 0);

    // Epilogue
    printf(".L.return.%s:\n", fn->name);
    if (fn->stack_size != 0) {
      printf("\tmov %%rbp, %%rsp\n");
      printf("\tpop %%rbp\n");
    }
    printf("\tret\n");
  }
}

void codegen(Obj *prog) {
  assign_lvar_offsets(prog);
  emit_data(prog);
  emit_text(prog);
}
