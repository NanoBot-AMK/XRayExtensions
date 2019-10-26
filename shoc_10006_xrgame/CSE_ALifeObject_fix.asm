include CSE_ALifeObject_fix_macro.asm

create_CSE_ALifeObject_sflags_writer	CSE_ALifeObject__used_ai_locations_w,	80h

align_proc
CSE_ALifeObject__script_register_fix proc
	call    sub_102F6079
	;---------------------------
	CSE_PERFORM_EXPORT__VOID__BOOL	CSE_ALifeObject__used_ai_locations_w,	"use_ai_locations"
	;---------------------------
	jmp		return_CSE_ALifeObject__script_register_fix
CSE_ALifeObject__script_register_fix endp



