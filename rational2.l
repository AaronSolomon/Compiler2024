%option yylineno noyywrap noinput nounput
%{
#include <stdio.h>
#include <stdarg.h>
#include "rational2.tab.h"
void yyerror(char* s, ...) {
  va_list args;
  va_start(args, s);
  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, args);
  fprintf(stderr, "\n");
  va_end(args);
}

struct Rational {
    int p;
    int q;
};
%}
%%

[0-9]+"/"[0-9]+  { sscanf(yytext, "%d/%d", &(yylval.p), &(yylval.q)); 
                        return RATIONAL; }

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MUL; }
"/" { return DIV; }

[ \t]      { }
\n      { return EOL; }
%%
