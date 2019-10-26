
;скриптовый колбек на хит актора
align_proc
CActor@@HitSignal_callback proc perc:real4, vLocalDir:ptr Fvector, who:ptr CObject, element:word
	push	esi
	mov		esi, ecx
	CALLBACK__GO_FLOAT_VECTOR_GO_u16	esi, GameObject__eHit, esi, perc, vLocalDir, who, element
	mov		ecx, esi
	pop		esi
	leave
	jmp		CActor@@HitSignal
CActor@@HitSignal_callback endp
