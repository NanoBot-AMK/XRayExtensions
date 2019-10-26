
static_int		static_for_callback, 0

align_proc
create_cell_item_fix proc
;edi	itm		CInventoryItem*
	mov		static_for_callback, eax
	push	eax
	.if (edi)
		mov		eax, [edi].CInventoryItem.CInventoryItem@m_object
		.if (eax)
			CALLBACK__GO	g_Actor, eOnCreateIcon, eax
		.endif
	.endif
	and		static_for_callback, 0
	pop		eax
;----------------
	pop		edi
	pop		esi
	pop		ebx
	add		esp, 8
	retn
create_cell_item_fix endp

align_proc
CUIFrameWindow__GetTitleStatic_fix proc
	mov		eax, static_for_callback
	retn
CUIFrameWindow__GetTitleStatic_fix endp