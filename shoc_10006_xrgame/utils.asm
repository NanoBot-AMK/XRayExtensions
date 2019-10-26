

align_proc
CGameObject@@lua_game_object proc (dword)
;ecx - this		CGameObject*
	ASSUME	ecx:ptr CGameObject
	xor		eax, eax
	.if (ecx)
		.if (![ecx].m_lua_game_object)
			push	edi
			mov		edi, ecx
			call	CGameObject__lua_game_object
			mov		ecx, edi
			pop		edi
		.endif
		mov     eax, [ecx].m_lua_game_object
	.endif
	ASSUME	ecx:nothing
	retn
CGameObject@@lua_game_object endp

