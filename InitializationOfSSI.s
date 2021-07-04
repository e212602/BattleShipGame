;****REGISTERS OF Serial Synchronous Interface "0" **********
RCGCSSI		EQU		0x400FE61C
SSI0_CR0	EQU		0x40008000
SSI0_CR1	EQU		0x40008004
SSI0_DR		EQU		0x40008008
SSI0_SR		EQU		0x4000800C
SSI0_CPPSR	EQU		0x40008010
SSI0_IM		EQU		0x40008014
SSI0_RIS	EQU		0x40008018
SSI0_MIS	EQU		0x4000801C
SSI0_ICR	EQU		0x40008020
SSI0_CC		EQU		0x40008FC8
;************************************************************
;****REGESTERS OF GPIO PORT A********************************
;USE PB4,5,6,7 FOR SSI0CLK,SSI0FSS,SSI0RX,SSI0TX RESPECTIVELY
RCGCGPIO			EQU	0x400FE608
GPIO_PORTA_DATA		EQU	0x400040F0
GPIO_PORTA_DIR		EQU	0x40004400
GPIO_PORTA_AFSEL	EQU	0x40004420
GPIO_PORTA_PCTL		EQU	0x4000452C
GPIO_PORTA_AMSEL	EQU	0x40004528
GPIO_PORTA_DEN		EQU	0x4000451C
GPIO_PORTA_PUR		EQU	0x40004510

;************************************************************

;************************************************************
;------------------------------------------------------------					
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	ssi_init

ssi_init	PROC
			; CLOCK CONFIGURATION FOR SSI AND GPIO

			LDR		R1,=RCGCSSI
			LDR		R0,[R1]
			ORR		R0,R0,#0x01
			STR		R0,[R1]		;RUN GPIO PORTA CLOCK
			NOP
			NOP
			NOP
			
			
			LDR		R1,=RCGCGPIO
			LDR		R0,[R1]
			ORR		R0,R0,#0x01
			STR		R0,[R1]		;RUN GPIO PORTA CLOCK
			NOP
			NOP
			NOP
			
			
			LDR		R1,=GPIO_PORTA_DEN
			LDR		R0,[R1]
			ORR		R0,R0,#0xFF		; DIGITAL ENABLE FOR PA2,3,4,5,7
			STR		R0,[R1]
			
			LDR		R1,=GPIO_PORTA_DIR
			LDR		R0,[R1]
			ORR		R0,R0,#0xEF
			STR		R0,[R1]
			
	
			LDR		R1,=GPIO_PORTA_AFSEL
			LDR		R0,[R1]
			ORR		R0,R0,#0x3C		; ENABLE ALTERNATE FUNCTION FOR PA2,3,4,5
			STR		R0,[R1]
			
			LDR		R1,=GPIO_PORTA_PCTL
			MOV32	R0,#0x00222200	; SET PA2,3,4,5 to SSI0CLK,SSI0FSS,SSI0RX AND SSI0TX
			STR		R0,[R1]
				
			LDR		R1,=GPIO_PORTA_PUR
			MOV		R0,#0x04
			STR		R0,[R1]
			
			
			; SSI CONFIGURATION		
;			LDR		R1,=RCGCSSI
;			LDR		R0,[R1]
;			ORR		R0,R0,#0x01
;			STR		R0,[R1]		;RUN GPIO PORTA CLOCK
;			NOP
;			NOP
;			NOP
			
			
			LDR		R1,=SSI0_CR1
			LDR		R0,[R1]
			BIC		R0,R0,#0x02		; DISABLE SSI0
			STR		R0,[R1]
			
			LDR		R1,=SSI0_CC
			MOV		R0,#0x5
			STR		R0,[R1]			; SysClk = PIOSC
			
			LDR		R1,=SSI0_CPPSR
			MOV		R0,#0x02
			STR		R0,[R1]			;  SysClk/16
			
			LDR		R1,=SSI0_CR0
			MOV		R0,#0x14C7	; SET 8 BIT DATA, POLARITY : LOW , PHASE : SECOND EDGE
			STR		R0,[R1]
				

			LDR		R1,=SSI0_CR1
			LDR		R0,[R1]
			ORR		R0,R0,#0x12		; ENABLE SSI0 , ENABLE EOT INTERRUPT
			STR		R0,[R1]
			
			BX		LR
			
			
			ENDP
				
				
				
			ALIGN
			END
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			























