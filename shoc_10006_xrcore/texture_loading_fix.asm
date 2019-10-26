
align_proc
texture_load_fix proc
argument           = dword ptr  10h
; сравним строки на предмет присутствия строки "Can't find texture"
	push	edi
	push	ecx
	push	ebx
	xor		ebx, ebx
	mov		eax, static_str$("Can't find texture")	;offset aCantfind
	mov		edi, dword ptr [ebp+argument]
	mov		cl, [edi]
start_compare:
	cmp		cl, 0
	jz		not_texture_fail
	cmp		cl, [eax+ebx]
	jnz		char_not_found
	cmp		ebx, 11h
	jz		is_texture_fail
	mov		cl, [edi+1]
	add		ebx, 1
	add		edi, 1
	jmp		start_compare
char_not_found:
	xor		ebx, ebx
	mov		cl, [edi+1]
	add		edi, 1
	jmp		start_compare
; нужная подстрока есть, обновляем лог, выходим
is_texture_fail:
	pop		ebx
	pop		ecx
	pop		edi
	mov		eax, [ebp+argument]
	PRINT_UINT "! %s", eax
	mov     esp, ebp
	pop     ebp
	retn	20h
	
; вылет не по текстуре, дохнем
not_texture_fail:
	pop		ebx
	pop		ecx
	pop		edi
	; заменяем вырезанное
	mov     eax, 1004h
	jmp		return_texture_load_fix
texture_load_fix endp

