section .data ; aquí son las variables
	;tanto db como equ son directivas
	msg db "Hola Mundo!!!!",0xA,0xD ; 0xA=10 (se pone al principio de la linea)
	;0xD=13(Salto de linea)
	;db es como un igual
	;hay otras directivas como:
	;db -> byte
	;dw -> word
	;dd -> double word
	;dq -> word ^2
	;dt -> diez bytes
	len equ $ - msg
	;equ es para asignar constantes
section .text ; el programa
	global _start
_start:
	mov eax, 4 ; llamada al sistema (sys_write)
	;eax=4
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg ;msg pantalla
	mov edx, len; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	mov eax,1	;sys_exit
	int 0x80	;otra vez llamamos al sistema