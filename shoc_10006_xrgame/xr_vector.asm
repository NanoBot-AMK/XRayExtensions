
align_proc
xr_vector__push_back proc uses edi ebx sizeof_class:dword, begin_size:dword
local new_vector:xr_vector
;ecx	this	xr_vector*
	mov		edi, ecx
	ASSUME	edi:ptr xr_vector
	.if ([edi]._Myfirst==NULL)
		mov		ebx, sizeof_class
		imul	ebx, begin_size
		xr_memory	ebx
		mov		[edi]._Myfirst, eax
		mov		[edi]._Mylast, eax
		lea		edx, [eax+ebx]
		mov		[edi]._Myend, edx
	.else
		mov		eax, [edi]._Mylast
		mov		ebx, [edi]._Myend
		.if (ebx==eax)		;вектор переполнен
			;создаём новый вектор
			sub		ebx, [edi]._Myfirst	;old_size = _Myend - _Myfirst;
			xr_memory	&[ebx+ebx]		;новый_размер = старый_размер*2
			and		new_vector._Alval, 0
			mov		new_vector._Myfirst, eax
			lea		edx, [eax+ebx]
			mov		new_vector._Mylast, edx
			lea		ecx, [edx+ebx]
			mov		new_vector._Myend, ecx
			;копируем в новый вектор, данные из старого
			mov		edx, eax
			mov		ecx, [edi]._Myfirst
			.while (ebx)
				mov		al, [ecx]
				mov		[edx], al
				dec		ebx
				inc		ecx
				inc		edx
			.endw
			;удаляем данные старого вектора.
			xr_mem_free	[edi]._Myfirst
			;вектор обновлён
			movups	xmm0, new_vector
			movups	[edi], xmm0
			mov		eax, [edi]._Mylast
		.endif
	.endif
	mov		edx, sizeof_class
	add		[edi]._Mylast, edx
	ASSUME	edi:nothing
	ret
xr_vector__push_back endp

xr_vector@@push_back MACRO this_:req, sizeof_class:req, begin_size:=<256>
	@push2mem	(begin_size)
	@push2mem	(sizeof_class)
	@reg2mem 	(ecx, this_)
	call	xr_vector__push_back
	EXITM <eax>
ENDM