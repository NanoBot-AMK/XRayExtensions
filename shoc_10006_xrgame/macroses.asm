; только для макросов!


ALIGN_8 MACRO
;align 8
ENDM

align_proc MACRO
align 16
ENDM

PRINT_STR MACRO val_txt:REQ
	pusha
	push    val_txt
	call    Msg
	add     esp, 04h
	popa
ENDM

PRINT MACRO msg_txt:REQ
LOCAL lab1_
LOCAL a_msg
	jmp     lab1_
a_msg db msg_txt, 0
lab1_:
	pusha
	push    offset a_msg
	call    Msg
	add     esp, 04h
	popa
ENDM

PRINT_UINT MACRO fmt_txt:REQ, val:REQ
LOCAL lab1_
LOCAL a_msg
	jmp     lab1_
a_msg db fmt_txt, 0
lab1_:
	pusha
	push    val
	push    offset a_msg
	call    Msg
	add     esp, 08h
	popa
ENDM

PRINT_FLOAT MACRO fmt_txt:REQ, val:REQ
LOCAL lab1_
LOCAL a_msg
LOCAL value1
	jmp     lab1_
a_msg db fmt_txt, 0
value1 dd ?
lab1_:
	pusha
	mov     [value1], val
	sub     esp, 8
	fld     [value1]
	fstp    QWORD ptr [esp]
	push    offset a_msg
	call    Msg
	add     esp, 0Ch
	
	popa
ENDM

FLUSH_LOG MACRO
	pusha
	call    [FlushLog]
	popa
ENDM

RT_DYNAMIC_CAST MACRO source, dest, reg
	push    0
	push    offset dest
	push    offset source
	push    0
	push    reg
	call    __RTDynamicCast
	add     esp, 14h
ENDM

PRINT_VECTOR MACRO title_:REQ, val:REQ
LOCAL lab1_
LOCAL a_msg1
	jmp		lab1_
a_msg1 db title_, 0
lab1_:
	pusha
	push val
	push offset a_msg1
	call Log_vector3
	add esp, 8
	popa
ENDM

; реальный макрос для приведения классов
; аналог smart_cast<CLASS1*>(CLASS2* object)
; (c) NanoBot
smart_cast 	MACRO	class_1:REQ, class_2:REQ, object:REQ
	push    0
	push    offset class_1
	push    offset class_2
	push    0
	push    object
	call    __RTDynamicCast
	add     esp, 14h
ENDM
;============================================================================================
;	Макросы колбеков, названия соотвествует передаваемым параметрам
CALLBACK__GO 	MACRO	_this:REQ, type_callback:REQ, param1:REQ
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO
ENDM

CALLBACK__GO_GO_INT_VECTOR_FLOAT MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ, param3:REQ, vector4:REQ, param5:REQ
	push	param5
	push	vector4.z
	push	vector4.y
	push	vector4.x
	push	param3
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO_GO_int_vector_float
ENDM

CALLBACK__GO_BOOL_U32 MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ, param3:REQ
	push	param3
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO_bool_u32
ENDM

CALLBACK__GO_FLOAT_VECTOR_GO_s16 MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ, vector3:REQ, param4:REQ
	push	param4
	push	vector3.z
	push	vector3.y
	push	vector3.x
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO_float_vector_GO_s16
ENDM

CALLBACK__GO_FLOAT_VECTOR_GO_u16 MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ, vector3:REQ, param4:REQ
	push	param4
	push	vector3.z
	push	vector3.y
	push	vector3.x
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO_float_vector_GO_u16
ENDM

CALLBACK__GO_STR 	MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO_str
ENDM

CALLBACK__GO_STR_STR_STR 	MACRO _this:REQ, type_callback:REQ, param1:REQ, param2:REQ, param3:REQ, param4:REQ
	push	param4
	push	param3
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO_str_str_int
ENDM

;CALLBACK__SGAMETASK_SGAMETASKOBJECTIVE_ETASKSTATE
;	call	script_callback__SGameTask_SGameTaskObjective_ETaskState

