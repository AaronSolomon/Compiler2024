%option noyywrap yylineno noinput nounput
%{
#include "sql1.tab.h"
#include <string.h>
%} 

%%
 /* single character ops */
"+" |
"-" |
"*" |
"/"     { return yytext[0]; }

[a-zA-Z][a-zA-Z0-9]*  { yylval.s = strdup(yytext); return NAME; }
[0-9]+  { yylval.d = atoi(yytext); return INTNUM; }
[ \n]   {}
%%
