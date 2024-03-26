/* Add parenthesis */
%token EOL PLUS MINUS MUL DIV NUMBER OP CP
%{
#include <stdio.h>
int yylex();
void yyerror(const char*, ...);
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { printf("= %d\n", $2); }

expr: factor            /* default action is $$ = $1; */
    | expr PLUS factor     { $$ = $1 + $3; }
    | expr MINUS factor    { $$ = $1 - $3; }

factor: NUMBER
    | factor MUL NUMBER     { $$ = $1 * $3; }
    | factor DIV NUMBER     { $$ = $1 / $3; }
    | OP expr CP            { $$ = $2; }

%%

int main() {
  printf("Input an expression, and press ENTER to calculate.\n");
  return yyparse();
}
