include cuiwindow_reg_macro.asm

align_proc
cuiwindow_fix proc
	; делаем то, что вырезали 
	push	ecx
	mov		ecx, esp
	push	eax
	call	edi
	PERFORM_EXPORT_CUIWND__VOID__VOID		CUIWindow@@DetachFromParent,		"DetachFromParent"
	PERFORM_EXPORT_CUIWND__VOID__VOID		CUIWindow@@BringToTop,				"BringToTop"
	PERFORM_EXPORT_CUIWND__VOID__VOID		CUIWindow@@Update_virtualcall,		"Update"
	PERFORM_EXPORT_CUIWND__FLOAT__VOID		CUIWindow@@GetVPos,					"GetVPos"
	PERFORM_EXPORT_CUIWND__FLOAT__VOID		CUIWindow@@GetHPos,					"GetHPos"
	PERFORM_EXPORT_CUIWND__FLOAT__VOID		CUIWindow@@GetCursorX,				"GetCursorX"
	PERFORM_EXPORT_CUIWND__FLOAT__VOID		CUIWindow@@GetCursorY,				"GetCursorY"
	PERFORM_EXPORT_CUIWND__FLOAT__VOID		CUIWindow@@GetAbsolutePosX,			"GetAbsolutePosX"
	PERFORM_EXPORT_CUIWND__FLOAT__VOID		CUIWindow@@GetAbsolutePosY,			"GetAbsolutePosY"
	
	jmp		return_cuiwindow_fix
cuiwindow_fix endp

align_proc
CUIWindow@@DetachFromParent proc
	ASSUME	ecx:ptr CUIWindow
	mov		eax, [ecx].m_pParentWnd
	.if (eax)
		push	ecx
		mov		ecx, eax
		mov		edx, [eax]
		mov		eax, [edx+38h]
		call	eax
	.endif
	ret
CUIWindow@@DetachFromParent endp

align_proc
CUIWindow@@BringToTop proc
	mov		eax, [ecx].m_pParentWnd
	.if (eax)
		; eax == this == parent windows
		push	ecx ; аргумент в стеке - окно, которое понимаем наверх
		call	CUIWindow@@BringToTop_
	.endif
	ret
CUIWindow@@BringToTop endp

static_int		g_counter_just_for_show, 0

align_proc
scroll_vew_fix proc
	PRINT_UINT "cntr=%d", g_counter_just_for_show
	inc		g_counter_just_for_show
	; делаем то, что вырезали 
	push	ecx
	push	esi
	push	edi
	mov		edi, ecx
	; идём обратно
	jmp		back_from_scroll_vew_fix
scroll_vew_fix endp

align_proc
CUIWindow@@Update_virtualcall proc 
	mov		eax, [ecx]
	jmp		dword ptr [eax+10h]
CUIWindow@@Update_virtualcall endp

align_proc
CUIWindow@@GetHPos proc
	fld		[ecx].m_wndPos.x
	ret
CUIWindow@@GetHPos endp

align_proc
CUIWindow@@GetVPos proc
	fld		[ecx].m_wndPos.y
	ret
CUIWindow@@GetVPos endp
; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
align_proc
CUIWindow@@GetCursorX proc
	fld		[ecx].cursor_pos.x
	ret
CUIWindow@@GetCursorX endp

align_proc
CUIWindow@@GetCursorY proc
	fld		[ecx].cursor_pos.y
	ret
CUIWindow@@GetCursorY endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
align_proc
CUIWindow@@GetAbsolutePosX proc
	fldz
	.repeat
		fadd	[ecx].m_wndPos.x
		mov		ecx, [ecx].m_pParentWnd
	.until (ecx==NULL)
	ret
CUIWindow@@GetAbsolutePosX endp

align_proc
CUIWindow@@GetAbsolutePosY proc
	fldz
	.repeat
		fadd	[ecx].m_wndPos.y
		mov		ecx, [ecx].m_pParentWnd
	.until (ecx==NULL)
	ASSUME	ecx:nothing
	ret
CUIWindow@@GetAbsolutePosY endp
