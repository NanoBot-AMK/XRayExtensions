
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

m_dwTotalShots 	dd 0					; для генератора айдишника пуль.		GLOBAL
aCallback_on 	db "callback_on", 0		; название булевого параметра в конфиге патрона для включения колбеков для старта и стопа пули.
aGrenadeAny		db "missile_0", 0

; колбек на выстрел, вызывается в объекте оружия
CWeapon__CallbackOnShoot proc
;--------------------------------
; esi - weapon
iAmmoElapsed				= dword ptr	 0		;1404
m_DefaultCartridge			= dword ptr	 1740	;1472
m_ammoName					= dword ptr	 1712
m_ammoType					= dword ptr	 1732
m_iCurFireMode				= dword ptr	 1964	;1928
m_bHasDifferentFireModes	= dword ptr	 1950	; bool (sizeof 1 byte)
m_vStartPos					= dword ptr	 1924
m_vStartDir					= dword ptr	 1936
; ebx - *cartridge
m_ammoSect					= dword ptr	 4
m_InvShortName				= dword ptr	 60
x							= dword ptr	 0
y							= dword ptr	 4
z							= dword ptr	 8
;--------------------------------
;	push	ecx
;	push	edx
	pusha
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
	popa
;	pop		edx
;	pop		ecx
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
	pusha
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
	popa
;	pop		edx
;	pop		ecx
	; делаем вырезанное
	mov		[esi+m_iCurFireMode], edx		; 6 bytes
	retn
;	jmp		back_from_CWeapon__CallbackOnShoot
CWeapon__Callback_SwitchMode endp

UpdateAddonsVisibility_fix proc
m_flagsAddOnState				= dword ptr	 460h
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
m_flagsAddOnState				= dword ptr	 460h
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
m_bFireSingleShot			= dword ptr	 1949
	call	CRocketLauncher__getRocketCount
	test	eax, eax
	jnz		exit
;	CWeaponMagazinedWGrenade::OnShot()
	mov		ecx, esi
	call	CWeaponMagazinedWGrenade__OnShot
;	float	dt = Device.fTimeDelta;
	mov		eax, ds:Device			 ; CRenderDevice Device
	mov		ecx, dword ptr [eax+1Ch]
	push	ecx
;	fShotTimeCounter = -dt
	xorps	xmm0, xmm0
	subss	xmm0, dword ptr [eax+1Ch]
	movss	[esi+fShotTimeCounter], xmm0
;	m_bFireSingleShot = true;
	mov		byte ptr [esi+m_bFireSingleShot], 1
;	CWeaponMagazined::state_Fire(dt)
	mov		ecx, esi
	call	CWeaponMagazined__state_Fire
	PRINT_UINT	"CWeaponMagazinedWGrenade__OnShot - %d", eax
	xor		eax, eax
exit:
	retn
shotgun_gl endp

switshGL_params proc
m_bGrenadeMode				= dword ptr	 2040
cNameSect					= dword ptr	 404
	push	ecx
	push	edx
;------------------------
	mov		edx, [esi+cNameSect]
	test	edx, edx
	jz		lab1
	add		edx, 10h
lab1:
	PRINT_UINT "name section - %s", edx
	movzx	eax, byte ptr [esi+m_bGrenadeMode]
	PRINT_UINT "switshGL_params - %d", eax
	test	eax, eax
	jnz		mode_gl
		push	edx
		mov		ecx, esi
		call	CShootingObject__LoadFireParams
		jmp		exit
mode_gl:
		mov		ecx, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [ecx]
		push	offset aGrenade_laun_0		; "grenade_launcher_name"
		push	edx
		call	ds:r_string					; CInifile::r_string(char const *,char const *)
		PRINT_UINT "grenade_launcher_name - %s", eax
		push	eax
		mov		ecx, esi
		call	CShootingObject__LoadFireParams
exit:
;-------------------------
	pop		edx
	pop		ecx
	; делаем что вырезали
	mov		esi, [esp+64h-48h]
	push	ecx
	jmp		back_from_switshGL_params
switshGL_params endp

m_rockets					= dword ptr	 1976
m_bGrenadeMode				= dword ptr	 2040
iAmmoElapsed				= dword ptr	 1680
m_magazine					= dword ptr	 1736	; sizeof 12 bytes
reload_GL proc
;----------------------------
	push	ecx
	PRINT "CWeaponMagazinedWGrenade::ReloadMagazine()"
	cmp		byte ptr [esi+m_bGrenadeMode], 0
	jz		exit
	mov		ecx, esi
	call	delete_rockets
exit:
	pop		ecx
	; делаем что вырезали
	cmp		dword ptr [esi+690h], 0
	jmp		back_from_reload_GL
reload_GL endp

delete_rockets proc
	
	push	esi
	push	ebx
	push	edx
	xor		ebx, ebx
	mov		esi, ecx
	push    0
	push    offset off_106373E8
	push    offset off_1061842C
	push    0
	push    esi
	call    __RTDynamicCast
	add     esp, 14h
	PRINT_UINT "CRocketLauncher - %x", eax
	test	eax, eax
	jz		exit
	mov		esi, eax	; esi - CRocketLauncher
while_:
;	lea		ecx, [esi+m_rockets]
	mov		ecx, esi
	call	CRocketLauncher__getCurrentRocket
;	if (cur_rock)	
	test	eax, eax
	jz		exit
	PRINT_UINT "rocket CCustomRocket - %x", eax
