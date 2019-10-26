
align_proc
on_belt_callback proc
;esi	this	CInventory*
;ebp	pIItem	CInventoryItem*
	call	UpdateInventoryWeightStatic
	; вызываем колбек
	mov		edi, g_Actor
	.if ([edi].CActor.m_inventory == esi)	;только для актора
		mov		ecx, [ebp].CInventoryItem.CAttachableItem@m_item
		;smart_cast<CGameObject*>(pIItem->m_item);
		mov		edx, [ecx]
		mov		eax, [edx+12Ch]
		call	eax
		CALLBACK__GO	edi, eOnBelt, eax
	.endif
	pop		edi
	pop		esi
	pop		ebp
	mov		al, 1
	pop		ebx
	add		esp, 8
	retn	4
on_belt_callback endp

align_proc
on_ruck_callback proc
;esi	this	CInventory*
;ebp	pIItem	CInventoryItem*
	call	UpdateInventoryWeightStatic
	; вызываем колбек
	mov		edi, g_Actor
	.if ([edi].CActor.m_inventory == esi)	;только для актора
		mov		ecx, [ebp].CInventoryItem.CAttachableItem@m_item
		;smart_cast<CGameObject*>(pIItem->m_item);
		mov		edx, [ecx]
		mov		eax, [edx+12Ch]
		call	eax
		CALLBACK__GO	edi, eOnRuck, eax
	.endif
	pop		edi
	pop		ebp
	mov		al, 1
	pop		ebx
	add		esp, 0Ch
	retn	4
on_ruck_callback endp

align_proc
on_slot_callback proc
;ebx	this	CInventory*
;esi	pIItem	CInventoryItem*
	call	UpdateInventoryWeightStatic
	; вызываем колбек
	mov		edi, g_Actor
	.if ([edi].CActor.m_inventory == ebx)	;только для актора
		mov		ecx, [esi].CInventoryItem.CAttachableItem@m_item
		;smart_cast<CGameObject*>(pIItem->m_item);
		mov		edx, [ecx]
		mov		eax, [edx+12Ch]
		call	eax
		CALLBACK__GO	edi, eOnSlot, eax
	.endif
	pop		edi
	pop		esi
	mov		al, 1
	pop		ebx
	retn	4
on_slot_callback endp

align_proc
CUIItemInfo__InitItem_EXT_CHUNK proc
;ebx	pInvItem	CInventoryItem
	CALLBACK__GO	g_Actor, eOnSelectItem, [ebx].CInventoryItem.CInventoryItem@m_object
	;вырезанное
	mov		eax, [esi+70h]
	test	eax, eax
	jmp		return_CUIItemInfo__InitItem_EXT_CHUNK
CUIItemInfo__InitItem_EXT_CHUNK endp

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; колбек на дроп из интерфейса инвентаря
align_proc
CUIInventoryWnd__SendEvent_Item_Drop proc
;edi	this	CInventoryItem*
	push	eax
	CALLBACK__GO	g_Actor, eOnDropItemInInventory, [edi].CInventoryItem.CInventoryItem@m_object
	pop		eax
	;вырезанное
	mov		eax, [eax]
	cmp		dword ptr [eax+44FCh], 0
	jmp		return_CUIInventoryWnd__SendEvent_Item_Drop
CUIInventoryWnd__SendEvent_Item_Drop endp

; обновление статика веса в инвентаре
align_proc
UpdateInventoryWeightStatic proc
	call	GetGameSP
	.if (eax)
		mov		eax, [eax+60] ; CUIInventoryWnd
		lea		ecx, [eax+348h] ; weight_static
		push	1
		push	ecx
		call	InventoryUtilities__UpdateWeight
		add		esp, 8
	.endif
	retn
UpdateInventoryWeightStatic endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
