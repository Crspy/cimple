#include "cimple.h"

// All local variable instances created during parsing are
// accumulated to this list.
Obj *locals;

static Node *declaration(const Token **rest, const Token *tok);
static Node *compound_stmt(const Token **rest, const Token *tok);
static Node *stmt(const Token **rest, const Token *tok);
static Node *expr_stmt(const Token **rest, const Token *tok);
static Node *expr(const Token **rest, const Token *tok);
static Node *assign(const Token **rest, const Token *tok);
static Node *equality(const Token **rest, const Token *tok);
static Node *comparison(const Token **rest, const Token *tok);
static Node *term(const Token **rest, const Token *tok);
static Node *factor(const Token **rest, const Token *tok);
static Node *unary(const Token **rest, const Token *tok);
static Node *primary(const Token **rest, const Token *tok);

// Find a local variable by name.
static Obj *find_var(const Token *tok)
{
  for (Obj *var = locals; var; var = var->next)
    if (var->len == tok->len && !strncmp(tok->loc, var->name, tok->len))
      return var;
  return NULL;
}

static Node *new_node(NodeKind kind, const Token *tok)
{
  Node *node = calloc(1, sizeof(Node)); // Node must be zero initialized
  node->kind = kind;
  node->tok = tok;
  return node;
}

static Node *new_binary(NodeKind kind, Node *lhs, Node *rhs, const Token *tok)
{
  Node *node = new_node(kind, tok);
  node->lhs = lhs;
  node->rhs = rhs;
  return node;
}

static Node *new_unary(NodeKind kind, Node *expr, const Token *tok)
{
  Node *node = new_node(kind, tok);
  node->lhs = expr;
  return node;
}

static Node *new_num(int val, const Token *tok)
{
  Node *node = new_node(ND_NUM, tok);
  node->val = val;
  return node;
}

static Node *new_var_node(Obj *var, const Token *tok)
{
  Node *node = new_node(ND_VAR, tok);
  node->var = var;
  return node;
}

static Obj *new_lvar(Type *type, const char *name, int len)
{
  Obj *var = malloc(sizeof(Obj));
  var->name = name;
  var->len = len;
  var->next = locals;
  var->type = type;
  locals = var;
  return var;
}

static char *get_ident(const Token *tok)
{
  if (tok->kind != TK_IDENT)
    error_tok(tok, "expected an identifier");
  return strndup(tok->loc, tok->len);
}

// declspec = "int"
static Type *declspec(const Token **rest, const Token *tok)
{
  *rest = consume(tok, "int");
  return type_int;
}

// declarator = "*"* ident
static Type *declarator(const Token **rest, const Token *tok, Type *type)
{
  while (match(&tok, tok, "*"))
  {
    type = pointer_to(type);
  }

  if (tok->kind != TK_IDENT)
    error_tok(tok, "expected a variable name");

  type->name = tok;
  *rest = tok->next;
  return type;
}

// declaration = declspec (declarator ("=" expr)? ("," declarator ("=" expr)?)*)? ";"
static Node *declaration(const Token **rest, const Token *tok)
{
  Type *base_type = declspec(&tok, tok);

  Node head = {0};
  Node *cur = &head;
  int i = 0;

  while (!equal(tok, ";"))
  {
    if (i++ > 0)
      tok = consume(tok, ",");

    Type *type = declarator(&tok, tok, base_type);
    Obj *var = new_lvar(type, get_ident(type->name), type->name->len);

    if (!equal(tok, "="))
      continue;

    Node *lhs = new_var_node(var, type->name);
    Node *rhs = assign(&tok, tok->next);
    Node *node = new_binary(ND_ASSIGN, lhs, rhs, tok);
    cur = cur->next = new_unary(ND_EXPR_STMT, node, tok);
  }

  Node *node = new_node(ND_BLOCK, tok);
  node->body = head.next;
  *rest = tok->next;
  return node;
}

