
;��������� ������� ��������� � ���� ������ ������
align_proc
CUICarBodyWnd@@UpdateLists_fix proc
;eax	cell_item
;esi	this (UICarBodyWnd)
;edi	**CInventoryItem
	push 	eax
	mov		edx, [edi]		; a2
	ASSUME	edx:ptr CInventoryItem
	; ���������, ��� ����������� ���������� ����� ������������� ������ ���������
	.if (g_manual_highlignt_active == 1 && [edx].m_flags & 08000h)
		; ��������� ���� ������ ��������� ; ���������������� ii ������ "manual_highlighting"
		; ������ ���������� ������� ��������� ������, ������ �������� �������� � 4-� ����� �� �������� 134
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
	;����������
	mov		ecx, [esi+74h]
	mov		edx, [ecx]
	jmp		return_CUICarBodyWnd@@UpdateLists_fix
CUICarBodyWnd@@UpdateLists_fix endp
