;GPIO Registers
GPIO_PORTF_DATA		EQU	    0x40025044 ; Access BIT0,4
SYSCTL_RCGCGIOP		EQU		0x400FE608 ; clock port enable reg.
GPIO_PORTF_DIR		EQU		0x40025400 ; direction reg.
GPIO_PORTF_AFSEL	EQU		0x40025420 ; alternate..... reg.
GPIO_PORTF_PUR		EQU		0x40025510 ; pull up reg
GPIO_PORTF_DEN		EQU		0x4002551C ; digital enable reg.
GPIO_PORTF_PDR		EQU		0x40025514 ; pull down register	
GPIO_PORTF_IS		EQU		0x40025404 ; sense interrupt register
GPIO_PORTF_IBE		EQU		0x40025408 ; interrupt both edges register
GPIO_PORTF_IEV		EQU		0x4002540C ; interrupt event register
GPIO_PORTF_IM		EQU		0x40025410 ; interrupt mask
GPIO_PORTF_RIS		EQU		0x40025414 ; row interrupt register
GPIO_PORTF_ICR		EQU		0x4002541C ; clear interrupt register
	
	
;NVIC ENABLE
NVIC_PRI			EQU		0xE000E41C ; priority register
NVIC_EN				EQU		0xE000E100 ; enable register
	

;LOCK REGISTER
GPIO_PORTF_GPIOLOCK	EQU	0x40025520	;GPIO LOCK
GPIO_PORTF_CR		EQU	0x40025524	;GPIO COMMIT
	
	
tempX				EQU	0x20001890
tempY				EQU	0x20001891
tempD				EQU	0x20001992
	
start				EQU	0x2000187d	
	
Funct				EQU	0x200018C0	


Mine				EQU	0x20001895

;*********************************************************
            AREA 		routines, CODE, READONLY
			THUMB
			EXTERN		DELAY100
			EXTERN		ships
;			EXTERN		DisplayMine
			EXPORT 		ButtonsInit
			EXPORT		ButtonsHand

;*********************************************************



ButtonsHand		PROC
				PUSH	{LR}
				
				BL		DELAY100
				BL		DELAY100
				BL		DELAY100
				BL		DELAY100
				BL		DELAY100
				
				LDR		R1,=Funct
				LDRB	R0,[R1]
				CMP		R0,#1
				BEQ		funtion2
				
				

				
				LDR		R1,=GPIO_PORTF_RIS
				LDR		R0,[R1]
				ANDS	R0,#0x01
				BEQ		battleship
				
				;CiviliianShip
				
				LDR		R1,=tempX	
				LDRB	R4,[R1],#1		; load x
				LDRB	R5,[R1],#1		; load y
				LDRB	R2,[R1]
				
				MOV		R9,#0
shift			LSR		R2,#1
				CMP		R2,#0
				BEQ		here1
				ADD		R9,#1
				B		shift
here1			MOV		R2,R9
				
				
				
				LDR		R1,=start
				MOV		R0,#4
				MUL		R0,R0,R6
				ADD		R1,R1,R0
				MOV		R0,#1
				STRB	R0,[R1],#1
				STRB	R4,[R1],#1
				STRB	R5,[R1],#1
				STRB	R2,[R1]
				
				
				ADD		R6,R6,#0x01
				BL		ships
				
				
done			LDR		R1,=GPIO_PORTF_ICR
				LDR		R0,[R1]
				ORR		R0,#0x11
				STR		R0,[R1]
				
				POP		{LR}
				BX		LR

				
				
				; battle ship
				
battleship		LDR		R1,=tempX	
				LDRB	R4,[R1],#1		; load x
				LDRB	R5,[R1],#1		; load y
				LDRB	R2,[R1]
				
				
				MOV		R9,#0
shift2			LSR		R2,#1
				CMP		R2,#0
				BEQ		here12
				ADD		R9,#1
				B		shift2
here12			MOV		R2,R9
				
				LDR		R1,=start
				MOV		R0,#4
				MUL		R0,R0,R6
				ADD		R1,R1,R0
				MOV		R0,#2
				STRB	R0,[R1],#1
				STRB	R4,[R1],#1
				STRB	R5,[R1],#1
				STRB	R2,[R1]
				
				ADD		R6,R6,#0x01
				BL		ships
				
				B		done
				
				
				
