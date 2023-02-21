#ifndef STRING_EXT_HEADER_GUARD
#define STRING_EXT_HEADER_GUARD
#include "stdint.h"
#include "stdlib.h"
#include "string.h"
#include "stdarg.h"
#include "stdio.h"

char * strndup(const char *s, size_t len);

// Takes a printf-style format string and returns a formatted heap string.
char* format(char *fmt, ...);

#endif /* STRING_EXT_HEADER_GUARD */