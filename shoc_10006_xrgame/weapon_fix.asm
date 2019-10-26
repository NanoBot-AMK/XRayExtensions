;====================================================================
;		Оружие
; Колбеки
; Рефакторинг НаноБот
;====================================================================

const_static_str	aCallback_on,		"callback_on" ; название булевого параметра в конфиге патрона для включения колбеков для старта и стопа пули.
const_static_str	aAllow_ricochet,	"allow_ricochet"
const_static_str	aShell_explosive,	"shell_explosive"
const_static_str	aSect_explosive,	"sect_explosive"
const_static_str	aWpn_scope,			"wpn_scope"

eAddonDisabled				= dword ptr 0		;// нельзя присоеденить
eAddonPermanent				= dword ptr 1		;// постоянно подключено по умолчанию
eAddonAttachable			= dword ptr 2		;// можно присоединять

;// текущее состояние аддонов
;enum EWeaponAddonState {
eWeaponAddonScope				= 1
eWeaponAddonGrenadeLauncher		= 2
eWeaponAddonSilencer			= 4
;};

align_proc
UpdateAddonsVisibility_fix proc
	; делаем что хотели сделать
	; вызываем колбек для объекта оружия
	;PRINT_UINT "UpdateAddonsVisibility: %x", eax
	ASSUME	edi:ptr CWeapon
	.if ([edi].m_flagsAddOnState & 040h)
		;PRINT_UINT "UpdateAddonsVisibility_fix object: %x", edi
		CALLBACK__VOID	&[edi].CGameObject@vfptr, eUpdateAddonsVisibility
	.endif
	;вырезанное
	mov		ecx, esi
	call	ds:CKinematics__CalculateBones_Invalidate
	mov		eax, [esi]
	mov		edx, [eax+40h]
	push	0
	mov		ecx, esi
	call	edx
	pop		esi
	pop		ebp
	pop		ebx
	retn
UpdateAddonsVisibility_fix endp

align_proc
UpdateHUDAddonsVisibility_fix proc
	;PRINT_UINT "UpdateHUDAddonsVisibility: %x", eax
	.if ([edi].m_flagsAddOnState & 040h)
		;PRINT "UpdateHUDAddonsVisibility 1"
		CALLBACK__VOID	&[edi].CGameObject@vfptr, eUpdateHudAddonsVisibility
	.endif
	ASSUME	edi:nothing
	;вырезанное
	push	ebx
	push	edi
	push	offset aWpn_scope ; "wpn_scope"
	mov		ecx, esi
	jmp		return_UpdateHUDAddonsVisibility_fix
UpdateHUDAddonsVisibility_fix endp

align_proc
CWeaponMagazinedWGrenade__UseScopeTexture_fix proc
	ASSUME	ecx:ptr CWeaponMagazinedWGrenade
	.if ([ecx].m_flagsAddOnState & 080h || (IsGrenadeLauncherAttached([ecx]) && [ecx].m_bGrenadeMode && ![ecx].m_bCanScopeGrnMode))
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
;cartridge		= dword ptr 10h
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
		mov		edx, [esp+20h+10h];cartridge	; секция патрона
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
;this			= dword ptr	 4
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
		;printf("m_dwID = %d, edi = %X", [edi].m_dwID, edi)
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
	;m_flags.set(cfFakeGrenade, pSettings->line_exist(section, "fake_grenade_name"));
	and		[esi].m_flags, not(cfFakeGrenade)	; m_flags.set(cfFakeGrenade, FALSE);
	push	offset aFake_grenade_n		; "fake_grenade_name"
	push	edi
	mov		ecx, ebx
	call	ds:line_exist		; CInifile::line_exist(char const *,char const *);
	.if (eax)
		or		[esi].m_flags, cfFakeGrenade	; m_flags.set(cfFakeGrenade, TRUE);
	.endif
	;PRINT_UINT	"CCartridge__Load_callback: this = %X", esi
	;movzx	eax, [esi].m_tracer_width
	;PRINT_UINT	"m_tracer_width = %d", eax
	ASSUME	esi:nothing, edx:nothing
	pop		ebx
	jmp		return_CCartridge__Load_callback
CCartridge__Load_callback endp
;=================================================================================

include weapon_RPG7_fix.asm
include weapon_RG6_fix.asm
include weapon_RL_fix.asm

