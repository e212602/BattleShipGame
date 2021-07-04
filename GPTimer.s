
; 16/32 Timer Registers   ; For Timer2
TIMER2_CFG			EQU 0x40032000
TIMER2_TAMR			EQU 0x40032004
TIMER2_CTL			EQU 0x4003200C
TIMER2_IMR			EQU 0x40032018
TIMER2_RIS			EQU 0x4003201C ; Timer Interrupt Status
TIMER2_ICR			EQU 0x40032024 ; Timer Interrupt Clear
TIMER2_TAILR		EQU 0x40032028 ; Timer interval
TIMER2_TAPR			EQU 0x40032038
TIMER2_TAR			EQU	0x40032048 ; Timer register
	
;System Registers
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; GPIO Gate Control
SYSCTL_RCGCTIMER 	EQU 0x400FE604 ; GPTM Gate Control
		
;*********************************************************
            AREA 		routines, CODE, READONLY
			THUMB
			EXPORT 	My_Timer2A_Handler
			EXPORT	Timer2AInit
				
;*********************************************************				

;*******************INITIALIZATION*****************************
Timer2AInit	PROC

			; TIMER2 initialization
			LDR R1, =SYSCTL_RCGCTIMER ; Start Timer2
			LDR R2,[R1]
			ORR R2,R2,#0x04
			STR R2,[R1]
			NOP ; allow clock to settle
			NOP
			NOP
			
			LDR	R0,=TIMER2_CTL
			MOV	R1,#0x00		; Disable TIMER2A 
			STR	R1,[R0]
			
			LDR	R0,=TIMER2_CFG
			MOV	R1,#0x4			; Choose 16 bit timer configuratioin
			STR	R1,[R0]
			
			LDR	R0,=TIMER2_TAMR	; set capture mode, time edge mode and Timer counts down
			MOV	R1,#0x07
			STR	R1,[R0]
			
			LDR	R0,=TIMER2_ICR ; clear the interrupt status register
			LDR	R1,[R0]
			BIC	R1,#0x01F
			STR	R1,[R0]
			
			LDR	R0,=TIMER2_TAILR ; Load  count interval
			MOV	R1,#0xFFFF
			STR	R1,[R0]
			
			LDR R1,=TIMER2_CTL	
			LDR R2,[R1]
			ORR R2,R2,#0x0F ; Enable TIMER2 , Hlat while Debugging and TIMER A event mode both edges
			STR R2, [R1] 
			BX LR ; return
			ENDP
			ALIGN
			END
			
			
			
			
			
			
			
			