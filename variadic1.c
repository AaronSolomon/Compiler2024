#include <stdio.h>
#include <stdarg.h>

// Variadic function to calculate the sum of integers
int sum(int dummy, ...) {
    int result = 0;
    va_list args; // Define a variable to hold the list of arguments
    va_start(args, dummy); // Initialize the argument list
                // ^ This parameter designates where to start fetching arguments

    int n;
    while ((n = va_arg(args, int)) != 0) {
        result += n;
    }

    va_end(args); // Clean up the argument list
    return result;
}

int main() {
    printf("Sum: %d\n", sum(3, 10, 20, 30)); // Calling the variadic function with 3 arguments
    printf("Sum: %d\n", sum(5, 1, 2, 3, 4, 5)); // Calling the variadic function with 5 arguments
    return 0;
}
