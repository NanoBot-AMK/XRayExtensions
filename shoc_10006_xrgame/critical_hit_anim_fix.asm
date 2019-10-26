
align_proc
global_critical_hit_anim_fix proc
	mov		eax, [eax+2B8h]
	.if (eax & 60)
		mov		eax, 3
	.endif
	jmp		return_global_critical_hit_anim_fix
global_critical_hit_anim_fix endp