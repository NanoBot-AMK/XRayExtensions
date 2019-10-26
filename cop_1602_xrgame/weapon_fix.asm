
;=================================================================================
;============================= (c) NanoBot =======================================
;=================================================================================
;========================= for Call of Pripyat 1.6.02 ==================================
eWeaponUpdateAddonsVisibility		= dword ptr 154		;
eWeaponUpdateHUDAddonsVisibility	= dword ptr 155		;
eWeaponOnShoot						= dword ptr 181		; колбек на выстрел
eWeaponStartBullet					= dword ptr 182		; колбек на старт пули
eWeaponStopBullet					= dword ptr 183		; колбек на стоп пули
eWeaponSwitchMode					= dword ptr 184		; колбек на переключения режима огня
eUpdateMissileVisibility			= dword ptr 185		; апдейт видимости кости ракеты РПГ7

m_dwTotalShots	dd 0					; для генератора айдишника пуль.		GLOBAL
aCallback_on	db "callback_on", 0		; название булевого параметра в конфиге патрона для включения колбеков для старта и стопа пули.
aGrenadeAny		db "missile_0", 0

; колбек на выстрел, вызывается в объекте оружия
CWeapon__CallbackOnShoot proc
;--------------------------------
; esi - weapon
iAmmoElapsed				= dword ptr	 0		;1404
m_DefaultCartridge			= dword ptr	 1740	;1472
m_ammoName					= dword ptr	 1712
m_ammoType					= byte	ptr	 1732
m_iCurFireMode				= dword ptr	 1964	;1928
m_vStartPos					= dword ptr	 1924
m_vStartDir					= dword ptr	 1936
; ebx - *cartridge
m_ammoSect					= dword ptr	 4
m_InvShortName				= dword ptr	 60
x							= dword ptr	 0
y							= dword ptr	 4
z							= dword ptr	 8
;--------------------------------
	push	eax
	;========================================
	; callback(eWeaponOnShoot)(m_vStartDir);
	push	0							; int
	push	[esi+m_vStartDir+z]			; 
	push	[esi+m_vStartDir+y]			; 
	push	[esi+m_vStartDir+x]			; 
	push	0
	push	offset eWeaponOnShoot		; константа - тип колбека
	lea		ecx, [esi+232]				; this
	call	CGameObject__callback		; eax = callback
	mov		ecx, eax					; callback
	call	script_callback_float_vector_int	;  
	;========================================
	pop		eax
	; делаем вырезанное
	xor		ebp, ebp
	cmp		[ebx+20h], ebp		; 5 bytes
	jmp		back_from_CWeapon__CallbackOnShoot
CWeapon__CallbackOnShoot endp
;--------------------------------------------------------------------------
CWeapon__Callback_SwitchMode proc
m_iCurFireMode				= dword ptr	 1964	;1928
;	push	ecx
;	push	edx
	pushad
	;========================================
	; callback(eWeaponSwitchMode)();
	inc		edx
	mov		ecx, [esi+m_iCurFireMode]
	inc		ecx
	push	ecx
	push	edx
	push	offset eWeaponSwitchMode		; константа - тип колбека
	mov		ecx, esi					; this
	add		ecx, 232
	call	CGameObject__callback		; eax = callback
	mov		ecx, eax					; callback
	call	script_callback_int_int	 
	;========================================
	popad
;	pop		edx
;	pop		ecx
	; делаем вырезанное
	mov		[esi+m_iCurFireMode], edx		; 6 bytes
	retn
;	jmp		back_from_CWeapon__CallbackOnShoot
CWeapon__Callback_SwitchMode endp

UpdateAddonsVisibility_fix proc
m_flagsAddOnState				= byte	ptr	 460h
	push	ecx
	;========================================
	test	edi, edi
	jz		disable_callback
	; callback(eWeaponUpdateAddonsVisibility)();
	movzx	ecx, byte ptr [edi + m_flagsAddOnState]
	push	0
	push	ecx
	push	offset eWeaponUpdateAddonsVisibility		; константа - тип колбека
	mov		ecx, edi					; this
	add		ecx, 232
	call	CGameObject__callback		; eax = callback
	mov		ecx, eax					; callback
	call	script_callback_int_int	 
disable_callback:
	;========================================
	pop		ecx
	jmp		back_from_UpdateAddonsVisibility_fix
UpdateAddonsVisibility_fix endp

UpdateHUDAddonsVisibility_fix proc
m_flagsAddOnState				= byte	ptr	 460h
	;========================================
	; callback(eWeaponUpdateHUDAddonsVisibility)();
	movzx	ecx, byte ptr [esi + m_flagsAddOnState]
