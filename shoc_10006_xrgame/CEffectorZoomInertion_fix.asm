
align_proc
CEffectorZoomInertion__Process_fix proc
	mov		eax, g_CEffectorZoomInertion__Process
	.if (eax)
		jmp		eax
	.endif
	sub		esp, 12
	push	ebx
	push	esi
	jmp		return_CEffectorZoomInertion__Process_fix
CEffectorZoomInertion__Process_fix endp