CALLBACK__FLOAT_FLOAT_INT_u32 	MACRO _this:REQ, type_callback:REQ, param1:REQ, param2:REQ, param3:REQ, param4:REQ
	push	param4
	push	param3
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__float_float_int_u32
ENDM

CALLBACK__FLOAT_VECTOR MACRO	_this:REQ, type_callback:REQ, param1:REQ, vector2:REQ
	push	vector2.z
	push	vector2.y
	push	vector2.x
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__float_vector_m1
ENDM

CALLBACK__FLOAT_VECTOR_INT MACRO	_this:REQ, type_callback:REQ, param1:REQ, vector2:REQ, param3:REQ
	push	param3
	push	vector2.z
	push	vector2.y
	push	vector2.x
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__float_vector_int
ENDM

CALLBACK__STR_u16 	MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__str_u16
ENDM

CALLBACK__INT_INT 	MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__u32_u32
ENDM

CALLBACK__VOID 	MACRO	_this:REQ, type_callback:REQ
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__void
ENDM
;============================================================================================

mrm MACRO param1:req, param2:req
	mov		eax, param2
	mov		param1, eax
ENDM
m2m MACRO param1:req, param2:req
	push	param2
	pop		param1
ENDM

;скалярное произведения 3d вектора
;результат возвращается xmm0.0, регистры xmm0, xmm1 не сохраняются
dotproduct MACRO param1:req, param2:req
	movaps	xmm0, param1
	mulps	xmm0, param2
IFDEF	___INSTRUCTION__SSE3
	haddps	xmm0, xmm0
	haddps	xmm0, xmm0
ELSE
	movss	xmm1, xmm0				; xmm1.x = x
	shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
	addss	xmm1, xmm0				; xmm1 = x + y
	shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
	addss	xmm0, xmm1				; xmm0 = z + xmm1
ENDIF	
ENDM

;ICF	void	transform_tiny(Tvector &dest, const Tvector &v)	const // preferred to use
;{
;	dest.x = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x + this.c.x;
;	dest.y = v.x*this.i.y + v.y*this.j.y + v.z*this.k.y + this.c.y;
;	dest.z = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x + this.c.x;
;}
;matrix_this:Fmatrix4, vec_dest:Fvector4, vec:Fvector
;69 bytes
transform_tiny MACRO matrix_this:req, vec_dest:req, vec:req
	xorps	xmm0, xmm0
	xorps	xmm1, xmm1
	movss	xmm0, vec.x
	movups	xmm2, matrix_this.i
	shufps	xmm0, xmm0, 11000000b	; 3000t
	mulps	xmm0, xmm2
	movss	xmm1, vec.y
	movups	xmm3, matrix_this.j
	shufps	xmm1, xmm1, 11000000b	; 3000t
	mulps	xmm1, xmm3
	addps	xmm1, xmm0
	movss	xmm0, vec.z
	movups	xmm2, matrix_this.k
	shufps	xmm0, xmm0, 11000000b	; 3000t
	mulps	xmm0, xmm2
	movups	xmm3, matrix_this.c_
	addps	xmm0, xmm1
	addps	xmm0, xmm3
	movups	vec_dest, xmm0
ENDM

;ICF	void	transform_dir		(Tvector &dest, const Tvector &v)	const 	// preferred to use
;{
;	dest.x = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x;
;	dest.y = v.x*this.i.y + v.y*this.j.y + v.z*this.k.y;
;	dest.z = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x;
;}
transform_dir MACRO matrix_this:req, vec_dest:req, vec:req
	xorps	xmm0, xmm0
	xorps	xmm1, xmm1
	movss	xmm0, vec.x
	movups	xmm2, matrix_this.i
	shufps	xmm0, xmm0, 11000000b	; 3000t
	mulps	xmm0, xmm2
	movss	xmm1, vec.y
	movups	xmm3, matrix_this.j
	shufps	xmm1, xmm1, 11000000b	; 3000t
	mulps	xmm1, xmm3
	addps	xmm1, xmm0
	movss	xmm0, vec.z
	movups	xmm2, matrix_this.k
	shufps	xmm0, xmm0, 11000000b	; 3000t
	mulps	xmm0, xmm2
	addps	xmm0, xmm1
	movups	vec_dest, xmm0
