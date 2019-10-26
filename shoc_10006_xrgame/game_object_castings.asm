;=======================================================================================================
;						Проверка типов объектов.
; Проверить объект можно двумя способами, виртуальными методами класса CGameObject и через smart_cast,
; последний способ даёт возможность проверить любой game_object, а первый работает более быстро,
; но количество классов ограничено.
; При использовании метода smart_cast надо убедится, что входящий класс соответствует указанному объекту.
; вернёт указатель на указанный класс, если он присутствует в указанном классе, или ноль, если его нет.
;
; Рефакторинг НаноБот
;=======================================================================================================

; приведение типа через виртуальные методы 
MAKE_VIRTUAL_CAST MACRO casting_fun_name:REQ, vcall_offset:REQ
align_proc
casting_fun_name proc
	mov		ecx, [ecx+4]	; Object()	// CGameObject*	не имеет смысл проверять на NULL, проверка есть внутри lua
	mov		eax, [ecx]
	mov		edx, [eax+vcall_offset]
	call	edx
	retn
casting_fun_name endp
ENDM

; приведение типа через smart_cast
MAKE_SMART_CAST MACRO casting_fun_name:REQ, name_class_AV:REQ
align_proc
casting_fun_name proc
	mov		eax, [ecx+4]
	smart_cast	name_class_AV, _AVCGameObject, eax
	retn
casting_fun_name endp
ENDM

MAKE_CHECK_VIRTUAL MACRO casting_fun_name:REQ, vcall_offset:REQ
align_proc
casting_fun_name proc
	mov		ecx, [ecx+4]
	mov		eax, [ecx]
	mov		edx, [eax+vcall_offset]
	call	edx
	;преобразовать в булеву
	test	eax, eax
	setnz	al
	retn
casting_fun_name endp
ENDM

MAKE_CHECK_CAST MACRO casting_fun_name:REQ, name_class_AV:REQ
align_proc
casting_fun_name proc
	mov		eax, [ecx+4]
	smart_cast	name_class_AV, _AVCGameObject, eax
	;преобразовать в булеву
	test	eax, eax
	setnz	al
	retn
casting_fun_name endp
ENDM

;//functions used for avoiding most of the smart_cast
;Таблица виртуальных методов для приведения типов.
virtual_cast_attachment_owner				= dword ptr 108		; CAttachmentOwner*
virtual_cast_inventory_owner				= dword ptr 112		; CInventoryOwner*
virtual_cast_inventory_item					= dword ptr 116		; CInventoryItem*
virtual_cast_entity							= dword ptr 120		; CEntity*
virtual_cast_entity_alive					= dword ptr 124		; CEntityAlive*
virtual_cast_actor							= dword ptr 128		; CActor*
virtual_cast_game_object					= dword ptr 132		; CGameObject*
virtual_cast_custom_zone					= dword ptr 136		; CCustomZone*
virtual_cast_physics_shell_holder			= dword ptr 140		; CPhysicsShellHolder*
virtual_cast_input_receiver					= dword ptr 144		; IInputReceiver*
virtual_cast_particles_player				= dword ptr 148		; CParticlesPlayer*
virtual_cast_artefact						= dword ptr 152		; CArtefact*
virtual_cast_custom_monster					= dword ptr 156		; CCustomMonster*
virtual_cast_stalker						= dword ptr 160		; CAI_Stalker*
virtual_cast_script_entity					= dword ptr 164		; CScriptEntity*
virtual_cast_weapon							= dword ptr 168		; CWeapon*
virtual_cast_explosive						= dword ptr 172		; CExplosive*
virtual_cast_restrictor						= dword ptr 176		; CSpaceRestrictor*
virtual_cast_attachable_item				= dword ptr 180		; CAttachableItem*
virtual_cast_holder_custom					= dword ptr 184		; CHolderCustom*
virtual_cast_base_monster					= dword ptr 188		; CBaseMonster*

