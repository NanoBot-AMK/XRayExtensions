
align_proc
CInventoryOwner@@Load_fix proc
;edi	this	CInventoryOwner*
;esi	section	LPCSTR
	smart_cast	CActor, CInventoryOwner, edi
	.if (eax)		;только для актора
;		PRINT_UINT "CInventory::CInventory_fix() owner = %08X", eax
		ASSUME	esi:ptr CInventory, edi:ptr CInventoryOwner
		mov		esi, [edi].m_inventory
		mov		ebx, const_static_str$("grenade_belt")		;гранаты с пояса
		.if (@LINE_EXIST(&aInventory, ebx))
			or		[esi].m_flags, @R_BOOL(&aInventory, ebx)
		.else
			mov		eax, g_ammo_on_belt
			and		al, 1
			or		[esi].m_flags, al
		.endif
		mov		ebx, const_static_str$("ammo_belt")			;патроны с пояса
		.if (@LINE_EXIST(&aInventory, ebx))
			shl		@R_BOOL(&aInventory, ebx), 1
			or		[esi].m_flags, al
		.else
			mov		eax, g_ammo_on_belt
			and		al, 1
			shl		al, 1
			or		[esi].m_flags, al
		.endif
		ASSUME	esi:nothing, edi:nothing
	.endif
	pop		edi
	pop		esi
	pop		ebx
	retn	4
CInventoryOwner@@Load_fix endp

;отключаем возврат указателя на рюкзак, если консольная команда включена и ищем у актора
align_proc
CInventory__Get proc
	.if (![eax].CInventory.m_flags & eInventoryAmmoBelt)
		add		eax, 14h
		jmp		return_CInventory__Get
	.endif
	pop		edi
	pop		esi
	pop		ebp
	xor		eax, eax
	pop		ebx
	pop		ecx
	retn	8
CInventory__Get endp

;блокируем поиск патронов в рюкзаке, если консольная команда включена и ищем у актора
align_proc
CWeapon__GetCurrentAmmo proc
	.if ([eax].CInventory.m_flags & eInventoryAmmoBelt)
		jmp		CWeapon__GetCurrentAmmo_not_inventory_owner
	.endif
	mov		edi, [eax].CInventory.m_ruck._Myfirst
	cmp		[eax].CInventory.m_ruck._Mylast, edi
	jmp		CWeapon__GetCurrentAmmo_not_ammo_on_belt
CWeapon__GetCurrentAmmo endp
;-------------------------------------------------------------------------------------------------
;-----------------------------------------<<<Гранаты>>>-------------------------------------------
;-------------------------------------------------------------------------------------------------
;
align_proc
CGrenade__fix1 proc
	.if ([esi].CInventory.m_flags & eInventoryGrnBelt)
		push	GEG_PLAYER_ITEM2BELT
	.else
		push	GEG_PLAYER_ITEM2RUCK
	.endif
	lea		esi, [esp+2024h-200Ch];P
	jmp		return_CGrenade__fix1
CGrenade__fix1 endp

GRENADE_SLOT		= 3

;функция поиска гранат любого типа на поясе
align_proc
CInventory__SameSlotInBelt proc uses esi edi slot:dword, pIItem:ptr CInventoryItem
;ebx	this	CInventory*
	ASSUME	ebx:ptr CInventory, edi:ptr xr_vector
	.if ([ebx].m_flags & eInventoryGrnBelt)
		lea		edi, [ebx].m_belt
	.else
		lea		edi, [ebx].m_ruck
	.endif
	.for (esi=[edi]._Myfirst: esi!=[edi]._Mylast: esi+=4)
		mov		ecx, [esi]
		.if (ecx != pIItem)
			;it->GetSlot();
			mov		eax, [ecx]
			mov		edx, [eax+0A4h]
			call	edx
			.if (eax == slot)
				mov		eax, [esi]
				jmp		exit	;ret
			.endif
		.endif
	.endfor
	ASSUME	ebx:nothing, edi:nothing
	xor		eax, eax
exit:
	ret
CInventory__SameSlotInBelt endp

align_proc
grenade_counter_fix proc
_bSearchRuck_		= byte ptr 8
	.if ([ecx].CInventory.m_flags & eInventoryGrnBelt && [esp+0Ch+_bSearchRuck_] & 2)
		lea		ebp, [ecx].CInventory.m_belt
	.endif
	mov		edi, [ebp].xr_vector._Myfirst
	cmp		[ebp].xr_vector._Mylast, edi
	jmp		return_grenade_counter_fix
grenade_counter_fix endp

align_proc	
grenade_counter_fix1 proc
	.if ([ecx].CInventory.m_flags & eInventoryGrnBelt)
		push	2
		push	eax
		mov		eax, [edx+4]
		call	eax		;CInventory::dwfGetSameItemCount(*cNameSect(), 2);
		inc		eax			; add one in slot
		jmp		return_grenade_counter_fix1
	.endif
	push	1
	push	eax
	mov		eax, [edx+4]
	call	eax
	jmp		return_grenade_counter_fix1
grenade_counter_fix1 endp