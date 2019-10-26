ZERO_MEMORY MACRO address:REQ, size_:REQ
	push	ecx
	push	eax
	push	size_
	push	0				; Val == 0
	push	address			; Dst
	call	memset
	add		esp, 0Ch
	pop		eax
	pop		ecx
ENDM

align_proc
CInventoryItem_constructor_fix proc
;esi	this	CInventoryItem*
	push	eax
	mov		ecx, ds:Memory
	push	1024
	call	ds:xrMemory__mem_alloc ; xrMemory::mem_alloc(uint)
	mov		[esi].CInventoryItem.m_nameComplex, eax		;+148
	ZERO_MEMORY eax, 1024
	PRINT_UINT "II created: %x", eax
	pop		eax
	jmp		return_CInventoryItem_constructor_fix
CInventoryItem_constructor_fix endp

align_proc
CInventoryItem_destructor_fix proc
;edi	this	CInventoryItem*
	mov		ecx, ds:Memory
	mov		eax, [edi].CInventoryItem.m_nameComplex
	.if (eax)
		push	eax
		push	ecx
		; здесь адрес блока уже в стеке, можно использовать регистр eax
		PRINT "trying destroy light"
		mov		ecx, eax ; ecx = inventory_item
		mov		eax, [ecx]
		.if (eax)
			call	light_destroy
			PRINT "light destroyed"
		.endif
		pop		ecx
		call	ds:xrMemory__mem_free
		PRINT "II destroyed: delete user data"
	.else
		PRINT "II destroyed: no user data to delete"
	.endif
	; идём обратно
	jmp		return_CInventoryItem_destructor_fix
CInventoryItem_destructor_fix endp

align_proc
CInventoryItem_get_user_data proc ; ecx = this, result in eax
	mov		eax, [ecx].CInventoryItem.m_nameComplex
	ret
CInventoryItem_get_user_data endp

align_proc
create_light proc ; да будет свет (результат в eax)
	mov		eax, ds:Render
	mov		ecx, [eax]
	mov		eax, [ecx]
	mov		eax, [eax+84h]
	call	eax
	retn
create_light endp

align_proc
render_mode proc ; вернуть тип рендера в eax
	mov		ecx, ds:Render
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax]
	call	eax
	retn
render_mode endp

align_proc
light_set_shadow proc ; ecx = light_ref, eax = 0/1 - shadow_on
	push	eax
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+0Ch]
	call	eax
	retn
light_set_shadow endp

;enum LT {
;	DIRECT,
;	POINT,
;	SPOT,
;	OMNIPART,
;	REFLECTED,
;};
align_proc
light_set_type proc ; ecx = light_ref_addr, eax = type
	push	eax
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+0Ch]
	call	eax
	retn
light_set_type endp

align_proc
light_set_position proc ; ecx = light_ref_addr, eax = position (vector)
	push	eax
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+14h]
	call	eax
	retn
light_set_position endp

align_proc
light_set_color proc ; ecx = light_ref_addr, stack - 3*float_color
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+2Ch]
	call	eax
	retn
light_set_color endp

align_proc
light_set_range proc ; ecx = light_ref_addr, eax = range (float)
	push	eax
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+20h]
	call	eax
	retn
light_set_range endp

align_proc
light_set_angle proc ; ecx = light_ref_addr, eax = angle (float)
	push	eax
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+1Ch]
	call	eax
	retn
light_set_angle endp

align_proc
light_get_active proc ; ecx = light_ref_addr, в eax вернётся результат
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+08h]
	call	eax
	retn
light_get_active endp

align_proc
light_set_active proc ; ecx = light_ref_addr, eax = 0/1 active
	push	eax
	mov		ecx, [ecx]
	mov		eax, [ecx]
	mov		eax, [eax+4h]
	call	eax
	retn
light_set_active endp

align_proc
light_destroy proc ; ecx = light_ref_addr
	call	ds:resptr_base_IRender_Light____dec
	retn
light_destroy endp 

; колбек на использования вещи, вызывается в this
align_proc
CInventory__Eat_callback proc
; ebx - pIItem			PIItem			// вещь которую сьедаем
; edi - pItemToEat		CEatableItem*	// вещь которую сьедаем
; esi - entity_alive	CEntityAlive*	// живой объект который кушает
	;// передадим колбек в биндер вещи и в параметр зададим саму вещь
	ASSUME	edi:ptr CEatableItem
	; smart_cast<CGameObject*>(pItemToEat)->callback(GameObject::eUseObject)((smart_cast<CGameObject*>(entity_alive))->lua_game_object());
	smart_cast	CGameObject, CEatableItem, edi
	mov		ebp, eax
	CALLBACK__GO	ebp, eEatObject, esi	; CGameObject = CEntityAlive
	; объект не удаляется!
	.if ([edi].m_bOnEatNotDelete)
		mrm		[edi].m_iPortionsNum, [edi].m_iStartPortionsNum
		; return true;		// выходим из bool CInventory::Eat(PIItem pIItem)
		pop		edi
		pop		esi
		mov		al, true
		pop		ebp
		add		esp, 201Ch
		retn	4
	.endif
	;вырезаное
	cmp		[edi].m_iPortionsNum, 0
	ASSUME	edi:nothing
	jmp		return_CInventory__Eat_callback
CInventory__Eat_callback endp

const_static_str		aNotDelete, "not_delete"	; объект не удаляется. 

align_proc
CEatableItem__Load_chank proc
; esi - this	CEatableItem*
; edi - section	LPCSTR
	ASSUME	esi:ptr CEatableItem
	;m_bOnEatNotDelete = READ_IF_EXISTS(pSettings, r_bool, section, "not_delete", false);
	mov		[esi].m_bOnEatNotDelete, false
	push	offset aNotDelete		; "not_delete"
	push	edi
	mov		eax, ds:pSettings
	mov		ecx, dword ptr[eax]
	call	ds:line_exist
	.if	(eax)
		push	offset aNotDelete	; "not_delete"
		push	edi
		mov		eax, ds:pSettings
		mov		ecx, dword ptr[eax]
		call	ds:r_bool
		mov		[esi].m_bOnEatNotDelete, al
	.endif
	ASSUME	esi:nothing
	; выходим из void CInventoryItem::Load(LPCSTR section) 
	pop		edi
	pop		esi
	retn	4
CEatableItem__Load_chank endp
