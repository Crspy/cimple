#include "tokenizer.h"
#include "cimple.h"

// Input filename
static const char *current_filename;

// Input string
static const char *current_input;

static const char *tokens_strings[TOKEN_TOTAL_COUNT] = {
    [TOKEN_RETURN] = "return",
    [TOKEN_IF] = "if",
    [TOKEN_ELSE] = "else",
    [TOKEN_FOR] = "for",
    [TOKEN_WHILE] = "while",
    [TOKEN_INT] = "int",
    [TOKEN_CHAR] = "char",
    [TOKEN_SIZEOF] = "sizeof",
    [TOKEN_STRUCT] = "struct",
    [TOKEN_KEYWORDS_COUNT] = "9",
    [TOKEN_LEFT_BRACKET] = "[",
    [TOKEN_RIGHT_BRACKET] = "]",
    [TOKEN_LEFT_PAREN] = "(",
    [TOKEN_RIGHT_PAREN] = ")",
    [TOKEN_LEFT_BRACE] = "{",
    [TOKEN_RIGHT_BRACE] = "}",
    [TOKEN_COMMA] = ",",
    [TOKEN_DOT] = ".",
    [TOKEN_MINUS] = "-",
    [TOKEN_PLUS] = "+",
    [TOKEN_SEMICOLON] = ",",
    [TOKEN_SLASH] = "/",
    [TOKEN_STAR] = "*",
    [TOKEN_PERCENT] = "%",
    [TOKEN_COLON] = ":",
    [TOKEN_AMPERSAND] = "&",
    [TOKEN_BANG] = "!",
    [TOKEN_BANG_EQUAL] = "!=",
    [TOKEN_EQUAL] = "=",
    [TOKEN_EQUAL_EQUAL] = "==",
    [TOKEN_GREATER] = ">",
    [TOKEN_GREATER_EQUAL] = ">=",
    [TOKEN_LESS] = "<",
    [TOKEN_LESS_EQUAL] = "<=",
    [TOKEN_PLUS_PLUS] = "++",
    [TOKEN_MINUS_MINUS] = "--",
    [TOKEN_ARROW] = "->",
    [TOKEN_IDENT] = "identifier",
    [TOKEN_STR] = "string literal",
    [TOKEN_NUM] = "numeric literal",
    [TOKEN_EOF] = "eof",
};

const char *token_to_str(TokenKind c) {
  if (TOKEN_TOTAL_COUNT > c)
    return tokens_strings[c];
  return "unknown-token";
}

// Reports an error and exit.
void error(const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  fprintf(stderr, "\n");
  exit(1);
}

// Reports an error message in the following format and exit.
//
// foo.c:10: x = y + 1;
//               ^ <error message here>
static void verror_at(size_t line_no, const char *loc, const char *fmt,
                      va_list ap) {
  // Find a line containing `loc`.
  const char *line = loc;
  while (current_input < line && line[-1] != '\n')
    line--;

  const char *end = loc;
  while (*end != '\n')
    end++;

  // Print out the line.
  int indent = fprintf(stderr, "%s:%lu: ", current_filename, line_no);
  fprintf(stderr, "%.*s\n", (int)(end - line), line);

  // Show the error message.
  int pos = loc - line + indent;

  fprintf(stderr, "%*s^ ", pos, ""); // print pos spaces.
  vfprintf(stderr, fmt, ap);
  fprintf(stderr, "\n");
  exit(1);
}

void error_at(const char *loc, const char *fmt, ...) {
  size_t line_no = 1;
  for (const char *p = current_input; p < loc; p++) {
    if (*p == '\n')
      line_no++;
  }
  va_list ap;
  va_start(ap, fmt);
  verror_at(line_no, loc, fmt, ap);
}

void error_tok(const Token *tok, const char *fmt, ...) {
  va_list ap;
  va_start(ap, fmt);
  verror_at(tok->line_no, tok->loc, fmt, ap);
}

// Ensure that the current token is `op`.
bool equal(const Token *tok, const char *op) {
  const int op_len = strlen(op);
  const int min_len = op_len < tok->len ? op_len : tok->len;
  return memcmp(tok->loc, op, min_len) == 0 && op[min_len] == '\0';
}

// Consumes the current token if it matches `op`.
Token *consume(const Token *tok, TokenKind kind) {
  if (!check(tok, kind))
    error_tok(tok, "expected '%s'", token_to_str(kind));
  return tok->next;
}

// Ensure that the current token kind is 'kind'
bool check(const Token *tok, TokenKind kind) { return tok->kind == kind; }

// tries to consume the current token if it has the same `kind` and returns true
// otherwise returns false
bool match(const Token **rest, const Token *tok, TokenKind kind) {
  if (check(tok, kind)) {
    *rest = tok->next;
    return true;
  }
  *rest = tok;
  return false;
}

