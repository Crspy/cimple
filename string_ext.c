#include "string_ext.h"

char *strndup(const char *s, size_t len) {
  char *new = (char *)malloc(len + 1);
  if (new == NULL)
    return NULL;
  new[len] = '\0';
  return (char *)memcpy(new, s, len);
}

char *format(char *fmt, ...) {

  va_list ap;
  va_start(ap, fmt);
  size_t needed = vsnprintf(NULL, 0, fmt, ap) + 1;
  char *buffer = malloc(needed);
  va_start(ap, fmt); // reset ap
  vsprintf(buffer, fmt, ap);
  return buffer;
}