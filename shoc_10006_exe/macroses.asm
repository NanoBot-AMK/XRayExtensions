
FALSE			equ 0
TRUE			equ 1
NULL			equ 0

;выравнивание процедур
align_proc MACRO
	align 16
ENDM

static_str$ MACRO any_text:VARARG
LOCAL txtname
.data
align 4
txtname		db any_text, 0
.code
EXITM <offset txtname>
ENDM

static_float MACRO name_param:REQ, param:VARARG
.data
align 4
name_param		REAL4	param
.code
ENDM

static_int MACRO name_param:REQ, param:VARARG
.data
align 4
name_param		DWORD	param
.code
ENDM

static_byte MACRO name_param:REQ, param:VARARG
.data
align 1
name_param		BYTE	param
.code
ENDM

static_str MACRO name_param:REQ, param:VARARG
.data
align 4
name_param		BYTE	param, 0
.code
ENDM

PRINT MACRO msg_txt:REQ
	pusha
	push	static_str$(msg_txt)
	call	Msg
	add		esp, 04h
	popa
ENDM

PRINT_UINT MACRO msg_txt:REQ, val:REQ
	pusha
	push	val
	push	static_str$(msg_txt)
	call	Msg
	add		esp, 08h
	popa
ENDM

PRINT_FLOAT MACRO msg_txt:REQ, val:REQ
	pusha
	push	val
	fld		dword ptr [esp]
	push	ecx
	fstp	qword ptr [esp]
	push	static_str$(msg_txt)
	call	Msg
	add		esp, 12
	popa
ENDM

static_byte		ignore_always, 1
static_byte		aEmpty, 0
;
R_ASSERT MACRO msg_txt:REQ, name_proc
LOCAL file_name
	file_name	equ @FileCur
	file_name	CATSTR <">,file_name,<">	;; добавляем кавычки
	mov		ecx, ds:Debug
	push	offset ignore_always
	IFNB <name_proc>
	push	static_str$(name_proc)		;; имя процедуры
	ELSE
	push	offset aEmpty
	ENDIF
	push	@Line			 			;; номер строки
	push	static_str$(file_name)		;; имя файла
	push	static_str$(msg_txt)		;; сообщение
	call	ds:xrDebug__fail
ENDM

xr_memory	MACRO reg:REQ
	mov		ecx, ds:Memory				; xrMemory Memory
	push	reg
	call	ds:xrMemory__mem_alloc
ENDM

xr_mem_free	MACRO reg:REQ
	mov		ecx, ds:Memory				; xrMemory Memory
	push	reg
	call	ds:xrMemory__mem_free
ENDM

nop2 MACRO
	mov		ecx, ecx
ENDM

nop3 MACRO
	lea		ecx, [ecx+12h]
	org		$-1
	db		0
ENDM

nop4 MACRO
	lea		esp, [esp+12h]
	org		$-1
	db		0
ENDM

nop5 MACRO
	mov		edx, edx
	lea		ecx, [ecx+12h]
	org		$-1
	db		0
ENDM

nop6 MACRO
	lea		ecx, [ecx+12345678h]
	org		$-4
	dd		0
ENDM

nop7 MACRO
	lea		esp, [esp+12345678h]
	org		$-4
	dd		0
ENDM
