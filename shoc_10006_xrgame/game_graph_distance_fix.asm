
align_proc
game_graph__distance_fix proc
	.if (xmm0==FP4(65535.0))
		; ага, проблемный путь. Надо его сбросить.
		mov		ecx, [ebp+30h]
		mov		[ebp+34h], ecx
		jmp		loc_100569C9
	.endif
	; делаем вырезанное
	movss	xmm1, dword ptr [ebp+24h]
	jmp		back_from_game_graph__distance_fix
game_graph__distance_fix endp
