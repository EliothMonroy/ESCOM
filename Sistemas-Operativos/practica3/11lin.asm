segment .data
	texto1 db 'cadena:',0xA
	lon1 equ $-texto1
	texto2 db 'longitud:',0xA
	lon2 equ $-texto2
segment .bss
	cadena resb 100
	long1 resb 8
	long2 resb 8
segment .text
	global _start
	_start:
		mov byte [long1],0x30
		mov byte [long2],0x30
		mov eax,4
		mov ebx,1
		mov ecx,texto1
		mov edx,lon1
		int 0x80
		mov eax,3
		mov ebx,0
		mov ecx,cadena
		mov edx,100d
		int 0x80
		mov esi,cadena
		mov edi,cadena
	cuenta:
		mov al,[esi]
		inc esi
		mov [edi],al
		inc edi
		cmp byte [long1],0x39
		jne sumarA
		mov byte [long1],0x30
		cmp byte [long2],0x39
		jne sumarB
		mov byte [long2],0x30
		jmp fuera
	sumarB
		add byte [long2],1d
		jmp fuera
	sumarA:
		add byte [long1],1d
	fuera:
		cmp al,0
		jne cuenta
		int 0x80
		mov eax,4
		mov ebx,1
		mov ecx,texto2
		mov edx,lon2
		int 0x80
		sub byte[long1],2d
		cmp byte[long1],'-'
		jne noHacer
		mov byte[long1],'8'
		sub byte[long2],1d
	noHacer:
		cmp byte[long1],'/'
		jne noHacerNada
		mov byte[long1],'9'
		sub byte[long2],1d
	noHacerNada:
		cmp byte[long2],0x30
		je imprimoA
		mov eax,4
		mov ebx,1
		mov ecx,long2
		mov edx,8d
		int 0x80
	imprimoA
		mov eax,4
		mov ebx,1
		mov ecx, long1
		mov edx,8d
		mov byte[ecx+1],0xA
		int 0x80
		mov eax,1
		int 0x80