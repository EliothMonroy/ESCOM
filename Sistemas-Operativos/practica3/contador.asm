segment .data

num db 1

segment .text

global _start

_start:
		mov byte[num],30h
		mov edx,1d
		mov ebx,[num]
		ciclo:
				CMP ebx,39h
				je Salir_ciclo
				mov [num],ebx
				mov ecx,num
				mov ebx,1
				mov eax,4
				int 0x80
				mov ebx,[num]
				add ebx, 01h
				jmp ciclo
			Salir_ciclo:
			mov eax,1
			int 0x80