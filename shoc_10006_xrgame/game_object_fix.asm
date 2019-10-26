include game_object_reg_macro.asm
;;;,				"can_move_to_slot" ; --
;;;,				"can_move_to_ruck" ;--
;;;,				"can_move_to_belt" ; --
align_proc
script_register@@game_object_extended proc
local ppFuncExport:dword
; регистрируем функцию разрешения колбеков на нажатия и мышь
;PERFORM_EXPORT_VOID__BOOL enable_input_extensions, "enable_input_extensions"
; регистрируем функцию получения топлива у машины
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetFuel,						"get_fuel"
; регистрируем функцию получения потребления топлива у машины
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetFuelConsumption,			"get_fuel_consumption"
; регистрируем функцию получения объёма бака у машины
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetFuelTank,					"get_fuel_tank"
; регистрируем функцию установки топлива у машины
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetFuel,						"set_fuel"
; регистрируем функцию установки потребления топлива у машины
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetFuelConsumption,			"set_fuel_consumption"
; регистрируем функцию получения предмета с пояса по номеру
PERFORM_EXPORT_GO__INT					CScriptGameObject@@item_on_belt,				"item_on_belt"
; регистрируем функцию получения предмета из рюкзака по номеру
PERFORM_EXPORT_GO__INT					CScriptGameObject@@item_in_ruck,				"item_in_ruck"
; регистрируем функцию получения количества предметов на поясе
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@BeltCount,					"belt_count"
; регистрируем функцию получения количества предметов в рюкзаке
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@RuckCount,					"ruck_count"
; регистрируем функцию получения количества слотов
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@SlotCount,					"slot_number"
; регистрируем функцию перемещения предмета предмета в рюкзак
PERFORM_EXPORT_BOOL__GO					CScriptGameObject@@MoveToRuck,					"move_to_ruck"
; регистрируем функцию перемещения предмета предмета на пояс
PERFORM_EXPORT_BOOL__GO					CScriptGameObject@@MoveToBelt,					"move_to_belt"
; регистрируем функцию перемещения предмета предмета в слот без активациии
PERFORM_EXPORT_BOOL__GO					CScriptGameObject@@MoveToSlotNotActivate,		"move_to_slot"
; регистрируем функцию перемещения предмета предмета в слот с одновременной активацией
PERFORM_EXPORT_BOOL__GO					CScriptGameObject@@MoveToSlotAndActivate,		"move_to_slot_and_activate"
; регистрируем функцию определения того, что предмет находится на поясе
PERFORM_EXPORT_BOOL__GO					CScriptGameObject@@IsOnBelt,					"is_on_belt"
; регистрируем функцию определения того, что предмет находится в рюкзаке
PERFORM_EXPORT_BOOL__GO					CScriptGameObject@@IsInRuck,					"is_in_ruck"
; регистрируем функцию определения того, что предмет находится в слоте
PERFORM_EXPORT_BOOL__GO					CScriptGameObject@@IsInSlot,					"is_in_slot"
; регистрируем функцию получения общего веса инвентаря
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetInventoryWeight,			"get_inventory_weight"
; регистрируем функцию получения предмета из инвентарного ящика по номеру
PERFORM_EXPORT_GO__INT					CScriptGameObject@@item_in_inv_box,				"object_from_inv_box"
; test get_id
;PERFORM_EXPORT_INT__VOID CScriptGameObject@@GetID, "get_id"
; регистрируем функцию установки коэффициента спринта для актора
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetSprintFactor,				"set_sprint_factor"
; регистрируем функцию получения коэффициента спринта для актора
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetSprintFactor,				"get_sprint_factor"
; регистрируем функцию получения состояния актора
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@ActorBodyState,				"actor_body_state"
; регистрируем функцию получения видимости актора
;PERFORM_EXPORT_UINT__VOID CScriptGameObject@@GetActorVisible, "get_actor_visible"

; регистрируем функцию получения max weight
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetActorMaxWeight,			"get_actor_max_weight"
; регистрируем функцию получения max walk weight
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetActorMaxWalkWeight,		"get_actor_max_walk_weight"
; регистрируем функцию установки max weight
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetActorMaxWeight,			"set_actor_max_weight"
; регистрируем функцию установки max walk weight
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetActorMaxWalkWeight,		"set_actor_max_walk_weight"
; регистрируем функцию получения take distance
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetActorTakeDist,			"get_actor_take_dist"
; регистрируем функцию установки take distance
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetActorTakeDist,			"set_actor_take_dist"
; регистрируем функцию для получения specific_character
PERFORM_EXPORT_STRING__VOID				CScriptGameObject@@GetSpecificProfile,			"specific_character"
;--
PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetGameObjectFloat,			"get_go_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetGameObjectFloat,			"set_go_float"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt,			"get_go_int"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetGameObjectInt,			"set_go_int"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt16,			"get_go_int16"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetGameObjectInt16,			"set_go_int16"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt8,			"get_go_int8"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetGameObjectInt8,			"set_go_int8"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@SetGameObjectSharedStr,		"set_go_shared_str"

PERFORM_EXPORT_VOID__U32_PVECTOR		CScriptGameObject@@SetGameObjectVector,			"set_go_vector"

PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetActorConditionInt,		"get_actor_condition_int"

PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetGameObjectFloat,			"get_car_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetGameObjectFloat,			"set_car_float"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt,			"get_car_int"	
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetGameObjectInt,			"set_car_int"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt16,			"get_car_int16"			
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetGameObjectInt16,			"set_car_int16"

PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetMemoryFloat,				"get_memory_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetMemoryFloat,				"set_memory_float"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetMemoryInt,				"get_memory_int"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetMemoryInt,				"set_memory_int"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetMemoryInt16,				"get_memory_int16"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetMemoryInt16,				"set_memory_int16"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetMemoryInt8,				"get_memory_int8"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetMemoryInt8,				"set_memory_int8"

PERFORM_EXPORT_STRING__VOID				CScriptGameObject@@GetGameObjectSharedStr,		"get_go_shared_str"
;--
PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetInventoryItemFloat,		"get_inventory_item_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetInventoryItemFloat,		"set_inventory_item_float"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetInventoryItemInt,			"get_inventory_item_int"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetInventoryItemInt,			"set_inventory_item_int"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetInventoryItemInt16,		"get_inventory_item_int16"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetInventoryItemInt16,		"set_inventory_item_int16"
PERFORM_EXPORT_U32__STRING_INT		CScriptGameObject@@SetInventoryItemSharedStr,		"set_inventory_item_shared_str"

PERFORM_EXPORT_STRING__VOID			CScriptGameObject@@GetInventoryItemSharedStr,		"get_inventory_item_shared_str"
;--
PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetGameObjectFloat,			"get_actor_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetGameObjectFloat,			"set_actor_float"
PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetActorConditionFloat,		"get_actor_condition_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetActorConditionFloat,		"set_actor_condition_float"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt,			"get_actor_int"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt16,			"get_actor_int16"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetGameObjectInt,			"set_actor_int"

PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetInventoryItemInt,			"get_wpn_gl_int"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetInventoryItemInt,			"get_wpn_int"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetInventoryItemInt16,		"get_wpn_int16"			;-- Nanobot
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetInventoryItemInt8,		"get_wpn_int8"			;-- Nanobot
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetInventoryItemInt,			"set_wpn_int"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetInventoryItemInt16,		"set_wpn_int16"			;-- Nanobot
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetInventoryItemInt8,		"set_wpn_int8"		 	;-- Nanobot

;PERFORM_EXPORT_U32__STRING_INT			register_get_wpn_bone_id, CScriptGameObject@@GetWeaponBoneID
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetBoneID,					"get_bone_id"

;PERFORM_EXPORT_U32__STRING_INT			register_get_wpn_hud_bone_id, CScriptGameObject@@GetWeaponHudBoneID

PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetHudBoneID,				"get_hud_bone_id"

PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@SetWeaponBoneVisible,		"set_wpn_bone_visible"
PERFORM_EXPORT_VOID__STR_BOOL			CScriptGameObject@@SetHudBoneVisible,			"set_hud_bone_visible"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetHudBoneVisible,			"get_hud_bone_visible"

PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetWeaponBoneVisible,		"get_wpn_bone_visible"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetBoneVisible,				"get_bone_visible"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@SetBoneVisible,				"set_bone_visible"

PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetInventoryItemFloat,		"get_wpn_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetInventoryItemFloat,		"set_wpn_float"

; регистрируем функцию получения FOV актора
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetCameraFOV,				"get_camera_fov"
; регистрируем функцию установки FOV актора
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetCameraFOV,				"set_camera_fov"
; регистрируем функцию получения FOV худа
;PERFORM_EXPORT_FLOAT__VOID CScriptGameObject@@GetHudFOV, "get_hud_fov"
; регистрируем функцию установки FOV худа
;PERFORM_EXPORT_VOID__FLOAT CScriptGameObject@@SetHudFOV, "set_hud_fov"
;
PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetGameObjectFloat,			"get_custom_monster_float"	;;CScriptGameObject@@GetCustomMonsterFloat
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetGameObjectInt,			"get_custom_monster_int"	;;CScriptGameObject@@GetCustomMonsterInt

PERFORM_EXPORT_STRING__VOID				CScriptGameObject@@GetGameObjectSharedStr,		"get_actor_shared_str"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@SetGameObjectSharedStr,		"set_actor_shared_str"

PERFORM_EXPORT_STRING__VOID			CScriptGameObject@@GetInventoryItemSharedStr,		"get_wpn_shared_str"
PERFORM_EXPORT_U32__STRING_INT		CScriptGameObject@@SetInventoryItemSharedStr,		"set_wpn_shared_str"	

PERFORM_EXPORT_STRING__VOID				CScriptGameObject@@GetHudSharedStr,				"get_hud_shared_str"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@SetHudSharedStr,				"set_hud_shared_str"

PERFORM_EXPORT_VOID__STRING				CScriptGameObject@@SetActorVisual,				"set_actor_visual"

PERFORM_EXPORT_VOID__GO					CScriptGameObject@@OpenInventoryBox,			"open_inventory_box"
; регистрируем функцию получения количества предметов в ящике
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@InvBoxCount,					"inv_box_count"
; получение инвентарного веса
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetWeght,					"get_weight"
; получение владельца машины, как game_object
PERFORM_EXPORT_GO__VOID					CScriptGameObject@@GetHolderOwner,				"get_holder_owner"
; получение скорости кровотечения
;PERFORM_EXPORT_FLOAT__VOID CScriptGameObject@@GetBleedingSpeed, "get_bleeding_speed"
; изменение скорости кровотечения
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@ChangeBleedingSpeed,			"heal_wounds"

PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsGameObject,				"is_game_object"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsCar,						"is_car"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsHelicopter,				"is_helicopter"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsHolder,					"is_holder"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsEntityAlive,				"is_entity_alive"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsInventoryItem,				"is_inventory_item"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsInventoryOwner,			"is_inventory_owner"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActor,						"is_actor"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsCustomMonster,				"is_custom_monster"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsWeapon,					"is_weapon"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsWeaponGL,					"is_weapon_gl"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsInventoryBox,				"is_inventory_box"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsMedkit,					"is_medkit"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsEatableItem,				"is_eatable_item"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsAntirad,					"is_antirad"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsOutfit,					"is_outfit"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsScope,						"is_scope"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsSilencer,					"is_silencer"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsGrenadeLauncher,			"is_grenade_launcher"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsWeaponMagazined,			"is_weapon_magazined"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsSpaceRestrictor,			"is_space_restrictor"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsStalker,					"is_stalker"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsCustomZone,				"is_anomaly"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsBaseMonster,				"is_monster"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsExplosive,					"is_explosive"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsScriptZone,				"is_script_zone"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsProjector,					"is_projector"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsTrader,					"is_trader"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsHudItem,					"is_hud_item"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsFoodItem,					"is_food_item"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsArtefact,					"is_artefact"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsAmmo,						"is_ammo"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsMissile,					"is_missile"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsPhysicsShellHolder,		"is_physics_shell_holder"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsGrenade,					"is_grenade"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsBottleItem,				"is_bottle_item"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsCrow,						"is_crow"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsBloodsucker,				"is_bloodsucker"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsBoar,						"is_boar"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsFlesh,						"is_flesh"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsPseudoDog,					"is_pseudodog"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsBurer,						"is_burer"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsChimera,					"is_chimera"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsPseudoGigant,				"is_pseudogigant"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsPoltergeist,				"is_poltergeist"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsZombie,					"is_zombie"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsFracture,					"is_fracture"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsSnork,						"is_snork"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsController,				"is_controller"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsCat,						"is_cat"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsTushkano,					"is_tushkano"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsDog,						"is_dog"

PERFORM_EXPORT_VECTOR__STRING			CScriptGameObject@@hud_bone_position,			"get_hud_bone_pos"

PERFORM_EXPORT_VOID__VOID				CScriptGameObject@@ProjectorOn,					"projector_on"
PERFORM_EXPORT_VOID__VOID				CScriptGameObject@@ProjectorOff,				"projector_off"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@ProjectorIsOn,				"projector_is_on"
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@SwitchProjector,				"switch_projector"

PERFORM_EXPORT_INIFILE__VOID			CScriptGameObject@@GetVisualIni,				"get_visual_ini"

PERFORM_EXPORT_VOID__VOID				CScriptGameObject@@UpdateCondition,				"update_condition"

PERFORM_EXPORT_VOID__STR_BOOL			CScriptGameObject@@PlayHudAnimation,			"play_hud_animation"
PERFORM_EXPORT_VOID__INT				CScriptGameObject@@SetHudAnimationChannel,		"set_hud_animation_channel"
PERFORM_EXPORT_VOID__INT		CScriptGameObject@@SetHudAnimationCallbackParam,		"set_hud_animation_callback_param"
PERFORM_EXPORT_VOID__BOOL		CScriptGameObject@@SetUseHudAnimationCallback,			"set_use_hud_animation_callback"


PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@SaveHudBoneFloat,			"save_hud_bone_float"
PERFORM_EXPORT_FLOAT__INT				CScriptGameObject@@GetHudFloat,					"get_hud_float"
PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT	CScriptGameObject@@SetHudFloat,					"set_hud_float"

;;;PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetCalibratingVector,	"set_calibrating_vector"

PERFORM_EXPORT_VOID__VOID				CScriptGameObject@@InvalidateInventory,			"invalidate_inventory"
;PERFORM_EXPORT_VECTOR__VOID
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@NonscriptUsable,				"nonscript_usable"
;
PERFORM_EXPORT_VOID__U32_U32_U32		CScriptGameObject@@SetGoodwillByID,				"set_goodwill_ex"
PERFORM_EXPORT_VOID__U32_U32_U32		CScriptGameObject@@ChangeGoodwillByID,			"change_goodwill_ex"

PERFORM_EXPORT_VOID__GO					CScriptGameObject@@AttachVehicle,				"attach_vehicle"

PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@EnableCarPanel,				"enable_car_panel"

PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetVectorGlobalArg1,			"set_vector_global_arg_1"
PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetVectorGlobalArg2,			"set_vector_global_arg_2"
PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetVectorGlobalArg3,			"set_vector_global_arg_3"
PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetVectorGlobalArg4,			"set_vector_global_arg_4"

PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetActorDirectionEx,			"set_camera_direction"

PERFORM_EXPORT_VOID__GO					CScriptGameObject@@SetGOArg1,					"set_object_arg_1"

PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@GetHudItemState,				"get_hud_item_state"


; by Real Wolf
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@SwitchTorch,					"switch_torch"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsTorchEnabled,				"is_torch_enabled"
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetTorchRange,				"set_torch_range"
PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetTorchColor,				"set_torch_color"
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetTorchOmniRange,			"set_torch_omni_range"
PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@SetTorchOmniColor,			"set_torch_omni_color"
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetTorchGlowRadius,			"set_torch_glow_radius"
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetTorchSpotAngle,			"set_torch_spot_angle"
PERFORM_EXPORT_VOID__STRING				CScriptGameObject@@SetTorchColorAnimator,		"set_torch_color_animator"

PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetInventoryItemInt8,		"get_inventory_item_int8"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@SetInventoryItemInt8,		"set_inventory_item_int8"

PERFORM_EXPORT_STRING__VOID				CScriptGameObject@@GetVisualName,				"get_visual_name"
PERFORM_EXPORT_VOID__STRING				CScriptGameObject@@SetVisualName,				"set_visual_name"

PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetShapeRadius,				"get_shape_radius"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsTorch,						"is_torch"
PERFORM_EXPORT_GO__INT					CScriptGameObject@@GetObjectArg1,				"get_object_arg_1"
; end

