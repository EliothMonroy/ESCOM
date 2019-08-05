
run:a.out
	./a.out
a.out:main.o agenda.o
	gcc main.o agenda.o
main.o:main.c
	gcc -c main.c
agenda.o:agenda.c
	gcc -c agenda.c
clear:
	-rm main.o agenda.o a.out