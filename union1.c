#include <stdio.h>

struct Type1 {
    int valueType;
    int n;
    float f;
};

struct Type2 {
    int valueType;
    union MyUnion {
        int n;
        float f;
    } u;
};

int main() {
    struct Type1 a = { 1, 0, 0.0 };
    struct Type2 b = { 2, {3} }; // Only the first member of the union
    printf("%ld\n", sizeof(a));
    printf("%ld %d %d\n", sizeof(b), b.valueType, b.u.n);
    return 0;
}
