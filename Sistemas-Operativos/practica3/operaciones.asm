section .data ; variables inicializadas
	msg1 db "La suma de 4+5 es: ",0xA,0xD
	len1 equ $ - msg1
	msg2 db 0xA,0xD,"La resta de 5-4 es: ",0xA,0xD
	len2 equ $ - msg2
	msg3 db 0xA,0xD,"El incremento de eax=4 es: ",0xA,0xD
	len3 equ $ - msg3
	msg4 db 0xA,0xD,"El decremento de eax=4 es: ",0xA,0xD
	len4 equ $ - msg4
	msg5 db 0xA,0xD,"La multiplicación de 2*2 es: ",0xA,0xD
	len5 equ $ - msg5
	msg6 db 0xA,0xD,"La multiplicación de -2*-2 es: ",0xA,0xD
	len6 equ $ - msg6
	msg7 db 0xA,0xD,"La división de 4/2 es: ",0xA,0xD
	len7 equ $ - msg7
	msg8 db 0xA,0xD,"La división de -4/-2: ",0xA,0xD
	len8 equ $ - msg8
section .bss;variables no inicializados
res resb 1	; reservar un espacio en memoria
section .text
	GLOBAL _start
_start:
	;Suma
	;-----------esta parte imprime el mensaje------
	mov eax,4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg1 ;msg pantalla
	mov edx, len1; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion suma
	mov eax, 4 ; inicializamos a eax con 4
	mov ebx, 5 ; inicializamos ebx con 5
	add eax, ebx ; le asignamos a eax el valor de la suma de eax y ebx
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	; con los corchetes solo modificamos el contenido de res, no la dirección de memoria
	;-----------esta parte imprime el resultado de la suma------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	
	;Resta
	;-----------esta parte imprime el mensaje------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg2 ;msg pantalla
	mov edx, len2; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion resta
	mov eax, 5 ; inicializamos a eax con 4
	mov ebx, 4 ; inicializamos ebx con 5
	sub eax, ebx ; le asignamos a eax el valor de la suma de eax y ebx
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	; con los corchetes solo modificamos el contenido de res, no la dirección de memoria
	;-----------esta parte imprime el resultado de la resta------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	
	;Incremento
	;-----------esta parte imprime el mensaje------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg3 ;msg pantalla
	mov edx, len3; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion incremento
	mov eax, 4 ; inicializamos a eax con 4
	inc eax		; incrementamos eax
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	;-----------esta parte imprime el resultado del incremento------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones

	;Decremento
	;-----------esta parte imprime el mensaje------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg4 ;msg pantalla
	mov edx, len4; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion decremento
	mov eax, 4 ; inicializamos a eax con 4
	dec eax		; decrementamos eax
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	;-----------esta parte imprime el resultado del decremento------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	
	;Multiplicación
	;-----------esta parte imprime el mensaje------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg5 ;msg pantalla
	mov edx, len5; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion multiplicación
	mov eax, 2 ; inicializamos a eax con 4
	mov ebx, 2 ; inicializamos ebx con 5
	mul ebx ; automaticamente multiplica con eax
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	; con los corchetes solo modificamos el contenido de res, no la dirección de memoria
	;-----------esta parte imprime el resultado de la multiplicacion------
	mov eax,4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al 

	;Multiplicación negativa
	;-----------esta parte imprime el mensaje------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg6 ;msg pantalla
	mov edx, len6; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion multi negativa
	mov eax, -2 ; inicializamos a eax con 4
	mov ebx, -2 ; inicializamos ebx con 5
	imul ebx ; automaticamente multiplica con eax
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	; con los corchetes solo modificamos el contenido de res, no la dirección de memoria
	;-----------esta parte imprime el resultado de la suma------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al sistema

	;División
	;-----------esta parte imprime el mensaje------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg7 ;msg pantalla
	mov edx, len7; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion division
	mov eax, 4 ; inicializamos a eax con 4
	mov ebx, 2 ; inicializamos ebx con 5
	mov edx, 0 ; aquí se guarda el residuo
	div ebx ; le asignamos a eax el valor de la division de eax y ebx
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	; con los corchetes solo modificamos el contenido de res, no la dirección de memoria
	;-----------esta parte imprime el resultado de la división------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al sistema

	;DIvision negativa
	;-----------esta parte imprime el mensaje------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, msg8 ;msg pantalla
	mov edx, len8; longitud del mensaje
	int 0x80	;llamada al sistema de interrupciones
	;Operacion division negativa
	mov eax, -4 ; inicializamos a eax con 4
	mov ebx, -2 ; inicializamos ebx con 5
	mov edx, 0 ; el residuo inicializado en 0
	idiv ebx ; le asignamos a eax el valor de la suma de eax y ebx
	add eax,'0' ;para poder imprimirlo necesitamos agregarla un simbolo de escape para que se sepa que es una cadena 
	mov [res],eax ; res recibe el valor actual de eax
	; con los corchetes solo modificamos el contenido de res, no la dirección de memoria
	;-----------esta parte imprime el resultado de la division negativa------
	mov eax, 4	;llamada al sistema sys_write
	mov ebx, 1	;stdout, queremos una salida en pantallas
	mov ecx, res ;msg pantalla
	mov edx, 1; longitud del mensaje
	int 0x80	;llamada al 

	;---Salida del programa---
	mov eax,1	;sys_exit
	int 0x80	;otra vez llamamos al sistema
