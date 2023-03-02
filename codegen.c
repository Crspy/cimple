#include "ast_node.h"
#include "cimple.h"
#include <stdio.h>

static int depth;
static char *argreg8[] = {"%dil", "%sil", "%dl", "%cl", "%r8b", "%r9b"};
static char *argreg16[] = {"%di", "%si", "%dx", "%cx", "%r8w", "%r9w"};
static char *argreg32[] = {"%edi", "%esi", "%edx", "%ecx", "%r8d", "%r9d"};
static char *argreg64[] = {"%rdi", "%rsi", "%rdx", "%rcx", "%r8", "%r9"};
static Obj *current_fn;
static FILE *output_file;

static void gen_expr(Node *node);
static void gen_stmt(Node *node);

static void emitln(const char *fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  vfprintf(output_file, fmt, ap);
  va_end(ap);
  fputc('\n', output_file);
}

static int count(void)
{
  static int i = 1;
  return i++;
}

static void push(void)
{
  emitln("\tpush %%rax");
  depth++;
}

static void pop(char *arg)
{
  emitln("\tpop %s", arg);
  depth--;
}

bool isPowerofTwo(int n) { return (n != 0) && ((n & (n - 1)) == 0); }

// Round up `n` to the nearest multiple of `align` (where align is a power of 2)
// For instance, align_to(5, 8) returns 8 and align_to(11, 8) returns 16.
int align_to(int n, int align)
{
  assert(isPowerofTwo(align));
  return ((n - 1) & -align) + align;
}

// Compute the absolute address of a given node.
// It's an error if a given node does not reside in memory.
static void gen_addr(Node *node)
{
  switch (node->tag)
  {
  case NODE_TAG_MEMBER:
  {
    struct MemberNode *member_node = (struct MemberNode *)node;
    gen_addr(member_node->lhs);
    emitln("\tadd $%d, %%rax", member_node->member->offset);
    return;
  }
  case NODE_TAG_VAR:
  {
    struct VarNode *var_node = (struct VarNode *)node;
    if (var_node->var->is_local)
    {
      // Local variable
      emitln("\tlea %d(%%rbp), %%rax", var_node->var->offset);
    }
    else
    {
      // Global variable
      emitln("\tlea %s(%%rip), %%rax", var_node->var->name);
    }
    return;
  }
  case NODE_TAG_UNARY:
  {
    struct UnaryNode *unary = (struct UnaryNode *)node;
    if (unary->kind == NODE_DEREF)
    {
      gen_expr(unary->expr);
      return;
    }
    break;
  }
  case NODE_TAG_BINARY:
  {
    struct BinaryNode *binary = (struct BinaryNode *)node;
    if (binary->kind == NODE_COMMA)
    {
      gen_expr(binary->lhs);
      gen_addr(binary->rhs);
      return;
    }
    break;
  }
  default:
    break;
  }

  error_tok(node->tok, "not an lvalue");
}

// Load a value from where %rax is pointing to.
static void load(Type *type)
{
  if (type->kind == TYPE_ARRAY || type->kind == TYPE_STRUCT ||
      type->kind == TYPE_UNION)
  {
    // If it is an array/struct/union, do not attempt to load a value to the
    // register because in general we can't load an entire array to a
    // register. As a result, the result of an evaluation of an array
    // becomes not the array itself but the address of the array.
    // This is where "array is automatically converted to a pointer to
    // the first element of the array in C" occurs.
    return;
  }

  // When we load a char or a short value to a register, we always
  // extend them to the size of int, so we can assume the lower half of
  // a register always contains a valid value. The upper half of a
  // register for char, short and int may contain garbage. When we load
  // a long value to a register, it simply occupies the entire register.
  if (type->size == 1)
    emitln("\tmovsbl (%%rax), %%eax");
  else if (type->size == 2)
    emitln("\tmovswl (%%rax), %%eax");
  else if (type->size == 4)
    emitln("\tmovsxd (%%rax), %%rax");
  else
    emitln("\tmov (%%rax), %%rax");
}

// Store %rax to an address that the stack top is pointing to.
static void store(Type *type)
{
  pop("%rdi");

  if (type->kind == TYPE_STRUCT || type->kind == TYPE_UNION)
  {
    for (int i = 0; i < type->size; i++)
    {
      // TODO: optimize this
      emitln("\tmov %d(%%rax), %%r8b", i);
      emitln("\tmov %%r8b, %d(%%rdi)", i);
    }
    return;
  }

  if (type->size == 1)
    emitln("\tmov %%al, (%%rdi)");
  else if (type->size == 2)
    emitln("\tmov %%ax, (%%rdi)");
  else if (type->size == 4)
    emitln("\tmov %%eax, (%%rdi)");
  else
    emitln("\tmov %%rax, (%%rdi)");
}

static void cmp_zero(Type *type)
{
  if (is_integer(type) && type->size <= 4)
    emitln("\ttest %%eax, %%eax");
  else
    emitln("\ttest %%rax, %%rax");
}

