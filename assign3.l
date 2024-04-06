%option noyywrap noinput nounput 
%{
#include "assign3.tab.h"
#include "assign3.h"
%}
%%

"=" |
"+" |
";" |
"(" |
")" |
"-"     { return yytext[0]; }

print   { return PRINT; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.s = lookup(yytext); return VAR; }
[0-9]+  { yylval.n = atoi(yytext); return NUMBER; }
[ \t] { }
\n      { return EOL; }
%%
