;GPIO_PORTA_DATA		EQU	0x40004300
;SSI0_DR				EQU	0x40008008
;SSI0_SR				EQU	0x4000800C
;ADC0PSSI			EQU	0x40038028
;;************************************************************
;Mine				EQU	0x20001895


;;------------------------------------------------------------					
;			AREA 	routines, CODE, READONLY
;			THUMB
;			EXTERN	fifo
;			EXPORT 	DisplayMine
;;************************************************************

;DisplayMine	PROC
;	
;			PUSH	{LR}
;			PUSH	{R6}
;			
;			
;			CMP		R6,#0
;			BEQ		done
;			
;			
;			
;loop		LDR		R1,=Mine
;			MOV		R0,#4
;			MUL		R0,R0,R6
;			ADD		R1,R1,R0
;			LDRB	R4,[R1],#1
;			LDRB	R5,[R1],#1
;			LDRB	R2,[R1]
;			
;			LDR		R1,=GPIO_PORTA_DATA	
;			LDR		R0,[R1]
;			BIC		R0,#0x80
;			STR		R0,[R1]

;			MOV		R0,#0x80
;			ORR		R0,R0,R4
;			LDR		R1,=SSI0_DR
;			STR		R0,[R1]
;			BL		fifo
;			
;			MOV		R0,#0x40
;			ORR		R0,R5,R0
;			LDR		R1,=SSI0_DR
;			STR		R0,[R1]
;			BL		fifo
;			
;	
;			LDR		R1,=GPIO_PORTA_DATA	
;			LDR		R0,[R1]
;			EOR		R0,#0x80
;			STR		R0,[R1]
;			
;			LDR		R1,=SSI0_DR
;			STR		R2,[R1]
;			BL		fifo
;			
;			SUBS	R6,R6,#1
;			BNE		loop
;			
;done		POP		{R6}
;			POP		{LR}
;			
;			BX		LR
;			
;			ENDP
;			ALIGN
;			END
			
			