/* Set default data type to float */
%token EOL PLUS MINUS MUL DIV INT FLOAT
%define api.value.type { float }
%{
#include <stdio.h>
int yylex();
void yyerror(const char*, ...);
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { 
                   printf("= %f\n", $2); }

expr: INT       { $$ = (float) $1; }
    | FLOAT     { $$ = $1; }
    | expr PLUS INT { 
                         $$ = $1 + (float) $3;
                    }
    | expr PLUS FLOAT {
                         $$ = $1 + $3;
                      }

%%

int main() {
  printf("Input an expression of rational numbers, "
      "and press ENTER to calculate.\n");
  return yyparse();
}