;	PRINT_UINT "UpdateHUDAddonsVisibility_fix = %x", ecx
	test	ecx, 40h
	jz		disable_callback
	push	0
	push	ecx
	push	offset eWeaponUpdateHUDAddonsVisibility		; константа - тип колбека
	mov		ecx, esi					; this
	add		ecx, 232
	call	CGameObject__callback		; eax = callback
	mov		ecx, eax					; callback
	call	script_callback_int_int
disable_callback:
	;========================================
	; делаем вырезанное
	mov		esi, [esi+46Ch]
	jmp		back_from_UpdateHUDAddonsVisibility_fix
UpdateHUDAddonsVisibility_fix endp

Objects_net_Find proc
	mov		eax, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
	mov		eax, [eax]
	mov		eax, [eax+ecx*4+4Ch]
	retn
Objects_net_Find endp

; Возможность стрелять картечью из подствольного гранатомёта.
; 
shotgun_gl proc
rocket_section				= dword ptr	 4
fShotTimeCounter			= dword ptr	 912
m_bFireSingleShot			= byte	ptr	 1949
	call	CRocketLauncher__getRocketCount
	.if		eax == 0
;		CWeaponMagazinedWGrenade::OnShot()
		mov		ecx, esi
		call	CWeaponMagazinedWGrenade__OnShot
;		float	dt = Device.fTimeDelta;
		mov		eax, ds:Device			 ; CRenderDevice Device
		mov		ecx, dword ptr [eax+1Ch]
		push	ecx
;		fShotTimeCounter = -dt
		xorps	xmm0, xmm0
		subss	xmm0, dword ptr [eax+1Ch]
		movss	[esi+fShotTimeCounter], xmm0
;		m_bFireSingleShot = true;
		mov		[esi+m_bFireSingleShot], 1
;		CWeaponMagazined::state_Fire(dt)
		mov		ecx, esi
		call	CWeaponMagazined__state_Fire
;		PRINT_UINT	"CWeaponMagazinedWGrenade__OnShot - %d", eax
		xor		eax, eax
	.endif
	retn
shotgun_gl endp

switshGL_params proc
m_bGrenadeMode				= byte	ptr	 2040
cNameSect					= dword ptr	 404
	push	ecx
	push	edx
	push	ebx
;------------------------
	mov		edx, [esi+cNameSect]
	add		edx, 10h
;	PRINT_UINT "name section - %s", edx
	.if		[esi+m_bGrenadeMode] == 0
		push	edx
		mov		ecx, esi
		call	CShootingObject__LoadFireParams
	.else
		mov		ecx, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [ecx]
		push	offset aGrenade_laun_0		; "grenade_launcher_name"
		push	edx
		call	ds:r_string					; CInifile::r_string(char const *,char const *)
;		PRINT_UINT "grenade_launcher_name - %s", eax
		mov		ebx, eax
		push	ebx
		mov		ecx, esi
		call	CShootingObject__LoadFireParams
;		mov		ecx, esi
;		call	load_param_GL
	.endif
;-------------------------
	pop		ebx
	pop		edx
	pop		ecx
	; делаем что вырезали
	mov		esi, [esp+64h-48h]
	push	ecx
	jmp		back_from_switshGL_params
switshGL_params endp

load_param_GL	proc
iMagazineSize2				= dword ptr	 2024
cNameSect					= dword ptr	 404
;-----------------------------
	push	ecx
	push	edi
	push	ebx
	mov		esi, ecx
	mov		[esi+m_bCanRocketReload], true
	mov		dword ptr [esi+iMagazineSize2], 1
	mov		edi, [esi+cNameSect]
	add		edi, 10h
;	PRINT_UINT "name_section - %s", edi
	push	offset aGrenade_laun_0			; "grenade_launcher_name"
	push	edi
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	.if		eax != 0
		mov		ecx, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [ecx]
		push	offset aGrenade_laun_0		; "grenade_launcher_name"
		push	edi
		call	ds:r_string					; CInifile::r_string(char const *,char const *)
;		PRINT_UINT "grenade_launcher_name - %s", eax
		mov		edi, eax
		push	offset aAmmo_mag_size			; "ammo_mag_size"
		push	edi
		mov		eax, ds:pSettings				; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
		.if		eax != 0
			push	offset aAmmo_mag_size		; "ammo_mag_size"
			push	edi
			mov		eax, ds:pSettings			; CInifile const * const pSettings
			mov		ecx, [eax]
			call	ds:r_u32
