#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//
// tokenizer.c
//

typedef enum {
  TK_RESERVED, // Keywords or punctuators
  TK_NUM,      // Integer literals
  TK_EOF,      // End-of-file markers
} TokenKind;

// Token type
typedef struct Token Token;
struct Token {
  TokenKind kind; // Token kind
  Token *next;    // Next token
  long val;       // If kind is TK_NUM, its value
  char *str;      // Token string
  size_t len;        // Token length
};

void error(char *fmt, ...);
void error_at(char *loc, char *fmt, ...);
bool consume(char *op);
void expect(char *op);
long expect_number(void);
bool at_eof(void);
Token *tokenize(void);

extern char *user_input;
extern Token *token;

//
// parser.c
//

typedef enum {
  ND_ADD, // +
  ND_SUB, // -
  ND_MUL, // *
  ND_DIV, // /
  ND_EQ,  // ==
  ND_NE,  // !=
  ND_LT,  // <
  ND_LE,  // <=
  ND_NUM, // Integer
} NodeKind;

// AST node type
typedef struct Node Node;
struct Node {
  NodeKind kind; // Node kind
  Node* next;
  Node *lhs;     // Left-hand side
  Node *rhs;     // Right-hand side
  long val;      // Used if kind == ND_NUM
};

Node *program(void);

//
// codegen.c
//

void codegen(Node *node);
