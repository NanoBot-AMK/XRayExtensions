; Макросы

static_str$ MACRO any_text:VARARG
LOCAL txtname
.data
align 4
txtname		db any_text, 0
.code
EXITM <offset txtname>
ENDM

PRINT_UINT MACRO fmt_txt:REQ, val:REQ
	pusha
	push    val
	push    static_str$(fmt_txt)
	call    Msg
	add     esp, 08h
	popa
ENDM

align_proc MACRO
align 16
ENDM