static int getTypeId(Type *type)
{
  enum cast_table_id
  {
    I8,
    I16,
    I32,
    I64
  };

  switch (type->kind)
  {
  case TYPE_CHAR:
    return I8;
  case TYPE_SHORT:
    return I16;
  case TYPE_INT:
    return I32;
  default:
    return I64;
  }
}

// The table for type casts
static const char i32i8[] = "movsbl %al, %eax";
static const char i32i16[] = "movswl %ax, %eax";
static const char i32i64[] = "movsxd %eax, %rax";

static const char *cast_table[4][4] = {
    {NULL, NULL, NULL, i32i64},    // i8
    {i32i8, NULL, NULL, i32i64},   // i16
    {i32i8, i32i16, NULL, i32i64}, // i32
    {i32i8, i32i16, NULL, NULL},   // i64
};

static void cast(Type *from, Type *to)
{
  if (to->kind == TYPE_VOID)
    return;
  if (to->kind == TYPE_BOOL)
  {
    cmp_zero(from);
    emitln("\tsetne %%al");
    emitln("\tmovzx %%al, %%eax");
    return;
  }

  int from_id = getTypeId(from);
  int to_id = getTypeId(to);
  if (cast_table[from_id][to_id])
    emitln("\t%s", cast_table[from_id][to_id]);
}

static void gen_expr(Node *node)
{
  emitln("\t.loc 1 %lu %lu", node->tok->line_no, node->tok->col_pos);

  switch (node->tag)
  {
  case NODE_TAG_UNARY:
  {
    struct UnaryNode *unary = (struct UnaryNode *)node;

    switch (unary->kind)
    {
    case NODE_NEG:
      gen_expr(unary->expr);
      emitln("\tneg %%rax");
      return;
    case NODE_ADDR:
      gen_addr(unary->expr);
      return;
    case NODE_DEREF:
      gen_expr(unary->expr);
      load(node->type);
      return;
    case NODE_STMT_EXPR:
      for (Node *n = unary->expr; n; n = n->next)
      {
        gen_stmt(n);
      }
      return;
    case NODE_CAST:
      gen_expr(unary->expr);
      cast(unary->expr->type, node->type);
      return;
    default:
      break;
    }

    break;
  }
  case NODE_TAG_BINARY:
  {
    struct BinaryNode *binary = (struct BinaryNode *)node;

    if (binary->kind == NODE_ASSIGN)
    {
      gen_addr(binary->lhs);
      push(); // push the address of the local variable
      gen_expr(binary->rhs);
      store(node->type);
      return;
    }
    else if (binary->kind == NODE_COMMA)
    {
      gen_expr(binary->lhs);
      gen_expr(binary->rhs);
      return;
    }

    gen_expr(binary->rhs);
    push();
    gen_expr(binary->lhs);
    pop("%rdi");

    const char *ax_reg, *di_reg;

    if (binary->lhs->type->kind == TYPE_LONG || binary->lhs->type->base)
    {
      ax_reg = "%rax";
      di_reg = "%rdi";
    }
    else
    {
      ax_reg = "%eax";
      di_reg = "%edi";
    }

    switch (binary->kind)
    {
    case NODE_ADD:
      emitln("\tadd %s, %s", di_reg, ax_reg);
      return;
    case NODE_SUB:
      emitln("\tsub %s, %s", di_reg, ax_reg);
      return;
    case NODE_MUL:
      emitln("\timul %s, %s", di_reg, ax_reg);
      return;
    case NODE_DIV:
      if (binary->lhs->type->size == 8)
        emitln("\tcqo");
      else
        emitln("\tcdq");
      emitln("\tidiv %s", di_reg);
      return;
    case NODE_EQ:
    case NODE_NE:
    case NODE_LT:
    case NODE_LE:
      emitln("\tcmp %s, %s", di_reg, ax_reg);

      if (binary->kind == NODE_EQ)
        emitln("\tsete %%al");
      else if (binary->kind == NODE_NE)
        emitln("\tsetne %%al");
      else if (binary->kind == NODE_LT)
        emitln("\tsetl %%al");
      else if (binary->kind == NODE_LE)
        emitln("\tsetle %%al");

      emitln("\tmovzb %%al, %%rax");
      return;
    default:
      break;
    }
    break;
  }
  case NODE_TAG_MEMBER:
  {
    gen_addr(node);
    load(node->type);
    return;
  }
  case NODE_TAG_FUNCALL:
  {
    struct FunCallNode *fun_call = (struct FunCallNode *)node;
    int nargs = 0;
    for (Node *arg = fun_call->args; arg; arg = arg->next)
    {
      gen_expr(arg);
      push();
      nargs++;
    }

    for (int i = nargs - 1; i >= 0; i--)
      pop(argreg64[i]);

    emitln("\tmov $0, %%rax");
    emitln("\tcall %s", fun_call->funcname);
    return;
  }
  case NODE_TAG_VAR:
  {
    // struct VarNode *var_node = (struct VarNode *)node;
    gen_addr(node);
    load(node->type);
    return;
  }
  case NODE_TAG_NUM:
    emitln("\tmov $%ld, %%rax", ((struct NumNode *)node)->val);
    return;
  default:
    break;
  }

  error_tok(node->tok, "invalid expression");
}

