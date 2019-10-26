PERFORM_EXPORT_CUI__VOID__STRING MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ecx, eax
	push	0
	push	offset fun_to_export						; sub
	push	const_static_str$(fun_name_str)
	push	ecx										 	; sub name
	call	register_CUI_void__string
ENDM

PERFORM_EXPORT_CUI__STRING__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ecx, eax
	push	0
	push	offset fun_to_export						; sub
	push	const_static_str$(fun_name_str)
	push	ecx											; sub name
	call	register__UI__string__void
ENDM

align_proc
CUIComboBox_fix proc
	call	sub_1040F216
	;-------------------------------
	PERFORM_EXPORT_CUI__VOID__STRING	CUIComboBox@@AddItem,	"AddItem"
	PERFORM_EXPORT_CUI__STRING__VOID	CUIComboBox@@GetText,	"GetText"
	
	jmp		return_CUIComboBox_fix
CUIComboBox_fix endp

align_proc
CUIComboBox@@AddItem proc uses esi text:ptr byte
	mov		esi, ecx
	CUIComboBox@@AddItem_(text, 012345678h)
	ret
CUIComboBox@@AddItem endp

align_proc
CUIComboBox@@GetText proc
	add		ecx, 420h
	mov		eax, [ecx]
	mov		edx, [eax+20h]
	jmp		edx
CUIComboBox@@GetText endp

align_proc
CUIComboBox__SaveValue_fix proc
	.if (dword ptr[ecx+40] == 012345678h)
		retn
	.endif
	;PRINT "continue normal"
	push	esi
	push	edi
	mov		edi, ecx
	call	CUIOptionsItem__SaveValue
	;
	jmp		back_from_CUIComboBox__SaveValue_fix
CUIComboBox__SaveValue_fix endp
