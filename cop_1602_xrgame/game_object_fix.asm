include game_object_reg_macro.asm

;ALIGN_8
game_object_fix proc
; делаем то, что вырезали 
	call	register__bool__void
; добавл€ем своЄ
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsGameObject,			"is_game_object"
	PERFORM_EXPORT_UINT__VOID			CScriptGameObject__GetGameObject,			"cast_game_object"
	PERFORM_EXPORT_UINT__VOID			CScriptGameObject__CCar,					"cast_car"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsCar,					"is_car"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsHelicopter,			"is_helicopter"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsHolder,				"is_holder"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsEntityAlive,			"is_entity_alive"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsInventoryItem,			"is_inventory_item"
	PERFORM_EXPORT_UINT__VOID			CScriptGameObject__CInventoryItem,			"cast_inventory_item"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsInventoryOwner,		"is_inventory_owner"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActor,					"is_actor"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsCustomMonster,			"is_custom_monster"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeapon,				"is_weapon"
	PERFORM_EXPORT_UINT__VOID			CScriptGameObject__CWeapon,					"cast_weapon"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponGL,				"is_weapon_gl"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsInventoryBox,			"is_inventory_box"
	PERFORM_EXPORT_UINT__VOID			CScriptGameObject__CInventoryBox,			"cast_inventory_box"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsMedkit,				"is_medkit"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsEatableItem,			"is_eatable_item"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsAntirad,				"is_antirad"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsOutfit,				"is_outfit"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsScope,					"is_scope"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsSilencer,				"is_silencer"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsGrenadeLauncher,		"is_grenade_launcher"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponMagazined,		"is_weapon_magazined"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsSpaceRestrictor,		"is_space_restrictor"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsStalker,				"is_stalker"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsCustomZone,			"is_anomaly"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsBaseMonster,			"is_monster"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsExplosive,				"is_explosive"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsScriptZone,			"is_script_zone"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsProjector,				"is_projector"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsTrader,				"is_trader"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsHudItem,				"is_hud_item"
	PERFORM_EXPORT_UINT__VOID			CScriptGameObject__CHudItem,				"cast_hud_item"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsFoodItem,				"is_food_item"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsArtefact,				"is_artefact"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsAmmo,					"is_ammo"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsMissile,				"is_missile"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsPhysicsShellHolder,	"is_physics_shell_holder"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsGrenade,				"is_grenade"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsBottleItem,			"is_bottle_item"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsHangingLamp,			"is_hanging_lamp"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponKnife,			"is_knife"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponBinoculars,		"is_binoculars"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponPistol,			"is_weapon_pistol"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponShotgun,			"is_weapon_shotgun"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponAutoShotgun,		"is_weapon_autoshotgun"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponRPG7,			"is_weapon_rpg7"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsWeaponRG6,				"is_weapon_rg6"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsRocketLauncher,		"is_rocket_launcher"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsCrow,					"is_crow"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsExploded,				"is_exploded"	; взрывной объект взорван? 
	PERFORM_EXPORT_FLOAT__VOID			CScriptGameObject__ObjectLuminocity,		"object_luminocity"
	; ACTOR STATES
	; методы дл€ оценки состо€ни€ актора
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorNormal,				"is_actor_normal"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorCrouch,				"is_actor_crouch"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorCreep,				"is_actor_creep"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorClimb,				"is_actor_climb"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorWalking,				"is_actor_walking"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorRunning,				"is_actor_running"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorSprinting,			"is_actor_sprinting"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorCrouching,			"is_actor_crouching"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorCreeping,				"is_actor_creeping"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsActorClimbing,				"is_actor_climbing"
	;
	PERFORM_EXPORT_UINT__VOID			CScriptGameObject__CurrentFireMode,				"get_fire_mode"
	PERFORM_EXPORT_STRING__VOID			CScriptGameObject__DefaultAmmo,					"get_default_ammo_type"
	PERFORM_EXPORT_STRING__VOID			CScriptGameObject__GetAmmo,						"get_ammo_type"
	PERFORM_EXPORT_FLOAT__VOID			CScriptGameObject__GetRPM,						"get_rpm"
	PERFORM_EXPORT_VOID__FLOAT			CScriptGameObject__SetRPM,						"set_rpm"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__IsGrenadeMode,				"is_grenade_mode"
	;
	PERFORM_EXPORT_VOID__STRING_BOOL	CScriptGameObject__SetObjectBoneVisible,		"set_obj_bone_visible"
	PERFORM_EXPORT_BOOL__STRING			CScriptGameObject__GetObjectBoneVisible,		"get_obj_bone_visible"
	PERFORM_EXPORT_VOID__STRING_BOOL	CScriptGameObject__SetHUDObjectBoneVisible,		"set_hud_obj_bone_visible"
	PERFORM_EXPORT_BOOL__VOID			CScriptGameObject__GetHUDmode,					"get_hud_mode"
	PERFORM_EXPORT_VOID__BOOL			CScriptGameObject__BlockedRocket,				"blocked_rocket_rpg"
	PERFORM_EXPORT_BOOL__GO				CScriptGameObject__DirectVisibility,			"direct_visibility"
	; ƒл€ биорадара на классе CEliteDetector
	PERFORM_EXPORT_BOOL__VOID						CScriptGameObject__DetectorClear,		"detector_clear"
	PERFORM_EXPORT__VOID__GO_STRING_VECTOR_FLOAT	CScriptGameObject__DetectorDrawObject,	"detector_draw_object"
	; сопротивлени€ воздуха у физ. объектов.
	PERFORM_EXPORT__VOID__FLOAT_FLOAT	CScriptGameObject__SetAirResistance,			"set_air_resistance"
	PERFORM_EXPORT_FLOAT__VOID			CScriptGameObject__GetAirResLinear,				"get_air_res_linear"
	PERFORM_EXPORT_FLOAT__VOID			CScriptGameObject__GetAirResAngular,			"get_air_res_angular"
	; ƒл€ подствольника
	PERFORM_EXPORT_VOID__BOOL			CScriptGameObject__SetGrenadeMode,				"set_grenade_mode"
	; идЄм обратно
	jmp		back_from_game_object_fix
