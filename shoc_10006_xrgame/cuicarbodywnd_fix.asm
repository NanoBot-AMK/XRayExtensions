;.text:103CBF42                 mov     eax, [edi]
;.text:103CBF44                 call    create_cell_item
CUICarBodyWnd__UpdateLists_fix proc
	; eax == cell_item, esi == this (UICarBodyWnd), edi == **CInventoryItem
	push eax
	push ebx
	push esi
	push edi
	mov     ebx, [edi]      ; a2
	mov     edi, eax

	;
	; ���������, ��� ����������� ���������� ����� ������������� ������ ���������
	cmp     [g_manual_highlignt_active], 1 ; z set if g_manual_highlignt_active == 1
	jnz     no_colorization ; ������ �� ����������, �� ������������
	; �������� ���� ������ ���������
	mov     eax, [ebx+132] ; ������ ��������
	test    eax, 08000h ; ���������������� ii ������ "manual_highlighting"
	jz      no_colorization ; � ������� �� cmp, z ��������������� ���� �� ����� �����
	; ������ ���������� ������� ��������� ������, ������ �������� �������� � 4-� ����� �� �������� 134
	push    esi
	mov     esi, [ebx+134]
	and     esi, 0Fh
	mov     eax, [g_highlight_colors + esi*4]
	pop     esi
	push    eax
	;
	mov     eax, [edi]
	mov     edx, [eax+90h]
	mov     ecx, edi
	call    edx ; SetColor
no_colorization:
	;
	pop edi
	pop esi
	pop ebx
	pop eax
	; ������ ����������
	mov     ecx, [esi+74h]
	mov     edx, [ecx]
	;
	jmp back_from_CUICarBodyWnd__UpdateLists_fix
CUICarBodyWnd__UpdateLists_fix endp