;			PRINT_UINT "iMagazineSize2 - %d", eax
			mov		dword ptr [esi+iMagazineSize2], eax
		.endif
	.endif
	pop		ebx
	pop		edi
	pop		ecx
	retn
load_param_GL	endp

m_rockets					= dword ptr	 1976
m_bGrenadeMode				= byte	ptr	 2040
iAmmoElapsed				= dword ptr	 1680
m_magazine					= dword ptr	 1736	; sizeof 12 bytes
m_hud_item_state			= dword ptr	 740
m_ammoType					= byte	ptr	 1732

reload_GL proc
;----------------------------
;	PRINT "CWeaponMagazinedWGrenade::ReloadMagazine()"
	.if		[esi+m_bGrenadeMode] 
;		mov     eax, ds:Device
;		mov     eax, [eax+18h]
;		PRINT_UINT "reload_GL Device.dwFrame - %d", eax
		.if		[esi+m_bCanRocketReload] == true
			mov		[esi+m_bCanRocketReload], false
			mov		ecx, esi
			call	delete_rockets
			.if		[esi+iAmmoElapsed] > 0
				mov		ecx, esi
				call	spawn_rockets
			.endif
		.endif
		pop		esi
		pop		ecx
		retn	; 	выходим из void CWeaponMagazinedWGrenade::ReloadMagazine()
	.endif
	; делаем что вырезали
	cmp		dword ptr [esi+iAmmoElapsed], 0
	jmp		back_from_reload_GL
reload_GL endp

delete_rockets proc
	push	esi
	push	ebx
	push	edx
	xor		ebx, ebx
	mov		esi, ecx
	push	0
	push	offset off_106373E8
	push	offset off_1061842C
	push	0
	push	esi
	call	__RTDynamicCast
	add		esp, 14h
