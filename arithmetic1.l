%option yylineno noyywrap noinput nounput
%{
#include <stdio.h>
#include <stdarg.h>
#include "arithmetic1.tab.h"    // Remember to change this
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
[0-9]+  { yylval = atof(yytext); return NUMBER; }
"+"     { return PLUS; }
"-"     { return MINUS; }
[ \t]   { }
\n      { return EOL; }
%%
