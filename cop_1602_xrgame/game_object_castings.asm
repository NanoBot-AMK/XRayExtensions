; for Call of Ptityat 1.6.02
MAKE_CASTING1 MACRO casting_fun_name:REQ, vcall_offset:REQ
LOCAL exit_fail
ALIGN_8
casting_fun_name proc near
	mov		ecx, [ecx+4]
	mov		eax, ecx
	test	eax, eax
	jz		short exit_fail
	mov		eax, [eax]
	mov		eax, [eax+vcall_offset]
	call	eax
exit_fail:
	retn
casting_fun_name endp
ENDM

a_casting_error db "casting no script object", 0
print_error_msg proc
	pusha
	push	offset a_casting_error
	call	Msg
	pop eax
	popa
	retn
print_error_msg endp

; приведение типа через RTTI
MAKE_CASTING2 MACRO casting_fun_name:REQ, proc_offset:REQ
LOCAL lab1
LOCAL exit
ALIGN_8
casting_fun_name proc near
;	push esi
;	push edi
;	push ecx
	
;	mov	   esi, ecx
;	mov		edi, [esi+4]
;	test	edi, edi
;	jz		short lab2
;	call	CGameObject__lua_game_object
;lab2:
;	mov		eax, [esi+4]
	mov		eax, [ecx+4]
	test	eax, eax
	jnz		short lab1
	;
	call print_error_msg
	;
	jmp		short exit
lab1:
	push	0				; a5
	push	offset proc_offset ; a4
	push	offset off_10619C60 ; a3
	push	0				; a2
	push	eax				; a1
	call	__RTDynamicCast
	add		esp, 14h
exit:
	;pop ecx
	;pop edi
	;pop esi
	ret
casting_fun_name endp
ENDM

; приведение типа для инвентарных предметов через промежуточное приведение к CInventoryItem
; с последующим приведением через RTTI
MAKE_CASTING3 MACRO casting_fun_name:REQ, proc_offset:REQ
LOCAL exit_fail
ALIGN_8
casting_fun_name proc near
	call	CScriptGameObject__CInventoryItem
	test	eax, eax
	jz		exit_fail
	; это CInventoryItem
	push	0			  ; a5
	push	offset proc_offset ; это надо передавать в качестве параметра макроса
	push	offset off_1061842C ; это у всех таких функций одинаковое
	push	0			  ; a2
	push	eax				; a1
	call	__RTDynamicCast
	add		esp, 14h
exit_fail:
	retn
casting_fun_name endp
ENDM

; странное приведение типа через два последовательных приведения
; встречается редко
MAKE_CASTING4 MACRO casting_fun_name:REQ, proc_offset1:REQ, proc_offset2:REQ
LOCAL exit
ALIGN_8
casting_fun_name proc
	mov		ecx, [ecx+4]
	;PRINT_UINT "obj=%x", ecx
	test	ecx, ecx
	mov		eax, ecx
	jz		exit
	mov		eax, [ecx]
	mov		eax, [eax+proc_offset1]
	call	eax
	;PRINT_UINT "1st=%x", eax
	;
	test	eax, eax
	jz		exit
	mov		edx, [eax]
	mov		ecx, eax
	mov		eax, [edx+proc_offset2]
	call	eax
	;PRINT_UINT "2nd=%x", eax
exit:
	retn
casting_fun_name endp
ENDM

MAKE_CHECK_FUN MACRO check_fun_name:REQ, cast_fun_name:REQ
LOCAL return_false
ALIGN_8
check_fun_name proc near
	call   cast_fun_name
	test   eax, eax
	jz	   return_false
	mov	   eax, 1
return_false:
	retn
check_fun_name endp
ENDM

																; CAttachmentOwner* CGameObject::cast_attachment_owner(); 
