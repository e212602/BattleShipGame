
;::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
;			;display message
;			;lose: you lose loser!
;			;lose
;			;y
;loose		MOV 		R4,#15
;			MOV 		R5,#1
;			MOV			R12,#1
;			BL			XDISPLAY
;			MOV			R12,#2
;			BL			XDISPLAY
;			MOV			R12,#4
;			BL			XDISPLAY
;			MOV			R12,#0xf8
;			BL			XDISPLAY
;			MOV			R12,#4
;			BL			XDISPLAY
;			MOV			R12,#2
;			BL			XDISPLAY
;			MOV			R12,#1
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			; O
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x81
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;U
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x80
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			
;			;L
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x80
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			; O
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x81
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;S
;			MOV			R12,#0x1f
;			BL			XDISPLAY
;			MOV			R12,#0x91
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xf1
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;E
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x91
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			;loser!
;			MOV 		R4,#26
;			MOV 		R5,#3
;			;L
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x80
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			; O
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x81
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;S
;			MOV			R12,#0x1f
;			BL			XDISPLAY
;			MOV			R12,#0x91
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xf1
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;E
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x91
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;R
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x11
;			BL			XDISPLAY
;			MOV			R12,#0x31
;			BL			XDISPLAY
;			MOV			R12,#0x51
;			BL			XDISPLAY
;			MOV			R12,#0x9e
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;!!
;			MOV			R12,#0xcf
;			BL			XDISPLAY
;			BL			XDISPLAY

;;			;;;win message
;;			;wow you won!!
;			MOV 		R4,#25
;			MOV 		R5,#1
;			;W
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0xe0
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0xe0
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			; O
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x81
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;W
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0xe0
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0xe0
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;			;!!
;			MOV			R12,#0xcf
;			BL			XDISPLAY
;			BL			XDISPLAY
;			;y
;			MOV 		R4,#15
;			MOV 		R5,#3
;			MOV			R12,#1
;			BL			XDISPLAY
;			MOV			R12,#2
;			BL			XDISPLAY
;			MOV			R12,#4
;			BL			XDISPLAY
;			MOV			R12,#0xf8
;			BL			XDISPLAY
;			MOV			R12,#4
;			BL			XDISPLAY
;			MOV			R12,#2
;			BL			XDISPLAY
;			MOV			R12,#1
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			; O
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x81
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;U
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x80
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			
;			;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;W
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0xe0
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0xe0
;			BL			XDISPLAY
;			MOV			R12,#0x1c
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			;
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			; O
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x81
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			;1 pixel line gap
;			MOV			R12,#0
;			BL			XDISPLAY
;			;N
;			MOV			R12,#0xff
;			BL			XDISPLAY
;			MOV			R12,#0x03
;			BL			XDISPLAY
;			MOV			R12,#0x0c
;			BL			XDISPLAY
;			MOV			R12,#0x30
;			BL			XDISPLAY
;			MOV			R12,#0xc0
;			BL			XDISPLAY
;			MOV			R12,#0xff
;			BL			XDISPLAY