;------------------приведения типа виртуальными методами-------------------------------------------
MAKE_VIRTUAL_CAST	CScriptGameObject__CAttachmentOwner,		virtual_cast_attachment_owner
MAKE_VIRTUAL_CAST	CScriptGameObject__CInventoryOwner,			virtual_cast_inventory_owner
MAKE_VIRTUAL_CAST	CScriptGameObject__CInventoryItem,			virtual_cast_inventory_item
MAKE_VIRTUAL_CAST	CScriptGameObject__CEntity,					virtual_cast_entity
MAKE_VIRTUAL_CAST	CScriptGameObject__CEntityAlive,			virtual_cast_entity_alive
MAKE_VIRTUAL_CAST	CScriptGameObject__CActor,					virtual_cast_actor
MAKE_VIRTUAL_CAST	CScriptGameObject__CGameObject,				virtual_cast_game_object
MAKE_VIRTUAL_CAST	CScriptGameObject__CCustomZone,				virtual_cast_custom_zone
MAKE_VIRTUAL_CAST	CScriptGameObject__CPhysicsShellHolder,		virtual_cast_physics_shell_holder
MAKE_VIRTUAL_CAST	CScriptGameObject__IInputReceiver,			virtual_cast_input_receiver
MAKE_VIRTUAL_CAST	CScriptGameObject__CParticlesPlayer,		virtual_cast_particles_player
MAKE_VIRTUAL_CAST	CScriptGameObject__CArtefact,				virtual_cast_artefact
MAKE_VIRTUAL_CAST	CScriptGameObject__CCustomMonster,			virtual_cast_custom_monster
MAKE_VIRTUAL_CAST	CScriptGameObject__CStalker,				virtual_cast_stalker
MAKE_VIRTUAL_CAST	CScriptGameObject__CScriptEntity,			virtual_cast_script_entity
MAKE_VIRTUAL_CAST	CScriptGameObject__CWeapon,					virtual_cast_weapon
MAKE_VIRTUAL_CAST	CScriptGameObject__CExplosive,				virtual_cast_explosive
MAKE_VIRTUAL_CAST	CScriptGameObject__CSpaceRestrictor,		virtual_cast_restrictor
MAKE_VIRTUAL_CAST	CScriptGameObject__CAttachableItem,			virtual_cast_attachable_item
MAKE_VIRTUAL_CAST	CScriptGameObject__CHolder,					virtual_cast_holder_custom
MAKE_VIRTUAL_CAST	CScriptGameObject__CBaseMonster,			virtual_cast_base_monster
;------------------------проверка типа виртуальными методами----------------------------------------
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsInventoryOwner,		virtual_cast_inventory_owner
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsInventoryItem,			virtual_cast_inventory_item
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsEntityAlive,			virtual_cast_entity_alive
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsActor,					virtual_cast_actor
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsCustomZone,			virtual_cast_custom_zone
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsPhysicsShellHolder,	virtual_cast_physics_shell_holder
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsArtefact,				virtual_cast_artefact
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsCustomMonster,			virtual_cast_custom_monster
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsStalker,				virtual_cast_stalker
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsWeapon,				virtual_cast_weapon
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsExplosive,				virtual_cast_explosive
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsSpaceRestrictor,		virtual_cast_restrictor
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsAttachableItem,		virtual_cast_attachable_item
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsHolder,				virtual_cast_holder_custom
MAKE_CHECK_VIRTUAL	CScriptGameObject__IsBaseMonster,			virtual_cast_base_monster
;-----------------------------приведения типа smart_cast--------------------------------------------
MAKE_SMART_CAST		CScriptGameObject__CInventoryBox,			_AVCInventoryBox
MAKE_SMART_CAST		CScriptGameObject__CScriptZone,				_AVCScriptZone
MAKE_SMART_CAST		CScriptGameObject__CProjector,				_AVCProjector
MAKE_SMART_CAST		CScriptGameObject__CTrader,					_AVCAI_CTrader
MAKE_SMART_CAST		CScriptGameObject__CCar,					_AVCCar
MAKE_SMART_CAST		CScriptGameObject__CHelicopter,				_AVCHelicopter
MAKE_SMART_CAST		CScriptGameObject__CTorch,					_AVCTorch
MAKE_SMART_CAST		CScriptGameObject__CHangingLamp,			_AVCHangingLamp
MAKE_SMART_CAST		CScriptGameObject__CWeaponPistol,			_AVCWeaponPistol
MAKE_SMART_CAST		CScriptGameObject__CWeaponKnife,			_AVCWeaponKnife
MAKE_SMART_CAST		CScriptGameObject__CWeaponBinoculars,		_AVCWeaponBinoculars
MAKE_SMART_CAST		CScriptGameObject__CWeaponShotgun,			_AVCWeaponShotgun
MAKE_SMART_CAST		CScriptGameObject__CWeaponGL,				_AVCWeaponMagazinedWGrenade
MAKE_SMART_CAST		CScriptGameObject__CMedkit,					_AVCMedkit
MAKE_SMART_CAST		CScriptGameObject__CAntirad,				_AVCAntirad
MAKE_SMART_CAST		CScriptGameObject__COutfit,					_AVCCustomOutfit
MAKE_SMART_CAST		CScriptGameObject__CScope,					_AVCScope
MAKE_SMART_CAST		CScriptGameObject__CSilencer,				_AVCSilencer
MAKE_SMART_CAST		CScriptGameObject__CGrenadeLauncher,		_AVCGrenadeLauncher
MAKE_SMART_CAST		CScriptGameObject__CFoodItem,				_AVCFoodItem
MAKE_SMART_CAST		CScriptGameObject__CGrenade,				_AVCGrenade
MAKE_SMART_CAST		CScriptGameObject__CBottleItem,				_AVCBottleItem
MAKE_SMART_CAST 	CScriptGameObject__CWeaponMagazined, 		_AVCWeaponMagazined
MAKE_SMART_CAST 	CScriptGameObject__CEatableItem,			_AVCEatableItem
MAKE_SMART_CAST 	CScriptGameObject__CMissile,				_AVCMissile
MAKE_SMART_CAST 	CScriptGameObject__CHudItem,				_AVCHudItem
MAKE_SMART_CAST 	CScriptGameObject__CAmmo,					_AVCWeaponAmmo

