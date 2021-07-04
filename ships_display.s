;makes ship on the stored location in memory according to type
;memory stores 4 locations, order.. flag(battle/civilian ahip),X coordinate, y coordinate, position in y .. 4 of these
start		EQU			0x2000187d
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	routines, READONLY, CODE
			THUMB
			EXTERN	ship_civil
			EXTERN	ship_battle
			EXPORT  	ships

ships		PROC
			PUSH 	{R0-R7,LR}
			CMP		R6,#0			; counter r6 for four ships only, 0 implies no ship is placed
			BEQ		done
			LDR		R0,=start		;initial address of memory.. 
again		LDRB		R7,[R0]			;FLAG
			LDRB		R1,[R0,#1]!		; x coordinate
			LDRB		R3,[R0,#1]!		; y coordinate (section)
			LDRB		R2,[R0,#1]!		;	y coordinate (within section)	
			MOV		R4,R1
			MOV		R5,R3
			;r2 already has position within the section
			CMP		R7,#1			; 1 imples civilian ship, 2 implies battle ship
			BNE		here
			BL		ship_civil
			B		ok
here		BL		ship_battle

ok			ADD		R0,#1			;for next ship
			SUBS	R6,#1
			BNE		again
			

done		POP		{R0-R7,LR}
			BX		LR
			ENDP
			ALIGN
			END