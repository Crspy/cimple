#ifndef OBJECT_HEADER_GUARD
#define OBJECT_HEADER_GUARD
#include <stddef.h>

// Variable or function
typedef struct Obj Obj;
struct Obj {
  Obj *next;
  char *name; // Variable name
  size_t name_length;  // Variable name length
  struct Type *type;       // Type
  bool is_local;    // local or global/function

  // Offset from RBP (local variable)
  int offset;

  // Global variable or function
  bool is_function;
  bool is_definition;

  // Global variable
  char *init_data;

  // Function
  Obj *params;
  struct Node *body;
  Obj *locals;
  int stack_size;
};

#endif /* OBJECT_HEADER_GUARD */