// stmt = "return" expr ";"
//      | "if" "(" expr ")" stmt ("else" stmt)?
//      | "for" "(" expr-stmt expr? ";" expr? ")" stmt
//      | "while" "(" expr ")" stmt
//      | "{" compound-stmt
//      | expr-stmt
static Node *stmt(const Token **rest, const Token *tok)
{
  if (equal(tok, "return"))
  {
    Node *node = new_unary(ND_RETURN, expr(&tok, tok->next), tok);
    *rest = consume(tok, ";");
    return node;
  }

  if (equal(tok, "if"))
  {
    Node *node = new_node(ND_IF, tok);
    tok = consume(tok->next, "(");
    node->cond_expr = expr(&tok, tok);
    tok = consume(tok, ")");
    node->then_stmt = stmt(&tok, tok);
    if (equal(tok, "else"))
      node->else_stmt = stmt(&tok, tok->next);
    else
      node->else_stmt = NULL;

    *rest = tok;
    return node;
  }
  if (equal(tok, "for"))
  {
    Node *node = new_node(ND_FOR, tok);
    tok = consume(tok->next, "(");

    node->init_expr = expr_stmt(&tok, tok);

    if (!equal(tok, ";"))
      node->cond_expr = expr(&tok, tok);
    tok = consume(tok, ";");

    if (!equal(tok, ")"))
      node->inc_expr = expr(&tok, tok);
    tok = consume(tok, ")");

    node->then_stmt = stmt(rest, tok);
    return node;
  }
  if (equal(tok, "while"))
  {
    Node *node = new_node(ND_FOR, tok);
    tok = consume(tok->next, "(");
    node->cond_expr = expr(&tok, tok);
    tok = consume(tok, ")");
    node->then_stmt = stmt(rest, tok);
    return node;
  }

  if (equal(tok, "{"))
  {
    return compound_stmt(rest, tok->next);
  }

  return expr_stmt(rest, tok);
}

// compound-stmt = stmt* "}"
static Node *compound_stmt(const Token **rest, const Token *tok)
{
  Node head = {0};
  Node *cur = &head;
  while (!equal(tok, "}"))
  {
    if (equal(tok, "int"))
    {
      cur = cur->next = declaration(&tok, tok);
    }
    else
    {
      cur = cur->next = stmt(&tok, tok);
    }
    add_type(cur);
  }

  Node *node = new_node(ND_BLOCK, tok);
  node->body = head.next;
  *rest = tok->next;
  return node;
}

// expr-stmt = expr? ";"
static Node *expr_stmt(const Token **rest, const Token *tok)
{
  if (equal(tok, ";"))
  {
    // empty expression
    *rest = tok->next;
    return new_node(ND_BLOCK, tok);
  }
  Node *node = new_node(ND_EXPR_STMT, tok);
  node->lhs = expr(&tok, tok);
  *rest = consume(tok, ";");
  return node;
}

// expr = assign
static Node *expr(const Token **rest, const Token *tok)
{
  return assign(rest, tok);
}

// assign = equality ("=" assign)?
static Node *assign(const Token **rest, const Token *tok)
{
  Node *node = equality(&tok, tok);
  if (equal(tok, "="))
    return new_binary(ND_ASSIGN, node, assign(rest, tok->next), tok);
  *rest = tok;
  return node;
}

