include game_object_reg_macro.asm

;ALIGN_8
game_object_fix proc
; делаем то, что вырезали 
	call	register__bool__void
; добавляем своё
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
	; методы для оценки состояния актора
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
	PERFORM_EXPORT_BOOL__STRING			CScriptGameObject__GetHUDObjectBoneVisible,		"get_hud_obj_bone_visible"
	PERFORM_EXPORT_VOID__BOOL			CScriptGameObject__BlockedRocket,				"blocked_rocket_rpg"
	PERFORM_EXPORT_BOOL__GO				CScriptGameObject__DirectVisibility,			"direct_visibility"
	; Для биорадара на классе CEliteDetector
	PERFORM_EXPORT_BOOL__VOID						CScriptGameObject__DetectorClear,		"detector_clear"
	PERFORM_EXPORT__VOID__GO_STRING_VECTOR_FLOAT	CScriptGameObject__DetectorDrawObject,	"detector_draw_object"
	
	; идём обратно
	jmp		back_from_game_object_fix
game_object_fix endp

;---===Nanobot===---
CScriptGameObject__IsExploded proc
	push	esi
	;---------------
	mov		esi, [ecx+4]	; m_object
	call	CScriptGameObject__CExplosive
	test	eax, eax
	jz		exit_fail		; no Explosive
	movzx	eax, byte ptr [eax+08Ch]	; eax = m_explosion_flags
	and		eax, 1			; eax = m_explosion_flags.flExploding
exit_fail:
	;---------------
	pop		esi
	retn
CScriptGameObject__IsExploded endp

CScriptGameObject__ObjectLuminocity proc
;	CEntityAlive *entity_alive = smart_cast<CEntityAlive*>(&object());
	push	edi
	mov		edi, [ecx+4]			; CGameObject edi
	test	edi, edi
	jz		exit_fail
	push	edi
	call	smart_cast_CEntityAlive
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	;	float		luminocity = object()->ROS()->get_luminocity();
	mov		ecx, edi
	call	ds:ROS					; CObject::ROS(void)
	mov		edx, [eax]
	mov		ecx, eax
	mov		eax, [edx+4]
	call	eax						; st = luminocity = get_luminocity()
	pop		edi
	retn
exit_fail:
	fldz
	pop		edi
	retn
CScriptGameObject__ObjectLuminocity endp

; ACTOR STATES
mstate_real		= dword ptr 1424	; для актора
; актор стоит
CScriptGameObject__IsActorNormal proc
	
	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
;	PRINT_UINT "State - %d", eax
	cmp		eax, 0
	jz		exit_ok
	cmp		eax, 32
	jz		exit_ok
	cmp		eax, 64
	jz		exit_ok
	cmp		eax, 96
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorNormal endp

; актор в присяде
CScriptGameObject__IsActorCrouch proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
;	PRINT_UINT "State - %d", eax
	cmp		eax, 16
	jz		exit_ok
	cmp		eax, 80
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorCrouch endp

; актор в полном присяде
CScriptGameObject__IsActorCreep proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 48
	jz		exit_ok
	cmp		eax, 112
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:

	retn
CScriptGameObject__IsActorCreep endp

; актор на лестнице
CScriptGameObject__IsActorClimb proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 2048
	jz		exit_ok
	cmp		eax, 2080
	jz		exit_ok
	cmp		eax, 2112
	jz		exit_ok
	cmp		eax, 2144
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:

	retn
CScriptGameObject__IsActorClimb endp

; актор идет
CScriptGameObject__IsActorWalking proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 33
	jz		exit_ok
	cmp		eax, 34
	jz		exit_ok
	cmp		eax, 36
	jz		exit_ok
	cmp		eax, 38
	jz		exit_ok
	cmp		eax, 40
	jz		exit_ok
	cmp		eax, 42
	jz		exit_ok
	cmp		eax, 37
	jz		exit_ok
	cmp		eax, 41
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorWalking endp