;-----------------------------проверка типа smart_cast----------------------------------------------
MAKE_CHECK_CAST		CScriptGameObject__IsInventoryBox,			_AVCInventoryBox
MAKE_CHECK_CAST		CScriptGameObject__IsScriptZone,			_AVCScriptZone
MAKE_CHECK_CAST		CScriptGameObject__IsProjector,				_AVCProjector
MAKE_CHECK_CAST		CScriptGameObject__IsTrader,				_AVCAI_CTrader
MAKE_CHECK_CAST		CScriptGameObject__IsCar,					_AVCCar
MAKE_CHECK_CAST		CScriptGameObject__IsHelicopter,			_AVCHelicopter
MAKE_CHECK_CAST		CScriptGameObject__IsWeaponGL,				_AVCWeaponMagazinedWGrenade
MAKE_CHECK_CAST		CScriptGameObject__IsMedkit,				_AVCMedkit
MAKE_CHECK_CAST		CScriptGameObject__IsAntirad,				_AVCAntirad
MAKE_CHECK_CAST		CScriptGameObject__IsOutfit,				_AVCCustomOutfit
MAKE_CHECK_CAST		CScriptGameObject__IsScope,					_AVCScope
MAKE_CHECK_CAST		CScriptGameObject__IsSilencer,				_AVCSilencer
MAKE_CHECK_CAST		CScriptGameObject__IsGrenadeLauncher,		_AVCGrenadeLauncher
MAKE_CHECK_CAST		CScriptGameObject__IsFoodItem,				_AVCFoodItem
MAKE_CHECK_CAST		CScriptGameObject__IsWeaponMagazined,		_AVCWeaponMagazined
MAKE_CHECK_CAST		CScriptGameObject__IsEatableItem,			_AVCEatableItem
MAKE_CHECK_CAST		CScriptGameObject__IsMissile,				_AVCMissile
MAKE_CHECK_CAST		CScriptGameObject__IsHudItem,				_AVCHudItem
MAKE_CHECK_CAST		CScriptGameObject__IsAmmo,					_AVCWeaponAmmo
MAKE_CHECK_CAST		CScriptGameObject__IsGrenade,				_AVCGrenade
MAKE_CHECK_CAST		CScriptGameObject__IsBottleItem,			_AVCBottleItem
MAKE_CHECK_CAST		CScriptGameObject__IsTorch,					_AVCTorch
MAKE_CHECK_CAST		CScriptGameObject__IsHangingLamp,			_AVCHangingLamp
MAKE_CHECK_CAST		CScriptGameObject__IsWeaponPistol,			_AVCWeaponPistol
MAKE_CHECK_CAST		CScriptGameObject__IsWeaponKnife,			_AVCWeaponKnife
MAKE_CHECK_CAST		CScriptGameObject__IsWeaponBinoculars,		_AVCWeaponBinoculars
MAKE_CHECK_CAST		CScriptGameObject__IsWeaponShotgun,			_AVCWeaponShotgun

;---------------------------------------------------------------------------------------------------

align_proc
CScriptGameObject__GetGameObject proc
	mov		eax, [ecx+4]
	retn
CScriptGameObject__GetGameObject endp


align_proc
CScriptGameObject__GetCarShift proc
	push	esi
	mov		esi, [ecx+4]
	call	CScriptGameObject__CCar
	sub		eax, esi
	pop		esi
	retn
CScriptGameObject__GetCarShift endp

