
align_proc
CUIMainIngameWnd__UpdatePickUpItem_EXT_CHUNK proc
;xmm0	float
	push	eax
	push	ecx
	call	ui_core@@is_16_9_mode	;//регистры xmm не измен€ютс€!
	.if (al)
		mulss	xmm0, FP4(0.75)	; 0.75 for 16:9 mode
	.endif
	pop		ecx
	pop		eax
	movss	real4 ptr [esp], xmm0	;на верхушку стека
	jmp		return_CUIMainIngameWnd__UpdatePickUpItem_EXT_CHUNK
CUIMainIngameWnd__UpdatePickUpItem_EXT_CHUNK endp

align_proc
CUIMainIngameWnd__SetAmmoIcon_EXT_CHUNK proc
var_4		= dword ptr -4h
var_14		= dword ptr -14h
; UIWeaponIcon.SetWidth(w)
	call	ui_core@@is_16_9_mode
	.if (al)
		movss	xmm0, FP4(0.83325)	;scaled_width 0.83325 = 1.111 * 0.75 (for 16:9), 1.111 == 50/45
		mulss	xmm0, [esp+10h+var_4]
		movss	dword ptr [esp+10h+var_4], xmm0
		mov		edx, [edi]
		fld		[esp+10h+var_4]
		mov		eax, [edx+28h]
		push	ecx
		mov		ecx, edi
		fstp	[esp+14h+var_14]
		call	eax
		fld		FP4(50.0)		; scaled height
		mov		edx, [edi]
		mov		eax, [edx+24h]
		push	ecx
		mov		ecx, edi
		fstp	[esp+14h+var_14]
		call	eax
		pop		edi
		add		esp, 0Ch
		retn
	.endif
	mov		edx, [edi]
	fld		[esp+10h+var_4]
	mov		eax, [edx+28h]
	push	ecx
	mov		ecx, edi
	fstp	[esp+14h+var_14]
	call	eax
	fld		FP4(45.0)			; original height
	mov		edx, [edi]
	mov		eax, [edx+24h]
	push	ecx
	mov		ecx, edi
	fstp	[esp+14h+var_14]
	call	eax
	pop		edi
	add		esp, 0Ch
	retn
CUIMainIngameWnd__SetAmmoIcon_EXT_CHUNK endp
