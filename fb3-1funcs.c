/* Companion source code for "flex & bison", published by O'Reilly
 * Media, ISBN 978-0-596-15597-1
 * Copyright (c) 2009, Taughannock Networks. All rights reserved.
 * See the README file for license conditions and contact info.
 * $Header: /home/johnl/flnb/code/RCS/fb3-1funcs.c,v 2.1 2009/11/08 02:53:18 johnl Exp $
 */
/*
 * helper functions for fb3-1
 */
#  include <stdio.h>
#  include <stdlib.h>
#  include <stdarg.h>
#  include "fb3-1.h"

struct ast* newast(int nodetype, struct ast* l, struct ast* r) {
  struct ast* p = malloc(sizeof(struct ast));
  
  if(!p) {
    yyerror("out of space");
    exit(0);
  }
  p->nodetype = nodetype;
  p->l = l;
  p->r = r;
  return p;
}

struct ast* newnum(double d) {
  struct numval* p = malloc(sizeof(struct numval));
  
  if(!p) {
    yyerror("out of space");
    exit(0);
  }
  p->nodetype = 'K';
  p->number = d;
  return (struct ast*) p;
}

double eval(struct ast* p) {
  double v;

  switch(p->nodetype) {
  case 'K': v = ((struct numval *)p)->number; break;

  case '+': v = eval(p->l) + eval(p->r); break;
  case '-': v = eval(p->l) - eval(p->r); break;
  case '*': v = eval(p->l) * eval(p->r); break;
  case '/': v = eval(p->l) / eval(p->r); break;
  case '|': v = eval(p->l); if(v < 0) v = -v; break;
  case 'M': v = -eval(p->l); break;
  default: printf("internal error: bad node %c\n", p->nodetype);
  }
  return v;
}

void treefree(struct ast* p) {
  switch(p->nodetype) {

    /* two subtrees */
  case '+':
  case '-':
  case '*':
  case '/':
    treefree(p->r);

    /* one subtree */
  case '|':
  case 'M':
    treefree(p->l);

    /* no subtree */
  case 'K':
    free(p);
    break;

  default: printf("internal error: free bad node %c\n", p->nodetype);
  }
}

void yyerror(char* s, ...) {
  va_list ap;
  va_start(ap, s);

  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, ap);
  fprintf(stderr, "\n");
}

int main() {
  printf("> "); 
  return yyparse();
}
