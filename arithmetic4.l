%option yylineno noyywrap noinput nounput
%{
#include <stdio.h>
#include <stdarg.h>
#include "arithmetic4.tab.h"
void yyerror(char* s, ...) {
  va_list ap;
  va_start(ap, s);

  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, ap);
  fprintf(stderr, "\n");
}
%}
%%

[0-9]+  { yylval = atoi(yytext); return NUMBER; }

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MUL; }
"/" { return DIV; }
"(" { return OP; }
")" { return CP; }

[ \t]      { }
\n      { return EOL; }
%%
