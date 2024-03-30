// readline()
%token WORD
%{
#include <stdio.h>
#include <string.h>
#include <readline/readline.h>
#include <readline/history.h>
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
    char* buffer = NULL;
    while ((buffer = readline("$ "))) {
        add_history(buffer);
        yyset_in(fmemopen(buffer, strlen(buffer), "r"));
        yyparse();
        free(buffer);
    }
    return 0;
}
