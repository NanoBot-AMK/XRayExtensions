xrServer__Process_event_reject_fix proc
	; ������ ���� ��������
	test edi, edi
	jnz entity_exist
	; ������������� ������ �����������, ������ �������
;	pop     edi
;	pop     esi
;	pop     ebp
;	mov     al, 1
;	pop     ebx
;	add     esp, 38h
;	retn    18h

	push	eax
	mov		eax, [esp+5Ch]
	PRINT_UINT "SV REJECT: FAILED! NO ENTITY! ID = %d", eax
	mov		eax, [esp+60h]
	PRINT_UINT "SV REJECT: FAILED! NO ENTITY! PARENT_ID = %d", eax
	mov		eax, [esp+4Ch]
	PRINT_UINT "SV REJECT: FAILED! NO ENTITY! RETURN ADDRESS = %d", eax
	pop		eax
	
	; ������
	pop     edi
	pop     esi
	pop     ebp
	mov     al, 1
	pop     ebx
	add     esp, 38h
	retn    18h
	
entity_exist:
	; ������ ����������
	push    ebx
	lea     eax, [esp+4Ch+var_1C]
	; ��� �������
	jmp back_from_xrServer__Process_event_reject_fix
xrServer__Process_event_reject_fix endp