; регистрируем функции установки lsf_params для ламп
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetLSFSpeed,					"set_lsf_speed"
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetLSFAmount,				"set_lsf_amount"
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetLSFSMAPJitter,			"set_lsf_smap_jitter"
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetLSFSpeed,					"get_lsf_speed"
; регистрируем функцию получения радиуса объекта
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetRadius,					"radius"
; получение имени кости по индексу
PERFORM_EXPORT_STRING__VOID				CScriptGameObject@@GetBoneName,					"get_bone_name"
; наличие визуала (с костями)
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@HasVisual,					"has_visual"

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; ACTOR STATES
; методы для оценки состояния актора
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorNormal,				"is_actor_normal"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorCrouch,				"is_actor_crouch"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorCreep,				"is_actor_creep"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorClimb,				"is_actor_climb"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorWalking,				"is_actor_walking"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorRunning,				"is_actor_running"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorSprinting,			"is_actor_sprinting"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorCrouching,			"is_actor_crouching"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorCreeping,				"is_actor_creeping"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsActorClimbing,				"is_actor_climbing"
; метод для вкл\выкл ПНВ
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@SwitchNightVision,			"switch_night_vision"
; методы для проверки на тип объекта
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsHangingLamp,				"is_hanging_lamp"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsWeaponKnife,				"is_knife"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsWeaponBinoculars,			"is_binoculars"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsWeaponPistol,				"is_weapon_pistol"
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsWeaponShotgun,				"is_weapon_shotgun"
; метод для высадки актора из машины
PERFORM_EXPORT_VOID__VECTOR				CScriptGameObject@@DetachVehicle,				"detach_vehicle"
; разворот камеры на геймобъект
PERFORM_EXPORT_VOID__GO					CScriptGameObject@@UpdateCameraDirection,		"update_camera_direction"
; восстановление прошлого значения FOV актора
PERFORM_EXPORT_VOID__VOID				CScriptGameObject@@RestoreCameraFOV,			"restore_camera_fov"
; HUD CONTROL
; получить оставшиеся время текущей анимации
PERFORM_EXPORT_UINT__VOID		CScriptGameObject@@GetHudAnimationRemainingTime,		"get_hud_animation_remaining_time"
; проверить является ли текущая анимация цикличной
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsCyclicHudAnimation,		"is_cyclic_hud_animation"
; проверить есть ли заданная анимация в модели
PERFORM_EXPORT_BOOL__STRING				CScriptGameObject@@HasHudAnimation,				"has_hud_animation"
; получить длину текущей анимации
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@GetHudAnimationLength,		"get_hud_animation_length"
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================

;PERFORM_EXPORT_VOID__INT		CScriptGameObject@@ClearRelations, "clear_relations"
PERFORM_EXPORT_VOID__INT_INT			CScriptGameObject@@ClearPersonalRecord,			"clear_personal_record"
; ---===Nanobot===---
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@IsExploding,					"is_exploding"	; взрывной объект взорван? 
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@setDynamicScales,			"set_air_resistance"
PERFORM_EXPORT_BOOL__STRING				CScriptGameObject@@LoadAmmoCar,					"load_ammo_car"
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@SizeAmmoBox,					"get_ammo_box_size"
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@CurrAmmoBox,					"set_ammo_box_curr"
; задать лучшие оружие сталкеру.
PERFORM_EXPORT_GO__VOID					CScriptGameObject@@GetScriptBestWeapon,			"get_script_best_weapon"
PERFORM_EXPORT_VOID__GO_BOOL			CScriptGameObject@@SetScriptBestWeapon,			"set_script_best_weapon"
; Можно ли выронить оружие при смерти сталкера.
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@GetNotDropWeaponDeath,		"get_not_drop_weapon_die"
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@SetNotDropWeaponDeath,		"set_not_drop_weapon_die"
;вычислить точку упреждения для НПС, актора, вертолёта, БТРа
PERFORM_EXPORT_UINT__VECTOR_PVECTOR		CScriptGameObject@@calc_future_position,		"calc_future_position"				
;включение колбеков
PERFORM_EXPORT_VOID__INT				CScriptGameObject@@SetFlagCallbackKey,			"set_flag_callback_key"
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@GetFlagCallbackKey,			"get_flag_callback_key"
;тип камеры
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@GetTypeCamera,				"get_type_camera"
;включение/выключение перекрестие прицела в машине с оружием
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@GetCarShowCrosshair,			"car_show_crosshair"
;разворот башни CCar под заданными углами.
PERFORM_EXPORT_VOID__FLOAT_FLOAT		CScriptGameObject@@SetCarWpnCurRotation,		"car_weapon_rotation"
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetCarWpnCurDirH,			"car_weapon_dir_h"
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetCarWpnCurDirP,			"car_weapon_dir_p"
;Нажата ли указаная клавиша.
PERFORM_EXPORT_BOOL__U32				CScriptGameObject@@GetKeyState,					"get_key_state"
PERFORM_EXPORT_U32__STRING_INT			CScriptGameObject@@SpawnArtefact,				"spawn_artefact"
;разрешить спавн артефактов аномалии скриптом.
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@AllowScriptSpawnArtefact,	"allow_script_spawn_artefact"
;перезагрузить оружия машины, надо для спареного оружия на бронетехнике.
PERFORM_EXPORT_VOID__STR_STR			CScriptGameObject@@ReloadCarWeapon,				"reload_car_weapon"
;заблокировать оружие НПС
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@GetWeaponNPCBlocked,			"get_weapon_npc_blocked"
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@SetWeaponNPCBlocked,			"set_weapon_npc_blocked"
; задать инициатор для физической оболочки, т.е. кто кинул камень?
PERFORM_EXPORT_VOID__INT				CScriptGameObject@@SetInitiator,				"set_initiator_id"
PERFORM_EXPORT_UINT__VOID				CScriptGameObject@@GetInitiator,				"get_initiator_id"
;переключить режим подствольного гранатомёта для НПС
PERFORM_EXPORT_BOOL__VOID				CScriptGameObject@@GetGrenadeModeGL,			"get_grenade_mode_gl"
PERFORM_EXPORT_VOID__BOOL				CScriptGameObject@@SetGrenadeModeGL,			"set_grenade_mode_gl"
PERFORM_EXPORT_BOOL__PVECTOR_FLOAT		CScriptGameObject@@TestGrenadeFire,				"test_grenade_fire"
;для РПГ7 можно менять скорость вылета гранаты, сделано для класса граната_для_нпс
PERFORM_EXPORT_FLOAT__VOID				CScriptGameObject@@GetLaunchSpeedRPG7,			"get_speed_rpg7"
PERFORM_EXPORT_VOID__FLOAT				CScriptGameObject@@SetLaunchSpeedRPG7,			"set_speed_rpg7"

ret
script_register@@game_object_extended endp

align_proc
script_register@@game_object_extended2 proc
local ppFuncExport:dword
PERFORM_EXPORT_PROPERTY__FLOAT_RW		CScriptGameObject@@GetSatiety,		CScriptGameObject@@ChangeSatiety,	"satiety"
PERFORM_EXPORT_PROPERTY__FLOAT_RW		CScriptGameObject@@GetAlcohol,		CScriptGameObject@@ChangeAlcohol,	"alcohol"
PERFORM_EXPORT_PROPERTY__FLOAT_RW		CScriptGameObject@@GetMaxPower,		CScriptGameObject@@ChangeMaxPower,	"max_power"
;получить параметры прицеливания у оружия, надо для разного скриптового оружия.
PERFORM_EXPORT_VECTOR__VOID				CScriptGameObject@@get_LastFP,					"get_LastFP"
PERFORM_EXPORT_VECTOR__VOID				CScriptGameObject@@get_LastFP2,					"get_LastFP2"
PERFORM_EXPORT_VECTOR__VOID				CScriptGameObject@@get_LastFD,					"get_LastFD"
PERFORM_EXPORT_VECTOR__VOID				CScriptGameObject@@get_LastSP,					"get_LastSP"

ret
script_register@@game_object_extended2 endp

align_proc
set_shared_str proc ; ebx = (shared_str*)	eax = (char*)
	push	ecx
	;-------------
	push	eax
	mov		eax, ds:g_pStringContainer
	mov		ecx, [eax]
	call	str_container__dock
	ASSUME	eax:ptr str_value, ecx:ptr str_value, ebx:ptr shared_str
	.if (eax)
		inc		[eax].dwReference
	.endif
	;if (0==p_) return;	p_->dwReference--;	if (0==p_->dwReference)	p_=0;
	mov		ecx, [ebx].p_	; str_value
	.if (ecx)
		dec		[ecx].dwReference
		.if ([ecx].dwReference==0)
			mov		[ebx].p_, 0
		.endif
	.endif
	ASSUME	eax:nothing, ecx:nothing, ebx:nothing
	mov		[ebx], eax
	pop		ecx
	ret
set_shared_str endp

align_proc
set_shared@@_set proc (dword) uses ebx str_name:ptr byte
;ecx	this	set_shared*
	mov		ebx, ecx
	push	str_name
	mov		eax, ds:g_pStringContainer
	mov		ecx, [eax]
	call	str_container__dock
	ASSUME	eax:ptr str_value, ecx:ptr str_value, ebx:ptr shared_str
	.if (eax)
		inc		[eax].dwReference
	.endif
	mov		ecx, [ebx].p_	; str_value
	.if (ecx)
		dec		[ecx].dwReference
	.endif
	mov		[ebx].p_, eax
	ASSUME	eax:nothing, ecx:nothing, ebx:nothing
	ret
set_shared@@_set endp

align_proc
CScriptGameObject@@GetHudFloat proc param_offset:dword
	smart_cast	CHudItem, CGameObject, [ecx+4]
	fldz
	.if (eax)
		mov		eax, [eax].CHudItem.m_pHUD	; CWeaponHUD*
		mov		ecx, param_offset
		fld		dword ptr [eax+ecx]
	.endif
	ret
CScriptGameObject@@GetHudFloat endp

align_proc
CScriptGameObject@@SetHudFloat proc pvector_param:dword, param_float:dword, param_offset:dword
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		mov		eax, [eax].CHudItem.m_pHUD	; CWeaponHUD*
		mov		ecx, param_offset
		mov		edx, param_float
		mov		[eax+ecx], edx
	.endif
	ret
CScriptGameObject@@SetHudFloat endp

;============================================================================================================
; Доступ к членам класса для CGameObject, CActor, CCar, CCustomMonster у них у всех смещение равно CGameObject
;============================================Чтение==========================================================
align_proc
CScriptGameObject@@GetGameObjectFloat proc param_offset:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		ecx, param_offset
	fld		dword ptr [edx+ecx]
	ret
CScriptGameObject@@GetGameObjectFloat endp

align_proc
CScriptGameObject@@GetGameObjectInt proc string_param:dword, param_offset:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		ecx, param_offset
	mov		eax, [edx+ecx]
	ret
CScriptGameObject@@GetGameObjectInt endp

align_proc
CScriptGameObject@@GetGameObjectInt16 proc string_param:dword, param_offset:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		ecx, param_offset
	movzx	eax, word ptr [edx+ecx]
	ret
CScriptGameObject@@GetGameObjectInt16 endp

align_proc
CScriptGameObject@@GetGameObjectInt8 proc string_param:dword, param_offset:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		ecx, param_offset
	movzx	eax, byte ptr [edx+ecx]
	ret
CScriptGameObject@@GetGameObjectInt8 endp

align_proc
CScriptGameObject@@GetGameObjectSharedStr proc
	mov		edx, [ecx+4]
	xor		eax, eax
	mov		ecx, g_int_argument_0
	.if (ecx)
		mov		eax, [edx+ecx]
		.if (eax)
			add		eax, 12
		.endif
		xor		ecx, ecx
		mov		g_int_argument_0, ecx
	.endif
	ret
CScriptGameObject@@GetGameObjectSharedStr endp

align_proc
CScriptGameObject@@GetGameObjectLPCSTR proc
	mov		edx, [ecx+4]
	xor		eax, eax
	mov		ecx, g_int_argument_0
	.if (ecx)
		mov		eax, [edx+ecx]
		xor		ecx, ecx
		mov		g_int_argument_0, ecx
	.endif
	ret
CScriptGameObject@@GetGameObjectLPCSTR endp

;==============================Запись===============================
align_proc
CScriptGameObject@@SetGameObjectFloat proc pvector_param:dword, param_float:dword, param_offset:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		eax, param_float
	mov		ecx, param_offset
	mov		[edx+ecx], eax
	ret
CScriptGameObject@@SetGameObjectFloat endp

align_proc
CScriptGameObject@@SetGameObjectInt proc param_offset:dword, dword_param:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		eax, dword_param
	mov		ecx, param_offset
	mov		[edx+ecx], eax
	ret
CScriptGameObject@@SetGameObjectInt endp

align_proc
CScriptGameObject@@SetGameObjectInt16 proc param_offset:dword, word_param:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		eax, word_param
	mov		ecx, param_offset
	mov		[edx+ecx], ax
	ret
CScriptGameObject@@SetGameObjectInt16 endp

align_proc
CScriptGameObject@@SetGameObjectInt8 proc param_offset:dword, byte_param:dword
	mov		edx, [ecx+4]	; CGameObject
	mov		eax, byte_param
	mov		ecx, param_offset
	mov		[edx+ecx], al
	ret
CScriptGameObject@@SetGameObjectInt8 endp

align_proc
CScriptGameObject@@SetGameObjectSharedStr proc uses ebx string_param:dword, param_offset:dword
	mov		ebx, [ecx+4]
	add		ebx, param_offset
	mov		eax, string_param
	call	set_shared_str	; ebx = (shared_str*)	eax = (char*)
	ret
CScriptGameObject@@SetGameObjectSharedStr endp

align_proc
CScriptGameObject@@SetGameObjectVector proc param_offset:dword, pvector_param:dword
	mov		edx, [ecx+4]
	add		edx, param_offset
	mov		ecx, pvector_param
	ASSUME	edx:ptr Fvector, ecx:ptr Fvector
	Fvector_set		[edx], [ecx].x, [ecx].y, [ecx].z
	ASSUME	edx:nothing, ecx:nothing
	ret
CScriptGameObject@@SetGameObjectVector endp
;=============================================================================
; Доступ к членам класса для CInventoryItem, CWeapon у них всех смещение одинаковое и смещено от CGameObject на -216 байт
;=============================Чтение=============================
align_proc
CScriptGameObject@@GetInventoryItemFloat proc uses esi param_offset:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	fldz
	.if (eax)
		mov		ecx, param_offset
		fld		dword ptr [eax+ecx]
	.else
		smart_cast	CCar, CGameObject, esi
		fldz
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				fld		dword ptr [edx+ecx]
			.endif
			ASSUME	eax:nothing
		.endif	
	.endif
	ret
CScriptGameObject@@GetInventoryItemFloat endp

align_proc
CScriptGameObject@@GetInventoryItemInt proc uses esi string_param:dword, param_offset:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		mov		ecx, param_offset
		mov		eax, [eax+ecx]
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				mov		eax, [edx+ecx]
			.endif
			ASSUME	eax:nothing
		.endif
	.endif
	ret
CScriptGameObject@@GetInventoryItemInt endp

align_proc
CScriptGameObject@@GetInventoryItemInt16 proc uses esi string_param:dword, param_offset:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		mov		ecx, param_offset
		movzx	eax, word ptr [eax+ecx]
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				movzx	eax, word ptr [edx+ecx]
			.endif
			ASSUME	eax:nothing
		.endif
	.endif
	ret
CScriptGameObject@@GetInventoryItemInt16 endp

align_proc
CScriptGameObject@@GetInventoryItemInt8 proc uses esi string_param:dword, param_offset:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		mov		ecx, param_offset
		movzx	eax, byte ptr [eax+ecx]
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				movzx	eax, byte ptr [edx+ecx]
			.endif
			ASSUME	eax:nothing
		.endif
	.endif
	ret
CScriptGameObject@@GetInventoryItemInt8 endp

align_proc
CScriptGameObject@@GetInventoryItemSharedStr proc uses esi
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		jmp		is_item
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		eax, [eax].m_car_weapon
			ASSUME	eax:nothing
			.if (eax)
is_item:
				mov		ecx, g_int_argument_0
				.if (ecx)
					mov		eax, [eax+ecx]
					.if (eax)
						add		eax,  12
						xor		ecx, ecx
						mov		g_int_argument_0, ecx
					.endif
				.endif
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@GetInventoryItemSharedStr endp

;===============================Запись=======================================
align_proc
CScriptGameObject@@SetInventoryItemFloat proc uses esi pvector_param:dword, param_float:dword, param_offset:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		mov		ecx, param_offset
		mov		edx, param_float
		mov		[eax+ecx], edx
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				mov		eax, param_float
				mov		[edx+ecx],eax
			.endif
			ASSUME	eax:nothing
		.endif
	.endif
	ret
