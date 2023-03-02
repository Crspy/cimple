#define ASSERT(x, y) assert(x, y, #y)

int printf();
void assert(int expected, int actual, char *code);