#include "ast_node.h"
#include "cimple.h"
#include "tokenizer.h"
#include "type.h"

// Scope for struct or union tags
typedef struct TagScope TagScope;
struct TagScope {
  TagScope *next;
  const Token *name;
  Type *type;
};

// Scope for local, global variables or typedefs
typedef struct VarScope VarScope;
struct VarScope {
  VarScope *next;
  char *name;
  size_t name_len;
  const Obj *var;
  Type *type_def;
};

// Represents a block scope.
typedef struct Scope Scope;
struct Scope {
  Scope *next;

  // C has two block scopes; one is for variables and the other is
  // for struct tags.
  VarScope *vars;
  TagScope *tags;
};

// Variable attributes such as typedef or extern.
typedef struct {
  bool is_typedef;
} VarAttr;

static Scope global_scope = {NULL};
static Scope *scopes = &global_scope;

// All local variable instances created during parsing are
// accumulated to this list.
static Obj *locals;
// Likewise, global variables are accumulated to this list.
static Obj *globals;

static bool is_typename(const Token *tok);
static Type *struct_decl(const Token **rest, const Token *tok);
static Type *union_decl(const Token **rest, const Token *tok);
static Type *declspec(const Token **rest, const Token *tok, VarAttr *attr);
static Type *declarator(const Token **rest, const Token *tok, Type *type);
static BlockNode *declaration(const Token **rest, const Token *tok,
                              Type *base_type);
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
static const Token *parse_typedef(const Token *tok, Type *base_type);

static void enter_scope(void) {
  Scope *sc = calloc(1, sizeof(Scope));
  sc->next = scopes;
  scopes = sc;
}

static void free_scope(Scope *scope) {
  // free Var scopes
  VarScope *var_scope = scope->vars;
  while (var_scope) {
    VarScope *dead_var_scope = var_scope;
    var_scope = var_scope->next;
    free(dead_var_scope);
  }
  // free tag scopes
  TagScope *tag_scope = scope->tags;
  while (tag_scope) {
    TagScope *dead_var_scope = tag_scope;
    tag_scope = tag_scope->next;
    free(dead_var_scope);
  }
  free(scope);
}

static void leave_scope(void) {
  Scope *dead_scope = scopes;
  scopes = scopes->next;
  free_scope(dead_scope);
}

// Find a variable by name.
static VarScope *find_var(const Token *tok) {
  for (Scope *sc = scopes; sc; sc = sc->next) {
    for (VarScope *vsc = sc->vars; vsc; vsc = vsc->next) {
      if (equal(tok, vsc->name, vsc->name_len))
        return vsc;
    }
  }
  return NULL;
}

static Type *find_tag(const Token *tok) {
  for (Scope *sc = scopes; sc; sc = sc->next)
    for (TagScope *tag_sc = sc->tags; tag_sc; tag_sc = tag_sc->next)
      if (tok->len == tag_sc->name->len &&
          strncmp(tok->loc, tag_sc->name->loc, tok->len) == 0)
        return tag_sc->type;
  return NULL;
}

static void push_tag_scope(const Token *tok, Type *type) {
  TagScope *sc = calloc(1, sizeof(TagScope));
  sc->name = tok;
  sc->type = type;
  sc->next = scopes->tags;
  scopes->tags = sc;
}

static VarScope *push_scope(char *name, size_t name_len) {
  VarScope *sc = calloc(1, sizeof(VarScope));
  sc->name = name;
  sc->name_len = name_len;
  sc->next = scopes->vars;
  scopes->vars = sc;
  return sc;
}

static Obj *new_var(Type *type, char *name, size_t len) {
  Obj *var = calloc(1, sizeof(Obj));
  var->name = name;
  var->name_length = len;
  var->type = type;
  push_scope(name, len)->var = var;
  return var;
}

