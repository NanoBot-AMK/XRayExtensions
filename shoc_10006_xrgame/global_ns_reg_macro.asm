SET_INT_ARG_N	MACRO argnum:REQ
LOCAL int_arg
.data
align 4
g_int_argument_&argnum&		dword ?
.code
SetIntArg&argnum& proc
int_arg		= dword ptr	 4
	mov		eax, [esp+int_arg]
	mov		g_int_argument_&argnum&, eax
	retn
SetIntArg&argnum& endp
ENDM

GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	[ebp+8]
	call	bit_and_register
	add		esp, 12
ENDM

GLOBAL_NS_PERFORM_EXPORT__BOOL__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	lea		eax, [var1]
	push	eax
	call	register_gs__bool__void
	add		esp, 12
ENDM

GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR MACRO fun_to_export:REQ, fun_name_str:REQ
	add		esp, 12
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	[ebp+8]
	call	error_log_register
ENDM


