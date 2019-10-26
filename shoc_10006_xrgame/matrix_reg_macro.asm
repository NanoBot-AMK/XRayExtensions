
PERFORM_EXPORT__MATRIX__THIS__FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ecx, eax
	push	0
	push	0
	mov		[ebp-0Ch], offset fun_to_export
	lea		eax, [ebp-0Ch]
	push	eax
	push	const_static_str$(fun_name_str)
	push	ecx
	call	register_matrix__this_float
ENDM

PERFORM_EXPORT__MATRIX__THIS__FLOAT_FLOAT_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_matrix__this_float_float_float
ENDM

PERFORM_EXPORT__MATRIX__THIS__PMATR_PMATR MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ecx, eax
	push	0
	push	const_static_str$(fun_name_str)
	lea		eax, [ebp-0Ch]
	push	eax
	push	ecx
	mov		[ebp-0Ch], offset fun_to_export
	call	register_matrix__this__pMatrix_pMatrix
ENDM