; актор идет быстрым шагом
CScriptGameObject__IsActorRunning proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 1
	jz		exit_ok
	cmp		eax, 2
	jz		exit_ok
	cmp		eax, 4
	jz		exit_ok
	cmp		eax, 8
	jz		exit_ok
	cmp		eax, 5
	jz		exit_ok
	cmp		eax, 9
	jz		exit_ok
	cmp		eax, 6
	jz		exit_ok
	cmp		eax, 10
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorRunning endp

; актор бежит
CScriptGameObject__IsActorSprinting proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 4097
	jz		exit_ok
	cmp		eax, 4096
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorSprinting endp

; актор идет в присяде
CScriptGameObject__IsActorCrouching proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 17
	jz		exit_ok
	cmp		eax, 18
	jz		exit_ok
	cmp		eax, 20
	jz		exit_ok
	cmp		eax, 24
	jz		exit_ok
	cmp		eax, 21
	jz		exit_ok
	cmp		eax, 26
	jz		exit_ok
	cmp		eax, 22
	jz		exit_ok
	cmp		eax, 25
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorCrouching endp

; актор идет в полном присяде
CScriptGameObject__IsActorCreeping proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 49
	jz		exit_ok
	cmp		eax, 50
	jz		exit_ok
	cmp		eax, 52
	jz		exit_ok
	cmp		eax, 56
	jz		exit_ok
	cmp		eax, 54
	jz		exit_ok
	cmp		eax, 58
	jz		exit_ok
	cmp		eax, 53
	jz		exit_ok
	cmp		eax, 57
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorCreeping endp

; актор лезет по лестнице
CScriptGameObject__IsActorClimbing proc

	call	CScriptGameObject__CActor
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+mstate_real]
	
	cmp		eax, 2049
	jz		exit_ok
	cmp		eax, 2050
	jz		exit_ok
	cmp		eax, 2057
	jz		exit_ok
	cmp		eax, 2053
	jz		exit_ok
	cmp		eax, 2054
	jz		exit_ok
	cmp		eax, 2058
	jz		exit_ok
	cmp		eax, 2081
	jz		exit_ok
	cmp		eax, 2082
	jz		exit_ok
	cmp		eax, 2086
	jz		exit_ok
	cmp		eax, 2090
	jz		exit_ok
	
exit_fail:
	xor		eax, eax
	jmp		exit
exit_ok:
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsActorClimbing endp

CScriptGameObject__CurrentFireMode proc
m_iCurFireMode				= dword ptr	 1964
m_bHasDifferentFireModes	= dword ptr	 1950	; bool (sizeof 1 byte)
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeaponMagazined
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	mov		ecx, eax
	xor		eax, eax
	test	byte ptr [ecx+m_bHasDifferentFireModes], 1
	jz		lab2
		mov		eax, [ecx+m_iCurFireMode]	; тип режима огня
lab2:
	inc		eax
exit_fail:
	retn
CScriptGameObject__CurrentFireMode endp

; class CWeaponMagazined
m_DefaultCartridge			= dword ptr	 1748
m_magazine					= dword ptr	 1736
m_iCurFireMode				= dword ptr	 1964
m_bHasDifferentFireModes	= dword ptr	 1950	; bool (sizeof 1 byte)
fOneShotTime				= dword ptr	 860
m_bGrenadeMode				= dword ptr	 2040
m_magazine2					= dword ptr	 2028
m_DefaultCartridge2			= dword ptr	 2044
; class CCartridge
m_ammoSect					= dword ptr	 4
sizeof_CCartridge			= dword ptr	 60

CScriptGameObject__DefaultAmmo proc
	push	ecx
	push	ebx
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeaponMagazined
	add		esp, 4
	test	eax, eax
	jz		exit_fail
