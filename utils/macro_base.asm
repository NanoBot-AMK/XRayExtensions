

LABEL_EXPR			equ 1b							; ����� ����
MEM_EXPR			equ 10b							; ������
IMM_EXPR			equ 100b						; ���������������� ���������
DIRECT_ADDR			equ 1000b						; ������ ��������� ������
REG_EXPR			equ 10000b						; �������
VALID_REF			equ 100000b						; �������� ���������
MEM_SS_EXPR			equ 1000000b					; ������ ������������ SS ��������
EXTER_LABEL_EXPR	equ 10000000b					; ������� �����
VIMM_EXPR			equ (VALID_REF OR IMM_EXPR)		; 

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