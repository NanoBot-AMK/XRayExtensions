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

;include macros_eval.asm

_static MACRO any_params:VARARG
.data
align 4
% any_params
.code
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
name_param		byte	param, 0
.code
ENDM

;type_variable	name_variable = value
;STATIC MACRO params:VARARG
;LOCAL name_variable, type_variable, value

;.data
;align 4
;name_variable	type_variable value
;_CODE SEGMENT
;ENDM

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

PRINT_STR MACRO val_txt:REQ
	pusha
	push	val_txt
	call	Msg
	add		esp, 04h
	popa
ENDM

PRINT MACRO msg_txt:REQ
	pusha
	push	static_str$(msg_txt)
	call	Msg
	add		esp, 04h
	popa
ENDM

PRINT_UINT MACRO fmt_txt:REQ, val:REQ
	pusha
	push	val
	push	static_str$(fmt_txt)
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
	push	static_str$(fmt_txt)
	call	Msg
	add		esp, 12
	popa
ENDM

FLUSH_LOG MACRO
	pusha
	call	[FlushLog]
	popa
ENDM

RT_DYNAMIC_CAST MACRO source, dest, reg
	push	0
	push	offset dest
	push	offset source
	push	0
	push	reg
	call	__RTDynamicCast
	add		esp, 14h
ENDM

PRINT_VECTOR MACRO fmt_txt:REQ, val:REQ
	pusha
	push	val
	push	static_str$(fmt_txt)
	call	Log_vector3
	add		esp, 8
	popa
ENDM

invoke2	MACRO proc_name:REQ, param:VARARG
	invoke	proc_name, param
	org		$-5
	call	@CatStr(_ds@,<proc_name>)
ENDM

@g_Alive  MACRO obj_entity:req
	xorps	xmm1, xmm1
	mov		eax, obj_entity.CEntity@m_entity_condition
	movss	xmm0, [eax+CEntityConditionSimple.m_fHealth]
	comiss	xmm0, xmm1
	EXITM <!carry?>
ENDM

;вызов виртуальной функции
vcall MACRO	_this:REQ, class_name_func:REQ, params:VARARG
	LOCAL num
	IFNB <params>
		num = @InStr(1, <&class_name_func>, <.>)
		.erre num, <"The symbol a point is not found.">
		invoke	(@SubStr(<&class_name_func>, 1, num-1) ptr[edx+12345678h])@SubStr(<&class_name_func>, num), params
		org		$-6
	ENDIF
	IF @SearchStr(<_this>,<ebx,ebp,esi,edi>)
		mov		eax, dword ptr [_this]
		mov		edx, dword ptr [eax+&class_name_func&]
		mov		ecx, _this
	ELSE
		IFDIFI <_this>,<ecx>
		mov		ecx, _this
		ENDIF
		mov		eax, dword ptr [ecx]
		mov		edx, dword ptr [eax+&class_name_func&]
	ENDIF
	call	edx
ENDM

;Умный способ приведения типов(классов)
;Аналог smart_cast<CLASS1*>(CLASS2* object)
;Если задано два параметра то используется виртуальный метод, первый: имя класса, второй: указатель на объект
;Если три, то универсальный способ через __RTDynamicCast, первый: имя класса, второй: имя класса объекта, третий: указатель на объект
;Задавать непосредствено имена классов без всяких префиксов!
; (c) NanoBot
smart_cast	MACRO	class_1_or_virt_class:REQ, class_2_or_object:REQ, object
	IFB <object>
		IFDIFI <class_2_or_object>,<ecx>
		mov		ecx, class_2_or_object
		ENDIF
		mov		eax, dword ptr [ecx]
		mov		edx, dword ptr [eax+virt@@CGameObject.cast_&class_1_or_virt_class&]
		call	edx
	ELSE
		push	0
		push	offset @CatStr(_AV,<class_1_or_virt_class>)
		push	offset @CatStr(_AV,<class_2_or_object>)
		push	0
		push	object
		call	__RTDynamicCast
		add		esp, 20
	ENDIF
ENDM
;приведения через виртуальные методы
smart_castV MACRO	class_1:REQ, class_2:REQ, object:REQ
	IFDIFI <object>,<ecx>
	mov		ecx, object
	ENDIF
	mov		eax, dword ptr [ecx]
	mov		edx, dword ptr [eax+virt@@&class_2&.cast_&class_1&]
	call	edx
ENDM

@smart_cast	MACRO	class_1_or_virt_class:REQ, class_2_or_object:REQ, object
	smart_cast	class_1_or_virt_class, class_2_or_object, object
	test	eax, eax
	EXITM <!zero?>
ENDM

;============================================================================================
;	Макросы колбеков, названия соотвествует передаваемым параметрам
CALLBACK__GO	MACRO	_this:REQ, type_callback:REQ, param1:REQ
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

