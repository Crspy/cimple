#include "cimple.h"

static int depth;
static char *argreg[] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};
static Function *current_fn;

static void gen_expr(Node *node);

static int count(void)
{
  static int i = 1;
  return i++;
}

static void push(void)
{
  printf("\tpush %%rax\n");
  depth++;
}

static void pop(char *arg)
{
  printf("\tpop %s\n", arg);
  depth--;
}

bool isPowerofTwo(int n)
{
  return (n != 0) && ((n & (n - 1)) == 0);
}

// Round up `n` to the nearest multiple of `align` (where align is a power of 2)
// For instance, align_to(5, 8) returns 8 and align_to(11, 8) returns 16.
static int align_to(int n, int align)
{
  assert(isPowerofTwo(align));
  return ((n - 1) & -align) + align;
}

// Compute the absolute address of a given node.
// It's an error if a given node does not reside in memory.
static void gen_addr(Node *node)
{
  switch (node->kind)
  {
  case NODE_VAR:
    printf("\tlea %d(%%rbp), %%rax\n", node->var->offset);
    return;
  case NODE_DEREF:
    gen_expr(node->lhs);
    return;
  }

  error_tok(node->tok, "not an lvalue");
}

static void gen_expr(Node *node)
{
  switch (node->kind)
  {
  case NODE_NUM:
    printf("\tmov $%d, %%rax\n", node->val);
    return;
  case NODE_NEG:
    gen_expr(node->lhs);
    printf("\tneg %%rax\n");
    return;
  case NODE_VAR:
    gen_addr(node);
    printf("\tmov (%%rax), %%rax\n");
    return;
  case NODE_DEREF:
    gen_expr(node->lhs);
    printf("\tmov (%%rax), %%rax\n");
    return;
  case NODE_ADDR:
    gen_addr(node->lhs);
    return;
  case NODE_ASSIGN:
    gen_addr(node->lhs);
    push(); // push the address of the local variable
    gen_expr(node->rhs);
    pop("%rdi"); // pop the address of the local variable
    printf("\tmov %%rax, (%%rdi)\n");
    return;
  case NODE_FUNCALL:
  {
    int nargs = 0;
    for (Node *arg = node->args; arg; arg = arg->next)
    {
      gen_expr(arg);
      push();
      nargs++;
    }

    for (int i = nargs - 1; i >= 0; i--)
      pop(argreg[i]);

    printf("\tmov $0, %%rax\n");
    printf("\tcall %s\n", node->funcname);
    return;
  }
  }

  gen_expr(node->rhs);
  push();
  gen_expr(node->lhs);
  pop("%rdi");

  switch (node->kind)
  {
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

    if (node->kind == NODE_EQ)
      printf("\tsete %%al\n");
    else if (node->kind == NODE_NE)
      printf("\tsetne %%al\n");
    else if (node->kind == NODE_LT)
      printf("\tsetl %%al\n");
    else if (node->kind == NODE_LE)
      printf("\tsetle %%al\n");

    printf("\tmovzb %%al, %%rax\n");
    return;
  }

  error_tok(node->tok, "invalid expression");
}

static void gen_stmt(Node *node)
{
  switch (node->kind)
  {
  case NODE_IF:
  {
    const int c = count();
    gen_expr(node->cond_expr);
    printf("\tcmp $0, %%rax\n");
    printf("\tje  .L.else.%d\n", c);
    gen_stmt(node->then_stmt);
    printf("\tjmp .L.end.%d\n", c);
    printf(".L.else.%d:\n", c);
    if (node->else_stmt)
    {
      gen_stmt(node->else_stmt);
    }
    printf(".L.end.%d:\n", c);
    return;
  }
  case NODE_FOR:
  {
    int c = count();
    if (node->init_expr)
      gen_stmt(node->init_expr);
    printf(".L.begin.%d:\n", c);
    if (node->cond_expr)
    {
      gen_expr(node->cond_expr);
      printf("\tcmp $0, %%rax\n");
      printf("\tje  .L.end.%d\n", c);
    }
    gen_stmt(node->then_stmt);
    if (node->inc_expr)
      gen_expr(node->inc_expr);
    printf("\tjmp .L.begin.%d\n", c);
    printf(".L.end.%d:\n", c);
    return;
  }
  case NODE_BLOCK:
    for (Node *n = node->body; n; n = n->next)
    {
      gen_stmt(n);
    }
    return;
  case NODE_RETURN:
    gen_expr(node->lhs);
    printf("\tjmp .L.return.%s\n", current_fn->name);
    return;
  case NODE_EXPR_STMT:
    gen_expr(node->lhs);
    return;
  }

  error_tok(node->tok, "invalid statement");
}

// Assign offsets to local variables.
static void assign_lvar_offsets(Function *prog)
{
  for (Function *fn = prog; fn; fn = fn->next)
  {
    int offset = 0;
    for (Obj *var = fn->locals; var; var = var->next)
    {
      offset += 8;
      var->offset = -offset;
    }
    fn->stack_size = align_to(offset, 16);
  }
}

void codegen(Function *prog)
{
  assign_lvar_offsets(prog);

  for (Function *fn = prog; fn; fn = fn->next)
  {
    printf(".globl %s\n", fn->name);
    printf("%s:\n", fn->name);
    current_fn = fn;

    // Prologue
    if (fn->stack_size != 0)
    {
      printf("\tpush %%rbp\n");
      printf("\tmov %%rsp, %%rbp\n");

      printf("\tsub $%d, %%rsp\n", fn->stack_size);
    }

    // Save passed-by-register arguments to the stack
    int i = 0;
    for (Obj *var = fn->params; var; var = var->next)
    {
      printf("\tmov %s, %d(%%rbp)\n", argreg[i++], var->offset);
    }

    // Emit code
    gen_stmt(fn->body);
    assert(depth == 0);

    // Epilogue
    printf(".L.return.%s:\n", fn->name);
    if (fn->stack_size != 0)
    {
      printf("\tmov %%rbp, %%rsp\n");
      printf("\tpop %%rbp\n");
    }
    printf("\tret\n");
  }
}
