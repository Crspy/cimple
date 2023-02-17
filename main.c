#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//
// Tokenizer
//
typedef enum
{
    TK_RESERVED, // Keywords or punctuators
    TK_NUM,      // Integer literals
    TK_EOF,      // End-of-file markers
} TokenKind;

// Token type
typedef struct Token Token;
struct Token
{
    TokenKind kind; // Token kind
    Token *next;    // Next token
    long val;       // If kind is TK_NUM, its value
    char *str;      // Token string
    size_t len;     // Token length
};

// Input program
char *user_input;

// Current token
Token *token;

// Reports an error and exit.
void error(char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    fprintf(stderr, "\n");
    exit(1);
}

// Reports an error location and exit.
void error_at(char *loc, char *fmt, ...)
{
    va_list ap;
    va_start(ap, fmt);

    int pos = loc - user_input;
    fprintf(stderr, "%s\n", user_input);
    fprintf(stderr, "%*s", pos, ""); // print pos spaces.
    fprintf(stderr, "^ ");
    vfprintf(stderr, fmt, ap);
    fprintf(stderr, "\n");
    exit(1);
}

// Consumes the current token if it matches `op`.
bool consume(char *op)
{
    if (token->kind != TK_RESERVED || strlen(op) != token->len || strncmp(token->str, op, token->len) != 0)
    {
        return false;
    }
    token = token->next;
    return true;
}

// Ensure that the current token is `op`.
void expect(char *op)
{
    if (token->kind != TK_RESERVED || strlen(op) != token->len || strncmp(token->str, op, token->len) != 0)
    {
        error_at(token->str, "expected \"%s\"", op);
    }
    token = token->next;
}

// Ensure that the current token is TK_NUM.
long expect_number(void)
{
    if (token->kind != TK_NUM)
        error_at(token->str, "expected a number");
    long val = token->val;
    token = token->next;
    return val;
}

bool at_eof(void)
{
    return token->kind == TK_EOF;
}

// Create a new token and add it as the next token of `cur`.
Token *new_token(TokenKind kind, Token *cur, char *str, size_t len)
{
    Token *tok = (Token *)malloc(sizeof(Token));
    tok->kind = kind;
    tok->str = str;
    tok->len = len;
    cur->next = tok;
    return tok;
}

static bool startswith(char *str, char *substr)
{
    return strncmp(str, substr, strlen(substr)) == 0;
}

// Tokenize `user_input` and returns new tokens.
Token *tokenize(void)
{
    char *p = user_input;
    Token head;
    Token *cur = &head;

    while (*p)
    {
        // Skip whitespace characters.
        if (isspace(*p))
        {
            p++;
            continue;
        }

        // Multi-letter punctuators
        if (startswith(p, "==") || startswith(p, "!=") ||
            startswith(p, "<=") || startswith(p, ">="))
        {
            cur = new_token(TK_RESERVED, cur, p, 2);
            p += 2;
            continue;
        }

        // Single-letter Punctuators
        if (ispunct(*p))
        {
            cur = new_token(TK_RESERVED, cur, p++, 1);
            continue;
        }

        // Integer literal
        if (isdigit(*p))
        {
            cur = new_token(TK_NUM, cur, p, 0);
            char *num_str_start = p;
            cur->val = strtol(p, &p, 0); // we pass 0 to support decimal/hexadecimal/octal numbers
            cur->len = p - num_str_start;
            continue;
        }

        error_at(p, "invalid token");
    }

    new_token(TK_EOF, cur, p, 0);
    return head.next;
}

