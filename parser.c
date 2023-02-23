#include "ast_node.h"
#include "cimple.h"

// All local variable instances created during parsing are
// accumulated to this list.
static Obj *locals;
static Obj *globals;

static Type *declspec(const Token **rest, const Token *tok);
static Type *declarator(const Token **rest, const Token *tok, Type *type);
static BlockNode *declaration(const Token **rest, const Token *tok);
static BlockNode *compound_stmt(const Token **rest, const Token *tok);
static Node *stmt(const Token **rest, const Token *tok);
static Node *expr_stmt(const Token **rest, const Token *tok);
static Node *expr(const Token **rest, const Token *tok);
static Node *assign(const Token **rest, const Token *tok);
static Node *equality(const Token **rest, const Token *tok);
static Node *comparison(const Token **rest, const Token *tok);
static Node *term(const Token **rest, const Token *tok);
static Node *factor(const Token **rest, const Token *tok);
static Node *postfix(const Token **rest, const Token *tok);
static Node *unary(const Token **rest, const Token *tok);
static Node *primary(const Token **rest, const Token *tok);

// Find a variable by name.
static Obj *find_var(const Token *tok) {
  for (Obj *var = locals; var; var = var->next)
    if (var->name_length == tok->len && !strncmp(tok->loc, var->name, tok->len))
      return var;

  for (Obj *var = globals; var; var = var->next)
    if (strlen(var->name) == tok->len &&
        !strncmp(tok->loc, var->name, tok->len))
      return var;

  return NULL;
}

static Obj *new_var(Type *type, const char *name, int len) {
  Obj *var = calloc(1, sizeof(Obj));
  var->name = name;
  var->name_length = len;
  var->type = type;
  return var;
}

static Obj *new_lvar(Type *type, const char *name, int name_len) {
  Obj *var = new_var(type, name, name_len);
  var->is_local = true;
  var->next = locals;
  locals = var;
  return var;
}
static Obj *new_gvar(Type *type, const char *name, int name_len) {
  Obj *var = new_var(type, name, name_len);
  var->next = globals;
  globals = var;
  return var;
}

static char *new_unique_name() {
  static int id = 0;
  return format(".L..%d", id++);
}

static Obj *new_anon_gvar(Type *type) {
  char *unique_name = new_unique_name();
  return new_gvar(type, unique_name, strlen(unique_name));
}
static Obj *new_string_literal(char *str, Type *type) {
  Obj *var = new_anon_gvar(type);
  var->init_data = str;
  return var;
}

static const char *get_ident(const Token *tok) {
  if (tok->kind != TOKEN_IDENT) {
    error_tok(tok, "expected an identifier");
  }
  return strndup(tok->loc, tok->len);
}

static int get_number(const Token *tok) {
  if (tok->kind != TOKEN_NUM) {
    error_tok(tok, "expected a number");
  }
  return tok->val;
}

// declspec = "char" | "int"
static Type *declspec(const Token **rest, const Token *tok) {
  if (match(rest, tok, TOKEN_CHAR)) {
    return char_type();
  }
  *rest = consume(tok, TOKEN_INT);
  return int_type();
}

// func-params = (param ("," param)*)? ")"
// param       = declspec declarator
static Type *func_params(const Token **rest, const Token *tok,
                         Type *return_type) {
  Type head = {0};
  Type *cur = &head;

  while (!check(tok, TOKEN_RIGHT_PAREN)) {
    if (cur != &head) {
      tok = consume(tok, TOKEN_COMMA);
    }

    Type *base_type = declspec(&tok, tok);
    Type *type = declarator(&tok, tok, base_type);
    cur = cur->next = type;
  }

  Type *type = func_type(return_type);
  type->params = head.next;
  *rest = tok->next;
  return type;
}

// type-suffix = "(" func-params
//             | "[" num "]" type-suffix
//             | ε
static Type *type_suffix(const Token **rest, const Token *tok, Type *type) {
  if (check(tok, TOKEN_LEFT_PAREN))
    return func_params(rest, tok->next, type);

  if (check(tok, TOKEN_LEFT_BRACKET)) {
    int array_count = get_number(tok->next);
    tok = consume(tok->next->next, TOKEN_RIGHT_BRACKET);
    type = type_suffix(rest, tok, type);
    return array_of(type, array_count);
  }

  *rest = tok;
  return type;
}

