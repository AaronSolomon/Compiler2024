%token WORD
%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyerror(const char*);
extern char* yytext;
%}
%%
WORDS:
     | WORDS WORD       { printf("yytext=%s\n", yytext); }
%%
int main() {
    yyparse();
    return 0;
}

int yyerror(const char* str) {
    fprintf(stderr, "Syntax error\n");
    exit(-2);
}