CScriptGameObject@@SetInventoryItemFloat endp

align_proc
CScriptGameObject@@SetInventoryItemInt proc param_offset:dword, param_int:dword
	smart_cast	CInventoryItem, [ecx+4]
	.if (eax)
		mov		ecx, param_offset
		mov		edx, param_int
		mov		[eax+ecx], edx
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				mov		eax, param_int
				mov		[edx+ecx], eax
			.endif
			ASSUME	eax:nothing
		.endif
	.endif
	ret
CScriptGameObject@@SetInventoryItemInt endp

align_proc
CScriptGameObject@@SetInventoryItemInt16 proc uses esi param_offset:dword, word_param:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		mov		ecx, param_offset
		mov		edx, word_param
		mov		[eax+ecx], dx
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				mov		eax, word_param
				mov		[edx+ecx], ax
			.endif
			ASSUME	eax:nothing
		.endif
	.endif
	ret
CScriptGameObject@@SetInventoryItemInt16 endp

align_proc
CScriptGameObject@@SetInventoryItemInt8 proc uses esi param_offset:dword, byte_param:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		mov		ecx, param_offset
		mov		edx, byte_param
		mov		[eax+ecx], dl
	.else
		smart_cast	CCar, CGameObject, esi
		.if (eax)
			ASSUME	eax:ptr CCar
			mov		edx, [eax].m_car_weapon
			.if (edx)
				mov		ecx, param_offset
				mov		eax, byte_param
				mov		[edx+ecx], al
			.endif
			ASSUME	eax:nothing
		.endif
	.endif
	ret
CScriptGameObject@@SetInventoryItemInt8 endp

align_proc
CScriptGameObject@@SetInventoryItemSharedStr proc uses ebx esi string_param:dword, param_offset:dword
	mov		esi, [ecx+4]	; this
	smart_cast	CInventoryItem, esi
	.if (eax)
		jmp		is_item
	.endif
	smart_cast	CCar, CGameObject, esi
	.if (eax)
		ASSUME	eax:ptr CCar
		mov		eax, [eax].m_car_weapon
		ASSUME	eax:nothing
		.if (eax)
is_item:
			mov		ebx, eax
			add		ebx, param_offset
			mov		eax, string_param
			call	set_shared_str	; ebx = (shared_str*)	  eax = (char*)
		.endif
	.endif
	ret
CScriptGameObject@@SetInventoryItemSharedStr endp

;=============================================================================
; Доступ в памяти
;================================Чтение=======================================
align_proc
CScriptGameObject@@GetMemoryFloat proc param_offset:dword
	mov		eax, param_offset
	fld		dword ptr [eax]
	ret
CScriptGameObject@@GetMemoryFloat endp

align_proc
CScriptGameObject@@GetMemoryInt proc string_param:dword, param_offset:dword
	mov		ecx, param_offset
	mov		eax, [ecx]
	ret
CScriptGameObject@@GetMemoryInt endp

align_proc
CScriptGameObject@@GetMemoryInt16 proc string_param:dword, param_offset:dword
	mov		ecx, param_offset
	movzx	eax, word ptr [ecx]
	ret
CScriptGameObject@@GetMemoryInt16 endp

align_proc
CScriptGameObject@@GetMemoryInt8 proc string_param:dword, param_offset:dword
	mov		ecx, param_offset
	movzx	eax, byte ptr [ecx]
	ret
CScriptGameObject@@GetMemoryInt8 endp
;================================Запись=======================================
align_proc
CScriptGameObject@@SetMemoryFloat proc pvector_param:dword, param_float:dword, param_offset:dword
	mov		ecx, param_offset
	mov		edx, param_float
	mov		[ecx], edx
	ret
CScriptGameObject@@SetMemoryFloat endp

align_proc
CScriptGameObject@@SetMemoryInt proc param_offset:dword, dword_param:dword
	mov		eax, dword_param
	mov		ecx, param_offset
	mov		[ecx], eax
	ret
CScriptGameObject@@SetMemoryInt endp

align_proc
CScriptGameObject@@SetMemoryInt16 proc param_offset:dword, word_param:word
	mov		ax, word_param
	mov		ecx, param_offset
	mov		[ecx], ax
	ret
CScriptGameObject@@SetMemoryInt16 endp

align_proc
CScriptGameObject@@SetMemoryInt8 proc param_offset:dword, byte_param:byte
	mov		al, byte_param
	mov		ecx, param_offset
	mov		[ecx], al
	ret
CScriptGameObject@@SetMemoryInt8 endp
;==============================================================================
align_proc
CScriptGameObject@@GetActorConditionFloat proc param_offset:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor
		mov		ecx, param_offset
		mov		edx, [eax].CActor@m_entity_condition	; CActorCondition + 93Ch	
		fld		dword ptr [edx+ecx]
	.endif
	ret
CScriptGameObject@@GetActorConditionFloat endp

align_proc
CScriptGameObject@@GetActorConditionInt proc string_param:dword, param_offset:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, param_offset
		mov		edx, [eax].CActor@m_entity_condition	; CActorCondition + 93Ch	
		mov		eax, [edx+ecx]
	.endif
	ret
CScriptGameObject@@GetActorConditionInt endp

align_proc
CScriptGameObject@@SetActorConditionFloat proc param_vector:dword, param_float:dword, param_offset:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		eax, [eax].CActor@m_entity_condition		; CActorCondition*
		ASSUME	eax:nothing
		mov		ecx, param_offset
		mov		edx, param_float
		mov		[eax+ecx], edx
	.endif
	ret
CScriptGameObject@@SetActorConditionFloat endp

align_proc
CScriptGameObject@@SetHudSharedStr proc uses ebx string_param:dword, param_offset:dword
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		mov		ebx, eax
		add		ebx, param_offset
		mov		eax, string_param
		call	set_shared_str	; ebx = (shared_str*)	eax = (char*)
	.endif
	ret
CScriptGameObject@@SetHudSharedStr endp

align_proc
CScriptGameObject@@GetHudSharedStr proc
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		mov		edx, eax
		mov		eax, g_int_argument_0
		.if (eax)
			mov		eax, [edx+eax]
			.if (eax)
				add		eax, 12
				xor		ecx, ecx
				mov		g_int_argument_0, ecx
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@GetHudSharedStr endp

;==============================================================================

align_proc
CScriptGameObject@@GetFuel proc
	smart_cast	CCar, CGameObject, [ecx+4]
	ASSUME	eax:ptr CCar
	.if (eax)
		fld		[eax].m_fuel
	.endif
	ret
CScriptGameObject@@GetFuel endp

align_proc
CScriptGameObject@@GetFuelConsumption proc
	smart_cast	CCar, CGameObject, [ecx+4]
	.if (eax)
		fld		[eax].m_fuel_consumption
	.endif
	ret
CScriptGameObject@@GetFuelConsumption endp

align_proc
CScriptGameObject@@GetFuelTank proc
	smart_cast	CCar, CGameObject, [ecx+4]
	.if (eax)
		fld		[eax].m_fuel_tank
	.endif
	ret
CScriptGameObject@@GetFuelTank endp

align_proc
CScriptGameObject@@SetFuel proc fuel:dword
	smart_cast	CCar, CGameObject, [ecx+4]
	.if (eax)
		mov		edx, fuel
		mov		[eax].m_fuel, edx
	.endif
	ret
CScriptGameObject@@SetFuel endp

align_proc
CScriptGameObject@@SetFuelConsumption proc fuel_consum:dword
	smart_cast	CCar, CGameObject, [ecx+4]
	.if (eax)
		mov		edx, fuel_consum
		mov		[eax].m_fuel_consumption, edx
	.endif
	ASSUME	eax:nothing
	ret
CScriptGameObject@@SetFuelConsumption endp

align_proc
CScriptGameObject@@item_on_belt proc uses esi edi number:dword
	smart_cast	CInventoryOwner, [ecx+4]
	.if (eax)
		mov		esi, eax
		ASSUME	esi:ptr CInventoryOwner, edi:ptr CInventory
		mov		edi, [esi].m_inventory	; CInventory
		mov		edx, [edi].m_belt._Myfirst
		mov		ecx, number
		lea		ecx, [edx+ecx*4]
		xor		eax, eax
		.if ([edi].m_belt._Mylast>ecx)
			mov		eax, [ecx]
			.if (eax)
				ASSUME	eax:ptr CInventoryItem
				mov		edi, [eax].CInventoryItem@m_object ; inventory_item -> CGameObject
				call	CGameObject__lua_game_object
				ASSUME	eax:nothing
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@item_on_belt endp

align_proc
CScriptGameObject@@item_in_ruck proc uses esi edi number:dword
	smart_cast	CInventoryOwner, [ecx+4]
	.if (eax)
		mov		esi, eax
		mov		edi, [esi].m_inventory	; CInventory
		mov		edx, [edi].m_ruck._Myfirst
		mov		ecx, number
		lea		ecx, [edx+ecx*4]
		xor		eax, eax
		.if ([edi].m_ruck._Mylast>ecx)
			mov		eax, [ecx]
			.if (eax)
				ASSUME	eax:ptr CInventoryItem
				mov		edi, [eax].CInventoryItem@m_object ; inventory_item -> CGameObject
				call	CGameObject__lua_game_object
				ASSUME	eax:nothing
			.endif
		.endif
		ASSUME	esi:nothing, edi:nothing
	.endif
	ret
CScriptGameObject@@item_in_ruck endp

align_proc
CScriptGameObject@@SlotCount proc
	smart_cast	CInventoryOwner, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CInventoryOwner, ecx:ptr CInventory
		mov		ecx, [eax].m_inventory
		mov		eax, [ecx].m_slots._Mylast
		sub		eax, [ecx].m_slots._Myfirst
		sar		eax, 4			; eax/=16
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@SlotCount endp

align_proc
CScriptGameObject@@BeltCount proc
	smart_cast	CInventoryOwner, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CInventoryOwner, ecx:ptr CInventory
		mov		ecx, [eax].m_inventory
		mov		eax, [ecx].m_belt._Mylast
		sub		eax, [ecx].m_belt._Myfirst
		sar		eax, 2			; eax/=4
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@BeltCount endp

align_proc
CScriptGameObject@@RuckCount proc
	smart_cast	CInventoryOwner, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CInventoryOwner, ecx:ptr CInventory
		mov		ecx, [eax].m_inventory
		mov		eax, [ecx].m_ruck._Mylast
		sub		eax, [ecx].m_ruck._Myfirst
		sar		eax, 2			; eax/=4
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@RuckCount endp

align_proc
CScriptGameObject@@MoveToRuck proc uses ebx esi item:dword
	mov		ebx, [ecx+4]	; this
	mov		eax, item
	.if (eax)
		smart_cast	CInventoryItem, [eax+4]
		.if (eax)	; проверим что это инвентарный объект
			mov		esi, eax
			smart_cast	CInventoryOwner, ebx
			.if (eax)
				ASSUME	eax:ptr CInventoryOwner
				mov		eax, [eax].m_inventory
				ASSUME	eax:nothing
				; здесь имеем eax == inventory, esi == item
				push	esi
				mov		esi, eax
				call	CInventory__Ruck ; int this<esi>, int item
				call	GetGameSP
				.if (eax)
					ASSUME	eax:ptr CUIGameSP
					mov		eax, [eax].InventoryMenu	; CUIInventoryWnd*
					ASSUME	eax:nothing
					.if (eax)
						mov		byte ptr [eax+64h], 1 ; m_b_need_reinit = true
					.endif
				.endif
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@MoveToRuck endp

align_proc
CScriptGameObject@@GetInventoryWeight proc
local weight:dword
	smart_cast	CInventoryOwner, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CInventoryOwner
		mov		edi, [eax].m_inventory
		call	CInventory__CalcTotalWeight
		;результат в xmm0, копируем в стек сопроцессора.
		movss	weight, xmm0
		fld		weight
		ASSUME	eax:nothing
	.endif
	ret
CScriptGameObject@@GetInventoryWeight endp

align_proc
CScriptGameObject@@IsOnBelt proc uses ebx esi item:dword
	mov		ebx, [ecx+4]	; this
	mov		eax, item
	.if (eax)
		smart_cast	CInventoryItem, [eax+4]
		.if (eax)	; проверим что это инвентарный объект
			mov		esi, eax
			smart_cast	CInventoryOwner, ebx
			.if (eax)
				mov		ecx, [eax].CInventoryOwner.m_inventory
				; здесь имеем ecx == inventory, esi == item
				mov		eax, esi
				call	CInventory__InBelt ; int item<eax>, int this<ecx>
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@IsOnBelt endp

;"is_in_ruck"
align_proc
CScriptGameObject@@IsInRuck proc uses ebx esi item:dword
	mov		ebx, [ecx+4]	; this
	mov		eax, item
	.if (eax)
		smart_cast	CInventoryItem, [eax+4]
		.if (eax)	; проверим что это инвентарный объект
			mov		esi, eax
			smart_cast	CInventoryOwner, ebx
			.if (eax)
				ASSUME	eax:ptr CInventoryOwner
				mov		ecx, [eax].m_inventory
				ASSUME	eax:nothing
				; здесь имеем ecx == inventory, esi == item
				mov		eax, esi
				call	CInventory__CanPutInRuck ; int item<eax>, int this<ecx>
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@IsInRuck endp

;"is_in_slot"
align_proc
CScriptGameObject@@IsInSlot proc uses ebx edi item:dword
	mov		ebx, [ecx+4]	; this
	mov		eax, item
	.if (eax)
		smart_cast	CInventoryItem, [eax+4]
		.if (eax)	; проверим что это инвентарный объект
			mov		edi, eax
			smart_cast	CInventoryOwner, ebx
			.if (eax)
				ASSUME	eax:ptr CInventoryOwner
				mov		ebx, [eax].m_inventory
				ASSUME	eax:nothing
				; здесь имеем ebx = inventory, edi = item
				call	CInventory__InSlot	; int this<ebx>, int item<edi>
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@IsInSlot endp

;"move_to_belt"
align_proc
CScriptGameObject@@MoveToBelt proc uses ebx edi item:dword
	mov		ebx, [ecx+4]	; this
	mov		eax, item
	.if (eax)
		smart_cast	CInventoryItem, [eax+4]
		.if (eax)	; проверим что это инвентарный объект
			mov		edi, eax
			smart_cast	CInventoryOwner, ebx
			.if (eax)
				ASSUME	eax:ptr CInventoryOwner
				mov		eax, [eax].m_inventory
				ASSUME	eax:nothing
				; здесь имеем eax == inventory, edi == item
				push	edi
				call	CInventory__Belt ; this<eax>, int item <stack>
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@MoveToBelt endp

;"move_to_slot_and_activate"
align_proc
CScriptGameObject@@MoveToSlotAndActivate proc uses ebx esi item:dword
	mov		ebx, [ecx+4]	; this
	mov		eax, item
	.if (eax)
		smart_cast	CInventoryItem, [eax+4]
		.if (eax)	; проверим что это инвентарный объект
			mov		esi, eax
			smart_cast	CInventoryOwner, ebx
			.if (eax)
				ASSUME	eax:ptr CInventoryOwner
				mov		ecx, [eax].m_inventory
				ASSUME	eax:nothing
				; здесь имеем ecx == inventory, esi == item
				push	FALSE
				mov		eax, esi
				call	CInventory__Slot ; item<eax>, this<ecx>, bool activate <stack>
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@MoveToSlotAndActivate endp

;"move_to_slot"
align_proc
CScriptGameObject@@MoveToSlotNotActivate proc uses ebx esi item:dword
	mov		ebx, [ecx+4]	; this
	mov		eax, item
	.if (eax)
		smart_cast	CInventoryItem, [eax+4]
		.if (eax)	; проверим что это инвентарный объект
			mov		esi, eax
			smart_cast	CInventoryOwner, ebx
			.if (eax)
				mov		ecx, [eax].CInventoryOwner.m_inventory
				; здесь имеем ecx == inventory, esi == item
				push	TRUE
				mov		eax, esi
				call	CInventory__Slot ; item<eax>, this<ecx>, bool activate <stack>
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@MoveToSlotNotActivate endp

;"can_move_to_slot" ; --
;"can_move_to_ruck" ;--
;"can_move_to_belt" ; --
align_proc
CScriptGameObject@@SetSprintFactor proc sprint_factor:dword
	smart_cast	CActor, [ecx+4]
	ASSUME	eax:ptr CActor
	.if (eax)
		mov		ecx, sprint_factor
		mov		[eax].m_fSprintFactor, ecx
	.endif
	ret
CScriptGameObject@@SetSprintFactor endp

align_proc
CScriptGameObject@@GetSprintFactor proc
	smart_cast	CActor, [ecx+4]
	fldz
	.if (eax)
		fld		[eax].m_fSprintFactor
	.endif
	ret
