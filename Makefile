
float.exe: float.l float.y
	bison -d float.y
	flex -ofloat.lex.c float.l
	gcc -o float.exe float.tab.c float.lex.c

rational.exe: rational.l rational.y
	bison -d rational.y
	flex -orational.lex.c rational.l
	gcc -o rational.exe rational.tab.c rational.lex.c

arithmetic3.exe: arithmetic3.l arithmetic3.y
	bison -d arithmetic3.y
	flex -oarithmetic3.lex.c arithmetic3.l
	gcc -o arithmetic3.exe arithmetic3.tab.c arithmetic3.lex.c

arithmetic2.exe: arithmetic2.l arithmetic2.y
	bison -d arithmetic2.y
	flex -oarithmetic2.lex.c arithmetic2.l
	gcc -o arithmetic2.exe arithmetic2.tab.c arithmetic2.lex.c

arithmetic1.exe: arithmetic1.l arithmetic1.y
	bison -d arithmetic1.y
	flex -oarithmetic1.lex.c arithmetic1.l
	gcc -o arithmetic1.exe arithmetic1.tab.c arithmetic1.lex.c

arithmetic.exe: arithmetic.l arithmetic.y
	bison -d arithmetic.y
	flex -oarithmetic.lex.c arithmetic.l
	gcc -o arithmetic.exe arithmetic.tab.c arithmetic.lex.c

sentences.exe: sentences.y sentences.l
	bison -d sentences.y
	flex -osentences.lex.c sentences.l
	gcc -o sentences.exe sentences.tab.c sentences.lex.c

sentence.exe: sentence.y sentence.l
	bison -d sentence.y
	flex -osentence.lex.c sentence.l
	gcc -o sentence.exe sentence.tab.c sentence.lex.c

fb3-1:  fb3-1.l fb3-1.y fb3-1.h
	bison -d fb3-1.y
	flex -ofb3-1.lex.c fb3-1.l
	gcc -o $@ fb3-1.tab.c fb3-1.lex.c fb3-1funcs.c

test:
	./rational.exe

clean:
	rm -f a.out *.o *.exe *.tab.c *.tab.h *.lex.c
