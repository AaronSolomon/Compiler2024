#include <stdio.h>
#include <stdarg.h>

int output(FILE* fp, const char* fmt, ...) {
    va_list args;
    va_start(args, fmt);
    int i = vfprintf(fp, fmt, args);
    va_end(args);
    return i;
}

int main() {
    FILE* fp = fopen("a.txt", "w");
    int i, j;
    i = output(fp, "%d+%d=%d\n", 10, 20, 10+20);
    j = output(fp, "%s\n", "Hello");
    printf("%d %d\n", i, j);
    return 0;
}
