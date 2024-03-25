%{
#include <stdio.h>
%}
%token PRONOUN BE NOT ADJECTIVE


%%
sentence: affirmative   { printf("肯定句\n"); }
        | negative      { printf("否定句\n"); }
        | interrogative { printf("疑問句\n"); }

affirmative: PRONOUN BE ADJECTIVE

negative: PRONOUN BE NOT ADJECTIVE

interrogative: BE PRONOUN ADJECTIVE

%%

int main() {
  return yyparse();
}
