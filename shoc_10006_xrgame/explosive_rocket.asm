;======================================================================
;	Project		: XRay - Extensions		
;	Module		: explosive_rocket.asm
;	Created		: 24.07.2019
;	Modified	: 28.07.2019
;	Author		: NanoBot
;	Description : Расширения возможностей  CExplosiveRocket
;======================================================================

;расширение конструктора
align_proc
CExplosiveRocket@@CExplosiveRocket@ext proc
;esi	this	CExplosiveRocket*
	ASSUME	esi:ptr CExplosiveRocket
	mov		[esi].m_bStartRocket, true
	xor		ecx, ecx
	mov		[esi].m_SubElements._Alval, ecx
	mov		[esi].m_SubElements._Myfirst, ecx
	mov		[esi].m_SubElements._Mylast, ecx
	mov		[esi].m_SubElements._Myend, ecx
	mov		[esi].m_type_element, eNoPyroelement
	mov		[esi].m_IgnorCollideID, -1
	mov		[esi].m_start_particles, ecx
	mov		[esi].m_start_sound, ecx
	mov		eax, esi
	pop		esi
	retn
CExplosiveRocket@@CExplosiveRocket@ext endp

;расширение деструктора
align_proc
CExplosiveRocket@@_CExplosiveRocket@ext proc
;ecx	this	CExplosiveRocket*
	push	esi
	mov		esi, ecx
	mov		edx, [esi].m_SubElements._Myfirst
	.if (edx)
		xr_mem_free	edx
		xor		ecx, ecx
		mov		[esi].m_SubElements._Myfirst, ecx
		mov		[esi].m_SubElements._Mylast, ecx
		mov		[esi].m_SubElements._Myend, ecx
	.endif
	mov		ecx, [esi].m_start_particles
	.if (ecx)
		CScriptParticles@@_CScriptParticles(1)
		mov		[esi].m_start_particles, NULL
	.endif
	mov		ecx, [esi].m_start_sound
	.if (ecx)
		dec		[ecx].ref_sound_data.dwReference
		.if ([ecx].ref_sound_data.dwReference==0)
			ref_sound@@_ref_sound(&[esi].m_start_sound)
		.endif
	.endif
	mov		ecx, esi
	pop		esi
	jmp		CCustomRocket@@_CCustomRocket
CExplosiveRocket@@_CExplosiveRocket@ext endp

align_proc
CExplosiveRocket@@Load@ext proc
;esi	this	CExplosiveRocket*
;edi	section	LPCSTR
	push	ebx
	push	ebp
	ASSUME	esi:ptr CExplosiveRocket
	mov		eax, ds:pSettings	; CInifile * pSettings
	mov		ebx, [eax]
	;возможность выключать в ракете взрываться от контакта с чем либо.
	mov		ebp, const_static_str$("can_contact_explode")
	mov		[esi].m_bCanContactExplo, true
	push	ebp
	push	edi
	mov		ecx, ebx
	call	ds:line_exist		; CInifile::line_exist(char const *,char const *);
	.if (eax)
		push	ebp
		push	edi
		mov		ecx, ebx
		call	ds:r_bool		; CInifile::r_bool(char const *,char const *);
		mov		[esi].m_bCanContactExplo, al
	.endif
	;возможность выключать в ракете способность взрываться от самоликвидатора.
	mov		ebp, const_static_str$("can_timer_explode")
	mov		[esi].m_bCanTimerExplo, true
	push	ebp
	push	edi
	mov		ecx, ebx
	call	ds:line_exist		; CInifile::line_exist(char const *,char const *);
	.if (eax)
		push	ebp
		push	edi
		mov		ecx, ebx
		call	ds:r_bool		; CInifile::r_bool(char const *,char const *);
		mov		[esi].m_bCanTimerExplo, al
	.endif
	;парашют у ракеты
	mov		ebp, const_static_str$("time_open_parachute")
	movflt	[esi].m_fTimeOpenParachute, 1.0e9
	push	ebp
	push	edi
	mov		ecx, ebx
	call	ds:line_exist		; CInifile::line_exist(char const *,char const *);
	.if (eax)
		push	ebp
		push	edi
		mov		ecx, ebx
		call	ds:r_float
		fstp	[esi].m_fTimeOpenParachute
		xorps	xmm0, xmm0
		.if (xmm0>=[esi].m_fTimeOpenParachute)
			movflt	[esi].m_fTimeOpenParachute, 1.0e9
		.else
			push	const_static_str$("speed_descent")	;speed descent by parachute
			push	edi
			mov		ecx, ebx
			call	ds:r_float		; CInifile::r_bool(char const *,char const *);
			fstp	[esi].m_fSpeedDescent
			movss	xmm0, [esi].m_fSpeedDescent
			float@clamp	xmm0, 0.5, 150.0	;// ограничем скорость снижения в разумных пределах
			movss	[esi].m_fSpeedDescent, xmm0
		.endif
	.endif
	mov		[esi].m_bOpenParachute, true
	;пиротехника
	mov		ebx, const_static_str$("type_pyroelement")	;наличие этого параметра означает, что ракета идёт как пироэлемент.
	.if (@LINE_EXIST(edi, ebx))
		mov		[esi].m_type_element, @R_U32(edi, ebx)
		mov		ecx, esi
		CExplosiveRocketPyro@@Load(edi)
	.endif
	pop		ebp
	pop		ebx
