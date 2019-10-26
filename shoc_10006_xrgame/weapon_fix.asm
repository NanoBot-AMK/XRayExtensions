;====================================================================
;		Оружие
; Колбеки
; Рефакторинг НаноБот
;====================================================================
eWeaponOnShoot		= dword ptr 181		; колбек на выстрел
eWeaponStartBullet	= dword ptr 182		; колбек на старт пули
eWeaponStopBullet	= dword ptr 183		; колбек на стоп пули

align	4
aCallback_on		db "callback_on", 0			; название булевого параметра в конфиге патрона для включения колбеков для старта и стопа пули.
align	4
aAllow_ricochet		db "allow_ricochet", 0
align	4
aShell_explosive	db "shell_explosive", 0
align	4
aSect_explosive		db "sect_explosive", 0
align	4
aWpn_scope			db "wpn_scope", 0

eAddonDisabled				= dword ptr 0		;// нельзя присоеденить
eAddonPermanent				= dword ptr 1		;// постоянно подключено по умолчанию
eAddonAttachable			= dword ptr 2		;// можно присоединять


m_flagsAddOnState				= byte	ptr 936
m_eGrenadeLauncherStatus		= dword ptr 948
m_bGrenadeMode					= byte	ptr 2392	; bool

align_proc
UpdateAddonsVisibility_fix proc
	; делаем что хотели сделать
	; вызываем колбек для объекта оружия
	;PRINT_UINT "UpdateAddonsVisibility: %x", eax
	.if ([edi+m_flagsAddOnState] & 040h)
		;PRINT_UINT "UpdateAddonsVisibility_fix object: %x", edi
		lea		eax, [edi+0d8h]		; CGameObject <- CWeapon
		CALLBACK__VOID	eax, 154
	.endif
	;PRINT "UpdateAddonsVisibility_fix 2"
	; делаем вырезанное
	mov		ecx, esi ; <== это было
	call	ds:CKinematics__CalculateBones_Invalidate ; <== вот эта команда будет испорчена релокацией, если врезаться здесь
	mov		eax, [esi]
	mov		edx, [eax+40h]
	push	0
	mov		ecx, esi
	call	edx
	;PRINT "UpdateAddonsVisibility_fix 3"
	pop		esi
	pop		ebp
	pop		ebx
	retn
UpdateAddonsVisibility_fix endp

align_proc
UpdateHUDAddonsVisibility_fix proc
	push	eax
	;PRINT_UINT "UpdateHUDAddonsVisibility: %x", eax
	.if ([ebp+m_flagsAddOnState] & 040h)
		;PRINT "UpdateHUDAddonsVisibility 1"
		lea		eax, [edi+0d8h]		; CGameObject <- CWeapon
		CALLBACK__VOID	eax, 155
	.endif
	pop		eax
	; делаем вырезанное
	push	ebx
	push	edi
	push	offset aWpn_scope ; "wpn_scope"
	mov		ecx, esi
	; идём обратно
	jmp		back_from_UpdateHUDAddonsVisibility_fix
UpdateHUDAddonsVisibility_fix endp

align_proc
CWeaponMagazinedWGrenade__UseScopeTexture_fix proc
	.if ([ecx+m_flagsAddOnState] & 080h)	
		xor		eax, eax
		retn
	.endif
	;if (IsGrenadeLauncherAttached() && m_bGrenadeMode) return false;
	mov		eax, [ecx+m_eGrenadeLauncherStatus]
	cmp		eax, eAddonAttachable ; IsGrenadeLauncherAttached()
	jnz		loc_1022B3D3
	test	[ecx+m_flagsAddOnState], al
	jnz		loc_1022B3D8
loc_1022B3D3:
	cmp		eax, eAddonPermanent
	jnz		return_true
loc_1022B3D8:
	cmp		[ecx+m_bGrenadeMode], 0
	jz		return_true
	xor		eax, eax ; return false
	retn
return_true:
	mov		eax, 1 ; return true
	retn
CWeaponMagazinedWGrenade__UseScopeTexture_fix endp
;bool CWeapon::IsGrenadeLauncherAttached() const
;{
;	return (CSE_ALifeItemWeapon::eAddonAttachable == m_eGrenadeLauncherStatus &&
;			0 != (m_flagsAddOnState&CSE_ALifeItemWeapon::eWeaponAddonGrenadeLauncher)) || 
;			CSE_ALifeItemWeapon::eAddonPermanent == m_eGrenadeLauncherStatus;
;}

align_proc
CWeapon__UseScopeTexture_fix proc
	; return (m_flagsAddOnState.test(0x80));
	test	[ecx+m_flagsAddOnState], 080h
	setz	al
	retn
CWeapon__UseScopeTexture_fix endp