// declarator = "*"* ident type-suffix
static Type *declarator(const Token **rest, const Token *tok, Type *type) {
  while (match(&tok, tok, TOKEN_STAR)) {
    type = pointer_to(type);
  }

  if (tok->kind != TOKEN_IDENT)
    error_tok(tok, "expected a variable name");

  type = type_suffix(rest, tok->next, type);
  type->name = tok;
  return type;
}

// declaration = declspec (declarator ("=" expr)? ("," declarator ("="
// expr)?)*)? ";"
static BlockNode *declaration(const Token **rest, const Token *tok) {
  Type *base_type = declspec(&tok, tok);

  Node head = {0};
  Node *cur = &head;
  int i = 0;

  while (!check(tok, TOKEN_SEMICOLON)) {
    if (i++ > 0)
      tok = consume(tok, TOKEN_COMMA);

    Type *type = declarator(&tok, tok, base_type);
    Obj *var = new_lvar(type, get_ident(type->name), type->name->len);

    if (!check(tok, TOKEN_EQUAL))
      continue;

    Node *lhs = new_var_node(var, type->name);
    Node *rhs = assign(&tok, tok->next);
    Node *node = new_binary_node(NODE_ASSIGN, lhs, rhs, tok);
    cur = cur->next = new_unary_node(NODE_EXPR_STMT, node, tok);
  }

  BlockNode *node = new_block_node(head.next, tok);
  *rest = tok->next;
  return node;
}

// Returns true if a given token represents a type.
static bool is_typename(const Token *tok) {
  return check(tok, TOKEN_CHAR) || check(tok, TOKEN_INT);
}

// stmt = "return" expr ";"
//      | "if" "(" expr ")" stmt ("else" stmt)?
//      | "for" "(" expr-stmt expr? ";" expr? ")" stmt
//      | "while" "(" expr ")" stmt
//      | "{" compound-stmt
//      | expr-stmt
static Node *stmt(const Token **rest, const Token *tok) {
  if (check(tok, TOKEN_RETURN)) {
    Node *node = new_unary_node(NODE_RETURN, expr(&tok, tok->next), tok);
    *rest = consume(tok, TOKEN_SEMICOLON);
    return node;
  }

  if (check(tok, TOKEN_IF)) {
    const Token *start = tok;
    tok = consume(tok->next, TOKEN_LEFT_PAREN);
    Node *cond_expr = expr(&tok, tok);
    tok = consume(tok, TOKEN_RIGHT_PAREN);
    Node *then_stmt = stmt(&tok, tok);
    Node *else_stmt;
    if (check(tok, TOKEN_ELSE)) {
      else_stmt = stmt(&tok, tok->next);
    } else {
      else_stmt = NULL;
    }

    Node *node = new_if_node(cond_expr, then_stmt, else_stmt, start);

    *rest = tok;
    return node;
  }
  if (check(tok, TOKEN_FOR)) {
    const Token *start = tok;

    tok = consume(tok->next, TOKEN_LEFT_PAREN);

    Node *init_expr = expr_stmt(&tok, tok);
    Node *cond_expr;
    if (!check(tok, TOKEN_SEMICOLON))
      cond_expr = expr(&tok, tok);
    else
      cond_expr = NULL;

    tok = consume(tok, TOKEN_SEMICOLON);

    Node *inc_expr;
    if (!check(tok, TOKEN_RIGHT_PAREN))
      inc_expr = expr(&tok, tok);
    else
      inc_expr = NULL;
    tok = consume(tok, TOKEN_RIGHT_PAREN);

    Node *body_stmt = stmt(rest, tok);

    Node *node = new_for_node(init_expr, cond_expr, inc_expr, body_stmt, start);
    return node;
  }
  if (check(tok, TOKEN_WHILE)) {
    const Token *start = tok;

    tok = consume(tok->next, TOKEN_LEFT_PAREN);
    Node *cond_expr = expr(&tok, tok);
    tok = consume(tok, TOKEN_RIGHT_PAREN);
    Node *body_stmt = stmt(rest, tok);

    Node *node = new_for_node(NULL, cond_expr, NULL, body_stmt, start);
    return node;
  }

  if (check(tok, TOKEN_LEFT_BRACE)) {
    return (Node *)compound_stmt(rest, tok->next);
  }

  return expr_stmt(rest, tok);
}

