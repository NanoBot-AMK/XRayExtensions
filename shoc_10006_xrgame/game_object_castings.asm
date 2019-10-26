;=======================================================================================================
;						Проверка типов объектов.
; Проверить объект можно двумя способами, виртуальными методами класса CGameObject и через smart_cast,
; последний способ даёт возможность проверить любой CGameObject, а первый работает более быстро,
; но количество классов ограничено.
; При использовании метода smart_cast надо убедится, что входящий класс соответствует указанному объекту,
; вернёт указатель на указанный класс, если он присутствует в указанном классе, или ноль, если его нет.
;
; Рефакторинг НаноБот
;=======================================================================================================

CHECK_CLASS_VIRTUAL MACRO casting_fun_name:REQ, name_class:REQ
align_proc
casting_fun_name proc
	smart_cast	name_class, [ecx+4]
	;преобразовать в булеву
	test	eax, eax
	setnz	al
	ret
casting_fun_name endp
ENDM

CHECK_CLASS_CAST MACRO casting_fun_name:REQ, name_class:REQ
align_proc
casting_fun_name proc
	smart_cast	name_class, CGameObject, [ecx+4]
	;преобразовать в булеву
	test	eax, eax
	setnz	al
	ret
casting_fun_name endp
ENDM

;------------------------проверка типа виртуальными методами----------------------------------------
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsInventoryOwner,		CInventoryOwner
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsInventoryItem,			CInventoryItem
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsEntityAlive,			CEntityAlive
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsActor,					CActor
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsGameObject,			CGameObject
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsCustomZone,			CCustomZone
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsPhysicsShellHolder,	CPhysicsShellHolder
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsArtefact,				CArtefact
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsCustomMonster,			CCustomMonster
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsStalker,				CAI_Stalker
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsWeapon,				CWeapon
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsExplosive,				CExplosive
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsSpaceRestrictor,		CSpaceRestrictor
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsAttachableItem,		CAttachableItem
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsHolder,				CHolderCustom
CHECK_CLASS_VIRTUAL		CScriptGameObject@@IsBaseMonster,			CBaseMonster
;-----------------------------проверка типа smart_cast----------------------------------------------
CHECK_CLASS_CAST		CScriptGameObject@@IsInventoryBox,			CInventoryBox
CHECK_CLASS_CAST		CScriptGameObject@@IsScriptZone,			CScriptZone
CHECK_CLASS_CAST		CScriptGameObject@@IsProjector,				CProjector
CHECK_CLASS_CAST		CScriptGameObject@@IsTrader,				CAI_CTrader
CHECK_CLASS_CAST		CScriptGameObject@@IsCar,					CCar
CHECK_CLASS_CAST		CScriptGameObject@@IsHelicopter,			CHelicopter
CHECK_CLASS_CAST		CScriptGameObject@@IsWeaponGL,				CWeaponMagazinedWGrenade
CHECK_CLASS_CAST		CScriptGameObject@@IsMedkit,				CMedkit
CHECK_CLASS_CAST		CScriptGameObject@@IsAntirad,				CAntirad
CHECK_CLASS_CAST		CScriptGameObject@@IsOutfit,				CCustomOutfit
CHECK_CLASS_CAST		CScriptGameObject@@IsScope,					CScope
CHECK_CLASS_CAST		CScriptGameObject@@IsSilencer,				CSilencer
CHECK_CLASS_CAST		CScriptGameObject@@IsGrenadeLauncher,		CGrenadeLauncher
CHECK_CLASS_CAST		CScriptGameObject@@IsFoodItem,				CFoodItem
CHECK_CLASS_CAST		CScriptGameObject@@IsWeaponMagazined,		CWeaponMagazined
CHECK_CLASS_CAST		CScriptGameObject@@IsEatableItem,			CEatableItem
CHECK_CLASS_CAST		CScriptGameObject@@IsMissile,				CMissile
CHECK_CLASS_CAST		CScriptGameObject@@IsHudItem,				CHudItem
CHECK_CLASS_CAST		CScriptGameObject@@IsAmmo,					CWeaponAmmo
CHECK_CLASS_CAST		CScriptGameObject@@IsGrenade,				CGrenade
CHECK_CLASS_CAST		CScriptGameObject@@IsBottleItem,			CBottleItem
CHECK_CLASS_CAST		CScriptGameObject@@IsTorch,					CTorch
CHECK_CLASS_CAST		CScriptGameObject@@IsHangingLamp,			CHangingLamp
CHECK_CLASS_CAST		CScriptGameObject@@IsWeaponPistol,			CWeaponPistol
CHECK_CLASS_CAST		CScriptGameObject@@IsWeaponKnife,			CWeaponKnife
CHECK_CLASS_CAST		CScriptGameObject@@IsWeaponBinoculars,		CWeaponBinoculars
CHECK_CLASS_CAST		CScriptGameObject@@IsWeaponShotgun,			CWeaponShotgun
CHECK_CLASS_CAST		CScriptGameObject@@IsCrow,					CAI_Crow
CHECK_CLASS_CAST		CScriptGameObject@@IsBloodsucker,			CAI_Bloodsucker
CHECK_CLASS_CAST		CScriptGameObject@@IsBoar,					CAI_Boar
CHECK_CLASS_CAST		CScriptGameObject@@IsFlesh,					CAI_Flesh
CHECK_CLASS_CAST		CScriptGameObject@@IsPseudoDog,				CAI_PseudoDog
CHECK_CLASS_CAST		CScriptGameObject@@IsBurer,					CBurer
CHECK_CLASS_CAST		CScriptGameObject@@IsChimera,				CChimera
CHECK_CLASS_CAST		CScriptGameObject@@IsPseudoGigant,			CPseudoGigant
CHECK_CLASS_CAST		CScriptGameObject@@IsPoltergeist,			CPoltergeist
CHECK_CLASS_CAST		CScriptGameObject@@IsZombie,				CZombie
CHECK_CLASS_CAST		CScriptGameObject@@IsFracture,				CFracture
CHECK_CLASS_CAST		CScriptGameObject@@IsSnork,					CSnork
CHECK_CLASS_CAST		CScriptGameObject@@IsController,			CController
CHECK_CLASS_CAST		CScriptGameObject@@IsCat,					CCat
CHECK_CLASS_CAST		CScriptGameObject@@IsTushkano,				CTushkano
CHECK_CLASS_CAST		CScriptGameObject@@IsDog,					CAI_Dog

;---------------------------------------------------------------------------------------------------