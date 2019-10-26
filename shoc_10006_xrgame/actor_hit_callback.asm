
;скриптовый колбек на хит актора
align_proc
CActor@@HitSignal_callback proc perc:real4, vLocalDir:ptr Fvector, who:ptr CObject, element:word
	push	esi
	push	edi
	mov		esi, ecx
	mov		ecx, who
	call	CGameObject@@lua_game_object
	mov		edi, eax
	mov		ecx, esi
	call	CGameObject@@lua_game_object
	mov		edx, eax	;безсмыслено, лучше передать оружие из которого актёра подстрелили!!!
	mov		ecx, vLocalDir	
	CALLBACK__GO_FLOAT_VECTOR_GO_u16	esi, GameObject__eHit, edx, perc, [ecx].Fvector, edi, element
	pop		edi
	mov		ecx, esi
	pop		esi
	leave
	jmp		CActor@@HitSignal
CActor@@HitSignal_callback endp
