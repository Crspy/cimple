#include "cimple.h"

static Node *expr(const Token **rest, const Token *tok);
static Node *expr_stmt(const Token **rest,const Token *tok);
static Node *assign(const Token **rest,const Token *tok);
static Node *equality(const Token **rest,const Token *tok);
static Node *comparison(const Token **rest,const Token *tok);
static Node *term(const Token **rest,const Token *tok);
static Node *factor(const Token **rest,const Token *tok);
static Node *unary(const Token **rest,const Token *tok);
static Node *primary(const Token **rest,const Token *tok);

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

static Node *new_var_node(char name) {
  Node *node = new_node(ND_VAR,NULL,NULL);
  node->name = name;
  return node;
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
    Node *node = new_var_node(*tok->loc);
    *rest = tok->next;
    return node;
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
Node *parse(const Token *tok) {
  Node head = {0};
  Node *cur = &head;
  while (tok->kind != TK_EOF)
  {
    cur = cur->next = stmt(&tok, tok);
  }
  return head.next;
}
