
;кастомная заливка предметов в окне обыска ящиков
align_proc
CUICarBodyWnd@@UpdateLists_fix proc
;eax	cell_item
;esi	this (UICarBodyWnd)
;edi	**CInventoryItem
	push 	eax
	mov		edx, [edi]		; a2
	ASSUME	edx:ptr CInventoryItem
	; проверяем, что активирован глобальный режим использования ручной раскраски
	.if (g_manual_highlignt_active == 1 && [edx].m_flags & 08000h)
		; проверяем флаг ручной раскраски ; пользовательский ii флажок "manual_highlighting"
		; задано подсветить предмет кастомным цветом, индекс которого хранится в 4-х битах по смещению 134
		movzx	ecx, [edx].m_custom_color	;+134
		and		ecx, 1111b
		push	g_highlight_colors[ecx*4]
		mov		ecx, eax
		mov		eax, [ecx]
		mov		edx, [eax+90h]
		call	edx	; SetColor
	.endif
	ASSUME	edx:nothing
	pop 	eax
	;вырезанное
	mov		ecx, [esi+74h]
	mov		edx, [ecx]
	jmp		return_CUICarBodyWnd@@UpdateLists_fix
CUICarBodyWnd@@UpdateLists_fix endp
