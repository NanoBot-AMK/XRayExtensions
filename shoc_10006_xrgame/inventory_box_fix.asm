
align_proc
inventory_box_fix proc
	; ������ ��, ��� ��������
	call    xr_vector_u16___push_back
	push    0               ; bool
	push    ebx             ; obj
	mov     ecx, esi        ; this
	call    ds:CObject__H_SetParent
	push    0
	mov     ecx, esi
	call    ds:CObject__setVisible
	push    0
	mov     ecx, esi
	call    ds:CObject__setEnabled
	; �������� ������ ��� �����
	mov     edi, esi ; item
	call    CGameObject__lua_game_object
	CALLBACK__GO	ebx, 151, eax
	; ��� �������
	jmp back_from_inventory_box_fix
inventory_box_fix endp


