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
NVICSTCTRL 		EQU 0xE000E010
;****REGESTERS OF GPIO PORT A********************************
;USE PA2,3,4,5 FOR SSI0CLK,SSI0FSS,SSI0RX,SSI0TX RESPECTIVELY,  PA6 for reset, PA7 for dispaly/command
RCGCGPIO			EQU	0x400FE608
GPIO_PORTA_DATA		EQU	0x40004300
GPIO_PORTA_DIR		EQU	0x40004400
GPIO_PORTA_AFSEL	EQU	0x40004420
GPIO_PORTA_PCTL		EQU	0x4000452C
GPIO_PORTA_AMSEL	EQU	0x40004528
GPIO_PORTA_DEN		EQU	0x4000451C
GPIO_PORTA_PUR		EQU	0x40004510

ADC0RIS				EQU	0x40038004
;************************************************************
;PORT F
GPIO_PORTF_ICR		EQU	0x4002541C ; clear interrupt register
GPIO_PORTF_RIS		EQU	0x40025414 ; row interrupt register
GPIO_PORTF_IM		EQU	0x40025410 ; interrupt mask
	
TIMER0_RIS			EQU 0x4003001C ; Timer Interrupt Status
Funct				EQU	0x200018C0
;************************************************************
;------------------------------------------------------------					
			AREA 	main, CODE, READONLY
			THUMB
			EXTERN	ssi_init
			EXTERN	DELAY100
			EXTERN	PrintNum
			
			EXTERN	DrawBorder
			EXTERN	ADC0Init
			EXTERN	Calibrator
			EXTERN	ADC_Handler
			EXTERN	ButtonsInit
			EXTERN	ships
			EXTERN	ClearScreen
			EXTERN	InitSysTick	
			EXTERN	player2
;			EXTERN	DisplayMine
			EXTERN	PULSE_INIT
			EXTERN	DECISION
			EXPORT 	__main
				
__main		
		
			BL		ssi_init
			
			
			; toggling the clock here...
			;let reset be high first
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			ORR		R0,#0x40
			STR		R0,[R1]
			BL		DELAY100
			BL		DELAY100
			;make it low for 100ms
			LDR		R0,[R1]
			EOR		R0,#0x40
			STR		R0,[R1]
			BL		DELAY100
			
			
			
			;make it high :D
			EOR		R0,R0,#0x40
			STR		R0,[R1]
			
			;INITIALIZE DISPLAY   SSI0_DR
			;make D/c low.. command
			LDR		R0,[R1]
			BIC 	R0,#0x80
			STR		R0,[R1]
			
			; horizontal addressing,activate chip, extended instruction set	H=1
			LDR		R1,=SSI0_DR
			MOV		R0,#0x21
			STR		R0,[R1]
			;check fifo if command sent
			BL		fifo
			
			MOV		R0,#0xC0			;Vop
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x4				;temp
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x13			;Vbias
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x20			;basic mode H=0
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x0C			;normal mode
			STR		R0,[R1]
			BL		fifo
;			
;			MOV		R0,#0x40			;y-address
;			STR		R0,[R1]
;			BL		fifo
;			
;			MOV		R0,#0x80		;x-address
;			STR		R0,[R1]
;			BL		fifo

			;write data to screen.. change to display ... D/C high
again		LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			ORR 	R0,#0x80
			STR		R0,[R1]
			
			;Refresh screen
			MOV		R3,#504   ;6*84
			LDR		R1,=SSI0_DR
			MOV		R0,#0x0
here		STR		R0,[R1]
			BL		fifo
			SUBS	R3,#1
			CMP		R3,#0
			BNE		here
			
						
			BL		ADC0Init

			
			LDR		R1,=Funct
			MOV		R0,#0
			STRB	R0,[R1]
			
			BL		ButtonsInit
						
			MOV		R6,#0
			
loop		LDR		R0,=ADC0RIS	
			LDR		R1,[R0]
			CMP		R1,#0x4
			BNE		loop
					
			BL		ADC_Handler
			
			
			
			BL		Calibrator
	;		BL		DELAY100
			BL		ships
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100

			
			
			
			CMP		R6,#4
			
			BNE		loop
			
			LDR		R1,=GPIO_PORTF_IM
			LDR		R0,[R1]
			BIC		R0,#0xFF		; disable interrupt of port F 
			STR		R0,[R1]
			
wait		LDR		R1,=GPIO_PORTF_RIS
			BL		DELAY100
			BL		DELAY100
			LDR		R0,[R1]
			ANDS	R0,#0x01			; wait for player 1 confirmation
			BEQ		wait
			
			
			BL		ClearScreen			; clear screen
			
			LDR		R1,=GPIO_PORTF_ICR
			LDR		R0,[R1]
			ORR		R0,#0xFF			; clear interrupt
			STR		R0,[R1]
			
			
			;*****PHASE_2**************
			
			
			LDR		R1,=Funct
			MOV		R0,#1
			STRB	R0,[R1]
			
			
wait1		LDR		R1,=GPIO_PORTF_RIS
			BL		DELAY100
			BL		DELAY100
			LDR		R0,[R1]
			ANDS	R0,#0x01			; wait for player 1 confirmation
			BEQ		wait1
			
			LDR		R1,=GPIO_PORTF_ICR
			LDR		R0,[R1]
			ORR		R0,#0xFF			; clear interrupt
			STR		R0,[R1]
			
			LDR		R1,=GPIO_PORTF_IM
			LDR		R0,[R1]
			ORR		R0,#0x11		; disable interrupt of port F 
			STR		R0,[R1]
			
			BL		PULSE_INIT	
			BL		ships
			
wfint		LDR		R1,=TIMER0_RIS		; wait for 0.5 sec
			LDR		R0,[R1]
			ANDS	R0,#0x01
			BEQ		wfint
			
			
			BL		ClearScreen
			
			
			MOV		R6,#0
			
			MOV		R7,#20
			BL		InitSysTick
			
			
loop2		LDR		R0,=ADC0RIS	
			LDR		R1,[R0]
			CMP		R1,#0x4
			BNE		loop2
					
			BL		ADC_Handler
			
			
			BL		player2
			BL		DELAY100
;			BL		DisplayMine
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100


			CMP		R6,#4
			BNE		loop2
			WFI
			CMP		R7,#0
			
			LDR		R1,=NVICSTCTRL
			LDR		R0,[R1]
			BIC		R0,#0x03
			STR		R0,[R1]
			BEQ		DECISION
			B		again
			
			

			;check fifo if EMPTY OR NOT/ BUSY
fifo		PUSH	{LR,R1,R0}
			LDR		R1,=SSI0_SR
check		LDR		R0,[R1]
			ANDS	R0,#0x10
			BNE		check
			POP     {LR,R1,R0}
			BX 		LR

done		B		done
			ALIGN
			END
				