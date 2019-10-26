
PERFORM_EXPORT_VECTOR__THIS__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	registervector__this__void		;вход 4 параметра, но используются только 3
ENDM

tmpFuncVector		= dword ptr -0Ch
PERFORM_EXPORT_VECTOR__THIS__FLOAT_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	lea		ecx, [ebp+tmpFuncVector]
	push	ecx
	push	eax
	mov		[ebp+tmpFuncVector], offset fun_to_export
	call	registervector__this__float_float
ENDM