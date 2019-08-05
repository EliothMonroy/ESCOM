;This is a coment
				global  _mainCRTStartup		;This is the main program entry point
				EXTERN  _ExitProcess@4		;Windows API call to exit the process
				EXTERN  _GetStdHandle@4		;Windows Api call to get the standard output handle
				EXTERN  _WriteFile@20		;Windows API call to write to a handle
				section .data				;start of the data segment
hello_world		db		'Hello World',10,0	;The hello world message
bytes_written	dd		0					;Return 32-bit word from WriteFile
				section .code				;Start of the code segment
				;We need to hold of the standard output handle so we can write
				;our 'Hello World' text to it. This is provided by the GetStdHandle
				;windows Api call
_mainCRTStartup:
				push    -11					;We want the standard output handle
				call    _GetStdHandle@4		;Call the windows API GetStdHandle to retrieve it
				; The EAX register now contains the handle we need to write to. As
				; we are just going to stack the parameters needed for the WriteFile
				; API call, and the push instruction does not affect the registers,
				; we can leave the returned handle in EAX for the moment
				push    0					;We do not want overlapped I/O
				push    dword bytes_written ;The address of the number of bytes written
				push    13					;The length of the text we are writing
				push    dword hello_world   ;The address of the text we are writing
				push    eax                 ;The handle returned from GetStdHandle call
				call    _WriteFile@20       ;Write the text to the standard output handle
				;The text has been written, so all we need to do now is exit the
				;process and return control back to the console
				push    0                   ;Stack the exit code
				call    _ExitProcess@4      ;Exit the process