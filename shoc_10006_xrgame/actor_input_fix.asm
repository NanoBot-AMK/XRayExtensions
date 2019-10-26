; ----------------------- ������ �� ������� ----------------------------
ALIGN_8
call_key_press_callback proc
	cmp     g_bDisableAllInput, 0
	jnz     input_disabled_exit

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
	; ��������� ���������� ���������� ��������
	mov eax, [extensions_flags]
	and eax, 1h
	jz lab_exit1
	; ���������� ������� alt � f4
	;mov eax, [ebp+8]
	;cmp eax, 56 ; ����� Alt
	;jz lab_exit1
	;cmp eax, 184; ������ Alt
	;jz lab_exit1
	;cmp eax, 62 ; F4
	;jz lab_exit1
	
	
	; �������� ������ ��� ������
	xor     eax, eax
	push    eax ; ��������
	push    [ebp+8] ; ��� �������
	; �������� ������
	;call Actor ; eax = client actor
	; �������� ������ �������
	push    123 ; type = ???
	mov     ecx, g_Actor
	call    CGameObject__callback ; eax = callback
	push    eax ; callback
	; ��������
	call    script_callback_int_int
	
lab_exit1:
	;-------------
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	;mov     esp, ebp
	pop ebp
input_disabled_exit:
; ������ ��, ��� ��������
	sub     esp, 414h
; ��� �������
	jmp back_from_key_press_callback
call_key_press_callback endp

call_key_press_callback_msg db "call_key_press_callback_problem", 0
; ----------------- ������ �� ���������� --------------------
ALIGN_8
call_key_release_callback proc
	cmp     g_bDisableAllInput, 0
	jnz     input_disabled_exit

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
	; ��������� ���������� ���������� ��������
	mov eax, [extensions_flags]
	and eax, 2h
	jz lab_exit2
	; ���������� ������� alt � f4
	mov eax, [ebp+8]
	cmp eax, 56 ; ����� Alt
	jz lab_exit2
	cmp eax, 184; ������ Alt
	jz lab_exit2
	cmp eax, 62 ; F4
	jz lab_exit2
	
	; �������� ������ ��� ������
	xor     eax, eax
	push    eax ; ��������
	push    [ebp+8] ; ��� �������
	; �������� ������
	;call Actor ; eax = client actor
	; �������� ������ �������
	push    124 ; type = ???
	mov     ecx, g_Actor
	call    CGameObject__callback ; eax = callback
	push    eax ; callback
	; ��������
	call    script_callback_int_int
lab_exit2:
	;-------------
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	;mov     esp, ebp
	pop ebp
input_disabled_exit:
; ������ ��, ��� ��������
	push    ecx
	push    ebx
	push    ebp
	mov     ebp, ecx
; ��� �������
	jmp back_from_key_release_callback
call_key_release_callback endp

call_key_release_callback_msg db "call_key_release_callback_problem", 0
; ----------------- ������ �� ��������� --------------------
ALIGN_8
call_key_hold_callback proc
	cmp     g_bDisableAllInput, 0
	jnz     input_disabled_exit

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
	; ��������� ���������� ���������� ��������
	mov eax, [extensions_flags]
	and eax, 4h
	jz lab_exit3
	; ���������� ������� alt � f4
	mov eax, [ebp+0Ch]
	cmp eax, 56 ; ����� Alt
	jz lab_exit3
	cmp eax, 184; ������ Alt
	jz lab_exit3
	cmp eax, 62 ; F4
	jz lab_exit3
	
	; �������� ������ ��� ������
	xor     eax, eax
	push    eax ; ��������
	push    [ebp+0Ch] ; ��� �������
	; �������� ������
	;call Actor ; eax = client actor
	; �������� ������ �������
	push    125 ; type = ???
	mov     ecx, g_Actor
	call    CGameObject__callback ; eax = callback
	push    eax ; callback
	; ��������
	call    script_callback_int_int
lab_exit3:
	;-------------
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	;mov     esp, ebp
	pop ebp
input_disabled_exit:
; ������ ��, ��� ��������
	cmp     dword ptr [edi+138h], 0
; ��� �������
	jmp back_from_key_hold_callback
call_key_hold_callback endp

call_key_hold_callback_msg db "call_key_hold_callback_problem", 0
; ----------------- ������ �� �������� ������ --------------------
ALIGN_8
call_mouse_wheel_callback proc
	cmp     g_bDisableAllInput, 0
	jnz     input_disabled_exit

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
	; ��������� ���������� ���������� ��������
	mov eax, [extensions_flags]
	and eax, 8h
	jz exit
	; �������� ������ ��� ������
	xor     eax, eax
	push    eax ; ��������
	push    [ebp+0Ch] ; ��� �������
	pop eax
	add eax, 100000
	push eax
	; �������� ������
	;call Actor ; eax = client actor
	; �������� ������ �������
	push    126 ; type = ???
	mov     ecx, g_Actor
	call    CGameObject__callback ; eax = callback
	push    eax ; callback
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
	
	;mov     esp, ebp
	pop ebp
input_disabled_exit:
; ������ ��, ��� ��������
	mov     ecx, [eax]
	mov     ecx, [ecx+148h]	
; ��� �������
	jmp back_from_mouse_wheel_callback
call_mouse_wheel_callback endp
	
call_mouse_wheel_callback_msg db "call_mouse_wheel_callback_problem", 0
; ----------------- ������ �� �������� ���� --------------------
ALIGN_8
call_mouse_move_callback proc
	cmp     g_bDisableAllInput, 0
	jnz     input_disabled_exit

	
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
	; ��������� ���������� ���������� ��������
	mov eax, [extensions_flags]
	and eax, 10h
	jz exit
	
	;jmp exit
	
	; �������� ������ ��� ������
	mov eax, [ebp+08h] ; dx 
	add eax, 100000
	push eax
	mov eax, [ebp+0Ch] ; dy
	add eax, 100000
	push eax
	; �������� ������
	;call Actor ; eax = client actor
	; �������� ������ �������
	push    127 ; type = ???
	mov     ecx, g_Actor ; ��� � ��� ������ �����
	call    CGameObject__callback ; eax = callback
	push    eax ; callback
	; ��������
	call    script_callback_int_int
lab_exit5:
	;-------------
exit:
	pop esi
	pop edi
	pop edx
	pop ecx
	pop ebx
	pop eax
	
	;mov     esp, ebp
	pop ebp
input_disabled_exit:
; ������ ��, ��� ��������
	push    ecx
	push    esi
	mov     esi, ecx
	mov     eax, [esi-194h]
; ��� �������
	jmp back_from_mouse_move_callback
call_mouse_move_callback endp
	
call_mouse_move_callback_msg db "call_mouse_move_callback_problem", 0
	