//
// Parser
//
typedef enum
{
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
typedef struct Node
{
    NodeKind kind;    // Node kind
    long val;         // Used if kind == ND_NUM
    struct Node *lhs; // Left-hand side
    struct Node *rhs; // Right-hand side
} Node;

static Node *new_node(NodeKind kind, Node *lhs, Node *rhs)
{
    Node *node = malloc(sizeof(Node));
    node->kind = kind;
    node->lhs = lhs;
    node->rhs = rhs;
    return node;
}
static Node *new_binary(NodeKind kind, Node *lhs, Node *rhs)
{
    Node *node = new_node(kind, lhs, rhs);
    return node;
}

static Node *new_num(int val)
{
    Node *node = new_node(ND_NUM, NULL, NULL);
    node->val = val;
    return node;
}
static Node *expr(void);
static Node *equality(void);
static Node *comparison(void);
static Node *term(void);
static Node *factor(void);
static Node *unary(void);
static Node *primary(void);

// expr = equality
static Node *expr(void)
{
    return equality();
}

// equality = comparison ("==" comparison | "!=" comparison)*
static Node *equality(void)
{
    Node *node = comparison();

    for (;;)
    {
        if (consume("=="))
            node = new_binary(ND_EQ, node, comparison());
        else if (consume("!="))
            node = new_binary(ND_NE, node, comparison());
        else
            return node;
    }
}

// comparison = term ("<" term | "<=" term | ">" term | ">=" term)*
static Node *comparison(void)
{
    Node *node = term();

    for (;;)
    {
        if (consume("<"))
            node = new_binary(ND_LT, node, term());
        else if (consume("<="))
            node = new_binary(ND_LE, node, term());
        else if (consume(">"))
            node = new_binary(ND_LT, term(), node); // we swap the operands because (a > b) is just the same as (b < a)
        else if (consume(">="))
            node = new_binary(ND_LE, term(), node); // we swap the operands because (a >= b) is just the same as (b <= a)
        else
            return node;
    }
}

// term = factor ("+" factor | "-" factor)*
static Node *term(void)
{
    Node *node = factor();

    for (;;)
    {
        if (consume("+"))
            node = new_binary(ND_ADD, node, factor());
        else if (consume("-"))
            node = new_binary(ND_SUB, node, factor());
        else
            return node;
    }
}

// factor = unary ("*" unary | "/" unary)*
static Node *factor(void)
{
    Node *node = unary();

    for (;;)
    {
        if (consume("*"))
            node = new_binary(ND_MUL, node, unary());
        else if (consume("/"))
            node = new_binary(ND_DIV, node, unary());
        else
            return node;
    }
}

// unary = ("+" | "-")? unary
//       | primary
static Node *unary(void)
{
    if (consume("+"))
        return unary();
    if (consume("-"))
        return new_binary(ND_SUB, new_num(0), unary());
    return primary();
}

// primary = "(" expr ")" | num
static Node *primary(void)
{
    if (consume("("))
    {
        Node *node = expr();
        expect(")");
        return node;
    }

    return new_num(expect_number());
}

//
// Code generator
//

static void gen(Node *node)
{
    if (node->kind == ND_NUM)
    {
        printf("  push %ld\n", node->val);
        return;
    }

    gen(node->lhs);
    gen(node->rhs);

    printf("  pop rdi\n");
    printf("  pop rax\n");

    switch (node->kind)
    {
    case ND_ADD:
        printf("  add rax, rdi\n");
        break;
    case ND_SUB:
        printf("  sub rax, rdi\n");
        break;
    case ND_MUL:
        printf("  imul rax, rdi\n");
        break;
    case ND_DIV:
        printf("  cqo\n"); // sign-extend rax into rdx to be (rdx:rax) for the idiv instruction
        printf("  idiv rdi\n");
        break;
    case ND_EQ:
        printf("  cmp rax, rdi\n");
        printf("  sete al\n");
        printf("  movzb rax, al\n");
        break;
    case ND_NE:
        printf("  cmp rax, rdi\n");
        printf("  setne al\n");
        printf("  movzb rax, al\n");
        break;
    case ND_LT:
        printf("  cmp rax, rdi\n");
        printf("  setl al\n");
        printf("  movzb rax, al\n");
        break;
    case ND_LE:
        printf("  cmp rax, rdi\n");
        printf("  setle al\n");
        printf("  movzb rax, al\n");
        break;
    }

    printf("  push rax\n");
}

int main(int argc, char **argv)
{
    if (argc != 2)
        error("%s: invalid number of arguments", argv[0]);

    // Tokenize and parse.
    user_input = argv[1];
    token = tokenize();
    Node *node = expr();

    // print assembly directives and main declaration
    printf(".intel_syntax noprefix\n");
    printf(".global main\n");
    printf("main:\n");

    // traverse the ast to emit assembly
    gen(node);

    // The result must be at the top of the stack, so pop it
    // to RAX to make it a program exit code.
    printf("  pop rax\n");
    printf("  ret\n");
    return 0;
}
