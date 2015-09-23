[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_init_gdtidt
	EXTERN	_Init_PIC
	EXTERN	_io_sti
	EXTERN	_fifo8_init
	EXTERN	_io_out8
	EXTERN	_Init_Keyboard
	EXTERN	_Enable_Mouse
	EXTERN	_DrawBack
	EXTERN	_sprintf
	EXTERN	_PutFont_Asc
	EXTERN	_Init_MouseCur
	EXTERN	_PutBlock
	EXTERN	_io_cli
	EXTERN	_fifo8_status
	EXTERN	_fifo8_get
	EXTERN	_Mouse_Decode
	EXTERN	_RectFill
	EXTERN	_io_stihlt
[FILE "kernel.c"]
[SECTION .data]
LC0:
	DB	"Screen:(%d, %d)",0x00
LC2:
	DB	"[lcr %4d %4d]",0x00
LC3:
	DB	"MousePos:(%3d, %3d)",0x00
LC1:
	DB	"%02X",0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	LEA	EBX,DWORD [-172+EBP]
	SUB	ESP,604
	MOV	EAX,DWORD [4088]
	MOV	DWORD [-608+EBP],EAX
	MOVSX	EAX,WORD [4086]
	MOVSX	EDI,WORD [4084]
	MOV	DWORD [-612+EBP],EAX
	CALL	_init_gdtidt
	CALL	_Init_PIC
	CALL	_io_sti
	LEA	EAX,DWORD [-460+EBP]
	PUSH	EAX
	PUSH	32
	PUSH	_KeyFifo
	CALL	_fifo8_init
	LEA	EAX,DWORD [-588+EBP]
	PUSH	EAX
	PUSH	128
	PUSH	_MouseFifo
	CALL	_fifo8_init
	PUSH	249
	PUSH	33
	CALL	_io_out8
	ADD	ESP,32
	PUSH	239
	PUSH	161
	CALL	_io_out8
	CALL	_Init_Keyboard
	CALL	_Enable_Mouse
	PUSH	DWORD [-612+EBP]
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_DrawBack
	PUSH	DWORD [-612+EBP]
	PUSH	EDI
	PUSH	LC0
	PUSH	EBX
	CALL	_sprintf
	ADD	ESP,36
	PUSH	EBX
	LEA	EBX,DWORD [-428+EBP]
	PUSH	15
	PUSH	0
	PUSH	0
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_PutFont_Asc
	PUSH	54
	LEA	EDX,DWORD [-16+EDI]
	MOV	ECX,2
	MOV	EAX,EDX
	PUSH	EBX
	CDQ
	IDIV	ECX
	MOV	EDX,DWORD [-612+EBP]
	MOV	DWORD [-616+EBP],EAX
	SUB	EDX,16
	MOV	EAX,EDX
	CDQ
	IDIV	ECX
	MOV	ESI,EAX
	CALL	_Init_MouseCur
	ADD	ESP,32
	PUSH	16
	PUSH	EBX
	PUSH	ESI
	PUSH	DWORD [-616+EBP]
	PUSH	16
	PUSH	16
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_PutBlock
	ADD	ESP,32
L2:
	CALL	_io_cli
	PUSH	_KeyFifo
	CALL	_fifo8_status
	PUSH	_MouseFifo
	MOV	EBX,EAX
	CALL	_fifo8_status
	LEA	EAX,DWORD [EAX+EBX*1]
	POP	EBX
	POP	EDX
	TEST	EAX,EAX
	JE	L18
	PUSH	_KeyFifo
	CALL	_fifo8_status
	POP	ECX
	TEST	EAX,EAX
	JNE	L19
	PUSH	_MouseFifo
	CALL	_fifo8_status
	POP	EDX
	TEST	EAX,EAX
	JE	L2
	PUSH	_MouseFifo
	CALL	_fifo8_get
	MOV	EBX,EAX
	CALL	_io_sti
	MOVZX	EAX,BL
	PUSH	EAX
	LEA	EAX,DWORD [-604+EBP]
	PUSH	EAX
	CALL	_Mouse_Decode
	ADD	ESP,12
	TEST	EAX,EAX
	JE	L2
	PUSH	DWORD [-596+EBP]
	PUSH	DWORD [-600+EBP]
	PUSH	LC2
	LEA	EBX,DWORD [-124+EBP]
	PUSH	EBX
	CALL	_sprintf
	ADD	ESP,16
	MOV	EAX,DWORD [-592+EBP]
	TEST	EAX,1
	JE	L11
	MOV	BYTE [-123+EBP],76
L11:
	TEST	EAX,2
	JE	L12
	MOV	BYTE [-121+EBP],82
L12:
	AND	EAX,4
	JE	L13
	MOV	BYTE [-122+EBP],67
L13:
	PUSH	31
	PUSH	151
	PUSH	16
	PUSH	32
	PUSH	15
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_RectFill
	PUSH	EBX
	PUSH	16
	PUSH	16
	PUSH	32
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_PutFont_Asc
	LEA	EAX,DWORD [15+ESI]
	ADD	ESP,52
	PUSH	EAX
	MOV	EAX,DWORD [-616+EBP]
	ADD	EAX,15
	PUSH	EAX
	PUSH	ESI
	PUSH	DWORD [-616+EBP]
	PUSH	54
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_RectFill
	MOV	EAX,DWORD [-600+EBP]
	ADD	ESI,DWORD [-596+EBP]
	ADD	ESP,28
	ADD	DWORD [-616+EBP],EAX
	JS	L20
L14:
	TEST	ESI,ESI
	JS	L21
L15:
	LEA	EAX,DWORD [-16+EDI]
	CMP	DWORD [-616+EBP],EAX
	JLE	L16
	MOV	DWORD [-616+EBP],EAX
L16:
	MOV	EAX,DWORD [-612+EBP]
	SUB	EAX,16
	CMP	ESI,EAX
	JLE	L17
	MOV	ESI,EAX
L17:
	PUSH	ESI
	PUSH	DWORD [-616+EBP]
	PUSH	LC3
	PUSH	EBX
	CALL	_sprintf
	PUSH	49
	PUSH	151
	PUSH	33
	PUSH	0
	PUSH	15
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_RectFill
	ADD	ESP,44
	PUSH	EBX
	PUSH	16
	PUSH	33
	PUSH	0
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_PutFont_Asc
	LEA	EAX,DWORD [-428+EBP]
	PUSH	16
	PUSH	EAX
	PUSH	ESI
	PUSH	DWORD [-616+EBP]
	PUSH	16
	PUSH	16
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_PutBlock
	ADD	ESP,56
	JMP	L2
L21:
	XOR	ESI,ESI
	JMP	L15
L20:
	MOV	DWORD [-616+EBP],0
	JMP	L14
L19:
	PUSH	_KeyFifo
	CALL	_fifo8_get
	MOV	EBX,EAX
	CALL	_io_sti
	PUSH	EBX
	LEA	EBX,DWORD [-124+EBP]
	PUSH	LC1
	PUSH	EBX
	CALL	_sprintf
	PUSH	31
	PUSH	15
	PUSH	16
	PUSH	0
	PUSH	15
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_RectFill
	ADD	ESP,44
	PUSH	EBX
	PUSH	16
	PUSH	16
	PUSH	0
	PUSH	EDI
	PUSH	DWORD [-608+EBP]
	CALL	_PutFont_Asc
	ADD	ESP,24
	JMP	L2
L18:
	CALL	_io_stihlt
	JMP	L2
	GLOBAL	_KeyFifo
[SECTION .data]
	ALIGNB	16
_KeyFifo:
	RESB	24
	GLOBAL	_MouseFifo
[SECTION .data]
	ALIGNB	16
_MouseFifo:
	RESB	24