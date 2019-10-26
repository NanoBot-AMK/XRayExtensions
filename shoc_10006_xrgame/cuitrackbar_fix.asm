
align_proc
CUITrackBar_fix proc
	call	register__CUITrackBar__GetCheck
	PERFORM_EXPORT_CUIWND__FLOAT__VOID	CUITrackBar__GetTestValue,		"GetFValue"
;	PERFORM_EXPORT_CUI__BOOL__VOID		CUITrackBar__IsFloat,			"IsFloat"
	PERFORM_EXPORT_CUI__BOOL__VOID		CUITrackBar__IsChanged_wrapper,	"IsChanged"
	
	jmp		return_CUITrackBar_fix
CUITrackBar_fix endp

align_proc
CUITrackBar__GetTestValue proc
	fld		dword ptr [ecx+140]
	retn
CUITrackBar__GetTestValue endp

;align_proc
;CUITrackBar__IsFloat proc
;	add ecx, (140 - 48)
	;mov eax, dword ptr [ecx+092]
	;PRINT_UINT "092: %0x", eax
	;mov eax, dword ptr [ecx+096]
	;PRINT_UINT "096: %0x", eax
	;mov eax, dword ptr [ecx+100]
	;PRINT_UINT "100: %0x", eax
	;mov eax, dword ptr [ecx+104]
	;PRINT_UINT "104: %0x", eax
	;mov eax, dword ptr [ecx+108]
	;PRINT_UINT "108: %0x", eax
	;mov eax, dword ptr [ecx+112]
	;PRINT_UINT "112: %0x", eax
	;mov eax, dword ptr [ecx+116]
	;PRINT_UINT "116: %0x", eax
	;mov eax, dword ptr [ecx+120]
	;PRINT_UINT "120: %0x", eax
	;mov eax, dword ptr [ecx+124]
	;PRINT_UINT "124: %0x", eax
	;mov eax, dword ptr [ecx+128]
	;PRINT_UINT "128: %0x", eax
	;mov eax, dword ptr [ecx+132]
	;PRINT_UINT "132: %0x", eax
	;mov eax, dword ptr [ecx+136]
	;PRINT_UINT "136: %0x", eax
;	xor		eax, eax
;	mov		ah, [ecx+45]
;	retn
;CUITrackBar__IsFloat endp

align_proc
CUITrackBar__IsChanged_wrapper proc
	add		ecx, (140 - 48)
	jmp		CUITrackBar__IsChanged
CUITrackBar__IsChanged_wrapper endp

align_proc
CUIOptionsItem__SaveOptFloatValue_fix proc
	.if (byte ptr [eax])
		fld		real4 ptr [esp+200h+4]	;value
		jmp		return_CUIOptionsItem__SaveOptFloatValue_fix
	.endif
	add		esp, 200h
	retn	4
CUIOptionsItem__SaveOptFloatValue_fix endp
