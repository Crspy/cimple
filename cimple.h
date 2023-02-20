#ifndef CIMPLE_HEADER_GUARD
#define CIMPLE_HEADER_GUARD
#include <assert.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "string_ext.h"

typedef struct Type Type;
typedef struct Node Node;

//
// tokenizer.c
//
typedef enum
{
  TOKEN_IDENT,   // Identifiers
  TOKEN_PUNCT,   // Punctuators
  TOKEN_KEYWORD, // Keywords
  TOKEN_NUM,     // Numeric literals
  TOKEN_EOF,     // End-of-file markers
} TokenKind;

// Token type
typedef struct Token Token;
struct Token
{
  TokenKind kind;  // Token kind
  Token *next;     // Next token
  int val;         // If kind is TOKEN_NUM, its value
  const char *loc; // Token location
  int len;         // Token length
};

void error(const char *fmt, ...);
void error_at(const char *loc, const char *fmt, ...);
void error_tok(const Token *tok, const char *fmt, ...);
bool equal(const Token *tok, const char *op);
Token *consume(const Token *tok, const char *op);
bool match(const Token **rest, const Token *tok, const char *str);
Token *tokenize(const char *input);

//
// parser.c
//

// Local variable
typedef struct Obj Obj;
struct Obj
{
  Obj *next;
  Type *type;       // Type
  const char *name; // Variable name
  int len;          // Variable name length
  int offset;       // Offset from RBP
};

// Function
typedef struct Function Function;
struct Function
{
  Function *next;
  Obj *params;
  const char *name;
  int name_length;
  Node *body;
  Obj *locals;
  int stack_size;
};

// AST node type
typedef enum
{
  NODE_ADD,       // +
  NODE_SUB,       // -
  NODE_MUL,       // *
  NODE_DIV,       // /
  NODE_NEG,       // unary -
  NODE_EQ,        // ==
  NODE_NE,        // !=
  NODE_LT,        // <
  NODE_LE,        // <=
  NODE_ASSIGN,    // =
  NODE_ADDR,      // unary &
  NODE_DEREF,     // unary *
  NODE_RETURN,    // "return"
  NODE_IF,        // "if"
  NODE_FOR,       // "for" or "while"
  NODE_BLOCK,     // { ... }
  NODE_FUNCALL,   // Function call
  NODE_EXPR_STMT, // Expression statement
  NODE_VAR,       // Variable
  NODE_NUM,       // Integer
} NodeKind;

struct Node
{
  NodeKind kind;    // Node kind
  Node *next;       // Next node
  Type *type;       // Type, e.g. int or pointer to int
  const Token *tok; // Representative token

  Node *lhs; // Left-hand side
  Node *rhs; // Right-hand side

  // "if" statement
  Node *else_stmt;

  // "if" statement or "for" statement
  Node *then_stmt;
  Node *cond_expr;

  // "for" statement
  Node *init_expr;
  Node *inc_expr;

  // Block
  Node *body; // Used if kind == NODE_BLOCK

  // Function call
  Node *args;
  char *funcname;
  int funcname_length;

  Obj *var; // Used if kind == NODE_VAR

  int val; // Used if kind == NODE_NUM
};

Function *parse(const Token *tok);

//
// type.c
//

typedef enum
{
  TYPE_INT,
  TYPE_PTR,
  TYPE_FUNC
} TypeKind;

struct Type
{
  TypeKind kind;

  // Pointer
  Type *base;

  // Declaration
  const Token *name;

  // Function type
  Type *return_type;
  Type *params;
  Type *next;
};

extern Type *type_int;

bool is_integer(Type *type);
Type *copy_type(Type *type);
Type *pointer_to(Type *base);
Type *func_type(Type *return_type);
void add_type(Node *node);

//
// codegen.c
//

void codegen(Function *prog);

#endif /* CIMPLE_HEADER_GUARD */