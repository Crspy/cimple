#include "cimple.h"

// All local variable instances created during parsing are
// accumulated to this list.
Obj *locals;

static Node *expr(const Token **rest, const Token *tok);
static Node *expr_stmt(const Token **rest,const Token *tok);
static Node *assign(const Token **rest,const Token *tok);
static Node *equality(const Token **rest,const Token *tok);
static Node *comparison(const Token **rest,const Token *tok);
static Node *term(const Token **rest,const Token *tok);
static Node *factor(const Token **rest,const Token *tok);
static Node *unary(const Token **rest,const Token *tok);
static Node *primary(const Token **rest,const Token *tok);

// Find a local variable by name.
static Obj *find_var(const Token *tok) {
  for (Obj *var = locals; var; var = var->next)
    if (var->len == tok->len && !strncmp(tok->loc, var->name, tok->len))
      return var;
  return NULL;
}

static Node *new_node(NodeKind kind,Node* lhs,Node* rhs) {
  Node *node = malloc(sizeof(Node));
  node->kind = kind;
  node->next = NULL;
  node->lhs = lhs;
  node->rhs = rhs;
  return node;
}

static Node *new_binary(NodeKind kind, Node *lhs, Node *rhs) {
  Node *node = new_node(kind,lhs,rhs);
  return node;
}

static Node *new_unary(NodeKind kind, Node *expr) {
  Node *node = new_node(kind,expr,NULL);
  return node;
}

static Node *new_num(int val) {
  Node *node = new_node(ND_NUM,NULL,NULL);
  node->val = val;
  return node;
}

static Node *new_var_node(Obj* var) {
  Node *node = new_node(ND_VAR,NULL,NULL);
  node->var = var;
  return node;
}

static Obj *new_lvar(const char *name,int len) {
  Obj *var = malloc(sizeof(Obj));
  var->name = name;
  var->len = len;
  var->next = locals;
  locals = var;
  return var;
}


// stmt = expr-stmt
static Node *stmt(const Token **rest,const Token *tok) {
  return expr_stmt(rest, tok);
}

// expr-stmt = expr ";"
static Node *expr_stmt(const Token **rest,const Token *tok) {
  Node *node = new_unary(ND_EXPR_STMT, expr(&tok, tok));
  *rest = consume(tok, ";");
  return node;
}

// expr = assign
static Node *expr(const Token **rest,const Token *tok) {
  return assign(rest, tok);
}

// assign = equality ("=" assign)?
static Node *assign(const Token **rest, const Token *tok) {
  Node *node = equality(&tok, tok);
  if (equal(tok, "="))
    node = new_binary(ND_ASSIGN, node, assign(&tok, tok->next));
  *rest = tok;
  return node;
}

// equality = comparison ("==" comparison | "!=" comparison)*
static Node *equality(const Token **rest,const Token *tok) {
  Node *node = comparison(&tok, tok);

  for (;;) {
    if (equal(tok, "==")) {
      node = new_binary(ND_EQ, node, comparison(&tok, tok->next));
      continue;
    }

    if (equal(tok, "!=")) {
      node = new_binary(ND_NE, node, comparison(&tok, tok->next));
      continue;
    }

    *rest = tok;
    return node;
  }
}

// comparison = term ("<" term | "<=" term | ">" term | ">=" term)*
static Node *comparison(const Token **rest,const Token *tok) {
  Node *node = term(&tok, tok);

  for (;;) {
    if (equal(tok, "<")) {
      node = new_binary(ND_LT, node, term(&tok, tok->next));
      continue;
    }

    if (equal(tok, "<=")) {
      node = new_binary(ND_LE, node, term(&tok, tok->next));
      continue;
    }

    if (equal(tok, ">")) {
      node = new_binary(ND_LT, term(&tok, tok->next), node);
      continue;
    }

    if (equal(tok, ">=")) {
      node = new_binary(ND_LE, term(&tok, tok->next), node);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// term = factor ("+" factor | "-" factor)*
static Node *term(const Token **rest,const Token *tok) {
  Node *node = factor(&tok, tok);

  for (;;) {
    if (equal(tok, "+")) {
      node = new_binary(ND_ADD, node, factor(&tok, tok->next));
      continue;
    }

    if (equal(tok, "-")) {
      node = new_binary(ND_SUB, node, factor(&tok, tok->next));
      continue;
    }

    *rest = tok;
    return node;
  }
}

// factor = unary ("*" unary | "/" unary)*
static Node *factor(const Token **rest,const Token *tok) {
  Node *node = unary(&tok, tok);

  for (;;) {
    if (equal(tok, "*")) {
      node = new_binary(ND_MUL, node, unary(&tok, tok->next));
      continue;
    }

    if (equal(tok, "/")) {
      node = new_binary(ND_DIV, node, unary(&tok, tok->next));
      continue;
    }

    *rest = tok;
    return node;
  }
}

// unary = ("+" | "-") unary
//       | primary
static Node *unary(const Token **rest,const Token *tok) {
  if (equal(tok, "+"))
    return unary(rest, tok->next);

  if (equal(tok, "-"))
    return new_unary(ND_NEG, unary(rest, tok->next));

  return primary(rest, tok);
}

// primary = "(" expr ")" | identifier | num
static Node *primary(const Token **rest,const Token *tok) {
  if (equal(tok, "(")) {
    Node *node = expr(&tok, tok->next);
    *rest = consume(tok, ")");
    return node;
  }

  if (tok->kind == TK_IDENT) {
    Obj *var = find_var(tok);
    if (!var)
      var = new_lvar(strndup(tok->loc, tok->len),tok->len);
    *rest = tok->next;
    return new_var_node(var);
  }

  if (tok->kind == TK_NUM) {
    Node *node = new_num(tok->val);
    *rest = tok->next;
    return node;
  }

  error_tok(tok, "expected an expression");
  return NULL;
}

// program = stmt*
Function *parse(const Token *tok) {
  Node head = {0};
  Node *cur = &head;
  while (tok->kind != TK_EOF)
  {
    cur = cur->next = stmt(&tok, tok);
  }
  Function* prog = malloc(sizeof(Function));
  prog->body = head.next;
  prog->locals = locals;
  prog->stack_size = 0;
  return prog;
}
