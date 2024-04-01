/* union */
%token EOL PLUS MINUS MUL DIV INT FLOAT
%define api.value.type { struct MyValue }
%{
#include <stdio.h>
int yylex();
void yyerror(const char*, ...);
struct MyValue {
    int valueType;
    union myUnion {
      int n;
      float f;
    } u;
};
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { 
               if ($2.valueType ==1)
                   printf("= %d\n", $2.u.n); 
               else
                   printf("= %f\n", $2.u.f); }

expr: factor    { if ($1.valueType == 1) {
                     $$.valueType = 1;
                     $$.u.n = $1.u.n;
                  } else {
                     $$.valueType = 2;
                     $$.u.f = $1.u.f;
                  }
                }
    | expr PLUS factor { if ($1.valueType == 1) {
                            if ($3.valueType == 1) {
                               $$.valueType = 1;
                               $$.u.n = $1.u.n + $3.u.n;
                            } else {
                               $$.valueType = 2;
                               $$.u.f = (float) $1.u.n + $3.u.f;
                            }
                         } else {
                            if ($3.valueType == 1) {
                               $$.valueType = 2;
                               $$.u.f = $1.u.f + (float) $3.u.n;
                            } else {
                               $$.valueType = 2;
                               $$.u.f = $1.u.f + $3.u.f;
                            }
                         }
                    }

expr: expr MINUS factor { if ($1.valueType == 1) {
                            if ($3.valueType == 1) {
                               $$.valueType = 1;
                               $$.u.n = $1.u.n - $3.u.n;
                            } else {
                               $$.valueType = 2;
                               $$.u.f = (float) $1.u.n - $3.u.f;
                            }
                         } else { // $1.valueType == T_FLOAT
                            if ($3.valueType == 1) {
                               $$.valueType = 2;
                               $$.u.f = $1.u.f - (float) $3.u.n;
                            } else {
                               $$.valueType = 2;
                               $$.u.f = $1.u.f - $3.u.f;
                            }
                         }
                    }

factor: INT       { $$.valueType = 1; $$.u.n = yylval.u.n; }
    | FLOAT       { $$.valueType = 2; $$.u.f = yylval.u.f; }
    | factor MUL INT { if ($1.valueType == 1) {
                         $$.valueType = 1;
                         $$.u.n = $1.u.n * $3.u.n;
                      } else {
                         $$.valueType = 2;
                         $$.u.f = $1.u.f * (float) $3.u.n;
                      }
                    }
    | factor MUL FLOAT { if ($1.valueType == 1) {
                         $$.valueType = 2;
                         $$.u.f = (float) $1.u.n * $3.u.f;
                      } else {
                         $$.valueType = 2;
                         $$.u.f = $1.u.f * $3.u.f;
                      }
                    }
    | factor DIV INT { if ($1.valueType == 1) {
                         $$.valueType = 2;
                         $$.u.f = (float) $1.u.n / $3.u.n;
                      } else {
                         $$.valueType = 2;
                         $$.u.f = $1.u.f / (float) $3.u.n;
                      }
                    }
    | factor DIV FLOAT { if ($1.valueType == 1) {
                         $$.valueType = 2;
                         $$.u.f = (float) $1.u.n / $3.u.f;
                      } else {
                         $$.valueType = 2;
                         $$.u.f = $1.u.f / $3.u.f;
                      }
                    }

%%

int main() {
  printf("Input an expression of rational numbers, "
      "and press ENTER to calculate.\n");
  return yyparse();
}
