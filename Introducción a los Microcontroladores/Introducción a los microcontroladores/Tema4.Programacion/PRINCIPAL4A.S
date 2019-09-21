;/**@brief ESTE PROGRAMA LEE LOS VALORES COLOCADOS EN EL PUERTO D
; * (RD3, RD2, RD2, RD0) MEDIANTE UN DIP-SWITCH. EL VALOR LEIDO 
; * ES DECODIFICADO PARA MOSTRAR UN NUMERO DE BOLETA 2015...EN UN 
; * DISPLAY DE 7 SEGMENTOS DE ANODO COMUN CONECTADO EN EL PUERTO B 
; * (RB6, ..., RB0). SE USA COMPARACIONES CON LA INSTRUCCION CP
; * EL DECODIFICADOR ES:
; *	    A
; *	---------
; *   F|	 |B
; *    |    G	 |
; *	---------
; *   E|	 |C
; *    |    	 |
; *	---------
; *	    D	
; * RD3 RD2 RD1 RD0 RB6-A RB5-B RB4-C RB3-D RB2-E RB1-F RB0-G CODIGO DIGITO
; *  0   0   0   0    1	    1     0     1     1     0     1    0X6D	2
; *  0   0   0   1    1	    1     1     1     1     1     0    0X7E	0
; *  0   0   1   0    0	    1     1     0     0     0     0    0X30	1
; *  0   0   1   1    1	    0     1     1     0     1     1    0X5B	5
; *  ...
; *  1   0   0   1    1	    1     1     1     0     0     1    0X79	3	
; * @device: DSPIC30F4013
; */
        .equ __30F4013, 1
        .include "p30F4013.inc"
;******************************************************************************
; BITS DE CONFIGURACIÓN
;******************************************************************************
;..............................................................................
;SE DESACTIVA EL CLOCK SWITCHING Y EL FAIL-SAFE CLOCK MONITOR (FSCM) Y SE 
;ACTIVA EL OSCILADOR INTERNO (FAST RC) PARA TRABAJAR
;FSCM: PERMITE AL DISPOSITIVO CONTINUAR OPERANDO AUN CUANDO OCURRA UNA FALLA 
;EN EL OSCILADOR. CUANDO OCURRE UNA FALLA EN EL OSCILADOR SE GENERA UNA TRAMPA
;Y SE CAMBIA EL RELOJ AL OSCILADOR FRC  
;..............................................................................
        config __FOSC, CSW_FSCM_OFF & FRC   
;..............................................................................
;SE DESACTIVA EL WATCHDOG
;..............................................................................
        config __FWDT, WDT_OFF 
;..............................................................................
;SE ACTIVA EL POWER ON RESET (POR), BROWN OUT RESET (BOR), POWER UP TIMER (PWRT)
;Y EL MASTER CLEAR (MCLR)
;POR: AL MOMENTO DE ALIMENTAR EL DSPIC OCURRE UN RESET CUANDO EL VOLTAJE DE 
;ALIMENTACIÓN ALCANZA UN VOLTAJE DE UMBRAL (VPOR), EL CUAL ES 1.85V
;BOR: ESTE MODULO GENERA UN RESET CUANDO EL VOLTAJE DE ALIMENTACIÓN DECAE
;POR DEBAJO DE UN CIERTO UMBRAL ESTABLECIDO (2.7V) 
;PWRT: MANTIENE AL DSPIC EN RESET POR UN CIERTO TIEMPO ESTABLECIDO, ESTO AYUDA
;A ASEGURAR QUE EL VOLTAJE DE ALIMENTACIÓN SE HA ESTABILIZADO (16ms) 
;..............................................................................
        config __FBORPOR, PBOR_ON & BORV27 & PWRT_16 & MCLR_EN
;..............................................................................
;SE DESACTIVA EL CÓDIGO DE PROTECCIÓN
;..............................................................................
   	config __FGS, CODE_PROT_OFF & GWRP_OFF      

;******************************************************************************
; SECCIÓN DE DECLARACIÓN DE CONSTANTES CON LA DIRECTIVA .EQU (= DEFINE EN C)
;******************************************************************************
        .equ MUESTRAS, 64         ;NÚMERO DE MUESTRAS

;******************************************************************************
; DECLARACIONES GLOBALES
;******************************************************************************
;..............................................................................
;PROPORCIONA ALCANCE GLOBAL A LA FUNCIÓN _wreg_init, ESTO PERMITE LLAMAR A LA 
;FUNCIÓN DESDE UN OTRO PROGRAMA EN ENSAMBLADOR O EN C COLOCANDO LA DECLARACIÓN
;"EXTERN"
;..............................................................................
        .global _wreg_init     
;..............................................................................
;ETIQUETA DE LA PRIMER LINEA DE CÓDIGO
;..............................................................................
        .global __reset          
;..............................................................................
;DECLARACIÓN DE LA ISR DEL TIMER 1 COMO GLOBAL
;..............................................................................
        .global __T1Interrupt    

;******************************************************************************
;CONSTANTES ALMACENADAS EN EL ESPACIO DE LA MEMORIA DE PROGRAMA
;******************************************************************************
        .section .myconstbuffer, code
;..............................................................................
;ALINEA LA SIGUIENTE PALABRA ALMACENADA EN LA MEMORIA 
;DE PROGRAMA A UNA DIRECCION MULTIPLO DE 2
;..............................................................................
        .palign 2                

ps_coeff:
        .hword   0x0002, 0x0003, 0x0005, 0x000A

;******************************************************************************
;VARIABLES NO INICIALIZADAS EN EL ESPACIO X DE LA MEMORIA DE DATOS
;******************************************************************************
         .section .xbss, bss, xmemory

