; только для макросов!

LABEL_EXPR			equ 1b							; метка кода
MEM_EXPR			equ 10b							; память
IMM_EXPR			equ 100b						; непосредственное выражение
DIRECT_ADDR			equ 1000b						; прямая адресация памяти
REG_EXPR			equ 10000b						; регистр
VALID_REF			equ 100000b						; валидное выражение
MEM_SS_EXPR			equ 1000000b					; память относительно SS регистра
EXTER_LABEL_EXPR	equ 10000000b					; внешняя метка
VIMM_EXPR			equ (VALID_REF OR IMM_EXPR)		; 

float			typedef REAL4 
double			typedef REAL8

align_proc MACRO
align 16
ENDM


ALIGN_8 MACRO
	;ALIGN 8
ENDM

PRINT MACRO msg_txt:REQ
LOCAL lab1_
LOCAL a_msg
	jmp     lab1_
a_msg db msg_txt, 0
lab1_:
	pushad
	push    offset a_msg
	call    Msg
	add     esp, 04h
	popad
ENDM

PRINT_UINT MACRO fmt_txt:REQ, val:REQ
LOCAL lab1_
LOCAL a_msg
	jmp     lab1_
a_msg db fmt_txt, 0
lab1_:
	pushad
	push    val
	push    offset a_msg
	call    Msg
	add     esp, 08h
	popad
ENDM

PRINT_FLOAT MACRO fmt_txt:REQ, val:REQ
LOCAL lab1_
LOCAL a_msg
LOCAL value1
	jmp     lab1_
a_msg db fmt_txt, 0
value1 dd ?
lab1_:
	pushad
	mov     [value1], val
	sub     esp, 8
	fld     [value1]
	fstp    QWORD ptr [esp]
	push    offset a_msg
	call    Msg
	add     esp, 0Ch
	
	popad
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

; поместить непосредственое float значение в стек.
pushflt	MACRO param:req
	push	12345678h
	org		$-4
	dd		param
ENDM

; поместить непосредственое float значение в память или регистр, в том числе и xmm.
movflt MACRO param:req, const:req
	IF @SearchStr(<param>,<xmm0,xmm1,xmm2,xmm3,xmm4,xmm5,xmm6,xmm7>)
		IF @SearchStr(<const>,<0.0,0.,0>)
			xorps	param, param
		ELSE
			pushflt	const
			movss	param, dword ptr [esp]
			add		esp, 4
		ENDIF
	ELSE
		mov		dword ptr param, 0
		org		$-4
		dd		const
	ENDIF
ENDM

; поместить в память или регистр float-значение из памяти или регистра или непосредственого значения
float_set MACRO flt_this:req, param:req
;;	echo param
	;; если param равен нулю
	IF @SearchStr(<param>,<0.0,0.,0>)
		and		flt_this, 0
;;		echo is_zero
		EXITM
	ENDIF
	;; если param регистр
	IF @SearchStr(<param>,<eax,ebx,ecx,edx,esp,ebp,esi,edi>)
		mov		flt_this, param
;;		echo is_register
		EXITM
	ENDIF
	;; если param непосредственое float значения
	IF @SearchStr(%@SubStr(<param>,1,1), <0,1,2,3,4,5,6,7,8,9,->)
		movflt	flt_this, param
;;		echo is_float_const
		EXITM
	ENDIF
	; param это память
	mov		eax, param
	mov		flt_this, eax
;;	echo is_memory
ENDM

Fmatrix4_set MACRO matrix_this:req, i:req, j:req, k:req, c_:req
	movups	xmm0, i
	movups	matrix_this.i, xmm0
	movups	xmm0, j
	movups	matrix_this.j, xmm0
	movups	xmm0, k
	movups	matrix_this.k, xmm0
	movups	xmm0, c_
	movups	matrix_this.c_, xmm0
ENDM

Fvector4_set MACRO vec_this:req, vec_x:req, vec_y:req, vec_z:req, vec_w:req
	float_set	vec_this.x, vec_x
	float_set	vec_this.y, vec_y
	float_set	vec_this.z, vec_z
	float_set	vec_this.w, vec_w
ENDM

Fvector_set MACRO vec_this:req, vec0:req, vec1, vec2
	IFNB <vec1>
		float_set	vec_this.x, vec0
		float_set	vec_this.y, vec1
		float_set	vec_this.z, vec2
	ELSE
		float_set	vec_this.x, vec0.x
		float_set	vec_this.y, vec0.y
		float_set	vec_this.z, vec0.z
	ENDIF
ENDM

Fvector_set1 MACRO vec_this:req, vec0:req
	mov		eax, vec0.x
	mov		edx, vec0.y
	mov		ecx, vec0.z
	mov		vec_this.x, eax
	mov		vec_this.y, edx
	mov		vec_this.z, ecx
ENDM
