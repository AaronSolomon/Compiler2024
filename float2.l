%option yylineno noyywrap noinput nounput
%{
#include <stdio.h>
#include <stdarg.h>
#include "float2.tab.h"
struct MyValue {        // This must be defined in both .l and .y
    int valueType;
    int n;
    float f;
};

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

([0-9]+)?\.[0-9]+  { yylval.valueType = 2; yylval.f = atof(yytext); return FLOAT; }
[0-9]+\.  { yylval.valueType = 2; yylval.f = atof(yytext); return FLOAT; }
[0-9]+    { yylval.valueType = 1; yylval.n = atoi(yytext); return INT; }

"+" { return PLUS; }
"-" { return MINUS; }
"*" { return MUL; }
"/" { return DIV; }

[ \t]      { }
\n      { return EOL; }
%%