CScriptGameObject@@GetSprintFactor endp

align_proc
CScriptGameObject@@ActorBodyState proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		eax, [eax].mstate_old
	.endif
	ASSUME	eax:nothing
	ret
CScriptGameObject@@ActorBodyState endp

align_proc
CScriptGameObject@@GetActorTakeDist proc
	smart_cast	CActor, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CInventory
		mov		ecx, [eax].m_inventory		; CInventory*	+298h
		fld		[ecx].m_fTakeDist
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetActorTakeDist endp

align_proc
CScriptGameObject@@SetActorTakeDist proc take_dist:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CInventory
		mov		edx, take_dist
		mov		ecx, [eax].m_inventory		; CInventory*	+298h
		mov		[ecx].m_fTakeDist, edx
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@SetActorTakeDist endp

align_proc
CScriptGameObject@@GetActorMaxWeight proc
	smart_cast	CActor, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CInventory
		mov		ecx, [eax].m_inventory		; CInventory*	+298h
		fld		[ecx].m_fMaxWeight
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetActorMaxWeight endp

align_proc
CScriptGameObject@@SetActorMaxWeight proc max_weight:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CInventory
		mov		edx, max_weight
		mov		ecx, [eax].m_inventory		; CInventory*	+298h
		mov		[ecx].m_fMaxWeight, edx
		call	UpdateInventoryWeightStatic
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@SetActorMaxWeight endp

align_proc
CScriptGameObject@@GetActorMaxWalkWeight proc
	smart_cast	CActor, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		ecx, [eax].CActor@m_entity_condition		; CActorCondition*	+93Ch
		fld		[ecx].m_MaxWalkWeight
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetActorMaxWalkWeight endp

align_proc
CScriptGameObject@@SetActorMaxWalkWeight proc max_walk_weight:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		edx, max_walk_weight
		mov		ecx, [eax].CActor@m_entity_condition		; CActorCondition*
		mov		[ecx].m_MaxWalkWeight, edx
		call	UpdateInventoryWeightStatic
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@SetActorMaxWalkWeight endp

align_proc
CScriptGameObject@@GetHudBoneID proc bone_name:dword, param_int:dword
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CHudItem, edx:ptr CWeaponHUD
		mov		edx, [eax].m_pHUD
		.if ([edx].m_bHidden)
			mov		eax, [edx].m_shared_data.p_
			ASSUME	eax:ptr weapon_hud_value
			mov		ecx, [eax].m_animations		; CKinematicsAnimated*
			ASSUME	eax:nothing, edx:nothing
			.if (ecx)
				smart_castV	CKinematics, IRender_Visual, ecx
				.if (eax)
					push	bone_name
					mov		ecx, eax
					call	ds:CKinematics__LL_BoneID
					ret
				.endif
			.endif
		.endif
	.endif
	mov		eax, -2
	ret
CScriptGameObject@@GetHudBoneID endp

align_proc
CScriptGameObject@@SetHudBoneVisible proc uses esi bone_name:dword, visible:dword
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CHudItem, edx:ptr CWeaponHUD
		mov		edx, [eax].m_pHUD
		.if ([edx].m_bHidden)
			mov		eax, [edx].m_shared_data.p_
			ASSUME	eax:ptr weapon_hud_value
			mov		ecx, [eax].m_animations		; CKinematicsAnimated*
			ASSUME	eax:nothing, edx:nothing
			.if (ecx)
				smart_castV	CKinematics, IRender_Visual, ecx
				.if (eax)
					mov		esi, eax
					push	bone_name
					mov		ecx, eax
					call	ds:CKinematics__LL_BoneID
					movzx	eax, ax
					push	TRUE
					push	visible
					push	eax			; bone_id
					mov		ecx, esi	; pHudVisual
					call	ds:CKinematics__LL_SetBoneVisible
					mov		ecx, esi
					call	ds:CKinematics__CalculateBones_Invalidate
					ret
				.endif
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@SetHudBoneVisible endp

align_proc
CScriptGameObject@@GetHudBoneVisible proc uses esi bone_name:dword, visible:dword
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CHudItem, edx:ptr CWeaponHUD
		mov		edx, [eax].m_pHUD
		.if ([edx].m_bHidden)
			mov		eax, [edx].m_shared_data.p_
			ASSUME	eax:ptr weapon_hud_value
			mov		ecx, [eax].m_animations		; CKinematicsAnimated*
			ASSUME	eax:nothing, edx:nothing
			.if (ecx)
				smart_castV	CKinematics, IRender_Visual, ecx
				.if (eax)
					mov		esi, eax
					push	bone_name
					mov		ecx, eax
					call	ds:CKinematics__LL_BoneID
					movzx	eax, ax
					push	eax		; bone_id
					mov		ecx, esi
					call	ds:CKinematics__LL_GetBoneVisible
					ret
				.endif
			.endif
		.endif
	.endif
	mov		eax, -2
	ret
CScriptGameObject@@GetHudBoneVisible endp

align_proc
CScriptGameObject@@GetBoneID proc bone_name:dword, param_int:dword
	mov		eax, [ecx+4]
	ASSUME	eax:ptr CGameObject
	mov		ecx, [eax].Visual_
	ASSUME	eax:nothing
	.if (ecx)
		smart_castV	CKinematics, IRender_Visual, ecx
		.if (eax)
			push	bone_name
			mov		ecx, eax
			call	ds:CKinematics__LL_BoneID
			movzx	eax, ax
			ret
		.endif
	.endif
	mov		eax, -1
	ret
CScriptGameObject@@GetBoneID endp

align_proc
CScriptGameObject@@SetWeaponBoneVisible proc uses esi bone_name:dword, visible:dword
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CWeapon
		mov		ecx, [eax].Visual_		;+168h
		ASSUME	eax:nothing
		.if (ecx)
			smart_castV	CKinematics, IRender_Visual, ecx
			mov		esi, eax		; esi = visual
			mov		ecx, esi		; this == visual
			push	bone_name
			call	ds:CKinematics__LL_BoneID
			movzx	eax, ax
			push	TRUE
			push	visible
			push	eax				; bone_id
			mov		ecx, esi
			call	ds:CKinematics__LL_SetBoneVisible
			mov		ecx, esi
			call	ds:CKinematics__CalculateBones_Invalidate
			mov		ecx, esi
			mov		eax, [ecx]
			mov		edx, [eax+40h]
			push	0
			call	edx
			mov		eax, 1 ; success
			ret
		.endif
	.endif
	xor		eax, eax ; fail
	ret
CScriptGameObject@@SetWeaponBoneVisible endp

align_proc
CScriptGameObject@@GetWeaponBoneVisible proc uses esi bone_name:dword, visible:dword
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CWeapon
		mov		ecx, [eax].Visual_		;+168h
		ASSUME	eax:nothing
		.if (ecx)
			smart_castV	CKinematics, IRender_Visual, ecx
			mov		esi, eax		; esi = visual
			mov		ecx, esi		; this == visual
			push	bone_name
			call	ds:CKinematics__LL_BoneID
			movzx	eax, ax
			push	eax				; bone_id
			mov		ecx, esi
			call	ds:CKinematics__LL_GetBoneVisible
			ret
		.endif
	.endif
	xor		eax, eax
	ret
CScriptGameObject@@GetWeaponBoneVisible endp

align_proc
CScriptGameObject@@GetCameraFOV proc
	fld		dword ptr g_fov
	ret
CScriptGameObject@@GetCameraFOV endp

align_proc
CScriptGameObject@@SetCameraFOV proc fov:dword
	mov		eax, fov
	mov		ecx, g_fov
	mov		g_last_fov, ecx
	mov		g_fov, eax
	ret
CScriptGameObject@@SetCameraFOV endp

align_proc
CScriptGameObject@@SetActorVisual proc uses esi ebx NewVisual:dword
local visual_name:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)	
		mov		esi, eax
		lea		ebx, visual_name
		mov		eax, NewVisual
		call	set_shared_str	; ebx = (shared_str*)	eax = (char*)
		mov		ecx, esi
		invoke	CActor@@ChangeVisual, visual_name
		dec		dword ptr [ebx]
	.endif
	ret
CScriptGameObject@@SetActorVisual endp

align_proc
CScriptGameObject@@OpenInventoryBox proc uses esi edi SGO_inv_box:dword
	mov		esi, [ecx+4] ; SGO_actor
	call	GetGameSP
	.if (eax)
		mov		edi, eax ; hud
		mov		ecx, SGO_inv_box
		smart_cast	CInventoryBox, CGameObject, [ecx+4]
		.if (eax)
			push	eax
			smart_cast	CInventoryOwner, esi
			push	eax
			mov		eax, edi
			call	CUIGameSP__StartCarBody
		.endif
	.endif
	ret
CScriptGameObject@@OpenInventoryBox endp

align_proc
GetGameSP proc uses ecx edx ; no args, eax - result
	mov		ecx, ds:g_pGameLevel
	mov		edx, [ecx]
	mov		ecx, [edx].CLevel.pHUD	;+148h
	mov		eax, [ecx]
	mov		edx, [eax+18h]
	call	edx		; GetUI
	mov		eax, [eax].CUI.pUIGame	;CUIGameCustom*	+2Ch
	.if (eax)
		smart_cast	CUIGameSP, CUIGameCustom, eax
	.endif
	ret
GetGameSP endp

align_proc
CScriptGameObject@@item_in_inv_box proc index_item:dword
	smart_cast	CInventoryBox, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CInventoryBox
		mov		ecx, [eax].m_items._Myfirst		; items.begin
		mov		eax, [eax].m_items._Mylast		; items.end
		sub		eax, ecx
		sar		eax, 1		  ; eax = items.size()
		mov		edx, index_item
		.if (eax>edx)
			movzx	eax, word ptr [ecx+edx*2] ; eax == id
			push	eax
			call	get_object_by_id
			add		esp, 4
		.endif
		ASSUME	eax:nothing
	.endif
	ret
CScriptGameObject@@item_in_inv_box endp

align_proc
CScriptGameObject@@InvBoxCount proc
	smart_cast	CInventoryBox, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CInventoryBox
		mov		edx, [eax].m_items._Mylast		; items.end
		sub		edx, [eax].m_items._Myfirst		; items.begin
		sar		edx, 1		  ; eax = items.size()
		mov		eax, edx
		ASSUME	eax:nothing
	.endif
	ret
CScriptGameObject@@InvBoxCount endp

align_proc
CScriptGameObject@@GetWeght proc
	smart_cast	CInventoryItem, [ecx+4]
	.if (eax)
		mov		ecx, eax
		mov		eax, [ecx]
		mov		edx, [eax+90h]
		call	edx
	.endif
	ret
CScriptGameObject@@GetWeght endp

align_proc
CScriptGameObject@@GetHolderOwner proc
	smart_cast	CHolderCustom, [ecx+4]
	.if (eax)
		mov		eax, [eax].CHolderCustom.m_owner
		CGameObject@@lua_game_object()
	.endif
	ret
CScriptGameObject@@GetHolderOwner endp

align_proc
CScriptGameObject@@ChangeBleedingSpeed proc uses edi bleeding_delta:dword
	smart_cast	CEntityAlive, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CEntityAlive
		mov		edi, [eax].CEntityAlive@m_entity_condition		; CEntityCondition*
		push	bleeding_delta
		call	CEntityCondition__ChangeBleeding
		ASSUME	eax:nothing
	.endif
	ret
CScriptGameObject@@ChangeBleedingSpeed endp

;"get_hud_bone_pos"
align_proc
CScriptGameObject@@hud_bone_position proc uses esi edi ebx result_vector:dword, bone_name:dword
local matrix:Fmatrix4
	mov		ebx, result_vector
	ASSUME	edi:ptr CWeaponHUD, esi:ptr CKinematics, ebx:ptr Fvector
	Fvector_set	[ebx], 0, 0, 0
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		;CWeaponHUD*	wpn_hud = obj->GetHUD;
		mov		edi, [eax].CHudItem.m_pHUD
		.if (![edi].m_bHidden)
			mov		eax, [edi].m_shared_data.p_
			mov		ecx, [eax].weapon_hud_value.m_animations		; CKinematicsAnimated*
			.if (ecx)
				mov		esi, ecx
				;bone_id	= K->LL_BoneID(bone_name);
				push	bone_name
				call	ds:CKinematics__LL_BoneID
				movzx	eax, ax		;=bone_id
				.if (ax!=-1)
					;matrix.mul_43(wpn_hud->Transform(), K->LL_GetTransform(bone_id));
					imul	ecx, eax, sizeof CBoneInstance
					add		ecx, [esi].bone_instances
					Fmatrix4@mul_43	matrix, [edi].m_Transform, [ecx].CBoneInstance.mTransform
					Fvector_set	[ebx], matrix.c_
				.endif
			.endif
		.endif
	.endif
	ASSUME	edi:nothing, esi:nothing, ebx:nothing
	mov		eax, ebx
	ret
CScriptGameObject@@hud_bone_position endp

align_proc
CScriptGameObject@@GetSpecificProfile proc
	call	CScriptGameObject__ID			;get id
	push	eax
	;input: eax - game id (uint)
	call	ch_info_get_from_id				;get CSE_ALifeTraderAbstract by id
	add		esp, 4
	;output: eax - CSE_ALifeTraderAbstract
	mov		eax, [eax+3Ch]
	add		eax, 12
	xor		ecx, ecx
	mov		g_int_argument_0, ecx
	ret
CScriptGameObject@@GetSpecificProfile endp

;убираем лишние действия при выключении уже выключенной инфопорции
align_proc
CScriptGameObject@@disable_info_portion_fix proc uses esi info_id:dword
	mov		esi, ecx
	push	info_id
	call	CScriptGameObject@@HasInfo
	.if (al) ; если инфопорция есть, то будем забирать. Продолжаем как обычно
		;а иначе, просто выходим из функции, поскольку делать нечего
		mov		ecx, esi
		push	info_id
		call	CScriptGameObject@@DisableInfoPortion
	.endif
	ret
CScriptGameObject@@disable_info_portion_fix endp

align_proc
CScriptGameObject@@ProjectorOn proc uses esi
	smart_cast	CProjector, CGameObject, [ecx+4]
	.if (eax)
		mov		esi, eax
		call	CProjector__TurnOn
	.endif
	ret
CScriptGameObject@@ProjectorOn endp

align_proc
CScriptGameObject@@ProjectorOff proc uses esi
	smart_cast	CProjector, CGameObject, [ecx+4]
	.if (eax)
		mov		esi, eax
		call	CProjector__TurnOff
	.endif
	ret
CScriptGameObject@@ProjectorOff endp

align_proc
CScriptGameObject@@ProjectorIsOn proc
	smart_cast	CProjector, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CProjector
		mov		ecx, [eax].light_render.p_		;+1C8h
		ASSUME	eax:nothing
		mov		eax, [ecx]
		mov		edx, [eax+8]
		call	edx
	.endif
	ret
CScriptGameObject@@ProjectorIsOn endp

align_proc
CScriptGameObject@@SwitchProjector proc uses esi state:byte
	smart_cast	CProjector, CGameObject, [ecx+4]
	.if (eax)
		mov		esi, eax
		.if (state)
			call	CProjector__TurnOn
		.else
			call	CProjector__TurnOff
		.endif
	.endif
	ret
CScriptGameObject@@SwitchProjector endp

align_proc
CScriptGameObject@@SwitchTorch proc state:byte
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		mov		ecx, eax
		movzx	eax, state
		call	CTorch__Switch
	.endif
	ret
CScriptGameObject@@SwitchTorch endp

align_proc
CScriptGameObject@@SetTorchRange proc range:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CTorch
		mov		ecx, [eax].light_render.p_
		ASSUME	eax:nothing
		push	range
		mov		eax, [ecx]
		mov		edx, [eax+20h]
		call	edx
	.endif
	ret
CScriptGameObject@@SetTorchRange endp

align_proc
CScriptGameObject@@SetTorchColor proc color:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CTorch, edx:ptr Fvector
		mov		ecx, [eax].light_render.p_
		mov		edx, color
		push	[edx].x
		push	[edx].y
		push	[edx].z
		ASSUME	eax:nothing, edx:nothing
		mov		eax, [ecx]
		mov		edx, [eax+2Ch]
		call	edx
	.endif
	ret
CScriptGameObject@@SetTorchColor endp

align_proc
CScriptGameObject@@SetTorchOmniRange proc range:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CTorch
		mov		ecx, [eax].light_omni.p_
		ASSUME	eax:nothing
		push	range
		mov		eax, [ecx]
		mov		edx, [eax+20h]
		call	edx
	.endif
	ret
CScriptGameObject@@SetTorchOmniRange endp