// compound-stmt = (declaration | stmt)* "}"
static BlockNode *compound_stmt(const Token **rest, const Token *tok) {
  Node head = {0};
  Node *cur = &head;
  while (!check(tok, TOKEN_RIGHT_BRACE)) {
    if (is_typename(tok)) {
      cur = cur->next = (Node *)declaration(&tok, tok);
    } else {
      cur = cur->next = stmt(&tok, tok);
    }
    add_type(cur);
  }

  BlockNode *node = new_block_node(head.next, tok);
  *rest = tok->next;
  return node;
}

// expr-stmt = expr? ";"
static Node *expr_stmt(const Token **rest, const Token *tok) {
  if (match(rest, tok, TOKEN_SEMICOLON)) {
    // empty expression
    return (Node *)new_block_node(NULL, tok);
  }
  const Token *start = tok;

  Node *node = expr(&tok, tok);
  node = new_unary_node(NODE_EXPR_STMT, node, start);
  *rest = consume(tok, TOKEN_SEMICOLON);
  return node;
}

// expr = assign
static Node *expr(const Token **rest, const Token *tok) {
  return assign(rest, tok);
}

// assign = equality ("=" assign)?
static Node *assign(const Token **rest, const Token *tok) {
  Node *node = equality(&tok, tok);
  if (check(tok, TOKEN_EQUAL))
    return new_binary_node(NODE_ASSIGN, node, assign(rest, tok->next), tok);
  *rest = tok;
  return node;
}

