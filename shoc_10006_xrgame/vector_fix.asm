;
;

include vector_reg_macro.asm

align_proc
vector_script_fix proc
	call	registervector__float__void
	;---------------------------------------------------------------------------------------
	PERFORM_EXPORT_VECTOR__THIS__VOID			Fvector@get_result,				"get_result"
	PERFORM_EXPORT_VECTOR__THIS__FLOAT_FLOAT	Fvector@TestThrow,				"test_throw"
	
	;---------------------------------------------------------------------------------------
	jmp		return_vector_script_fix
vector_script_fix endp

align_proc
Fvector@get_result proc
	Fvector_set	[ecx].Fvector, g_vector_for_matrix
	mov		eax, ecx
	ret
Fvector@get_result endp

align_proc
Fvector@TestThrow proc uses esi edi throw_vel:real4, gravity_accel:real4
local throw_dir[2]:Fvector
	ASSUME	edi:ptr Fvector, esi:ptr Fvector
	mov		esi, ecx	;this
	lea		edi, throw_dir
	.if (TransferenceAndThrowVelToThrowDir(esi, throw_vel, gravity_accel, edi))
		Fvector_set	[esi], [edi]
	.else
		Fvector_set	[esi], 0.0, 0.0, 0.0
	.endif
	ASSUME	edi:nothing, esi:nothing
	mov		eax, esi
	ret
Fvector@TestThrow endp
