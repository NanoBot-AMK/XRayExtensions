
align_proc
to_logo proc
	mov		ecx, [edx+148h]
	call	ecx
	jmp		logo_rendering
to_logo endp

align_proc
to_text proc
	mov		eax, [ecx+148h]
	call	eax
	jmp		text_rendering
to_text endp

align_proc
to_end proc
	mov		edx, [edx]
	mov		eax, [edx]
	call	eax
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn
to_end endp

