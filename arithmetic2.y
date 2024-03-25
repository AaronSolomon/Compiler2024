/* Why isn't the precedence of MUL higher than ADD? */
%token EOL PLUS MINUS MUL DIV NUMBER
%{
#include <stdio.h>
int yylex();
void yyerror(const char*, ...);
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { printf("= %d\n", $2); }

expr: NUMBER
    | expr PLUS NUMBER    { $$ = $1 + $3; }
    | expr MINUS NUMBER    { $$ = $1 - $3; }
    | expr MUL NUMBER     { $$ = $1 * $3; }
    | expr DIV NUMBER     { $$ = $1 / $3; }

%%

int main() {
  printf("Input an expression, and press ENTER to calculate.\n");
  return yyparse();
}
