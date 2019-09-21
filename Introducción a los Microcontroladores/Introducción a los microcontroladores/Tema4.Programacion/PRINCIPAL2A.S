;/**@brief ESTE PROGRAMA LEE LOS VALORES COLOCADOS EN EL PUERTO D
; * (RD3, RD2, RD2, RD0) MEDIANTE UN DIP-SWITCH. AL VALOR LEIDO 
; * SE LE APLICA LA OPERACIÓN: 
; * IF( RF0 = 1 )
; *	PORTB(3...0) = PORTD(3...0) + 5
; * ELSE	
; *	PORTB(3...0) = PORTD(3...0) - 5	
; * EN EL PUERTO B (RB3, RB2, RB1, RB0) SE TIENEN CONECTADOS LEDS
; * PARA VISUALIZAR LA SALIDA
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

	BTSC	PORTF,		#0
	GOTO	SUMA
RESTA:
	SUB	#0X005,		W0
	MOV	W0,		PORTB
	NOP
	
	GOTO	CICLO
SUMA:
	ADD	#0X005,		W0
	MOV	W0,		PORTB
	NOP
	GOTO	CICLO

;/**@brief ESTA RUTINA INICIALIZA LOS PERIFERICOS DEL DSC
; * PORTD: 
; * RD0 - ENTRADA, DIPSWITCH 0 
; * RD1 - ENTRADA, DIPSWITCH 1 
; * RD2 - ENTRADA, DIPSWITCH 2 
; * RD3 - ENTRADA, DIPSWITCH 3 
; * PORTB: 
; * RB0 - SALIDA, LED 0 
; * RB1 - SALIDA, LED 1 
; * RB2 - SALIDA, LED 2 
; * RB3 - SALIDA, LED 3 
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






