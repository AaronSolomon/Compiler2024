/* +,-,*,/ */
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

expr: factor    { if ($1.valueType == 1) {
                     $$.valueType = 1;
                     $$.n = $1.n;
                  } else {
                     $$.valueType = 2;
                     $$.n = $1.f;
                  }
                }
    | expr PLUS factor { if ($1.valueType == 1) {
                            if ($3.valueType == 1) {
                               $$.valueType = 1;
                               $$.n = $1.n + $3.n;
                            } else {
                               $$.valueType = 2;
                               $$.f = (float) $1.n + $3.f;
                            }
                         } else {
                            if ($3.valueType == 1) {
                               $$.valueType = 2;
                               $$.f = $1.f + (float) $3.n;
                            } else {
                               $$.valueType = 2;
                               $$.f = $1.f + $3.f;
                            }
                         }
                    }

expr: expr MINUS factor { if ($1.valueType == 1) {
                            if ($3.valueType == 1) {
                               $$.valueType = 1;
                               $$.n = $1.n - $3.n;
                            } else {
                               $$.valueType = 2;
                               $$.f = (float) $1.n - $3.f;
                            }
                         } else {
                            if ($3.valueType == 1) {
                               $$.valueType = 2;
                               $$.f = $1.f - (float) $3.n;
                            } else {
                               $$.valueType = 2;
                               $$.f = $1.f - $3.f;
                            }
                         }
                    }

factor: INT       { $$.valueType = 1; $$.n = yylval.n; }
    | FLOAT     { $$.valueType = 2; $$.f = yylval.f; }
    | factor MUL INT { if ($1.valueType == 1) {
                         $$.valueType = 1;
                         $$.n = $1.n * $3.n;
                      } else {
                         $$.valueType = 2;
                         $$.f = $1.f * (float) $3.n;
                      }
                    }
    | factor MUL FLOAT { if ($1.valueType == 1) {
                         $$.valueType = 2;
                         $$.f = (float) $1.n * $3.f;
                      } else {
                         $$.valueType = 2;
                         $$.f = $1.f * $3.f;
                      }
                    }
    | factor DIV INT { if ($1.valueType == 1) {
                         $$.valueType = 1;
                         $$.n = $1.n / $3.n;
                      } else {
                         $$.valueType = 2;
                         $$.f = $1.f / (float) $3.n;
                      }
                    }
    | factor DIV FLOAT { if ($1.valueType == 1) {
                         $$.valueType = 2;
                         $$.f = (float) $1.n / $3.f;
                      } else {
                         $$.valueType = 2;
                         $$.f = $1.f / $3.f;
                      }
                    }

%%

int main() {
  printf("Input an expression of rational numbers, "
      "and press ENTER to calculate.\n");
  return yyparse();
}
