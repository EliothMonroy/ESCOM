section .data
	msg1 db "Ingrese un numero:",0xA,0xD
	len1 equ $ - msg1
	msg2 db 0xA,0xD,"Ingrese otro numero:",0xA,0xD
	len2 equ $ - msg2
	msg3 db 0xA,0xD,"El resultado es:",0xA,0xD
	len3 equ $ - msg3
	msg4 db "Seleccione una operación:",0xA,0xD,"1(Multiplicacion), 2(Division), 3(Suma), 4(Resta)",0xA,0xD
	len4 equ $ - msg4
	salto db 0xA,0xD
	lens equ $ - salto
section .bss
	num1 resb 1
	num2 resb 1
	res resb 1
	opc resb 1
section .text
	GLOBAL _start
_start:
	;Imprime el primer mensaje
	mov eax, 4 ;llamada al sistema sys_write
	mov ebx, 1 ;salida en pantalla
	mov ecx, msg1 ; mensaje
	mov edx, len1 ; longitud del mensaje
	int 0x80 ; llamada al sistema de interrupciones

	; Para leer el primer numero:
	mov eax, 3; llamada a sys_read
	mov ebx, 2 ; debo investigar esto
	mov ecx, num1; donde se almacenara
	mov edx, 2 ; longitud de la cadena
	int 0x80

	; Pide el segundo numero
	mov eax, 4 ;llamada al sistema sys_write
	mov ebx, 1 ;salida en pantalla
	mov ecx, msg2 ; mensaje
	mov edx, len2 ; longitud del mensaje
	int 0x80
	;Lee el segundo numero
	mov eax, 3 ;llamada al sistema sys_write
	mov ebx, 2 ;salida en pantalla
	mov ecx, num2 ; mensaje
	mov edx, 2 ; longitud de la cadena
	int 0x80

	;Pedimos que seleccione una operacion
	mov eax, 4 ;llamada al sistema sys_write
	mov ebx, 1 ;salida en pantalla
	mov ecx, msg4 ; mensaje
	mov edx, len4 ; longitud del mensaje
	int 0x80

	;Lee la opción
	mov eax, 3 ;llamada al sistema sys_write
	mov ebx, 2 ;salida en pantalla
	mov ecx, opc ; mensaje
	mov edx, 2 ; longitud de la cadena
	int 0x80
	

	;Imprimimos que vamos a imprimir el resultado
	mov eax, 4 ;llamada al sistema sys_write
	mov ebx, 1 ;salida en pantalla
	mov ecx, msg3 ; mensaje
	mov edx, len3 ; longitud del mensaje
	int 0x80

	;aqui iria la condicional
	mov eax,[opc]
	sub eax,'0'
	cmp eax,4
	je division
	cmp eax,3
	je multi
	cmp eax,2
	je resta
	cmp eax,1
	je suma

division:
	;aqui calculo la division
	mov eax, [num1] ; a eax le asignamos el valor del primer numero
	mov ebx, [num2] ; a ebx le asignamos el valor del segundo numero
	sub eax, '0'  ; volvemos un numero la cadena
	sub ebx, '0' ; volvemos un numero la cadena
	mov edx, 0 
	div ebx ; sumamos los numeros
	add eax, '0'  ; volvemos el numero una cadena
	mov [res],eax ; a res le asignamos el resultado
	jmp resultado

suma:
	;aqui calculo la suma
	mov eax, [num1] ; a eax le asignamos el valor del primer numero
	mov ebx, [num2] ; a ebx le asignamos el valor del segundo numero
	sub eax, '0'  ; volvemos un numero la cadena
	sub ebx, '0' ; volvemos un numero la cadena
	add eax, ebx ; sumamos los numeros
	add eax, '0'  ; volvemos el numero una cadena
	mov [res],eax ; a res le asignamos el resultado
	jmp resultado

resta:
	;aqui calculo la resta
	mov eax, [num1] ; a eax le asignamos el valor del primer numero
	mov ebx, [num2] ; a ebx le asignamos el valor del segundo numero
	sub eax, '0'  ; volvemos un numero la cadena
	sub ebx, '0' ; volvemos un numero la cadena
	sub eax, ebx ; sumamos los numeros
	add eax, '0'  ; volvemos el numero una cadena
	mov [res],eax ; a res le asignamos el resultado
	jmp resultado

multi:
	;aqui calculo la multi
	mov eax, [num1] ; a eax le asignamos el valor del primer numero
	mov ebx, [num2] ; a ebx le asignamos el valor del segundo numero
	sub eax, '0'  ; volvemos un numero la cadena
	sub ebx, '0' ; volvemos un numero la cadena
	mul ebx ; sumamos los numeros
	add eax, '0'  ; volvemos el numero una cadena
	mov [res],eax ; a res le asignamos el resultado
	jmp resultado

	; Imprimo el resultado
resultado:
	mov eax, 4 ;llamada al sistema sys_write
	mov ebx, 1 ;salida en pantalla
	mov ecx, res ; mensaje
	mov edx, 1 ; longitud del mensaje
	int 0x80

	; Imprimo un salto de linea
	mov eax, 4 ;llamada al sistema sys_write
	mov ebx, 1 ;salida en pantalla
	mov ecx, salto ; mensaje
	mov edx, lens ; longitud del mensaje
	int 0x80

	; Salida del programa
	mov eax, 1; sys_exit
	int 0x80