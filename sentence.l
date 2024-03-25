%option case-insensitive noyywrap noinput nounput
%{
#include <stdarg.h>
#include "sentence.tab.h"
%}
%%

this |
that |
it      { return PRONOUN; }

is |
are     { return BE; }

good |
bad     { return ADJECTIVE; }

not     { return NOT; }

[ \t\n]      { }
%%

void yyerror(char* s, ...) {
  va_list ap;
  va_start(ap, s);

  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, ap);
  fprintf(stderr, "\n");
}
