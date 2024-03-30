%option yylineno noyywrap noinput nounput
%{
#include <stdio.h>
#include <stdarg.h>
#include "rational.tab.h"
void yyerror(char* s, ...) {
  va_list args;
  va_start(args, s);
  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, args);
  fprintf(stderr, "\n");
  va_end(args);
}
%}
%%

[0-9]+  { yylval = atoi(yytext); return INT; }

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MUL; }
"/" { return DIV; }

[ \t]      { }
\n      { return EOL; }
%%
