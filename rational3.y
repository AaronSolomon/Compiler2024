/* Addition of Rational Numbers */
%token EOL DIV INT PLUS MINUS MUL RATIONAL
%define api.value.type { struct Rational }
%{
#include <stdio.h>
int yylex();
void yyerror(const char*, ...);
struct Rational {
    int p;
    int q;
};
struct Rational add(struct Rational a, struct Rational b);
void reduce(struct Rational* a);
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { 
               struct Rational a = $2;
               reduce(&a);
               printf("= %d/%d\n", a.p, a.q); }

expr: RATIONAL
    | expr PLUS RATIONAL { $$ = add($1, $3); }

%%

int main() {
  printf("Input an expression of rational numbers, "
      "and press ENTER to calculate.\n");
  return yyparse();
}

struct Rational add(struct Rational a, struct Rational b) {
   struct Rational c;
   c.p = a.p * b.q + a.q * b.p;
   c.q = a.q * b.q;
   return c;
}

int gcd(int a, int b) {
    if (b == 0)
        return a;
    else 
        return gcd(b, a % b);
}

void reduce(struct Rational* a) {
   int n = gcd(a->p, a->q);
   a->p /= n;
   a->q /= n;
}
