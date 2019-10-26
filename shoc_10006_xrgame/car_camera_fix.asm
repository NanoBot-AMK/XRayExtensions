
align_proc
CCar__cam_Update_fix0 proc
	mov		eax, g_CCar__cam_Update
	.if (eax)
		jmp		eax
	.endif
	sub     esp, 18h
	xorps   xmm0, xmm0
	jmp		return_CCar__cam_Update_fix0
CCar__cam_Update_fix0 endp