ENDM
	
;209 bytes
Fmatrix4_mul_43 MACRO matrix_this:req, A:req, B:req
	; заполняем регистры
	xorps	xmm1, xmm1
	movups	xmm4, A.i
	xorps	xmm0, xmm0
	movups	xmm5, A.j
	xorps	xmm2, xmm2
	movups	xmm6, A.k
	; xmm0:mul(A.i, B.i.x)
	movss	xmm0, B.i.x
	shufps	xmm0, xmm0, 11000000b	; 3000t		; 0|B.i.x|B.i.x|B.i.x|
	movss	xmm1, B.i.y
	mulps	xmm0, xmm4
	; xmm2:mul(A.j, B.i.y)
	shufps	xmm1, xmm1, 11000000b	; 3000t		; 0|B.i.y|B.i.y|B.i.y|
	movss	xmm2, B.i.z
	mulps	xmm1, xmm5
	; xmm3:mul(A.j, B.i.y)
	shufps	xmm2, xmm2, 11000000b	; 3000t		; 0|B.i.z|B.i.z|B.i.z|
	addps	xmm0, xmm1
	mulps	xmm2, xmm6
	; xmm0.add(xmm1).add(xmm2)
	addps	xmm0, xmm2
	movups	matrix_this.i, xmm0
	; xmm0:mul(A.i, B.j.x)
	movss	xmm0, B.j.x
	shufps	xmm0, xmm0, 11000000b	; 3000t		; 0|B.j.x|B.j.x|B.j.x|
	movss	xmm1, B.j.y
	mulps	xmm0, xmm4
	; xmm2:mul(A.j, B.j.y)
	shufps	xmm1, xmm1, 11000000b	; 3000t		; 0|B.j.y|B.j.y|B.j.y|
	movss	xmm2, B.j.z
	mulps	xmm1, xmm5
	shufps	xmm2, xmm2, 11000000b	; 3000t		; 0|B.j.z|B.j.z|B.j.z|
	addps	xmm0, xmm1
	; xmm3:mul(A.k, B.j.z)
	mulps	xmm2, xmm6
	addps	xmm0, xmm2
	; xmm0.add(xmm1).add(xmm2)
	movups	matrix_this.j, xmm0
	; xmm0:mul(A.i, B.k.x)
	movss	xmm0, B.k.x
	shufps	xmm0, xmm0, 11000000b	; 3000t		; 0|B.k.x|B.k.x|B.k.x|
	movss	xmm1, B.k.y
	mulps	xmm0, xmm4
	; xmm2:mul(A.j, B.j.y)
	shufps	xmm1, xmm1, 11000000b	; 3000t		; 0|B.k.y|B.k.y|B.k.y|
	mulps	xmm1, xmm5
	movss	xmm2, B.k.z
	addps	xmm0, xmm1
	; xmm3:mul(A.k, B.j.z)
	shufps	xmm2, xmm2, 11000000b	; 3000t		; 0|B.k.z|B.k.z|B.k.z|
	mulps	xmm2, xmm6
	addps	xmm0, xmm2
	; xmm0.add(xmm1).add(xmm2)
	movups	matrix_this.k, xmm0
	; xmm0:mul(A.i, B.k.x)
	movss	xmm0, B.c_.x
	shufps	xmm0, xmm0, 11000000b	; 3000t		; 0|B.c_.x|B.c_.x|B.c_.x|
	movss	xmm1, B.c_.y
	mulps	xmm0, xmm4
	; xmm2:mul(A.j, B.j.y)
	shufps	xmm1, xmm1, 11000000b	; 3000t		; 0|B.c_.y|B.c_.y|B.c_.y|
	movups	xmm7, A.c_
	mulps	xmm1, xmm5
	movss	xmm2, B.c_.z
	addps	xmm0, xmm1
	; xmm3:mul(A.k, B.j.z)
	shufps	xmm2, xmm2, 11000000b	; 3000t		; 0|B.c_.z|B.c_.z|B.c_.z|
	mulps	xmm2, xmm6
	addps	xmm0, xmm2
	; xmm0.add(xmm1).add(xmm2)
	; xmm0.add(A.c)
	addps	xmm0, xmm7
	movups	matrix_this.c_, xmm0
