/* Addition,Subtraction,Multiplication,Division of Rational Numbers */
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
struct Rational sub(struct Rational a, struct Rational b);
struct Rational mul(struct Rational a, struct Rational b);
struct Rational div(struct Rational a, struct Rational b);
void reduce(struct Rational* a);
%}

%%
calculation: /* nothing */
           | calculation expr EOL       { 
               struct Rational a = $2;
               reduce(&a);
               printf("= %d", a.p); 
               if (a.q != 1)
                   printf("/%d", a.q);
               printf("\n");
               }

expr: factor
    | expr PLUS factor { $$ = add($1, $3); }
    | expr MINUS factor { $$ = sub($1, $3); }

factor: RATIONAL
    | factor MUL RATIONAL { $$ = mul($1, $3); }
    | factor DIV RATIONAL { $$ = div($1, $3); }

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

struct Rational sub(struct Rational a, struct Rational b) {
   struct Rational c;
   c.p = a.p * b.q - a.q * b.p;
   c.q = a.q * b.q;
   return c;
}

struct Rational mul(struct Rational a, struct Rational b) {
   struct Rational c;
   c.p = a.p * b.p;
   c.q = a.q * b.q;
   return c;
}

struct Rational div(struct Rational a, struct Rational b) {
   struct Rational c;
   c.p = a.p * b.q;
   c.q = a.q * b.p;
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
