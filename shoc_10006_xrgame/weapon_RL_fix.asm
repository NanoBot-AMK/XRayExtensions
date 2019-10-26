;======================================================================
;	Project		: XRay - Extensions		
;	Module		: weapon_RL_fix.asm
;	Created		: 14.10.2019
;	Modified	: 21.10.2019
;	Author		: NanoBot
;	Description : Оружие с подствольным гранатомётом, класс CWeaponMagazinedWGrenade
;======================================================================

align_proc
CWeaponMagazinedWGrenade@@CWeaponMagazinedWGrenade_fix proc
;edi	this	CWeaponMagazinedWGrenade*
;ebx	0
	ASSUME	edi:ptr CWeaponMagazinedWGrenade
	mov		[edi].m_bHasDifferentFireModes2, false		;для подствольника, режим огня только одиночный!
;---------------------
	mov		eax, edi
	pop		ebx
	pop		ecx
	retn
CWeaponMagazinedWGrenade@@CWeaponMagazinedWGrenade_fix endp

align_proc
CWeaponMagazinedWGrenade@@Load_fix proc
;edi	this	CWeaponMagazinedWGrenade*
	mov		[edi].iMagazineSize2, 1			;// по дефолту ПГ однозарядный.
	mov		[edi].m_bCanRocketReload, true
	mov		[edi].m_bGrnLauncherShotgun, false
	mov		[edi].m_bCanScopeGrnMode, false
	mov		[edi].m_bBlockAutoAimRG, false
	mov		[edi].m_bAutoReload2, true
	mov		esi, [esp+9Ch+4];section
	mov		ebx, offset aGrenade_laun_0
	.if (@LINE_EXIST(esi, ebx))
		mov		ebx, @R_STRING(esi, ebx)	;LPCSTR	sect_gl
		mov		esi, const_static_str$("ammo_mag_size")
		.if (@LINE_EXIST(ebx, esi))
			mov		[edi].iMagazineSize2, @R_U32(ebx, esi)
		.endif
		mov		esi, const_static_str$("grenade_launcher_shotgun")
		.if (@LINE_EXIST(ebx, esi))
			mov		[edi].m_bGrnLauncherShotgun, @R_BOOL(ebx, esi)
		.endif
		mov		esi, const_static_str$("can_scope_grn_mode")
		.if (@LINE_EXIST(ebx, esi))
			mov		[edi].m_bCanScopeGrnMode, @R_BOOL(ebx, esi)
		.endif
		mov		esi, offset aBlock_auto_aim_rg	;"block_auto_aim_rg"
		.if (@LINE_EXIST(ebx, esi))
			mov		[edi].m_bBlockAutoAimRG, @R_BOOL(ebx, esi)
		.endif
		mov		esi, offset eAuto_reload		;"auto_reload"
		.if (@LINE_EXIST(ebx, esi))
			mov		[edi].m_bAutoReload2, @R_BOOL(ebx, esi)
		.endif
	.endif
;----------------------
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	add		esp, 8Ch
	retn	4
CWeaponMagazinedWGrenade@@Load_fix endp

align_proc
CWeaponMagazinedWGrenade@@PerformSwitchGL_fix proc
	mov		edi, [ebp-4];this	CWeaponMagazinedWGrenade*
	swap	[edi].m_bAutoReload2, [edi].m_bAutoReload
	swap	[edi].m_bHasDifferentFireModes2, [edi].m_bHasDifferentFireModes
	;// перегружаем параметры: подствольный, основной ствол. Если включено.	(c) NanoBot
	.if ([edi].m_bGrnLauncherShotgun)
		mov		eax, [edi].NameSection.p_	;LPCSTR	sect = cNameSect().c_str();
		lea		ebx, [eax].str_value.value
		.if ([edi].m_bGrenadeMode)
			mov		ebx, @R_STRING(ebx, &aGrenade_laun_0)	;"grenade_launcher_name"
		.endif
		;fTimeToFire	= 60.f / pSettings->r_float(sect, "rpm");
		@R_FLOAT(ebx, &aRpm)	;"rpm"
		fdivr	const_static_float$(60.0)
		fstp	[edi].fTimeToFire
		mov		ecx, edi
		CWeaponMagazinedWGrenade@@LoadFireParams(ebx, &null_string)
	.else	;// если режим дробовика не включён, то в режиме ПГ запрещаем стрелять пулями.
		;fireDistance	= (m_bGrenadeMode) ? 0.f : pSettings->r_float(cNameSect(), "fire_distance");
		fldz
		.if (![edi].m_bGrenadeMode)
			mov		edx, [edi].NameSection.p_
			@R_FLOAT(&[edx].str_value.value, &aFire_distance)	;"fire_distance"
		.endif
		fstp	[edi].fireDistance
	.endif
	ASSUME	edi:nothing