;	if (cur_rock->local())	{
	test	dword ptr [eax+0A4h], 8000000h
	jz		exit
	PRINT	"rocket DestroyObject"
;	cur_rock->DestroyObject();
	mov		edx, [eax]
	mov		ecx, eax
	mov		eax, [edx+100h]
	call	eax
;	dropCurrentRocket();
;	lea		ecx, [esi+m_rockets]
	mov		ecx, esi
	call	CRocketLauncher__dropCurrentRocket
	inc		ebx
	jmp		while_
exit:	;	};
	mov		eax, ebx
	pop		edx
	pop		ebx
	pop		esi
	retn
delete_rockets endp

spawn_rockets proc
m_ammoSect					= dword ptr	 4	; shared_str
; локальные переменные
size_variables			= dword ptr	4+4	; размер поля локальных переменных
_						= dword ptr	0		; float			sizeof 4 bytes
fake_grenade_name		= dword ptr 4		; shared_str*	sizeof 4 bytes
;--------------------------------------
	sub		esp, size_variables
	push	ebp
	push	edx
	push	esi
	push	edi
	mov		esi, ecx
	mov		ecx, [esi+m_magazine+4]
	sub		ecx, [esi+m_magazine]
	mov		eax, 88888889h
	imul	ecx
	add		edx, ecx
	sar		edx, 5
	mov		ecx, edx
	shr		ecx, 1Fh
	xor		edi, edi
	add		ecx, edx
	jz		exit
	push	ebx
	xor		ebx, ebx
	PRINT_UINT "Numbers - %d", ecx
for_:
	mov		edx, [esi+m_magazine]
	mov		eax, dword ptr [ebx+edx+m_ammoSect]
	test	eax, eax
	jz		lab1
	add		eax, 10h
	PRINT_UINT "Number - %d", edi
	PRINT_UINT "m_ammoSect - %s", eax
lab1:
	;------------------------------
	push	ecx
	push	edx
	push	offset aFake_grenade_n			; "fake_grenade_name"
	push	eax
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:r_string						; CInifile::r_string(char const *,char const *)
;	PRINT_UINT "fake_grenade_name - %s", eax
	lea     ecx, [esp+28+fake_grenade_name]
;	PRINT_UINT "ecx - %x", ecx
	push    eax
	call    LPCSTR2shared_str
	lea     eax, [esi+0E8h]
	lea     ecx, [esp+28+fake_grenade_name]
;	PRINT_UINT "ecx - %x", ecx
	push	eax
	push	ecx
	lea		ecx, [esi+1976]
	call    CRocketLauncher__SpawnRocket
	pop		edx
	pop		ecx
	;------------------------------
	mov		ecx, [esi+m_magazine+4]
	sub		ecx, [esi+m_magazine]
	mov		eax, 88888889h
	imul	ecx
	add		edx, ecx
	sar		edx, 5
	mov		ecx, edx
	shr		ecx, 1Fh
	add		edi, 1
	add		ecx, edx
	add		ebx, 3Ch
	cmp		edi, ecx
	jb		for_
	mov		eax, edi
	pop		ebx
exit:						   
	pop     edi
	pop     esi
	pop		edx
	pop     ebp
	add		esp, size_variables
	retn
spawn_rockets endp

; Удаляем ракеты при разрядке CWeaponRG6, CWeaponRPG7, CWeaponMagazinedWGrenade.
unload_delete_rockets proc
	mov		ecx, ebp
	push	eax
	call	delete_rockets
	pop		eax
	; делаем что вырезали
	mov     ecx, [ebp+6C8h]
	jmp		back_from_unload_delete_rockets
unload_delete_rockets endp

; Реальные ракеты при заряжании. (Ракеты соотвествуют секции fake_grenade_name патрона)	CWeaponRPG7__ReloadMagazine
CWeaponRPG7__RealReloadRockets proc
; esi - CWeaponRPG7
;---------------------------
	mov		ecx, esi
	call	delete_rockets		; удаляем старые ракеты
	mov		ecx, esi
	call	spawn_rockets		; спавним новые, которые соотвествуют патронам
;	pop		ebx
	pop     esi
	pop     ecx
	retn			; выходим из void CWeaponRPG7::ReloadMagazine()
CWeaponRPG7__RealReloadRockets endp
CWeaponRPG7__RealReloadRockets2 proc
; esi - CWeaponRPG7
;---------------------------
	mov		ecx, esi
	call	spawn_rockets
	pop     esi
	mov     eax, ebx
	pop     ebx
	retn    4		; выходим из BOOL CWeaponRPG7::net_Spawn
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
	mov		eax, [ecx+z]
	push	eax							; 
	mov		eax, [ecx+y]
	push	eax							; 
	mov		eax, [ecx+x]
	push	eax							; 
	movss	xmm0, [esp+5Ch+k_hit]
	mulss	xmm0, [esi+fCurrentHit]
	push	ecx
	movss	dword ptr [esp], xmm0
	push	offset eWeaponOnShoot		; константа - тип колбека
	mov		ecx, esi					; this
	add		ecx, 232
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
	mov		[esi+m_iPrefferedFireMode], eax
	;------------
;	m_bAutoReload	= READ_IF_EXISTS(pSettings, r_bool, section, "auto_reload", true);
	mov		byte ptr [esi+m_bAutoReload], 1
	push	offset aAutoReload			; "auto_reload"
	push	ebx
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	test	eax, eax
	jz		exit
		push	offset aAutoReload			; "auto_reload"
		push	ebx
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_bool
		mov		byte ptr [esi+m_bAutoReload], al
exit:
	jmp		back_from_LoadBoolAutoload
LoadBoolAutoload endp

BlockedRPG7 proc
	xor		eax, eax
	cmp		byte ptr [esi+m_bBlockRocket], 1
	jz		exit
	call	CRocketLauncher__getRocketCount
exit:
	retn
BlockedRPG7 endp
