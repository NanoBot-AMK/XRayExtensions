ZERO_MEMORY MACRO address:REQ, size_:REQ
	push    ecx
	push    eax
	mov     eax, address
	push    size_
	xor     ecx, ecx
	push    ecx             ; Val == 0
	push    eax             ; Dst
	call    memset
	add     esp, 0Ch
	pop     eax
	pop     ecx
ENDM

CInventoryItem_constructor_fix proc
	; esi == this
	push    esi
	push    ecx
	push    eax
	
	mov     ecx, ds:Memory
	push    1024
	call    ds:xrMemory__mem_alloc ; xrMemory::mem_alloc(uint)
	test    eax, eax
	mov     [esi + 148], eax
	ZERO_MEMORY eax, 1024
	
	PRINT_UINT "II created: %x", eax
	pop     eax
	pop     ecx
	pop     esi
	; идём обратно
	jmp back_from_CInventoryItem_constructor_fix
CInventoryItem_constructor_fix endp

CInventoryItem_destructor_fix proc
	; edi == this
	push    edi
	push    ecx
	push    eax
	
	mov     ecx, ds:Memory
	mov     eax, [edi + 148]
	test    eax, eax
	jz      no_user_data
	push    eax
	push    ecx
	; здесь адрес блока уже в стеке, можно использовать регистр eax
	PRINT "trying destroy light"
	mov  ecx, eax ; ecx = inventory_item
	mov  eax, [ecx]
	test    eax, eax
	jz      no_light01
	call light_destroy
	PRINT "light destroyed"
no_light01:
	;
	pop     ecx
	call    ds:xrMemory__mem_free
	PRINT "II destroyed: delete user data"
	jmp     exit
no_user_data:
	PRINT "II destroyed: no user data to delete"
exit:
	pop     eax
	pop     ecx
	pop     edi
	; идём обратно
	jmp back_from_CInventoryItem_destructor_fix
CInventoryItem_destructor_fix endp

CInventoryItem_get_user_data proc ; ecx = this, result in eax
	mov     eax, [ecx + 148]
	retn
CInventoryItem_get_user_data endp

create_light proc ; да будет свет (результат в eax)
	push    ecx
	mov     eax, ds:Render
	mov     ecx, [eax]
	mov     eax, [ecx]
	mov     eax, [eax+84h]
	call    eax
	pop     ecx
	retn
create_light endp

render_mode proc ; вернуть тип рендера в eax
	push    ecx
	mov     ecx, ds:Render
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax]
	call    eax
	pop     ecx
	retn
render_mode endp

light_set_shadow proc ; ecx = light_ref, eax = 0/1 - shadow_on
	push    eax
	
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+0Ch]
	call    eax
	retn
light_set_shadow endp

;enum LT {
;	DIRECT,
;	POINT,
;	SPOT,
;	OMNIPART,
;	REFLECTED,
;};

light_set_type proc ; ecx = light_ref_addr, eax = type
	push    eax
	
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+0Ch]
	call    eax
	retn
light_set_type endp

light_set_position proc ; ecx = light_ref_addr, eax = position (vector)
	push    eax
	
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+14h]
	call    eax
	retn
light_set_position endp

light_set_color proc ; ecx = light_ref_addr, stack - 3*float_color
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+2Ch]
	call    eax
	retn
light_set_color endp

light_set_range proc ; ecx = light_ref_addr, eax = range (float)
	push    eax
	
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+20h]
	call    eax
	retn
light_set_range endp

light_set_angle proc ; ecx = light_ref_addr, eax = angle (float)
	push    eax
	
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+1Ch]
	call    eax
	retn
light_set_angle endp

light_get_active proc ; ecx = light_ref_addr, в eax вернётся результат
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+08h]
	call    eax
	retn
light_get_active endp

light_set_active proc ; ecx = light_ref_addr, eax = 0/1 active
	push    eax
	
	mov     ecx, [ecx]
	mov     eax, [ecx]
	mov     eax, [eax+4h]
	call    eax
	retn
light_set_active endp

light_destroy proc ; ecx = light_ref_addr
	call    ds:resptr_base_IRender_Light____dec
	retn
light_destroy endp 

align 4
aOnEatThisCallback			db "on_eat_this_callback", 0

; колбек на использования вещи, вызывается в this
align_proc
CInventory__Eat_callback proc
; ebx - pIItem			PIItem			// вещь которую сьедаем
; edi - pItemToEat		CEatableItem*	// вещь которую сьедаем
; esi - entity_alive	CEntityAlive*	// живой объект который кушает
	;// передадим колбек в биндер вещи и в параметр зададим саму вещь
	;if(pItemToEat->on_eat_this_callback)
	.if ([edi+on_eat_this_callback])
		push	edi
		; smart_cast<CGameObject*>(pIItem)->callback(GameObject::eUseObject)((smart_cast<CGameObject*>(entity_alive))->lua_game_object());
		mov     edi, esi	; CGameObject = CEntityAlive
		call    CGameObject__lua_game_object
		push    eax
		push    GameObject__eUseObject
		; smart_cast<CGameObject*>(pIItem)
		mov		edx, [ebx]
		mov		eax, [edx+12Ch]
		mov		ecx, ebx
		call	eax
		mov     ecx, eax	; CGameObject
		call    CGameObject__callback
		push    eax
		call    script_use_callback
		pop		edi
		; объект не удаляется!
		; m_iPortionsNum = m_iStartPortionsNum;
		mov		eax, [edi+m_iStartPortionsNum]
		mov		[edi+m_iPortionsNum], eax
		; return true;		// выходим из bool CInventory::Eat(PIItem pIItem)
		pop		edi
		pop		esi
		mov		al, true
		pop		ebp
		add		esp, 201Ch
		retn	4
	.endif
	;вырезаное
	cmp     dword ptr [edi+0F4h], 0
	jmp		return_CInventory__Eat_callback
CInventory__Eat_callback endp

align_proc
CInventoryItem__Load_chank proc
; esi - this	CInventoryItem*
; edi - section	LPCSTR
	mov     [esi+0C4h], eax
	;on_eat_this_callback = READ_IF_EXISTS(pSettings, r_bool, section, "on_eat_this_callback", false);
	mov		[esi+on_eat_this_callback], false
	push	offset aOnEatThisCallback		; "on_eat_this_callback"
	push	edi
	mov		eax, ds:pSettings
	mov		ecx, dword ptr[eax]
	call	ds:line_exist
	.if	(eax)
		push	offset aOnEatThisCallback	; "on_eat_this_callback"
		push	edi
		mov		eax, ds:pSettings
		mov		ecx, dword ptr[eax]
		call	ds:r_bool
		mov		[esi+on_eat_this_callback], al
	.endif
	; выходим из void CInventoryItem::Load(LPCSTR section) 
	pop     edi
	pop     esi
	pop     ebp
	pop     ebx
	add     esp, 8
	retn    4
CInventoryItem__Load_chank endp