;	PRINT_UINT "CRocketLauncher - %x", eax
	.if		eax != 0
		mov		esi, eax	; esi - CRocketLauncher
		.while	1
			mov		ecx, esi
			call	CRocketLauncher__getCurrentRocket
			.break .if	eax == NULL
		;	if (cur_rock->local())	{
			.break .if	!(dword ptr [eax+0A4h] & 8000000h)
;			PRINT	"rocket DestroyObject"
			CGameObject__DestroyObject eax
		;	dropCurrentRocket();
			mov		ecx, esi
			call	CRocketLauncher__dropCurrentRocket
			inc		ebx
		.endw
	.endif
	mov		eax, ebx
	pop		edx
	pop		ebx
	pop		esi
	retn
delete_rockets endp

spawn_rockets proc
m_ammoSect					= dword ptr	 4	; shared_str
; локальные переменные
local fake_grenade_name:dword, ammo_sect:dword, size_mag:dword
;--------------------------------------
	push	edx
	push	esi
	push	edi
	push	ebx
;------------------------------
	mov		esi, ecx
	mov		ecx, [esi+m_magazine+4]
	sub		ecx, [esi+m_magazine]
	mov		eax, 88888889h
	imul	ecx
	add		edx, ecx
	sar		edx, 5
	mov		ecx, edx
	shr		ecx, 31
	add		ecx, edx
	mov		size_mag, ecx
	;--------
	xor		edi, edi
	inc		edi
	mov		ebx, [esi+m_magazine]
	PRINT_UINT "Rocket count - %d", ecx
	.while	edi <= size_mag
		mov		eax, dword ptr [ebx+m_ammoSect]
		.break .if	eax == null
		add		eax, 10h
		mov		ammo_sect, eax
	;	PRINT_UINT "edi - %d", edi
	;	PRINT_UINT "m_ammoSect - %s", eax
		push	offset aFake_grenade_n			; "fake_grenade_name"
		push	eax
		mov		eax, ds:pSettings				; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:line_exist
		.if		eax
			push	offset aFake_grenade_n			; "fake_grenade_name"
			push	ammo_sect
			mov		eax, ds:pSettings				; CInifile const * const pSettings
			mov		ecx, [eax]
			call	ds:r_string						; CInifile::r_string(char const *,char const *)
		.else
			mov		eax, [esi+NameSection]
			add		eax, 10h
			push	offset aRocket_class			; rocket_class
			push	eax								; rpg7.NameSection
			mov		eax, ds:pSettings				; CInifile const * const pSettings
			mov		ecx, [eax]
			call	ds:r_string
		.endif
	;	PRINT_UINT "fake_grenade_name - %s", eax
		lea		ecx, fake_grenade_name
		push	eax
		call	LPCSTR2shared_str
		lea		eax, [esi+0E8h]
		lea		ecx, fake_grenade_name
		push	eax
		push	ecx
		lea		ecx, [esi+1976]
		call	CRocketLauncher__SpawnRocket
		inc		edi
		add		ebx, sizeof	CCartridge	; 60
	.endw
	mov		eax, edi
;------------------------------
	pop		ebx
	pop		edi
	pop		esi
	pop		edx
	ret
spawn_rockets endp

; Удаляем ракеты при разрядке CWeaponRG6, CWeaponRPG7,  но не CWeaponMagazinedWGrenade.
unload_delete_rockets proc
	; smart_cast__CWeaponMagazinedWGrenade
	push	0
	push	offset off_10636A7C
	push	offset off_1061842C
	push	0
	push	ebp
	call	__RTDynamicCast
	add		esp, 14h
;	PRINT_UINT "smart_cast__CWeaponMagazinedWGrenade - %x", eax
	.if		eax == 0 || [eax+m_bGrenadeMode]
		mov		ecx, ebp
		call	delete_rockets
	.endif
	; делаем что вырезали
	xor		eax, eax
	mov		ecx, [ebp+m_magazine]
	jmp		back_from_unload_delete_rockets
unload_delete_rockets endp

; Реальные ракеты при заряжании. (Ракеты соотвествуют секции fake_grenade_name патрона)	CWeaponRPG7__ReloadMagazine
CWeaponRPG7__RealReloadRockets proc
; esi - CWeaponRPG7
;---------------------------
	.if		[esi+m_bCanRocketReload] == true
		mov		[esi+m_bCanRocketReload], false
		mov		ecx, esi
		call	delete_rockets		; удаляем старые ракеты
		mov		ecx, esi
		call	spawn_rockets		; спавним новые, которые соотвествуют патронам
	.endif
	pop		esi
	pop		ecx
	retn			; выходим из void CWeaponRPG7::ReloadMagazine()
CWeaponRPG7__RealReloadRockets endp
CWeaponRPG7__RealReloadRockets2 proc
; esi - CWeaponRPG7
;---------------------------
	mov		ecx, esi
	call	spawn_rockets
	mov		[esi+m_bBlockRocket], 0				; m_bBlockRocket = false; // Init m_bBlockRocket
;	mov		[esi+m_bHasDifferentFireModes], 1
	pop		esi
	mov		eax, ebx
	pop		ebx
	retn	4		; выходим из BOOL CWeaponRPG7::net_Spawn
CWeaponRPG7__RealReloadRockets2 endp

; колбек на удар ножа, вызывается в объекте ножа
CWeaponKnife__CallbackOnShoot proc
; esi - CWeaponKnife
fCurrentHit					= dword ptr	 1956
x							= dword ptr	 0
y							= dword ptr	 4
z							= dword ptr	 8
pos							= dword ptr	 4
dir							= dword ptr	 8
k_hit						= dword ptr	 0Ch
;--------------------------------
	;========================================
	; callback(eWeaponOnShoot)(fCurrentHit*k_hit, dir, 0);
;	mov		ecx, [esp+4Ch+pos]
;	mov		eax, [ecx+x]
;	PRINT_FLOAT	"pos.x - %f", eax
;	mov		eax, [ecx+y]
;	PRINT_FLOAT	"pos.y - %f", eax
;	mov		eax, [ecx+z]
;	PRINT_FLOAT	"pos.z - %f", eax
	push	0							; int
	mov		ecx, [esp+50h+dir]
	push	[ecx+z]						; vec.z
	push	[ecx+y]						; vec.y
	push	[ecx+x]						; vec.x
	movss	xmm0, [esp+5Ch+k_hit]
	mulss	xmm0, [esi+fCurrentHit]
	push	ecx
	movss	dword ptr [esp], xmm0		; float
	push	offset eWeaponOnShoot		; константа - тип колбека
	lea		ecx, [esi+232]				; this
	call	CGameObject__callback		; eax = callback
	mov		ecx, eax					; callback
	call	script_callback_float_vector_int	;  
	;========================================
	; делаем вырезанное
	mov		ax, [esi+74Ch]		; 7 bytes
	jmp		back_from_CWeaponKnife__CallbackOnShoot
CWeaponKnife__CallbackOnShoot endp

; блокировка автоперезарядки (перезарядка только кнопкой R)
aAutoReload			db "auto_reload", 0

LoadBoolAutoload proc
; esi - CWeaponMagazined
;---------------------------------------
	; делаем вырезанное
	mov		[esi+m_iBaseDispersionedBulletsCount], eax
	;------------
;	m_bAutoReload	= READ_IF_EXISTS(pSettings, r_bool, section, "auto_reload", true);
	mov		[esi+m_bAutoReload], 1
;	lea		eax, [esi+m_bAutoReload]
;	PRINT_UINT "222adress m_bAutoReload - %x", eax
	push	offset aAutoReload			; "auto_reload"
	push	ebx
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	.if		eax != 0
		push	offset aAutoReload			; "auto_reload"
		push	ebx
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_bool
		mov		[esi+m_bAutoReload], al
;		movzx	eax, al
;		PRINT_UINT "m_bAutoReload - %d", eax
	.endif
	jmp		back_from_LoadBoolAutoload
LoadBoolAutoload endp

;BlockedRPG7 proc
;	xor		eax, eax
;	.if		[esi+m_bBlockRocket] == 0
;		call	CRocketLauncher__getRocketCount
;	.endif
;	retn
;BlockedRPG7 endp

aUpdateMissileVis	db "callback_update_missile_vis", 0

Callback_UpdateMissileVisibility proc
	mov		ebx, [edi+cNameSect]
	.if		ebx != 0
		add		ebx, 10h
		push	offset aUpdateMissileVis		; "callback_update_missile_vis"
		push	ebx
		mov		eax, ds:pSettings				; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
		.if		eax != 0
			push	offset aUpdateMissileVis	; "callback_update_missile_vis"
			push	ebx
			mov		eax, ds:pSettings			; CInifile const * const pSettings
			mov		ecx, [eax]
			call	ds:r_bool
			.if		eax != 0
;				PRINT	"XRay Callback_UpdateMissileVisibility"
				push	[edi+m_hud_item_state]	; номер состояния худа оружия
				movzx	eax, [edi+m_ammoType]		; номер типа текущего боеприпаса (от 1)
				inc		eax
				push	eax
				push	offset eUpdateMissileVisibility		; константа - тип колбека	
				lea		ecx, [edi+232]				; this
				call	CGameObject__callback		; eax = callback
				mov		ecx, eax					; callback
				call	script_callback_int_int
				pop		edi
				pop		esi
				pop		ebx
				add		esp, 8
				retn	; выходим из CWeaponRPG7__UpdateMissileVisibility
			.endif
		.endif
	.endif
	; делаем вырезанное
	mov		eax, [edi+iAmmoElapsed]
	jmp		back_from__Callback_UpdateMissileVisibility
Callback_UpdateMissileVisibility endp
; автоогонь у РПГ7
CWeaponRPG7__FireRocket proc
	; делаем вырезанное
	call	CWeapon__FireTrace
	mov		ecx, esi
	call	CWeaponRPG7__RocketLaunch
	jmp		back_from__CWeaponRPG7__FireRocket
CWeaponRPG7__FireRocket endp
; автоогонь у РГ-6
CWeaponRG6__FireTrace proc	; (const Fvector& P, const Fvector& D)
P				= dword ptr	 4
D				= dword ptr	 8
	mov		eax, [esp+D]
	push	esi
	mov		esi, ecx
	mov		ecx, [esp+4+P]
	push	eax
	push	ecx
	mov		ecx, esi
	call	CWeapon__FireTrace
	lea		ecx, [esi+824]
	call	CWeaponRG6__RocketLaunch
	pop		esi
	retn	8
CWeaponRG6__FireTrace endp

; При отсоединении ПГ в основном режиме, разряжаем ПГ.
CWeaponMagazinedWGrenade__Detach_fix proc
	; делаем вырезанное
	mov     [esi+1120], bl
	.if		[esi+m_bGrenadeMode] == false		; если в основном режиме, то перегодим на ПГ.
		; переключаемся на гранатомёт
		mov     ecx, esi
		call    CWeaponMagazinedWGrenade__PerformSwitchGL
	.endif
	jmp		back_from_CWeaponMagazinedWGrenade__Detach_fix
CWeaponMagazinedWGrenade__Detach_fix endp

; для нормальной перезарядки РПГ-7.
CWeaponRPG7__OnAnimationEnd proc
state			= dword ptr 4
	push	esi
	mov		esi, ecx
	push	[esp+4+state]
	mov		[esi+m_bCanRocketReload-2E0h], true
	call	CWeaponMagazined__OnAnimationEnd
	pop		esi
	retn	4
CWeaponRPG7__OnAnimationEnd endp
