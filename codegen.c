#include "cimple.h"

static int depth;

static void push(void)
{
  printf("  push %%rax\n");
  depth++;
}

static void pop(char *arg)
{
  printf("  pop %s\n", arg);
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
  if (node->kind == ND_VAR)
  {
    printf("  lea %d(%%rbp), %%rax\n", node->var->offset);
    return;
  }

  error("not an lvalue");
}

static void gen_expr(Node *node)
{
  switch (node->kind)
  {
  case ND_NUM:
    printf("  mov $%d, %%rax\n", node->val);
    return;
  case ND_NEG:
    gen_expr(node->lhs);
    printf("  neg %%rax\n");
    return;
  case ND_VAR:
    gen_addr(node);
    printf("  mov (%%rax), %%rax\n");
    return;
  case ND_ASSIGN:
    gen_addr(node->lhs);
    push(); // push the address of the local variable
    gen_expr(node->rhs);
    pop("%rdi"); // pop the address of the local variable
    printf("  mov %%rax, (%%rdi)\n");
    return;
  }

  gen_expr(node->rhs);
  push();
  gen_expr(node->lhs);
  pop("%rdi");

  switch (node->kind)
  {
  case ND_ADD:
    printf("  add %%rdi, %%rax\n");
    return;
  case ND_SUB:
    printf("  sub %%rdi, %%rax\n");
    return;
  case ND_MUL:
    printf("  imul %%rdi, %%rax\n");
    return;
  case ND_DIV:
    printf("  cqo\n");
    printf("  idiv %%rdi\n");
    return;
  case ND_EQ:
  case ND_NE:
  case ND_LT:
  case ND_LE:
    printf("  cmp %%rdi, %%rax\n");

    if (node->kind == ND_EQ)
      printf("  sete %%al\n");
    else if (node->kind == ND_NE)
      printf("  setne %%al\n");
    else if (node->kind == ND_LT)
      printf("  setl %%al\n");
    else if (node->kind == ND_LE)
      printf("  setle %%al\n");

    printf("  movzb %%al, %%rax\n");
    return;
  }

  error("invalid expression");
}

static void gen_stmt(Node *node)
{
  switch (node->kind)
  {
  case ND_RETURN:
    gen_expr(node->lhs);
    printf("  jmp .L.return\n");
    return;
  case ND_EXPR_STMT:
    gen_expr(node->lhs);
    return;
  }

  error("invalid statement");
}

// Assign offsets to local variables.
static void assign_lvar_offsets(Function *prog)
{
  int offset = 0;
  for (Obj *var = prog->locals; var; var = var->next)
  {
    offset += 8;
    var->offset = -offset;
  }
  prog->stack_size = align_to(offset, 16);
}

void codegen(Function *prog)
{
  assign_lvar_offsets(prog);

  printf("  .globl main\n");
  printf("main:\n");

  // Prologue
  printf("  push %%rbp\n");
  printf("  mov %%rsp, %%rbp\n");
  printf("  sub $%d, %%rsp\n", prog->stack_size);

  for (Node *n = prog->body; n; n = n->next)
  {
    gen_stmt(n);
    assert(depth == 0);
  }

  printf(".L.return:\n");
  // epilogue
  printf("  mov %%rbp, %%rsp\n");
  printf("  pop %%rbp\n");
  printf("  ret\n");
}
