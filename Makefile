# $Header: /home/johnl/flnb/code/sql/RCS/Makefile,v 2.1 2009/11/08 02:53:39 johnl Exp $
# Companion source code for "flex & bison", published by O'Reilly
# Media, ISBN 978-0-596-15597-1
# Copyright (c) 2009, Taughannock Networks. All rights reserved.
# See the README file for license conditions and contact info.

CC = cc -g
LEX = flex
YACC = bison
CFLAGS = -DYYDEBUG=1

PROGRAMS4 = pmysql

all:	${PROGRAMS4} 

# chapter 4

pmysql:	pmysql.tab.o pmysql.o
	${CC} -o $@ pmysql.tab.o pmysql.o

pmysql.tab.c pmysql.tab.h:	pmysql.y
	${YACC} -vd pmysql.y

pmysql.c:	pmysql.l
	${LEX} -o $@ $<

pmysql.o:	pmysql.c pmysql.tab.h


clean:
	rm -f pmysql pmysql.tab.c pmysql.tab.h pmysql.c pmysql.tab.o pmysql.o \
	pmysql.output *.lex.c *.tab.[ch] *.exe

.SUFFIXES:	.l .y .c


sql2.exe: sql2.l sql2.y
	bison -d sql2.y
	flex -o sql2.lex.c sql1.l
	gcc -o $@ sql2.tab.c sql2.lex.c 

sql1.exe: sql1.l sql1.y
	bison -d sql1.y
	flex -o sql1.lex.c sql1.l
	gcc -o $@ sql1.tab.c sql1.lex.c 