align_proc
CScriptGameObject@@SetTorchOmniColor proc color:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CTorch, edx:ptr Fvector
		mov		ecx, [eax].light_omni.p_
		mov		edx, color
		push	[edx].x
		push	[edx].y
		push	[edx].z
		ASSUME	eax:nothing, edx:nothing
		mov		eax, [ecx]
		mov		edx, [eax+2Ch]
		call	edx
	.endif
	ret
CScriptGameObject@@SetTorchOmniColor endp

align_proc
CScriptGameObject@@SetTorchGlowRadius proc radius:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CTorch
		mov		ecx, [eax].glow_render.p_
		ASSUME	eax:nothing
		mov		eax, [ecx]
		mov		edx, [eax+10h]
		push	radius
		call	edx
	.endif
	ret
CScriptGameObject@@SetTorchGlowRadius endp

align_proc
CScriptGameObject@@SetTorchSpotAngle proc angle:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CTorch
		mov		ecx, [eax].light_render.p_
		ASSUME	eax:nothing
		mov		eax, [ecx]
		mov		edx, [eax+1Ch]
		movss	xmm0, angle
		mulss_c	xmm0, 0.017453293
		movss	angle, xmm0
		push	angle
		call	edx
	.endif
	ret
CScriptGameObject@@SetTorchSpotAngle endp

align_proc
CScriptGameObject@@IsTorchEnabled proc
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CTorch
		movzx	eax, [eax].m_switched_on
		ASSUME	eax:nothing
	.endif
	ret
CScriptGameObject@@IsTorchEnabled endp

align_proc
CScriptGameObject@@SetTorchColorAnimator proc uses esi color:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	esi:ptr CTorch
		mov		esi, eax
		mov		ecx, ds:off_1045862C ;?LALib@@3VELightAnimLibrary@@A
		push	color
		call	ds:off_10458630 ;?FindItem@ELightAnimLibrary@@QAEPAVCLAItem@@PBD@Z
		mov		[esi].lanim, eax
		mov		eax, esi
		ASSUME	esi:nothing
	.endif
	ret
CScriptGameObject@@SetTorchColorAnimator endp

align_proc
CScriptGameObject@@SetBoneVisible proc uses esi bone_name:dword, visible:dword
	mov		edx, [ecx+4]
	ASSUME	edx:ptr CGameObject
	mov		ecx, [edx].Visual_
	xor		eax, eax
	.if (ecx)
		smart_castV	CKinematics, IRender_Visual, ecx
		mov		esi, eax ; esi = visual
		push	bone_name
		mov		ecx, eax ; this == visual
		call	ds:CKinematics__LL_BoneID
		movzx	eax, ax
		push	TRUE
		push	visible
		push	eax ; bone_id
		mov		ecx, esi
		call	ds:CKinematics__LL_SetBoneVisible
		mov		ecx, esi
		call	ds:CKinematics__CalculateBones_Invalidate
		mov		ecx, esi
		mov		eax, [ecx]
		mov		edx, [eax+40h]
		push	0
		call	edx
		mov		eax, 1 ; success
	.endif
	ASSUME	edx:nothing
	ret
CScriptGameObject@@SetBoneVisible endp

align_proc
CScriptGameObject@@GetBoneVisible proc uses esi bone_name:dword, visible:dword
	mov		edx, [ecx+4]
	ASSUME	edx:ptr CGameObject
	mov		ecx, [edx].Visual_
	xor		eax, eax
	.if (ecx)
		smart_castV	CKinematics, IRender_Visual, ecx
		mov		esi, eax ; esi = visual
		mov		ecx, eax ; this == visual
		push	bone_name
		call	ds:CKinematics__LL_BoneID
		movzx	eax, ax
		push	eax ; bone_id
		mov		ecx, esi
		call	ds:CKinematics__LL_GetBoneVisible
	.endif
	ASSUME	edx:nothing
	ret
CScriptGameObject@@GetBoneVisible endp

align_proc
CScriptGameObject@@GetVisualIni proc
	mov		edx, [ecx+4]
	;return ((CScriptIniFile*)smart_cast<CKinematics*>(object().Visual())->LL_UserData());
	ASSUME	edx:ptr CGameObject, eax:ptr CKinematics
	smart_castV	CKinematics, IRender_Visual, [edx].Visual_
	mov		eax, [eax].pUserData		;CInifile = CScriptIniFile
	ASSUME	edx:nothing, eax:nothing
	ret
CScriptGameObject@@GetVisualIni endp

align_proc
CScriptGameObject@@GetMaxPower proc
	smart_cast	CActor, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		ecx, [eax].CActor@m_entity_condition	; CActorCondition
		fld		[ecx].m_fPowerMax
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetMaxPower endp

align_proc
CScriptGameObject@@ChangeMaxPower proc add_max_power:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		ecx, [eax].CActor@m_entity_condition	; CActorCondition
		movss	xmm0, [ecx].m_fPowerMax
		addss	xmm0, add_max_power
		float@clamp	xmm0, 0.0, 1.0
		movss	[ecx].m_fPowerMax, xmm0
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@ChangeMaxPower endp

align_proc
CScriptGameObject@@GetAlcohol proc
	smart_cast	CActor, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		ecx, [eax].CActor@m_entity_condition	; CActorCondition
		fld		[ecx].m_fAlcohol
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetAlcohol endp

align_proc
CScriptGameObject@@ChangeAlcohol proc add_alcohol:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		ecx, [eax].CActor@m_entity_condition	; CActorCondition
		movss	xmm0, [ecx].m_fAlcohol
		addss	xmm0, add_alcohol
		float@clamp	xmm0, 0.0, 1.0
		movss	[ecx].m_fAlcohol, xmm0
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@ChangeAlcohol endp

align_proc
CScriptGameObject@@GetSatiety proc
	smart_cast	CActor, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		ecx, [eax].CActor@m_entity_condition	; CActorCondition
		fld		[ecx].m_fSatiety
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetSatiety endp

align_proc
CScriptGameObject@@ChangeSatiety proc add_satiety:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor, ecx:ptr CActorCondition
		mov		ecx, [eax].CActor@m_entity_condition	; CActorCondition
		movss	xmm0, [ecx].m_fSatiety
		addss	xmm0, add_satiety
		float@clamp	xmm0, 0.0, 1.0
		movss	[ecx].m_fSatiety, xmm0
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@ChangeSatiety endp

align_proc
CScriptGameObject@@UpdateCondition proc uses ebx esi edi
	smart_cast	CEntityAlive, [ecx+4]
	.if (eax)
		;PRINT "updating condition"
		mov		ecx, eax
		mov		ebx, eax
		ASSUME	ebx:ptr CEntityAlive
		mov		esi, [ebx].CEntityAlive@m_entity_condition
		call	CEntityCondition__UpdateConditionTime
		mov		ecx, [ebx].CEntityAlive@m_entity_condition
		mov		eax, [ecx]
		mov		edx, [eax+24h]
		call	edx
		mov		edi, [ebx].CEntityAlive@m_entity_condition
		call	CEntityCondition__UpdateWounds
		ASSUME	ebx:nothing
	.endif
	ret
CScriptGameObject@@UpdateCondition endp

static_int	g_hud_animation_channel			, 0
static_int	g_hud_animation_callback_param	, 0
static_byte	g_use_hud_animation_callback	, 0

align_proc
CScriptGameObject@@SetHudAnimationChannel proc channel:dword
	mrm		g_hud_animation_channel, channel
	ret
CScriptGameObject@@SetHudAnimationChannel endp

align_proc
CScriptGameObject@@SetHudAnimationCallbackParam proc param_dword:dword
	mov		eax, param_dword
	PRINT_UINT "set anim callback param: %d", eax
	mov		g_hud_animation_callback_param, eax
	ret
CScriptGameObject@@SetHudAnimationCallbackParam endp

align_proc
CScriptGameObject@@SetUseHudAnimationCallback proc param_byte:byte
	movzx	eax, param_byte
	PRINT_UINT "set use anim: %d", eax
	mov		g_use_hud_animation_callback, al
	ret
CScriptGameObject@@SetUseHudAnimationCallback endp

align_proc
on_animation_end_callback proc B:dword
	mov		eax, B
	PRINT_UINT "on_animation_end_callback: %x", eax
	mov		eax, [eax+38h]
	PRINT_UINT "value: %d", eax
	; вызываем колбек
	mov		eax, B
	CALLBACK__INT_INT	g_Actor, 157, [eax+38h], eax
	ret
on_animation_end_callback endp

align_proc
CScriptGameObject@@PlayHudAnimation proc uses esi name_anim:dword, mix_in:byte
local motion_ID:word
	call	CScriptGameObject@@GetHudVisual
	mov		esi, eax
	mov		ecx, esi ; this == ecx
	push	name_anim
	lea		eax, motion_ID
	push	eax
	call	ds:CKinematicsAnimated__ID_Cycle
	.if (motion_ID!=-1)
		push	g_hud_animation_channel
		xor		eax, eax
		mov		g_hud_animation_channel, eax
		push	g_hud_animation_callback_param
		; обнуляем параметр для последующих вызовов
		mov		g_hud_animation_callback_param, eax
		.if (g_use_hud_animation_callback)
			mov		g_use_hud_animation_callback, al
			mov		eax, offset on_animation_end_callback
		.endif
		push	eax
		movzx	eax, mix_in
		push	eax
		movzx	eax, motion_ID
		push	eax
		mov		ecx, esi ; this == ecx
		call	ds:CKinematicsAnimated__PlayCycle
	.endif
	ret
CScriptGameObject@@PlayHudAnimation endp

align_proc
CScriptGameObject@@GetHudVisual proc
	smart_cast	CHudItem, CGameObject, [ecx+4]
	ASSUME	eax:ptr CHudItem, edx:ptr CWeaponHUD
	mov		edx, [eax].m_pHUD
	.if ([edx].m_bHidden)
		mov		eax, [edx].m_shared_data.p_
		ASSUME	eax:ptr weapon_hud_value
		mov		ecx, [eax].m_animations		; CKinematicsAnimated*
		ASSUME	eax:nothing, edx:nothing
		.if (ecx)
			smart_castV	CKinematics, IRender_Visual, ecx
			ret
		.endif
	.endif
	xor		eax, eax
	ret
CScriptGameObject@@GetHudVisual endp

align_proc
CScriptGameObject@@SaveHudBoneFloat proc bone_name:dword, param_offset:dword
	call	CScriptGameObject@@GetHudVisual
	.if (eax)
		mov		esi, eax
		push	bone_name
		mov		ecx, esi ; this == ecx
		call	ds:CKinematics__LL_BoneID
		movzx	eax, ax
		.if (ax!=-1)
			lea		eax, [eax+eax*4]
			shl		eax, 5
			add		eax, [esi+84h] ; eax == bone_instance
			mov		ecx, param_offset
			mov		eax, [eax+ecx] ; value
		.endif
	.endif
	ret
CScriptGameObject@@SaveHudBoneFloat endp

align_proc
CScriptGameObject@@InvalidateInventory proc
	smart_cast	CInventoryOwner, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CInventoryOwner, edx:ptr CInventory
		mov		edx, [eax].m_inventory
		mov		ecx, ds:Device
		mov		ecx, [ecx+0F4h]
		mov		[edx].m_dwModifyFrame, ecx
		ASSUME	eax:nothing, edx:nothing
	.endif
	ret
CScriptGameObject@@InvalidateInventory endp

align_proc
CScriptGameObject@@NonscriptUsable proc
	mov		ecx, [ecx+4]
	movzx	eax, [ecx].CGameObject.m_bNonscriptUsable
	ret
CScriptGameObject@@NonscriptUsable endp

align_proc
CScriptGameObject@@SetGoodwillByID proc for_who:dword, to_who:dword, goodwill:dword
	push	to_who
	push	for_who
	mov		eax, goodwill
	call	RELATION_REGISTRY__SetGoodwill
	ret
CScriptGameObject@@SetGoodwillByID endp

align_proc
CScriptGameObject@@ChangeGoodwillByID proc uses edi for_who:dword, to_who:dword, goodwill:dword
	push	goodwill
	push	for_who
	mov		edi, to_who
	call	RELATION_REGISTRY__ChangeGoodwill
	ret
CScriptGameObject@@ChangeGoodwillByID endp

align_proc
CScriptGameObject@@AttachVehicle proc uses edi vehicle:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		edi, eax
		mov		eax, vehicle
		.if (eax)
			smart_cast	CHolderCustom, [eax+4]
			.if (eax)
				call	CActor__attach_Vehicle ; vehicle<eax>, CActor<edi>
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@AttachVehicle endp

align_proc
CScriptGameObject@@EnableCarPanel proc is_visible:byte
	mov		eax, [ecx+4]
	smart_cast	CCar, CGameObject, eax
	ASSUME	eax:ptr CCar
	.if (eax)
		mov		dl, is_visible
		mov		[eax].m_car_panel_visible, dl
	.endif
	ASSUME	eax:nothing
	ret
CScriptGameObject@@EnableCarPanel endp

_static		g_vector_arg_1 Fvector {0.0, 0.0, 0.0}
_static		g_vector_arg_2 Fvector {0.0, 0.0, 0.0}
_static		g_vector_arg_3 Fvector {0.0, 0.0, 0.0}
_static		g_vector_arg_4 Fvector {0.0, 0.0, 0.0}

align_proc
CScriptGameObject@@SetVectorGlobalArg1 proc pvector:dword
	mov		edx, pvector
	mov		ecx, offset g_vector_arg_1
	ASSUME	ecx:ptr Fvector, edx:ptr Fvector
	Fvector_set	[ecx], [edx].x, [edx].y, [edx].z
	ret
CScriptGameObject@@SetVectorGlobalArg1 endp

align_proc
CScriptGameObject@@SetVectorGlobalArg2 proc pvector:dword
	mov		edx, pvector
	mov		ecx, offset g_vector_arg_2
	Fvector_set	[ecx], [edx].x, [edx].y, [edx].z
	ret
CScriptGameObject@@SetVectorGlobalArg2 endp

align_proc
CScriptGameObject@@SetVectorGlobalArg3 proc pvector:dword
	mov		edx, pvector
	mov		ecx, offset g_vector_arg_3
	Fvector_set	[ecx], [edx].x, [edx].y, [edx].z
	ret
CScriptGameObject@@SetVectorGlobalArg3 endp

align_proc
CScriptGameObject@@SetVectorGlobalArg4 proc pvector:dword
	mov		edx, pvector
	mov		ecx, offset g_vector_arg_4
	Fvector_set	[ecx], [edx].x, [edx].y, [edx].z
	ASSUME	ecx:nothing, edx:nothing
	ret
CScriptGameObject@@SetVectorGlobalArg4 endp

static_int		g_object_arg_1, ?
align_proc
CScriptGameObject@@SetGOArg1 proc object:dword
	mrm		g_object_arg_1, object
	ret
CScriptGameObject@@SetGOArg1 endp

actor_id		= word ptr 0
align_proc
CScriptGameObject@@GetHudItemState proc uses esi
	mov		esi, [ecx+4]
	ASSUME	esi:ptr CGameObject, eax:ptr CGameObject
	mov		eax, [esi].Parent
	.if (eax && [eax].ID==actor_id)
		ASSUME	esi:nothing, eax:nothing
		smart_cast	CInventoryItem, esi
		.if (eax)
			mov		ecx, eax
			mov		eax, [ecx]
			mov		edx, [eax+124h]	  ; cast_hud_item
			call	edx			   ; CInventoryItem::cast_hud_item()
			.if (eax)
				mov		eax, [eax+4]   ; m_state
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@GetHudItemState endp

align_proc
CScriptGameObject@@SetActorDirectionEx proc dir_vector:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor, edx:ptr Fvector
		mov		ecx, [eax].cam_active
		mov		ecx, [eax].cameras[ecx*4]
		mov		edx, dir_vector
		push	[edx].z
		push	[edx].y
		push	[edx].x
		ASSUME	eax:nothing, edx:nothing
		mov		eax, [ecx]
		mov		edx, [eax+1Ch]
		call	edx
	.endif
	ret
CScriptGameObject@@SetActorDirectionEx endp

align_proc
CScriptGameObject@@GetVisualName proc
	mov		edx, [ecx+4]
	ASSUME	edx:ptr CGameObject, ecx:ptr str_value
	mov		ecx, [edx].NameVisual
	lea		eax, [ecx].value
	ASSUME	edx:nothing, ecx:nothing
	ret
CScriptGameObject@@GetVisualName endp

