align_proc
cursor_change_sens proc
	mov		edx, g_ui_mouse_sens
	mov		dword ptr [eax+84h], edx
	fld     dword ptr [eax+84h]
	jmp		return_cursor_change_sens
cursor_change_sens endp