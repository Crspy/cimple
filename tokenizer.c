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

void error_at(const char *loc, const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  verror_at(loc, fmt, ap);
}

void error_tok(const Token *tok, const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  verror_at(tok->loc, fmt, ap);
}

// Consumes the current token if it matches `op`.
bool equal(const Token *tok, const char *op) {
  return memcmp(tok->loc, op, tok->len) == 0 && op[tok->len] == '\0';
}

// Ensure that the current token is `op`.
Token *consume(const Token *tok, const char *op) {
  if (!equal(tok, op))
    error_tok(tok, "expected '%s'", op);
  return tok->next;
}

// tries to consume the current token if it is equal to `str` and returns true
// otherwise returns false
bool match(const Token **rest, const Token *tok, const char *str) {
  if (equal(tok, str)) {
    *rest = tok->next;
    return true;
  }
  *rest = tok;
  return false;
}

// Create a new token.
static Token *new_token(TokenKind kind, const char *start, const char *end) {
  Token *tok = malloc(sizeof(Token));
  tok->kind = kind;
  tok->loc = start;
  tok->next = NULL;
  tok->len = end - start;
  return tok;
}

static bool startswith(const char *p, const char *q) {
  return strncmp(p, q, strlen(q)) == 0;
}

// Returns true if c is valid as the first character of an identifier.
static bool is_ident1(char c) {
  return ('a' <= c && c <= 'z') || ('A' <= c && c <= 'Z') || c == '_';
}

// Returns true if c is valid as a non-first character of an identifier.
static bool is_ident2(char c) { return is_ident1(c) || ('0' <= c && c <= '9'); }

// Read a punctuator token from p and returns its length.
static int read_punct(const char *p) {
  if (startswith(p, "==") || startswith(p, "!=") || startswith(p, "<=") ||
      startswith(p, ">="))
    return 2;

  return ispunct(*p) ? 1 : 0;
}

static bool is_keyword(Token *tok) {
  static char *kw[] = {"return", "if",  "else", "for",
                       "while",  "int", "char", "sizeof"};

  for (int i = 0; i < sizeof(kw) / sizeof(*kw); i++)
    if (equal(tok, kw[i]))
      return true;
  return false;
}

static int read_escaped_char(const char ch) {
  switch (ch) {
  case 'a':
    return '\a';
  case 'b':
    return '\b';
  case 't':
    return '\t';
  case 'n':
    return '\n';
  case 'v':
    return '\v';
  case 'f':
    return '\f';
  case 'r':
    return '\r';
  // [GNU] \e for the ASCII escape character is a GNU C extension.
  case 'e':
    return 27;
  default:
    return ch;
  }
}

// Find a closing double-quote.
static const char *string_literal_end(const char *p) {
  const char *start = p;
  for (; *p != '"'; p++) {
    if (*p == '\n' || *p == '\0')
      error_at(start, "unclosed string literal");
    if (*p == '\\')
      p++;
  }
  return p;
}

static Token *read_string_literal(const char *start) {
  const char *end = string_literal_end(start + 1);
  char *buf = malloc(end - start);
  int len = 0;

  for (const char *p = start + 1; p < end;) {
    if (*p == '\\') {
      buf[len++] = read_escaped_char(*(p + 1));
      p += 2;
    } else {
      buf[len++] = *p++;
    }
  }
  buf[len] = '\0';

  Token *tok = new_token(TOKEN_STR, start, end + 1);
  tok->type = array_of(char_type(), len + 1);
  tok->str = buf;
  return tok;
}

static void convert_keywords(Token *tok) {
  for (Token *t = tok; t->kind != TOKEN_EOF; t = t->next) {
    if (is_keyword(t)) {
      t->kind = TOKEN_KEYWORD;
    }
  }
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
      cur = cur->next = new_token(TOKEN_NUM, p, p);
      const char *num_start = p;
      cur->val = strtoul(p, (char **)&p, 10);
      cur->len = p - num_start;
      continue;
    }

    // String literal
    if (*p == '"') {
      cur = cur->next = read_string_literal(p);
      p += cur->len;
      continue;
    }

    // Identifier or keyword
    if (is_ident1(*p)) {
      const char *start = p;
      do {
        p++;
      } while (is_ident2(*p));
      cur = cur->next = new_token(TOKEN_IDENT, start, p);
      continue;
    }

    // Punctuators
    int punct_len = read_punct(p);
    if (punct_len) {
      cur = cur->next = new_token(TOKEN_PUNCT, p, p + punct_len);
      p += cur->len;
      continue;
    }

    error_at(p, "invalid token");
  }

  cur = cur->next = new_token(TOKEN_EOF, p, p);
  convert_keywords(head.next);
  return head.next;
}
