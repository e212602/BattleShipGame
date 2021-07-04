;DISPLAYS AT THE GIVEN COORDINATES...
;** INCREASE COORDINATES MANUALLY.. OR GICE COORDINATES
;input:x-R4(0-83),y-ADRESS-R5(0-5), DATA -R12
;output: DATA ON SCREEN
;WAITS FOR FIFO TO GET EMPTY BEFORE GETTING OUT OF THE ROUTINE
GPIO_PORTA_DATA		EQU		0x40004300
SSI0_DR				EQU		0x40008008
SSI0_SR				EQU		0x4000800C
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	routines, READONLY, CODE
			THUMB
			EXPORT  	DISPLAY
			EXTERN  	fifo
				
DISPLAY		PROC
			PUSH{LR,R1,R0,r4,r5,r12}
			;make D/c low.. command
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			BIC 	R0,#0x80
			STR		R0,[R1]
			
			;SET X, Y
			LDR		R1,=SSI0_DR

			ORR		R5,#0x40			;y-address  R5
			STR		R5,[R1]
			BL		fifo
			
			ORR		R4,#0x80			;x-address		R4
			STR		R4,[R1]
			BL		fifo

			;write data to screen.. change to display ... D/C high
			LDR		R1,=GPIO_PORTA_DATA	
			LDR		R0,[R1]
			ORR 	R0,#0x80
			STR		R0,[R1]
			
			;data to be written
			LDR		R1,=SSI0_DR
			STR		R12,[R1]				;DATA TO BE WRITTEN MUST BE IN R12
			;check fifo if EMPTY OR NOT/ BUSY
			LDR		R1,=SSI0_SR
check		LDR		R0,[R1]
			ANDS	R0,#0x10
			BNE		check
			POP		{LR,R1,R0,r4,r5,r12}
			BX 		LR
			ENDP
			ALIGN
			END			