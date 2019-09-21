        .include "p30F4013.inc"

        .global _datoLCD
	.global _comandoLCD
	.global _busyFlag
	.global _iniLCD8bits
 
	.EQU	RS_LCD,	    RD0
	.EQU	RW_LCD,	    RD1
	.EQU	E_LCD,	    RD2
	.EQU	BF_LCD,	    RB7
;/**@brief ESTA RUTINA MANDA UN DATO A UN LCD
; */
_datoLCD:
    BSET    PORTD,	#RS_LCD
    NOP
    BCLR    PORTD,	#RW_LCD
    NOP
    ;CONTINUARA...
    return
;/**@brief ESTA RUTINA MANDA UN COMANDO A UN LCD
; */
_comandoLCD:
    ;CONTINUARA...
    return
;/**@brief ESTA RUTINA VERIFICA LA BANDERA BUSY FLAG DEL LCD
; */
_busyFlag:
    SETM.B	TRISB
    NOP
    BSET	PORTD,	    #RW_LCD
    NOP
    ;RS = 0, TERMINEN
    BSET	PORTD,	    #E_LCD
    NOP
    
PROCESA:
    BTSC	PORTB,	    #BF_LCD
    GOTO	PROCESA
    ;CONTINUARA...
    return
;/**@brief ESTA RUTINA VERIFICA LA BANDERA BUSY FLAG DEL LCD
; */
_iniLCD8bits:
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD
    
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD
    
    CALL    _RETARDO15ms
    MOV	    #0X30,	W0
    CALL    _comandoLCD

    CALL    _busyFlag
    MOV	    #0X38,	W0
    CALL    _comandoLCD
   
    ;CONTINUARA...
    return



