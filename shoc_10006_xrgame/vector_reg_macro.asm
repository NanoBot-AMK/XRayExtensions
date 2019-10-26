
PERFORM_EXPORT_VECTOR__THIS__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ecx, eax
	push	[ebp-3Ch]
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	ecx
	call	scriptprototype__this__void		;вход 4 параметра, но используются только 3
ENDM