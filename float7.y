/* Simplify float1.l by %union */
%token EOL PLUS MINUS MUL DIV 
%union {
    int i;
    float f;
}
%token <i> INT
%token <f> FLOAT
%type <f> expr
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
