GLOBAL_NS_SCOPE_ADD MACRO
	mov		ecx, eax
	call	esi 
ENDM

GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		eax, esp
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register__gs_sell_condition__fl_fl
	pop		ecx
	pop		ecx
ENDM

GLOBAL_NS_PERFORM_EXPORT__FLOAT__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		eax, esp
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	get_snd_volume_register
	pop		ecx
	pop		ecx
ENDM

