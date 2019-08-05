all:
	nasm -f elf lectura_teclado.asm
	ld -m elf_i386 -s -o lectura lectura_teclado.o
	./lectura
clean:
	rm -f contador.o contador hola hola_mundo.o operaciones.o operacion lectura_teclado.o lectura