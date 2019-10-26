
align_proc
CUITradeWnd__CanMoveToOther_fix proc
;eax	this	CUITradeWnd*
;ebx	item	CInventoryItem*
	ASSUME	ebx:ptr CInventoryItem
	.if (g_trade_filtration_active)	; ��������� ���������� ������
		.if ([ebx].m_flags & 01000h)	; ��������� ������ ����� ��������� �������� ��������
			mov		al, true
			retn
		.endif
		.if ([ebx].m_flags & 02000h)	; ��������� ������ ������ ������� �������� ��������
			mov		al, false
			retn
		.endif
	.endif
	; ������ ��, ��� ��������
	sub		esp, 1Ch
	push	esi
	mov		esi, eax
	mov		eax, [esi+5Ch]
	jmp		return_CUITradeWnd__CanMoveToOther_fix
CUITradeWnd__CanMoveToOther_fix endp

;������ ��������� ���������:
;1.	���� do_colorize == false, ������ ������� �� � ��������� ������, �� ������������
;2.	���� ������� �� �������� �� ���������� ������� CUITradeWnd__CanMoveToOther,
;	��� �������� ����� � ������ �� ���������, �� ��������� ���������� ������ � �������� 0 �� �������
;3.	���� ������ ������ ���������� ���������� �������� � ��� �������� ������� ��� ���������
;	������ ��������� ��������, �� ������������ ������ �� ������� m_custom_color
align_proc
CUITradeWnd@@GetIndexColor proc (byte)
;al		bool
;ebx	item	CInventoryItem*
	.if (al==false)		;��������� ������, ������ � ���� � �������� 0 (������ �������)
		xor		ecx, ecx
		mov		al, true
	;����� ���������, ��������� ��������� ���������
	.elseif (g_manual_highlignt_active && [ebx].m_flags & 08000h)	; ���������������� ii ������ "manual_highlighting"
		;���������� ������� ��������� ������, ������ �������� �������� � 4-� ����� � m_custom_color
		movzx	ecx, [ebx].m_custom_color	;+134
		and		ecx, 1111b
		mov		al, true
	.else	; ������ �� ����������, ��������� ���������� ��� ���������, �� �� ������������ �����
		mov		al, false
	.endif
	mov		edx, g_highlight_colors[ecx*4]		;� edx ���������� ����
	ASSUME	ebx:nothing
	ret
CUITradeWnd@@GetIndexColor endp
