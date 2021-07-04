;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	routines, READONLY, CODE
			THUMB
			EXPORT  	CONVRT 


CONVRT		PROC
			PUSH		{R0-R5}	
			MOV32		R0,#0x3B9ACA00  ; move 10^9 to R0
			MOV			R1,#10
			MOV			R3,#10
			
start		UDIV		R2,R4,R0
			CMP			R2,#0x0
			BEQ			dec

loop		ADD			R2,R2,#0x30
			STRB		R2,[R5]
			ADD			R5,R5,#1
			SUB			R2,R2,#0x30
			MUL			R2,R2,R0
			SUB			R4,R4,R2
			UDIV		R0,R0,R3
			SUBS		R1,R1,#1
			BNE			div
			B			Done
			
div			UDIV		R2,R4,R0
			B			loop
			
dec			UDIV		R0,R0,R3
			SUBS		R1,R1,#1
			BNE			start
			ADD			R2,R2,#0x30
			STRB		R2,[R5]
			ADD			R5,R5,#1
			
Done		MOV		R3,#0x04
			STRB	R3,[R5]
			POP		{R0-R5}	
			BX		LR
			ALIGN
			ENDP
			END
			
			
			
			
			
			
		
			