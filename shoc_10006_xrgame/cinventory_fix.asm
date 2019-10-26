
align_proc
CInventory__CInventory_fix proc
;esi	this	CInventory*
;ebp	owner	CInventoryOwner*
	ASSUME	esi:ptr CInventory
	mov		[esi].m_pOwner, ebx		;=NULL
	mov		[esi].m_flags, bl		;m_flags.zero();
	ASSUME	esi:nothing
;----------------------
	mov		eax, esi
	pop		ebx
	add		esp, 110h
	retn
CInventory__CInventory_fix endp

align_proc
CInventory__Take_fix proc
	mov		ecx, [ebx].CInventory.m_pOwner
	.if (ecx)
		mov		eax, [ecx]
		mov		edx, [eax+0B4h]
		push	ebp
		call	edx
	.endif
	jmp		return_CInventory__Take_fix
CInventory__Take_fix endp

align_proc
CInventory__Ruck_fix proc
	mov		ecx, [esi].CInventory.m_pOwner
	.if (ecx)
		mov		eax, [ebp+98h]
		mov		edx, [ecx]
		mov		edx, [edx+0BCh]
		push	eax
		push	ebp
		call	edx
	.endif
	jmp		return_CInventory__Ruck_fix
CInventory__Ruck_fix endp

align_proc
CInventory__DropItem_fix proc
	mov		ecx, [esi].CInventory.m_pOwner
	.if (ecx)
		mov		edx, [ecx]
		push	eax
		mov		eax, [edx+0C4h]
		call	eax
	.endif
	jmp		return_CInventory__DropItem_fix
CInventory__DropItem_fix endp

;вызываем колбек на предиспользование предмета
align_proc
CInventory__Eat_fix proc
; ebx - pIItem			PIItem			// вещь которую сьедаем
; esi - entity_alive	CEntityAlive*	// живой объект который кушает
	mov		ecx, ds:g_pGamePersistent
	mov		edx, [ecx]
	mov		eax, [edx+424h]
	.if (eax<=1 && esi==g_Actor)		;// только для актора
		;smart_cast<CGameObject*>(pIItem);
		mov		ecx, ebx
		mov		edx, [ebx]
		mov		eax, [edx+12Ch]
		call	eax
		CALLBACK__GO	esi, eOnBeforeUseItem, eax
	.endif
	;вырезанное
	mov		edx, [edi]
	mov		eax, [edx+130h]
	jmp		return_CInventory__Eat_fix
CInventory__Eat_fix endp
