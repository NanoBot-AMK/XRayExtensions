
ALIGN_8
call_pda_contact_callback proc

	push ebp
	mov ebp, esp
	;and     esp, 0FFFFFFF8h
; ��������� ���
	push eax
	push ebx
	push ecx
	push edx
	push edi
	push esi
	
	; �������� ������ ��� ������
	push    eax ; ��������
	push    eax
	; �������� ������
	;call Actor ; eax = client actor
	; �������� ������ �������
	push    180 ; type = ???
	mov     ecx, g_Actor
	call    CGameObject__callback ; eax = callback
	push    eax ; callback
	; ��������
	call    script_callback_int_int
	
	;-------------
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	;mov     esp, ebp
	pop ebp
	; ������ ��� ��������
	call ch_info_get_from_id
; ��� �������
	jmp back_from_pda_contact
call_pda_contact_callback endp


call_pda_contact_callback_msg db "call_pda_contact_callback_problem", 0