MAKE_CASTING1 CScriptGameObject__CInventoryOwner,		088h	; CInventoryOwner* CGameObject::cast_inventory_owner();
MAKE_CASTING1 CScriptGameObject__CInventoryItem,		08Ch	; CInventoryItem* CGameObject::cast_inventory_item();
													;	090h	; CEntity* CGameObject::cast_entity(); 
MAKE_CASTING1 CScriptGameObject__CEntityAlive,			094h	; CEntityAlive* CGameObject::cast_entity_alive();
MAKE_CASTING1 CScriptGameObject__CActor,				098h	; CActor* CGameObject::cast_actor();
													;	09Ch	; CGameObject* CGameObject::cast_game_object();
MAKE_CASTING1 CScriptGameObject__CCustomZone,			0A0h	; CCustomZone* CGameObject::cast_custom_zone();
MAKE_CASTING1 CScriptGameObject__IsPhysicsShellHolder,	0A4h	; CPhysicsShellHolder* CGameObject::cast_physics_shell_holder(); 
													;	0A8h	; IInputReceiver* CGameObject::cast_input_receiver();
													;	0ACh	; CParticlesPlayer* CGameObject::cast_particles_player(); 
MAKE_CASTING1 CScriptGameObject__CArtefact,				0B0h	; CArtefact* CGameObject::cast_artefact(); 
MAKE_CASTING1 CScriptGameObject__CCustomMonster,		0B4h		; CCustomMonster* CGameObject::cast_custom_monster(); 
MAKE_CASTING1 CScriptGameObject__CStalker,				0B8h	; CAI_Stalker* CGameObject::cast_stalker(); 
													;	0BCh		; CScriptEntity* CGameObject::cast_script_entity(); 
MAKE_CASTING1 CScriptGameObject__CWeapon,				0C0h	; CWeapon* CGameObject::cast_weapon(); 
MAKE_CASTING1 CScriptGameObject__CExplosive,			0C4h	; CExplosive* CGameObject::cast_explosive(); 
MAKE_CASTING1 CScriptGameObject__CSpaceRestrictor,		0C8h	; CSpaceRestrictor* CGameObject::cast_restrictor(); 
;MAKE_CASTING1 CScriptGameObject__CAttachableItem,		0CCh	; CAttachableItem* CGameObject::cast_attachable_item(); 
MAKE_CASTING1 CScriptGameObject__CHolder,				0D0h	; CHolderCustom* CGameObject::cast_holder_custom(); 
MAKE_CASTING1 CScriptGameObject__CBaseMonster,			0D4h	; CBaseMonster* CGameObject::cast_base_monster(); 

;MAKE_CASTING1 CScriptGameObject__CEatableItem, 114h  ; <== not working yet


MAKE_CASTING2 CScriptGameObject__CInventoryBox,			off_1062CD94		; заменил
MAKE_CASTING2 CScriptGameObject__CScriptZone,			off_1062CD38		; заменил
MAKE_CASTING2 CScriptGameObject__CProjector,			off_1062D2DC		; заменил
MAKE_CASTING2 CScriptGameObject__CTrader,				off_10628D10		; заменил
MAKE_CASTING2 CScriptGameObject__CCar,					off_1062CD54		; заменил
MAKE_CASTING2 CScriptGameObject__CHelicopter,			off_1062CC74		; заменил
MAKE_CASTING2 CScriptGameObject__CTorch,				off_1061844C		; заменил
MAKE_CASTING2 CScriptGameObject__CHangingLamp,			off_1062CC90		; заменил
MAKE_CASTING2 CScriptGameObject__CWeaponPistol,			off_10637320		; заменил
MAKE_CASTING2 CScriptGameObject__CWeaponKnife,			off_10635EF0		; заменил
MAKE_CASTING2 CScriptGameObject__CWeaponBinoculars, 	off_106376D8		; заменил
MAKE_CASTING2 CScriptGameObject__CWeaponShotgun,		off_10637720		; заменил
MAKE_CASTING2 CScriptGameObject__CWeaponAutoShotgun,	off_10637748		; добавил

