/* float and int */
%token EOL PLUS MINUS MUL DIV INT FLOAT
%define api.value.type { struct MyValue }
%{
#include <stdio.h>
int yylex();
void yyerror(const char*, ...);
struct MyValue {
    int valueType;
    int n;
    float f;
};
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { 
               if ($2.valueType ==1)
                   printf("= %d\n", $2.n); 
               else
                   printf("= %f\n", $2.f); }

expr: INT       { $$.valueType = 1; $$.n = $1.n; }
    | FLOAT     { $$.valueType = 2; $$.f = yylval.f; }

%%

int main() {
  printf("Input an expression of rational numbers, "
      "and press ENTER to calculate.\n");
  return yyparse();
}
