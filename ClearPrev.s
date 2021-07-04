GPIO_PORTA_DATA		EQU	0x40004300
SSI0_DR				EQU	0x40008008
SSI0_SR				EQU	0x4000800C
ADC0PSSI			EQU	0x40038028
;************************************************************
CursorX				EQU	0x20000400
CursorY				EQU	0x20000404
	
tempX				EQU	0x20001890
tempY				EQU	0x20001891
tempD				EQU	0x20001992




;------------------------------------------------------------					
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	ClearScreen




ClearScreen	PROC


; CLEAR PREV POSITION OF THE CURSOR
			
			PUSH	{LR}

			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			BIC		R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			MOV		R0,#0x40
			STR		R0,[R1]
			BL		fifo
			MOV		R0,#0x80
			STR		R0,[R1]
			BL		fifo

			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
	
			MOV		R3,#4032
			LDR		R1,=SSI0_DR
			MOV		R0,#0x0
here		STR		R0,[R1]
			BL		fifo
			SUBS	R3,#1
			CMP		R3,#0
			BNE		here
			
			
			
			POP		{LR}
			
			BX		LR
			
			
						
			
						;check fifo if EMPTY OR NOT/ BUSY
fifo		PUSH	{LR,R1,R0}
			LDR		R1,=SSI0_SR
check		LDR		R0,[R1]
			ANDS	R0,#0x10
			BNE		check
			POP     {LR,R1,R0}
			BX 		LR
			
			ALIGN
			ENDP
			END