
align_proc
CHangingLamp__net_Spawn_fix proc
;edi	lamp			CSE_ALifeObjectHangingLamp*
;esi	light_render	
	; добавл€ем сохранение virtual size в незан€тую €чейку старшего байта флагов
	; провер€ем тип рендера
	ASSUME	edi:ptr CSE_ALifeObjectHangingLamp, ecx:ptr light
	mov		edx, ds:psDeviceFlags
	mov		ecx, [edx]
	.if (ecx & 80000h)
		;light_render->m_f270h = lamp->m_ambient_power;
		;light_render->m_f274h = -lamp->m_ambient_power;
		fld		[edi].m_ambient_power	;+336
		mov		ecx, [esi]
		fst		[ecx].m_f270h
		fchs
		fstp	[ecx].m_f274h
	.endif
	; делаем вырезанное
	mov		ecx, [esi]
	mov		edx, [ecx]
	mov		edx, [edx+30h]
	; идЄм обратно
	jmp		return_CHangingLamp__net_Spawn_fix
CHangingLamp__net_Spawn_fix endp

;FLDCW instruction loads the control register from the specified memory location, 
;FSTCW stores the control register into the specified memory location.

; next fix assumes extended CSE_ALifeObjectHangingLamp::flags field
flPhysic		= 0x01
flCastShadow	= 0x02
flR1			= 0x04
flR2			= 0x08
flTypeSpot		= 0x10
flPointAmbient	= 0x20
flVolumetric	= 0x40
flUseFlare		= 0x80

align_proc
CHangingLamp__net_Spawn_fix_2 proc
	;вырезанное
	push	ecx
	fstp	dword ptr [esp]
	call	edx
	; провер€ем тип рендера
	mov		eax, ds:psDeviceFlags
	mov		edx, [eax]
	.if (edx & 80000h)	;psR2
		; mark flare flag
		mov		ecx, [esi]	;light_render
		mov		dx, [edi].CSE_ALifeObjectHangingLamp@flags		;+138h
		.if (dx & flUseFlare)
		;	mov		eax, ONE
			mov		[ecx].m_dw284h, 1
		.endif
		; handle volumetric spots
		.if (dx & (flVolumetric AND flTypeSpot))
		;	mov		eax, ONE
			mov		[ecx].m_dw288h, 1
		.endif
	.endif
	ASSUME	edi:nothing, ecx:nothing
	; идЄм обратно
	jmp		return_CHangingLamp__net_Spawn_fix_2
CHangingLamp__net_Spawn_fix_2 endp

;static_int		ONE, 1
