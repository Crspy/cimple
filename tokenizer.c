#include "cimple.h"

// Input string
static const char *current_input;

// Reports an error and exit.
void error(const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  fprintf(stderr, "\n");
  exit(1);
}

// Reports an error location and exit.
static void verror_at(const char *loc, const char *fmt, va_list ap) {
  int pos = loc - current_input;
  fprintf(stderr, "%s\n", current_input);
  fprintf(stderr, "%*s", pos, ""); // print pos spaces.
  fprintf(stderr, "^ ");
  vfprintf(stderr, fmt, ap);
  fprintf(stderr, "\n");
  exit(1);
}

void error_at(const char *loc,const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  verror_at(loc, fmt, ap);
}

void error_tok(const Token *tok,const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  verror_at(tok->loc, fmt, ap);
}

// Consumes the current token if it matches `op`.
bool equal(const Token *tok, const char *op) {
  return memcmp(tok->loc, op, tok->len) == 0 && op[tok->len] == '\0';
}

// Ensure that the current token is `op`.
Token *consume(const Token *tok,const char *op) {
  if (!equal(tok, op))
    error_tok(tok, "expected '%s'", op);
  return tok->next;
}

// Create a new token.
static Token *new_token(TokenKind kind, const char *start,const char *end) {
  Token *tok = malloc(sizeof(Token));
  tok->kind = kind;
  tok->loc = start;
  tok->next = NULL;
  tok->len = end - start;
  return tok;
}

static bool startswith(const char *p,const char *q) {
  return strncmp(p, q, strlen(q)) == 0;
}

// Read a punctuator token from p and returns its length.
static int read_punct(const char *p) {
  if (startswith(p, "==") || startswith(p, "!=") ||
      startswith(p, "<=") || startswith(p, ">="))
    return 2;

  return ispunct(*p) ? 1 : 0;
}

// Tokenize `current_input` and returns new tokens.
Token *tokenize(const char *p) {
  current_input = p;
  Token head = {0};
  Token *cur = &head;

  while (*p) {
    // Skip whitespace characters.
    if (isspace(*p)) {
      p++;
      continue;
    }

    // Numeric literal
    if (isdigit(*p)) {
      cur = cur->next = new_token(TK_NUM, p, p);
      const char *num_start = p;
      cur->val = strtoul(p,(char**) &p, 10);
      cur->len = p - num_start;
      continue;
    }

      // Identifier
    if ('a' <= *p && *p <= 'z') {
      cur = cur->next = new_token(TK_IDENT, p, p + 1);
      p++;
      continue;
    }

    // Punctuators
    int punct_len = read_punct(p);
    if (punct_len) {
      cur = cur->next = new_token(TK_PUNCT, p, p + punct_len);
      p += cur->len;
      continue;
    }

    error_at(p, "invalid token");
  }

  cur = cur->next = new_token(TK_EOF, p, p);
  return head.next;
}
