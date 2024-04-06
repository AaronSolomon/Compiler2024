/* c = a + b */
%right '='
%left  '+' '-'

%union {
  int n;
  struct symbol *s;
}
%token <n> NUMBER
%type  <n> expr
%token <s> VAR
%type <s> assignment
%token PRINT EOL
%{
#include <stdio.h>
#include "assign3.h"
int yylex();
void yyerror(const char *s) { fprintf(stderr, "%s\n", s); }
%}
%%
stmts :                         
      | stmts stmt EOL          { printf("> "); }

stmt : expr
     | PRINT expr               { printf("%d\n", $2); }

expr : assignment               { $$ = $1->value; } 
     | NUMBER                   { $$ = $1; }
     | VAR                      { $$ = $1->value; }
     | expr '+' expr            { $$ = $1 + $3; }
     | '(' expr ')'             { $$ = $2; }
                                
assignment: VAR '=' expr        { $1->value = $3; $$ = $1; }

%%
