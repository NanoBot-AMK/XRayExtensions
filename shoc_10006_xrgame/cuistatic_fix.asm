cuistatic_fix:
	; ������ ��, ��� ��������
	call    sub_103F1781
	; ������ ����
	PERFORM_EXPORT_CUI_VOID__BOOL CUIStatic__SetTextComplexMode_, "SetTextComplexMode"
	PERFORM_EXPORT_CUIWND__VOID__VOID CUIStatic__AdjustWidthToText_, "AdjustWidthToText"
	PERFORM_EXPORT_CUIWND__VOID__VOID CUIStatic__AdjustHeightToText_, "AdjustHeightToText"
	PERFORM_EXPORT_CUI_VOID__UINT CUIStatic__SetVTextAlignment_, "SetVTextAlign"
	PERFORM_EXPORT_CUI_VOID__FLOAT_FLOAT CUIStatic__SetTextPos_, "SetTextPos"
	PERFORM_EXPORT_CUI_VOID__BOOL CUIStatic__CanRotate, "CanRotate"
	; ��� �������
	jmp     back_from_cuistatic_fix

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
CUIStatic__SetTextComplexMode_ proc
mode_on = dword ptr  8
	push    edi
	push    [esp+mode_on] ; bool
	mov     edi, ecx ; wnd
	call	CUIStatic__SetTextComplexMode
	pop		edi
	retn    4
CUIStatic__SetTextComplexMode_ endp

CUIStatic__AdjustWidthToText_ proc
	push    esi
	mov     esi, ecx ; wnd
	call	CUIStatic__AdjustWeigthToText
	pop		esi
	retn
CUIStatic__AdjustWidthToText_ endp

CUIStatic__AdjustHeightToText_ proc
	push    edi
	mov     edi, ecx ; wnd
	call	CUIStatic__AdjustHeightToText
	pop		edi
	retn
CUIStatic__AdjustHeightToText_ endp

CUIStatic__SetVTextAlignment_ proc
alignment = dword ptr  8
	push    edi
	mov     edi, ecx ; wnd
	mov     ebx, [esp+alignment] ; align
	call	CUIStatic__SetVTextAlignment
	pop		edi
	retn	4
CUIStatic__SetVTextAlignment_ endp

CUIStatic__SetTextPos_ proc
x = dword ptr  4
y = dword ptr  8
	mov     eax, [esp+y]
	push    eax
	mov     eax, [esp+4+x]
	push    eax
	call	CUIStatic__SetTextPos
	retn	8
CUIStatic__SetTextPos_ endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================

CUIStatic__CanRotate proc
can_rotate = dword ptr  4
	mov     eax, [esp+can_rotate]
	setnz   al
	test    al, al
	mov     [ecx+11Ch], al
	jz      lab1
	or      byte ptr [ecx+8Ch], 10h
	jmp     lab2
lab1:
	and     byte ptr [ecx+8Ch], 0EFh
lab2:
	retn    4
CUIStatic__CanRotate endp

CUIStatic__OnFocusRecieve_callback proc
	pusha
	; eax = CUIStatic*
	mov		static_for_callback, eax
	RT_DYNAMIC_CAST ??_R0?AVCUIStatic@@@8, ??_R0?AVCUICellItem@@@8, eax
	test	eax, eax
	jz		short exit
	
	mov		eax, [eax+17Ch]
	test	eax, eax
	jz		short exit
	
	mov		edi, [eax+0D4h]
	test	edi, edi
	jz		short exit
	
	call	CGameObject__lua_game_object
	test	eax, eax
	jz		short exit
	
	push 	eax
	push 	141

	mov 	ecx, g_Actor
	call    CGameObject__callback
	push    eax
	call    script_use_callback	
exit:
	mov		static_for_callback, 0
	popa
	
	mov     edx, [ecx+204h]
	jmp		CUIStatic__OnFocusRecieve_callback_back
CUIStatic__OnFocusRecieve_callback endp

CUIStatic__OnFocusLost_callback proc
	pusha
	; eax = CUIStatic*
	mov		static_for_callback, ecx
	RT_DYNAMIC_CAST ??_R0?AVCUIStatic@@@8, ??_R0?AVCUICellItem@@@8, ecx
	test	eax, eax
	jz		short exit
	
	mov		eax, [eax+17Ch]
	test	eax, eax
	jz		short exit
	
	mov		edi, [eax+0D4h]
	test	edi, edi
	jz		short exit
	
	call	CGameObject__lua_game_object
	test	eax, eax
	jz		short exit
	
	push 	eax
	push 	142

	mov 	ecx, g_Actor
	call    CGameObject__callback
	push    eax
	call    script_use_callback	
exit:
	mov		static_for_callback, 0
	popa
	
	mov     eax, ecx
	mov     ecx, [eax+3Ch]
	jmp		CUIStatic__OnFocusLost_callback_back
CUIStatic__OnFocusLost_callback endp

CUICustomItem__Render_fix proc
	call    ui_core__is_16_9_mode
	test    al, al

	jz      lab1
	movss   xmm1, ds:g_static_rescale_correction
	jmp     back_from_CUICustomItem__Render_fix
lab1:
	movss   xmm1, ds:float_10459718__1_0
	jmp     back_from_CUICustomItem__Render_fix
CUICustomItem__Render_fix endp