static Obj *new_lvar(Type *type, char *name, size_t name_len) {
  Obj *var = new_var(type, name, name_len);
  var->is_local = true;
  var->next = locals;
  locals = var;
  return var;
}
static Obj *new_gvar(Type *type, char *name, size_t name_len) {
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

static char *get_ident(const Token *tok) {
  if (tok->kind != TOKEN_IDENT) {
    error_tok(tok, "expected an identifier");
  }
  return strndup(tok->loc, tok->len);
}

static Type *find_typedef(const Token *tok) {
  if (check(tok, TOKEN_IDENT)) {
    VarScope *sc = find_var(tok);
    if (sc)
      return sc->type_def;
  }
  return NULL;
}

static int64_t get_number(const Token *tok) {
  if (tok->kind != TOKEN_NUM) {
    error_tok(tok, "expected a number");
  }
  return tok->val;
}

// declspec = ("void" | "char" | "short" | "int" | "long"
//             | "typedef"
//             | struct-decl | union-decl | typedef-name)+
//
// The order of typenames in a type-specifier doesn't matter. For
// example, `int long static` means the same as `static long int`.
// That can also be written as `static long` because you can omit
// `int` if `long` or `short` are specified. However, something like
// `char int` is not a valid type specifier. We have to accept only a
// limited combinations of the typenames.
//
// In this function, we count the number of occurrences of each typename
// while keeping the "current" type object that the typenames up
// until that point represent. When we reach a non-typename token,
// we returns the current type object.
static Type *declspec(const Token **rest, const Token *tok, VarAttr *attr) {
  // We use a single integer as counters for all typenames.
  // For example, bits 0 and 1 represents how many times we saw the
  // keyword "void" so far. With this, we can use a switch statement
  // as you can see below.
  enum {
    VOID = 1 << 0,
    CHAR = 1 << 2,
    SHORT = 1 << 4,
    INT = 1 << 6,
    LONG = 1 << 8,
    OTHER = 1 << 10,
  };

  Type *type = int_type();
  int counter = 0;

  while (is_typename(tok)) {

    // Handle "typedef" keyword
    if (check(tok, TOKEN_TYPEDEF)) {
      if (!attr) {
        error_tok(tok,
                  "storage class specifier is not allowed in this context");
      }
      attr->is_typedef = true;
      tok = tok->next;
      continue;
    }

    // Handle user-defined types.
    Type *type_def = find_typedef(tok);
    if (check(tok, TOKEN_STRUCT) || check(tok, TOKEN_UNION) || type_def) {

      if (counter != 0)
        break;

      if (check(tok, TOKEN_STRUCT)) {
        type = struct_decl(&tok, tok->next);
      } else if (check(tok, TOKEN_UNION)) {
        type = union_decl(&tok, tok->next);
      } else { // if(type_def)
        type = type_def;
        tok = tok->next;
      }

      counter += OTHER;
      continue;
    }

    // Handle built-in types.
    switch (tok->kind) {
    case TOKEN_VOID:
      counter += VOID;
      break;
    case TOKEN_CHAR:
      counter += CHAR;
      break;
    case TOKEN_SHORT:
      counter += SHORT;
      break;
    case TOKEN_INT:
      counter += INT;
      break;
    case TOKEN_LONG:
      counter += LONG;
      break;
    default:
      unreachable();
    }

    switch (counter) {
    case VOID:
      type = void_type();
      break;
    case CHAR:
      type = char_type();
      break;
    case SHORT:
    case SHORT + INT:
      type = short_type();
      break;
    case INT:
      type = int_type();
      break;
    case LONG:
    case LONG + INT:
    case LONG + LONG:
      type = long_type();
      break;
    default:
      error_tok(tok, "invalid type");
    }

    tok = tok->next;
  }

  *rest = tok;
  return type;
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

    Type *base_type = declspec(&tok, tok, NULL);
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
  if (match(&tok, tok, TOKEN_LEFT_PAREN))
    return func_params(rest, tok, type);

  if (match(&tok, tok, TOKEN_LEFT_BRACKET)) {
    int array_count = get_number(tok);
    tok = consume(tok, TOKEN_NUM);
    tok = consume(tok, TOKEN_RIGHT_BRACKET);
    type = type_suffix(rest, tok, type);
    return array_of(type, array_count);
  }

  *rest = tok;
  return type;
}

// declarator = "*"* ( ident | "(" ident ")" | "(" declarator ")" ) type-suffix
static Type *declarator(const Token **rest, const Token *tok, Type *type) {
  while (match(&tok, tok, TOKEN_STAR)) {
    type = pointer_to(type);
  }

  if (match(&tok, tok, TOKEN_LEFT_PAREN)) {
    const Token *start = tok;
    Type dummy = {0};
    declarator(&tok, start, &dummy);
    tok = consume(tok, TOKEN_RIGHT_PAREN);
    type = type_suffix(rest, tok, type);
    return declarator(&tok, start, type);
  }

  if (tok->kind != TOKEN_IDENT)
    error_tok(tok, "expected a variable name");

  type = type_suffix(rest, tok->next, type);
  type->name = tok;
  return type;
}

// declaration = declspec (declarator ("=" expr)? ("," declarator ("="
// expr)?)*)? ";"
static BlockNode *declaration(const Token **rest, const Token *tok,
                              Type *base_type) {

  Node head = {0};
  Node *cur = &head;
  int i = 0;

  while (!check(tok, TOKEN_SEMICOLON)) {
    if (i++ > 0)
      tok = consume(tok, TOKEN_COMMA);

    Type *type = declarator(&tok, tok, base_type);
    if (type->kind == TYPE_VOID) {
      error_tok(tok, "variable declared void");
    }
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
  switch (tok->kind) {
  case TOKEN_VOID:
  case TOKEN_CHAR:
  case TOKEN_SHORT:
  case TOKEN_INT:
  case TOKEN_LONG:
  case TOKEN_STRUCT:
  case TOKEN_UNION:
  case TOKEN_TYPEDEF:
    return true;
  default:
    return find_typedef(tok) != NULL;
  }
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

  if (match(&tok, tok, TOKEN_LEFT_BRACE)) {
    return (Node *)compound_stmt(rest, tok);
  }

  return expr_stmt(rest, tok);
}

// compound-stmt = (typedef | declaration | stmt)* "}"
static BlockNode *compound_stmt(const Token **rest, const Token *tok) {
  Node head = {0};
  Node *cur = &head;

  enter_scope();

  while (!check(tok, TOKEN_RIGHT_BRACE)) {
    if (is_typename(tok)) {
      VarAttr attr = {0};
      Type *base_type = declspec(&tok, tok, &attr);
      if (attr.is_typedef) {
        tok = parse_typedef(tok, base_type);
        continue;
      }

      cur = cur->next = (Node *)declaration(&tok, tok, base_type);

    } else {
      cur = cur->next = stmt(&tok, tok);
    }

    add_type(cur);
  }

  leave_scope();

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

// expr = assign ("," expr)?
static Node *expr(const Token **rest, const Token *tok) {
  Node *node = assign(&tok, tok);

  if (check(tok, TOKEN_COMMA))
    return new_binary_node(NODE_COMMA, node, expr(rest, tok->next), tok);

  *rest = tok;
  return node;
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

// struct-members = (declspec declarator (","  declarator)* ";")*
static Member *struct_union_members(const Token **rest, const Token *tok) {
  Member head = {0};
  Member *cur = &head;
  while (!check(tok, TOKEN_RIGHT_BRACE)) {
    Type *base_type = declspec(&tok, tok, NULL);
    int i = 0;

    while (!match(&tok, tok, TOKEN_SEMICOLON)) {
      if (i++)
        tok = consume(tok, TOKEN_COMMA);

      Type *type = declarator(&tok, tok, base_type);
      cur->next = new_struct_union_member(type, type->name);
      cur = cur->next;
    }
  }
  *rest = tok->next;
  return head.next;
}

static Type *union_decl(const Token **rest, const Token *tok) {
  // Read a union tag
  const Token *tag = NULL;
  if (check(tok, TOKEN_IDENT)) {
    tag = tok;
    tok = tok->next;
  }

  if (tag && !check(tok, TOKEN_LEFT_BRACE)) {
    Type *type = find_tag(tag);
    if (!type)
      error_tok(tag, "unknown union type");
    *rest = tok;
    return type;
  }

  Member *members = struct_union_members(rest, tok->next);
  size_t union_align = 1;
  size_t union_size = 0;

  // If union, we don't have to assign offsets because they
  // are already initialized to zero. We need to compute the
  // alignment and the size though.
  for (Member *mem = members; mem; mem = mem->next) {
    if (union_align < mem->type->align)
      union_align = mem->type->align;
    if (union_size < mem->type->size)
      union_size = mem->type->size;
  }
  union_size = align_to(union_size, union_align);
  Type *union_type = new_union_type(members, union_size, union_align);
  // Register the union type if a name was given.
  if (tag)
    push_tag_scope(tag, union_type);
  return union_type;
}

static Type *struct_decl(const Token **rest, const Token *tok) {
  // Read a struct tag.
  const Token *tag = NULL;
  if (check(tok, TOKEN_IDENT)) {
    tag = tok;
    tok = tok->next;
  }

  if (tag && !check(tok, TOKEN_LEFT_BRACE)) {
    Type *type = find_tag(tag);
    if (!type)
      error_tok(tag, "unknown struct type");
    *rest = tok;
    return type;
  }

  Member *members = struct_union_members(rest, tok->next);
  size_t struct_align = 1;
  // Assign offsets within the struct to members.
  size_t offset = 0;
  for (Member *mem = members; mem; mem = mem->next) {
    offset = align_to(offset, mem->type->align);
    mem->offset = offset;
    offset += mem->type->size;

    if (struct_align < mem->type->align) {
      struct_align = mem->type->align;
    }
  }
  const size_t struct_size = align_to(offset, struct_align);
  Type *struct_type = new_struct_type(members, struct_size, struct_align);
  // Register the struct type if a name was given.
  if (tag)
    push_tag_scope(tag, struct_type);
  return struct_type;
}

static Member *get_struct_union_member(Type *type, const Token *tok) {
  for (Member *mem = type->members; mem; mem = mem->next) {
    if (mem->name->len == tok->len &&
        strncmp(mem->name->loc, tok->loc, tok->len) == 0) {
      return mem;
    }
  }
  error_tok(tok, "no a member of the struct");
  return NULL;
}

static Node *struct_union_ref(Node *lhs, const Token *tok) {
  add_type(lhs);

  if (lhs->type->kind != TYPE_STRUCT && lhs->type->kind != TYPE_UNION) {
    error_tok(lhs->tok, "not a struct nor a union");
  }

  Member *member = get_struct_union_member(lhs->type, tok);
  return new_member_node(lhs, member, tok);
}

// postfix = primary ("[" expr "]" | "." ident | "->" ident)*
static Node *postfix(const Token **rest, const Token *tok) {
  Node *node = primary(&tok, tok);

  for (;;) {
    if (check(tok, TOKEN_LEFT_BRACKET)) {
      // x[y] is short for *(x+y)
      const Token *start = tok;
      Node *idx = expr(&tok, tok->next);
      tok = consume(tok, TOKEN_RIGHT_BRACKET);
      node = new_unary_node(NODE_DEREF, new_add(node, idx, start), start);
      continue;
    }

    if (match(&tok, tok, TOKEN_DOT)) {
      node = struct_union_ref(node, tok);
      tok = consume(tok, TOKEN_IDENT);
      // tok = tok->next; // skip the "ident" after the "."
      continue;
    }

    if (check(tok, TOKEN_ARROW)) {
      // x->y is equivalent to  (*x).y
      node = new_unary_node(NODE_DEREF, node, tok);
      tok = consume(tok, TOKEN_ARROW);
      node = struct_union_ref(node, tok);
      tok = consume(tok, TOKEN_IDENT);
      // tok = tok->next->next;
      continue;
    }

    *rest = tok;
    return node;
  }
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
  }
  if (match(&tok, tok, TOKEN_LEFT_PAREN)) {
    Node *node = expr(&tok, tok);
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

    const VarScope *var_scope = find_var(tok);
    if (!var_scope || !var_scope->var) {
      error_tok(tok, "undefined variable");
    }
    *rest = tok->next;
    return new_var_node(var_scope->var, tok);
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
static const Token *parse_typedef(const Token *tok, Type *base_type) {
  bool first = true;

  while (!match(&tok, tok, TOKEN_SEMICOLON)) {
    if (!first) {
      tok = consume(tok, TOKEN_COMMA);
    }
    first = false;

    Type *type = declarator(&tok, tok, base_type);

    VarScope *sc = push_scope(get_ident(type->name), type->name->len);
    sc->type_def = type;
  }
  return tok;
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
  fn->is_definition = !match(&tok, tok, TOKEN_SEMICOLON);
  if (!fn->is_definition)
    return tok;

  locals = NULL;
  enter_scope();
  create_param_lvars(type->params);
  fn->params = locals;

  tok = consume(tok, TOKEN_LEFT_BRACE);
  fn->body = (Node *)compound_stmt(&tok, tok);
  fn->locals = locals;
  leave_scope();
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

// program = (typedef | function-definition | global-variable)*
Obj *parse(const Token *tok) {
  globals = NULL;

  while (!check(tok, TOKEN_EOF)) {
    VarAttr attr = {0};
    Type *base_type = declspec(&tok, tok, &attr);

    // Typedef
    if (attr.is_typedef) {
      tok = parse_typedef(tok, base_type);
      continue;
    }

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
