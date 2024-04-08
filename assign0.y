/* shift/reduce conflict */
%token NUMBER VAR PRINT 
%%
stmt : expr
     | PRINT expr

expr : assignment               /* conflict: VAR '=' expr '+' NUMBER */
     | NUMBER                   /*           ^----------^            */
     | expr '+' NUMBER          /*              assignment           */
                                /*                   ^-------------^ */
assignment: VAR '=' expr        /*                      expr         */

%%
int main() {
    yyparse();
    return 0;
}
