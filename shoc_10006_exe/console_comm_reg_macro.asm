REGISTER_CC_FLAG MACRO bitfield_to_bind:REQ, mask_value:REQ, command_name_str:REQ
LOCAL lab1
LOCAL flag_was_registered, cmd_obj, obj_destructor
	jmp		lab1
static_byte		flag_was_registered, 0
static_int		cmd_obj, 24 DUP (0)
obj_destructor:
	mov		ecx, ds:Console
	mov		cmd_obj, offset IConsole_Command___vftable ; const IConsole_Command::`vftable'
	.if (ecx)
		push	offset cmd_obj ; C
		call	CConcole__RemoveCommand ; CConsole::RemoveCommand(IConsole_Command *)
	.endif
	retn
lab1:
	.if (!flag_was_registered & 1)
		or		flag_was_registered, 1
		push	mask_value
		push	offset bitfield_to_bind
		push	static_str$(command_name_str) 
		mov		ecx, offset cmd_obj
		call	CCC_Mask__CCC_Mask ; CCC_Mask::CCC_Mask(char const *,_flags<uint> *,uint)
		push	offset obj_destructor ; void (__cdecl *)()
		call	_atexit
		add		esp, 4
	.endif
	mov		edi, ds:Console ; CConsole * Console
	mov		ecx, offset cmd_obj
	mov		ecx, [ecx+4]
	add		edi, 484h
	lea		esi, [esp+10h]
	mov		[esp+10h], ecx
	call	sub_4B9E10
	mov		dword ptr [eax], offset cmd_obj
ENDM

REGISTER_CC_FLOAT MACRO var_to_bind:REQ, command_name_str:REQ, low_bond:REQ, high_bond:REQ
LOCAL lab1
LOCAL flag_was_registered
LOCAL cmd_obj
LOCAL obj_destructor
LOCAL LB_, HB_
	jmp		lab1
static_float	LB_, low_bond
static_float	HB_, high_bond
static_byte		flag_was_registered, 0
static_int		cmd_obj, 24 DUP (0)
obj_destructor:
	mov		ecx, ds:Console
	mov		cmd_obj, offset IConsole_Command___vftable ; const IConsole_Command::`vftable'
	.if (ecx)
		push	offset cmd_obj ; C
		call	CConcole__RemoveCommand ; CConsole::RemoveCommand(IConsole_Command *)
	.endif
	retn
lab1:
	.if (!flag_was_registered & 1)
		or		flag_was_registered, 1
		push	HB_
		push	LB_
		push	offset var_to_bind
		push	static_str$(command_name_str)
		mov		ecx, offset cmd_obj
		call	CCC_Float__CCC_Float 
		push	offset obj_destructor ; void (__cdecl *)()
		call	_atexit
		add		esp, 4
	.endif
	mov		edi, ds:Console ; CConsole * Console
	mov		ecx, offset cmd_obj
	mov		ecx, [ecx+4]
	add		edi, 484h
	lea		esi, [esp+10h]
	mov		[esp+10h], ecx
	call	sub_4B9E10
	mov		dword ptr [eax], offset cmd_obj
ENDM

REGISTER_CC_INT MACRO var_to_bind:REQ, command_name_str:REQ, low_bond:REQ, high_bond:REQ
LOCAL lab1
LOCAL flag_was_registered, cmd_obj, obj_destructor
	jmp		lab1
static_byte		flag_was_registered, 0
static_int		cmd_obj, 24 DUP (0)
obj_destructor:
	mov		ecx, ds:Console
	mov		cmd_obj, offset IConsole_Command___vftable ; const IConsole_Command::`vftable'
	.if (ecx)
		push	offset cmd_obj ; C
		call	CConcole__RemoveCommand ; CConsole::RemoveCommand(IConsole_Command *)
	.endif
	retn
lab1:
	.if (!flag_was_registered & 1)
		or		flag_was_registered, 1
		push	high_bond
		push	low_bond
		push	offset var_to_bind
		push	static_str$(command_name_str)
		mov		ecx, offset cmd_obj
		call	CCC_Integer__CCC_Integer ; CCC_Integer::CCC_Integer(char const *,int *,int,int)
		push	offset obj_destructor ; void (__cdecl *)()
		call	_atexit
		add		esp, 4
	.endif
	mov		edi, ds:Console
	mov		edx, offset cmd_obj
	mov		edx, [edx+4]
	add		edi, 484h
	lea		esi, [esp+10h]
	mov		[esp+10h], edx
	call	sub_4B9E10
	mov		dword ptr [eax], offset cmd_obj
ENDM

REGISTER_CC_VECTOR3 MACRO var_to_bind:REQ, command_name_str:REQ, min_x:REQ, min_y:REQ, min_z:REQ, max_x:REQ, max_y:REQ, max_z:REQ
LOCAL lab1
LOCAL flag_was_registered, cmd_obj, obj_destructor
LOCAL _MIN_X, _MIN_Y, _MIN_Z
LOCAL _MAX_X, _MAX_Y, _MAX_Z
	jmp		lab1
static_float	_MIN_X, min_x
static_float	_MIN_Y, min_y
static_float	_MIN_Z, min_z
static_float	_MAX_X, max_x
static_float	_MAX_Y, max_y
static_float	_MAX_Z, max_z
static_byte		flag_was_registered, 0
static_int		cmd_obj, 24 DUP (0)
obj_destructor:
	mov		ecx, ds:Console
	mov		cmd_obj, offset IConsole_Command___vftable ; const IConsole_Command::`vftable'
	.if (ecx)
		push	offset cmd_obj ; C
		call	CConcole__RemoveCommand ; CConsole::RemoveCommand(IConsole_Command *)
	.endif
	retn
lab1:
	.if (!flag_was_registered & 1)
		or		flag_was_registered, 1
		push	_MAX_Z
		push	_MAX_Y
		push	_MAX_X
		push	_MIN_Z
		push	_MIN_Y
		push	_MIN_X
		push	offset var_to_bind
		push	static_str$(command_name_str)
		mov		ecx, offset cmd_obj
		call	CCC_Vector3__CCC_Vector3 ; CCC_Vector3::CCC_Vector3(const char *, _vector3<float> *, _vector3<float>, _vector3<float>)
		push	offset obj_destructor ; void (__cdecl *)()
		call	_atexit
		add		esp, 4
	.endif
	mov		edi, ds:Console
	mov		edx, offset cmd_obj
	mov		edx, [edx+4]
	add		edi, 484h
	lea		esi, [esp+10h]
	mov		[esp+10h], edx
	call	sub_4B9E10
	mov		dword ptr [eax], offset cmd_obj
ENDM