CALLBACK__GO_FLOAT_VECTOR_GO_u16 MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ, vector3:REQ, param4:REQ, param5:REQ
	IF (TYPE (param5) EQ 2)
		movzx	eax, param5
		push	eax
	ELSE
		push	param5
	ENDIF
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

CALLBACK__GO_STR	MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__GO_str
ENDM

CALLBACK__GO_STR_STR_STR	MACRO _this:REQ, type_callback:REQ, param1:REQ, param2:REQ, param3:REQ, param4:REQ
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

CALLBACK__FLOAT_FLOAT_INT_u32	MACRO _this:REQ, type_callback:REQ, param1:REQ, param2:REQ, param3:REQ, param4:REQ
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

CALLBACK__STR_u16	MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__str_u16
ENDM

CALLBACK__INT_INT	MACRO	_this:REQ, type_callback:REQ, param1:REQ, param2:REQ
	push	param2
	push	param1
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__u32_u32
ENDM

CALLBACK__VOID	MACRO	_this:REQ, type_callback:REQ
	push	type_callback
	mov		ecx, _this
	call	CGameObject__callback
	push	eax
	call	script_callback__void
ENDM
;============================================================================================

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

float@clamp	MACRO param, min, max
	pushflt	min
	maxss	param, dword ptr [esp]
	pushflt	max
	minss	param, dword ptr [esp]
	add		esp, 8
ENDM

;скалярное произведения 3d вектора
;результат возвращается xmm0.0, регистры xmm0, xmm1 не сохраняются
Fvector4@dotproduct MACRO vec_this:req, param2:req
	movaps	xmm0, vec_this
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

Fvector@normalize MACRO vec_this:req
	sub		esp, 16
	movups	xmm0, xmmword ptr vec_this
	movups	xmmword ptr [esp], xmm0
	xor		eax, eax
	mov		[esp+12], eax;dword ptr 
	movups	xmm0, xmmword ptr [esp]
	movaps	xmm2, xmm0
	mulps	xmm0, xmm0
	movss	xmm1, xmm0				; xmm1.x = x
	shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
	addss	xmm1, xmm0				; xmm1 = x + y
	shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
	addss	xmm0, xmm1				; xmm0 = z + xmm1
	sqrtss	xmm1, xmm0
	xorps	xmm0, xmm0
	movflt	xmm0, 1.0
	divss	xmm0, xmm1
	shufps	xmm0, xmm0, 11000000b
	mulps	xmm0, xmm2
	movups	xmmword ptr [esp], xmm0
	mrm		vec_this.x, [esp]
	mrm		vec_this.y, [esp+4]
	mrm		vec_this.z, [esp+8]
	add		esp, 16
ENDM

;ICF	void	transform_tiny(Tvector &dest, const Tvector &v)	const // preferred to use
;{
;	dest.x = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x + this.c.x;
;	dest.y = v.x*this.i.y + v.y*this.j.y + v.z*this.k.y + this.c.y;
;	dest.z = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x + this.c.x;
;}
;matrix_this:Fmatrix4, vec_result:Fvector4, vec:Fvector
;69 bytes
Fmatrix4@transform_tiny MACRO matrix_this:req, vec_result:req, vec:req
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
	movups	vec_result, xmm0
ENDM

;ICF	void	transform_dir		(Tvector &dest, const Tvector &v)	const	// preferred to use
;{
;	dest.x = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x;
;	dest.y = v.x*this.i.y + v.y*this.j.y + v.z*this.k.y;
;	dest.z = v.x*this.i.x + v.y*this.j.x + v.z*this.k.x;
;}
Fmatrix4@transform_dir MACRO matrix_this:req, vec_result:req, vec:req
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
	movups	vec_result, xmm0
ENDM
	
;209 bytes
Fmatrix4@mul_43 MACRO matrix_this:req, A:req, B:req
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

