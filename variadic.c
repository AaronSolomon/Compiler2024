#include <stdio.h>
#include <stdarg.h>

// Variadic function to calculate the sum of integers
int sum(int count, ...) {
    int result = 0;
    va_list args; // Define a variable to hold the list of arguments
    va_start(args, count); // Initialize the argument list

    for (int i = 0; i < count; i++) {
        result += va_arg(args, int); // Access each argument
    }

    va_end(args); // Clean up the argument list
    return result;
}

int main() {
    printf("Sum: %d\n", sum(3, 10, 20, 30)); // Calling the variadic function with 3 arguments
    printf("Sum: %d\n", sum(5, 1, 2, 3, 4, 5)); // Calling the variadic function with 5 arguments
    return 0;
}
