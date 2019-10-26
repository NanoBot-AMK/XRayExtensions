;============================================================================================
; Колбеки на нажатие клавишь.
; Вызывается в биндер актора.
; Так же эти колбеки вызываются в биндере активной вещи, и холдера.
; Это надо для скриптового оружия и для стрельбы из техники с оружием(БТР, турели, вертолёт?).
;
; Рефакторинг (с) НаноБот		3.08.2017	27.09.2018
;============================================================================================

DIK_LMENU			equ 56
DIK_RMENU			equ 184
DIK_F4				equ 62
DIK_1				equ 2
DIK_2				equ 3
DIK_3				equ 4
DIK_4				equ 5
DIK_5				equ 6
DIK_6				equ 7
DIK_7				equ 8
DIK_8				equ 9
DIK_9				equ 10
DIK_0				equ 11

eOnKeyPress							= dword ptr 123
eOnKeyRelease				 		= dword ptr 124
eOnKeyHold					 		= dword ptr 125
eOnMouseWheel				 		= dword ptr 126
eOnMouseMove					 	= dword ptr 127

eCallbackKeyPress					equ 00000001b
eCallbackKeyRelease				 	equ 00000010b
eCallbackKeyHold					equ 00000100b
eCallbackMouseWheel				 	equ 00001000b
eCallbackMouseMove					equ 00010000b
eCallbackShoot						equ 00100000b
eCallbackAllHit						equ 01000000b
;						equ 10000000b

; ----------------------- колбек на нажатие ----------------------------
align_proc
CLevel__IR_OnKeyboardPress_callback proc uses ebx edi esi key:dword
; ebx - CLevel
	mov		ebx, ecx
	mov		edi, key
	mov		esi, g_Actor
	ASSUME	esi:ptr CActor
	.if (esi && !g_bDisableAllInput && edi!=DIK_LMENU && edi!=DIK_RMENU && edi!=DIK_F4)	; игнорируем клавиши alt и F4
		.if (extensions_flags & eCallbackKeyPress)
			; вызываем колбек для актора
			CALLBACK__INT_INT  esi, eOnKeyPress, edi, 0
		.endif
		; блокировка цифр на основной клавиатуре
		.if (g_bDisableNumBaseInput && edi>=DIK_1 && edi<=DIK_0)
			ret
		.endif
		; колбеки в биндер активных вещей: оружия которое держим в руках, холдер в котором сидим.
		; определим активное оружие
		; stalker->inventory().ActiveItem()
		mov		ecx, esi
		mov		eax, [ecx]
		mov		edx, [eax+70h]
		call	edx			; stalker->inventory()
		ASSUME	edx:ptr CGameObject
		.if (eax)
			mov		ecx, [eax+24h]
			mov		eax, [ecx+48h]
			.if (eax!=-1)	; slot
				shl		eax, 4
				add		eax, [ecx+38h]
				mov		eax, [eax+4]
				mov		edx, [eax+0D4h]		; CGameObject*
				.if ([edx].m_flCallbackKey & eCallbackKeyPress)
					CALLBACK__INT_INT  edx, eOnKeyPress, edi, 0
				.endif
			.endif
		.endif
		; холдер
		mov		eax, [esi].m_holder
		.if	(eax)
			smart_cast	CGameObject, CHolderCustom, eax
			mov		edx, eax
			.if ([edx].m_flCallbackKey & eCallbackKeyPress)
				CALLBACK__INT_INT  edx, eOnKeyPress, edi, 0
			.endif
		.endif
		ASSUME	edx:nothing
	.endif
	ASSUME	esi:nothing
	; CLevel::IR_OnKeyboardPress(key);
	mov		ecx, ebx
	pop		esi
	pop		edi
	pop		ebx
	leave
	jmp		CLevel__IR_OnKeyboardPress
CLevel__IR_OnKeyboardPress_callback endp

; ----------------- колбек на отпускание --------------------
align_proc
CLevel__IR_OnKeyboardRelease_callback proc uses ebx edi esi key:dword
; ebx - CLevel
	mov		ebx, ecx
	mov		edi, key
	mov		esi, g_Actor
	ASSUME	esi:ptr CActor
	.if (esi && !g_bDisableAllInput && edi!=DIK_LMENU && edi!=DIK_RMENU && edi!=DIK_F4)	; игнорируем клавиши alt и F4
		.if (extensions_flags & eCallbackKeyRelease)
			; вызываем колбек для актора
			CALLBACK__INT_INT  esi, eOnKeyRelease, edi, 0
		.endif
		; блокировка цифр на основной клавиатуре
		.if (g_bDisableNumBaseInput && edi>=DIK_1 && edi<=DIK_0)
			ret
		.endif
		; колбеки в биндер активных вещей: оружия которое держим в руках, холдер в котором сидим.
		; определим активное оружие
		; stalker->inventory().ActiveItem()
		mov		ecx, esi
		mov		eax, [ecx]
		mov		edx, [eax+70h]
		call	edx			; stalker->inventory()
		ASSUME	edx:ptr CGameObject
		.if (eax)
			mov		ecx, [eax+24h]
			mov		eax, [ecx+48h]
			.if (eax!=-1)
				shl		eax, 4
				add		eax, [ecx+38h]
				mov		eax, [eax+4]
				mov		edx, [eax+0D4h]		; CGameObject*
				.if ([edx].m_flCallbackKey & eCallbackKeyRelease)
					CALLBACK__INT_INT  edx, eOnKeyRelease, edi, 0
				.endif
			.endif
		.endif
		; холдер
		mov		eax, [esi].m_holder
		.if	(eax)
			smart_cast	CGameObject, CHolderCustom, eax
			mov		edx, eax
			.if ([edx].m_flCallbackKey & eCallbackKeyRelease)
				CALLBACK__INT_INT  edx, eOnKeyRelease, edi, 0
			.endif
		.endif
		ASSUME	edx:nothing
	.endif
	ASSUME	esi:nothing
	; CLevel::IR_OnKeyboardRelease(key);
	mov		ecx, ebx
	pop		esi
	pop		edi
	pop		ebx
	leave
	jmp		CLevel__IR_OnKeyboardRelease
