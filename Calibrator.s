GPIO_PORTA_DATA		EQU	0x40004300
SSI0_DR				EQU	0x40008008
SSI0_SR				EQU	0x4000800C
ADC0PSSI			EQU	0x40038028
;************************************************************
CursorX				EQU	0x20000400
CursorY				EQU	0x20000404
	
tempX				EQU	0x20001890
tempY				EQU	0x20001891
tempD				EQU	0x20001892


;------------------------------------------------------------					
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	Calibrator
				
Calibrator	PROC
			PUSH	{LR}
			
			
			MOV		R0,#0x31		; (31)b16 = (49)b10
			MUL		R4,R4,R0
			MOV		R0,#0xFFF		; X address (R4)
			UDIV	R4,R4,R0
			ADD		R4,R4,#0x6
			
			MOV		R2,R5
			MOV		R0,#0x3
			MUL		R5,R5,R0
			MOV		R0,#0xFFF		; Y address (R5)
			UDIV	R5,R5,R0
			ADD		R5,R5,#1
			
			MOV		R3,#1365
			UDIV	R3,R2,R3
			MOV		R0,#1365		; Required Shift (R2)
			MUL		R3,R3,R0
			SUB		R2,R2,R3
			MOV		R0,#7
			MUL		R2,R2,R0
			MOV		R0,#1365
			UDIV	R2,R2,R0
			MOV		R0,#0x01
			LSL		R2,R0,R2
			
			
		
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			BIC		R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			MOV		R0,#0x40
			STR		R0,[R1]
			BL		fifo
			MOV		R0,#0x85
			STR		R0,[R1]
			BL		fifo

			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
	
			MOV		R3,#350
			LDR		R1,=SSI0_DR
			MOV		R0,#0x0
here		STR		R0,[R1]
			BL		fifo
			SUBS	R3,#1
			CMP		R3,#0
			BNE		here
			
			
			
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			BIC		R0,#0x80
			STR		R0,[R1]

			MOV		R0,#0x80
			ORR		R0,R0,R4
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x40
			ORR		R0,R5,R0
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
	
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=tempX
			STRB	R4,[R1],#1
			STRB	R5,[R1],#1
			STRB	R2,[R1]
			
			MOV		R3,R2
			CMP		R2,#0x01
			BEQ		top
			CMP		R2,#0x80
			BEQ		buttom
			

			LSR		R0,R2,#1
			LSL		R1,R2,#1
			ORR		R2,R2,R0
			ORR		R2,R2,R1
			
			LDR		R1,=SSI0_DR
			STR		R2,[R1]
			BL		fifo
			
done		MOV		R2,R3
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			MOV		R0,#0x80
			ORR		R0,R0,R4
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x40
			ORR		R0,R5,R0
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			ADD		R0,R4,#1
			SUB		R3,R4,#1
			
			MOV		R1,#0x80
			ORR		R0,R1,R0
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			STR		R2,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			MOV		R1,#0x80
			ORR		R0,R1,R3
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			STR		R2,[R1]
			BL		fifo
			
			LDR		R0,=ADC0PSSI	
			MOV		R1,#0x4			;INITIATE SS3
			STR		R1,[R0]
			
			POP		{LR}
			BX		LR
			
			
	
top			LSL		R1,R2,#1
			ORR		R2,R2,R1
			
			LDR		R1,=SSI0_DR
			STR		R2,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			SUB		R1,R5,#1
			
			MOV		R0,#0x40
			ORR		R0,R1,R0
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x80
			ORR		R0,R0,R4
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo

			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			MOV		R2,#0x80
			LDR		R1,=SSI0_DR
			STR		R2,[R1]
			BL		fifo
			
			
			B		done
			
			
			










buttom		LSR		R1,R2,#1
			ORR		R2,R2,R1
			
			LDR		R1,=SSI0_DR
			STR		R2,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			ADD		R1,R5,#1
			
			MOV		R0,#0x40
			ORR		R0,R1,R0
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			MOV		R0,#0x80
			ORR		R0,R0,R4
			LDR		R1,=SSI0_DR
			STR		R0,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR		R0,#0x80
			STR		R0,[R1]
			
			MOV		R2,#0x01
			LDR		R1,=SSI0_DR
			STR		R2,[R1]
			BL		fifo
			
			B		done
			
			
			
			
			
			
			
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