;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	routines, READONLY, CODE
			THUMB
			EXPORT  	DELAY100

DELAY100	PROC
			PUSH 	{R0-R4}
			PUSH	{LR}
			MOV32	R0,#0x411AB	; you need about  ...cycles to to complete 100ms
loop		SUBS	R0,#0x001				
			BNE		loop
			POP		{LR}
			POP		{R0-R4}
			
			BX		LR
			ENDP
			ALIGN
			END
			
			; the equation for calculating required itirations is = (16e6*(required_time))/6
			; this equation is found by considering that arm m4 works on 80MHz clock and it requires about 6 cycles to subs and branch
			; finaly the equation is calibarated after doing some experiments
			