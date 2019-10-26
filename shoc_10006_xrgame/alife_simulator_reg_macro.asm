
ALIFE_SIM_PERFORM_EXPORT__LPCSTR_PFVECTOR_INT_U16_U16 MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		[ebp-08h], offset fun_to_export
	lea		eax, [ebp-08h]
	call	CALifeSimulator_register__CSE_Abstract__LPCSTR_pFvector_int_u16_u16
ENDM
