
align_proc
xrServer__Process_event_reject_fix proc
	; ������ ���� ��������
	.if (edi==NULL)
		; ������������� ������ �����������, ������ �������
		push	eax
		mov		eax, [esp+5Ch]
		PRINT_UINT "SV REJECT: FAILED! NO ENTITY! ID = %d", eax
		mov		eax, [esp+60h]
		PRINT_UINT "SV REJECT: FAILED! NO ENTITY! PARENT_ID = %d", eax
		mov		eax, [esp+4Ch]
		PRINT_UINT "SV REJECT: FAILED! NO ENTITY! RETURN ADDRESS = %d", eax
		pop		eax
		; ������
		pop		edi
		pop		esi
		pop		ebp
		mov		al, 1
		pop		ebx
		add		esp, 38h
		retn	18h
	.endif
	; ������ ����������
	push	ebx
	lea		eax, [esp+4Ch-1Ch]
	; ��� �������
	jmp		return_xrServer__Process_event_reject_fix
xrServer__Process_event_reject_fix endp
