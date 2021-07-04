;takes 2 position coordinates and compares them if one falls in the viccinity of other
;mine in vicinty of ship in this case
;r1,r2,r3 mine coordinates...r1-x, r2-Ysection,r3-withinYposition
;r4,r5,r6	ship coordinates r4-x, r5-Ysection,r6-withinYposition
;r7, flag if in vicinity (r7=1) or not in vicinity (r7=2)
;LABEL		DIRECTIVE	VALUE		COMMENT
			AREA    	routines, READONLY, CODE
			THUMB
			EXPORT  	vicinityM

vicinityM	PROC
			PUSH 	{R0-R6}
			;compare x coordinates
			ADD		R0,R4,#7			;UPPER LIMIT OF X
			CMP		R1,R0
			BHI		skipall				;exceeds ==> not in vicinity set negative flag
			SUB		R0,R4,#1			;lower limit of x
			CMP		R1,R0
			BGT		ok
			B		skipall				;;below lower bound ==> not in vicinity
			;check y section
ok			CMP		R2,R5				; current Y section
			BNE		here
			CMP		R3,R6				;either mine is insame position in section or higher will imply in the bounding box of ship
			BHS		within
			B		skipall
here		ADD		R0,R5,#1			;check the next section cause ship could be in y and y+1
			CMP		R2,R0				
			BNE		skipall				;not in these sections then out of bound
			CMP		R3,R6
			BLS		within
skipall		;flag negative
			MOV		R7,#2			; R7=2 implies not in vicinity
			B		done
within		;flag positive
			MOV		R7,#1			;R7=1 implies within vicinity
done		POP		{R0-R6}
			BX		LR
			ENDP
			ALIGN
			END
			