;=================================================================================
;								(c) NanoBot
;=================================================================================

iAmmoElapsed		= dword ptr	 1404
m_DefaultCartridge	= dword ptr	 1472
m_ammoType			= dword ptr	 1444
m_iCurFireMode		= dword ptr	 1928

; колбек на выстрел, вызывается в объекте оружия
align_proc
CShootingObject__FireBulletCallback proc
;esi - CShootingObject
;edi - weapon
cartridge		= dword ptr 10h
	call	random_dir
	push	edi
	ASSUME	edi:ptr CGameObject
	smart_cast	_AVCGameObject, _AVCShootingObject, esi
	.if (eax==NULL)	; это CCar
		ASSUME	esi:ptr CCarWeapon
		mov		eax, [esi].m_object	; CPhysicsShellHolder = CGameObject
		ASSUME	esi:nothing
	.endif
	mov		edi, eax
	.if ([edi].m_flCallbackKey & eCallbackShoot)
		smart_cast	_AVCWeaponMagazined, _AVCGameObject, edi
		.if (eax)
			mov		eax, [eax+m_iCurFireMode]	; тип режима огня
			inc		eax
		.endif
		mov		edx, [esp+24h+cartridge]	; секция патрона
		ASSUME	edx:ptr CCartridge
		mov		ecx, [edx].m_ammoSect
		add		ecx, 12		; str
		CALLBACK__STR_u16	edi, eWeaponOnShoot, ecx, eax
		ASSUME	edx:nothing
	.endif
	ASSUME	edi:nothing
	pop		edi
	jmp		return_CShootingObject__FireBulletCallback
CShootingObject__FireBulletCallback endp
;--------------------------------------------------------------------------

; Колбек на старт пули.
align_proc
SBullet__Init_callback proc
;esi - *bullet
	ASSUME	esi:ptr SBullet, edi:ptr CCartridge, ebx:ptr CBulletManager
	;========================================
	mov		ecx, ds:g_pGameLevel
	mov		eax, [ecx]	; CLevel
	mov		ebx, [eax+m_pBulletManager]
	; bullet->m_dwID = g_dwTotalShots++
	mov		eax, [ebx].m_dwTotalShots
	inc		eax
	mov		[esi].m_dwID, eax
	mov		[ebx].m_dwTotalShots, eax
	; bullet->flags.callback_on = cartridge.m_flags.test(CCartridge::cfCallbackOn);
	.if ([edi].m_flags & cfCallbackOn)
		or		[esi].flags, bull_callback_on
		; CObject	*weapon = Level().Objects.net_Find(bullet->weapon_id);
		movzx	ecx, [esi].weapon_id
		Level__Objects_net_Find	 ecx
		.if (eax)
			; weapon->callback(eWeaponStartBullet)(cartridge, bullet);
			CALLBACK__INT_INT	eax, eWeaponStartBullet, edi, esi
		.endif
	.endif
	.if ([edi].m_flags & cfShellExplosive)
		mov		edx, ds:pSettings ; CInifile * pSettings
		push	offset aSect_explosive	; "sect_explosive"
		mov		eax, [edi].m_ammoSect
		add		eax, 12
		push	eax
		mov		ecx, [edx]
		call	ds:r_string
		movzx	edx, [esi].weapon_id
		mov		ecx, ebx
		invoke	CBulletManager@@CreateExplosive, eax, edx
		.if (ax!=0FFFFh)
			;explosive_id = explo_id;
			mov		[esi].explosive_id, ax
			;flags.set(shell_explosive, TRUE);
			or		[esi].flags, shell_explosive
			;	movzx	eax, ax
			;	PRINT_UINT "explosive_id = %d", eax
			;	PRINT_UINT "m_dwID = %d", [esi].m_dwID
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing, ebx:nothing
	jmp		return_SBullet__Init_callback
SBullet__Init_callback endp

; колбек на удаления пули, вызывается в объекте оружия
align_proc
CBulletManager@@UpdateWorkload proc
this_		= dword ptr 8	;CBulletManager
;esi - *bullet
	ASSUME	esi:ptr SBullet
	.if ([esi].flags & bull_callback_on)
		; CObject	*weapon = Level().Objects.net_Find(bullet->weapon_id);
		movzx	ecx, [esi].weapon_id
		Level__Objects_net_Find	 ecx
		.if (eax)
			; weapon->callback(eWeaponStopBullet)(bullet, 0);
			CALLBACK__INT_INT	eax, eWeaponStopBullet, esi, 0
		.endif
	.endif
	.if ([esi].flags & shell_explosive && !([esi].flags & shell_exploding))
		;PRINT_UINT "DeleteExplosive: m_dwID = %d", [esi].m_dwID
		;DeleteExplosive((int)explosive_id);
		mov		ecx, [ebp+this_]
		invoke	CBulletManager@@DeleteExplosive, [esi].explosive_id
	.endif
	ASSUME	esi:nothing
