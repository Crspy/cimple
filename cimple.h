#ifndef CIMPLE_HEADER_GUARD
#define CIMPLE_HEADER_GUARD
#include "string_ext.h"
#include <assert.h>
#include <errno.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "type.h"
#include "ast_node.h"
#include "tokenizer.h"
#include "obj.h"

#define unreachable() \
  error("internal error at %s:%d", __FILE__, __LINE__)

//
// parser.c
//

Obj *parse(const Token *tok);


//
// codegen.c
//

void codegen(Obj *prog,FILE* out);
int align_to(int n, int align);

#endif /* CIMPLE_HEADER_GUARD */