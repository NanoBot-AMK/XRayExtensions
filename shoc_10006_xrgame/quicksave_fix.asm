
;align_proc
;quicksave_fix proc
;	mov		ecx, ds:Console
;	mov		ecx, [ecx]
;	mov		eax, const_static_str$("main_menu on")
;	push	eax
;	call	ds:CConsole__Execute
;	mov		ecx, ds:Console
;	mov		ecx, [ecx]
;	mov		eax, const_static_str$("save")
;	push	eax
;	call	ds:CConsole__Execute
;	pop     edi
;	pop     esi
;	pop     ebp
;	pop     ebx
;	add     esp, 414h
;	mov     [esp+4], const_static_str$("main_menu off")
;	mov     eax, ds:Console
;	mov     ecx, [eax]
;	jmp     ds:CConsole__Execute
;quicksave_fix endp
