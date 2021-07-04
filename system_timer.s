NVICSTCTRL 		EQU 0xE000E010
NVICSTRELOAD  	EQU 0xE000E014
NVICSTCURRENT 	EQU 0xE000E018
SHPSYSPRI3		EQU 0xE000ED20

;***************************************************************
; GPIO intialization
;***************************************************************
;LABEL		DIRECTIVE	VALUE			COMMENT
            AREA 		routines, READONLY, CODE
            THUMB
            EXPORT 		InitSysTick		
				
InitSysTick	PROC
			
			PUSH		{R0-R1}			
			LDR			R0,=NVICSTCTRL  ;disable SysTick
			MOV			R1,#0x0
			STR			R1,[R0]
			
			LDR			R0,=NVICSTRELOAD ; load amount of delay , (i.e load number to start counting) 
			MOV32		R1,#0x3D0900
			STR			R1,[R0]
			
			LDR			R0,=NVICSTCURRENT 
			MOV32		R1,#0x3D0900			 
			STR			R1,[R0]
			
			LDR 		R0,=SHPSYSPRI3 ; set priority level for SysTick , in this case set to 2
			MOV 		R1,#0x40000000
			STR 		R1,[R0]
			
			LDR			R0,=NVICSTCTRL	; enable SysTick , enable interrupt and choose clock to be 4MHz
			MOV			R1,#0x3
			STR			R1,[R0]
			
			POP			{R0-R1}
			BX			LR
			ENDP
			ALIGN
			END
			
			
			
			
			
