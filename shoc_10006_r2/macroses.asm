
float			typedef REAL4 
double			typedef REAL8

align_proc MACRO
align 16
ENDM

;include macros_eval.asm

_static MACRO any_params:VARARG
.data
align 4
% any_params
.code
ENDM

const_static_str$ MACRO any_text:VARARG
LOCAL txtname
.const
align 4
txtname		db any_text, 0
.code
EXITM <offset txtname>
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

static_xmm4 MACRO name_param:REQ, param:VARARG
.data
align 16
name_param		dd	param
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
name_param		byte	param, 0
.code
ENDM

const_static_str MACRO name_param:REQ, param:VARARG
.const
align 4
name_param		byte	param, 0
.code
ENDM

; найти в списке строк номер совпадающей строки, если не нашли - то возвращает ноль
@SearchStr MACRO str1:req, params:VARARG
LOCAL i, num
	i = 0
	num = 0
	FOR arg,<params>
		i = i + 1
		IFIDNI <str1>,<arg>
			num = i
			EXITM 
		ENDIF
	ENDM
	EXITM <num>
ENDM

PUT_FLOAT MACRO val:REQ
	push	val
	fld		dword ptr [esp]
	push	ecx
	fstp	qword ptr [esp]
ENDM

PRINT_MATRIX MACRO title_:REQ, val:REQ
LOCAL a_msg1, a_msg2
const_static_str	a_msg1, title_
const_static_str	a_msg2, "%.6f, %.6f, %.6f, %.6f"
	pusha
	mov		edi, val
	push	offset a_msg1
	call	Msg
	add		esp, 4
	ASSUME	edi:PTR Fmatrix
	PUT_FLOAT [edi]._14_
	PUT_FLOAT [edi].i.z
	PUT_FLOAT [edi].i.y
	PUT_FLOAT [edi].i.x
	push	offset a_msg2
	call	Msg
	add		esp, 24h
	PUT_FLOAT [edi]._24_
	PUT_FLOAT [edi].j.z
	PUT_FLOAT [edi].j.y
	PUT_FLOAT [edi].j.x
	push	offset a_msg2
	call	Msg
	add		esp, 24h
	PUT_FLOAT [edi]._34_
	PUT_FLOAT [edi].k.z
	PUT_FLOAT [edi].k.y
	PUT_FLOAT [edi].k.x
	push	offset a_msg2
	call	Msg
	add		esp, 24h
	PUT_FLOAT [edi]._44_
	PUT_FLOAT [edi].c_.z
	PUT_FLOAT [edi].c_.y
	PUT_FLOAT [edi].c_.x
	push	offset a_msg2
	call	Msg
	add		esp, 24h
	ASSUME	edi:nothing
	popa
ENDM

PRINT_STR MACRO val_txt:REQ
	pusha
	push	val_txt
	call	Msg
	add		esp, 04h
	popa
ENDM

PRINT MACRO msg_txt:REQ
	pusha
	push	const_static_str$(msg_txt)
	call	Msg
	add		esp, 04h
	popa
ENDM

PRINT_UINT MACRO fmt_txt:REQ, val:REQ
	pusha
	push	val
	push	const_static_str$(fmt_txt)
	call	Msg
	add		esp, 08h
	popa
ENDM

PRINT_FLOAT MACRO fmt_txt:REQ, val:REQ
	pusha
	push	val
	fld		dword ptr [esp]
	push	ecx
	fstp	qword ptr [esp]
	push	const_static_str$(fmt_txt)
	call	Msg
	add		esp, 12
	popa
ENDM

FLUSH_LOG MACRO
	pusha
	call	FlushLog
	popa
ENDM

; RT_DYNAMIC_CAST MACRO source, dest, reg
	; push	0
	; push	offset dest
	; push	offset source
	; push	0
	; push	reg
	; call	__RTDynamicCast
	; add		esp, 14h
; ENDM

PRINT_VECTOR MACRO fmt_txt:REQ, val:REQ
	pusha
	push	val
	push	const_static_str$(fmt_txt)
	call	Log_vector3
	add		esp, 8
	popa
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

mrm MACRO FirstArgument:REQ, SecondArgument:REQ
	LOCAL itemSize
	itemSize=TYPE (FirstArgument)
	IF itemSize EQ 1
		mov		al, SecondArgument
		mov		FirstArgument, al
	ELSEIF itemSize EQ 2
		itemSize=TYPE (SecondArgument)
		IF (itemSize EQ 2) or (itemSize EQ 0)
			mov		ax, SecondArgument
			mov		FirstArgument, ax
		ELSE
			movzx	eax, SecondArgument
			mov		FirstArgument, ax
		ENDIF
	ELSE
		itemSize=TYPE (SecondArgument)
		IF (itemSize EQ 4) or (itemSize EQ 0)
			mov		eax, SecondArgument
			mov		FirstArgument, eax
		ELSE
			movzx	eax, SecondArgument
			mov		FirstArgument, eax
		ENDIF	
	ENDIF
ENDM
m2m MACRO param1:req, param2:req
	push	param2
	pop		param1
ENDM
