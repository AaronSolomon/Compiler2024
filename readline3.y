%token WORD
%{
#include <stdio.h>
#include <string.h>
extern FILE *yyset_in(FILE *);
extern int yylex(void);
extern char* yytext;
void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}
%}

%%
WORDS:
     | WORDS WORD       { printf("yytext=%s\n", yytext); }
%%

int main(int argc, char** argv) {
    char buffer[] = "This is a car";
    yyset_in(fmemopen(buffer, strlen(buffer), "r"));
    yyparse();
    return 0;
}
