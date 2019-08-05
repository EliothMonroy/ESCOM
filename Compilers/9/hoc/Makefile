run: analizador.out
	./analizador.out
analizador.out: hoc.tab.o lex.yy.o
	gcc -lm -lfl lex.yy.o hoc.tab.o -o ./analizador.out
lex.yy.o: lex.yy.c
	gcc -c -lfl -Wall lex.yy.c -o lex.yy.o
lex.yy.c:
	flex hoc.l
hoc.tab.o: hoc.tab.c
	gcc -c -Wall hoc.tab.c -o hoc.tab.o
hoc.tab.c:
	bison -d -Wconflicts-sr hoc.y
lex:
	flex hoc.l
clean:
	rm -f *.o ./analizador.out ./hoc.tab.* ./lex.yy.c