x_input: .space 2*MUESTRAS        ;RESERVANDO ESPACIO (EN BYTES) A LA VARIABLE

;******************************************************************************
;VARIABLES NO INICIALIZADAS EN EL ESPACIO Y DE LA MEMORIA DE DATOS
;******************************************************************************

          .section .ybss, bss, ymemory

y_input:  .space 2*MUESTRAS       ;RESERVANDO ESPACIO (EN BYTES) A LA VARIABLE
;******************************************************************************
;VARIABLES NO INICIALIZADAS LA MEMORIA DE DATOS CERCANA (NEAR), LOCALIZADA
;EN LOS PRIMEROS 8KB DE RAM
;******************************************************************************
          .section .nbss, bss, near

var1:     .space 2               ;LA VARIABLE VAR1 RESERVA 1 WORD DE ESPACIO

;******************************************************************************
;SECCION DE CODIGO EN LA MEMORIA DE PROGRAMA
;******************************************************************************
.text					;INICIO DE LA SECCION DE CODIGO

__reset:
        MOV	#__SP_init, 	W15	;INICIALIZA EL STACK POINTER

        MOV 	#__SPLIM_init, 	W0     	;INICIALIZA EL REGISTRO STACK POINTER LIMIT 
        MOV 	W0, 		SPLIM

        NOP                       	;UN NOP DESPUES DE LA INICIALIZACION DE SPLIM

        CALL 	_WREG_INIT          	;SE LLAMA A LA RUTINA DE INICIALIZACION DE REGISTROS
                                  	;OPCIONALMENTE USAR RCALL EN LUGAR DE CALL
        CALL    INI_PERIFERICOS

CICLO:	
	MOV	PORTD,		W0
	NOP
	AND	#0X00F,		W0
	
	CP	W0,		#0
	BRA	Z,		DIGITO_2
	CP	W0,		#1
	BRA	Z,		DIGITO_0
	CP	W0,		#2
	BRA	Z,		DIGITO_1
	CP	W0,		#3
	BRA	Z,		DIGITO_5
	;CONTINUARA...
	GOTO	CICLO
	
DIGITO_0:
	MOV	#0X7E,		W0
	MOV	W0,		PORTB
	NOP	
	GOTO CICLO
DIGITO_1:
	MOV	#0X30,		W0
	MOV	W0,		PORTB
	NOP	
	GOTO CICLO	
DIGITO_2:
	MOV	#0X6D,		W0
	MOV	W0,		PORTB
	NOP
	GOTO CICLO
DIGITO_5:
	MOV	#0X5B,		W0
	MOV	W0,		PORTB
	NOP
	GOTO CICLO

;/**@brief ESTA RUTINA GENERA UN RETARDO DE 1 SEG APROX
; */
RETARDO1S:
	PUSH	W0  ; PUSH.D W0
	PUSH	W1
	
	MOV	#10,	    W1
CICLO2_1S:
    
	CLR	W0	
CICLO1_1S:	
	DEC	W0,	    W0
	BRA	NZ,	    CICLO1_1S	
    
	DEC	W1,	    W1
	BRA	NZ,	    CICLO2_1S
	
	POP	W1  ; POP.D W0
	POP	W0
	RETURN
;/**@brief ESTA RUTINA INICIALIZA LOS PERIFERICOS DEL DSC
; * PORTD: 
; * RD0 - ENTRADA, DIPSWITCH 0 
; * RD1 - ENTRADA, DIPSWITCH 1 
; * RD2 - ENTRADA, DIPSWITCH 2 
; * RD3 - ENTRADA, DIPSWITCH 3 
; * PORTB: 
; * RB0 - SALIDA, SEGMENTO G
; * RB1 - SALIDA, SEGMENTO F
; * RB2 - SALIDA, SEGMENTO E
; * RB3 - SALIDA, SEGMENTO D
; * RB4 - SALIDA, SEGMENTO C
; * RB5 - SALIDA, SEGMENTO B 
; * RB6 - SALIDA, SEGMENTO A 
; * PORTF: 
; * RF0 - ENTRADA, PUSH BUTTON 
; */
INI_PERIFERICOS:
	CLR	PORTD
	NOP
	CLR	LATD
	NOP
	MOV	#0X000F,	W0
	MOV	W0,		TRISD
	NOP
	
	CLR	PORTB
	NOP
	CLR	LATB
	NOP
	CLR	TRISB
	NOP
	SETM	ADPCFG

	CLR	PORTF
	NOP
	CLR	LATF
	NOP
	CLR	TRISF
	NOP
	BSET	TRISF,	    #TRISF0
	NOP
	
        RETURN

;/**@brief ESTA RUTINA INICIALIZA LOS REGISTROS Wn A 0X0000
; */
_WREG_INIT:
        CLR 	W0
        MOV 	W0, 				W14
        REPEAT 	#12
        MOV 	W0, 				[++W14]
        CLR 	W14
        RETURN

;/**@brief ISR (INTERRUPT SERVICE ROUTINE) DEL TIMER 1
; * SE USA PUSH.S PARA GUARDAR LOS REGISTROS W0, W1, W2, W3, 
; * C, Z, N Y DC EN LOS REGISTROS SOMBRA
; */
__T1Interrupt:
        PUSH.S 


        BCLR IFS0, #T1IF           ;SE LIMPIA LA BANDERA DE INTERRUPCION DEL TIMER 1

        POP.S

        RETFIE                     ;REGRESO DE LA ISR


.END                               ;TERMINACION DEL CODIGO DE PROGRAMA EN ESTE ARCHIVO






