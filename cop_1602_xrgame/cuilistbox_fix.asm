cuilistbox_fix1 proc
	; ������ ���
	xor		eax, eax
	push	eax
	mov		eax, offset CUIListBox__GetMainInputReceiver
	push	eax
	push	offset aGetMainInputReceiver ; "GetMainInputReceiver"
	; ������ ��, ��� ��������
	xor		eax, eax
	push	eax
	mov		eax, offset CUIScrollView__GetItem
	; ��� �������
	jmp		back_from_cuilistbox_fix1
cuilistbox_fix1 endp

aGetMainInputReceiver db "GetMainInputReceiver",0

cuilistbox_fix2 proc
	; ������ ��, ��� ��������
	call	register__cuilistbox__CUIWindows__UINT
	mov		ecx, eax
	; ������ ���
	call	register__cuilistbox__CUIWindows__UINT ; ��� ����������� ����� �������, ������� ����� ��� input receiver
	mov		ecx, eax
	; ��� �������
	jmp	   back_from_cuilistbox_fix2
cuilistbox_fix2 endp


CUIListBox__GetMainInputReceiver proc near
stub = dword ptr  4
	call	CurrentGameUI
	.if		eax != 0
		lea		ecx, [eax+10h]
		call	CDialogHolder__TopInputReceiver
	.endif
	retn	4
CUIListBox__GetMainInputReceiver endp