;	push	0
;	push	offset off_10636A7C
;	push	offset off_1061842C
;	push	0
;	push	eax
;	call	__RTDynamicCast
;	add		esp, 14h
;	test	eax, eax
;	jz		no_gl
;	cmp		byte ptr [eax + m_bGrenadeMode], 0
;	jz		no_gl
;	mov		eax, [eax+m_DefaultCartridge2+m_ammoSect]		; секция патрона подствольника
;	jmp		lab1
;no_gl:
	mov		eax, [eax+m_DefaultCartridge+m_ammoSect]		; секция патрона
lab1:
	test	eax, eax
	jz		exit_fail
	add		eax, 10h
exit_fail:
	pop		ebx
	pop		ecx
	retn
CScriptGameObject__DefaultAmmo endp

CScriptGameObject__GetAmmo proc
	push	ecx
	push	ebx
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeaponMagazined
	add		esp, 4
	test	eax, eax
	jz		exit_fail
;	push	0
;	push	offset off_10636A7C
;	push	offset off_1061842C
;	push	0
;	push	eax
;	call	__RTDynamicCast
;	add		esp, 14h
;	test	eax, eax
;	jz		no_gl
;	cmp		byte ptr [eax + m_bGrenadeMode], 0
;	jz		no_gl
;	mov		ecx, [eax+m_magazine2+4]
;	jmp		lab1
;no_gl:
	mov		ecx, [eax+m_magazine+4]
lab1:
	sub		ecx, sizeof_CCartridge
	mov		eax, [ecx+m_ammoSect]		; секция патрона
	test	eax, eax
	jz		exit_fail
	add		eax, 10h
exit_fail:
	pop		ebx
	pop		ecx
	retn
CScriptGameObject__GetAmmo endp

CScriptGameObject__GetRPM proc
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	test	eax, eax
	jz		exit_fail
;	push	eax
;	call	smart_cast_CWeaponMagazined
;	add		esp, 4
;	test	eax, eax
;	jz		exit_fail
	fld		dword ptr [eax+fOneShotTime]
	fdivr	ds:float_60
	retn
exit_fail:
	fldz
	retn
CScriptGameObject__GetRPM endp

CScriptGameObject__SetRPM proc
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	test	eax, eax
	jz		exit_fail
;	push	eax
;	call	smart_cast_CWeaponMagazined
;	add		esp, 4
;	test	eax, eax
;	jz		exit_fail
	movss	xmm0, ds:float_60
	divss	xmm0, dword ptr [esp+4]
	movss	dword ptr [eax+fOneShotTime], xmm0
	retn	4
exit_fail:
	retn	4
CScriptGameObject__SetRPM endp

CScriptGameObject__IsGrenadeMode proc
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeaponMagazined
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	push	0
	push	offset off_10636A7C
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
	test	eax, eax
	jz		exit_fail
	movzx	eax, byte ptr [eax + m_bGrenadeMode]
exit_fail:
	retn
CScriptGameObject__IsGrenadeMode endp

CScriptGameObject__SetObjectBoneVisible proc
bone_name = dword ptr 4
visible	  = dword ptr 8
	push	esi
	push	ebx
;-----------------------------------------
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
;	visual = object().Visual()
	mov		eax, [eax+90h]
;	if (!visual) return
	test	eax, eax
	jz		exit_fail
;	IKinematics* pWeaponVisual = smart_cast<IKinematics*>(visual);
	push	eax
	call	smart_cast_IKinematics
	add		esp, 4
;	if (!pWeaponVisual) return
	test	eax, eax
	jz		exit_fail
	mov		esi, eax			; esi = pWeaponVisual
;	pWeaponVisual->CalculateBones_Invalidate();
	mov		eax, [esi]
	mov		edx, [eax+70h]
	mov		ecx, esi
	call	edx				; CalculateBones_Invalidate
;	bone_id = pWeaponVisual->LL_BoneID(bone_name);
	mov		eax, [esi]
	mov		edx, [eax+14h]
	mov		ecx, [esp + 8 + bone_name]
	push	ecx
	push	esi
	call	edx
	movzx	ebx, ax			; ebx = bone_id
	PRINT_UINT "SetObjectBoneVisible:  bone_id = %d", ebx
	cmp		ebx, 0FFFFh
	jz		exit_fail
