/* symbol table */
struct symbol {         /* a variable name */
  char *name;
  int value;
};

struct symbol *lookup(char*);
