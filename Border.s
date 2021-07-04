GPIO_PORTA_DATA		EQU	0x40004300
SSI0_DR				EQU	0x40008008
SSI0_SR				EQU	0x4000800C

;************************************************************
;------------------------------------------------------------					
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT 	DrawBorder

DrawBorder	PROC
			
			PUSH	{LR}
			;Draw Rect.
			MOV		R4,#0x41
			MOV		R5,#0x85
			
ver1		CMP		R4,#0x45
			BEQ		set1
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			STR		R4,[R1]
			BL		fifo
			STR		R5,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			MOV		R0,#0xFF
			STR		R0,[R1]
			BL		fifo
			
			ADD		R4,R4,#0x01
			B		ver1
			
set1		MOV		R5,#0x85
			MOV		R4,#0x45
			
hor1		CMP		R5,#0xC6
			BEQ		set2
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			STR		R4,[R1]
			BL		fifo
			STR		R5,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			MOV		R0,#0x01
			STR		R0,[R1]
			BL		fifo
			
			ADD		R5,R5,#0x01
			B		hor1
			
set2		MOV		R4,#0x41
			MOV		R5,#0xC5

ver2		CMP		R4,#0x45
			BEQ		set3
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			STR		R4,[R1]
			BL		fifo
			STR		R5,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			MOV		R0,#0xFF
			STR		R0,[R1]
			BL		fifo
			
			ADD		R4,R4,#0x01
			B		ver2

set3		MOV		R4,#0x40
			MOV		R5,#0x85
			
hor2		CMP		R5,#0xC6
			BEQ		done
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			STR		R4,[R1]
			BL		fifo
			STR		R5,[R1]
			BL		fifo
			
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			EOR 	R0,#0x80
			STR		R0,[R1]
			
			LDR		R1,=SSI0_DR
			MOV		R0,#0x80
			STR		R0,[R1]
			BL		fifo
			
			ADD		R5,R5,#0x01
			B		hor2
			
done		POP		{LR}
			BX		LR

			;check fifo if EMPTY OR NOT/ BUSY
fifo		PUSH	{LR,R1,R0}
			LDR		R1,=SSI0_SR
check		LDR		R0,[R1]
			ANDS	R0,#0x10
			BNE		check
			POP     {LR,R1,R0}
			BX 		LR
			
			ENDP
			ALIGN
			END