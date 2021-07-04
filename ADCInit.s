;***************REGISTERS_ADDRESSES***********************

;GPIO Registers
GPIO_PORTE_DATA		EQU 0x40024020 ; Access BIT3
GPIO_PORTE_DATAE2	EQU 0x40024020 ; Access BIT2
GPIO_PORTE_DIR 		EQU 0x40024400 ; Port Direction
GPIO_PORTE_AFSEL	EQU 0x40024420 ; Alt Function enable
GPIO_PORTE_DEN 		EQU 0x4002451C ; Digital Enable
GPIO_PORTE_AMSEL 	EQU 0x40024528 ; Analog enable
GPIO_PORTE_PCTL 	EQU 0x4002452C ; Alternate Functions
;System Registers
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; GPIO Gate Control
SYSCTL_RCGCADC		EQU	0x400FE638 ;ADC GATE CONTROL
	
;ADC0SS3_REGISTERS
ADC0ACTSS			EQU	0x40038000 
ADC0SSMUX2			EQU	0x40038080
ADC0EMUX			EQU	0x40038014
ADC0SS2CTL			EQU	0x40038084
ADC0SSPC			EQU	0x40038FC4
ADC0PSSI			EQU	0x40038028
ADC0RIS				EQU	0x40038004
ADC0FIFO2			EQU	0x40038088
ADC0ISC				EQU	0x4003800C
	


;*********************************************************
;*********************************************************
            AREA 		routines, CODE, READONLY
			THUMB
			EXPORT 	ADC_Handler
			EXPORT	ADC0Init
				
;*********************************************************

ADC_Handler	PROC
			LDR		R0,=ADC0FIFO2
			LDR		R5,[R0]			;READ FIFO AND STORE RESULT TO 
			LDR		R4,[R0]
			LDR		R0,=ADC0ISC
			MOV		R1,#0x4
			STR		R1,[R0]
;			LDR		R0,=ADC0PSSI	
;			MOV		R1,#0x8			;INITIATE SS3
;			STR		R1,[R0]
			BX		LR
			ALIGN
			ENDP
			
	


;*********************************************************
;*********************************************************	


ADC0Init	PROC
			; GPIO INITIALIZATION
			LDR		R0,=SYSCTL_RCGCGPIO
			LDR		R1,[R0]		; RUN CLOCK OF PORTE
			ORR		R1,#0x10
			STR		R1,[R0]
			NOP
			NOP
			
			LDR		R0,=SYSCTL_RCGCADC
			LDR		R1,[R0]
			ORR		R1,#0x01			; RUN CLOCK OF ADC0
			STR		R1,[R0]
			NOP
			NOP
			NOP
			NOP
			
;					
;			LDR		R0,=GPIO_PORTE_DIR
;			MOV		R1,#0x00 	; SET PORTE PINS AS INPUTS
;			STR		R1,[R0]
			
			LDR		R0,=GPIO_PORTE_AFSEL
			MOV		R1,#0x0C	; SET PE3,PE2 TO ALTERNATE FUNCTION
			STR		R1,[R0]
			
			LDR		R0,=GPIO_PORTE_DEN
			LDR		R1,[R0]			
			BIC		R1,#0x0C		; DISABLE DIGITAL FUNCTIONALITY OF PORTE
			STR		R1,[R0]
			
			LDR		R0,=GPIO_PORTE_AMSEL
			LDR		R1,[R0]
			ORR		R1,#0x0C		; ENABLE ANALOG MODE OF PE3
			STR		R1,[R0]
			
			
			
			;ADC INITIALIZATION
			
			
			LDR		R0,=0x400FE100
			LDR		R1,[R0]
			ORR		R1,#0x00010000
			STR		R1,[R0]
			
			;SAMPLE SEQUENCER 2 IS USED
			LDR		R0,=ADC0ACTSS
			LDR		R1,[R0]
			BIC		R1,#0x4		;DISABLE SAMPLE SEQUENCER 2 (SS2)
			STR		R1,[R0]
			
			LDR		R0,=ADC0EMUX
			LDR		R1,[R0]
			BIC		R1,#0x0F00		;CLEAR BITS 12:15 FOR SOFTWARE TRIGGERING
			STR		R1,[R0]		
				
			LDR		R0,=ADC0SSMUX2
			LDR		R1,[R0]
			ORR		R1,#0x010		;PE3, FOR Y POSITION POT AND PE2 FOR X POSITION POT
			STR		R1,[R0]
			
			LDR		R0,=ADC0SS2CTL
			LDR		R1,[R0]	
			ORR		R1,R1,#0x60			;SET ENABLE AND INTERRUPT BITS
			STR		R1,[R0]
			
			LDR		R0,=ADC0SSPC
			LDR		R1,[R0]
			ORR		R1,R1,#0x01		;SET 125Ksps
			STR		R1,[R0]
			
			LDR		R0,=ADC0ACTSS
			LDR		R1,[R0]
			ORR		R1,R1,#0x04		;ENABLE SS2
			STR		R1,[R0]
			
			LDR		R0,=ADC0PSSI	
			MOV		R1,#0x4			;INITIATE SS2
			STR		R1,[R0]
			
			BX		LR
			ALIGN
			ENDP
			END
		
			
			
			
			
			
			
			
			
			
			




