align_proc
CWeapon@@FireTrace_fix proc uses esi ebx P:ptr Fvector, D:ptr Fvector
local pos_start:Fvector4, dir_start:Fvector4
;edi	this CWeapon*
	smart_cast	CRocketLauncher, CWeapon, edi
	.if (eax)
		mov		ecx, eax
		mov		edx, P
		movups	xmm0, [edx].Fvector4
		movups	pos_start, xmm0
		and		pos_start.w, 0
		mov		edx, D
		movups	xmm0, [edx].Fvector4
		movups	dir_start, xmm0
		and		dir_start.w, 0
		CRocketLauncher@@FireTraceRocket(ecx, &pos_start, &dir_start)
		CWeapon@@FireTrace(&pos_start, &dir_start)
	.else
		CWeapon@@FireTrace(P, D)	;CWeapon *this@<edi>
	.endif
	ret
CWeapon@@FireTrace_fix endp
;----------------------------------------------------------------------

;BOOL	CWeaponShotgun::net_Spawn(CSE_Abstract* DC)
;{
;	BOOL	res = inherited::net_Spawn(DC);
;	CSE_ALifeItemWeaponShotGun*		E = smart_cast<CSE_ALifeItemWeaponShotGun*>(DC);
;	u32	ammoCount = E->m_AmmoIDs.size();
;	for (u32 i=0; i<ammoCount; ++i){
;		u8	ammoType = E->m_AmmoIDs[i];
;		m_magazine[i].m_flags.zero();
;		m_magazine[i].Load(*m_ammoTypes[ammoType], m_ammoType);
;	}
;	return res;
;}
align_proc
CWeaponShotgun@@net_Spawn proc uses esi edi ebx DC:ptr CSE_Abstract
local res:dword, E:dword
;ecx	this	CWeapon
	ASSUME	edi:ptr CWeapon, esi:ptr CSE_ALifeItemWeaponShotGun
	mov		edi, ecx
	mov		esi, DC
	CWeapon@@net_Spawn(esi)
	.if (eax)
		mov		res, eax
		mov		ebx, [esi].m_AmmoIDs._Myfirst
		mrm		E, [esi].m_AmmoIDs._Mylast
		ASSUME	esi:ptr CCartridge, ebx:ptr byte
		.for (esi=[edi].m_magazine._Myfirst, edi=[edi].m_ammoTypes._Myfirst: ebx!=E: ebx++, esi+=size CCartridge)
			mov		[esi].m_flags, 0	;cartidge.m_flags.zero();
			movzx	edx, [ebx]			;u8 ammoType = E->m_AmmoIDs[i];
			mov		ecx, [edi+edx*4]
			CCartridge@@Load(esi, &[ecx].str_value.value, edx)
		.endfor
		mov		eax, res
	.endif
	ASSUME	esi:nothing, edi:nothing, ebx:nothing
	ret
CWeaponShotgun@@net_Spawn endp
;----------------------------------------------------------------------
;Пули и ракеты вылетают из дула.
align_proc
CActor@@g_fireParamsWeapon proc uses esi edi ebx pHudItem:ptr CHudItem, pFire_pos:ptr Fvector, pFire_dir:ptr Fvector
local max_range:real4, cam_active:dword, min_range:real4, dist_back:real4
local fire_pos:Fvector4, fire_dir:Fvector4, cam_pos:Fvector4
	mov		edi, ecx
	mov		eax, pHudItem
	dynamic_cast	CWeaponMagazined, CInventoryItem, [eax].CHudItem.CHudItem@m_item
	.if (eax)
		mov		esi, eax	;CWeaponMagazined
		mrm		cam_active, [edi].CActor.cam_active
		mov		ebx, pFire_pos
		mov		edi, pFire_dir
		ASSUME	edi:ptr Fvector, ebx:ptr Fvector, esi:ptr CWeapon
		mov		ecx, CWeapon@@get_LastFP()
		Fvector_set	fire_pos, [ecx].Fvector
		and		fire_pos.w, 0
		and		fire_dir.w, 0
		.if (cam_active==eacFreeLook)
			mov		ecx, CWeapon@@get_LastFD()
			Fvector_set	fire_dir, [ecx].Fvector
			movflt	dist_back, -0.5
			;fire_pos.mad(fire_dir, dist_back-vLoadedFirePoint.z);	//для того чтобы пули не летели через стену.
			movss	xmm1, dist_back
			subss	xmm1, [esi].vLoadedFirePoint.z
			movups	xmm2, fire_pos
			movups	xmm0, fire_dir
			shufps	xmm1, xmm1, 0
			mulps	xmm0, xmm1
			addps	xmm2, xmm0
			movups	fire_pos, xmm2
		.else
			mov		min_range, 0.5	;минимальная дист. до цели от камеры
			mov		max_range, 2.0	;= 2.5-0.5
			mov		ecx, ds:Device
			Fvector_set	fire_dir, [ecx].CRenderDevice.vCameraDirection
			Fvector_set	cam_pos, [ecx].CRenderDevice.vCameraPosition
			and		cam_pos.w, 0
			;dist = HUD().GetCurrentRayQuery().range;
			call	CCustomHUD__GetRQ
			movss	xmm2, [eax].collide__rq_result.range
			movss	xmm3, xmm2
			subss	xmm3, min_range	;range = dist - 0.5f;
			.if (xmm3<max_range)	;при близких дистанциях до цели, точку вылета пуль, плавно перемещаем в позицию камеры.
				;fire_pos:add(cam_pos, vec:sub(cam_pos, fire_pos):mul(range/max_range))
				divss	xmm3, max_range
				shufps	xmm3, xmm3, 0
				movups	xmm1, cam_pos
				movups	xmm0, fire_pos
				subps	xmm1, xmm0
				mulps	xmm1, xmm3
				movups	xmm0, cam_pos
				addps	xmm0, xmm1
				movups	fire_pos, xmm0
			.endif
			;Fvector	pos;
			;pos.mad(cam_pos, fire_dir, dist);	//точка куда стреляем
			;fire_dir.sub(pos, fire_pos).normalize();
			shufps	xmm2, xmm2, 0
			movups	xmm0, fire_dir
			mulps	xmm0, xmm2
			movups	xmm1, cam_pos
			addps	xmm0, xmm1
			movups	xmm1, fire_pos
			subps	xmm0, xmm1
			Fvector4@normalize	xmm0
			movups	fire_dir, xmm0
		.endif
		Fvector_set	[ebx], fire_pos
		Fvector_set	[edi], fire_dir
		ASSUME	edi:nothing, ebx:nothing
	.endif
	ret