;// TODO: Функцию необходимо определить для разных классов,
;// потому что стандартное изменение работает не совсем корректно. (с) inelisoni
; Точне совсем не корректно, для сталкеров и монстров. Надо перезапустить имунитеты, физику тела и анимацию. НаноБот
align_proc
CScriptGameObject@@SetVisualName proc uses ebx esi edi NewVisual:dword
local visual_name:shared_str
	mov		esi, [ecx+4]
	ASSUME	esi:ptr CGameObject, ebx:ptr str_value
	;visual_name = NewVisual
	xor		eax, eax
	mov		visual_name.p_, eax
	lea		ebx, visual_name
	mov		eax, NewVisual
	call	set_shared_str
	mov		ebx, eax
	mov		edx, [esi].NameVisual
	ASSUME	edx:ptr str_value
;	PRINT_UINT "visual_name.dwReference[%d]", [ebx].dwReference
;	PRINT_UINT "visual_name.dwLength[%d]", [ebx].dwLength
;	PRINT_UINT "visual_name.dwCRC[%08X]", [ebx].dwCRC
;	lea		eax, [ebx].value
;	PRINT_UINT "visual_name.value[%s]", eax
	mov		ecx, [edx].dwCRC
	mov		eax, [edx].dwLength
	ASSUME	edx:nothing
	.if (ebx && ([ebx].dwLength!=eax || [ebx].dwCRC!=ecx))
		smart_cast	CActor, esi
		.if (eax)
			mov		ecx, eax
			invoke	CActor@@ChangeVisual, visual_name.p_
			jmp		exit
		.endif
		smart_cast	CBaseMonster, esi
		.if (eax)
			mov		ecx, eax
			invoke	CBaseMonster@@SetVisualName, visual_name.p_
			jmp		exit
		.endif
		smart_cast	CAI_Stalker, esi
		.if (eax)
			mov		ecx, eax
			invoke	CAI_Stalker@@SetVisualName, visual_name.p_
			jmp		exit
		.endif
		smart_cast	CEntity, esi
		.if (eax)
			mov		ecx, eax
			invoke	CEntity@@SetVisualName, visual_name.p_
			jmp		exit
		.endif
		smart_cast	CWeapon, esi
		.if (eax)
			mov		edi, eax
			mov		ecx, esi
			invoke2	CObject@@cNameVisual_set, visual_name.p_
			call	CWeapon__UpdateAddonsVisibility
		.else
			mov		ecx, esi
			invoke2	CObject@@cNameVisual_set, visual_name.p_
			;// Обновление костей.
			mov		edi, [esi].Visual_
			.if (edi)
				mov		ecx, edi
				call	ds:CKinematics__CalculateBones_Invalidate
				;kinematics->CalculateBones();
				mov		ecx, edi
				push	0
				mov		eax, [ecx]
				mov		edx, [eax+40h]
				call	edx
			.endif
		.endif
exit:
		dec		[ebx].dwReference
;		PRINT_UINT "visual_name.dwReference[%d]", [ebx].dwReference
;		PRINT_UINT "visual_name.dwLength[%d]", [ebx].dwLength
;		PRINT_UINT "visual_name.dwCRC[%08X]", [ebx].dwCRC
;		lea		eax, [ebx].value
;		PRINT_UINT "visual_name.value[%s]", eax
	.endif
	ASSUME	esi:nothing, ebx:nothing
	ret
CScriptGameObject@@SetVisualName endp

align_proc
CBaseMonster@@SetVisualName proc uses esi edi NewVisual:dword
	mov		esi, ecx
	ASSUME	esi:ptr CBaseMonster, edi:ptr str_value
	;загрузим новый визуал
	invoke2	CObject@@cNameVisual_set, NewVisual
	;перезагрузим имунитеты
	mov		edi, [esi].NameSection
	inc		[edi].dwReference
	lea		eax, [edi].value
	mov		ecx, ds:pSettings
	mov		edx, [ecx]
	push	edx
	push	offset aDamage		; "damage"
	push	eax
	lea		ecx, [esi].CDamageManager@vfptr
	call	CDamageManager@@reload
	dec		[edi].dwReference
	;перезагрузим физику тела
	mov		eax, [esi].m_pPhysics_support	; CCharacterPhysicsSupport*
	call	CCharacterPhysicsSupport@@in_ChangeVisual
	.if (@g_Alive([esi]))
		;перезапустим анимации
		mov		eax, [esi].m_control_manager			; CControl_Manager*
		mov		eax, [eax+CControl_Manager.m_animation]	; CControlAnimation*
		call	CControlAnimation@@restart
	.endif
	ASSUME	esi:nothing, edi:nothing
	ret
CBaseMonster@@SetVisualName endp

;Для сталкеров
align_proc
CAI_Stalker@@SetVisualName proc uses esi edi NewVisual:dword
	mov		esi, ecx
	ASSUME	esi:ptr CAI_Stalker, edi:ptr str_value
	ASSUME	ecx:ptr CKinematicsAnimated
	mov		ecx, [esi].Visual_
	mov		eax, [ecx].m_Motions._Mylast
	sub		eax, [ecx].m_Motions._Myfirst
	xor		edx, edx
	mov		ecx, 20
	idiv	ecx
	PRINT_UINT "m_Motions.size() = %d", eax
	mov		ecx, esi
	ASSUME	ecx:nothing
	;загрузим новый визуал
	invoke2	CObject@@cNameVisual_set, NewVisual
	;перезагрузим имунитеты
	mov		edi, [esi].NameSection
	inc		[edi].dwReference
	lea		eax, [edi].value
	mov		ecx, ds:pSettings
	mov		edx, [ecx]
	push	edx
	push	offset aDamage		; "damage"
	push	eax
	lea		ecx, [esi].CDamageManager@vfptr
	call	CDamageManager@@reload
	dec		[edi].dwReference
	;перезагрузим физику тела
	mov		eax, [esi].m_pPhysics_support	; CCharacterPhysicsSupport*
	call	CCharacterPhysicsSupport@@in_ChangeVisual
	.if (@g_Alive([esi]))
		;перезапустим анимации
		mov		ecx, [esi].m_animation_manager	; CStalkerAnimationManager*
		call	CStalkerAnimationManager@@restart
	.endif
	ASSUME	esi:nothing, edi:nothing
	ret
CAI_Stalker@@SetVisualName endp

align_proc
CEntity@@SetVisualName proc uses esi edi NewVisual:dword
	mov		esi, ecx
	ASSUME	esi:ptr CEntity, edi:ptr str_value
	;загрузим новый визуал
	invoke2	CObject@@cNameVisual_set, NewVisual
	;перезагрузим имунитеты
	mov		edi, [esi].NameSection
	inc		[edi].dwReference
	lea		eax, [edi].value
	mov		ecx, ds:pSettings
	mov		edx, [ecx]
	push	edx
	push	offset aDamage		; "damage"
	push	eax
	lea		ecx, [esi].CDamageManager@vfptr
	call	CDamageManager@@reload
	dec		[edi].dwReference
	.if (@g_Alive([esi]))
		;перезапустим анимации
		mov		ecx, [esi].Visual_
		.if (ecx)
			ASSUME	ecx:ptr CKinematicsAnimated
			mov		eax, [ecx].m_Motions._Mylast
			sub		eax, [ecx].m_Motions._Myfirst
			xor		edx, edx
			mov		ecx, 20
			idiv	ecx
			PRINT_UINT "m_Motions.size() = %d", eax
			;invoke2	CKinematicsAnimated@@PlayCycle, edx, TRUE, NULL, NULL, 0
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing, ecx:nothing
	ret
CEntity@@SetVisualName endp

align_proc
CStalkerAnimationManager@@restart_global_anim proc uses ebx callback:dword
local time_saved:dword
;edi - this		CStalkerAnimationManager*
;esi - part		CStalkerAnimationPair*
	ASSUME	edi:ptr CStalkerAnimationManager, esi:ptr CStalkerAnimationPair, eax:ptr CBlend
	movzx	eax, [esi].m_animation.val
	PRINT_UINT "[esi].m_animation = %d", eax
	mov		eax, [esi].m_blend
	mov		ecx, [eax].timeCurrent
	mov		time_saved, ecx
	xor		ebx, ebx
	mov		[esi].m_blend, ebx
	.while (ebx<MAX_PARTS)
		movzx	edx, [esi].m_animation.val
		mov		ecx, [edi].m_skeleton_animated
		.if (![esi].m_blend)
			invoke2	CKinematicsAnimated@@LL_PlayCycle, ebx, edx, TRUE, callback, [edi].m_object, 0
		.else
			invoke2	CKinematicsAnimated@@LL_PlayCycle, ebx, edx, TRUE, NULL, NULL, 0
		.endif
		.if (eax && ![esi].m_blend)
			mov		[esi].m_blend, eax
			mov		ecx, time_saved
			mov		[eax].timeCurrent, ecx
		.endif
		inc		ebx
	.endw
	ASSUME	edi:nothing, esi:nothing, eax:nothing
	ret
CStalkerAnimationManager@@restart_global_anim endp

align_proc
CStalkerAnimationManager@@restart_other_anim proc callback:dword
local time_saved:dword
	ASSUME	edi:ptr CStalkerAnimationManager, esi:ptr CStalkerAnimationPair, eax:ptr CBlend
	movzx	eax, [esi].m_animation.val
	PRINT_UINT "[esi].m_animation = %d", eax
	mov		eax, [esi].m_blend
	mov		ecx, [eax].timeCurrent
	mov		time_saved, ecx
	movzx	edx, [esi].m_animation.val
	mov		ecx, [edi].m_skeleton_animated
	invoke2	CKinematicsAnimated@@PlayCycle, edx, TRUE, callback, [edi].m_object, 0
	mov		[esi].m_blend, eax
	.if (eax)
		mov		ecx, time_saved
		mov		[eax].timeCurrent, ecx
		mov		[esi].m_actual, true
	.endif
	ASSUME	edi:nothing, esi:nothing, eax:nothing
	ret
CStalkerAnimationManager@@restart_other_anim endp

align_proc
CStalkerAnimationManager@@restart proc uses edi esi
	mov		edi, ecx
	ASSUME	edi:ptr CStalkerAnimationManager, esi:ptr CStalkerAnimationPair, edx:ptr CAI_Stalker
	mov		edx, [edi].m_object
	;m_skeleton_animated			= smart_cast<CKinematicsAnimated*>(m_object->Visual());
	mov		ecx, [edx].Visual_
	mov		[edi].m_skeleton_animated, ecx
	ASSUME	ecx:ptr CKinematicsAnimated
	mov		eax, [ecx].m_Motions._Mylast
	sub		eax, [ecx].m_Motions._Myfirst
	xor		edx, edx
	mov		ecx, 20
	idiv	ecx
	PRINT_UINT "m_Motions.size() = %d", eax
	ASSUME	ecx:nothing
	.if ([edi].m_script.m_blend)
		lea		esi, [edi].m_script
		invoke	CStalkerAnimationManager@@restart_global_anim, addr CStalkerAnimationManager@@script_play_callback
		PRINT_UINT "CStalkerAnimationManager@@restart: m_script res=%08X", [esi].m_blend
		jmp		head
	.elseif ([edi].m_global.m_blend)
		lea		esi, [edi].m_global
		invoke	CStalkerAnimationManager@@restart_global_anim, addr CStalkerAnimationManager@@global_play_callback
		PRINT_UINT "CStalkerAnimationManager@@restart: m_global res=%08X", eax
	.else
		.if ([edi].m_torso.m_blend)
			lea		esi, [edi].m_torso
			invoke	CStalkerAnimationManager@@restart_other_anim, addr CStalkerAnimationManager@@torso_play_callback
			PRINT_UINT "CStalkerAnimationManager@@restart: m_torso res=%08X", eax
		.endif
		.if ([edi].m_legs.m_blend)
			lea		esi, [edi].m_legs
			invoke	CStalkerAnimationManager@@restart_other_anim, addr CStalkerAnimationManager@@legs_play_callback
			PRINT_UINT "CStalkerAnimationManager@@restart: m_legs res=%08X", eax
		.endif
head:
		.if ([edi].m_head.m_blend)
			lea		esi, [edi].m_head
			invoke	CStalkerAnimationManager@@restart_other_anim, addr CStalkerAnimationManager@@head_play_callback
			PRINT_UINT "CStalkerAnimationManager@@restart: m_head res=%08X", eax
		.endif
	.endif
	ASSUME	edi:nothing, esi:nothing, edx:nothing
	ret
CStalkerAnimationManager@@restart endp

;------------------------------------------------------
;Скорей всего эти методы неработают. 
align_proc
CScriptGameObject@@SetLSFSpeed proc param:dword
	smart_cast	CHangingLamp, CGameObject, [ecx+4]
	ASSUME	eax:ptr CHangingLamp, edx:ptr light
	.if (eax)
		mov		edx, [eax].light_render.p_	;resptr_core<IRender_Light,resptrcode_light>
		mrm		[edx].m_fLSFSpeed, param				;
	.endif
	ret
CScriptGameObject@@SetLSFSpeed endp

align_proc
CScriptGameObject@@SetLSFAmount proc param:dword
	smart_cast	CHangingLamp, CGameObject, [ecx+4]
	.if (eax)
		mov		edx, [eax].light_render.p_
		mrm		[edx].m_fLSFAmount, param
	.endif
	ret
CScriptGameObject@@SetLSFAmount endp

align_proc
CScriptGameObject@@SetLSFSMAPJitter proc param:dword
	smart_cast	CHangingLamp, CGameObject, [ecx+4]
	.if (eax)
		mov		edx, [eax].light_render.p_
		mrm		[edx].m_fLSFSMAPJitter, param
	.endif
	ret
CScriptGameObject@@SetLSFSMAPJitter endp

align_proc
CScriptGameObject@@GetLSFSpeed proc
	smart_cast	CHangingLamp, CGameObject, [ecx+4]
	fldz
	.if (eax)
		mov		edx, [eax].light_render.p_
		fld		[edx].m_fLSFSpeed
	.endif
	ASSUME	eax:nothing, edx:nothing
	ret
CScriptGameObject@@GetLSFSpeed endp
;-------------------------------------------------------
align_proc
CScriptGameObject@@GetShapeRadius proc
	smart_cast	CSpaceRestrictor, [ecx+4]
	fldz
	.if (eax)
		ASSUME	eax:ptr CSpaceRestrictor, ecx:ptr ICollisionForm
		mov		ecx, [eax].CFORM	;+0A0h	ICollisionForm*
		fld		[ecx].bv_sphere.R
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetShapeRadius endp

align_proc
CScriptGameObject@@GetRadius proc
	mov		ecx, [ecx+4]
	jmp		ds:CObject__Radius
CScriptGameObject@@GetRadius endp

; аргумент-индекс передаётся через глобальную переменную (младшие два байта)
align_proc
CScriptGameObject@@GetBoneName proc
	mov		eax, [ecx+4]
	ASSUME	eax:ptr CGameObject
	mov		ecx, [eax].Visual_
	ASSUME	eax:nothing
	.if (ecx)
		smart_castV	CKinematics, IRender_Visual, ecx
		mov		ecx, eax
		push	g_int_argument_0
		call	ds:CKinematics__LL_BoneName_dbg
	.endif
	ret
CScriptGameObject@@GetBoneName endp

align_proc
CScriptGameObject@@HasVisual proc
	mov		eax, [ecx+4] ; eax = m_object
	ASSUME	eax:ptr CGameObject
	mov		ecx, [eax].Visual_
	ASSUME	eax:nothing
	xor		al, al
	.if (ecx)
		smart_castV	CKinematics, IRender_Visual, ecx
		test	eax, eax
		setnz	al
	.endif
	ret
CScriptGameObject@@HasVisual endp

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; актор стоит
align_proc
CScriptGameObject@@IsActorNormal proc
	smart_cast	CActor, [ecx+4]
	ASSUME	eax:ptr CActor
	.if (eax)
		mov		ecx, [eax].mstate_old
		xor		al, al
		.if (!(ecx & (mcCrouch or mcAccel or mcAnyMove)) || ecx==mcAccel)
			mov		al, true
		.endif
	.endif
	ret
CScriptGameObject@@IsActorNormal endp

; актор в присяде
align_proc
CScriptGameObject@@IsActorCrouch proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, [eax].mstate_old
		and		ecx, (mcCrouch or mcAccel)
		cmp		ecx, mcCrouch
		setz	al
	.endif
	ret
CScriptGameObject@@IsActorCrouch endp

; актор в полном присяде
align_proc
CScriptGameObject@@IsActorCreep proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, [eax].mstate_old
		and		ecx, (mcCrouch or mcAccel)
		cmp		ecx, (mcCrouch or mcAccel)
		setz	al
	.endif
	ret
CScriptGameObject@@IsActorCreep endp

; актор на лестнице
align_proc
CScriptGameObject@@IsActorClimb proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		test	[eax].mstate_old, mcClimb
		setnz	al
	.endif
	ret
CScriptGameObject@@IsActorClimb endp