ENDM

; сохраняем и читаем в стеке регистры XMM
pushxmm MACRO regxmm:req
	sub		esp, 16
	movups	oword ptr [esp], regxmm
ENDM

popxmm MACRO regxmm:req
	movups	regxmm, oword ptr [esp]
	add		esp, 16
ENDM

push1xmm MACRO regxmm:req
	push	eax
	movss	dword ptr [esp], regxmm
ENDM

pop1xmm MACRO regxmm:req
	movss	regxmm, dword ptr [esp]
	add		esp, 4
ENDM

pushaxmm MACRO
	sub		esp, 16*8
	movups	oword ptr [esp], xmm0
	movups	oword ptr [esp+16*1], xmm1
	movups	oword ptr [esp+16*2], xmm2
	movups	oword ptr [esp+16*3], xmm3
	movups	oword ptr [esp+16*4], xmm4
	movups	oword ptr [esp+16*5], xmm5
	movups	oword ptr [esp+16*6], xmm6
	movups	oword ptr [esp+16*7], xmm7
ENDM

popaxmm MACRO
	movups	xmm0, oword ptr [esp]
	movups	xmm1, oword ptr [esp+16*1]
	movups	xmm2, oword ptr [esp+16*2]
	movups	xmm3, oword ptr [esp+16*3]
	movups	xmm4, oword ptr [esp+16*4]
	movups	xmm5, oword ptr [esp+16*5]
	movups	xmm6, oword ptr [esp+16*6]
	movups	xmm7, oword ptr [esp+16*7]
	add		esp, 16*8
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
		pushflt	const
		movss	param, dword ptr [esp]
		add		esp, 4
	ELSE
		mov		dword ptr param, 0
		org		$-4
		dd		const
	ENDIF
ENDM

;арифметические операции с xmm регистрами и константами
addss_c MACRO reg_xmm:req, const:req, opt_reg
	pushflt	const
	addss	reg_xmm, dword ptr [esp]
	IFNB <opt_reg>
		pop		opt_reg
	ELSE
		add		esp, 4
	ENDIF
ENDM
subss_c MACRO reg_xmm:req, const:req, opt_reg
	pushflt	const
	subss	reg_xmm, dword ptr [esp]
	IFNB <opt_reg>
		pop		opt_reg
	ELSE
		add		esp, 4
	ENDIF
ENDM
mulss_c MACRO reg_xmm:req, const:req, opt_reg
	pushflt	const
	mulss	reg_xmm, dword ptr [esp]
	IFNB <opt_reg>
		pop		opt_reg
	ELSE
		add		esp, 4
	ENDIF
ENDM
divss_c MACRO reg_xmm:req, const:req, opt_reg
	pushflt	const
	divss	reg_xmm, dword ptr [esp]
	IFNB <opt_reg>
		pop		opt_reg
	ELSE
		add		esp, 4
	ENDIF
ENDM


movxmm MACRO param:req, const_x:req, const_y:req, const_z:req, const_w:req
	pushflt	const_w
	pushflt	const_z
	pushflt	const_y
	pushflt	const_x
	movups	param, oword ptr [esp]
	add		esp, 16
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

Fvector_set MACRO vec_this:req, vec_x:req, vec_y:req, vec_z:req
	float_set	vec_this.x, vec_x
	float_set	vec_this.y, vec_y
	float_set	vec_this.z, vec_z
ENDM

float_fchs MACRO flt_this:req, param:req
	mov		eax, param
	xor		eax, 80000000h	; меняем знак
	mov		flt_this, eax
ENDM

