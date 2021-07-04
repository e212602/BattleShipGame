;*********************************************************
;*********************************************************
            AREA 		routines, CODE, READONLY
			THUMB
			EXPORT 	ship_battle
			EXPORT	ship_civil
			EXTERN	DISPLAY
				
;*********************************************************
;*********************************************************
;*********************************************************	

ship_battle	PROC
			PUSH	{LR,R2,R4,R5,R8,R7,r6,r12}
			PUSH {R2,R5}
			PUSH{R4}
			;FIRST LINE, LAST LINE SINGLE LINE
			CMP		R2,#0
			BNE		SKP
			MOV		R6,#0Xff
			MOV		R12,R6
			BL		DISPLAY
			ADD 	R4,#7
			BL		DISPLAY
			BL		NL
	
SKP			MOV		R8,#1
AG			LSL		R8,#1
			SUBS	R2,#1
			BNE		AG
			EOR		R8,#0XFF
			ADD		R8,#1    ;1S COMPLEMENT
			;DISPLAY
			MOV		R12,R8
			BL		DISPLAY
			ADD 	R4,#7
			BL		DISPLAY
			SUB		R4,#7
			EOR		R8,#0XFF   ; FOR REMAINING BITS TO DISPLAY
			;INCREMENT Y SECTION ADRESS
			ADD		R5,#1
			;DISPLAY
			MOV		R12,R8
			BL		DISPLAY
			ADD 	R4,#7
			BL		DISPLAY
			
NL			POP{R4}
			POP		{R2,R5}
			ADD		R4,#1
			;THE OTHER LINES
			MOV		R8,#6
			CMP		R2,#0
			BNE		SKIP1
			MOV		R12,#0X81		;10000001
DAA			BL		DISPLAY
			ADD		R4,#1
			SUBS	R8,#1
			BNE		DAA	
			B		ok
			
SKIP1		PUSH	{R4,R8}
			MOV		R7,R2
			MOV		R6,#1
AGAINAA		LSL		R6,#1
			SUBS	R7,#1
			BNE		AGAINAA
			MOV		R12,R6
DBB			BL		DISPLAY
			ADD		R4,#1
			SUBS	R8,#1
			BNE		DBB
			POP		{R4,R8}
			ADD		R5,#1
			LSR		R12,#1
DCC			BL		DISPLAY	
			ADD		R4,#1
			SUBS	R8,#1
			BNE		DCC
			
			

ok			POP		{LR,R2,R4,R5,R8,R7,r6,r12}
			BX		LR
			ALIGN
			ENDP
			
	


;*********************************************************
;*********************************************************	
			;CIVILIAN SHIP 8X8 FILLED SQUARE
			; X, Y SECTION, AND POSITION WITHIN THE SECTION
			;DISPLAY FROM X TO X+7 ... 8 PIXELS FOR X
			;X address (R4),Y address(SECTION) (R5), y POSITION IN r2 WIHTIN A SECTION

ship_civil	PROC
			PUSH{LR,R2,R4,R5,R8,R6,R7,r12}
			MOV		R8,#8
HERE		CMP		R2,#0
			BNE		SKIP
			EOR		R6,R2,#0Xff
			MOV		R12,R6
D			BL		DISPLAY
			ADD		R4,#1
			SUBS	R8,#1
			BNE		D	
			B		DONE

SKIP		MOV		R8,#1
			MOV		R7,#8
			PUSH	{R4,R7}
AGAIN		LSL		R8,#1
			SUBS	R2,#1
			BNE		AGAIN
			EOR		R8,#0XFF
			ADD		R8,#1    ;1S COMPLEMENT
			;DISPLAY
			MOV		R12,R8
DA			BL		DISPLAY
			ADD		R4,#1
			SUBS	R7,#1
			BNE		DA	
			POP		{R4,R7}
			
			EOR		R8,#0XFF   ; FOR REMAINING BITS TO DISPLAY
			;INCREMENT Y SECTION ADRESS
			ADD		R5,#1
			;DISPLAY
			MOV		R12,R8
DB			BL		DISPLAY
			ADD		R4,#1
			SUBS	R7,#1
			BNE		DB
			
DONE		POP		{LR,R2,R4,R5,R8,R6,R7,r12}
			BX		LR
			ALIGN
			ENDP
			END

		
			
			
			
			
			
			
			
			
			
			




















