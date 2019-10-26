
align_proc
actor_torch_light proc
;edi - light*
;esi - CTorch*
;	% echo @CatStr(% light.vis);;sizeof
;	% echo @CatStr(% light.X)
	ASSUME	esi:ptr CTorch, edi:ptr light	;IRender_Light
	mov		edi, [esi].light_render.p_			;+2ACh	IRender_Light*
	movzx	eax, [esi].m_switched_on	;+2A8h
	mov		dword ptr [edi+290h], eax	; размер light 624 байт
	ASSUME	esi:nothing, edi:nothing
	;return;
	pop		edi
	pop		esi
	pop		ebx
	mov		esp, ebp
	pop		ebp
	retn	4
actor_torch_light endp

