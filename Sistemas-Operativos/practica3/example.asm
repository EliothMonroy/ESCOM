segment .data
	handleConsola	dd 1		;Primer Argumento para la llamada al sistema _WriteConsoleA()
	cadImprimir		db 'Ensamblado en Windows', 0xA ; Segundo argumento para la llamada al sistema _WriteConsoleA()
	longitudCadena	dd 1		;Tercer argumento para la llamada al sistema _WriteConsoleA()
	caractEscritos	dd 1		;Cuarto argumento para la llamada al sistema _WriteConsoleA()
	ultimoArgumento	dd 1		;Quinto argumento para la llamada al sistema _WriteConsoleA()
segment .text
GLOBAL _main
EXTERN _GetStdHandle@4			;Acceso externo a la llamada al sistema _GetStdHandle()
EXTERN _WriteConsoleA@20		;Acceso externo a la llamada al sistema _WriteConsoleA()
EXTERN _ExitProcess@4			;Acceso externo a la llamada al sistema _ExitProcess()
_main:
		push dword -11			;Argumento pasado a la pila y usado en _GetStdHandle() para la salida estándar
		call _GetStdHandle@4	;Invocación de _GetStdHandle()
		mov [handleConsola],eax	;Devolución del manejador de consola para escritura en el registro eax
		
		xor eax,eax
		mov eax,23d
		mov [longitudCadena],eax
		xor eax,eax				;Limpieza del registro eax (eax=0)
		mov eax,0d				;eax=0 valor del ultimo argumento de _WriteCOnsoleA()
		mov [ultimoArgumento],eax ;Se guarda el valor del último argumento en memoria.

		push dword [ultimoArgumento] ; Quinto argumento de _WriteConsoleA() pasado por la pila.
		push dword caractEscritos;Cuarto argumento de _WriteConsoleA() pasado por la pila
		push dword [longitudCadena] ;Tercer argumento de _WriteConsoleA() pasado por la pila
		push dword cadImprimir  ;Segundo argumento de _WriteConsoleA() pasado por la pila
		push dword [handleConsola];Primer argumento de _WriteConsoleA() pasado por la pila
		call _WriteConsoleA@20	;Invocación de _WriteConsoleA()

		xor eax,eax 			;Limpieza del registro eax(eax=0)
		mov eax,0d				;eax=0 valor del argumento de _ExitProcess()
		mov [ultimoArgumento],eax;Se guarda el valor del argumento en memoria
		push dword[ultimoArgumento];Argumento de _ExitProcess() pasado por la pila
		call _ExitProcess@4		;Invocación de _ExitProcess()