; актор идет
align_proc
CScriptGameObject@@IsActorWalking proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, [eax].mstate_old
		test	ecx, mcAnyMove
		setnz	dl		; актор в движении
		and		ecx, (mcCrouch or mcAccel)	; уберём флаги 
		xor		al, al
		.if (dl && ecx == mcAccel)
			mov		al, true
		.endif
	.endif
	ret
CScriptGameObject@@IsActorWalking endp

; актор идет быстрым шагом (обычный режим)
align_proc
CScriptGameObject@@IsActorRunning proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, [eax].mstate_old
		xor		al, al
		.if (ecx & mcAnyMove && !(ecx & (mcCrouch or mcAccel or mcSprint)))
			mov		al, true
		.endif
	.endif
	ret
CScriptGameObject@@IsActorRunning endp

; актор бежит
align_proc
CScriptGameObject@@IsActorSprinting proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		test	[eax].mstate_old, mcSprint
		setnz	al		; актор в движении
	.endif
	ret
CScriptGameObject@@IsActorSprinting endp

; актор идет в присяде
align_proc
CScriptGameObject@@IsActorCrouching proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, [eax].mstate_old
		test	ecx, mcAnyMove
		setnz	dl		; актор в движении
		and		ecx, (mcCrouch or mcAccel)
		xor		al, al
		.if (dl && ecx == mcCrouch)
			mov		al, true
		.endif
	.endif
	ret
CScriptGameObject@@IsActorCrouching endp

; актор идет в полном присяде
align_proc
CScriptGameObject@@IsActorCreeping proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, [eax].mstate_old
		test	ecx, mcAnyMove
		setnz	dl		; актор в движении
		and		ecx, (mcCrouch or mcAccel)
		xor		al, al
		.if (dl && ecx == (mcCrouch or mcAccel))
			mov		al, true
		.endif
	.endif
	ret
CScriptGameObject@@IsActorCreeping endp

; актор лезет по лестнице
align_proc
CScriptGameObject@@IsActorClimbing proc
	smart_cast	CActor, [ecx+4]
	.if (eax)
		mov		ecx, [eax].mstate_old
		xor		al, al
		.if (ecx & mcAnyMove && ecx & mcClimb)
			mov		al, true
		.endif
	.endif
	ASSUME	eax:nothing
	ret
CScriptGameObject@@IsActorClimbing endp
;---------------------------------------------------------------------------------

; вкл\выкл ПНВ
align_proc
CScriptGameObject@@SwitchNightVision proc vision_on:dword
	smart_cast	CTorch, CGameObject, [ecx+4]
	.if (eax)
		push	vision_on
		push	eax
		call	CTorch__SwitchNightVision
	.endif
	ret
CScriptGameObject@@SwitchNightVision endp

; высадка ГГ из машины
align_proc
CScriptGameObject@@DetachVehicle proc exit_pos:dword
	smart_cast	CActor, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CActor
		; получим айди текущего холдера
		movzx	eax, [eax].m_holderID
		.if (ax!=-1)
			; получим объект по айди
			Level__Objects_net_Find	eax
			.if (eax)
				; кастуем в CCar
				smart_cast	CCar, CGameObject, eax
				.if (eax)
					mov		ecx, eax
					ASSUME	ecx:ptr CCar, edx:ptr Fvector
					; правим позицию выхода
					mov		edx, exit_pos
					Fvector_set	[ecx].m_exit_position, [edx].x, [edx].z, [edx].y
					ASSUME	ecx:nothing, edx:nothing
					; детачим актора из машины
					mov		eax, g_Actor
					call	CActor__detach_Vehicle
				.endif
			.endif
		.endif
	.endif
	ret
CScriptGameObject@@DetachVehicle endp

; разворот камеры на геймобъект
align_proc
CScriptGameObject@@UpdateCameraDirection proc SGO_target:dword
	ASSUME	ecx:ptr CScriptGameObject
	smart_cast	CActor, [ecx].object
	.if (eax)
		mov		ecx, SGO_target
		.if (ecx)
			mov		eax, [ecx].object
			call	UpdateCameraDirection
		.endif
	.endif
	ASSUME	ecx:nothing
	ret
CScriptGameObject@@UpdateCameraDirection endp

; восстановление прошлого значения FOV актора
static_float	g_last_fov, 0.0

align_proc
CScriptGameObject@@RestoreCameraFOV proc
	movss	xmm0, g_last_fov
	.if (xmm0 >= FP4(0.001))
		push	g_last_fov
		call	CScriptGameObject@@SetCameraFOV
	.endif
	ret
CScriptGameObject@@RestoreCameraFOV endp

; получить оставшиеся время текущей анимации
align_proc
CScriptGameObject@@GetHudAnimationRemainingTime proc
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CHudItem, ecx:ptr CWeaponHUD
		mov		ecx, [eax].m_pHUD
		.if (ecx && [ecx].m_bStopAtEndAnimIsRunning)
			mov		eax, [ecx].m_dwAnimEndTime
			mov		edx, ds:Device
			sub		eax, [edx].CRenderDevice.dwTimeGlobal
		.endif
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetHudAnimationRemainingTime endp

; проверить является ли текущая анимация цикличной
align_proc
CScriptGameObject@@IsCyclicHudAnimation proc
	smart_cast	CHudItem, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CHudItem, ecx:ptr CWeaponHUD
		mov		ecx, [eax].m_pHUD
		xor		al, al
		.if (ecx)
			mov		al, [ecx].m_bStopAtEndAnimIsRunning
			test	al, al
			setz	al
		.endif
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@IsCyclicHudAnimation endp

; проверить есть ли заданная анимация в модели
align_proc
CScriptGameObject@@HasHudAnimation proc name_anim:dword
local motion_ID:word
	call	CScriptGameObject@@GetHudVisual
	mov		ecx, eax
	push	name_anim
	lea		eax, motion_ID
	push	eax
	call	ds:CKinematicsAnimated__ID_Cycle_Safe
	xor		al, al
	.if (motion_ID!=-1)
		mov		al, true
	.endif
	ret
CScriptGameObject@@HasHudAnimation endp

; получить длину текущей анимации
align_proc
CScriptGameObject@@GetHudAnimationLength proc name_anim:dword, dword_param:dword
local motion_ID:word
	mov		esi, ecx
	call	CScriptGameObject@@GetHudVisual
	mov		ecx, eax
	push	name_anim
	lea		eax, motion_ID
	push	eax
	call	ds:CKinematicsAnimated__ID_Cycle
	xor		eax, eax
	.if (motion_ID!=-1)
		smart_cast	CHudItem, CGameObject, [esi+4]
		ASSUME	eax:ptr CHudItem, ecx:ptr CWeaponHUD
		mov		ecx, [eax].m_pHUD
		movzx	eax, motion_ID
		push	eax
		lea		eax, [ecx].m_shared_data	; shared_weapon_hud*
		call	shared_weapon_hud__motion_length
		ASSUME	eax:nothing, ecx:nothing
	.endif
	ret
CScriptGameObject@@GetHudAnimationLength endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================

align_proc
CScriptGameObject@@ClearPersonalRecord proc id_from:dword, id_to:dword
	push	id_to
	push	id_from
	call	RELATION_REGISTRY__ClearPersonalRecord
	ret
CScriptGameObject@@ClearPersonalRecord endp

align_proc
CScriptGameObject@@GetObjectArg1 proc param:dword
	mov		eax, g_object_arg_1
	.if (eax && dword ptr[eax+4]==0)
		xor		eax, eax
	.endif
	ret
CScriptGameObject@@GetObjectArg1 endp

;---===Nanobot===---
align_proc
CScriptGameObject@@IsExploding proc
	smart_cast	CExplosive, [ecx+4]
	.if (eax)
		test	[eax].CExplosive.m_explosion_flags, flExploding
		setnz	al
	.endif
	ret
CScriptGameObject@@IsExploding endp

;---===Nanobot===---
align_proc
CScriptGameObject@@setDynamicScales proc uses esi air_resistance:dword
	smart_cast	CPhysicsShellHolder, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CPhysicsShellHolder, edx:ptr CPHShell
		mov		edx, [eax].m_pPhysicsShell
		.if (edx)
			ASSUME	eax:ptr CPHElement
			; clamp(param1, 0.f, 1.f) // if( param1<0.f ) param1 = 0.f; else if( param1>1.f ) param1 = 1.f;
			movss	xmm0, air_resistance
			float@clamp	xmm0, 0, 1.0
			mov		ecx, [edx].elements._Myfirst	; ELEMENT_I i = CPHShell->elements.begin(),
			mov		esi, [edx].elements._Mylast		; ELEMENT_I e = CPHShell->elements.end();
			.while (esi!=ecx)
				mov		eax, [ecx]					; eax = CPHShell->(CPhysicsElement*)(*i)
				movss	[eax].k_l, xmm0				; CPHShell->(CPhysicsElement*)(*i)->k_l = air_resistance
				add		ecx, 4
			.endw
		.endif
		ASSUME	eax:nothing, edx:nothing
	.endif
	ret
CScriptGameObject@@setDynamicScales endp

;---===NanoBot===---
; Загрузка параметров патрона в объект CCarWeapon через CHolder
; задаём секцию патронов
align_proc
CScriptGameObject@@LoadAmmoCar proc uses esi	sect_ammo:dword
	smart_cast	CCar, CGameObject, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CCar, edx:ptr CCarWeapon
		mov		edx, [eax].m_car_weapon
		.if (edx)
			mov		esi, [edx].m_Ammo	; CCartridge*
			mov		eax, sect_ammo
			CCartridge@@Load(0)
			mov		eax, 1
		.endif
		ASSUME	eax:nothing, edx:nothing
	.endif
	ret
CScriptGameObject@@LoadAmmoCar endp

align_proc
CScriptGameObject@@SizeAmmoBox proc
	smart_cast	CWeaponAmmo, CGameObject, [ecx+4]
	ASSUME	eax:ptr CWeaponAmmo
	.if (eax)
		movzx	eax, [eax].m_boxSize
	.endif
	ret
CScriptGameObject@@SizeAmmoBox endp

align_proc
CScriptGameObject@@CurrAmmoBox proc
	smart_cast	CWeaponAmmo, CGameObject, [ecx+4]
	.if (eax)
		movzx	eax, [eax].m_boxCurr
	.endif
	ASSUME	eax:nothing
	ret
CScriptGameObject@@CurrAmmoBox endp

align_proc
CScriptGameObject@@SetScriptBestWeapon proc uses esi ebx best_wpn:dword, not_check_can_kill:byte
	smart_cast CAI_Stalker, [ecx+4]
	.if (eax)
		mov		esi, eax
		ASSUME	esi:ptr CAI_Stalker
		; CWeapon* wpn = smart_cast<CWeapon*>(best_wpn->object()));
		mov		eax, best_wpn
		.if (eax)
			smart_cast CWeapon, [eax+4]	; best_wpn должно быть оружием, иначе непысь зависает, а потом игра вылетает!
			mov		ebx, eax
			.if (ebx)
				mov		al, true
				.if (!not_check_can_kill)	
					; al = wpn->can_kill();
					mov		ecx, ebx
					mov		edx, [ecx]
					mov		eax, [edx+0F8h]
					call	eax
				.endif
				.if (al)
					; m_script_best_weapon = wpn;
					mov		[esi].m_script_best_weapon, ebx
					mrm		[esi].m_script_not_check_can_kill, not_check_can_kill
					; обновим оружие
					call	CAI_Stalker__update_best_item_info
				.endif
			.endif
		.else
			mov		[esi].m_script_best_weapon, eax
		.endif
		ASSUME	esi:nothing
	.endif
	ret
CScriptGameObject@@SetScriptBestWeapon endp

align_proc
CScriptGameObject@@GetScriptBestWeapon proc uses edi
	; CAI_Stalker*	stalker = smart_cast<CAI_Stalker*>(&object()));
	smart_cast CAI_Stalker, [ecx+4]
	.if (eax)
		mov		edx, eax
		ASSUME	edx:ptr CAI_Stalker, eax:ptr CWeapon
		; CWeapon* item = stalker->m_script_best_weapon;
		mov		eax, [edx].m_script_best_weapon
		.if (eax)
			; return (item->lua_game_object());
			lea		edi, [eax].CGameObject@vfptr		; CWeapon преобразуем в CGameObject
			call	CGameObject__lua_game_object
		.endif
		ASSUME	edx:nothing, eax:nothing
	.endif
	ret
CScriptGameObject@@GetScriptBestWeapon endp

align_proc
CScriptGameObject@@SetNotDropWeaponDeath proc	not_drop_wpn_at_death:byte
	smart_cast CAI_Stalker, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CAI_Stalker
		mov		cl, not_drop_wpn_at_death
		mov		[eax].m_not_drop_wpn_death, cl
	.endif
	ret
CScriptGameObject@@SetNotDropWeaponDeath endp

align_proc
CScriptGameObject@@GetNotDropWeaponDeath proc
	smart_cast CAI_Stalker, [ecx+4]
	.if (eax)
		; return (stalker->m_not_drop_wpn_death);
		mov		al, [eax].m_not_drop_wpn_death
		ASSUME	eax:nothing
	.endif
	ret
CScriptGameObject@@GetNotDropWeaponDeath endp

align_proc
CScriptGameObject@@calc_future_position proc uses esi edi ebx velocity_target:dword, res_pos_target:dword
local dir:Fvector, pos:Fvector
; esi - CAI_Stalker*
; edi - CWeaponMagazined
; ebx - CGameObject*
	mov		ebx, [ecx+4]
	; это сталкер или актор с оружием в руках
	; CAI_Stalker*	stalker = smart_cast<CAI_Stalker*>(&object());
	smart_cast CAI_Stalker, ebx		;CShootingObject CWeaponMagazined CAI_Stalker
	.if (eax==NULL)
		smart_cast CActor, ebx
	.endif
	.if (eax)
		mov		esi, eax	; stalker
		; определим активное оружие
		; stalker->inventory().ActiveItem()
		mov		ecx, esi
		mov		eax, [ecx]
		mov		edx, [eax+70h]
		call	edx			; stalker->inventory()
		.if (eax)
			mov		ecx, [eax+24h]
			mov		eax, [ecx+48h]
			.if (eax==-1)
				xor		eax, eax
				jmp		exit
			.endif
			; 
			shl		eax, 4
			add		eax, [ecx+38h]
			mov		eax, [eax+4]
			mov		eax, [eax+0D4h]
			;PRINT_UINT "CGameObject - %d", eax
			smart_cast CWeaponMagazined, CGameObject, eax
			ASSUME	edi:ptr CWeaponMagazined
			mov		edi, eax	; weapon
			xor		eax, eax
			.if (edi && [edi].iAmmoElapsed>0)
				; CEntity(stalker)->g_fireParams(weapon, pos, dir);
				mov		ecx, esi	; CEntity = CAI_Stalker
				mov		edx, [ecx]
				mov		edx, [edx+1E0h]
				lea		eax, dir
				push	eax
				lea		eax, pos
				push	eax
				lea		eax, [edi].CHudItem@vfptr	; CHudItem
				push	eax
				call	edx				; g_fireParams(weapon, pos, dir);
				; m_magazine.back()
				mov		eax, [edi].m_magazine._Mylast
				; calc_future_position(&pos, weapon->StartBulletSpeed(), weapon->m_magazine.back().m_kAirRes, velocity_target, res_pos_target);
				ASSUME	eax:ptr CCartridge, edx:ptr CShootingObject
				mov		ecx, [eax-sizeof CCartridge].m_kAirRes
				lea		edx, [edi].CShootingObject@vfptr	; 2C8h CWeaponMagazined -> CShootingObject
				calc_future_position(&pos, [edx].m_fStartBulletSpeed, ecx, velocity_target, res_pos_target)
			.endif
			ASSUME	edx:nothing, edi:nothing, eax:nothing
		.endif
		jmp		exit
	.endif
	; это БТР
	smart_cast CCar, CGameObject, ebx
	.if (eax)
		ASSUME	ecx:ptr CCartridge, esi:ptr CCarWeapon, eax:ptr CCar
		; если ли оружия в машине?
		mov		esi, [eax].m_car_weapon	; CCarWeapon* = CShootingObject*
		.if (esi)
			mov		ecx, [esi].m_Ammo	; CCartridge
			calc_future_position(&[esi].m_fire_pos, [esi].m_fStartBulletSpeed, [ecx].m_kAirRes, velocity_target, res_pos_target)
		.endif
		ASSUME	ecx:nothing, esi:nothing, eax:nothing
		jmp		exit
	.endif
	; это вертолёт 
	smart_cast CHelicopter, CGameObject, ebx
	.if (eax)
		ASSUME	eax:ptr CHelicopter
		lea		ecx, [eax].CShootingObject@vfptr	; 
		lea		edx, [eax].m_CurrentAmmo			; CCartridge*
		lea		esi, [eax].m_fire_pos				; Fvector*
		ASSUME	ecx:ptr CShootingObject, edx:ptr CCartridge
		calc_future_position(esi, [ecx].m_fStartBulletSpeed, [edx].m_kAirRes, velocity_target, res_pos_target)
		ASSUME	ecx:nothing, edx:nothing
		jmp		exit
	.endif
	; это турель
	smart_cast CWeaponMounted, CGameObject, ebx
	.if (eax)
		ASSUME	eax:ptr CWeaponMounted
		lea		ecx, [eax].CShootingObject@vfptr	; 
		lea		edx, [eax].m_CurrentAmmo			; CCartridge*
		lea		esi, [eax].fire_pos					; Fvector*
		ASSUME	ecx:ptr CShootingObject, edx:ptr CCartridge
		calc_future_position(esi, [ecx].m_fStartBulletSpeed, [edx].m_kAirRes, velocity_target, res_pos_target)
		ASSUME	ecx:nothing, edx:nothing, eax:nothing
	.endif
