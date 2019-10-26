

MMM_PERFORM_EXPORT__BOOL__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	mov     ecx, eax
	xor     eax, eax
	lea     edi, [ebp-10h]
	stosb
	push    [ebp-10h]
	lea     edi, [ebp-0Ch]
	stosb
	push    [ebp-0Ch]
	lea     eax, [ebp-8h]
	push    static_str$(fun_name_str)
	push    ecx
	mov     [ebp+var_8], offset fun_to_export
	call    register__MMM_bool__void
ENDM