PI					equ	 3.14159265359
M_PI				equ -3.14159265359
PI_MUL_2			equ	 6.28318530718
R_PI_MUL_2			equ	 0.15915494309
;// normalize angle (0..2PI)
;ICF float		angle_normalize_always	(float a)
;{
;	float		div	 =	a/PI_MUL_2;
;	int			rnd	 =	(div>0)?iFloor(div):iCeil(div);
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
	IF (TYPE (obj_id) EQ 2)
		movzx	eax, obj_id
		push	eax
	ELSE
		push	obj_id
	ENDIF
	mov		ecx, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
	mov		eax, [ecx]
	lea		ecx, [eax+54h]
	call	ds:CObjectList__net_Find	; CObjectList::net_Find(uint)
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

;if_goto MACRO condition:req;;, _label:req
;	.while (1)
;	.break .if (<condition>)
;	.endw
;;_label:	
;ENDM

;xr_vector
xr_vector@pop MACRO this_vector:req, param:req, class_vector
	mov		param, this_vector._Mylast[0-sizeof class_vector]
ENDM

return MACRO result
	IFNB <result>
		IFIDNI <result>,<NULL>
			xor		eax, eax
		ELSE
			IF @InStr(1, <&result>, <&>) EQ 1
				lea		eax, @SubStr(<&result>, 2)
			ELSE
				mov		eax, result
			ENDIF
		ENDIF
	ENDIF
	ret
ENDM

;безусловный assert, авост игры.
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

CREATE_TEXTURE MACRO name_texture:req
	push	name_texture
	mov		eax, ds:resptrcode_shader@@create
	add		eax, offsetCreate_Texture_Init
	call	eax
ENDM

DELETE_TEXTURE MACRO pTexture:req
	push	pTexture
	mov		eax, ds:resptrcode_shader@@create
	add		eax, offsetDelete_Texture
	call	eax
ENDM

@reg2mem MACRO reg:req, mem:req
	LOCAL _mem
	IF @InStr(1, <&mem>, <&>) EQ 1
		_mem equ @SubStr(<&mem>, 2)
;;		%echo @CatStr(%OPATTR (_mem))
		IF ((OPATTR _mem) AND DIRECT_ADDR)
		EXITM <mov	reg, offset _mem>
		ELSE
		EXITM <lea	reg, _mem>
		ENDIF
	ENDIF
	EXITM <mov	reg, mem>
ENDM

@push2mem MACRO mem:req
	LOCAL _mem
	IF @InStr(1, <&mem>, <&>) EQ 1
		_mem equ @SubStr(<&mem>, 2)
		IF ((OPATTR (_mem)) AND DIRECT_ADDR)
			push 	offset _mem
		ELSE
			lea		eax, _mem
			push	eax
		ENDIF
	ELSE
		push	mem
	ENDIF
	EXITM <>
ENDM

@STRCMP MACRO str_shader1:req, str2:req
	@reg2mem (eax, str_shader1)
	@reg2mem (ecx, str2)
	call	xr_strcmp
	EXITM <eax>
ENDM
;str1 -> str2
StrCopy MACRO str1:req, str2:req
	@reg2mem (edx, str1)
	@reg2mem (ecx, str2)
	.repeat
		mov		al, [edx]
		mov		[ecx], al
		inc		edx
		inc		ecx
	.until (al==0)
ENDM

@LINE_EXIST MACRO name_sect:req, name_param:req
	@push2mem (name_param)
	@push2mem (name_sect)
	mov		eax, ds:pSettings	;; CInifile const * const pSettings
	mov		ecx, dword ptr[eax]
	call	ds:line_exist		;; CInifile::line_exist(char const *,char const *)
	EXITM <eax>
ENDM

;возвращает в стеке сопроцессора.
@R_FLOAT MACRO name_sect:req, name_param:req
	@push2mem (name_param)
	@push2mem (name_sect)
	mov		eax, ds:pSettings			; CInifile const * const pSettings
	mov		ecx, dword ptr[eax]
	call	ds:r_float
	EXITM <>
ENDM

;		value equ @SubStr(<&expression>, num+2)
;		dest equ @SubStr(<&expression>, 1, num-1)
;		%echo value
;		%echo dest
;;	%echo @CatStr(%num)
;;	%echo @SubStr(<&condition>, 2, num-2)
operator@pp MACRO reg:req
	LOCAL cycle0, exit, cycle1, else_if, break_cycle1
	ASSUME	eax:ptr _Node@ref_texture
	cmp		[reg]._Isnil, 0
	jnz		exit
	mov		eax, [reg]._Right
	cmp		[eax]._Isnil, 0
	jnz		else_if
	mov		reg, eax
	mov		eax, [reg]._Left
	cmp		[eax]._Isnil, 0
	jnz		exit
cycle0:
	mov		reg, eax
	mov		eax, [reg]._Left
	cmp		[eax]._Isnil, 0
	jz		cycle0
	jmp		exit
else_if:
	mov		eax, [reg]._Parent
	cmp		[eax]._Isnil, 0
	jnz		break_cycle1
cycle1:
	cmp		reg, [eax]._Right
	jnz		break_cycle1
	mov		reg, eax
	mov		eax, [eax]._Parent
	cmp		[eax]._Isnil, 0
	jz		cycle1
break_cycle1:
	mov		reg, eax
exit:
	ASSUME	eax:nothing
	EXITM <>
ENDM
;	_Myiter& operator++()
;	{	// preincrement
;	if (_Mytree::_Isnil(_Ptr))
;		;	// end() shouldn't be incremented, don't move
;	else if (!_Mytree::_Isnil(_Mytree::_Right(_Ptr)))
;		_Ptr = _Mytree::_Min(_Mytree::_Right(_Ptr));	// ==> smallest of right subtree
;	else
;		{	// climb looking for right subtree
;		_Nodeptr _Pnode;
;		while (!_Mytree::_Isnil(_Pnode = _Mytree::_Parent(_Ptr))
;			&& _Ptr == _Mytree::_Right(_Pnode))
;			_Ptr = _Pnode;	// ==> parent while right subtree
;		_Ptr = _Pnode;	// ==> parent (head if end())
;		}
;	return (*this);
;	}
;operator++
map@operator@inc MACRO class_map:req, reg:req
;_Ptr - reg
	ASSUME	eax:ptr _Node@&class_map&
	.if (![reg]._Isnil)
		mov		eax, [reg]._Right
		.if (![eax]._Isnil)
			.repeat
				mov		reg, eax
				mov		eax, [eax]._Left
			.until ([eax]._Isnil)
		.else
			mov		eax, [reg]._Parent	;_Nodeptr _Pnode;
			.while (![eax]._Isnil && reg==[eax]._Right)
			;	.break .if (reg!=[eax]._Right)
				mov		reg, eax
				mov		eax, [eax]._Parent
			.endw
			mov		reg, eax
		.endif
	.endif
	ASSUME	eax:nothing
	EXITM <>
ENDM
;	_Myiter& operator--()
;	{	// predecrement
;	if (_Mytree::_Isnil(_Ptr))
;		_Ptr = _Mytree::_Right(_Ptr);	// end() ==> rightmost
;	else if (!_Mytree::_Isnil(_Mytree::_Left(_Ptr)))
;		_Ptr = _Mytree::_Max(_Mytree::_Left(_Ptr));	// ==> largest of left subtree
;	else
;		{	// climb looking for left subtree
;		_Nodeptr _Pnode;
;		while (!_Mytree::_Isnil(_Pnode = _Mytree::_Parent(_Ptr))
;			&& _Ptr == _Mytree::_Left(_Pnode))
;			_Ptr = _Pnode;	// ==> parent while left subtree
;		if (_Mytree::_Isnil(_Ptr))
;			;	// begin() shouldn't be decremented, don't move
;		else
;			_Ptr = _Pnode;	// ==> parent if not head
;		}
;	return (*this);
;	}
;operator--
map@operator@dec MACRO class_map:req, reg:req
	ASSUME	eax:ptr _Node@&class_map&
	.if ([reg]._Isnil)
		mov		reg, [reg]._Right
	.else
		mov		eax, [reg]._Left
		.if (![eax]._Isnil)
			.repeat
				mov		reg, eax
				mov		eax, [eax]._Right
			.until ([eax]._Isnil)
		.else
			mov		eax, [reg]._Parent	;_Nodeptr _Pnode;
			.while (![eax]._Isnil && reg==[eax]._Left)
				mov		reg, eax
				mov		eax, [eax]._Parent
			.endw
			.if (![eax]._Isnil)
				mov		reg, eax
			.endif
		.endif
	.endif
	ASSUME	eax:nothing
	EXITM <>
ENDM

;вычисляем выражения ++, --, +=, -=, &=, |=, ^=, =
@expr MACRO param:req
	LOCAL num, value, dest
	;;echo param
	num = @InStr(1, <&param>, <++>)
	IF num GT 0
		EXITM <inc	@SubStr(<&param>, 1, num-1)>
	ENDIF
	num = @InStr(1, <&param>, <-->)
	IF num GT 0
		EXITM <dec	@SubStr(<&param>, 1, num-1)>
	ENDIF
	num = @InStr(1, <&param>, <+=>)
	IF num GT 0
		EXITM <add	@SubStr(<&param>, 1, num-1), @SubStr(<&param>, num+2)>
	ENDIF
	num = @InStr(1, <&param>, <-=>)
	IF num GT 0
		EXITM <sub	@SubStr(<&param>, 1, num-1), @SubStr(<&param>, num+2)>
	ENDIF
	num = @InStr(1, <&param>, <&=>)
	IF num GT 0
		EXITM <and	@SubStr(<&param>, 1, num-1), @SubStr(<&param>, num+2)>
	ENDIF
	num = @InStr(1, <&param>, <|=>)
	IF num GT 0
		EXITM <or	@SubStr(<&param>, 1, num-1), @SubStr(<&param>, num+2)>
	ENDIF
	num = @InStr(1, <&param>, <^=>)
	IF num GT 0
		EXITM <xor	@SubStr(<&param>, 1, num-1), @SubStr(<&param>, num+2)>
	ENDIF
	num = @InStr(1, <&param>, <=>)
	IF num GT 0
		value equ @SubStr(<&param>, num+1)
		dest equ @SubStr(<&param>, 1, num-1)
		;;%echo @CatStr(%value)
		;;%echo @CatStr(%dest)
		IF @SearchStr(<%value>,<0.0,0.,0>)
			IF @SearchStr(%dest,<eax,ebx,ecx,edx,esp,ebp,esi,edi>) NE 0
				EXITM <xor	dest, dest>
			ENDIF
			EXITM <and	dest, 0>
		ENDIF
		EXITM <mov	dest, value>
	ENDIF
	EXITM <param>
ENDM

;Имитация for (iterator=const, condition, expression) стиля С
count_for			= 0
for_expression1		equ <>
for_expression2		equ <>
for_expression3		equ <>
for_expression4		equ <>
for_expression5		equ <>
for_expression6		equ <>
@for MACRO begin_init, condition, expression
	LOCAL num
	;;;echo begin_init condition expression
	count_for = count_for + 1
	IF count_for EQ 1
		for_expression1 equ <expression>
	ELSEIF count_for EQ 2
		for_expression2 equ <expression>
	ELSEIF count_for EQ 3
		for_expression3 equ <expression>
	ELSEIF count_for EQ 4
		for_expression4 equ <expression>
	ELSEIF count_for EQ 5
		for_expression5 equ <expression>
	ELSEIF count_for EQ 6
		for_expression6 equ <expression>
	ELSE
		.err <The Maximum quantity of the enclosed cycles is no more 6!!>	;;Максимальное количество вложенных циклов не больше 6!
	ENDIF
	IFNB <begin_init>
		@expr(<begin_init>)
	ENDIF
	num = @SizeStr(<condition>)
	IF num EQ 0
		.while (1)	;; бесконечный цикл
	ELSE
		.while (@SubStr(<&condition>, 2, num-2))	;; уберём кавычки
	ENDIF
	EXITM <>
ENDM
endf MACRO
	LOCAL expression
	IF count_for EQ 1
		expression equ <for_expression1>
	ELSEIF count_for EQ 2
		expression equ <for_expression2>
	ELSEIF count_for EQ 3
		expression equ <for_expression3>
	ELSEIF count_for EQ 4
		expression equ <for_expression4>
	ELSEIF count_for EQ 5
		expression equ <for_expression5>
	ELSEIF count_for EQ 6
		expression equ <for_expression6>
	ENDIF
	count_for = count_for - 1
	IF @SizeStr(%expression) NE 0
		@expr(%expression)
	ENDIF
	.endw
ENDM

;======================================================================
;PURGE CVIRTUAL, COMINTERFACE, ENDCOMINTERFACE;, ENDMETHODS

COMINTERFACE MACRO CName:REQ
	curClass TEXTEQU <CName>
	@CatStr(CName, < COMSTRUCT >)
	union	;; начало объединение	//объединим методы и параметры в одну структуру
	struct	;; начало методов
	CVIRTUAL 	QueryInterface,	<STDCALL>, <dword>, riid:ptr _GUID, ppvObj:ptr ptr
	CVIRTUAL 	AddRef, 		<STDCALL>, <dword>
	CVIRTUAL 	Release, 		<STDCALL>, <dword>
ENDM

ENDMETHODS MACRO
	ends	;; конец методов
	struct	;; начало параметров
ENDM

ENDCOMINTERFACE MACRO
	LOCAL sz1
	ends	;; конец параметров
	ends	;; конец объединение
	curClass ENDS
	pDef CATSTR <ptr&curClass&>, < typedef PTR >, <&curClass>
	% pDef
ENDM

CVIRTUAL MACRO method:REQ, langType:REQ, retType:REQ, protoDef:VARARG
	LOCAL sz1, sz2
	pDef CATSTR <TYPEDEF PROTO >,<&langType&>,< (&retType&)>
	IFNB <protoDef>
		pDef CATSTR pDef, <, >, <&protoDef>
	ENDIF
	sz2 CATSTR curClass, <@@&method>	;; curClass@@method
	% &sz2 &pDef
;;	% echo &sz2 &pDef
	% sz1 typedef PTR &sz2
	% method sz1 ?
ENDM

;@CatStr(%value)
CLASS MACRO CName:REQ
	curClass TEXTEQU <CName>
	@CatStr(CName, < CSTRUCT >)
	union	;; начало объединение	//объединим методы и параметры в одну структуру
	struct	;; начало методов
ENDM

CMETHOD MACRO method:REQ, langType:REQ, retType:REQ, protoDef:VARARG
	LOCAL sz1, sz2
	pDef CATSTR <TYPEDEF PROTO >,<&langType&>,< (&retType&)>;;
	IFNB <protoDef>
		pDef CATSTR pDef, <, >, <&protoDef>
	ENDIF
	sz2 CATSTR curClass, <@@&method>, <Pto>	;; curClass@@method
	% &sz2 &pDef
;;	sz2 CATSTR <_>, curClass, <_&method>, <Pto>
	% sz1 typedef PTR &sz2
	% method sz1 offset &curClass&@@&method&
ENDM

ENDCLASS MACRO
	ends	;; конец параметров
	ends	;; конец объединение
	curClass ENDS
	.data
	align 16
	% _stat&curClass &curClass <>
	ptrDefS TEXTEQU <psr>
	ptrDefS CATSTR ptrDefS, <&curClass&>, < TYPEDEF PTR >, <&curClass&>
	% ptrDefS
	.code
ENDM

_NEW MACRO className:REQ, ctorArgs:VARARG
	% mov r8, sizeof(className)
	MEMALLOC(r8)
	.if (rax != 0)
		mov rdi,rax
		% lea rsi,_stat&className
		% mov rcx, sizeof(className)
		rep movsb
		fnex TEXTEQU <_>
		fnex CATSTR fnex, <&className&>
		fnex CATSTR fnex, <_>
		fnex CATSTR fnex, <Init>
		IFNB <ctorArgs>
			fnex2 TEXTEQU <invoke fnex, rax, ctorArgs>
		ELSE
			fnex2 TEXTEQU <invoke fnex, rax>
		ENDIF
		fnex2
	.endif
	exitm<rax>
ENDM

;только для Win32
_DEREF MACRO itype:REQ, proc:REQ, argCount:REQ, argsAndRefs:VARARG
	LOCAL i, ptrstr, typestr, argstr
	argstr TEXTEQU < >
	i = 0
	FOR dref, <argsAndRefs>
		IF i LT argCount+1 
			IF i GT 0
				argstr CATSTR argstr, <,>, <&dref&>
			ENDIF
		ELSE
			IF (i-argCount) MOD 2 EQ 1
				ptrstr TEXTEQU <&dref&>
			ELSE
				typestr TEXTEQU <&dref&>
				IF (i-argCount) EQ 1
					% IF(OPATTR(ptrstr)) EQ 0x30
						% mov ecx, &ptrstr&
					ELSE
						% mov ecx, @CatStr(<[>, <&ptrstr&>, <].>, <&typestr&>)
					ENDIF
				ELSE
					% mov ecx, @CatStr(<[>, <&ptrstr&>, <].>, <&typestr&>)
				ENDIF
			ENDIF
		ENDIF
		i = i + 1
	ENDM

	% IF @SizeStr(<%&argstr&>) GT 3
		argstr SUBSTR argstr, 3
	ENDIF
	IF argCount EQ 0
	   argstr TEXTEQU <>
	ENDIF
	
	IF argCount GT 0
		InterfacePtr TEXTEQU <_>
		InterfacePtr CATSTR InterfacePtr, <&itype>, <_>, <&proc>, <Pto>
		IF(OPATTR(ecx)) AND 00010000b
			mov edx,[ecx]
			IF argCount GT 0
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ELSE
			mov edx,[ecx]
			IF argCount GT 0
				FOR arg, <argstr>
					IFIDNI <&arg>, <ecx>
						.ERR <ecx is not allowed as a Method parameter with indirect object label>
					ENDIF
				ENDM
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ENDIF
	ELSE
		InterfacePtr TEXTEQU <_>
		InterfacePtr CATSTR InterfacePtr, <&itype>, <_>, <&proc>, <Pto>
		IF(OPATTR(ecx)) AND 00010000b
			mov edx,[ecx]
			IF argCount GT 0
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ELSE
			mov edx,[ecx]
			IF argCount GT 0
				FOR arg, <argstr>
					IFIDNI <&arg>, <ecx>
						.ERR <ecx is not allowed as a Method parameter with indirect object label>
					ENDIF
				ENDM
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ENDIF
	ENDIF
ENDM

;только для Win32
_DEREFI MACRO itype:REQ, proc:REQ, argCount:REQ, argsAndRefs:VARARG
	LOCAL i, ptrstr, typestr, argstr
	argstr TEXTEQU < >
	i = 0
	FOR dref, <argsAndRefs>
		IF i LT argCount+1 
			IF i GT 0
				argstr CATSTR argstr, <,>, <&dref&>
			ENDIF
		ELSE
			IF (i-argCount) MOD 2 EQ 1
				ptrstr TEXTEQU <&dref&>
			ELSE
				typestr TEXTEQU <&dref&>
				IF (i-argCount) EQ 1
					% IF(OPATTR(ptrstr)) EQ 0x30
						% mov ecx, &ptrstr&
					ELSE
						% mov ecx, @CatStr(<[>, <&ptrstr&>, <].>, <&typestr&>)
					ENDIF
				ELSE
					% mov ecx, @CatStr(<[>, <&ptrstr&>, <].>, <&typestr&>)
				ENDIF
			ENDIF
		ENDIF
		i = i + 1
	ENDM

	% IF @SizeStr(<%&argstr&>) GT 3
		argstr SUBSTR argstr, 3
	ENDIF
	IF argCount EQ 0
	   argstr TEXTEQU <>
	ENDIF
	
	IF argCount GT 0
		InterfacePtr TEXTEQU <_>
		InterfacePtr CATSTR InterfacePtr, <&itype>, <_>, <&proc>, <Pto>
		IF(OPATTR(ecx)) AND 00010000b
			mov edx,[ecx]
			IF argCount GT 0
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ELSE
			mov edx,[ecx]
			IF argCount GT 0
				FOR arg, <argstr>
					IFIDNI <&arg>, <ecx>
						.ERR <ecx is not allowed as a Method parameter with indirect object label>
					ENDIF
				ENDM
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ENDIF
	ELSE
		InterfacePtr TEXTEQU <_>
		InterfacePtr CATSTR InterfacePtr, <&itype>, <_>, <&proc>, <Pto>
		IF(OPATTR(ecx)) AND 00010000b
			mov edx,[ecx]
			IF argCount GT 0
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ELSE
			mov edx,[ecx]
			IF argCount GT 0
				FOR arg, <argstr>
					IFIDNI <&arg>, <ecx>
						.ERR <ecx is not allowed as a Method parameter with indirect object label>
					ENDIF
				ENDM
				% invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx, &argstr
			ELSE
				invoke(InterfacePtr PTR[edx].&itype&vtbl.&proc), ecx
			ENDIF
		ENDIF
	ENDIF
	IF @LastReturnType EQ 0
        EXITM <al>
    ELSEIF @LastReturnType EQ 0x40
        EXITM <al>
    ELSEIF @LastReturnType EQ 1
        EXITM <ax>
    ELSEIF @LastReturnType EQ 0x41
        EXITM <ax>
    ELSEIF @LastReturnType EQ 2
        EXITM <eax>
    ELSEIF @LastReturnType EQ 0x42
        EXITM <eax>
    ELSEIF @LastReturnType EQ 3
        EXITM <rax>
    ELSEIF @LastReturnType EQ 0x43
        EXITM <rax>
    ELSEIF @LastReturnType EQ 0xc3
        EXITM <rax>
    ELSEIF @LastReturnType EQ 6
        EXITM <xmm0>
    ELSEIF @LastReturnType EQ 7
        EXITM <ymm0>
    ELSEIF @LastReturnType EQ 8
        EXITM <zmm0>
    ELSEIF @LastReturnType EQ 0x22
        EXITM <xmm0>
    ELSEIF @LastReturnType EQ 0x23
        EXITM <xmm0>
    ELSE
        EXITM <eax>
    ENDIF
ENDM

;;enum lang_type {
LANG_NONE       	= 0
LANG_C          	= 1
LANG_SYSCALL    	= 2
LANG_STDCALL    	= 3
LANG_PASCAL     	= 4
LANG_FORTRAN    	= 5
LANG_BASIC      	= 6
LANG_FASTCALL   	= 7
LANG_VECTORCALL 	= 8
LANG_SYSVCALL   	= 9
LANG_DELPHICALL 	= 10
;;};

;вызов виртуальной функции из UASM, только Win32
;на манер С++
_VCALL_CPP MACRO	_this:REQ, class_name:REQ, func_name:REQ, num_lang_type:REQ, params:VARARG
	InterfacePtr TEXTEQU <>
	InterfacePtr CATSTR InterfacePtr, <&class_name>, <@@>, <&func_name>
	IF num_lang_type EQ LANG_PASCAL
		push	dword ptr _this
	ENDIF
	;;вводим параметры через прототип.
	IFNB <params>
		% invoke(InterfacePtr PTR[edx]), &params
		org		$-2
	ENDIF
	IFDIFI <_this>,<ecx>
		mov		ecx, dword ptr _this
	ENDIF
	mov		eax, dword ptr [ecx]
	mov		edx, dword ptr [eax+&class_name&.&func_name&]
	IF (num_lang_type NE LANG_FASTCALL AND num_lang_type NE LANG_PASCAL)
		push	ecx
	ENDIF
	call	edx
ENDM

_VCALL_CPPI MACRO	_this:REQ, class_name:REQ, func_name:REQ, num_lang_type:REQ, params:VARARG
	InterfacePtr TEXTEQU <>
	InterfacePtr CATSTR InterfacePtr, <&class_name>, <@@>, <&func_name>
	IF num_lang_type EQ LANG_PASCAL
		push	dword ptr _this
	ENDIF
	;;вводим параметры через прототип.
	IFNB <params>
		% invoke(InterfacePtr PTR[edx]), &params
		org		$-2
	ENDIF
	IFDIFI <_this>,<ecx>
		mov		ecx, dword ptr _this
	ENDIF
	mov		eax, dword ptr [ecx]
	mov		edx, dword ptr [eax+&class_name&.&func_name&]
	IF (num_lang_type NE LANG_FASTCALL AND num_lang_type NE LANG_PASCAL)
		push	ecx
	ENDIF
	call	edx
	IF @LastReturnType EQ 0
        EXITM <al>
    ELSEIF @LastReturnType EQ 0x40
        EXITM <al>
    ELSEIF @LastReturnType EQ 1
        EXITM <ax>
    ELSEIF @LastReturnType EQ 0x41
        EXITM <ax>
    ELSEIF @LastReturnType EQ 2
        EXITM <eax>
    ELSEIF @LastReturnType EQ 0x42
        EXITM <eax>
    ELSEIF @LastReturnType EQ 3
        EXITM <rax>
    ELSEIF @LastReturnType EQ 0x43
        EXITM <rax>
    ELSEIF @LastReturnType EQ 0xc3
        EXITM <rax>
    ELSEIF @LastReturnType EQ 6
        EXITM <xmm0>
    ELSEIF @LastReturnType EQ 7
        EXITM <ymm0>
    ELSEIF @LastReturnType EQ 8
        EXITM <zmm0>
    ELSEIF @LastReturnType EQ 0x22
        EXITM <xmm0>
    ELSEIF @LastReturnType EQ 0x23
        EXITM <xmm0>
    ELSE
        EXITM <eax>
    ENDIF
ENDM
;;		invoke	(&class_name& ptr[edx+12345678h]).&func_name&, params
;;		mov		edx, dword ptr [eax+&class_name&.&func_name&]
;;	IF @SearchStr(<_this>,<ebx,ebp,esi,edi>)
;;		mov		eax, dword ptr [_this]
;;		mov		edx, dword ptr [eax+&class_name&.&func_name&]
;;		mov		ecx, _this
;;	ELSE
;;		mov		ecx, dword ptr _this
;;	ENDIF
;% echo @CatStr(%InterfacePtr)
;	% echo @CatStr(%OPATTR(%InterfacePtr))
arginvoke MACRO argNo:REQ, invCount:REQ, func:REQ, args:VARARG
	arg equ <invoke func>
	FOR var, <args>
		arg CATSTR arg, <, var>
	ENDM
	arg
	IF @LastReturnType EQ 0
        EXITM <al>
    ELSEIF @LastReturnType EQ 0x40
        EXITM <al>
    ELSEIF @LastReturnType EQ 1
        EXITM <ax>
    ELSEIF @LastReturnType EQ 0x41
        EXITM <ax>
    ELSEIF @LastReturnType EQ 2
        EXITM <eax>
    ELSEIF @LastReturnType EQ 0x42
        EXITM <eax>
    ELSEIF @LastReturnType EQ 3
        EXITM <rax>
    ELSEIF @LastReturnType EQ 0x43
        EXITM <rax>
    ELSEIF @LastReturnType EQ 0xc3
        EXITM <rax>
    ELSEIF @LastReturnType EQ 6
        EXITM <xmm0>
    ELSEIF @LastReturnType EQ 7
        EXITM <ymm0>
    ELSEIF @LastReturnType EQ 8
        EXITM <zmm0>
    ELSEIF @LastReturnType EQ 0x22
        EXITM <xmm0>
    ELSEIF @LastReturnType EQ 0x23
        EXITM <xmm0>
    ELSE
        EXITM <eax>
    ENDIF
ENDM

; uinvoke MACRO func:REQ, args:VARARG
	; IFB <args>
		; invoke func
	; ELSE
		; invoke func, args
	; ENDIF
	; IF @LastReturnType EQ 0
        ; EXITM <al>
    ; ELSEIF @LastReturnType EQ 0x40
        ; EXITM <al>
    ; ELSEIF @LastReturnType EQ 1
        ; EXITM <ax>
    ; ELSEIF @LastReturnType EQ 0x41
        ; EXITM <ax>
    ; ELSEIF @LastReturnType EQ 2
        ; EXITM <eax>
    ; ELSEIF @LastReturnType EQ 0x42
        ; EXITM <eax>
    ; ELSEIF @LastReturnType EQ 3
        ; EXITM <rax>
    ; ELSEIF @LastReturnType EQ 0x43
        ; EXITM <rax>
    ; ELSEIF @LastReturnType EQ 0xc3
        ; EXITM <rax>
    ; ELSEIF @LastReturnType EQ 6
        ; EXITM <xmm0>
    ; ELSEIF @LastReturnType EQ 7
        ; EXITM <ymm0>
    ; ELSEIF @LastReturnType EQ 8
        ; EXITM <zmm0>
    ; ELSEIF @LastReturnType EQ 0x22
        ; EXITM <xmm0>
    ; ELSEIF @LastReturnType EQ 0x23
        ; EXITM <xmm0>
	; ENDIF
; ENDM

