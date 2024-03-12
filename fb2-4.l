/* fb2-4 text concordance */
%option noyywrap nodefault yylineno case-insensitive noinput nounput

/* the symbol table */
%{
  #include <stdio.h>
  struct symbol {               /* a word */
    char *name;
    struct ref *reflist;
  };

  struct ref {
    struct ref *next;
    char *filename;
    int flags;
    int lineno;
  };

  /* simple symtab of fixed size */
  #define NHASH 9997
  struct symbol symtab[NHASH];

  struct symbol *lookup(char*);
  void addRef(int, char*, char*,int);
  void printRef();

  char *curfilename;            /* name of current input file */

%}
%%

 /* rules for concordance generator */
 /* skip common words */
a |
an |
and |
are |
as |
at |
be |
but |
for |
in |
is |
it |
of |
on |
or |
that |
the |
this |
to                     /* ignore */

[a-z]+(\'(s|t))?   { addRef(yylineno, curfilename, yytext, 0); }
.|\n                   /* ignore everything else */
%%

/* concordance main routine */
int main(int argc, char** argv) {
  if(argc < 2) { /* just read stdin */
    curfilename = "(stdin)";
    yylineno = 1;       /* Initialize yylineno */
    yylex();
  } else
  for(int i = 1; i < argc; i++) {
    FILE *f = fopen(argv[i], "r");

    if(!f) {
      perror(argv[i]);
      return (1);
    }
    curfilename = argv[i];      /* for addRef */

    yyin = f;
    yylineno = 1; /* Otherwise, the line numbers would */ 
    yylex();      /* continue from one file to another */
    fclose(f);
  }

  printRef();
}

/* hash a symbol */
static unsigned symhash(char *sym) {
  unsigned int hash = 0;
  unsigned c;

  while ((c = *sym++)) hash = hash*9 ^ c;

  return hash;
}

struct symbol* lookup(char* sym) {
  struct symbol *sp = &symtab[symhash(sym) % NHASH];
  int available = NHASH;           

  while(--available >= 0) {
    if(sp->name && !strcasecmp(sp->name, sym)) return sp;

    if(!sp->name) {             /* new entry */
      sp->name = strdup(sym);
      sp->reflist = 0;
      return sp;
    }

    if(++sp >= symtab+NHASH) sp = symtab; /* try the next entry */
  }
  fputs("symbol table overflow\n", stderr);
  abort(); /* tried them all, table is full */
}

void addRef(int lineno, char *filename, char *word, int flags) {
  struct ref *r;
  struct ref *p;
  struct symbol *sp = lookup(word);

  /* don't do dups of same line and file */
  if(sp->reflist &&
     sp->reflist->lineno == lineno &&
     sp->reflist->filename == filename) return;

  r = malloc(sizeof(struct ref));
  if(!r) {fputs("out of space\n", stderr); abort(); }
  if (sp->reflist == NULL)
      sp->reflist = r;
  else {
      for (p=sp->reflist; p->next; p=p->next); /* Find the last node */
      p->next = r;
  }
  r->next = NULL;
  r->filename = filename;
  r->lineno = lineno;
  r->flags = flags;
}

/* print the references
 * sort the table alphabetically
 * and print it out
 */

/* aux function for sorting */
static int symcompare(const void *xa, const void *xb)
{
  const struct symbol *a = xa;
  const struct symbol *b = xb;

  if(!a->name) {
    if(!b->name) return 0;      /* both empty */
    return 1;                   /* put empties at the end */
  }
  if(!b->name) return -1;
  return strcmp(a->name, b->name);
}

void printRef() {
  struct symbol *sp;
  struct ref *rp;

  qsort(symtab, NHASH, sizeof(struct symbol), symcompare); /* sort the symbol table */

  for(sp = symtab; sp->name && sp < symtab+NHASH; sp++) {
    /* print the word and its references */
    char *prevfn = NULL;        /* last printed filename, to skip dups */
    printf("%10s", sp->name);
    for(rp = sp->reflist; rp; rp = rp->next) {
      if(rp->filename == prevfn) {
        printf(" %d", rp->lineno);
      } else {
        printf(" %s:%d", rp->filename, rp->lineno);
        prevfn = rp->filename;
      }
    }
    printf("\n");
  }
}