game_object_fix endp

;---===Nanobot===---
m_explosion_flags		= byte ptr 08Ch

CScriptGameObject__IsExploded proc
;	push	esi
	;---------------
;	mov		esi, [ecx+4]	; m_object
	call	CScriptGameObject__CExplosive
	.if		eax != 0		; no Explosive
		movzx	eax, [eax+m_explosion_flags]	; eax = m_explosion_flags
		and		eax, 1						; eax = m_explosion_flags.flExploding
	.endif
	;---------------
;	pop		esi
	retn
CScriptGameObject__IsExploded endp

CScriptGameObject__ObjectLuminocity proc
	push	edi
	mov		edi, [ecx+4]			; CGameObject edi
;	CEntityAlive *entity_alive = smart_cast<CEntityAlive*>(&object());	
	push	edi
	call	smart_cast_CEntityAlive
	add		esp, 4
	.if		eax != 0
;		float	luminocity = object()->ROS()->get_luminocity();
		mov		ecx, edi
		call	ds:ROS					; CObject::ROS(void)
		mov		edx, [eax]
		mov		ecx, eax
		mov		eax, [edx+4]
		call	eax						; st = luminocity = get_luminocity()
	.else
		fldz
	.endif
	pop		edi
	retn
CScriptGameObject__ObjectLuminocity endp

; ACTOR STATES
mstate_real		= dword ptr 1424	; дл€ актора
; актор стоит
CScriptGameObject__IsActorNormal proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 0 || eax == 32 || eax == 64 || eax == 96
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorNormal endp

; актор в прис€де
CScriptGameObject__IsActorCrouch proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 16 || eax == 80
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorCrouch endp

; актор в полном прис€де
CScriptGameObject__IsActorCreep proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 48 || eax == 112
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorCreep endp

; актор на лестнице
CScriptGameObject__IsActorClimb proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 2048 || eax == 2080 || eax == 2112 || eax == 2144
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorClimb endp

; актор идет
CScriptGameObject__IsActorWalking proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 33 || eax == 34 || eax == 36 || eax == 38 || eax == 40 || eax == 42 || eax == 37 || eax == 41
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorWalking endp

; актор идет быстрым шагом
CScriptGameObject__IsActorRunning proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 1 || eax == 2 || eax == 4 || eax == 8 || eax == 5 || eax == 9 || eax == 6 || eax == 10
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorRunning endp

; актор бежит
CScriptGameObject__IsActorSprinting proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 4097 || eax == 4096
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorSprinting endp

; актор идет в прис€де
CScriptGameObject__IsActorCrouching proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 17 || eax == 18 || eax == 20 || eax == 24 || eax == 21 || eax == 26 || eax == 22 || eax == 25
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorCrouching endp