MAKE_CASTING3 CScriptGameObject__CWeaponGL,				off_10636A7C		; заменил
MAKE_CASTING3 CScriptGameObject__CMedkit,				off_10637578		; заменил
MAKE_CASTING3 CScriptGameObject__CAntirad,				off_10637590		; заменил
MAKE_CASTING3 CScriptGameObject__COutfit,				off_1062CD70		; заменил
MAKE_CASTING3 CScriptGameObject__CScope,				off_10637380		; заменил
MAKE_CASTING3 CScriptGameObject__CSilencer,				off_10637398		; заменил
MAKE_CASTING3 CScriptGameObject__CGrenadeLauncher,		off_106373B0		; заменил
MAKE_CASTING3 CScriptGameObject__CFoodItem,				off_106375A8		; заменил
MAKE_CASTING3 CScriptGameObject__CGrenade,				off_1061AD4C		; заменил
MAKE_CASTING3 CScriptGameObject__CBottleItem,			off_106375C0		; заменил

MAKE_CASTING4 CScriptGameObject__CWeaponMagazined,		0C0h, 140h
MAKE_CASTING4 CScriptGameObject__CEatableItem,			08Ch, 118h  ; 
MAKE_CASTING4 CScriptGameObject__CMissile,				08Ch, 124h  ;	CMissile* CInventoryItem::cast_missile();
MAKE_CASTING4 CScriptGameObject__CHudItem,				08Ch, 128h  ;	CHudItem* CInventoryItem::cast_hud_item();
MAKE_CASTING4 CScriptGameObject__CAmmo,					08Ch, 12Ch  ;	CWeaponAmmo* CInventoryItem::cast_weapon_ammo();
; additional wrappers for checking functions, just convert return value to plain one if nonzero
MAKE_CHECK_FUN CScriptGameObject__IsInventoryBox		, CScriptGameObject__CInventoryBox
MAKE_CHECK_FUN CScriptGameObject__IsInventoryOwner		, CScriptGameObject__CInventoryOwner
MAKE_CHECK_FUN CScriptGameObject__IsInventoryItem		, CScriptGameObject__CInventoryItem
MAKE_CHECK_FUN CScriptGameObject__IsEntityAlive			, CScriptGameObject__CEntityAlive
MAKE_CHECK_FUN CScriptGameObject__IsActor				, CScriptGameObject__CActor
MAKE_CHECK_FUN CScriptGameObject__IsCustomZone			, CScriptGameObject__CCustomZone
MAKE_CHECK_FUN CScriptGameObject__IssPhysicsShellHolder	, CScriptGameObject__IsPhysicsShellHolder

MAKE_CHECK_FUN CScriptGameObject__IsArtefact			, CScriptGameObject__CArtefact
MAKE_CHECK_FUN CScriptGameObject__IsCustomMonster		, CScriptGameObject__CCustomMonster
MAKE_CHECK_FUN CScriptGameObject__IsStalker				, CScriptGameObject__CStalker
MAKE_CHECK_FUN CScriptGameObject__IsWeapon				, CScriptGameObject__CWeapon

MAKE_CHECK_FUN CScriptGameObject__IsExplosive			, CScriptGameObject__CExplosive
MAKE_CHECK_FUN CScriptGameObject__IsSpaceRestrictor		, CScriptGameObject__CSpaceRestrictor

MAKE_CHECK_FUN CScriptGameObject__IsHolder				, CScriptGameObject__CHolder