;	pWeaponVisual->LL_SetBoneVisible(bone_id, visible, TRUE);
	mov		eax, [esi]
	mov		edx, [eax+60h]
	movzx	eax, byte ptr [esp + 8 + visible]
	PRINT_UINT "SetObjectBoneVisible:  visible = %d", eax
	push	1				; TRUE
	push	eax				; visible
	push	ebx				; bone_id
	mov		ecx, esi
	call	edx				; LL_SetBoneVisible
;	pWeaponVisual->CalculateBones_Invalidate();
	mov		eax, [esi]
	mov		edx, [eax+70h]
	mov		ecx, esi
	call	edx
;	pWeaponVisual->CalculateBones(TRUE);
	mov		eax, [esi]
	mov		edx, [eax+6Ch]
	push	1
	mov		ecx, esi
	call	edx
exit_fail:
;-----------------------------------------
	pop		ebx
	pop		esi
	retn	8
CScriptGameObject__SetObjectBoneVisible endp

CScriptGameObject__GetObjectBoneVisible proc
bone_name = dword ptr 4
	push	esi
	push	ebx
;-----------------------------------------
	mov		eax, [ecx+4]
	PRINT_UINT "GetObjectBoneVisible:  eax = %x", eax
	test	eax, eax
	jz		exit_fail
;	visual = object().Visual()
	mov		eax, [eax+90h]
	PRINT_UINT "GetObjectBoneVisible:  visual eax = %x", eax
;	if (!visual) return
	test	eax, eax
	jz		exit_fail
;	IKinematics* pWeaponVisual = smart_cast<IKinematics*>(visual);
	push	eax
	call	smart_cast_IKinematics
	add		esp, 4
;	if (!pWeaponVisual) return
	test	eax, eax
	jz		exit_fail
	mov		esi, eax			; esi = pWeaponVisual
	PRINT_UINT "GetObjectBoneVisible:  pWeaponVisual eax = %x", eax
;	bone_id = pWeaponVisual->LL_BoneID(bone_name);
	mov		eax, [esi]
	mov		edx, [eax+14h]
	mov		ecx, [esp + 8 + bone_name]
	push	ecx
	push	esi
	call	edx
	movzx	ebx, ax			; ebx = bone_id
	PRINT_UINT "GetObjectBoneVisible:  bone_id = %d", ebx
	cmp		ebx, 0FFFFh
	jz		exit_fail
;	return	pWeaponVisual->LL_GetBoneVisible(bone_id);
	mov		ecx, [esi]
	mov		edx, [ecx+5Ch]
	push	ebx				; bone_id
	push	esi
	call	edx				; LL_GetBoneVisible
exit_fail:
	PRINT_UINT "GetObjectBoneVisible:  result = %d", eax
;-----------------------------------------
	pop		ebx
	pop		esi
	retn	4
CScriptGameObject__GetObjectBoneVisible endp

CScriptGameObject__SetHUDObjectBoneVisible proc
bone_name = dword ptr 4
visible	  = dword ptr 8
	push	esi
	push	edi
	push	ebx
;-----------------------------------------
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	;push	eax
	;call	smart_cast_CWeapon
	;add		esp, 4
;	visual = object().Visual()
	lea		edi, [eax+1F8h]
	mov		ecx, edi
	call	CHudItem__GetHUDmode
	test	eax, eax
	jz		exit_fail
;	if (!visual) return
	mov		ecx, edi
	call	CHudItem__HudItemData
	test	eax, eax
	jz		exit_fail
;	IKinematics* pWeaponVisual = smart_cast<IKinematics*>(visual);
;	push	eax
;	call	smart_cast_IKinematics
;	add		esp, 4
;	if (!pWeaponVisual) return
;	test	eax, eax
;	jz		exit_fail
	mov		esi, eax			; esi = m_model
