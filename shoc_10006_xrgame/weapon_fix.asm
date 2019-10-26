;====================================================================
;		Оружие
; Колбеки
; Рефакторинг НаноБот
;====================================================================
eWeaponOnShoot		= dword ptr 181		; колбек на выстрел
eWeaponStartBullet	= dword ptr 182		; колбек на старт пули
eWeaponStopBullet	= dword ptr 183		; колбек на стоп пули

static_str	aCallback_on,		"callback_on"		; название булевого параметра в конфиге патрона для включения колбеков для старта и стопа пули.
static_str	aAllow_ricochet,	"allow_ricochet"
static_str	aShell_explosive,	"shell_explosive"
static_str	aSect_explosive,	"sect_explosive"
static_str	aWpn_scope,			"wpn_scope"

eAddonDisabled				= dword ptr 0		;// нельзя присоеденить
eAddonPermanent				= dword ptr 1		;// постоянно подключено по умолчанию
eAddonAttachable			= dword ptr 2		;// можно присоединять

;// текущее состояние аддонов
;enum EWeaponAddonState {
eWeaponAddonScope 				= 1
eWeaponAddonGrenadeLauncher 	= 2
eWeaponAddonSilencer 			= 4
;};

align_proc
UpdateAddonsVisibility_fix proc
	; делаем что хотели сделать
	; вызываем колбек для объекта оружия
	;PRINT_UINT "UpdateAddonsVisibility: %x", eax
	ASSUME	edi:ptr CWeapon
	.if ([edi].m_flagsAddOnState & 040h)
		;PRINT_UINT "UpdateAddonsVisibility_fix object: %x", edi
		lea		eax, [edi].CGameObject@vfptr		;+216 CGameObject <- CWeapon
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
	.if ([edi].m_flagsAddOnState & 040h)
		;PRINT "UpdateHUDAddonsVisibility 1"
		lea		eax, [edi].CGameObject@vfptr		;+216 CGameObject <- CWeapon
		CALLBACK__VOID	eax, 155
	.endif
	ASSUME	edi:nothing
	pop		eax
	; делаем вырезанное
	push	ebx
	push	edi
	push	offset aWpn_scope ; "wpn_scope"
	mov		ecx, esi
	; идём обратно
	jmp		back_from_UpdateHUDAddonsVisibility_fix
UpdateHUDAddonsVisibility_fix endp

;инлайн функция, использовать только в условных блоках .if, .while и т.д.
IsGrenadeLauncherAttached MACRO this_wpn:req
	mov		eax, this_wpn.m_eGrenadeLauncherStatus
	EXITM <((eax==eAddonAttachable && this_wpn.m_flagsAddOnState & eWeaponAddonGrenadeLauncher) || eax==eAddonPermanent)>
ENDM

align_proc
CWeaponMagazinedWGrenade__UseScopeTexture_fix proc
	ASSUME	ecx:ptr CWeaponMagazinedWGrenade
	.if ([ecx].m_flagsAddOnState & 080h || (IsGrenadeLauncherAttached([ecx]) && [ecx].m_bGrenadeMode))
		xor		al, al	; return false
		retn
	.endif
	mov		al, true
	retn
CWeaponMagazinedWGrenade__UseScopeTexture_fix endp

align_proc
CWeapon__UseScopeTexture_fix proc
	; return (m_flagsAddOnState.test(0x80));
	test	[ecx].m_flagsAddOnState, 080h
	setz	al
	retn
	ASSUME	ecx:nothing
CWeapon__UseScopeTexture_fix endp

;=================================================================================
;								(c) NanoBot
;=================================================================================

; колбек на выстрел, вызывается в объекте оружия
align_proc
CShootingObject__FireBulletCallback proc
;esi - CShootingObject
;edi - CGameObject*
cartridge		= dword ptr 10h
	call	random_dir
	smart_cast	CGameObject, CShootingObject, esi
	.if (eax==NULL)	; это CCar	CCarWeapon = CShootingObject
		mov		eax, [esi].CCarWeapon.m_object	; CPhysicsShellHolder = CGameObject
	.endif
	.if (eax && [eax].CGameObject.m_flCallbackKey & eCallbackShoot)
		mov		edi, eax
		smart_cast	CWeaponMagazined, CGameObject, edi
		.if (eax)
			mov		eax, [eax].CWeaponMagazined.m_iCurFireMode	; тип режима огня
			inc		eax
		.endif
		mov		edx, [esp+20h+cartridge]	; секция патрона
		mov		ecx, [edx].CCartridge.m_ammoSect
		add		ecx, 12		; str
		CALLBACK__STR_u16	edi, eWeaponOnShoot, ecx, eax
	.endif
	jmp		return_CShootingObject__FireBulletCallback
CShootingObject__FireBulletCallback endp
;--------------------------------------------------------------------------

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
	; Задать толщину трассера.
	ASSUME	edx:ptr CBulletManager
	; if(pSettings->line_exist(section, "tracer_width"))
	mov		ecx, ebx
	push	offset aTracer_width ; "tracer_width"
	push	edi
	call	ds:line_exist ; CInifile::line_exist(char const *,char const *) ; 
	.if (eax)
		; fTracer_width = pSettings->r_float(section, "tracer_width"));
		mov		ecx, ebx
		push	offset aTracer_width ; "tracer_width"
		push	edi
		call	ds:r_float
		push	eax
		fstp	dword ptr [esp]
		movss	xmm0, dword ptr [esp]
		pop		eax
	.else
		mov		ecx, ds:g_pGameLevel
		mov		eax, [ecx]	; 
		mov		edx, [eax].CLevel.m_pBulletManager
		movss	xmm0, [edx].m_fTracerWidth
	.endif
	float@clamp xmm0, 0.0, 1.0
	mulss_c	xmm0, 255.0
	cvttss2si eax, xmm0
	mov		[esi].m_tracer_width, al
	.if (al==0)
		and		[esi].m_flags, not(cfTracer)
	.endif
	;PRINT_UINT	"CCartridge__Load_callback: this = %X", esi
	;movzx	eax, [esi].m_tracer_width
	;PRINT_UINT	"m_tracer_width = %d", eax
	ASSUME	esi:nothing, edx:nothing
	pop		ebx
	jmp		return_CCartridge__Load_callback
CCartridge__Load_callback endp
;=================================================================================
