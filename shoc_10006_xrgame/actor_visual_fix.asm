
align_proc
actor_visual_fix proc
	mov		ecx, [esi].CActor.m_inventory
	mov		eax, [ecx].CInventory.m_slots._Myfirst
	add		eax, 60h
	mov		eax, [eax].CInventorySlot.m_pIItem
	test	eax, eax
	jnz		loc_1024C35F
	jmp		return_actor_visual_fix
actor_visual_fix endp

align_proc
actor_visual_drop_fix proc
	mov     dword ptr [eax+4], 0
	mov		edx, [ebp+0]
	mov		eax, [edx+0A4h]
	mov		ecx, ebp
	call	eax
	; провер€ем номер слота
	.if (eax!=6)
		; ок, выкидывают броню из слота. ѕросто вызовем дл€ нее OnMoveToRuck
		mov		edx, [ebp+0]
		mov		edx, [edx+9Ch]
		mov		ecx, ebp
		call	edx
	.endif
	jmp		return_actor_visual_drop_fix
actor_visual_drop_fix endp
