/* Rational Number */
%token EOL DIV INT PLUS MINUS MUL
%define api.value.type { struct Rational }
%{
#include <stdio.h>
int yylex();
void yyerror(const char*, ...);
struct Rational {
    int p;
    int q;
};
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { 
               printf("= %d/%d\n", $2.p, $2.q); }

expr: rational

rational: INT DIV INT   { $$.p = $1; $$.q = $3; }
%%

int main() {
  printf("Input an expression of rational numbers, "
      "and press ENTER to calculate.\n");
  return yyparse();
}
