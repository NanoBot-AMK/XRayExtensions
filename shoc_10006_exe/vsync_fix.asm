

align_proc
vsync_fix_1 proc
	push	eax
	push	ecx
	push	edx
	mov		ecx, edi
	call	CHW__selectPresentInterval
	mov		dword ptr [edi+0A4h], eax
	pop		edx
	pop		ecx
	pop		eax
	test	ebx, ebx
	jmp	back_from_vsync_fix_1
vsync_fix_1 endp

align_proc
vsync_fix_2 proc
	push	eax
	push	ecx
	push	edx
	mov		ecx, ebx
	call	CHW__selectPresentInterval
	mov		dword ptr [esi+34h], eax
	pop		edx
	pop		ecx
	pop		eax
	cmp		eax, ecx
	jmp	back_from_vsync_fix_2
vsync_fix_2 endp

align_proc
CHW@@setRefrash proc dwWidth:dword, dwHeight:dword, fmt:dword
org		$-3	;зачистим (push ebp/mov ebp,esp) ebp и так указывает на параметры
;esi - this		CHW*
;	mov		ecx, asddsa
	mov		edx, dwRefreshRateDispHz
	.if (edx)
		mov		ebx, eax	; defaul_ref_rate
		mov		ecx, esi
		invoke	CHW@@ValidityRefreshRate, dwWidth, dwHeight, fmt, edx
		.if (eax==0)
			mov		eax, ebx
		.endif
	.endif
	PRINT_UINT "vid_refresh_rate_hz = %dHz", eax
	;return
	pop		edi
	pop		esi
	pop		ebx
	mov		esp, ebp
	pop		ebp
	retn	12
CHW@@setRefrash endp

align_proc
CHW@@ValidityRefreshRate proc uses esi edi ebx dwWidth:dword, dwHeight:dword, fmt:dword, refresh_rate:dword
local Mode:_D3DDISPLAYMODE
;esi - this		CHW*
	mov		esi, ecx
	ASSUME	esi:ptr CHW
	mov		eax, [esi].pD3D
	push	fmt
	push	[esi].DevAdapter
	push	eax
	mov		ecx, [eax]
	mov		edx, [ecx+18h]
	call	edx
	mov		ebx, eax
	.for (edi=0 :edi<ebx: edi++)
		mov		eax, [esi].pD3D
		lea		edx, Mode
		push	edx
		push	edi
		push	fmt
		push	[esi].DevAdapter
		push	eax
		mov		ecx, [eax]
		mov		edx, [ecx+1Ch]
		call	edx
		mov		ecx, dwWidth
		mov		edx, dwHeight
		mov		eax, refresh_rate
		.if (Mode.Width_==ecx && Mode.Height_==edx && Mode.RefreshRate==eax)
			mov		eax, refresh_rate
			ret
		.endif
	.endfor
	xor		eax, eax
	ASSUME	esi:nothing
	ret
CHW@@ValidityRefreshRate endp