;---------------------
	pop		edi
	pop		esi
	retn	4
CExplosiveRocket@@Load@ext endp

align_proc
CExplosiveRocket@@Explode proc uses edi
;ecx	this	CExplosive*
	mov		edi, ecx
	call	CExplosive@@Explode
	lea		ecx, [edi-CExplosiveRocket.CExplosive@vfptr]	;cast CExplosive --> CExplosiveRocket
	.if ([ecx].CExplosiveRocket.m_type_element==eLustkugel)
		CExplosiveRocketPyro@@Explode()
	.endif
	ret
CExplosiveRocket@@Explode endp

align_proc
CExplosiveRocket@@OnEvent@ext proc
;esi	this	CExplosiveRocket*
;ebx	P		NET_Packet*
;edi	type	u16
	.if ([esi].m_type_element==eLustkugel)
		mov		ecx, esi
		CExplosiveRocketPyro@@OnEvent(ebx, edi)
	.endif
;----------------------------
	pop		edi
	pop		esi
	pop		ebx
	retn	8
CExplosiveRocket@@OnEvent@ext endp

align_proc
CExplosiveRocket@@UpdateCL proc
;esi	this	CExplosiveRocket*
	.if ([esi].m_pPhysicsShell && [esi].m_bStartRocket)	;если физ. оболочка в наличии, то произошёл выстрел
		mov		[esi].m_bStartRocket, false
		;Выстрел! Ракета пошла!
		.if ([esi].m_type_element!=eNoPyroelement)
			mov		ecx, esi
			CExplosiveRocketPyro@@InitStart()
		.endif
	.endif
;------------------
	pop		esi
	retn
CExplosiveRocket@@UpdateCL endp

;возможность выключать в ракете способность взрываться от контакта
align_proc
CCustomRocket@@SwitchContact proc
	.if ([esi].m_bCanContactExplo)
		push	offset CCustomRocket@@ObjectContactCallback		;ракета взрывается от контакта
	.else
		;CGameObject	*obj = H_Root();
		push	eax
		push	ecx
		.if (CObject@@H_Root(esi))
			;m_pPhysicsShell->set_CallbackData(smart_cast<CPhysicsShellHolder*>(obj)); //для того чтобы не хитовала владельца!
			smart_cast	CPhysicsShellHolder, eax
			CPhysicsShell@@set_CallbackData([esi].m_pPhysicsShell, eax)
		.endif
		pop		ecx
		pop		eax
		push	offset CExplosiveLustkugel__ExitContactCallback	;CMissile@@ExitContactCallback			;ракета НЕ взрывается от контакта
	.endif
	ASSUME	esi:nothing
	jmp		return_CCustomRocket@@SwitchContact
CCustomRocket@@SwitchContact endp

;возможность выключать в ракете способность взрываться от самоликвидатора.
align_proc
CCustomRocket@@DeleteOrExplode proc
;esi	this	CCustomRocket*
	ASSUME	esi:ptr CCustomRocket
	.if ([esi].m_bCanTimerExplo)
		;Contact(Position(), Direction());				//взрываем
		mov		edx, [esi]
		mov		edx, [edx+1E8h]
		lea		eax, [esi].XFORM_.k		;+70h
		push	eax
		lea		ecx, [esi].XFORM_.c_	;+80h
		push	ecx
		mov		ecx, esi
		call	edx
	.elseif ([esi].Props.flags & net_Local) ;Local()	//просто удаляем
		;DestroyObject();
		mov		edx, [esi]
		mov		ecx, esi
		mov		eax, [edx+0E8h]
		call	eax
	.endif
	ASSUME	esi:nothing
	pop		esi
	retn
CCustomRocket@@DeleteOrExplode endp

align_proc
CCustomRocket@@SetLaunchParams_ext proc
;ebx	this	CCustomRocket*
	ASSUME	ebx:ptr CCustomRocket
	;m_fTimeOpenParachute = Device.fTimeGlobal + m_fTimeOpenParachute;	//запуск таймера парашюта
	mov		eax, ds:Device
	movss	xmm0, [eax].CRenderDevice.fTimeGlobal
	addss	xmm0, [ebx].m_fTimeOpenParachute
	movss	[ebx].m_fTimeOpenParachute, xmm0
	mov		[ebx].m_bOpenParachute, false
	ASSUME	ebx:nothing
	pop		ebx
	retn	12
CCustomRocket@@SetLaunchParams_ext endp

;Открыть парашют в ракете, задаётся коэффициентом сопротивления воздуха.
align_proc
CCustomRocket@@OpenParachute proc
;esi	this	CExplosiveRocket*
	ASSUME	esi:ptr CCustomRocket
	mov		[esi].m_bOpenParachute, true
	mov		ecx, esi
	CPhysicsShellHolder@@SetSpeedDescent([esi].m_fSpeedDescent)
	ASSUME	esi:nothing
	ret
CCustomRocket@@OpenParachute endp
