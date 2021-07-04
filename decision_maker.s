;;makes the decision... win/loose
;INPUT:r6 contains number of mines, memory for mine and ship positions

startSh		EQU			0x2000187d			; info abt ships position flag(type of ship),X,Ysection,Yposition
startMi		EQU			0x20001895			; info abt mine position X,Ysection,Yposition,empty
R6Memory	EQU			0x200018C9
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	routines, READONLY, CODE
			THUMB
			EXTERN		vicinityM
			EXTERN		__main
			EXTERN		XDISPLAY
			EXTERN		DELAY100
			EXPORT  	DECISION

DECISION	PROC
			PUSH 	{R0-R12,LR}
			MOV		R8,#0			;hit count flag, 
			MOV		r11,#4			;ship data counter
			
			LDR		R1,=R6Memory
			STR		R6,[R1]

			MOV		R12,R6
			CMP		R6,#0			;no mine is placed and time runs out, definite loose
			BEQ		loose
			
			LDR		R9,=startSh		;for ship data
here2		LDRB	R10,[R9]		;FLAG(civilian/battle)
			LDRB	R4,[R9,#1]!		; x coordinate
			LDRB	R5,[R9,#1]!		; y coordinate (section)
			LDRB	R6,[R9,#1]!		;y coordinate (within section)	
			
			LDR		R0,=startMi		;initial address of memory for mine data
here1		LDRB	R1,[R0]			;x coordinate
			LDRB	R2,[R0,#1]!		; y coordinate (section)
			LDRB	R3,[R0,#1]!		; y coordinate (within section)
			BL		vicinityM
			CMP		R10,#1			;CIVILIAN SHIP?
			BEQ		CIVIL			;yes
			B		battle				;otherwise it is  battle ship
CIVIL		CMP		R7,#1			;if civilian ship, does mine hit? vicinity..1 implies it does
			BEQ		loose
			ADD		R8,#1			;for civil ship did not hit flag
			B		nextmine
			
battle		CMP		R7,#1		;vicinity check
			BNE		nextmine	;not in vicinity, check next mine
			ADD		R8,#1		;in vicinity, raise hit count flag..
nextmine	ADD		R0,R0,#2
			SUBS	R12,#1
			BNE		here1
			CMP		R8,#0		; if this flag zero==> did not hit the batlleship, 1 hit the battleship or did not hit civilian
			BEQ		loose		;did not hit the battleship
;			MOV		R6,R12		;reset mine counter
			LDR		R12,=R6Memory
			LDR		R12,[R12]
			MOV		R8,#0		;reset the hit flag
			ADD		R9,#1		;for next ship data
			SUBS	R11,#1
			BNE		here2
			;win/loose display
			
win			MOV		R4,#41
			MOV		R5,#3
			MOV		R12,#0xff
			BL		XDISPLAY
			BL		XDISPLAY
			BL		XDISPLAY
			BL		XDISPLAY
			B		done
loose		MOV		R4,#41
			MOV		R5,#3
			MOV		R12,#0xf8
			BL		XDISPLAY
			BL		XDISPLAY
			BL		XDISPLAY
			BL		XDISPLAY
			
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			BL		DELAY100
			
		
			
			
done		POP		{R0-R12,LR}
			BX		LR
			ENDP
			ALIGN
			END