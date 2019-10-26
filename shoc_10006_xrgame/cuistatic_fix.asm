
align_proc
cuistatic_fix proc
	; делаем то, что вырезали
	call	sub_103F1781
	; делаем свое
	PERFORM_EXPORT_CUI_VOID__BOOL			CUIStatic__SetTextComplexMode_,	"SetTextComplexMode"
	PERFORM_EXPORT_CUIWND__VOID__VOID		CUIStatic__AdjustWidthToText_,	"AdjustWidthToText"
	PERFORM_EXPORT_CUIWND__VOID__VOID		CUIStatic__AdjustHeightToText_,	"AdjustHeightToText"
	PERFORM_EXPORT_CUI_VOID__UINT			CUIStatic__SetVTextAlignment_,	"SetVTextAlign"
	PERFORM_EXPORT_CUI_VOID__FLOAT_FLOAT	CUIStatic__SetTextPos_,			"SetTextPos"
	PERFORM_EXPORT_CUI_VOID__BOOL			CUIStatic__CanRotate,			"CanRotate"
	; идём обратно
	jmp		back_from_cuistatic_fix
cuistatic_fix endp
; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
align_proc
CUIStatic__SetTextComplexMode_ proc uses edi mode_on:dword
	push	mode_on		; bool
	mov		edi, ecx	; wnd
	call	CUIStatic__SetTextComplexMode
	ret
CUIStatic__SetTextComplexMode_ endp

align_proc
CUIStatic__AdjustWidthToText_ proc uses esi
	mov		esi, ecx ; wnd
	call	CUIStatic__AdjustWeigthToText
	ret
CUIStatic__AdjustWidthToText_ endp

align_proc
CUIStatic__AdjustHeightToText_ proc uses edi
	mov		edi, ecx ; wnd
	call	CUIStatic__AdjustHeightToText
	ret
CUIStatic__AdjustHeightToText_ endp

align_proc
CUIStatic__SetVTextAlignment_ proc uses edi ebx alignment:dword
	mov		edi, ecx ; wnd
	mov		ebx, alignment
	call	CUIStatic__SetVTextAlignment
	ret
CUIStatic__SetVTextAlignment_ endp

align_proc
CUIStatic__SetTextPos_ proc	 x:dword, y:dword
	push	y
	push	x
	call	CUIStatic__SetTextPos
	ret
CUIStatic__SetTextPos_ endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
align_proc
CUIStatic__CanRotate proc can_rotate:byte
	ASSUME	ecx:ptr CUIStatic
	mov		al, can_rotate
	mov		[ecx].m_bHeading, al
	.if (al)
		or		[ecx].m_lanim_xform.m_lanimFlags, 00010000b
	.else
		and		[ecx].m_lanim_xform.m_lanimFlags, 11101111b
	.endif
	ASSUME	ecx:nothing
	ret
CUIStatic__CanRotate endp

align_proc
CUIStatic__OnFocusRecieve_callback proc
	pusha
	; eax = CUIStatic*
	mov		static_for_callback, eax
	smart_cast	CUICellItem, CUIStatic, eax
	.if (eax)
		mov		eax, [eax].CUICellItem.m_pData		;void*	сюда этот класс помещают CInventoryItem
		.if (eax)
			mov		edi, [eax].CInventoryItem.CInventoryItem@m_object
			.if (edi)
				call	CGameObject__lua_game_object
				.if (eax)
					CALLBACK__GO	g_Actor, 141, eax
				.endif
			.endif
		.endif
	.endif
	mov		static_for_callback, 0
	popa
	;вырезаное
	mov		edx, [ecx+204h]
	jmp		CUIStatic__OnFocusRecieve_callback_back
CUIStatic__OnFocusRecieve_callback endp

align_proc
CUIStatic__OnFocusLost_callback proc
	pusha
	; ecx = CUIStatic*
	mov		static_for_callback, ecx
	smart_cast	CUICellItem, CUIStatic, ecx
	.if (eax)
		mov		eax, [eax].CUICellItem.m_pData
		.if (eax)
			mov		edi, [eax].CInventoryItem.CInventoryItem@m_object
			.if (edi)
				call	CGameObject__lua_game_object
				.if (eax)
					CALLBACK__GO	g_Actor, 142, eax
				.endif
			.endif
		.endif
	.endif
	mov		static_for_callback, 0
	popa
	;вырезаное
	mov		eax, ecx
	mov		ecx, [eax+3Ch]
	jmp		CUIStatic__OnFocusLost_callback_back
CUIStatic__OnFocusLost_callback endp

