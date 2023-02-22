#ifndef CIMPLE_HEADER_GUARD
#define CIMPLE_HEADER_GUARD
#include "string_ext.h"
#include <assert.h>
#include <errno.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "type.h"
#include "ast_node.h"
#include "tokenizer.h"
#include "obj.h"

//
// parser.c
//

Obj *parse(const Token *tok);


//
// codegen.c
//

void codegen(Obj *prog,FILE* out);

#endif /* CIMPLE_HEADER_GUARD */