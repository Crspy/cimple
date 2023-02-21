#ifndef CIMPLE_HEADER_GUARD
#define CIMPLE_HEADER_GUARD
#include "string_ext.h"
#include <assert.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Type Type;
typedef struct Node Node;

//
// tokenizer.c
//
typedef enum {
  TOKEN_IDENT,   // Identifiers
  TOKEN_PUNCT,   // Punctuators
  TOKEN_KEYWORD, // Keywords
  TOKEN_STR,     // String literals
  TOKEN_NUM,     // Numeric literals
  TOKEN_EOF,     // End-of-file markers
} TokenKind;

// Token type
typedef struct Token Token;
struct Token {
  TokenKind kind;  // Token kind
  Token *next;     // Next token
  int val;         // If kind is TOKEN_NUM, its value
  const char *loc; // Token location
  int len;         // Token length
  Type *type;      // Used if TOKENK_STR
  char *str;       // String literal contents including terminating '\0'
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

// Variable or function
typedef struct Obj Obj;
struct Obj {
  Obj *next;
  const char *name; // Variable name
  int name_length;  // Variable name length
  Type *type;       // Type
  bool is_local;    // local or global/function

  // Offset from RBP (local variable)
  int offset;

  // Global variable or function
  bool is_function;

  // Global variable
  char *init_data;

  // Function
  Obj *params;
  Node *body;
  Obj *locals;
  int stack_size;
};

// AST node type
struct Node {
  enum NodeTag {
    NODE_TAG_UNARY,
    NODE_TAG_BINARY,
    NODE_TAG_IF,
    NODE_TAG_FOR,
    NODE_TAG_BLOCK,
    NODE_TAG_FUNCALL,
    NODE_TAG_VAR,
    NODE_TAG_NUM
  } tag;
  Node *next;       // Next node
  Type *type;       // Type, e.g. int or pointer to int
  const Token *tok; // Representative token
};

typedef enum {
  NODE_NEG,       // unary -
  NODE_ADDR,      // unary &
  NODE_DEREF,     // unary *
  NODE_EXPR_STMT, // Expression statement
  NODE_RETURN,    // "return"
} UnaryKind;
struct UnaryNode {
  Node node;
  UnaryKind kind;
  Node *expr;
};

typedef enum {
  NODE_ADD,    // +
  NODE_SUB,    // -
  NODE_MUL,    // *
  NODE_DIV,    // /
  NODE_EQ,     // ==
  NODE_NE,     // !=
  NODE_LT,     // <
  NODE_LE,     // <=
  NODE_ASSIGN, // =
} BinaryKind;
struct BinaryNode {
  Node node;
  BinaryKind kind;
  Node *lhs; // Left-hand side
  Node *rhs; // Right-hand side
};
struct IfNode {
  Node node;
  Node *cond_expr;
  Node *then_stmt;
  Node *else_stmt;
};
struct ForNode {
  Node node;
  Node *init_expr;
  Node *cond_expr;
  Node *inc_expr;
  Node *body_stmt;
};
struct BlockNode {
  Node node;
  Node *body;
};
struct FunCallNode {
  Node node;
  Node *args;
  const char *funcname;
  int funcname_length;
};
struct VarNode {
  Node node;
  Obj *var;
};
struct NumNode {
  Node node;
  int val;
};

Obj *parse(const Token *tok);

//
// type.c
//

typedef enum {
  TYPE_CHAR,
  TYPE_INT,
  TYPE_PTR,
  TYPE_FUNC,
  TYPE_ARRAY,
} TypeKind;

struct Type {
  TypeKind kind;

  int size; // sizeof() value

  // Array
  int array_length;

  // Pointer-to or array-of type. We intentionally use the same member
  // to represent pointer/array duality in C.
  // In many contexts in which a pointer is expected, we examine this
  // member instead of "kind" member to determine whether a type is a
  // pointer or not. That means in many contexts "array of T" is
  // naturally handled as if it were "pointer to T", as required by
  // the C spec.
  Type *base;

  // Declaration
  const Token *name;

  // Function type
  Type *return_type;
  Type *params;
  Type *next;
};

Type *int_type();
Type *char_type();
bool is_integer(Type *type);
Type *copy_type(Type *type);
Type *pointer_to(Type *base);
Type *func_type(Type *return_type);
Type *array_of(Type *base, int size);
void add_type(Node *node);

//
// codegen.c
//

void codegen(Obj *prog);

#endif /* CIMPLE_HEADER_GUARD */