;----------------------
	pop		edi
	pop		esi
	pop		ebx
	mov		esp, ebp
	pop		ebp
	retn
CWeaponMagazinedWGrenade@@PerformSwitchGL_fix endp

align_proc
CWeaponMagazinedWGrenade@@FireTraceRocket proc uses esi P:ptr Fvector, D:ptr Fvector
;ecx	this	CRocketLauncher*
	lea		esi, [ecx-CWeaponMagazinedWGrenade.CRocketLauncher@vfptr]
	ASSUME	esi:ptr CWeaponMagazinedWGrenade
	.if ([esi].m_bGrenadeMode)
		mov		[esi].bWorking, false
		;bool	aim = m_bZoomMode && !m_bBlockAutoAimRG;
		mov		dl, [esi].m_bZoomMode
		mov		al, [esi].m_bBlockAutoAimRG
		xor		al, 1
		and		dl, al
		lea		ecx, [esi].CRocketLauncher@vfptr
		CRocketLauncher@@StartRocket(P, D, dl)
	.endif
	ret
CWeaponMagazinedWGrenade@@FireTraceRocket endp

align_proc
CWeaponMagazinedWGrenade@@UnloadMagazine proc uses esi spawn_ammo:byte
	mov		esi, ecx
	CWeaponMagazined@@UnloadMagazine(spawn_ammo)
	.if ([esi].m_bGrenadeMode)
		lea		ecx, [esi].CRocketLauncher@vfptr
		CRocketLauncher@@DeleteRockets()
	.endif
	ASSUME	esi:nothing
	ret
CWeaponMagazinedWGrenade@@UnloadMagazine endp

align_proc
CWeaponMagazinedWGrenade@@Detach_fix proc
	mov		eax, edi
	CWeaponMagazinedWGrenade@@PerformSwitchGL()
	jmp		return_CWeaponMagazinedWGrenade@@Detach_fix
CWeaponMagazinedWGrenade@@Detach_fix endp

;сохранение m_ammoType2 в упакованом виде
;Формат хранения такой: [00YYZZZZ] где ZZZZ это m_magazine2.size(), YY - m_ammoType2
align_proc
CWeaponMagazinedWGrenade@@save_fix proc
;edi	this	CWeaponMagazinedWGrenade*
;esi	P		NET_Packet*
;eax	size
	ASSUME	edi:ptr CWeaponMagazinedWGrenade, esi:ptr NET_Packet
	and		eax, 0FFFFh
	mov		edx, [edi].m_ammoType2
	and		edx, 0FFh
	shl		edx, 16
	or		eax, edx
	mov		dword ptr [esi].NET_Packet.B.data[ebx], eax
;---------------
	pop		edi
	pop		esi
	pop		ebx
	retn	4
CWeaponMagazinedWGrenade@@save_fix endp

;загрузка m_ammoType2
align_proc
CWeaponMagazinedWGrenade@@load_fix proc
;edi	this	CWeaponMagazinedWGrenade*
;sz = -3Ch		int		//
	mov		eax, [esp+50h-3Ch];sz
	mov		edx, eax
	shr		edx, 16
	and		edx, 0FFh
	and		dword ptr [esp+50h-3Ch], 0FFFFh	;zx &= 0xFFFF;
	mov		[edi].m_ammoType2, edx
	jmp		return_CWeaponMagazinedWGrenade@@load_fix
CWeaponMagazinedWGrenade@@load_fix endp

align_proc
CWeaponMagazinedWGrenade@@OnH_A_Chield proc uses edi ebx
	sub		ecx, 0D8h	;casting: CGameObject -> CWeaponMagazinedWGrenade
	mov		edi, ecx
	mov		bl, [edi].m_bHasDifferentFireModes
	mov		[edi].m_bHasDifferentFireModes, true
	CWeaponMagazined@@OnH_A_Chield()
	mov		[edi].m_bHasDifferentFireModes, bl
	ret
CWeaponMagazinedWGrenade@@OnH_A_Chield endp

