
align_proc
CUICustomEdit_fix proc
	;PERFORM_EXPORT_CUIWND__FLOAT__VOID CUICustomEdit__GetTestValue, "get_test_value"
	mov		ecx, eax
	xor		eax, eax
	lea		edi, [ebp-0Ch]
	jmp		back_from_CUICustomEdit_fix
CUICustomEdit_fix endp

;CUICustomEdit__GetTestValue proc
;	fldpi
;	ret
;CUICustomEdit__GetTestValue endp

static_int			g_input_language, 0		; 0 - eng, 1 - rus
const_static_byte	g_rus_char_map, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, "йцукенгшщзхъ", 0,0, "фывапролджэ", 0,0,0, "ячсмитьбю"

align_proc
CUICustomEdit__KeyPressed_fix proc
	.if (g_input_language && eax <= 52)
		movzx	ecx, g_rus_char_map[eax]
		.if (ecx)
			pop		edi
			jmp		letter_inserting
		.endif
	.endif
	call	xr_map?u32@char?@@find
	mov		eax, [eax]
	cmp		dword_10560904, eax
	pop		edi
	jz		loc_103F4B42
	movzx	ecx, byte ptr [eax+10h]
letter_inserting:
	push	ecx
	mov		ecx, ebp
	jmp		return_CUICustomEdit__KeyPressed_fix
CUICustomEdit__KeyPressed_fix endp

;		? esc 1 2 3 4 5 6 7 8 9 0 - = bk tb "qwertyuiop[]" ret lc "asdfghjkl;'" gr ls bs "zxcvbnm,." last - 52
align_proc
CUICustomEdit__KeyPressed_fix_1 proc ; обработка нажатия 'хХ'
	.if (g_input_language)	; case 14
		TERNARY	bl, 'Х', 'х'
	.else
		TERNARY	bl, '{', '['
	.endif
	jmp		return_CUICustomEdit__KeyPressed_fix_1
CUICustomEdit__KeyPressed_fix_1 endp

align_proc
CUICustomEdit__KeyPressed_fix_2 proc ; 'ъЪ'
	.if (g_input_language)	; case 15
		TERNARY	bl, 'Ъ', 'ъ'
	.else
		TERNARY	bl, '}', ']'
	.endif
	jmp		return_CUICustomEdit__KeyPressed_fix_2
CUICustomEdit__KeyPressed_fix_2 endp

align_proc
CUICustomEdit__KeyPressed_fix_3 proc ; 'жЖ'
	.if (g_input_language)	; case 27
		TERNARY	bl, 'Ж', 'ж'
	.else
		TERNARY	bl, ':', ';'
	.endif
	jmp		return_CUICustomEdit__KeyPressed_fix_3
CUICustomEdit__KeyPressed_fix_3 endp

align_proc
CUICustomEdit__KeyPressed_fix_4 proc ; 'эЭ'
	.if (g_input_language)	; case 28
		TERNARY	bl, 'Э', 'э'
	.else
		TERNARY	bl, '"', "'"
	.endif
	jmp		return_CUICustomEdit__KeyPressed_fix_4
CUICustomEdit__KeyPressed_fix_4 endp

align_proc
CUICustomEdit__KeyPressed_fix_5 proc ; 'бБ'
	.if (g_input_language)	; case 39
		TERNARY	bl, 'Б', 'б'
	.else
		TERNARY	bl, ',', '<'
	.endif
	jmp		return_CUICustomEdit__KeyPressed_fix_5
CUICustomEdit__KeyPressed_fix_5 endp

align_proc
CUICustomEdit__KeyPressed_fix_6 proc ; 'юЮ'
	.if (g_input_language)	; case 40
		TERNARY	bl, 'Ю', 'ю'
	.else
		TERNARY	bl, '>', '.'
	.endif
	jmp		return_CUICustomEdit__KeyPressed_fix_6
CUICustomEdit__KeyPressed_fix_6 endp

align_proc
CUICustomEdit__KeyPressed_fix_7 proc ; '.,'
	.if (g_input_language)	; case 41
		TERNARY	bl, ',', '.'
	.else
		TERNARY	bl, '?', '/'
	.endif
	jmp		return_CUICustomEdit__KeyPressed_fix_7
CUICustomEdit__KeyPressed_fix_7 endp