;	bone_id = m_model->LL_BoneID(bone_name);
	mov		eax, [esi+0Ch]
	mov		ecx, [eax]
	mov		edx, [ecx+14h]
	mov		eax, [esp + 8 + bone_name]
	push	eax
	push	ecx
	call	edx
	movzx	ebx, ax			; ebx = bone_id
	PRINT_UINT "SetHUDObjectBoneVisible:  bone_id = %d", ebx
	cmp		ebx, 0FFFFh
	jz		exit_fail
;	pWeaponVisual->LL_SetBoneVisible(bone_id, visible, TRUE);
	mov		ecx, [esi+0Ch]
	mov		eax, [ecx]
	mov		edx, [eax+60h]
	movzx	eax, byte ptr [esp + 8 + visible]
	PRINT_UINT "SetHUDObjectBoneVisible:  visible = %d", eax
	push	1				; TRUE
	push	eax				; visible
	push	ebx				; bone_id
	call	edx				; LL_SetBoneVisible
;	pWeaponVisual->CalculateBones_Invalidate();
	mov		ecx, [esi+0Ch]
	mov		eax, [ecx]
	mov		edx, [eax+70h]
	call	edx
exit_fail:
;-----------------------------------------
	pop		ebx
	pop		edi
	pop		esi
	retn	8
CScriptGameObject__SetHUDObjectBoneVisible endp

CScriptGameObject__GetHUDObjectBoneVisible proc
bone_name = dword ptr 4
	PRINT_UINT "GetObjectBoneVisible:  esp = %x", esp
	push	esi
	push	edi
	push	ebx
;-----------------------------------------
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	;push	eax
	;call	smart_cast_CWeapon
	;add		esp, 4
;	visual = object().Visual()
	lea		edi, [eax+1F8h]
	mov		ecx, edi
	call	CHudItem__GetHUDmode
	test	eax, eax
	jz		exit_fail
;	if (!visual) return
	mov		ecx, edi
	call	CHudItem__HudItemData
	test	eax, eax
	jz		exit_fail
;	IKinematics* pWeaponVisual = smart_cast<IKinematics*>(visual);
;	push	eax
;	call	smart_cast_IKinematics
;	add		esp, 4
;	if (!pWeaponVisual) return
;	test	eax, eax
;	jz		exit_fail
	mov		esi, eax			; esi = m_model
;	bone_id = m_model->LL_BoneID(bone_name);
	mov		eax, [esi+0Ch]
	mov		ecx, [eax]
	mov		edx, [ecx+14h]
	mov		eax, [esp + 8 + bone_name]
	push	eax
	push	ecx
	call	edx
	movzx	ebx, ax			; ebx = bone_id
	PRINT_UINT "SetHUDObjectBoneVisible:  bone_id = %d", ebx
	cmp		ebx, 0FFFFh
	jz		exit_fail
;	return	pWeaponVisual->LL_GetBoneVisible(bone_id);
	mov		eax, [esi+0Ch]
	mov		ecx, [eax]
	mov		edx, [ecx+5Ch]
	push	ebx				; bone_id
	push	ecx
	call	edx				; LL_GetBoneVisible
exit_fail:
	PRINT_UINT "GetObjectBoneVisible:  result = %d", eax
;-----------------------------------------
	pop		ebx
	pop		edi
	pop		esi
	PRINT_UINT "GetObjectBoneVisible:  esp = %x", esp
	retn	4
CScriptGameObject__GetHUDObjectBoneVisible endp

m_bBlockRocket		= dword ptr 1974
CScriptGameObject__BlockedRocket proc
block				= dword ptr 4
	push	esi
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeapon
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CWeaponMagazined
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	mov		esi, eax
	; smart_cast_CWeaponRPG7
	push	0
	push	offset off_10637538
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
	test	eax, eax
	jz		exit_fail
	movzx	eax, byte ptr [esp+4+block]
;	PRINT_UINT	"BlockRocketRPG7 - %d", eax
	mov		byte ptr [esi+m_bBlockRocket], al
exit_fail:
	pop		esi
	retn	4