funtion2		LDR		R1,=GPIO_PORTF_RIS
				LDR		R0,[R1]
				ANDS	R0,#0x10
				BEQ		player2done
				

				
				LDR		R1,=tempX	
				LDRB	R4,[R1],#1		; load x
				LDRB	R5,[R1],#1		; load y
				LDRB	R2,[R1]
				
				MOV		R9,#0
shift1			LSR		R2,#1
				CMP		R2,#0
				BEQ		here11
				ADD		R9,#1
				B		shift1
here11			MOV		R2,R9
				
				
				LDR		R1,=Mine
				MOV		R0,#4
				MUL		R0,R0,R6
				ADD		R1,R1,R0
				STRB	R4,[R1],#1	;x
				STRB	R5,[R1],#1	;y
				STRB	R2,[R1]		;d
				
				
				ADD		R6,R6,#0x01
;				BL		DisplayMine
				
				B		done

player2done		B		done


				
				
				ENDP


;*******************************************************************


ButtonsInit PROC
				
			LDR			R1,=SYSCTL_RCGCGIOP
			LDR			R0,[R1]
			ORR			R0,R0,#0x20			; ACTIVATE PORT F CLOCK
			STR			R0,[R1]
			NOP
			NOP
			NOP
			
			
			
			LDR			R1,=GPIO_PORTF_GPIOLOCK
			MOV32		R0,#0x4C4F434B			; UNLOCK PF0
			STR			R0,[R1]
			
			
			LDR			R1,=GPIO_PORTF_CR
			MOV			R0,#0x11			; SET PF0 AND PF4 TO COMMIT
			STR			R0,[R1]	
			
			
			
			LDR			R1,=GPIO_PORTF_DIR
			LDR			R0,[R1]
			BIC			R0,#0x11				; SET PF0 AND PF4 AS INPUT
			STR			R0,[R1]
			
			LDR			R1,=GPIO_PORTF_DEN
			LDR			R0,[R1]
			ORR			R0,#0x11				; SET PF0 and PF4 AS DIGITAL PINS
			STR			R0,[R1]
			
			LDR			R1,=GPIO_PORTF_AFSEL
			LDR			R0,[R1]
			BIC			R0,#0x11				; DIAABLE ALTERNATE FUNCTION
			STR			R0,[R1]
			
			LDR			R1,=GPIO_PORTF_PUR
			LDR			R0,[R1]
			ORR			R0,#0x11				; PULL UP PF0 AND PF4
			STR			R0,[R1]
			
			LDR			R1,=GPIO_PORTF_IS
			LDR			R0,[R1]
			BIC			R0,#0x11				; SET PF0 AND PF4 AS EDGE SENSETIVE
			STR			R0,[R1]
			
			LDR			R1,=GPIO_PORTF_IBE
			LDR			R0,[R1]
			BIC			R0,#0x11				; SET PF0 AND PF4 AS EDGE SENSETIVE
			STR			R0,[R1]
			
			LDR			R1,=GPIO_PORTF_IEV
			LDR			R0,[R1]
			ORR			R0,#0x11				; RISING EDGE SENSETIVITY
			STR			R0,[R1]
			
			LDR			R1,=NVIC_PRI
			LDR			R0,[R1]
			ORR			R0,#0x00400000			; INTERRUPT PRIORITY 2
			STR			R0,[R1]
			
			LDR			R1,=NVIC_EN
			LDR			R0,[R1]
			ORR			R0,#0x40000000			; ENABLE PORT F INTERRUPT
			STR			R0,[R1]
			
			LDR			R1,=GPIO_PORTF_IM
			LDR			R0,[R1]
			ORR			R0,#0x11				; ENABLE INTERRUPT PF0 AND PF4
			STR			R0,[R1]
			
			BX			LR
			
			
			ENDP
			
			
			ALIGN
			END
			
			
			
			
			
			
			
			
			
			
			
			
			


