; актор идет в полном прис€де
CScriptGameObject__IsActorCreeping proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 49 || eax == 50 || eax == 52 || eax == 56 || eax == 54 || eax == 58 || eax == 53 || eax == 57
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorCreeping endp

; актор лезет по лестнице
CScriptGameObject__IsActorClimbing proc
	call	CScriptGameObject__CActor
	.if		eax != 0
		mov		eax, [eax+mstate_real]
		.if		eax == 2049 || eax == 2050 || eax == 2057 || eax == 2053 || eax == 2054 || eax == 2058 || eax == 2081 || eax == 2082 || eax == 2086 || eax == 2090
			mov		eax, 1
		.else
			xor		eax, eax
		.endif
	.endif
	ret
CScriptGameObject__IsActorClimbing endp

; class CWeaponMagazined
m_DefaultCartridge			= dword ptr	 1748
m_magazine					= dword ptr	 1736
m_iCurFireMode				= dword ptr	 1964
m_bHasDifferentFireModes	= byte  ptr	 1950	; bool (sizeof 1 byte)
fOneShotTime				= dword ptr	 860
m_bGrenadeMode				= byte  ptr	 2040
m_magazine2					= dword ptr	 2028
m_DefaultCartridge2			= dword ptr	 2044
; class CCartridge
m_ammoSect					= dword ptr	 4
sizeof_CCartridge			= dword ptr	 60

CScriptGameObject__CurrentFireMode proc
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
		push	eax
		call	smart_cast_CWeaponMagazined
		add		esp, 4
		.if		eax != 0
			mov		ecx, eax
			xor		eax, eax
			.if		[ecx+m_bHasDifferentFireModes] != 0
				mov		eax, [ecx+m_iCurFireMode]	; тип режима огн€
			.endif
			inc		eax
		.endif
	.endif
	retn
CScriptGameObject__CurrentFireMode endp

CScriptGameObject__DefaultAmmo proc
	push	ecx
	push	ebx
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
		push	eax
		call	smart_cast_CWeaponMagazined
		add		esp, 4
		.if		eax != 0
			mov		eax, [eax+m_DefaultCartridge+m_ammoSect]		; секци€ патрона
			.if		eax != 0
				add		eax, 10h
			.endif
		.endif
	.endif
	pop		ebx
	pop		ecx
	retn
CScriptGameObject__DefaultAmmo endp

CScriptGameObject__GetAmmo proc
	push	ecx
	push	ebx
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
		push	eax
		call	smart_cast_CWeaponMagazined
		add		esp, 4
		.if		eax != 0
			mov		ecx, [eax+m_magazine+4]
			sub		ecx, sizeof_CCartridge
			mov		eax, [ecx+m_ammoSect]		; секци€ патрона
			.if		eax != 0
				add		eax, 10h
			.endif
		.endif
	.endif
	pop		ebx
	pop		ecx
	retn
CScriptGameObject__GetAmmo endp

CScriptGameObject__GetRPM proc
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
;		push	eax
;		call	smart_cast_CWeaponMagazined
;		add		esp, 4
;		test	eax, eax
;		jz		exit_fail
		fld		dword ptr [eax+fOneShotTime]
		fdivr	ds:float_60
		retn
	.endif
	fldz
	retn
CScriptGameObject__GetRPM endp

CScriptGameObject__SetRPM proc	rpm:dword
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
;		push	eax
;		call	smart_cast_CWeaponMagazined
;		add		esp, 4
;		test	eax, eax
;		jz		exit_fail
		movss	xmm0, ds:float_60
		divss	xmm0, rpm
		movss	dword ptr [eax+fOneShotTime], xmm0
	.endif
	ret		4
CScriptGameObject__SetRPM endp

CScriptGameObject__IsGrenadeMode proc
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
		push	eax
		call	smart_cast_CWeaponMagazined
		add		esp, 4
		.if		eax != 0
			SMARTCAST_CWeaponMagazinedWGrenade
			.if		eax != 0
				movzx	eax, byte ptr [eax + m_bGrenadeMode]
			.endif
		.endif
	.endif
	retn
CScriptGameObject__IsGrenadeMode endp

CScriptGameObject__SetObjectBoneVisible proc	bone_name:dword, visible:byte
	push	esi
	push	ebx
;-----------------------------------------
	mov		eax, [ecx+4]
;	visual = object().Visual()
	mov		eax, [eax+90h]
	.if		eax != 0
