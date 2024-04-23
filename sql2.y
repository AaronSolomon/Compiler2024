%union {
    char* s;
    int d;
}
%token <s> NAME
%token <d> INTNUM
%type <d> expr 
%left '+' '-'
%left '*' '/'
%{
#include <stdio.h>
int yylex();
void yyerror(const char *s) { fprintf(stderr, "%s\n", s); }
%}

%%
expr: NAME      { printf("NAME %s,", $1); }
    | INTNUM    { printf("NUMBER %d,", $1); }
    | expr '+' expr { printf("ADD,"); }
    | expr '-' expr { printf("SUB,"); }
    | expr '*' expr { printf("MUL,"); }
    | expr '/' expr { printf("DIV,"); }
    | '(' expr ')' { $$ = $2; }
%%

int main() {
    yyparse();
    return 0;
}