exit:
	ret
CScriptGameObject@@calc_future_position endp

align_proc
CScriptGameObject@@SetFlagCallbackKey proc flag_key:byte
	mov		edx, [ecx+4]
	ASSUME	edx:ptr CGameObject
	mrm		[edx].m_flCallbackKey, flag_key
	ret
CScriptGameObject@@SetFlagCallbackKey endp

align_proc
CScriptGameObject@@GetFlagCallbackKey proc
	mov		edx, [ecx+4]
	movzx	eax, [edx].m_flCallbackKey
	ASSUME	edx:nothing
	ret
CScriptGameObject@@GetFlagCallbackKey endp

;тип камеры
align_proc
CScriptGameObject@@GetTypeCamera proc uses esi
	mov		esi, [ecx+4]
	smart_cast	CActor, esi
	ASSUME	edx:ptr CCameraBase, eax:ptr CActor
	.if (eax)
		;return (cam_active);
		mov		eax, [eax].cam_active
		ret
	.endif
	smart_cast	CCar, CGameObject, esi
	ASSUME	eax:ptr CCar
	.if (eax)
		;return (active_camera->tag);
		mov		edx, [eax].active_camera
		mov		eax, [edx].tag
		ret
	.endif
	ASSUME	edx:nothing, eax:nothing
	or		eax, -1
	ret
CScriptGameObject@@GetTypeCamera endp

align_proc
CScriptGameObject@@GetCarShowCrosshair proc	 show:byte
	mov		eax, [ecx+4]
	smart_cast	CCar, CGameObject, eax
	.if (eax)
		ASSUME	ecx:ptr CCarWeapon, eax:ptr CCar
		; если ли оружия в машине?
		mov		ecx, [eax].m_car_weapon	; CCarWeapon* = CShootingObject*
		.if (ecx)
			mov		al, show
			mov		[ecx].m_bShowCrosshair, al
		.endif
		ASSUME	ecx:nothing, eax:nothing
	.endif
	ret
CScriptGameObject@@GetCarShowCrosshair endp

align_proc
CScriptGameObject@@SetCarWpnCurRotation proc cur_yaw:dword, cur_pitch:dword
	push	ebx
	mov		eax, [ecx+4]
	smart_cast	CCar, CGameObject, eax
	.if (eax)
		mov		edx, eax
		ASSUME	ecx:ptr CCarWeapon, edx:ptr CCar, ebx:ptr CCameraBase
		; если ли оружия в машине?
		mov		ecx, [edx].m_car_weapon	; CCarWeapon* = CShootingObject*
		.if (ecx)
			mov		ebx, [edx].active_camera
			;азимут от севера (рыскание).
			mov		eax, cur_yaw
			xor		eax, 80000000h		; = -cur_yaw;
			mov		[ecx].m_cur_y_rot, eax
			mov		[ecx].m_tgt_y_rot, eax
			mov		[ebx].yaw, eax
			;склонение от горизонтального вектора (тангаж).
			mov		eax, cur_pitch
			mov		[ecx].m_cur_x_rot, eax
			mov		[ecx].m_tgt_x_rot, eax
			mov		[ebx].pitch, eax
			;m_fire_dir.setHP(cur_yaw, cur_pitch);
			Fvector_setHP	[ecx].m_fire_dir, cur_yaw, cur_pitch
			;lea		eax, [ecx].m_fire_dir
			;PRINT_VECTOR "m_fire_dir ", eax
		.endif
		ASSUME	ecx:nothing, edx:nothing, ebx:nothing
	.endif
	pop		ebx
	ret
CScriptGameObject@@SetCarWpnCurRotation endp

align_proc
CScriptGameObject@@GetCarWpnCurDirH proc
	mov		eax, [ecx+4]
	smart_cast	CCar, CGameObject, eax
	.if (eax)
		ASSUME	ecx:ptr CCarWeapon, eax:ptr CCar
		; если ли оружия в машине?
		mov		ecx, [eax].m_car_weapon	; CCarWeapon* = CShootingObject*
		.if (ecx)
			fld		[ecx].m_cur_y_rot
		.endif
		ASSUME	ecx:nothing, eax:nothing
	.endif
	ret
CScriptGameObject@@GetCarWpnCurDirH endp

align_proc
CScriptGameObject@@GetCarWpnCurDirP proc
	mov		eax, [ecx+4]
	smart_cast	CCar, CGameObject, eax
	.if (eax)
		ASSUME	ecx:ptr CCarWeapon, eax:ptr CCar
		; если ли оружия в машине?
		mov		ecx, [eax].m_car_weapon	; CCarWeapon* = CShootingObject*
		.if (ecx)
			fld		[ecx].m_cur_x_rot
		.endif
		ASSUME	ecx:nothing, eax:nothing
	.endif
	ret
CScriptGameObject@@GetCarWpnCurDirP endp

align_proc
CScriptGameObject@@GetKeyState proc key:dword
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	push	key
	lea		ecx, [eax+10h]
	call	ds:IInputReceiver__IR_GetKeyState
	ret
CScriptGameObject@@GetKeyState endp

align_proc
CScriptGameObject@@SpawnArtefact proc uses esi edi ebx sect_art:dword, count:dword
local	pos:Fvector, lvertex:dword
	smart_cast	CCustomZone, [ecx+4]
	.if (eax)
		ASSUME	esi:ptr CCustomZone
		mov		esi, eax
		mov		eax, ds:g_dedicated_server
		or		ecx, -1	;=-1;
		.if (byte ptr[eax]==false)
			mov		eax, [esi].m_ai_location
			mov		ecx, [eax+4]
		.endif
		mov		lvertex, ecx
		mov		ecx, esi
		mov		eax, [ecx]
		mov		edx, [eax+10h]
		lea		ebx, pos
		push	ebx
		call	edx
		mov		edi, count
		.if (edi==0)
			inc		edi
		.endif
		.for (:sdword ptr edi>0:edi--)
			mov		eax, ds:g_pGameLevel
			mov		edx, [eax]
			movzx	ecx, [esi].ID
			invoke	CLevel@@spawn_item, edx, sect_art, lvertex, ecx, FALSE
		.endfor
		mov		eax, true
		ASSUME	esi:nothing
	.endif
	ret
CScriptGameObject@@SpawnArtefact endp

align_proc
CScriptGameObject@@AllowScriptSpawnArtefact proc on_spawn:byte
	smart_cast	CCustomZone, [ecx+4]
	.if (eax)
		mov		dl, on_spawn
		mov		[eax].CCustomZone.m_bAllowScriptSpawnArtefact, dl
	.endif
	ret
CScriptGameObject@@AllowScriptSpawnArtefact endp

align_proc
CScriptGameObject@@ReloadCarWeapon proc uses esi edi sect_carwpn:dword, name_bone_fire:dword
	smart_cast	CCar, CGameObject, [ecx+4]
	.if (eax)
		mov		edi, eax
		ASSUME	esi:ptr CCarWeapon, edi:ptr CCar
		; если ли оружия в машине?
		mov		ecx, [edi].m_car_weapon	; CCarWeapon* = CShootingObject*
		.if (ecx)
			mov		esi, ecx
			mov		eax, sect_carwpn
			call	CCarWeapon__Load
			mov		ecx, [edi].Visual_
			smart_castV	CKinematics, IRender_Visual, ecx
			push	name_bone_fire
			mov		ecx, eax
			call	ds:CKinematics__LL_BoneID
			mov		[esi].m_fire_bone, ax
		.endif
		ASSUME	esi:nothing, edi:nothing
	.endif
	ret
CScriptGameObject@@ReloadCarWeapon endp

align_proc
CScriptGameObject@@GetWeaponNPCBlocked proc
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		ASSUME	eax:ptr CWeapon
		movzx	eax, [eax].m_bNPCBlocked
	.endif
	ret
CScriptGameObject@@GetWeaponNPCBlocked endp

align_proc
CScriptGameObject@@SetWeaponNPCBlocked proc blocked:byte
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		mov		cl, blocked
		mov		[eax].m_bNPCBlocked, cl
		ASSUME	eax:nothing
	.endif
	ret
CScriptGameObject@@SetWeaponNPCBlocked endp

align_proc
CScriptGameObject@@get_LastFP proc uses esi local_vector:dword
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		ASSUME	esi:ptr CWeapon, edx:ptr Fvector
		mov		esi, eax
		mov		ecx, eax
		call	CWeapon__UpdateFireDependencies_internal
		mov		edx, local_vector
		Fvector_set	[edx], [esi].m_firedeps.vLastFP.x, [esi].m_firedeps.vLastFP.y, [esi].m_firedeps.vLastFP.z	;	//огня
		mov		eax, edx
	.endif
	ret
CScriptGameObject@@get_LastFP endp

align_proc
CScriptGameObject@@get_LastFP2 proc uses esi local_vector:dword
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		mov		esi, eax
		mov		ecx, eax
		call	CWeapon__UpdateFireDependencies_internal
		mov		edx, local_vector
		Fvector_set	[edx], [esi].m_firedeps.vLastFP2.x, [esi].m_firedeps.vLastFP2.y, [esi].m_firedeps.vLastFP2.z	;	//огня
		mov		eax, edx
	.endif
	ret
CScriptGameObject@@get_LastFP2 endp

align_proc
CScriptGameObject@@get_LastFD proc uses esi local_vector:dword
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		mov		esi, eax
		mov		ecx, eax
		call	CWeapon__UpdateFireDependencies_internal
		mov		edx, local_vector
		Fvector_set	[edx], [esi].m_firedeps.vLastFD.x, [esi].m_firedeps.vLastFD.y, [esi].m_firedeps.vLastFD.z	;	// direction
		mov		eax, edx
	.endif
	ret
CScriptGameObject@@get_LastFD endp

align_proc
CScriptGameObject@@get_LastSP proc uses esi local_vector:dword
	smart_cast	CWeapon, [ecx+4]
	.if (eax)
		mov		esi, eax
		mov		ecx, eax
		call	CWeapon__UpdateFireDependencies_internal
		mov		edx, local_vector
		Fvector_set	[edx], [esi].m_firedeps.vLastSP.x, [esi].m_firedeps.vLastSP.y, [esi].m_firedeps.vLastSP.z	;	// гильзы
		mov		eax, edx
		ASSUME	esi:nothing, edx:nothing
	.endif
	ret
CScriptGameObject@@get_LastSP endp

align_proc
CScriptGameObject@@SetInitiator proc InitiatorID:word
	mov		ecx, [ecx+4]
	ASSUME	ecx:ptr CPhysicsShellHolder, edx:ptr CPHShell
	mov		edx, [ecx].m_pPhysicsShell
	.if (edx)
		mrm		[edx].m_InitiatorID, InitiatorID
	.endif
	ret
CScriptGameObject@@SetInitiator endp

align_proc
CScriptGameObject@@GetInitiator proc
	mov		ecx, [ecx+4]
	mov		edx, [ecx].m_pPhysicsShell
	mov		eax, 0FFFFh
	.if (edx)
		movzx	eax, [edx].m_InitiatorID
	.endif
	ASSUME	ecx:nothing, edx:nothing
	ret
CScriptGameObject@@GetInitiator endp

align_proc
CScriptGameObject@@GetGrenadeModeGL proc
	smart_cast	CWeaponMagazinedWGrenade, CGameObject, [ecx+4]
	mov		edx, eax
	xor		eax, eax
	.if (edx)
		movzx	eax, [edx].CWeaponMagazinedWGrenade.m_bGrenadeMode
	.endif
	ret
CScriptGameObject@@GetGrenadeModeGL endp

align_proc
CScriptGameObject@@SetGrenadeModeGL proc mode:byte
	smart_cast	CWeaponMagazinedWGrenade, CGameObject, [ecx+4]
	.if (eax)
		mov		dl, mode
		.if ([eax].CWeaponMagazinedWGrenade.m_bGrenadeMode != dl)
			call    CWeaponMagazinedWGrenade@@PerformSwitchGL
		.endif
	.endif
	ret
CScriptGameObject@@SetGrenadeModeGL endp

align_proc
CScriptGameObject@@GetLaunchSpeedRPG7 proc
	smart_cast	CWeaponRPG7, CGameObject, [ecx+4]
	fldz
	.if (eax)
		fld		[eax].CWeaponRPG7.m_fLaunchSpeed
	.endif
	ret
CScriptGameObject@@GetLaunchSpeedRPG7 endp

align_proc
CScriptGameObject@@SetLaunchSpeedRPG7 proc launch_speed:real4
	smart_cast	CWeaponRPG7, CGameObject, [ecx+4]
	.if (eax)
		fld		launch_speed
		fstp	[eax].CWeaponRPG7.m_fLaunchSpeed
	.endif
	ret
CScriptGameObject@@SetLaunchSpeedRPG7 endp

static_float	flt_max, 3.4e38

include trajectories.asm

;вызывается для оружия, которое может стрелять гранатами, должно быть в инвентаре живого и не раненого сталкера.
;проверяется, достижимость цели в указаной точки и в пределах указаного радиуса.
align_proc
CScriptGameObject@@TestGrenadeFire proc uses esi edi ebx pTargetPos:ptr Fvector, radius:real4
local throw_vel:Fvector4, throw_target_pos:Fvector4, throw_pos:Fvector4, throw_dir:Fvector4
local time:real4, grenade_vel:real4
;	mov		edx, pTargetPos
;	PRINT_VECTOR "pTargetPos", edx
;	PRINT_FLOAT "radius = %.6f", radius
	ASSUME	esi:ptr CGameObject, edi:ptr CAI_Stalker
	mov		esi, [ecx+4]
	smart_cast CRocketLauncher, CGameObject, esi
	.if (eax)
		mrm		grenade_vel, [eax].CRocketLauncher.m_fLaunchSpeed
		mov		eax, [esi].Parent
		.if (eax)
			smart_cast CAI_Stalker, eax
			.if (eax)
				mov		edi, eax
				mov		edx, [edi].CEntityAlive@m_entity_condition
				xor		eax, eax
				xorps	xmm0, xmm0
				.if (xmm0<[edx].CEntityCondition.m_fHealth && ![edi].m_wounded)	;сталкер жив и не ранен
					;если оружие: подствольный гранатомёт или РГ-6, то скорость гранаты фиксированая.
					Fvector4_set	throw_pos, [edi].eye_matrix.c_.x, [edi].eye_matrix.c_.y, [edi].eye_matrix.c_.z, 0
					ASSUME	edx:ptr Fvector
					mov		edx, pTargetPos
					Fvector4_set	throw_target_pos, [edx].x, [edx].y, [edx].z, 0
					;throw_vel:sub(throw_target_pos, throw_pos);
					movups	xmm0, throw_target_pos
					movups	xmm1, throw_pos
					subps	xmm0, xmm1
					movups	throw_vel, xmm0
					mov		eax, ph_world
					mov		ebx, [eax].CPHWorld.m_gravity
					xorps	xmm0, xmm0
					.if (xmm0==grenade_vel)
						ThrowMinVelTime(&throw_vel, ebx)
						movss	time, xmm0
						TransferenceToThrowVel(&throw_vel, time, ebx)
					.else
						push	edi
						.if (TransferenceAndThrowVelToThrowDir(&throw_vel, grenade_vel, ebx, &throw_dir))
							Fvector_set	throw_vel, throw_dir
						.endif
						pop		edi
					.endif
					.if (al)
						trajectory_intersects_geometry(time, &throw_pos, &throw_target_pos, &throw_vel, ebx, edi, NULL)
						Fvector_set	[edi].m_throw_direction, throw_dir
					.endif
				.endif
			.endif
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing, edx:nothing
	ret
CScriptGameObject@@TestGrenadeFire endp

