
MMM_PERFORM_EXPORT__BOOL__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		[ebp+var_8], offset fun_to_export
	lea		eax, [ebp+var_8]
	call	register__MMM_bool__void
ENDM
