; расширение регистрации CUIStatic
CUIStatic_extention_1:
	xor		eax, eax
	push	eax
	mov		eax, offset CUIStatic__SetTextureRect
	push	eax
	push	offset aSettexturerect ; "SetTextureRect"
; добавляем ещё один метод
	xor		eax, eax
	push	eax
	mov		eax, offset CUIStatic__SetHeading
	push	eax
	push	offset aSetHeading ; "SetHeading"
;----------------------------	
	xor		eax, eax
	push	eax
	mov		eax, offset CUIStatic__SetColor
	push	eax
	push	offset aSetColor ; "SetColor"
; ---------------------------
	jmp		back_to_CUIStatic_ext_1;


CUIStatic_extention_2:
; для CUIStatic__SetColor
	mov		ecx, eax
	call	SetTextureRect_register
; это добавленный для CUIStatic__SetHeading
	mov		ecx, eax
	call	SetTextureRect_register	   ; SetTextureRect_register
; это оригинальный
	mov		ecx, eax
	call	SetTextureRect_register	   ; SetTextureRect
; ---------------------------
	jmp		back_to_CUIStatic_ext_2;
	
aSettexturerect db "SetTextureRect", 0
aSetHeading db "SetHeading", 0
aSetColor	db "SetColor", 0


CUIStatic__SetHeading proc
arg_0			= dword ptr	 4
	mov		eax, dword ptr [esp+arg_0]
	mov		eax, dword ptr [eax]
	mov		byte ptr [ecx+0C8h], 1
	mov		byte ptr [ecx+0C9h], 1
	mov		dword ptr [ecx+0CCh], eax
	retn	4
CUIStatic__SetHeading endp

CUIStatic__SetColor proc
m_UIStaticItem	= dword ptr	 08Ch
dwColor			= dword ptr	 038h
arg_0			= dword ptr	 4
	push	ebx
;----------------------------------
; u32 color = clamp_0_255((int)(_c.x1)) | (clamp_0_255((int)(_c.x2)) << 8) | (clamp_0_255((int)(_c.y1)) << 16) | (clamp_0_255((int)(_c.y1)) << 24)
	mov		eax, [esp+4+arg_0]
	cvttss2si	edx, dword ptr [eax]
	call	clamp_0_255
	mov		ebx, edx
	cvttss2si	edx, dword ptr [eax+4]
	call	clamp_0_255
	shl		edx, 8
	or		ebx, edx
	cvttss2si	edx, dword ptr [eax+8]
	call	clamp_0_255
	shl		edx, 16
	or		ebx, edx
	cvttss2si	edx, dword ptr [eax+12]
	call	clamp_0_255
	shl		edx, 24
	or		ebx, edx							; u32	ebx = color
	mov		[ecx+m_UIStaticItem+dwColor], ebx	; m_UIStaticItem.SetTextureColor(color)
;	PRINT_UINT "color - %x", ebx
;----------------------------------
	pop		ebx
	retn	4
;==========================
	; clamp(param, 0, 255)
clamp_0_255:
	cmp		edx, 0
	jge		lab1
	xor		edx, edx
	jmp		lab2
lab1:
	cmp		edx, 0FFh
	jbe		lab2
	mov		edx, 0FFh
lab2:
;	PRINT_UINT "param - %d", edx
	retn
CUIStatic__SetColor endp
	