; -----------------	
	; делаем вырезанное
	xorps	xmm0, xmm0
	mov		esi, [ebp+this_]
	jmp		return@CBulletManager@@UpdateWorkload
CBulletManager@@UpdateWorkload endp

; колбек на застревание пули в геометрии или в объекте, вызывается в объекте оружия
align_proc
CBulletManager@@RegisterEventCallback proc
;esi - _event
;this			= dword ptr  4
;Type			= dword ptr	 8
;_dynamic		= dword ptr	 12
;bullet			= dword ptr	 16
;end_point		= dword ptr	 20
;R				= dword ptr	 24
;tgt_material	= dword ptr	 28
	mov		edi, [esp+0B8h+16];bullet
	ASSUME	edi:ptr SBullet
	.if ([edi].flags & bull_callback_on)
		; CObject	*weapon = Level().Objects.net_Find(bullet->weapon_id);
		movzx	ecx, [edi].weapon_id
		Level__Objects_net_Find	 ecx
		.if (eax)
			; weapon->callback(eWeaponStopBullet)(bullet, 0);
			CALLBACK__INT_INT	eax, eWeaponStopBullet, edi, 0
		.endif
	.endif
;	mov		eax, sizeof CActor
;	mov		eax, sizeof CStepManager
;	mov		eax, sizeof associative_vector
;	mov		eax, sizeof DLL_Pure
	.if ([edi].flags & shell_explosive)
		;PRINT_UINT "m_dwID = %d", [edi].m_dwID
		;PRINT_UINT "edi = %X", edi
		;Explode((int)explosive_id, &pos, &dir, (int)parent_id);
		mov		edx, [esp+0B8h+20];end_point
		mov		ecx, [esp+0B8h+4];this
		invoke	CBulletManager@@Explode, [edi].explosive_id, edx, addr [edi].dir, [edi].parent_id
		;flags.set(shell_exploding, TRUE);
		or		[edi].flags, shell_exploding	; 
	.endif
	ASSUME	edi:nothing
	;вырезаное
	mov		eax, [esp+0B8h+8];Type
	jmp		return@CBulletManager@@RegisterEventCallback
CBulletManager@@RegisterEventCallback endp


; загрузка параметра(флага) колбека.
align_proc
CCartridge__Load_callback proc
; esi - *cartridge
	call	CGameMtlLibrary__GetMaterialIt_char_const
	push	ebx
	ASSUME	esi:ptr CCartridge
	; if(pSettings->line_exist(section, "callback_on"))
	mov		eax, ds:pSettings ; CInifile * pSettings
	mov		ebx, [eax]
	push	offset aCallback_on ; "callback_on"
	push	edi
	mov		ecx, ebx
	call	ds:line_exist ; CInifile::line_exist(char const *,char const *) ; 
	.if (eax)
		; m_flags.set(cfCallbackOn, pSettings->r_bool(section, "callback_on"));
		mov		ecx, ebx
		push	offset aCallback_on ; "callback_on"
		push	edi
		call	ds:r_bool		; CInifile::r_bool(char const *,char const *) ; 
		.if (eax)
			or		[esi].m_flags, cfCallbackOn
		.endif
	.endif
	; if(pSettings->line_exist(section, "allow_ricochet"))
	mov		ecx, ebx
	push	offset aAllow_ricochet ; "allow_ricochet"
	push	edi
	call	ds:line_exist ; CInifile::line_exist(char const *,char const *) ; 
	.if (eax)
		; m_flags.set(cfRicochet, pSettings->r_bool(section, "allow_ricochet"));
		mov		ecx, ebx
		push	offset aAllow_ricochet ; "allow_ricochet"
		push	edi
		call	ds:r_bool		; CInifile::r_bool(char const *,char const *) ; 
		.if (!eax)
			and		[esi].m_flags, not(cfRicochet)
		.endif
	.endif
	; m_flags.set(cfShellExplosive, FALSE);
	and		[esi].m_flags, not(cfShellExplosive)
	; if(pSettings->line_exist(section, "sect_explosive"))
	mov		ecx, ebx
	push	offset aSect_explosive	; "sect_explosive"		aShell_explosive ; "shell_explosive"
	push	edi
	call	ds:line_exist ; CInifile::line_exist(char const *,char const *) ; 
	.if (eax)
		; m_flags.set(cfShellExplosive, TRUE);
		or		[esi].m_flags, cfShellExplosive
	.endif
	ASSUME	esi:nothing
	pop		ebx
	jmp		return_CCartridge__Load_callback
CCartridge__Load_callback endp
;=================================================================================