;IC	SelfRef	setHP	(T h, T p)
;{
;	T _ch=_cos(h), _cp=_cos(p), _sh=_sin(h), _sp=_sin(p);
;	x = -_cp*_sh;
;	y = _sp;
;	z = _cp*_ch;
;	return *this;	
;}
Fvector_setHP MACRO vec_this:req, h:req, p:req
	fld		p
	fsincos				; st(0)= _cp=cos(p); st(1)= _sp=sin(p)
	fld		h
	fsincos				; st(0)= _ch=cos(h); st(1)= _sh=sin(h); st(2)= _cp=cos(p); st(3)= _sp=sin(p)
	fmul	st, st(2)	; z = _ch*_cp;
	fstp	vec_this.z
	fmul	st, st(1)	; x = _sh*_cp;
	fchs				; x = -x;
	fstp	vec_this.x
	fstp	st
	fstp	vec_this.y
ENDM

PI					equ  3.14159265359
M_PI				equ -3.14159265359
PI_MUL_2			equ  6.28318530718
R_PI_MUL_2			equ  0.15915494309
;// normalize angle (0..2PI)
;ICF float		angle_normalize_always	(float a)
;{
;	float		div	 =	a/PI_MUL_2;
;	int			rnd  =	(div>0)?iFloor(div):iCeil(div);
;	float		frac =	div-rnd;
;	if (frac<0)	frac +=	1.f;
;	return		frac *	PI_MUL_2;
;}
; результат в xmm0, параметр angle задаётся xmm0
angle_normalize_always__xmm0 MACRO
	mulss_c	xmm0, R_PI_MUL_2, eax	;; angle/PI_MUL_2;
	xorps	xmm2, xmm2
	cvttss2si eax, xmm0
	cvtsi2ss xmm1, eax
	subss	xmm0, xmm1	;; дробная часть
	comiss	xmm0, xmm2
	.if (carry?)	;;xmm0 < 0.0
		addss_c	xmm0, 1.0, eax
	.endif
	mulss_c	xmm0, PI_MUL_2, eax
ENDM

;// -PI .. +PI
;ICF float		angle_normalize_signed(float a)
;{
;	if (a>=(-PI) && a<=PI)		return		a;
;	float angle = angle_normalize_always	(a);
;	if (angle>PI) angle-=PI_MUL_2;
;	return angle;
;}
; результат в xmm0, параметр angle задаётся xmm0
angle_normalize_signed__xmm0 MACRO
local exit
	movflt	xmm1, M_PI
	movflt	xmm3, PI
	;if (xmm0>M_PI && xmm0<PI)	return a;
	comiss	xmm0, xmm1
	jb		@F	;;.if (!carry?)	;;xmm0 >= xmm1
		comiss	xmm0, xmm3
		jbe		exit	;;xmm0 > xmm3
	@@:	;;.endif
	angle_normalize_always__xmm0
	;if (xmm0>PI)
	comiss	xmm0, xmm3
	jbe		@F	;;xmm0 > xmm3
		addss	xmm3, xmm3
		subss	xmm0, xmm3
	@@:
exit:
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

;копирования pointer1 <- pointer2
xr_memcopy	MACRO pointer1:REQ, pointer2:REQ, size_byte:REQ
	push	esi
	push	edi
	mov		ecx, size_byte/4
	mov		edi, pointer1
	mov		esi, pointer2
	rep movsd
	pop		edi
	pop		esi
ENDM

xr_memset MACRO pointer1:REQ, set:REQ, size1:REQ
	push	edi
	mov		edi, pointer1
	mov		ecx, size1
	IF set EQ 0
		xor		eax, eax
	ELSE
		mov		eax, set
	ENDIF
	rep stosd
	pop		edi
ENDM

Level__Objects_net_Find MACRO obj_id:REQ
	push    obj_id
	mov     ecx, ds:g_pGameLevel 		; IGame_Level * g_pGameLevel
	mov     eax, [ecx]
	lea     ecx, [eax+54h]
	call    ds:CObjectList__net_Find 	; CObjectList::net_Find(uint)
ENDM

nop2 MACRO
	mov		edx, edx
ENDM

nop3 MACRO
	lea		ecx, [ecx+0]
ENDM
