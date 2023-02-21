#ifndef TOKENIZER_HEADER_GUARD
#define TOKENIZER_HEADER_GUARD

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
  struct Type *type;      // Used if TOKENK_STR
  char *str;       // String literal contents including terminating '\0'
};

void error(const char *fmt, ...);
void error_at(const char *loc, const char *fmt, ...);
void error_tok(const Token *tok, const char *fmt, ...);
bool equal(const Token *tok, const char *op);
Token *consume(const Token *tok, const char *op);
bool match(const Token **rest, const Token *tok, const char *str);
Token *tokenize(const char *input);

#endif /* TOKENIZER_HEADER_GUARD */