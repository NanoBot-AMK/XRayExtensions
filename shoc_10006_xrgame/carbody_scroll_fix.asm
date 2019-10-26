
align_proc
CUICarBodyWnd@@Update_fix proc
;edx	CInventory*
;ecx	time	u32
	; затычка от случая, когда инвентарь, откуда берем вещь, удаляется при открытом окне обмена
	.if (edx)
		.if ([edx].CInventory.m_dwModifyFrame==ecx)
			call	CUICarBodyWnd@@carbody_scroll_fix
		.endif
		jmp		return_CUICarBodyWnd@@Update_fix
	.endif
	mov		ecx, esi
	pop		esi
	jmp		CUIWindow__Update
CUICarBodyWnd@@Update_fix endp

align_proc
CUICarBodyWnd@@carbody_scroll_fix proc uses edi ebx
local our_scroll:dword, other_scroll:dword
;esi	this	CUICarBodyWnd*
	ASSUME	esi:ptr CUICarBodyWnd, edi:ptr CUIScrollBar
	mov		eax, [esi].m_pUIOurBagList
	mov		edi, [eax].CUIDragDropListEx.m_vScrollBar	;+84h
	mov		ecx, [edi].m_iScrollPos	;+6Ch
	mov		edx, [esi].m_pUIOthersBagList
	mov		ebx, [edi].m_iMinPos	;+74h
	mov		edi, [edx].CUIDragDropListEx.m_vScrollBar	;+84h
	mov		edx, [edi].m_iScrollPos	;+6Ch
	mov		eax, [edi].m_iMinPos	;+74h
	mov		our_scroll, ecx
	mov		ecx, eax
	sub		ecx, edx
	mov		edx, ecx
	sar		edx, 1Fh
	and		edx, ecx
	sub		eax, edx
	mov		other_scroll, eax
	call	CUICarBodyWnd@@UpdateLists
	mov		eax, [esi].m_pUIOurBagList
	mov		edi, [eax].CUIDragDropListEx.m_vScrollBar
	mov		eax, ebx
	sub		eax, our_scroll
	mov		ecx, eax
	sar		ecx, 1Fh
	and		ecx, eax
	mov		eax, [edi].m_iMaxPos	;+78h
	sub		eax, [edi].m_iPageSize	;+7Ch
	sub		ebx, ecx
	mov		[edi].m_iScrollPos, ebx	;+6Ch
	mov		edx, [edi].m_iMinPos	;+74h
	mov		ecx, ebx	   ; ecx
	inc		eax
	.if (sdword ptr ecx < edx)
		mov		[edi].m_iScrollPos, edx
	.elseif (sdword ptr ecx > eax)
		mov		[edi].m_iScrollPos, eax
	.endif
	push	esi
	mov		esi, edi
	call	CUIScrollBar@@UpdateScrollBar ; CUIScrollBar::UpdateScrollBar(void)
	pop		esi
	mov		eax, [esi].m_pUIOurBagList
	mov		ecx, [eax].CUIDragDropListEx.m_vScrollBar	;+84h
	mov		edx, [ecx]
	mov		eax, [ecx].CUIScrollBar.m_ScrollBox		;+64h	CUIScrollBox*
	mov		edx, [edx+70h]
	push	0
	push	27
	push	eax
	call	edx
	mov		ebx, [esi].m_pUIOthersBagList	;+78h
	mov		edi, [ebx].CUIDragDropListEx.m_vScrollBar	;+84h
	mov		eax, other_scroll
	mov		[edi].m_iScrollPos, eax	;+6Ch
	mov		eax, [edi].m_iMaxPos	;+78h
	sub		eax, [edi].m_iPageSize	;+7Ch
	mov		ecx, [edi].m_iScrollPos	;+6Ch
	mov		edx, [edi].m_iMinPos	;+74h
	inc		eax
	.if (sdword ptr ecx < edx)
		mov		[edi].m_iScrollPos, edx
	.elseif (sdword ptr ecx > eax)
		mov		[edi].m_iScrollPos, eax
	.endif
	push	esi
	mov		esi, edi
	call	CUIScrollBar@@UpdateScrollBar ; CUIScrollBar::UpdateScrollBar(void)
	pop		esi
	mov		ebx, [ebx].CUIDragDropListEx.m_vScrollBar	;+84h
	mov		edx, [ebx]
	mov		eax, [ebx].CUIScrollBar.m_ScrollBox		;+64h	CUIScrollBox*
	mov		edx, [edx+70h]
	push	0
	push	27
	push	eax
	mov		ecx, ebx
	call	edx
	ASSUME	esi:nothing, edi:nothing
	ret
CUICarBodyWnd@@carbody_scroll_fix endp