;		IKinematics* pWeaponVisual = smart_cast<IKinematics*>(visual);
		push	eax
		call	smart_cast_IKinematics
		add		esp, 4
		.if		eax != 0
			mov		esi, eax			; esi = pWeaponVisual
			IKinematics__CalculateBones_Invalidate 	esi
			IKinematics__LL_BoneID 	esi, bone_name
			movzx	ebx, ax			; ebx = bone_id
			.if		bx != 0FFFFh
				movzx	eax, visible
				IKinematics__LL_SetBoneVisible 	esi, ebx, eax, 1
				IKinematics__CalculateBones_Invalidate 	esi
				IKinematics__CalculateBones esi, 1
			.endif
		.endif
	.endif
;-----------------------------------------
	pop		ebx
	pop		esi
	ret		8
CScriptGameObject__SetObjectBoneVisible endp

CScriptGameObject__GetObjectBoneVisible proc	bone_name:dword
	push	esi
	push	ebx
;-----------------------------------------
	mov		eax, [ecx+4]
;	visual = object().Visual()
	mov		eax, [eax+90h]		; eax = visual
	.if		eax != 0
;		IKinematics* pWeaponVisual = smart_cast<IKinematics*>(visual);
		push	eax
		call	smart_cast_IKinematics
		add		esp, 4
		.if		eax != 0	;		if (!pWeaponVisual) return
			mov		esi, eax			; esi = pWeaponVisual
			IKinematics__LL_BoneID 	esi, bone_name
			movzx	ebx, ax			; ebx = bone_id
			.if		bx != 0FFFFh
				IKinematics__LL_GetBoneVisible	esi, ebx
			.endif
		.endif
	.endif
;-----------------------------------------
	pop		ebx
	pop		esi
	ret		4
CScriptGameObject__GetObjectBoneVisible endp

CScriptGameObject__SetHUDObjectBoneVisible proc	bone_name:dword, visible:byte
; локальные переменные
local _name:dword			; shared_str*	sizeof 4 bytes
;--------------------------------------
	push	esi
	push	edi
	push	ebx
;-----------------------------------------
	mov		edi, [ecx+4]
;	visual = object().Visual()
	mov		esi, [edi+90h]		; esi = visual
	.if		esi != 0
		lea		ecx, [edi+1F8h]
		call	CHudItem__GetHUDmode
		.if		eax != 0
;		IKinematics* pWeaponVisual = smart_cast<IKinematics*>(visual);
			push	esi
			call	smart_cast_IKinematics
			add		esp, 4
			.if		eax != 0	;		if (!pWeaponVisual) return
				mov		esi, eax			; esi = pWeaponVisual
				IKinematics__LL_BoneID 	esi, bone_name
				.if		ax != 0FFFFh	; ax = bone_id
					lea		esi, [edi+1F8h]
					mov		ecx, esi
					call	CHudItem__HudItemData
					.if		eax != 0
						mov		eax, ds:str_container__g_pStringContainer	; str_container * g_pStringContainer
						mov		ecx, [eax]
						push	bone_name
						call	ds:str_container__dock						; str_container::dock(char const *)
						.if		eax != 0
							add		dword ptr [eax], -1
							push	1
							movzx	ecx, visible
							push	ecx
							lea		ecx, _name
							push	ecx
							mov		_name, eax
							mov		ecx, esi
							call    CHudItem__HudItemData
							mov     ecx, eax
							call    attachable_hud_item__set_bone_visible
						.endif
					.endif
				.endif
			.endif
		.endif
	.endif
;-----------------------------------------
	pop		ebx
	pop		edi
	pop		esi
	ret		8
CScriptGameObject__SetHUDObjectBoneVisible endp

CScriptGameObject__GetHUDmode proc
	mov		eax, [ecx+4]
;	return GetHUDmode();
	lea		ecx, [eax+1F8h]
	call	CHudItem__GetHUDmode
	retn
CScriptGameObject__GetHUDmode endp


CScriptGameObject__BlockedRocket proc	blocked:byte
	push	esi
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
		push	eax
		call	smart_cast_CWeaponMagazined
		add		esp, 4
		.if		eax != 0
			mov		esi, eax
			SMARTCAST_CWeaponRPG7
			.if		eax != 0
				mov		al, blocked
				mov		[esi+m_bBlockRocket], al
			.endif
		.endif
	.endif
	pop		esi
	ret		4
CScriptGameObject__BlockedRocket endp

CScriptGameObject__DirectVisibility proc	obj_vis:dword
; свободны - eax, ecx, edx
	push	esi
	push	edi
	push	ebx
