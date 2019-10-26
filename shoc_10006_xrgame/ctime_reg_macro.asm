
tmpFuncVector		= dword ptr -10h
CTIME_PERFORM_EXPORT__VOID__INT_INT_INT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	mov		[ebp+tmpFuncVector], offset fun_to_export
	push	eax
	lea		eax, [ebp+tmpFuncVector]
	call	CTime_register__void__int_int_int
ENDM

CTIME_PERFORM_EXPORT__VOID__PINT_PINT_PINT_PINT_PINT_PINT_PINT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	mov		[ebp+tmpFuncVector], offset fun_to_export
	push	eax
	lea		eax, [ebp+tmpFuncVector]
	call	CTime_register__void__pu32_pu32_pu32_pu32_pu32_pu32_pu32
ENDM
