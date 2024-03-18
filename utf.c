#include <stdio.h>

int main() {
    char a[] = "\u66a8\u5357\u5927\u5b78";
    char b[] = "\U000066a8\U00005357\U00005927\U00005b78";
    printf("%s\n%s\n", a, b);
    return 0;
}
