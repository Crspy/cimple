#include "cimple.h"
static Node *new_node(NodeKind kind, Node *lhs, Node *rhs)
{
    Node *node = malloc(sizeof(Node));
    node->kind = kind;
    node->next = NULL;
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
static Node *stmt(void);
static Node *expr(void);
static Node *equality(void);
static Node *comparison(void);
static Node *term(void);
static Node *factor(void);
static Node *unary(void);
static Node *primary(void);


// program = stmt*
Node *program(void) {
  Node head;
  Node *cur = &head;

  while (!at_eof()) {
    cur->next = stmt();
    cur = cur->next;
  }
  return head.next;
}

// stmt = expr ";"
static Node *stmt(void) {
  Node *node = expr();
  expect(";");
  return node;
}



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