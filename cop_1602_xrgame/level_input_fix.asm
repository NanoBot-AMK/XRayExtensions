
; колбек на нажатие клавиш
level_input_CallbackKeyPress proc
	push 	ebp
	mov 	ebp, esp
; добавляем своё
	push 	eax
	push 	ebx
	push 	ecx
	push 	edx
	push 	edi
	push 	esi
	; вызываем колбек для актора
	mov     ecx, g_Actor	; получаем актора
	.if		ecx != 0
		push    0						; заглушка
		push    [ebp+8] 				; код клавиши
		push    123             		; тип колбека
		call    CGameObject__callback 	; получаем объект колбека
		mov     ecx, eax 				
		call    script_callback_int_int	; вызываем callback
	.endif
	;-------------
	pop 	esi
	pop 	edi
	pop 	edx
	pop 	ecx
	pop 	ebx
	pop 	eax
	
	pop 	ebp
; делаем то, что вырезали
	sub     esp, 410h
; идём обратно
	jmp 	back_from_level_input_CallbackKeyPress
level_input_CallbackKeyPress endp

; колбек на удержание клавиш
level_input_CallbackKeyRelease proc
key				= dword ptr 4
	push 	ebp
	mov 	ebp, esp
	; вызываем колбек для актора
	mov     ecx, g_Actor	; получаем актора
	.if		ecx != 0
		push    0						; заглушка
		push    [ebp+8+key] 			; код клавиши
		push    124             		; тип колбека
		call    CGameObject__callback 	; получаем объект колбека
		mov     ecx, eax 				
		call    script_callback_int_int	; вызываем callback
	.endif
	pop 	ebp
	; делаем то, что вырезали
	cmp     dword ptr [esi+400ECh], 0
	jmp		back_from__level_input_CallbackKeyRelease
level_input_CallbackKeyRelease endp

; колбек на опускание клавиш
level_input_CallbackKeyHold proc
key				= dword ptr 4
	push 	ebp
	mov 	ebp, esp
	; вызываем колбек для актора
	mov     ecx, g_Actor	; получаем актора
	.if		ecx != 0
		push    0						; заглушка
		push    [ebp+12+key] 			; код клавиши
		push    125             		; тип колбека
		call    CGameObject__callback 	; получаем объект колбека
		mov     ecx, eax 				
		call    script_callback_int_int	; вызываем callback
	.endif
	pop 	ebp
	; делаем то, что вырезали
	call	CurrentGameUI
	jmp		back_from__level_input_CallbackKeyHold
level_input_CallbackKeyHold endp
