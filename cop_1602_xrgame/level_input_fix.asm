level_input_fix:
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
	xor     eax, eax
	push    eax ; ��������
	push    [ebp+8] ; ��� �������
	push    123             ; type
	; �������� ������
	mov     ecx, g_Actor
	; �������� ������ �������
	call    CGameObject__callback ; eax = callback
	mov     ecx, eax ; callback
	; ��������
	call    script_callback_int_int
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


