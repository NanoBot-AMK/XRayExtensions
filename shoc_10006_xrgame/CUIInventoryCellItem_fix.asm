
;ручное управление группируемостью предметов
align_proc
CUIInventoryCellItem__EqualTo_fix proc
;esi	ci		CInventoryItem*
;eax	this	CInventoryItem*
	mov		ebx, [edi+17Ch]		;вырезанное
	ASSUME	esi:ptr CInventoryItem, ebx:ptr CInventoryItem
	; Вызываем коллбек для ручного регулирования группировки предметов.	; by Real Wolf
	mov		eax, [ebx].CInventoryItem@m_object
	CGameObject@@lua_game_object()
	.if (eax)
		mov		g_object_arg_1, eax
		mov		eax, [esi].CInventoryItem@m_object
		.if (eax)
			CALLBACK__GO	g_Actor, 143, eax
			; Обнуление в коллбеке означает негруппировку.
			mov		eax, g_object_arg_1
			and		g_object_arg_1, 0	;=NULL
			.if (!eax)
				jmp		exit
			.endif
		.endif
	.endif
	and		g_object_arg_1, 0	;=NULL
	.if (g_manual_grouping_active)	; check manual grouping flag 
		; not in actor's inventory
		mov		eax, [ebx].m_pCurrentInventory			;CInventory*	+88h
		.if (eax) ; has no owner, process as usual
			mov		ecx, [eax].CInventory.m_pOwner		;CInventoryOwner*	+60h
			.if (ecx)	; has no owner, process as usual
				mov		eax, [ecx]
				mov		edx, [eax]
				call	edx
				.if ([eax].CGameObject.ID==0 && ([ebx].m_flags & 04000h || [esi].m_flags & 04000h))	; actors id is always 0 in single
exit:				xor		al, al
					pop		esi
					pop		edi
					pop		ebx
					pop		ecx
					retn	4
				.endif
			.endif
		.endif
	.endif
	ASSUME	esi:nothing, ebx:nothing
	mov		eax, ebx
	xor		ebx, ebx
	jmp		return_CUIInventoryCellItem__EqualTo_fix
CUIInventoryCellItem__EqualTo_fix endp
