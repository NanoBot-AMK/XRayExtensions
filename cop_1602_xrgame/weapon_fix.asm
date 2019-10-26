
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

m_dwTotalShots dd 0						; для генератора айдишника пуль.		GLOBAL
aCallback_on db "callback_on", 0		; название булевого параметра в конфиге патрона для включения колбеков для старта и стопа пули.

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
	mov		ecx, [esi+m_vStartDir+z]
	push	ecx							; 
	mov		ecx, [esi+m_vStartDir+y]
	push	ecx							; 
	mov		ecx, [esi+m_vStartDir+x]
	push	ecx							; 
	push	0
	push	offset eWeaponOnShoot		; константа - тип колбека
	mov		ecx, esi					; this
	add		ecx, 232
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

;reload_GL_2 proc
;	PRINT "CWeaponMagazinedWGrenade::switch2_Reload()"
;	; делаем что вырезали
;	or		word ptr [esi+2F4h], 1
;	jmp		back_from_reload_GL_2
;reload_GL_2 endp

reload_GL proc
m_rockets					= dword ptr	 1976
m_bGrenadeMode				= dword ptr	 2040
iAmmoElapsed				= dword ptr	 1680

	push	ecx
	PRINT "CWeaponMagazinedWGrenade::ReloadMagazine()"
	cmp		byte ptr [esi+m_bGrenadeMode], 0
	jz		exit
;	CCustomRocket		cur_rock = getCurrentRocket()	
	lea     ecx, [esi+m_rockets]
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
;	dropCurrentRocket();	};
	lea     ecx, [esi+m_rockets]
	call    CRocketLauncher__dropCurrentRocket
exit:
	pop		ecx
	; делаем что вырезали
	cmp		dword ptr [esi+690h], 0
	jmp		back_from_reload_GL
reload_GL endp
