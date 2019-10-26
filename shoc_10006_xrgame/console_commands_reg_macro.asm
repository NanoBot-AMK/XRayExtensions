REGISTER_CC_INT2 MACRO var_to_bind:REQ, command_name_str:REQ, low_bond:REQ, high_bond:REQ
LOCAL lab1
LOCAL flag_was_registered, cmd_obj, obj_destructor
	jmp		lab1
static_byte		flag_was_registered, 0
static_int		cmd_obj, 24 DUP (0)
obj_destructor:
	mov		ecx, offset cmd_obj
	jmp		ds:CCC_Integer___CCC_Integer ; CCC_Integer::~CCC_Integer(void)
lab1:
	.if (!flag_was_registered & 1)
		or		flag_was_registered, 1
		push	high_bond
		push	low_bond
		push	offset var_to_bind
		push	static_str$(command_name_str)
		mov		ecx, offset cmd_obj
		call	ds:CCC_Integer__CCC_Integer ; CCC_Integer::CCC_Integer(char const *,int *,int,int)
		push	offset obj_destructor ; void (__cdecl *)()
		mov		edi, offset off_104A7014
		mov		cmd_obj, edi
		call	_atexit
		add		esp, 4
	.endif
	mov		edx, ds:Console
	mov		ecx, [edx]
	push	offset cmd_obj
	call	CConsole__AddCommand ; CConsole::AddCommand(IConsole_Command *)
ENDM
;=============================================================================================
REGISTER_CC_FLOAT2 MACRO var_to_bind:REQ, command_name_str:REQ, low_bond:REQ, high_bond:REQ
LOCAL lab1
LOCAL flag_was_registered, cmd_obj, obj_destructor
LOCAL LB_, HB_
	jmp		lab1
static_int		LB_, low_bond
static_int		HB_, high_bond
static_byte		flag_was_registered, 0
static_int		cmd_obj, 24 DUP (0)
obj_destructor:
	mov		ecx, offset cmd_obj
	jmp		ds:CCC_Float___CCC_Float ; CCC_Float::~CCC_Float(void)
lab1:
	.if (!flag_was_registered & 1)
		or		flag_was_registered, 1
		push	HB_
		push	LB_
		push	offset var_to_bind
		push	static_str$(command_name_str)
		mov		ecx, offset cmd_obj
		call	ds:CCC_Float__CCC_Float 
		push	offset obj_destructor ; void (__cdecl *)()
		mov		edi, offset off_104A702C
		mov		cmd_obj, edi
		call	_atexit
		add		esp, 4
	.endif
	mov		edx, ds:Console ; CConsole * Console
	mov		ecx, [edx]
	push	offset cmd_obj
	call	CConsole__AddCommand ; CConsole::AddCommand(IConsole_Command *)
ENDM
;=============================================================================================
REGISTER_CC_FLAG MACRO bitfield_to_bind:REQ, mask_value:REQ, command_name_str:REQ
LOCAL lab1
LOCAL flag_was_registered, cmd_obj, obj_destructor
	jmp		lab1
static_byte		flag_was_registered, 0
static_int		cmd_obj, 24 DUP (0)
obj_destructor:
	mov		ecx, offset cmd_obj
	jmp		ds:CCC_Mask___CCC_Mask ; CCC_Mask::~CCC_Mask(void)
lab1:
	.if (!flag_was_registered & 1)
		mov		flag_was_registered, 1
		push	mask_value
		push	offset bitfield_to_bind
		push	static_str$(command_name_str)
		mov		ecx, offset cmd_obj
		call	ds:CCC_Mask__CCC_Mask ; CCC_Mask::CCC_Mask(char const *,_flags<uint> *,uint)
		push	offset obj_destructor ; void (__cdecl *)()
		call	_atexit
		add		esp, 4
	.endif
	mov		edx, ds:Console
	mov		ecx, [edx]
	push	offset cmd_obj
	call	CConsole__AddCommand ; CConsole::AddCommand(IConsole_Command *)
ENDM
;=============================================================================================
