

align_proc
CGameObject@@lua_game_object proc (dword)
;eax - this		CGameObject*
	.if (eax)
		push	ecx
		mov		ecx, eax
		mov     eax, [ecx].CGameObject.m_lua_game_object
		.if (!eax)
			push	edi
			push	edx
			mov		edi, ecx
			call	CGameObject__lua_game_object
			pop		edx
			pop		edi
		.endif
		pop		ecx
	.endif
	ret
CGameObject@@lua_game_object endp

