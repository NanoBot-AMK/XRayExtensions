;======================================================================
;	Project		: XRay - Extensions		
;	Module		: weapon_RG6_fix.asm
;	Created		: 14.10.2019
;	Modified	: 15.10.2019
;	Author		: NanoBot
;	Description : √ранатомЄт –√-6, класс CWeaponRG6
;======================================================================

align_proc
CWeaponRG6@@FireTraceRocket proc uses esi ebx P:ptr Fvector4, D:ptr Fvector4
;ecx	this	CRocketLauncher*
	lea		esi, [ecx-CWeaponRG6.CRocketLauncher@vfptr]
	ASSUME	esi:ptr CWeaponRG6
	mov		edx, [esi].m_magazine._Mylast	;CCartridge
	.if ([edx-size CCartridge].CCartridge.m_flags & cfFakeGrenade)	;определить патрон-ракету
		xor		ebx, ebx	;zoom = false
		mov		ecx, [esi].Parent
		.if([esi].m_bZoomMode && ![esi].m_bBlockAutoAimRG && EQ_QWORD([ecx].CObject.CLS_ID, 'O_ACTOR '))
			inc		ebx		;zoom = true
		.endif
		lea		ecx, [esi].CRocketLauncher@vfptr
		CRocketLauncher@@StartRocket(P, D, bl)
	.endif
	ASSUME	esi:nothing
	ret
CWeaponRG6@@FireTraceRocket endp

align_proc
CWeaponRG6@@ReloadMagazine proc uses esi ebx
;ecx	this CWeapon*
	mov		esi, ecx
	ASSUME	esi:ptr CWeapon, eax:ptr CRocketLauncher
	;размер магазина нельз€ задавать больше 255!!!
	mov		bl, true	;can_reload_rockets = true
	.if (![esi].m_bTriStateReload && [esi].iAmmoElapsed==0)
		mov		bl, false
		;зар€дим ракеты
		mov		ecx, esi
		CWeaponRG6@@AddCartridge([esi].iMagazineSize)
	.endif
	mov		ecx, esi
	CWeaponMagazined@@ReloadMagazine()
	.if (bl && [esi].iAmmoElapsed>0)
		;зар€дим ракеты которые соотвествуют патронам в m_magazine
		lea		ecx, [esi-size CRocketLauncher]
		CRocketLauncher@@SpawnRockets(&[esi].m_magazine)
	.endif
	ASSUME	esi:nothing, eax:nothing
	ret
CWeaponRG6@@ReloadMagazine endp

align_proc
CWeaponRG6@@UnloadMagazine proc uses esi spawn_ammo:byte
;ecx	this CWeapon*
	mov		esi, ecx
	CWeaponMagazined@@UnloadMagazine(spawn_ammo)
	;удалить ракеты
	lea		ecx, [esi-size CRocketLauncher]
	CRocketLauncher@@DeleteRockets()
	ret
CWeaponRG6@@UnloadMagazine endp

align_proc
CWeaponRG6@@AddCartridge_chank proc
;esi	this	CWeaponRG6*
;eax	*m_ammoTypes[m_ammoType]	LPCSTR
	mov		edi, eax
	.if (@LINE_EXIST(edi, &aFake_grenade_n)==0)
		pop		edi
		pop		esi
		pop		ebx
		retn	4
	.endif
	mov		eax, edi
	jmp		return_CWeaponRG6@@AddCartridge_chank
CWeaponRG6@@AddCartridge_chank endp
