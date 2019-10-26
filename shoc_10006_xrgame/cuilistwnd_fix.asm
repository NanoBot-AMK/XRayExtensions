
align_proc
CUIListWnd__script_register_fix PROC
	;вырезанное
	call	sub_104207F6
	pop		ecx
	;------------------------------
	push	0
	push	offset CUIListWnd__SetSelectedItem
	push	const_static_str$("SetSelectedItem")
	push	eax
	call	sub_104207F6
	
	jmp		return_CUIListWnd__script_register_fix
CUIListWnd__script_register_fix ENDP

align_proc
CUIListWnd__SetSelectedItem proc selected_item:dword
;ecx	this	CUIListWnd*
	mrm		[ecx].CUIListWnd.m_iSelectedItem, selected_item
	ret
CUIListWnd__SetSelectedItem endp