;------------------------------
	mov		eax, [ecx+4]
	mov		ebx, obj_vis
	.if		ebx != 0
		mov		ebx, [ebx+4]
		.if		ebx != 0
			
		.endif
	.endif
;------------------------------
	pop		ebx
	pop		edi
	pop		esi
	ret		4
CScriptGameObject__DirectVisibility endp
	
CScriptGameObject__DetectorClear proc
	push	esi
	push	edi
;------------------------------
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CInventoryItem
	add		esp, 4
	.if		eax != 0
		SMARTCAST_CEliteDetector
		mov		edi, eax
		xor		eax, eax
		.if		edi != 0 && [edi+m_bScriptMode] != 0
			mov		esi, [edi+m_items_to_draw]
			mov		eax, [esi+116]
			mov		[esi+120], eax
			mov		eax, 1		; result = true;
		.endif
	.endif
;------------------------------
	pop		edi
	pop		esi
	ret
CScriptGameObject__DetectorClear endp

CScriptGameObject__DetectorDrawObject proc 	obj:dword, palette:dword	;, pos:dword, num:dword
; obj - CGameObject
NameSection					= dword ptr	0ACh	;404
Position					= dword ptr	80h
ID							= dword ptr	0A4h
; локальные переменные
local palette_idx:dword			; shared_str*	sizeof 4 bytes
;--------------------------------------
; свободны - eax, ecx, edx
; ebp - указатель на локальные переменные
	push	esi
	push	ebx
;------------------------------
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CInventoryItem
	add		esp, 4
	.if		eax
		SMARTCAST_CEliteDetector
		mov		esi, eax
		.if		esi != 0 && byte ptr [esi+m_bScriptMode] != 0
			mov		ebx, obj
			.if		ebx
				mov		ebx, [ebx+4]
				.if		ebx
					mov		eax, ds:str_container__g_pStringContainer	; str_container * g_pStringContainer
					mov		ecx, [eax]
					push	palette
					call	ds:str_container__dock						; str_container::dock(char const *)
					.if		eax
						add		dword ptr [eax], 1
						lea		ecx, palette_idx
						push	ecx							; const shared_str& palette_idx
						mov		palette_idx, eax
						lea		eax, [ebx+Position]
						push	eax							; const Fvector& p
						mov     ecx, [esi+m_items_to_draw]
						call	CUIArtefactDetectorElite__RegisterItemToDraw
					.endif
				.endif
			.endif
		.endif
	.endif
;------------------------------
	pop		ebx
	pop		esi
	ret		16
CScriptGameObject__DetectorDrawObject endp

CScriptGameObject__SetAirResistance proc linear:real4, angular:real4
m_pPhysicsShell			= dword ptr 1ECh
	mov		eax, [ecx+4]
	mov     ecx, [eax+m_pPhysicsShell]
	.if		ecx
		mov     eax, [ecx]
		mov     edx, [eax+80h]
		push	angular
		push	linear
		call	edx
	.endif
	ret		8
CScriptGameObject__SetAirResistance endp

CScriptGameObject__GetAirResLinear proc
m_pPhysicsShell			= dword ptr 1ECh
local	linear:real4, angular:real4
	mov		eax, [ecx+4]
	mov     ecx, [eax+m_pPhysicsShell]
	.if		ecx
		mov     eax, [ecx]
		mov     edx, [eax+84h]
		lea		eax, angular
		push	eax
		lea		eax, linear
		push	eax
		call	edx
		fld		linear
	.endif
	ret
CScriptGameObject__GetAirResLinear endp

CScriptGameObject__GetAirResAngular proc
m_pPhysicsShell			= dword ptr 1ECh
local	linear:real4, angular:real4
	mov		eax, [ecx+4]
	mov     ecx, [eax+m_pPhysicsShell]
	.if		ecx
		mov     eax, [ecx]
		mov     edx, [eax+84h]
		lea		eax, angular
		push	eax
		lea		eax, linear
		push	eax
		call	edx
		fld		angular
	.endif
	ret
CScriptGameObject__GetAirResAngular endp

CScriptGameObject__SetGrenadeMode proc mode:byte
;	push	esi
	mov		eax, [ecx+4]
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	.if		eax != 0
		SMARTCAST_CWeaponMagazinedWGrenade
		.if		eax != 0
			mov		ecx, eax
			mov		al, mode
			.if		[ecx+m_bGrenadeMode] != al
				call    CWeaponMagazinedWGrenade__PerformSwitchGL
			.endif
		.endif
	.endif
;	pop		esi
	ret		4
CScriptGameObject__SetGrenadeMode endp

