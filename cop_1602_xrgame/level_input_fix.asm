
; ������ �� ������� ������
level_input_CallbackKeyPress proc
	push 	ebp
	mov 	ebp, esp
; ��������� ���
	push 	eax
	push 	ebx
	push 	ecx
	push 	edx
	push 	edi
	push 	esi
	; �������� ������ ��� ������
	mov     ecx, g_Actor	; �������� ������
	.if		ecx != 0
		push    0						; ��������
		push    [ebp+8] 				; ��� �������
		push    123             		; ��� �������
		call    CGameObject__callback 	; �������� ������ �������
		mov     ecx, eax 				
		call    script_callback_int_int	; �������� callback
	.endif
	;-------------
	pop 	esi
	pop 	edi
	pop 	edx
	pop 	ecx
	pop 	ebx
	pop 	eax
	
	pop 	ebp
; ������ ��, ��� ��������
	sub     esp, 410h
; ��� �������
	jmp 	back_from_level_input_CallbackKeyPress
level_input_CallbackKeyPress endp

; ������ �� ��������� ������
level_input_CallbackKeyRelease proc
key				= dword ptr 4
	push 	ebp
	mov 	ebp, esp
	; �������� ������ ��� ������
	mov     ecx, g_Actor	; �������� ������
	.if		ecx != 0
		push    0						; ��������
		push    [ebp+8+key] 			; ��� �������
		push    124             		; ��� �������
		call    CGameObject__callback 	; �������� ������ �������
		mov     ecx, eax 				
		call    script_callback_int_int	; �������� callback
	.endif
	pop 	ebp
	; ������ ��, ��� ��������
	cmp     dword ptr [esi+400ECh], 0
	jmp		back_from__level_input_CallbackKeyRelease
level_input_CallbackKeyRelease endp

; ������ �� ��������� ������
level_input_CallbackKeyHold proc
key				= dword ptr 4
	push 	ebp
	mov 	ebp, esp
	; �������� ������ ��� ������
	mov     ecx, g_Actor	; �������� ������
	.if		ecx != 0
		push    0						; ��������
		push    [ebp+12+key] 			; ��� �������
		push    125             		; ��� �������
		call    CGameObject__callback 	; �������� ������ �������
		mov     ecx, eax 				
		call    script_callback_int_int	; �������� callback
	.endif
	pop 	ebp
	; ������ ��, ��� ��������
	call	CurrentGameUI
	jmp		back_from__level_input_CallbackKeyHold
level_input_CallbackKeyHold endp
