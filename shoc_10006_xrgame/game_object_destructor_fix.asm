
align_proc
game_object_destructor_fix proc
	mov		eax, [edi+4]
	.if (!eax)
		; ������� ������ ���������, ������� � ������ ��� ������� � ���
		mov		eax, [esp]	; CGameObject ptr
		mov		eax, [eax].CGameObject.NameObject.p_	; str_value � eax
		add		eax, 12
		PRINT_UINT "CGAMEOBJECT DESTRUCTOR FIX: something wrong with the object %s", eax
		pop		edi
		pop		ebx
		pop		ecx
		retn
	.endif
	mov		ecx, [eax]
	jmp		return_game_object_destructor_fix
game_object_destructor_fix endp