CLevel__IR_OnKeyboardRelease_callback endp

; ----------------- колбек на удержание --------------------
align_proc
CLevel__IR_OnKeyboardHold_callback proc uses ebx edi esi key:dword
; ebx - CLevel
	mov		ebx, ecx
	mov		edi, key
	mov		esi, g_Actor
	ASSUME	esi:ptr CActor
	.if (esi && !g_bDisableAllInput && edi!=DIK_LMENU && edi!=DIK_RMENU && edi!=DIK_F4)	; игнорируем клавиши alt и F4
		.if (extensions_flags & eCallbackKeyHold)
			; вызываем колбек для актора
			CALLBACK__INT_INT  esi, eOnKeyHold, edi, 0
		.endif
		; блокировка цифр на основной клавиатуре
		.if (g_bDisableNumBaseInput && edi>=DIK_1 && edi<=DIK_0)
			ret
		.endif
		; колбеки в биндер активных вещей: оружия которое держим в руках, холдер в котором сидим.
		; определим активное оружие
		; stalker->inventory().ActiveItem()
		mov		ecx, esi
		mov		eax, [ecx]
		mov		edx, [eax+70h]
		call	edx			; stalker->inventory()
		ASSUME	edx:ptr CGameObject
		.if (eax)
			mov		ecx, [eax+24h]
			mov		eax, [ecx+48h]
			.if (eax!=-1)
				shl		eax, 4
				add		eax, [ecx+38h]
				mov		eax, [eax+4]
				mov		edx, [eax+0D4h]		; CGameObject*
				.if ([edx].m_flCallbackKey & eCallbackKeyHold)
					CALLBACK__INT_INT  edx, eOnKeyHold, edi, 0
				.endif
			.endif
		.endif
		; холдер
		mov		eax, [esi].m_holder
		.if	(eax)
			smart_cast	CGameObject, CHolderCustom, eax
			mov		edx, eax
			.if ([edx].m_flCallbackKey & eCallbackKeyHold)
				CALLBACK__INT_INT  edx, eOnKeyHold, edi, 0
			.endif
		.endif
		ASSUME	edx:nothing
	.endif
	ASSUME	esi:nothing
	; CLevel::IR_OnKeyboardHold(key);
	mov		ecx, ebx
	pop		esi
	pop		edi
	pop		ebx
	leave
	jmp		CLevel__IR_OnKeyboardHold
CLevel__IR_OnKeyboardHold_callback endp

; ----------------- колбек на кручение колеса --------------------
align_proc
CLevel__IR_OnMouseWheel_callback proc direction:dword
; ebx - CLevel
	push	ebx
	push	esi
	mov		ebx, ecx
	mov		esi, g_Actor
	ASSUME	esi:ptr CActor
	.if (esi && !g_bDisableAllInput)
		.if (extensions_flags & eCallbackMouseWheel)
			mov		edx, direction
			add		edx, 100000
			CALLBACK__INT_INT  esi, eOnMouseWheel, edx, 0
		.endif
		; колбеки в биндер активных вещей: оружия которое держим в руках, холдер в котором сидим.
		; определим активное оружие
		; stalker->inventory().ActiveItem()
		mov		ecx, esi
		mov		eax, [ecx]
		mov		edx, [eax+70h]
		call	edx			; stalker->inventory()
		ASSUME	edx:ptr CGameObject
		.if (eax)
			mov		ecx, [eax+24h]
			mov		eax, [ecx+48h]
			.if (eax!=-1)
				shl		eax, 4
				add		eax, [ecx+38h]
				mov		eax, [eax+4]
				mov		edx, [eax+0D4h]		; CGameObject*
				.if ([edx].m_flCallbackKey & eCallbackMouseWheel)
					CALLBACK__INT_INT  edx, eOnMouseWheel, direction, 0
				.endif
			.endif
		.endif
		; холдер
		mov		eax, [esi].m_holder
		.if	(eax)
			smart_cast	CGameObject, CHolderCustom, eax
			mov		edx, eax
			.if ([edx].m_flCallbackKey & eCallbackMouseWheel)
				CALLBACK__INT_INT  edx, eOnMouseWheel, direction, 0
			.endif
		.endif
		ASSUME	edx:nothing
	.endif
	ASSUME	esi:nothing
	;CLevel::IR_OnMouseWheel(direction);
	mov		ecx, ebx
	pop		esi
	pop		ebx
	leave
	jmp		CLevel__IR_OnMouseWheel
CLevel__IR_OnMouseWheel_callback endp
	
; ----------------- колбек на движение мыши --------------------
; колбек на движения мыши для биндеров я думаю делать не целесообразно. НаноБот
align_proc
CLevel__IR_OnMouseMove_callback proc _dx:dword, _dy:dword
	.if (!g_bDisableAllInput && extensions_flags & eCallbackMouseMove)
		push	ecx
		mov		edx, _dx 
		mov		eax, _dy
		add		edx, 100000 ; dx 
		add		eax, 100000 ; dy
		CALLBACK__INT_INT  g_Actor, eOnMouseMove, edx, eax
		pop		ecx
	.endif
	;CLevel::IR_OnMouseMove(_dx, _dy);
	leave
	jmp		CLevel__IR_OnMouseMove
CLevel__IR_OnMouseMove_callback endp
