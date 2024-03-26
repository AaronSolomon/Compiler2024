#include <stdio.h>
#include <string.h>

union myUnion {
    int n;
    char s[4];
};

int main() {
    union myUnion u;
    strcpy(u.s, "A\0\0\0");
    printf("%d\n", u.n);
    ++u.n;
    printf("%s\n", u.s);
    return 0;
}
