/* Demonstrate left-associativity */
%left  ';'
%right '='
%left  '+' '-'

%token NUMBER VAR PRINT 
%{
#include <stdio.h>
int yylex();
void yyerror(const char *s) { fprintf(stderr, "%s\n", s); }
%}
%%
stmts :                         /* Without this, 2nd line is syntax error */
      | stmts stmt

stmt : expr
     | PRINT expr

expr : assignment               
     | NUMBER                   { $$ = $1; printf("%d\n", $1); }
     | expr '+' expr          { $$ = $1 + $3; printf("%d + %d\n", $1, $3); }
                                
assignment: VAR '=' expr        

%%
int main() {
    yyparse();
    return 0;
}