CScriptGameObject__BlockedRocket endp

CScriptGameObject__DirectVisibility proc
obj_vis				= dword ptr 4
; свободны - eax, ecx, edx
	push	esi
	push	edi
	push	ebx
;------------------------------
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	mov		ebx, [esp+12+obj_vis]
	test	ebx, ebx
	jz		exit_fail
	mov		ebx, [ebx+4]
	test	ebx, ebx
	jz		exit_fail
	
	
exit_fail:
;------------------------------
	pop		ebx
	pop		edi
	pop		esi
	retn	4
CScriptGameObject__DirectVisibility endp
	
CScriptGameObject__DetectorClear proc
	push	esi
	push	edi
	push	ebx
;------------------------------
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CInventoryItem
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	; smart_cast_CEliteDetector
	push	0
	push	offset off_10637B58
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
	test	eax, eax
	jz		exit_fail
		mov		edi, eax
		cmp		byte ptr [edi+m_bScriptMode], 0
		jz		exit_fail
			mov		esi, [edi+m_items_to_draw]
			mov		ecx, [esi+120]
			mov		eax, [esi+116]
			add		esi, 74h
			cmp		eax, ecx
			jz		exit1
			mov		ebx, ecx
			sub		ebx, ecx
			jz		exit2
			push	ebx				; size_t
			push	ecx				; void *
			push	eax				; void *
			call	ds:memmove
			add		esp, 0Ch
			add		eax, ebx
exit2:
		mov		[esi+4], eax
exit1:
		mov		eax, 1
exit_fail:
;------------------------------
	pop		ebx
	pop		edi
	pop		esi
	retn
CScriptGameObject__DetectorClear endp

CScriptGameObject__DetectorDrawObject proc
NameSection					= dword ptr	0ACh	;404
Position					= dword ptr	80h
ID							= dword ptr	0A4h
;-----
obj							= dword ptr 8
palette						= dword ptr 12
pos							= dword ptr 16
num							= dword ptr 20
; локальные переменные
size_variables				= dword ptr	4	; размер поля локальных переменных
palette_idx					= dword ptr	0	; shared_str*	sizeof 4 bytes
;--------------------------------------
; свободны - eax, ecx, edx
	push	ebp
	mov		ebp, esp
	and		esp, 0FFFFFFF8h
	sub		esp, size_variables
	push	esi
	push	edi
	push	ebx
;------------------------------
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit_fail
	push	eax
	call	smart_cast_CInventoryItem
	add		esp, 4
	test	eax, eax
	jz		exit_fail
	; smart_cast_CEliteDetector
	push	0
	push	offset off_10637B58
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
	test	eax, eax
	jz		exit_fail
	mov		esi, eax
	cmp		byte ptr [esi+m_bScriptMode], 0
	jz		exit_fail
	mov		eax, [ebp+obj]
	test	eax, eax
	jz		exit_fail
	mov		eax, [eax+4]
	test	eax, eax
	jz		exit_fail
		mov		ebx, eax
		mov		edx, [ebp+palette]
;		PRINT_UINT "DetectorDrawObject palette - %s", edx
		mov		ecx, ds:str_container__g_pStringContainer		; str_container * g_pStringContainer
		mov		ecx, [ecx]
		push	edx
		call	ds:str_container__dock							; str_container::dock(char const *)
		test	eax, eax
		jz		exit_fail
		add		dword ptr [eax], 1
		lea		ecx, [esp+12+palette_idx]
		push	ecx					; const shared_str& palette_idx
		mov		[esp+16+palette_idx], eax
		lea		eax, [ebx+Position]
		push	eax					; const Fvector& p
		mov     ecx, [esi+m_items_to_draw]
		call	CUIArtefactDetectorElite__RegisterItemToDraw
exit_fail:
;------------------------------
	pop		ebx
	pop		edi
	pop		esi
	add		esp, size_variables
	mov		esp, ebp
	pop		ebp
	retn	16
CScriptGameObject__DetectorDrawObject endp
