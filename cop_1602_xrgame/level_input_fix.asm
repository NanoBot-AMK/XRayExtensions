
level_input_fix proc
	push ebp
	mov ebp, esp
; ��������� ���
	push eax
	push ebx
	push ecx
	push edx
	push edi
	push esi
	; �������� ������ ��� ������
	; �������� ������
	mov     ecx, g_Actor
	test	ecx, ecx
	jz		exit
		xor     eax, eax
		push    eax ; ��������
		push    [ebp+8] ; ��� �������
		push    123             ; type
		; �������� ������ �������
		call    CGameObject__callback ; eax = callback
		mov     ecx, eax ; callback
		; ��������
		call    script_callback_int_int
exit:
	;-------------
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	pop ebp
; ������ ��, ��� ��������
	sub     esp, 410h
; ��� �������
	jmp back_from_level_input_fix
level_input_fix endp

