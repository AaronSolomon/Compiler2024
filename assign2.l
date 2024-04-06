%option noyywrap noinput nounput 
%{
#include "assign2.tab.h"
%}
%%

"=" |
"+" |
";" |
"-"     { return yytext[0]; }

print   { return PRINT; }
[a-zA-Z_][a-zA-Z0-9_]*  { return VAR; }
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
[ \t\n] { }
%%