// equality = comparison ("==" comparison | "!=" comparison)*
static Node *equality(const Token **rest, const Token *tok) {
  Node *node = comparison(&tok, tok);

  for (;;) {
    const Token *start = tok;
    if (check(tok, TOKEN_EQUAL_EQUAL)) {
      node = new_binary_node(NODE_EQ, node, comparison(&tok, tok->next), start);
      continue;
    }

    if (check(tok, TOKEN_BANG_EQUAL)) {
      node = new_binary_node(NODE_NE, node, comparison(&tok, tok->next), start);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// comparison = term ("<" term | "<=" term | ">" term | ">=" term)*
static Node *comparison(const Token **rest, const Token *tok) {
  Node *node = term(&tok, tok);

  for (;;) {
    const Token *start = tok;
    if (check(tok, TOKEN_LESS)) {
      node = new_binary_node(NODE_LT, node, term(&tok, tok->next), start);
      continue;
    }

    if (check(tok, TOKEN_LESS_EQUAL)) {
      node = new_binary_node(NODE_LE, node, term(&tok, tok->next), start);
      continue;
    }

    if (check(tok, TOKEN_GREATER)) {
      node = new_binary_node(NODE_LT, term(&tok, tok->next), node, start);
      continue;
    }

    if (check(tok, TOKEN_GREATER_EQUAL)) {
      node = new_binary_node(NODE_LE, term(&tok, tok->next), node, start);
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
static Node *new_add(Node *lhs, Node *rhs, const Token *tok) {
  add_type(lhs);
  add_type(rhs);

  // num + num
  if (is_integer(lhs->type) && is_integer(rhs->type))
    return new_binary_node(NODE_ADD, lhs, rhs, tok);

  if (lhs->type->base && rhs->type->base)
    error_tok(tok, "invalid operands");

  // Canonicalize `num + ptr` to `ptr + num`.
  if (!lhs->type->base && rhs->type->base) {
    Node *tmp = lhs;
    lhs = rhs;
    rhs = tmp;
  }

  // ptr + num
  rhs = new_binary_node(NODE_MUL, rhs, new_num_node(lhs->type->base->size, tok),
                        tok); // TODO: make this a right left (<<) by n instead
  return new_binary_node(NODE_ADD, lhs, rhs, tok);
}

// Like `+`, `-` is overloaded for the pointer type.
static Node *new_sub(Node *lhs, Node *rhs, const Token *tok) {
  add_type(lhs);
  add_type(rhs);

  // num - num
  if (is_integer(lhs->type) && is_integer(rhs->type))
    return new_binary_node(NODE_SUB, lhs, rhs, tok);

  // ptr - num
  if (lhs->type->base && is_integer(rhs->type)) {
    rhs =
        new_binary_node(NODE_MUL, rhs, new_num_node(lhs->type->base->size, tok),
                        tok); // TODO: make this a right left (<<) by n instead
    add_type(rhs);
    Node *node = new_binary_node(NODE_SUB, lhs, rhs, tok);
    node->type = lhs->type;
    return node;
  }

  // ptr - ptr, which returns how many elements are between the two.
  if (lhs->type->base && rhs->type->base) {
    Node *node = new_binary_node(NODE_SUB, lhs, rhs, tok);
    node->type = int_type();

    // TODO: make this a right shift (>>) by n instead
    return new_binary_node(NODE_DIV, node,
                           new_num_node(lhs->type->base->size, tok), tok);
  }

  error_tok(tok, "invalid operands");
  return NULL; // unreachable
}

// term = factor ("+" factor | "-" factor)*
static Node *term(const Token **rest, const Token *tok) {
  Node *node = factor(&tok, tok);

  for (;;) {
    const Token *start = tok;

    if (check(tok, TOKEN_PLUS)) {
      node = new_add(node, factor(&tok, tok->next), start);
      continue;
    }

    if (check(tok, TOKEN_MINUS)) {
      node = new_sub(node, factor(&tok, tok->next), start);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// factor = unary ("*" unary | "/" unary)*
static Node *factor(const Token **rest, const Token *tok) {
  Node *node = unary(&tok, tok);

  for (;;) {
    const Token *start = tok;
    if (check(tok, TOKEN_STAR)) {
      node = new_binary_node(NODE_MUL, node, unary(&tok, tok->next), start);
      continue;
    }

    if (check(tok, TOKEN_SLASH)) {
      node = new_binary_node(NODE_DIV, node, unary(&tok, tok->next), start);
      continue;
    }

    *rest = tok;
    return node;
  }
}

// unary = ("+" | "-" | "*" | "&") unary
//       | postfix
static Node *unary(const Token **rest, const Token *tok) {
  if (check(tok, TOKEN_PLUS))
    return unary(rest, tok->next);

  if (check(tok, TOKEN_MINUS))
    return new_unary_node(NODE_NEG, unary(rest, tok->next), tok);
  if (check(tok, TOKEN_AMPERSAND))
    return new_unary_node(NODE_ADDR, unary(rest, tok->next), tok);
  if (check(tok, TOKEN_STAR))
    return new_unary_node(NODE_DEREF, unary(rest, tok->next), tok);

  return postfix(rest, tok);
}

// postfix = primary ("[" expr "]")*
static Node *postfix(const Token **rest, const Token *tok) {
  Node *node = primary(&tok, tok);

  while (check(tok, TOKEN_LEFT_BRACKET)) {
    // x[y] is short for *(x+y)
    const Token *start = tok;
    Node *idx = expr(&tok, tok->next);
    tok = consume(tok, TOKEN_RIGHT_BRACKET);
    node = new_unary_node(NODE_DEREF, new_add(node, idx, start), start);
  }
  *rest = tok;
  return node;
}

// funcall = ident "(" (assign ("," assign)*)? ")"
static Node *funcall(const Token **rest, const Token *tok) {
  const Token *start = tok;
  tok = tok->next->next;

  Node head = {0};
  Node *cur = &head;

  while (!check(tok, TOKEN_RIGHT_PAREN)) {
    if (cur != &head)
      tok = consume(tok, TOKEN_COMMA);
    cur = cur->next = assign(&tok, tok);
  }

  *rest = consume(tok, TOKEN_RIGHT_PAREN);

  Node *node = new_fun_call_node(strndup(start->loc, start->len), start->len,
                                 head.next, start);
  // node->funcname = strndup(start->loc, start->len);
  // node->funcname_length = start->len;
  // node->args = head.next;
  return node;
}

// primary = "(" "{" stmt+ "}" ")"
//         | "(" expr ")"
//         | "sizeof" unary
//         | ident func-args?
//         | str
//         | num
static Node *primary(const Token **rest, const Token *tok) {
  if (check(tok, TOKEN_LEFT_PAREN) && check(tok->next, TOKEN_LEFT_BRACE)) {
    // This is a GNU statement expresssion.
    const Token *start = tok;

    BlockNode *block_node = compound_stmt(&tok, tok->next->next);
    *rest = consume(tok, TOKEN_RIGHT_PAREN);
    return new_unary_node(NODE_STMT_EXPR, block_node->body, start);
    ;
  }
  if (check(tok, TOKEN_LEFT_PAREN)) {
    Node *node = expr(&tok, tok->next);
    *rest = consume(tok, TOKEN_RIGHT_PAREN);
    return node;
  }

  if (check(tok, TOKEN_SIZEOF)) {
    Node *node = unary(rest, tok->next);
    add_type(node);
    return new_num_node(node->type->size, tok);
  }

  if (check(tok, TOKEN_IDENT)) {
    // Function call
    if (check(tok->next, TOKEN_LEFT_PAREN)) {
      return funcall(rest, tok);
    }

    Obj *var = find_var(tok);
    if (!var) {
      error_tok(tok, "undefined variable");
    }
    *rest = tok->next;
    return new_var_node(var, tok);
  }

  if (check(tok, TOKEN_STR)) {
    Obj *var = new_string_literal(tok->str, tok->type);
    *rest = tok->next;
    return new_var_node(var, tok);
  }

  if (check(tok, TOKEN_NUM)) {
    Node *node = new_num_node(tok->val, tok);
    *rest = tok->next;
    return node;
  }

  error_tok(tok, "expected an expression");
  return NULL;
}

static void create_param_lvars(Type *param) {
  if (param) {
    create_param_lvars(param->next);
    new_lvar(param, get_ident(param->name), param->name->len);
  }
}

static const Token *function(const Token *tok, Type *base_type) {
  Type *type = declarator(&tok, tok, base_type);

  Obj *fn = new_gvar(type, get_ident(type->name), type->name->len);
  fn->is_function = true;

  locals = NULL;
  create_param_lvars(type->params);
  fn->params = locals;

  tok = consume(tok, TOKEN_LEFT_BRACE);
  fn->body = (Node *)compound_stmt(&tok, tok);
  fn->locals = locals;
  return tok;
}

static const Token *global_variable(const Token *tok, Type *base_type) {
  bool first = true;

  while (!match(&tok, tok, TOKEN_SEMICOLON)) {
    if (!first) {
      tok = consume(tok, TOKEN_COMMA);
    }

    first = false;

    Type *type = declarator(&tok, tok, base_type);
    new_gvar(type, get_ident(type->name), type->name->len);
  }
  return tok;
}

// Lookahead tokens and returns true if a given token
// is a start of a function definition or declaration
static bool is_function(const Token *tok) {
  if (check(tok, TOKEN_SEMICOLON)) {
    return false;
  }

  Type dummy = {0};
  Type *type = declarator(&tok, tok, &dummy);
  return type->kind == TYPE_FUNC;
}

// program = (function-definition | global-variable)*
Obj *parse(const Token *tok) {
  globals = NULL;

  while (!check(tok, TOKEN_EOF)) {
    Type *base_type = declspec(&tok, tok);

    // Function
    if (is_function(tok)) {
      tok = function(tok, base_type);
      continue;
    }

    // Global variable
    tok = global_variable(tok, base_type);
  }
  return globals;
}
