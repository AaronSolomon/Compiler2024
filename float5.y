/* 1. int / int -> float
   2. Use "enum".
 */

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
enum ValueType { T_INT=1, T_FLOAT };
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { 
               if ($2.valueType ==T_INT)
                   printf("= %d\n", $2.n); 
               else
                   printf("= %f\n", $2.f); }

expr: factor    { if ($1.valueType == T_INT) {
                     $$.valueType = T_INT;
                     $$.n = $1.n;
                  } else {
                     $$.valueType = T_FLOAT;
                     $$.n = $1.f;
                  }
                }
    | expr PLUS factor { if ($1.valueType == T_INT) {
                            if ($3.valueType == T_INT) {
                               $$.valueType = T_INT;
                               $$.n = $1.n + $3.n;
                            } else {
                               $$.valueType = T_FLOAT;
                               $$.f = (float) $1.n + $3.f;
                            }
                         } else {
                            if ($3.valueType == T_INT) {
                               $$.valueType = T_FLOAT;
                               $$.f = $1.f + (float) $3.n;
                            } else {
                               $$.valueType = T_FLOAT;
                               $$.f = $1.f + $3.f;
                            }
                         }
                    }

expr: expr MINUS factor { if ($1.valueType == T_INT) {
                            if ($3.valueType == T_INT) {
                               $$.valueType = T_INT;
                               $$.n = $1.n - $3.n;
                            } else {
                               $$.valueType = T_FLOAT;
                               $$.f = (float) $1.n - $3.f;
                            }
                         } else {
                            if ($3.valueType == T_INT) {
                               $$.valueType = T_FLOAT;
                               $$.f = $1.f - (float) $3.n;
                            } else {
                               $$.valueType = T_FLOAT;
                               $$.f = $1.f - $3.f;
                            }
                         }
                    }

factor: INT       { $$.valueType = T_INT; $$.n = yylval.n; }
    | FLOAT     { $$.valueType = T_FLOAT; $$.f = yylval.f; }
    | factor MUL INT { if ($1.valueType == T_INT) {
                         $$.valueType = T_INT;
                         $$.n = $1.n * $3.n;
                      } else {
                         $$.valueType = T_FLOAT;
                         $$.f = $1.f * (float) $3.n;
                      }
                    }
    | factor MUL FLOAT { if ($1.valueType == T_INT) {
                         $$.valueType = T_FLOAT;
                         $$.f = (float) $1.n * $3.f;
                      } else {
                         $$.valueType = T_FLOAT;
                         $$.f = $1.f * $3.f;
                      }
                    }
    | factor DIV INT { if ($1.valueType == T_INT) {
                         $$.valueType = T_FLOAT;
                         $$.f = (float) $1.n / (float) $3.n;
                      } else {
                         $$.valueType = T_FLOAT;
                         $$.f = $1.f / (float) $3.n;
                      }
                    }
    | factor DIV FLOAT { if ($1.valueType == T_INT) {
                         $$.valueType = T_FLOAT;
                         $$.f = (float) $1.n / $3.f;
                      } else {
                         $$.valueType = T_FLOAT;
                         $$.f = $1.f / $3.f;
                      }
                    }

%%

int main() {
  printf("Input an expression of rational numbers, "
      "and press ENTER to calculate.\n");
  return yyparse();
}
