/* Only Addition */
%token EOL PLUS NUMBER
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

%%

int main() {
  printf("Input an expression, and press ENTER to calculate.\n");
  return yyparse();
}
