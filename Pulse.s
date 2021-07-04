
;Nested Vector Interrupt Controller registers
NVIC_EN0_INT19		EQU 0x00080000 ; Interrupt 19 enable
NVIC_EN0			EQU 0xE000E100 ; IRQ 0 to 31 Set Enable Register
NVIC_PRI4			EQU 0xE000E410 ; IRQ 16 to 19 Priority Register
	
; 16/32 Timer Registers   ; For Timer0
TIMER0_CFG			EQU 0x40030000
TIMER0_TAMR			EQU 0x40030004
TIMER0_CTL			EQU 0x4003000C
TIMER0_IMR			EQU 0x40030018
TIMER0_RIS			EQU 0x4003001C ; Timer Interrupt Status
TIMER0_ICR			EQU 0x40030024 ; Timer Interrupt Clear
TIMER0_TAILR		EQU 0x40030028 ; Timer interval
TIMER0_TAPR			EQU 0x40030038
TIMER0_TAR			EQU	0x40030048 ; Timer register
	
;GPIO Registers
GPIO_PORTF_DATA		EQU 0x40025010 ; Access BIT2
GPIO_PORTF_DIR 		EQU 0x40025400 ; Port Direction
GPIO_PORTF_AFSEL	EQU 0x40025420 ; Alt Function enable
GPIO_PORTF_DEN 		EQU 0x4002551C ; Digital Enable
GPIO_PORTF_AMSEL 	EQU 0x40025528 ; Analog enable
GPIO_PORTF_PCTL 	EQU 0x4002552C ; Alternate Functions

;System Registers
SYSCTL_RCGCGPIO 	EQU 0x400FE608 ; GPIO Gate Control
SYSCTL_RCGCTIMER 	EQU 0x400FE604 ; GPTM Gate Control

;---------------------------------------------------
LOW					EQU	0x00000012 ; LOW interval
HIGH				EQU	0x0000001A ; HIGH interval


;---------------------------------------------------
					
			AREA 	routines, CODE, READONLY
			THUMB
			EXPORT	PULSE_INIT
					
;---------------------------------------------------

PULSE_INIT	PROC
			
			LDR R1, =SYSCTL_RCGCTIMER ; Start Timer0
			LDR R2, [R1]
			ORR R2, R2, #0x01
			STR R2, [R1]
			NOP ; allow clock to settle
			NOP
			NOP
			
			LDR R1, =TIMER0_CTL ; disable timer during setup LDR R2, [R1]
			BIC R2, R2, #0x01
			STR R2, [R1]
			
			LDR R1, =TIMER0_CFG ; set 16 bit mode
			MOV R2, #0x04
			STR R2, [R1]
			
			LDR R1, =TIMER0_TAMR
			MOV R2, #0x01 ; set to periodic, count down
			STR R2, [R1]
			
			LDR R1, =TIMER0_TAILR ; initialize match clocks
			MOV	R2,#0x7A12
			STR R2, [R1]
			
			LDR R1, =TIMER0_TAPR
			MOV R2, #0xFF ; divide clock by 255 to
			STR R2, [R1] ; get 62500Hz clocks
			
;			LDR R1, =TIMER0_IMR ; enable timeout interrupt
;			MOV R2, #0x01
;			STR R2, [R1]


			LDR	R1,=TIMER0_ICR
			LDR	R0,[R1]
			ORR	R0,#0xFF
			STR	R0,[R1]

; Enable timer
			LDR R1, =TIMER0_CTL
			LDR R2, [R1]
			ORR R2, R2, #0x03 ; set bit0 to enable
			STR R2, [R1] ; and bit 1 to stall on debug
			BX LR ; return
			ENDP
			ALIGN
			END