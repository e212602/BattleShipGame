GPIO_PORTA_DATA		EQU	0x40004300
SSI0_DR				EQU	0x40008008
SSI0_SR				EQU	0x4000800C
;***************************************************************
;LABEL		DIRECTIVE	VALUE		COMMENT
            AREA        sdata, DATA, READONLY
            THUMB
    	
Zero     	DCB			0X00
			DCB     	0x7E
			DCB			0x81
			DCB			0x81
			DCB			0x81
			DCB			0x7E
			DCB			0X00


One			DCB			0x00
			DCB			0x84
			DCB			0x86
			DCB			0xFF
			DCB			0x80
			DCB			0x80
			DCB			0x00

Two			DCB			0x00
			DCB			0xF1
			DCB			0x91
			DCB			0x91
			DCB			0x91
			DCB			0x9F
			DCB			0x00

Three		DCB			0x00
			DCB			0x91
			DCB			0x91
			DCB			0x91
			DCB			0x91
			DCB			0xFF
			DCB			0x00
			
Four		DCB			0x00
			DCB			0x1F
			DCB			0x10
			DCB			0x10
			DCB			0xFF
			DCB			0x10
			DCB			0x00
			
Five		DCB			0x00
			DCB			0x9F
			DCB			0x91
			DCB			0x91
			DCB			0x91
			DCB			0xF1
			DCB			0x00
			
Six			DCB			0x00
			DCB			0xFF
			DCB			0x91
			DCB			0x91
			DCB			0x91
			DCB			0xF1
			DCB			0x00
			
Seven		DCB			0x00
			DCB			0x41
			DCB			0x21
			DCB			0x11
			DCB			0x09
			DCB			0x07
			DCB			0x00
			
Eight		DCB			0x00
			DCB			0xFF
			DCB			0x91
			DCB			0x91
			DCB			0x91
			DCB			0xFF
			DCB			0x00
			
Nine		DCB			0x00
			DCB			0x9F
			DCB			0x91
			DCB			0x91
			DCB			0x91
			DCB			0xFF
			DCB			0x00
				
;************************************************************
;------------------------------------------------------------					
			AREA 	routines, CODE, READONLY
			THUMB
			EXTERN	DECISION
			EXPORT 	PrintNum
				
PrintNum	PROC
	
			PUSH	{LR}
			PUSH	{R4,R5,R6}
			
			SUB		R7,R7,#1
			
			MOV		R0,#10
			UDIV	R1,R7,R0
			MUL		R0,R0,R1
			SUB		R3,R7,R0
			
			;Comparison
			CMP		R1,#0
			LDREQ	R2,=Zero
			
			CMP		R1,#1
			LDREQ	R2,=One
			
			CMP		R1,#2
			LDREQ	R2,=Two
			
			CMP		R1,#3
			LDREQ	R2,=Three
			
			CMP		R1,#4
			LDREQ	R2,=Four
			
			CMP		R1,#5
			LDREQ	R2,=Five
			
			CMP		R1,#6
			LDREQ	R2,=Six
			
			CMP		R1,#7
			LDREQ	R2,=Seven
			
			CMP		R1,#8
			LDREQ	R2,=Eight
			
			CMP		R1,#9
			LDREQ	R2,=Nine
			
			; DISPLAY FIRST DIGIT
			MOV		R4,#0x40
			MOV		R5,#0xC6
			
loop1		LDR		R1,=GPIO_PORTA_DATA	
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
			LDRB	R0,[R2],#0x01
			STR		R0,[R1]
			BL		fifo
			
			ADD		R5,R5,#0x01
			CMP		R5,#0xCD
			BNE		loop1
			
			
			CMP		R3,#0
			LDREQ	R2,=Zero
			
			CMP		R3,#1
			LDREQ	R2,=One
			
			CMP		R3,#2
			LDREQ	R2,=Two
			
			CMP		R3,#3
			LDREQ	R2,=Three
			
			CMP		R3,#4
			LDREQ	R2,=Four
			
			CMP		R3,#5
			LDREQ	R2,=Five
			
			CMP		R3,#6
			LDREQ	R2,=Six
			
			CMP		R3,#7
			LDREQ	R2,=Seven
			
			CMP		R3,#8
			LDREQ	R2,=Eight
			
			CMP		R3,#9
			LDREQ	R2,=Nine
			
			; DISPLAY Second DIGIT
loop2		LDR		R1,=GPIO_PORTA_DATA	
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
			LDRB	R0,[R2],#0x01
			STR		R0,[R1]
			BL		fifo
			
			ADD		R5,R5,#0x01
			CMP		R5,#0xD4
			BNE		loop2
			
;			CMP		R7,#0
;			BEQ		DECISION
			
			POP		{R4,R5,R6}
			POP		{LR}
			BX		LR
			ENDP
			
			
			
			;check fifo if EMPTY OR NOT/ BUSY
fifo		PUSH	{LR,R1,R0}
			LDR		R1,=SSI0_SR
check		LDR		R0,[R1]
			ANDS	R0,#0x10
			BNE		check
			POP     {LR,R1,R0}
			BX 		LR
			
			ALIGN
			END