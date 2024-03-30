%option noinput nounput noyywrap
%{
#include "readline1.tab.h"
%}
%%
[a-zA-Z]+       { return WORD; }
[ \t\n]
%%
