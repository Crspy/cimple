#ifndef TOKENIZER_HEADER_GUARD
#define TOKENIZER_HEADER_GUARD
#include "stddef.h"
#include "stdbool.h"

typedef enum {
  // Keywords.
  // we use keywords enum as index for keywords string array
  TOKEN_RETURN,
  TOKEN_IF,
  TOKEN_ELSE,
  TOKEN_FOR,
  TOKEN_WHILE,
  TOKEN_INT,
  TOKEN_CHAR,
  TOKEN_SIZEOF,
  TOKEN_KEYWORDS_COUNT,

  // Single-character tokens.
  TOKEN_LEFT_BRACKET,
  TOKEN_RIGHT_BRACKET,
  TOKEN_LEFT_PAREN,
  TOKEN_RIGHT_PAREN,
  TOKEN_LEFT_BRACE,
  TOKEN_RIGHT_BRACE,
  TOKEN_COMMA,
  TOKEN_DOT,
  TOKEN_MINUS,
  TOKEN_PLUS,
  TOKEN_SEMICOLON,
  TOKEN_SLASH,
  TOKEN_STAR,
  TOKEN_PERCENT,
  TOKEN_COLON,
  TOKEN_AMPERSAND,
  // One or two character tokens.
  TOKEN_BANG,
  TOKEN_BANG_EQUAL,
  TOKEN_EQUAL,
  TOKEN_EQUAL_EQUAL,
  TOKEN_GREATER,
  TOKEN_GREATER_EQUAL,
  TOKEN_LESS,
  TOKEN_LESS_EQUAL,
  TOKEN_PLUS_PLUS,
  TOKEN_MINUS_MINUS,

  // Literals.
  TOKEN_IDENT, // Identifiers
  TOKEN_STR,   // String literals
  TOKEN_NUM,   // Numeric literals
  TOKEN_EOF,   // End-of-file markers

  TOKEN_TOTAL_COUNT
} TokenKind;

// Token type
typedef struct Token Token;
struct Token {
  TokenKind kind;    // Token kind
  Token *next;       // Next token
  int val;           // If kind is TOKEN_NUM, its value
  const char *loc;   // Token location
  int len;           // Token length
  struct Type *type; // Used if TOKENK_STR
  char *str;         // String literal contents including terminating '\0'

  size_t line_no; // Line number
};

const char *token_to_str(TokenKind c);
void error(const char *fmt, ...);
void error_at(const char *loc, const char *fmt, ...);
void error_tok(const Token *tok, const char *fmt, ...);
bool equal(const Token *tok, const char *op);
Token *consume(const Token *tok, TokenKind kind);
bool check(const Token *tok, TokenKind kind);
bool match(const Token **rest, const Token *tok, TokenKind kind);
Token *tokenize_file(const char *filename);
void free_tokens(Token *tok);

#endif /* TOKENIZER_HEADER_GUARD */