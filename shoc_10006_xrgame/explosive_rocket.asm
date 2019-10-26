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

;фикс ошибки при взрыве ракеты методом explode(0)
align_proc
CScriptGameObject@@explode_fix proc
;ebx	explosive	CExplosive*	
	smart_cast	CExplosiveRocket, CExplosive, ebx
	.if (eax)
		;explosive->Contact(object().Position(), normal);
		mov		ebx, eax	;CExplosiveRocket*
		mov		eax, [ebx]
		mov		edx, [eax+1E8h]
	.else
		;explosive->GenExplodeEvent(object().Position(), normal);
		mov		eax, [ebx]
		mov		edx, [eax+4Ch]
	.endif
	jmp		return_CScriptGameObject@@explode_fix
CScriptGameObject@@explode_fix endp

align_proc
CCustomRocket@@SetParamsAirResistance proc uses esi edi ebx
local linear:real4, angular:real4
;esi	this	CCustomRocket*
	mov		esi, ecx
	ASSUME	esi:ptr CCustomRocket
	and		linear, 0
	and		angular, 0
	mov		edx, [esi].NameSection.p_
	lea		ebx, [edx].str_value.value
	mov		edi, const_static_str$("air_resistance_linear")
	.if (@LINE_EXIST(ebx, edi))
		@R_FLOAT(ebx, edi)
		fstp	linear
		xorps	xmm0, xmm0
		.if (xmm0>linear)
			movss	linear, xmm0
		.endif
	.endif
	mov		edi, const_static_str$("air_resistance_angular")
	.if (@LINE_EXIST(ebx, edi))
		@R_FLOAT(ebx, edi)
		fstp	angular
		xorps	xmm0, xmm0
		.if (xmm0>angular)
			movss	angular, xmm0
		.endif
	.endif
	CPHShell@@SetAirResistance([esi].m_pPhysicsShell, linear, angular)
	ret
CCustomRocket@@SetParamsAirResistance endp

;//используется для расчёта траектории
align_proc
CExplosiveRocket@@RealGravity proc (real4) uses esi edi
local mass:real4, min_impulse:real4
	mov		esi, ecx
	ASSUME	esi:ptr CExplosiveRocket, edi:ptr CPHWorld
	mov		min_impulse, 0.01
	mov		edx, [esi].NameSection.p_
	mov		eax, @R_U32(&[edx].str_value.value, &aForce_explode_)	;"force_explode_time"
	movss	xmm0, min_impulse
	mov		edi, ph_world
	.if ([esi].m_bEnginePresent && [esi].m_dwEngineWorkTime==eax && xmm0<=[esi].m_fEngineImpulse)
		;gravity = ph_world->Gravity() - m_fEngineImpulseUp/GetMass()
		mov		ecx, [esi].m_pPhysicsShell
		.if (ecx)
			mov		edx, [ecx]
			mov		eax, [edx+48h]
			call	eax
			fstp	mass
		.else
			mov		mass, 7.0	;; предполагается что масса ракеты фиксированная.
		.endif
		movss	xmm0, [edi].m_gravity
		movss	xmm1, [esi].m_fEngineImpulseUp
		divss	xmm1, mass
		subss	xmm0, xmm1
	.elseif	(![esi].m_bEnginePresent)
		movss	xmm0, [edi].m_gravity	;gravity = ph_world->Gravity();
	.else	;//не смогли рассчитать реальную гравитацию
		xorps	xmm0, xmm0	;gravity = 0.f
	.endif
	ASSUME	esi:nothing, edi:nothing
	ret
CExplosiveRocket@@RealGravity endp

;кумулятивная струя
align_proc
CExplosive@@CumulativeJet proc uses esi edi ebx
local SendHits:byte, sect_cum:ptr byte, pos:Fvector, cartridge:CCartridge
;ecx	this	CExplosive*
	mov		edi, ecx
	ASSUME	esi:ptr CGameObject, edi:ptr CExplosive
	mov		esi, [edi].m_game_object
	.if (esi)
		mov		ebx, const_static_str$("cumulative_sect")
		mov		edx, [esi].NameSection.p_		;LPCSTR	sect = obj->cNameSect().c_str();
		.if (@LINE_EXIST(&[edx].str_value.value, ebx))
			mov		edx, [esi].NameSection.p_
			mov		sect_cum, @R_STRING(&[edx].str_value.value, ebx)
			xor		eax, eax
			mov		cartridge.m_flags, al
			mov		cartridge.m_ammoSect.p_, eax
			mov		cartridge.m_InvShortName.p_, eax
			CCartridge@@Load(&cartridge, sect_cum, 0)
			mov		SendHits, OnServer()
			CObject@@Center(esi, &pos)
			;Initiator()
			mov		ecx, edi
			mov		eax, [edi]
			mov		edx, [eax+4]
			call	edx
			mov		edx, eax
			CBulletManager@@AddBullet(&pos, &[esi].XFORM_.k, 1000.0, 1.0, 1.0, edx, [esi].ID, eHitTypeFireWound, 1.0, &cartridge, SendHits)
		.endif
	.endif
	mov		eax, esi
	ASSUME	esi:nothing, edi:nothing
	ret
CExplosive@@CumulativeJet endp

align_proc
CExplosive@@CumulativeJet_fix proc
	mov		ecx, ebp
	CExplosive@@CumulativeJet()
	jmp		return_CExplosive@@CumulativeJet_fix
CExplosive@@CumulativeJet_fix endp
