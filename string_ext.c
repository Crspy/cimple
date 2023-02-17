#include "string_ext.h"


char * strndup(const char *s, size_t len)
{
  char *new = (char *) malloc (len + 1);
  if (new == NULL)
    return NULL;
  new[len] = '\0';
  return (char *) memcpy (new, s, len);
}