// equality = comparison ("==" comparison | "!=" comparison)*
static Node *equality(const Token **rest, const Token *tok)
{
  Node *node = comparison(&tok, tok);

  for (;;)
  {
    const Token *start = tok;
    if (equal(tok, "=="))
    {
      node = new_binary(ND_EQ, node, comparison(&tok, tok->next), start);
      continue;
    }

    if (equal(tok, "!="))
    {
      node = new_binary(ND_NE, node, comparison(&tok, tok->next), start);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// comparison = term ("<" term | "<=" term | ">" term | ">=" term)*
static Node *comparison(const Token **rest, const Token *tok)
{
  Node *node = term(&tok, tok);

  for (;;)
  {
    const Token *start = tok;
    if (equal(tok, "<"))
    {
      node = new_binary(ND_LT, node, term(&tok, tok->next), start);
      continue;
    }

    if (equal(tok, "<="))
    {
      node = new_binary(ND_LE, node, term(&tok, tok->next), start);
      continue;
    }

    if (equal(tok, ">"))
    {
      node = new_binary(ND_LT, term(&tok, tok->next), node, start);
      continue;
    }

    if (equal(tok, ">="))
    {
      node = new_binary(ND_LE, term(&tok, tok->next), node, start);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// In C, `+` operator is overloaded to perform the pointer arithmetic.
// If p is a pointer, p+n adds not n but sizeof(*p)*n to the value of p,
// so that p+n points to the location n elements (not bytes) ahead of p.
// In other words, we need to scale an integer value before adding to a
// pointer value. This function takes care of the scaling.
static Node *new_add(Node *lhs, Node *rhs, const Token *tok)
{
  add_type(lhs);
  add_type(rhs);

  // num + num
  if (is_integer(lhs->type) && is_integer(rhs->type))
    return new_binary(ND_ADD, lhs, rhs, tok);

  if (lhs->type->base && rhs->type->base)
    error_tok(tok, "invalid operands");

  // Canonicalize `num + ptr` to `ptr + num`.
  if (!lhs->type->base && rhs->type->base)
  {
    Node *tmp = lhs;
    lhs = rhs;
    rhs = tmp;
  }

  // ptr + num
  rhs = new_binary(ND_MUL, rhs, new_num(8, tok), tok); // TODO: make this a right left (<<) by n instead
  return new_binary(ND_ADD, lhs, rhs, tok);
}

// Like `+`, `-` is overloaded for the pointer type.
static Node *new_sub(Node *lhs, Node *rhs, const Token *tok)
{
  add_type(lhs);
  add_type(rhs);

  // num - num
  if (is_integer(lhs->type) && is_integer(rhs->type))
    return new_binary(ND_SUB, lhs, rhs, tok);

  // ptr - num
  if (lhs->type->base && is_integer(rhs->type))
  {
    rhs = new_binary(ND_MUL, rhs, new_num(8, tok), tok); // TODO: make this a right left (<<) by n instead
    add_type(rhs);
    Node *node = new_binary(ND_SUB, lhs, rhs, tok);
    node->type = lhs->type;
    return node;
  }

  // ptr - ptr, which returns how many elements are between the two.
  if (lhs->type->base && rhs->type->base)
  {
    Node *node = new_binary(ND_SUB, lhs, rhs, tok);
    node->type = type_int;

    // TODO: make this a right shift (>>) by n instead
    return new_binary(ND_DIV, node, new_num(8, tok), tok);
  }

  error_tok(tok, "invalid operands");
  return NULL; // unreachable
}

// term = factor ("+" factor | "-" factor)*
static Node *term(const Token **rest, const Token *tok)
{
  Node *node = factor(&tok, tok);

  for (;;)
  {
    const Token *start = tok;

    if (equal(tok, "+"))
    {
      node = new_add(node, factor(&tok, tok->next), start);
      continue;
    }

    if (equal(tok, "-"))
    {
      node = new_sub(node, factor(&tok, tok->next), start);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// factor = unary ("*" unary | "/" unary)*
static Node *factor(const Token **rest, const Token *tok)
{
  Node *node = unary(&tok, tok);

  for (;;)
  {
    const Token *start = tok;
    if (equal(tok, "*"))
    {
      node = new_binary(ND_MUL, node, unary(&tok, tok->next), start);
      continue;
    }

    if (equal(tok, "/"))
    {
      node = new_binary(ND_DIV, node, unary(&tok, tok->next), start);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// unary = ("+" | "-" | "*" | "&") unary
//       | primary
static Node *unary(const Token **rest, const Token *tok)
{
  if (equal(tok, "+"))
    return unary(rest, tok->next);

  if (equal(tok, "-"))
    return new_unary(ND_NEG, unary(rest, tok->next), tok);
  if (equal(tok, "&"))
    return new_unary(ND_ADDR, unary(rest, tok->next), tok);
  if (equal(tok, "*"))
    return new_unary(ND_DEREF, unary(rest, tok->next), tok);

  return primary(rest, tok);
}

// primary = "(" expr ")" | identifier | num
static Node *primary(const Token **rest, const Token *tok)
{
  if (equal(tok, "("))
  {
    Node *node = expr(&tok, tok->next);
    *rest = consume(tok, ")");
    return node;
  }

  if (tok->kind == TK_IDENT)
  {
    Obj *var = find_var(tok);
    if (!var)
    {
      error_tok(tok, "undefined variable");
    }
    *rest = tok->next;
    return new_var_node(var, tok);
  }

  if (tok->kind == TK_NUM)
  {
    Node *node = new_num(tok->val, tok);
    *rest = tok->next;
    return node;
  }

  error_tok(tok, "expected an expression");
  return NULL;
}

// program = stmt*
Function *parse(const Token *tok)
{
  tok = consume(tok, "{");
  Function *prog = malloc(sizeof(Function));
  prog->body = compound_stmt(&tok, tok);
  prog->locals = locals;
  prog->stack_size = 0;
  return prog;
}
