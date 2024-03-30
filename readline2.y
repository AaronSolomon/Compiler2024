/* Read from a file */
%token WORD
%{
#include <stdio.h>
extern FILE *yyset_in(FILE *);
extern int yylex(void);
extern char* yytext;
void yyerror(const char *s) { fprintf(stderr, "%s\n", s); }
%}

%%
WORDS:
     | WORDS WORD       { printf("yytext=%s\n", yytext); }
%%

int main(int argc, char** argv) {
    FILE* fp = fopen("a.txt", "w");
    fprintf(fp, "This is a book.\n");
    fclose(fp);

    fp = fopen("a.txt", "r");
    yyset_in(fp);
    yyparse();
    return 0;
}
