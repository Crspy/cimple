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


typedef struct Node Node;

//
// tokenizer.c
//
typedef enum
{
  TK_IDENT, // Identifiers
  TK_PUNCT, // Punctuators
  TK_NUM,   // Numeric literals
  TK_EOF,   // End-of-file markers
} TokenKind;

// Token type
typedef struct Token Token;
struct Token
{
  TokenKind kind; // Token kind
  Token *next;    // Next token
  int val;        // If kind is TK_NUM, its value
  const char *loc;      // Token location
  int len;        // Token length
};

void error(const char *fmt, ...);
void error_at(const char *loc,const char *fmt, ...);
void error_tok(const Token *tok,const char *fmt, ...);
bool equal(const Token *tok,const char *op);
Token *consume(const Token *tok,const char *op);
Token *tokenize(const char *input);

//
// parser.c
//

// Local variable
typedef struct Obj Obj;
struct Obj {
  Obj *next;
  const char *name; // Variable name
  int len; // Variable name length
  int offset; // Offset from RBP
};

// Function
typedef struct Function Function;
struct Function {
  Node *body;
  Obj *locals;
  int stack_size;
};


// AST node type
typedef enum
{
  ND_ADD,       // +
  ND_SUB,       // -
  ND_MUL,       // *
  ND_DIV,       // /
  ND_NEG,       // unary -
  ND_EQ,        // ==
  ND_NE,        // !=
  ND_LT,        // <
  ND_LE,        // <=
  ND_ASSIGN,    // =
  ND_EXPR_STMT, // Expression statement
  ND_VAR,       // Variable
  ND_NUM,       // Integer
} NodeKind;

struct Node
{
  NodeKind kind; // Node kind
  Node *next;    // Next node
  Node *lhs;     // Left-hand side
  Node *rhs;     // Right-hand side
  Obj *var;     // Used if kind == ND_VAR
  int val;       // Used if kind == ND_NUM
};

Function *parse(const Token *tok);

//
// codegen.c
//

void codegen(Function *prog);


#endif /* CIMPLE_HEADER_GUARD */