// Create a new token.
static Token *new_token(TokenKind kind, size_t line_no, const char *line_start,
                        const char *start, const char *end) {
  Token *tok = malloc(sizeof(Token));
  tok->kind = kind;
  tok->loc = start;
  tok->next = NULL;
  tok->len = end - start;
  tok->line_no = line_no;
  tok->col_pos = start - line_start;
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
static int read_punct(const char *p, TokenKind *kind) {
  switch (*p) {
  case '[':
    *kind = TOKEN_LEFT_BRACKET;
    return 1;
  case ']':
    *kind = TOKEN_RIGHT_BRACKET;
    return 1;
  case '(':
    *kind = TOKEN_LEFT_PAREN;
    return 1;
  case ')':
    *kind = TOKEN_RIGHT_PAREN;
    return 1;
  case '{':
    *kind = TOKEN_LEFT_BRACE;
    return 1;
  case '}':
    *kind = TOKEN_RIGHT_BRACE;
    return 1;
  case ';':
    *kind = TOKEN_SEMICOLON;
    return 1;
  case ',':
    *kind = TOKEN_COMMA;
    return 1;
  case '.':
    *kind = TOKEN_DOT;
    return 1;
  case '-':
    if (p[1] == '-') {
      *kind = TOKEN_MINUS_MINUS;
      return 2;
    } else if (p[1] == '>') {
      *kind = TOKEN_ARROW;
      return 2;
    }
    *kind = TOKEN_MINUS;
    return 1;
  case '+':
    if (p[1] == '+') {
      *kind = TOKEN_PLUS_PLUS;
      return 2;
    }
    *kind = TOKEN_PLUS;
    return 1;
  case '/':
    *kind = TOKEN_SLASH;
    return 1;
  case '*':
    *kind = TOKEN_STAR;
    return 1;
  case '&':
    *kind = TOKEN_AMPERSAND;
    return 1;
  case '%':
    *kind = TOKEN_PERCENT;
    return 1;
  case ':':
    *kind = TOKEN_COLON;
    return 1;
  case '!':
    if (p[1] == '=') {
      *kind = TOKEN_BANG_EQUAL;
      return 2;
    }
    *kind = TOKEN_BANG;
    return 1;
  case '=':
    if (p[1] == '=') {
      *kind = TOKEN_EQUAL_EQUAL;
      return 2;
    }
    *kind = TOKEN_EQUAL;
    return 1;
  case '<':
    if (p[1] == '=') {
      *kind = TOKEN_LESS_EQUAL;
      return 2;
    }
    *kind = TOKEN_LESS;
    return 1;
  case '>':
    if (p[1] == '=') {
      *kind = TOKEN_GREATER_EQUAL;
      return 2;
    }
    *kind = TOKEN_GREATER;
    return 1;
  }
  return 0;
}

static bool find_keyword(Token *tok, TokenKind *kind) {
  for (int i = 0; i < TOKEN_KEYWORDS_COUNT; i++)
    if (equal(tok, tokens_strings[i])) {
      *kind = i;
      return true;
    }
  return false;
}
static int from_hex(char c) {
  if ('0' <= c && c <= '9')
    return c - '0';

  if ('a' <= c && c <= 'f')
    return c - 'a' + 10;

  return c - 'A' + 10;
}
static int read_escaped_char(const char **new_pos, const char *p) {
  if ('0' <= *p && *p <= '7') {
    // Read an octal number (only 3 digits)
    int c = *p++ - '0';
    if ('0' <= *p && *p <= '7') {
      c = (c << 3) + (*p++ - '0');
      if ('0' <= *p && *p <= '7')
        c = (c << 3) + (*p++ - '0');
    }
    *new_pos = p;

    // TODO: check if octal escape sequence out of range
    return c;
  }

  if (*p == 'x') {
    // Read a hexadecimal number.
    p++;
    if (!isxdigit(*p))
      error_at(p, "invalid hex escape sequence");

    int c = 0;
    for (; isxdigit(*p); p++)
      c = (c << 4) + from_hex(*p);
    *new_pos = p;

    // TODO: check if hex escape sequence out of range
    return c;
  }

  *new_pos = p + 1;

  // Escape sequences are defined using themselves
  switch (*p) {
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
    return *p;
  }
}

// Find a closing double-quote.
static const char *string_literal_end(const char *p) {
  const char *start = p;
  for (; *p != '"'; p++) {
    if (*p == '\n' || *p == '\0')
      error_at(start, "unterminated string literal");
    if (*p == '\\')
      p++;
  }
  return p;
}

static Token *read_string_literal(const char *start, size_t line_no,
                                  const char *line_start) {
  const char *end = string_literal_end(start + 1);
  char *buf = malloc(end - start);
  int len = 0;

  for (const char *p = start + 1; p < end;) {
    if (*p == '\\') {
      buf[len++] = read_escaped_char(&p, p + 1);
    } else {
      buf[len++] = *p++;
    }
  }
  buf[len] = '\0';

  Token *tok = new_token(TOKEN_STR, line_no, line_start, start, end + 1);
  tok->type = array_of(char_type(), len + 1);
  tok->str = buf;
  return tok;
}

// Tokenize `current_input` and returns new tokens.
static Token *tokenize(const char *filename, const char *p) {
  current_filename = filename;
  current_input = p;
  Token head = {0};
  Token *cur = &head;
  size_t line_no = 1;
  const char *line_start = p;

  while (*p) {
    // Skip line comments.
    if (startswith(p, "//")) {
      p += 2;
      while (*p != '\n')
        p++;
      continue;
    }

    // Skip block comments.
    if (startswith(p, "/*")) {
      p = p + 2;
      while (*p) {
        if (p[0] == '\0' || p[1] == '\0') {
          error_at(p, "unterminated block comment");
        } else if (p[0] == '*' && p[1] == '/') {
          p += 2;
          break;
        } else if (p[0] == '\n') {
          ++line_no;
          line_start = p + 1;
        }

        p++;
      }
      // char *q = strstr(p + 2, "*/");
      // if (!q)
      //   error_at(p, "unterminated block comment");
      // p = q + 2;
      continue;
    }

    // Skip whitespace characters.
    if (isspace(*p)) {
      if (*p == '\n') {
        ++line_no;
        line_start = p + 1;
      }
      p++;
      continue;
    }

    // Numeric literal
    if (isdigit(*p)) {
      cur = cur->next = new_token(TOKEN_NUM, line_no, line_start, p, p);
      const char *num_start = p;
      cur->val = strtoul(p, (char **)&p, 10);
      cur->len = p - num_start;
      continue;
    }

    // String literal
    if (*p == '"') {
      cur = cur->next = read_string_literal(p, line_no, line_start);
      p += cur->len;
      continue;
    }

    // Identifier or keyword
    if (is_ident1(*p)) {
      const char *start = p;
      do {
        p++;
      } while (is_ident2(*p));
      cur = cur->next = new_token(TOKEN_IDENT, line_no, line_start, start, p);

      TokenKind keywordKind;
      if (find_keyword(cur, &keywordKind)) {
        cur->kind = keywordKind;
      }
      continue;
    }

    // Punctuators
    TokenKind punct_kind;
    int punct_len = read_punct(p, &punct_kind);
    if (punct_len) {
      cur = cur->next =
          new_token(punct_kind, line_no, line_start, p, p + punct_len);
      p += cur->len;
      continue;
    }

    error_at(p, "invalid token");
  }

  cur = cur->next = new_token(TOKEN_EOF, line_no, line_start, p, p);
  return head.next;
}

// Returns the contents of a given file.
static char *read_file(const char *path) {
  FILE *fp;

  if (strcmp(path, "-") == 0) {
    // By convention, read from stdin if a given filename is "-".
    fp = stdin;
  } else {
    fp = fopen(path, "r");
    if (!fp)
      error("cannot open %s: %s", path, strerror(errno));
  }

  size_t buf_size = 1024;
  char *buf = malloc(buf_size);
  if (buf == NULL) {
    perror("Failed to allocate enough memory to read input");
    exit(1);
  }
  size_t buflen = 0;

  // Read the entire file.
  char buf2[4096];
  for (;;) {
    int n = fread(buf2, 1, sizeof(buf2), fp);
    if (n == 0)
      break;
    size_t needed_size = n + buflen + 2; // +2  for '\n' + '\0'
    if (needed_size > buf_size) {
      buf = realloc(buf, needed_size);
      if (buf == NULL) {
        perror("Failed to allocate enough memory to read input");
        exit(1);
      }
      buf_size = needed_size;
    }
    memcpy(buf + buflen, buf2, n);
    buflen += n;
  }

  if (fp != stdin)
    fclose(fp);

  // Make sure that the last line is properly terminated with '\n'.
  // fflush(out);
  if (buflen == 0 || buf[buflen - 1] != '\n')
    buf[buflen] = '\n';
  buf[buflen] = '\0';
  return buf;
}

Token *tokenize_file(const char *path) {
  return tokenize(path, read_file(path));
}

void free_tokens(Token *tok) {
  while (tok) {
    Token *dead_tok = tok;
    tok = tok->next;
    free(dead_tok);
  }
}