MAKE_CHECK_FUN CScriptGameObject__IsBaseMonster			, CScriptGameObject__CBaseMonster
;
MAKE_CHECK_FUN CScriptGameObject__IsScriptZone			, CScriptGameObject__CScriptZone
MAKE_CHECK_FUN CScriptGameObject__IsProjector			, CScriptGameObject__CProjector
MAKE_CHECK_FUN CScriptGameObject__IsTrader				, CScriptGameObject__CTrader
MAKE_CHECK_FUN CScriptGameObject__IsCar					, CScriptGameObject__CCar
MAKE_CHECK_FUN CScriptGameObject__IsHelicopter			, CScriptGameObject__CHelicopter
MAKE_CHECK_FUN CScriptGameObject__IsWeaponGL			, CScriptGameObject__CWeaponGL
MAKE_CHECK_FUN CScriptGameObject__IsMedkit				, CScriptGameObject__CMedkit
MAKE_CHECK_FUN CScriptGameObject__IsAntirad				, CScriptGameObject__CAntirad
MAKE_CHECK_FUN CScriptGameObject__IsOutfit				, CScriptGameObject__COutfit
MAKE_CHECK_FUN CScriptGameObject__IsScope				, CScriptGameObject__CScope
MAKE_CHECK_FUN CScriptGameObject__IsSilencer			, CScriptGameObject__CSilencer
MAKE_CHECK_FUN CScriptGameObject__IsGrenadeLauncher		, CScriptGameObject__CGrenadeLauncher
MAKE_CHECK_FUN CScriptGameObject__IsFoodItem			, CScriptGameObject__CFoodItem
MAKE_CHECK_FUN CScriptGameObject__IsWeaponMagazined		, CScriptGameObject__CWeaponMagazined
MAKE_CHECK_FUN CScriptGameObject__IsEatableItem			, CScriptGameObject__CEatableItem
MAKE_CHECK_FUN CScriptGameObject__IsMissile				, CScriptGameObject__CMissile
MAKE_CHECK_FUN CScriptGameObject__IsHudItem				, CScriptGameObject__CHudItem
MAKE_CHECK_FUN CScriptGameObject__IsAmmo				, CScriptGameObject__CAmmo
MAKE_CHECK_FUN CScriptGameObject__IsGrenade				, CScriptGameObject__CGrenade
MAKE_CHECK_FUN CScriptGameObject__IsBottleItem			, CScriptGameObject__CBottleItem

MAKE_CHECK_FUN CScriptGameObject__IsTorch				, CScriptGameObject__CTorch
MAKE_CHECK_FUN CScriptGameObject__IsHangingLamp			, CScriptGameObject__CHangingLamp
MAKE_CHECK_FUN CScriptGameObject__IsWeaponPistol		, CScriptGameObject__CWeaponPistol
MAKE_CHECK_FUN CScriptGameObject__IsWeaponKnife			, CScriptGameObject__CWeaponKnife
MAKE_CHECK_FUN CScriptGameObject__IsWeaponBinoculars	, CScriptGameObject__CWeaponBinoculars
MAKE_CHECK_FUN CScriptGameObject__IsWeaponShotgun		, CScriptGameObject__CWeaponShotgun
MAKE_CHECK_FUN CScriptGameObject__IsWeaponAutoShotgun	, CScriptGameObject__CWeaponAutoShotgun

;	CEatableItem* CInventoryItem::cast_eatable_item();	108
;	CWeapon* CInventoryItem::cast_weapon();		  112
;	CFoodItem* CInventoryItem::cast_food_item();  116


ALIGN_8
CScriptGameObject__GetGameObject proc near
	mov		eax, [ecx+4]
	retn
CScriptGameObject__GetGameObject endp

ALIGN_8
CScriptGameObject__IsGameObject proc near
	mov		eax, [ecx+4]
	test	eax, eax
	jz		exit
	mov		eax, 1
exit:
	retn
CScriptGameObject__IsGameObject endp

ALIGN_8
CScriptGameObject__GetCarShift proc
	push	esi
	mov		esi, ecx
	push	edi
	
	call	CScriptGameObject__CCar
	
	mov		esi, [esi+4]
	sub		eax, esi

	pop		edi
	pop		esi
	retn
CScriptGameObject__GetCarShift endp