static void gen_stmt(Node *node)
{
  emitln("\t.loc 1 %lu %lu", node->tok->line_no, node->tok->col_pos);

  switch (node->tag)
  {
  case NODE_TAG_UNARY:
  {
    struct UnaryNode *unary = (struct UnaryNode *)node;
    switch (unary->kind)
    {
    case NODE_EXPR_STMT:
      gen_expr(unary->expr);
      return;
    case NODE_RETURN:
      gen_expr(unary->expr);
      emitln("\tjmp .L.return.%s", current_fn->name);
      return;
    default:
      break;
    }
    break;
  }
  case NODE_TAG_IF:
  {
    struct IfNode *if_node = (struct IfNode *)node;
    const int c = count();
    gen_expr(if_node->cond_expr);
    emitln("\tcmp $0, %%rax");
    emitln("\tje  .L.else.%d", c);
    gen_stmt(if_node->then_stmt);
    emitln("\tjmp .L.end.%d", c);
    emitln(".L.else.%d:", c);
    if (if_node->else_stmt)
    {
      gen_stmt(if_node->else_stmt);
    }
    emitln(".L.end.%d:", c);
    return;
  }
  case NODE_TAG_FOR:
  {
    struct ForNode *for_node = (struct ForNode *)node;
    int c = count();
    if (for_node->init_expr)
      gen_stmt(for_node->init_expr);
    emitln(".L.begin.%d:", c);
    if (for_node->cond_expr)
    {
      gen_expr(for_node->cond_expr);
      emitln("\tcmp $0, %%rax");
      emitln("\tje  .L.end.%d", c);
    }
    gen_stmt(for_node->body_stmt);
    if (for_node->inc_expr)
      gen_expr(for_node->inc_expr);
    emitln("\tjmp .L.begin.%d", c);
    emitln(".L.end.%d:", c);
    return;
  }
  case NODE_TAG_BLOCK:
  {
    struct BlockNode *block_node = (struct BlockNode *)node;
    for (Node *n = block_node->body; n; n = n->next)
    {
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
static void assign_lvar_offsets(Obj *prog)
{
  for (Obj *fn = prog; fn; fn = fn->next)
  {
    if (!fn->is_function)
      continue;

    int offset = 0;
    for (Obj *var = fn->locals; var; var = var->next)
    {
      offset += var->type->size;
      offset = align_to(offset, var->type->align);
      var->offset = -offset;
    }
    fn->stack_size = align_to(offset, 16);
  }
}

static void emit_data(Obj *prog)
{
  for (Obj *var = prog; var; var = var->next)
  {
    if (var->is_function)
      continue;

    emitln(".data");
    emitln(".globl %s", var->name);
    emitln("%s:", var->name);
    if (var->init_data)
    {
      for (int i = 0; i < var->type->size; i++)
      {
        emitln("\t.byte %d", var->init_data[i]);
      }
    }
    else
    {
      emitln("\t.zero %d", var->type->size);
    }
  }
}
static void store_gp(int r, int offset, int sz)
{
  switch (sz)
  {
  case 1:
    emitln("\tmov %s, %d(%%rbp)", argreg8[r], offset);
    return;
  case 2:
    emitln("\tmov %s, %d(%%rbp)", argreg16[r], offset);
    return;
  case 4:
    emitln("\tmov %s, %d(%%rbp)", argreg32[r], offset);
    return;
  case 8:
    emitln("\tmov %s, %d(%%rbp)", argreg64[r], offset);
    return;
  }
  unreachable();
}

static void emit_text(Obj *prog)
{
  for (Obj *fn = prog; fn; fn = fn->next)
  {
    if (!fn->is_function || !fn->is_definition)
      continue;

    emitln(".text");
    emitln(".globl %s", fn->name);
    emitln("%s:", fn->name);
    current_fn = fn;

    // Prologue
    if (fn->stack_size != 0)
    {
      emitln("\tpush %%rbp");
      emitln("\tmov %%rsp, %%rbp");

      emitln("\tsub $%d, %%rsp", fn->stack_size);
    }

    // Save passed-by-register arguments to the stack
    int i = 0;
    for (Obj *var = fn->params; var; var = var->next)
      store_gp(i++, var->offset, var->type->size);

    // Emit code
    gen_stmt(fn->body);
    assert(depth == 0);

    // Epilogue
    emitln(".L.return.%s:", fn->name);
    if (fn->stack_size != 0)
    {
      emitln("\tmov %%rbp, %%rsp");
      emitln("\tpop %%rbp");
    }
    emitln("\tret");
  }
}

void codegen(Obj *prog, FILE *out)
{
  output_file = out;
  assign_lvar_offsets(prog);
  emit_data(prog);
  emit_text(prog);
}