align_proc
CWeaponMagazinedWGrenade@@LoadFireParams proc uses edi esi ebx section:ptr byte, prefixptr:ptr byte
local const_0p7:real4, const_1p0:real4
	mov		edi, ecx
	mov		ebx, section
	lea		ecx, [edi].CShootingObject@vfptr
	CWeapon@@LoadFireParams(ebx, prefixptr)
	;//дисперсия стрельбы
	;//подбрасывание камеры во время отдачи
	;camMaxAngle = pSettings->r_float(section, "cam_max_angle")*DEG2RAD;
	@R_FLOAT(ebx, &aCam_max_angle)		;"cam_max_angle"
	fmul	g_fDeg2rad
	fstp	[edi].camMaxAngle
	;camRelaxSpeed = pSettings->r_float(section, "cam_relax_speed")*DEG2RAD;
	@R_FLOAT(ebx, &aCam_relax_speed)	;"cam_relax_speed"
	fmul	g_fDeg2rad
	fstp	[edi].camRelaxSpeed
	;camMaxAngleHorz = pSettings->r_float(section, "cam_max_angle_horz")*DEG2RAD;
	@R_FLOAT(ebx, &aCam_max_angle_)		;"cam_max_angle_horz"
	fmul	g_fDeg2rad
	fstp	[edi].camMaxAngleHorz
	;camStepAngleHorz = pSettings->r_float(section, "cam_step_angle_horz")*DEG2RAD;
	@R_FLOAT(ebx, &aCam_step_angle)		;"cam_step_angle_horz"
	fmul	g_fDeg2rad
	fstp	[edi].camStepAngleHorz
	mov		const_0p7, 0.7
	mov		const_1p0, 1.0
	;camDispertionFrac = READ_IF_EXISTS(pSettings, r_float, section, "cam_dispertion_frac", 0.7f);
	mov		esi, offset aCam_dispertion		;"cam_dispertion_frac"
	.if (@LINE_EXIST(ebx, esi))
		@R_FLOAT(ebx, esi)
	.else
		fld		const_0p7
	.endif
	fstp	[edi].camDispertionFrac
	;fireDispersionConditionFactor = pSettings->r_float(section, "fire_dispersion_condition_factor");
	@R_FLOAT(ebx, &aFire_dispers_1)		;"fire_dispersion_condition_factor"
	fstp	[edi].fireDispersionConditionFactor
	;misfireProbability = pSettings->r_float(section, "misfire_probability");
	@R_FLOAT(ebx, &aMisfire_probab)		;"misfire_probability"
	fstp	[edi].misfireProbability
	;misfireConditionK = READ_IF_EXISTS(pSettings, r_float, section, "misfire_condition_k", 1.0f);
	mov		esi, offset aMisfire_condit		;"misfire_condition_k"
	.if (@LINE_EXIST(ebx, esi))
		@R_FLOAT(ebx, esi)
	.else
		fld		const_1p0
	.endif
	fstp	[edi].misfireConditionK
	;conditionDecreasePerShot = pSettings->r_float(section, "condition_shot_dec");
	@R_FLOAT(ebx, &aCondition_shot)		;"condition_shot_dec"
	fstp	[edi].conditionDecreasePerShot
	ret
CWeaponMagazinedWGrenade@@LoadFireParams endp

;учёт веса патронов во втором стволе
align_proc
CWeaponMagazinedWGrenade@@Weight proc uses esi edi ebx
local res:real4, weight:real4, box_size:real4
	mov		edi, ecx
	CWeapon@@Weight()
	fstp	res
	;size_ammo = m_magazine2.size();
	mov		eax, [edi].m_magazine2._Mylast
	sub		eax, [edi].m_magazine2._Myfirst
	xor		edx, edx
	mov		ecx, sizeof(CCartridge)
	div		ecx
	.if (eax)
		mov		esi, eax	;size_ammo
		mov		eax, [edi].m_magazine2._Mylast
		mov		edx, [eax-sizeof(CCartridge)].CCartridge.m_ammoSect
		lea		ebx, [edx].str_value.value
		;float weight = pSettings->r_float(ammo_sect, "inv_weight");
		@R_FLOAT(ebx, &aInv_weight)
		fstp	weight
		;float box_size = pSettings->r_float(ammo_sect, "box_size");
		@R_FLOAT(ebx, &aBox_size)
		fstp	box_size
		;res += weight*((float)size_ammo / box_size);
		cvtsi2ss xmm0, esi
		divss	xmm0, box_size
		mulss	xmm0, weight
		addss	xmm0, res
		movss	res, xmm0
	.endif
	fld		res
	ASSUME	edi:nothing, esi:nothing
	ret
CWeaponMagazinedWGrenade@@Weight endp
