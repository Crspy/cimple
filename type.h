
#ifndef TYPE_HEADER_GUARD
#define TYPE_HEADER_GUARD
#include "ast_node.h"

typedef struct Type Type;

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
  const struct Token *name;

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

#endif /* TYPE_HEADER_GUARD */