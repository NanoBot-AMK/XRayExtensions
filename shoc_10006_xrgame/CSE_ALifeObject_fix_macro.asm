
CSE_PERFORM_EXPORT__VOID__BOOL MACRO fun_to_export:REQ, fun_name_str:REQ
	push    0
	push    offset fun_to_export
	push    static_str$(fun_name_str)
	push    eax
	call    register_CSE__VOID__BOOL
ENDM

create_CSE_ALifeObject_sflags_writer MACRO fun_name:REQ, flag_mask:REQ
fun_name proc bool_arg:byte
	.if (bool_arg)
		or      dword ptr [ecx+0B4h], flag_mask
		ret		4
	.endif
	and     dword ptr [ecx+0B4h], 0ffffffffh XOR flag_mask
	ret		4
fun_name endp
ENDM
