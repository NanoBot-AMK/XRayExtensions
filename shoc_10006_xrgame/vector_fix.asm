;
;

include vector_reg_macro.asm

align_proc
vector_script_fix proc
	call	scriptprototype__float__void
	;---------------------------------------------------------------------------------------
	PERFORM_EXPORT_VECTOR__THIS__VOID		script_vector@get_result, "get_result"
	
	;---------------------------------------------------------------------------------------
	jmp		return_vector_script_fix
vector_script_fix endp

align_proc
script_vector@get_result proc
	ASSUME	ecx:ptr Fvector
	Fvector_set	[ecx], g_vector_for_matrix
	ASSUME	ecx:nothing
	mov		eax, ecx
	ret
script_vector@get_result endp
