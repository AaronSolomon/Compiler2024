
float7.exe: float7.l float7.y
	bison -d float7.y
	flex -ofloat7.lex.c float7.l
	gcc -o float7.exe float7.tab.c float7.lex.c

float6.exe: float2.l float6.y
	bison --header=float2.tab.h float6.y
	flex -ofloat2.lex.c float2.l
	gcc -o float6.exe float6.tab.c float2.lex.c

float5.exe: float2.l float5.y
	bison --header=float2.tab.h float5.y
	flex -ofloat2.lex.c float2.l
	gcc -o float5.exe float5.tab.c float2.lex.c

float4.exe: float2.l float4.y
	bison --header=float2.tab.h float4.y
	flex -ofloat2.lex.c float2.l
	gcc -o float4.exe float4.tab.c float2.lex.c

float3.exe: float2.l float3.y
	bison --header=float2.tab.h float3.y
	flex -ofloat2.lex.c float2.l
	gcc -o float3.exe float3.tab.c float2.lex.c

float2.exe: float2.l float2.y
	bison -d float2.y
	flex -ofloat2.lex.c float2.l
	gcc -o float2.exe float2.tab.c float2.lex.c

float1.exe: float1.l float1.y
	bison -d float1.y
	flex -ofloat1.lex.c float1.l
	gcc -o float1.exe float1.tab.c float1.lex.c

rational5.exe: rational5.l rational4.y
	bison --header=rational5.tab.h -orational5.tab.c rational4.y
	flex -orational5.lex.c rational5.l
	gcc -o rational5.exe rational5.tab.c rational5.lex.c

rational4.exe: rational2.l rational4.y
	bison --header=rational2.tab.h rational4.y
	flex -orational2.lex.c rational2.l
	gcc -o rational4.exe rational4.tab.c rational2.lex.c

rational3.exe: rational2.l rational3.y
	bison --header=rational2.tab.h rational3.y
	flex -orational2.lex.c rational2.l
	gcc -o rational3.exe rational3.tab.c rational2.lex.c

rational2.exe: rational2.l rational2.y
	bison -d rational2.y
	flex -orational2.lex.c rational2.l
	gcc -o rational2.exe rational2.tab.c rational2.lex.c

rational.exe: rational.l rational.y
	bison -d rational.y
	flex -orational.lex.c rational.l
	gcc -o rational.exe rational.tab.c rational.lex.c

arithmetic4.exe: arithmetic4.l arithmetic4.y
	bison -d arithmetic4.y
	flex -oarithmetic4.lex.c arithmetic4.l
	gcc -o arithmetic4.exe arithmetic4.tab.c arithmetic4.lex.c

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