CActor@@g_fireParamsWeapon endp

align_proc
CActor@@g_fireParams_fix proc
;esi	this		CActor*
;edi	fire_pos	Fvector*
	mov     eax, [esp+8+4];pHudItem
	mov		edx, [esp+8+12];fire_dir
	mov		ecx, esi
	CActor@@g_fireParamsWeapon(eax, edi, edx)
;---------------------
	pop		edi
	pop		esi
	retn	12
CActor@@g_fireParams_fix endp

;====================================================================
const_static_str	eAuto_reload, "auto_reload"
align_proc
CWeaponMagazined@@Load_fix proc
;edi	this	CWeaponMagazined*
	ASSUME	edi:ptr CWeaponMagazined
	mov		esi, [esp+2Ch+4];section
	mov		[edi].m_bAutoReload, true
	mov		ebx, offset eAuto_reload	;"auto_reload"
	.if (@LINE_EXIST(esi, ebx))
		mov		[edi].m_bAutoReload, @R_BOOL(esi, ebx)
	.endif
	.if (![edi].m_bHasDifferentFireModes)
		and		[edi].m_iCurFireMode, 0
	.endif
;	printf("section='%s' m_bHasDifferentFireModes=%d, m_iCurFireMode=%d", esi, [edi].m_bHasDifferentFireModes, [edi].m_iCurFireMode)
	ASSUME	edi:nothing
;---------------------
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	add		esp, 1Ch
	retn	4
CWeaponMagazined@@Load_fix endp

align_proc
CWeaponMagazined@@FireEnd_fix proc
;edi	this	CWeaponMagazined*
	mov		eax, [edi]
	mov		edx, [eax+178h]
	mov		ecx, edi
	pop		edi
	pop		esi
	jmp		edx		;Reload();
CWeaponMagazined@@FireEnd_fix endp

align_proc
CWeaponMagazined@@SetQueueSize_fix proc
;ecx	this	CWeaponMagazined
;eax	size	int
	push	edi
	ASSUME	edi:ptr CWeaponMagazined
	mov		edi, ecx
	.if (sdword ptr eax<WEAPON_ININITE_QUEUE)
		mov		eax, WEAPON_ININITE_QUEUE
	.endif
	xor		ecx, ecx	;i=0
	mov		edx, 1		;size_queue=1
	.if ([edi].m_bHasDifferentFireModes)
		push	esi
		.for (esi=[edi].m_aFireModes._Myfirst: esi!=[edi].m_aFireModes._Mylast: esi+=4, ecx++)
			mov		edx, [esi]	;m_aFireModes[i];
			.if ((eax<=edx && eax>=0) || edx==WEAPON_ININITE_QUEUE)
				mov		edx, eax		;размер очереди может быть меньше или равным указаным в fire_modes
				.break
			.endif
		.endfor
		pop		esi
	.endif
	mov		[edi].m_iCurFireMode, ecx	;=i
	mov		[edi].m_iQueueSize, edx
	mov		ecx, edi
	pop		edi
	.if (eax==0 && edx)			;вероятно блокировка оружия
		retn	4
	.endif
	mov		eax, edx
	ASSUME	edi:nothing
	jmp		return_CWeaponMagazined@@SetQueueSize_fix
CWeaponMagazined@@SetQueueSize_fix endp
