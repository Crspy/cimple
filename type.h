
#ifndef TYPE_HEADER_GUARD
#define TYPE_HEADER_GUARD
#include "ast_node.h"

typedef struct Type Type;
typedef struct Member Member;
typedef enum {
  TYPE_VOID,
  TYPE_BOOL,
  TYPE_CHAR,
  TYPE_SHORT,
  TYPE_INT,
  TYPE_LONG,
  TYPE_ENUM,
  TYPE_PTR,
  TYPE_FUNC,
  TYPE_ARRAY,
  TYPE_STRUCT,
  TYPE_UNION
} TypeKind;

struct Type {
  TypeKind kind;

  size_t size; // sizeof() value

  // Array
  size_t array_length;
  size_t align;

  // Struct
  Member *members;

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

// Struct member
struct Member {
  Member *next;
  Type *type;
  const Token *name;
  size_t offset;
};

Member new_member(Type* type,const Token* name);
Type *long_type(void);
Type *int_type(void);
Type *short_type(void);
Type *char_type(void);
Type *bool_type(void);
Type *void_type(void);
Type *enum_type(void);
bool is_integer(Type *type);
Type *copy_type(Type *type);
Type *pointer_to(Type *base);
Type *func_type(Type *return_type);
Type *new_struct_type(Member*members , size_t size, size_t align);
Type *new_union_type(Member*members , size_t size, size_t align);
Member *new_struct_union_member(Type* type,const Token* name);
Type *array_of(Type *base, size_t size);
void add_type(Node *node);

#endif /* TYPE_HEADER_GUARD */