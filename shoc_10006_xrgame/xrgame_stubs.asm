;*******************************************************************************
; S.T.A.L.K.E.R data stubs
;*******************************************************************************

org 10227DAAh - shift	; 6 bytes
	nop6

org 1018367Bh - shift
cse_alife_object__register_readonly_u32:

;CWeaponMagazinedWGrenade__UseScopeTexture proc near
;org 1022B3C0h - shift
;	db		39 dup (0CCh)	; затрём всю функцию, так лучше будет IDA
org 1022B3C0h - shift	; 5 bytes
	jmp		CWeaponMagazinedWGrenade__UseScopeTexture_fix


org 1048ADD4h - shift 
dd	CWeapon__UseScopeTexture_fix
org 1048B7E4h - shift 
dd	CWeapon__UseScopeTexture_fix
org 1048BF0Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 1048D1E4h - shift 
dd	CWeapon__UseScopeTexture_fix
org 1048F47Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 1048FA4Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 10490144h - shift 
dd	CWeapon__UseScopeTexture_fix
org 1049118Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 1049175Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 104921ACh - shift 
dd	CWeapon__UseScopeTexture_fix
org 1049278Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 1049325Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 10493E04h - shift 
dd	CWeapon__UseScopeTexture_fix
org 104943D4h - shift 
dd	CWeapon__UseScopeTexture_fix
org 10494994h - shift 
dd	CWeapon__UseScopeTexture_fix
org 10494F6Ch - shift 
dd	CWeapon__UseScopeTexture_fix
org 10495554h - shift 
dd	CWeapon__UseScopeTexture_fix
org 10495C14h - shift 
dd	CWeapon__UseScopeTexture_fix
org 104961FCh - shift 
dd	CWeapon__UseScopeTexture_fix
org 104967C4h - shift 
dd	CWeapon__UseScopeTexture_fix
org 10496E0Ch - shift 
dd	CWeapon__UseScopeTexture_fix


org 102EAFE4h - shift
register_cse_abstract_u16_rw_prop:

;
org 1020D3F5h - shift	; 11 bytes
	nop7
	nop4

;
org 1020CFD1h - shift	; 11 bytes
	jmp		CInventoryOwner__OnEvent_dbg_fix
	nop6
return_CInventoryOwner__OnEvent_dbg_fix:

;фикс для исправления соотношения сторон CUIStatic
org 103EDEEFh - shift	; 8 bytes
	movss	xmm1, ds:g_static_rescale_correction

org 10459718h - shift
float_1p0		dd ?

org 103B8C70h - shift
ui_core@@is_16_9_mode:

;
org 1024DCDCh - shift	; 8 bytes
	mulss	xmm5, ds:g_hud_inertia_factor

;
org 1024DCFAh - shift	; 8 bytes
	movss	xmm4, ds:g_hud_inertia_param_2

;кастомная заливка предметов в окне обыска ящиков
org 103CBF49h - shift	; 5 bytes
	jmp		CUICarBodyWnd@@UpdateLists_fix
return_CUICarBodyWnd@@UpdateLists_fix:

;ручное управление группируемостью предметов
org 10416E83h - shift	; 6 bytes
	jmp		CUIInventoryCellItem__EqualTo_fix
	nop
return_CUIInventoryCellItem__EqualTo_fix:

org 10228B20h - shift
CWeaponMagazined__GetBriefInfo:

; заменяем информацию бинокля на информацию ствола
org 10495448h - shift	; 4 bytes
CWeaponBinoculars__GetBriefInfo	dd	CWeaponMagazined__GetBriefInfo

; бинокль будет стрелять
org 102340FAh - shift	; 2 bytes
	nop2

org 1045893Ch - shift
CKinematics__LL_BoneName_dbg	dd ?

;дебаговый фикс для трассировки скриптовых хитов
org 10141C60h - shift	; 5 bytes
	jmp		CScriptGameObject__Hit_dbg_fix
org 10141C66h - shift
back_from_CScriptGameObject__Hit_dbg_fix:

org 10458A80h - shift
CObject__Radius dd ?
org 102F6079h - shift
sub_102F6079:
org 102F60EDh - shift
register_CSE__VOID__BOOL:

;
org 102F3663h - shift	; 5 bytes
	jmp		CSE_ALifeObject__script_register_fix
return_CSE_ALifeObject__script_register_fix:

; заглушки для регистрации rw свойства класса cse_abstract типа vector
; org 102EB061h - shift
; cse_abstract__register_position:
; org 101739BEh - shift
; sub_101739BE dd ?
; org	 100072F3h - shift
; sub_100072F3 dd ?
; org 10001F8Ch - shift
; sub_10001F8C:
; org 1013A984h - shift
; sub_1013A984 dd ?
; org 100072F3h - shift
; sub_100072F3 dd ?
; org 10458F44h - shift
; ?add_getter@class_base@detail@luabind@@QAEXPBDABV?$function2@HPAUlua_State@@HV?$allocator@Vfunction_base@boost@@@std@@@boost@@@Z dd ?
; org 10458E9Ch - shift
; ?add_setter@class_base@detail@luabind@@QAEXPBDABV?$function2@HPAUlua_State@@HV?$allocator@Vfunction_base@boost@@@std@@@boost@@@Z dd ?

;оптимизация cse_abstract_register__vector__rw_prop
org 1045B6C0h - shift
aPosition			dd ?	; "position"
org 102EB061h - shift
cse_abstract_register__vector__rw_prop:
org 102EB14Ch - shift
cse_abstract_register__LPCSTR__void:
org 102EB06Dh - shift	; 3 bytes
	mov		eax, [ebp+16]
org 102EB0DAh - shift	; 3 bytes
	mov		eax, [ebp+16]
org 102EB0C4h - shift	; 5 bytes
	push	[ebp+12]
	nop2
org 102EB12Fh - shift	; 5 bytes
	push	[ebp+12]
	nop2
org 102EB149h - shift	; 3 bytes
	retn	12
;--------------------------------------------------
;добавление скриптовых свойств в класс CSE_Abstract
org 102EA534h - shift	; 36 bytes
	push	88
	push	offset aPosition
	push	eax
	call	cse_abstract_register__vector__rw_prop
	push	eax
	call	cse_abstract_register__LPCSTR__void
	push	eax
	call	cse_abstract_register__LPCSTR__void
	jmp		CSE_Abstract__script_register_fix
return_CSE_Abstract__script_register_fix:
	mov		ecx, eax
	push	0
	push	0
;--------------------------------------------------

;убираем столбец дополнительных назначений клавиш в окне опций управления
org 103DF1F7h - shift
no_third_optins_row:
org 103DF696h - shift
no_alternative_keyboard_binding:
org 103DF1A6h - shift	; 5 bytes
	jmp		no_third_optins_row
org 103DF607h - shift	; 5 bytes
	jmp		no_alternative_keyboard_binding

;
org 102D41D0h - shift
str_cmp:

;добавляем свои опции, требующие рестарта видео (после нажатия кнопки "Применить" в окне опций или после ввода команды vid_restart)
org 103D7C60h - shift	; 5 bytes
	jmp		CUIOptionsItem__SaveValue_fix
org 103D7CF5h - shift
no_vid_restart:
org 103D7CF7h - shift
vid_restart:

;
org 103EB9ABh - shift
register__UI__string__void:
org 10458770h - shift
CGameFont__SizeOf_		dd ? ; public: float __thiscall CGameFont::SizeOf_(char const *)

;---------- CUIComboBox fix ------
org 1040E5B0h - shift
CUIComboBox__SetItem:

;исправляеем феерический баг движка в функции CUIComboBox::SetListLength
;убираем R_ASSERT(0 == m_iListHeight);
org 1040DF6Ah - shift	; 2 bytes
	jmp		loc_1040DFA5
org 1040DFA5h - shift
loc_1040DFA5:

org 103D7C60h - shift
CUIOptionsItem__SaveValue:

;
org 1040E540h - shift	; 5 bytes
	jmp		CUIComboBox__SaveValue_fix
org 1040E549h - shift
back_from_CUIComboBox__SaveValue_fix:
;
org 103D7BC4h - shift
	jmp		CUIOptionsItem__SaveOptFloatValue_fix
	nop2
return_CUIOptionsItem__SaveOptFloatValue_fix:

org 103F9600h - shift
CUIWindow@@BringToTop_:

org 1040E220h - shift
CUIComboBox@@AddItem_ proc str_:ptr byte, data:dword
CUIComboBox@@AddItem_ endp

org 103F1520h - shift
register_CUI_void__string:

org 1040F216h - shift
sub_1040F216:

;скриптовые методы в CUIComboBox
org 1040EF76h - shift	; 5 bytes
	jmp		CUIComboBox_fix
return_CUIComboBox_fix:

;вырезаем эффект приближения камеры
org 1019C4C0h - shift	; 5 bytes
	xor		eax, eax
	retn	24

;---------------- begin of controller fixes ------------------------
; removing buggy pp effects
;вырезаем кривой постэффект контролёра
org 100E15A4h - shift	; 8 bytes
	add		esp, 4
	xor		eax, eax
	nop3
; ничего не делаем, поскольку нулевой указатель обрабатывается в коде
; CController::UpdateCL
org 100E2BC4h - shift	; 5 bytes
	nop5
; CController::shedule_Update
org 100E2C21h - shift	; 5 bytes
	nop5
; CController::Die
org 100E2C43h - shift	; 6 bytes
	jmp		loc_100E2C77
	nop4
org 100E2C77h - shift
loc_100E2C77:
; CController::net_Destroy
org 100E2C99h - shift	; 6 bytes
	jmp		loc_100E2CCD
	nop4
org 100E2CCDh - shift
loc_100E2CCD:
; CController::Load
org 100E21A6h - shift	; 24 bytes
	pop		edi
	pop		esi
	pop		ebx
	mov		esp, ebp
	pop		ebp
	retn	4
	db		15 dup (0CCh)
;---------------- end of controller fixes ------------------------

org 104100E0h - shift
CUITrackBar__IsChanged:

org 103FB71Eh - shift
register__UI__bool__void:

org 1040CA2Bh - shift
register__CUITrackBar__GetCheck:

;скриптовые методы в CUITrackBar
;CUIButton::script_register
org 1040B935h - shift	; 5 bytes
	jmp		CUITrackBar_fix
return_CUITrackBar_fix:

org 10458D98h - shift 
xr_FS			dd ?	; class CLocatorAPI * xr_FS
org 10458C68h - shift
CLocatorAPI__rescan_pathes dd ?

; поддержка русского языка в поле ввода (язык переключается функцией set_input_language(0/1))
;обработка ввода символов 'хХ'
org 103F4CD3h - shift	; 10 bytes
	jmp		CUICustomEdit__KeyPressed_fix_1
	nop5
return_CUICustomEdit__KeyPressed_fix_1:
;'ъЪ'
org 103F4CECh - shift	; 10 bytes
	jmp		CUICustomEdit__KeyPressed_fix_2
	nop5
return_CUICustomEdit__KeyPressed_fix_2:
;'жЖ'
org 103F4CFFh - shift	; 13 bytes
	mov		bl, [ebp].CUICustomEdit.m_bShift
	jmp		CUICustomEdit__KeyPressed_fix_3
	nop2
return_CUICustomEdit__KeyPressed_fix_3:
;'эЭ'
org 103F4D1Bh - shift	; 10 bytes
	jmp		CUICustomEdit__KeyPressed_fix_4
	nop5
return_CUICustomEdit__KeyPressed_fix_4:
;'бБ'
org 103F4D66h - shift	; 10 bytes
	jmp		CUICustomEdit__KeyPressed_fix_5
	nop5
return_CUICustomEdit__KeyPressed_fix_5:
;'юЮ'
org 103F4D7Fh - shift	; 10 bytes
	jmp		CUICustomEdit__KeyPressed_fix_6
	nop5
return_CUICustomEdit__KeyPressed_fix_6:
;'.,'
org 103F4D4Dh - shift	; 10 bytes
	jmp		CUICustomEdit__KeyPressed_fix_7
	nop5
return_CUICustomEdit__KeyPressed_fix_7:

org 103F5320h - shift
xr_map?u32@char?@@find:
org 10560904h - shift
dword_10560904		dd ?
;
org 103F4B21h - shift	; 5 bytes
	jmp		CUICustomEdit__KeyPressed_fix
org 103F4B38h - shift
return_CUICustomEdit__KeyPressed_fix:
org 103F4B42h - shift
loc_103F4B42:

;регистрация CUICustomEdit
org 103F5F3Ah - shift	; 7 bytes
	jmp		CUICustomEdit_fix
	nop2
back_from_CUICustomEdit_fix:

; функция регистрации метода класса CUIListWnd с прототипом void CUIListWnd::fun(int);
org 104207F6h - shift
sub_104207F6:

;скриптовые методы в CUIListWnd
org 10420424h - shift	; 6 bytes
	jmp		CUIListWnd__script_register_fix
	nop
return_CUIListWnd__script_register_fix:

;
org 101A5430h - shift
CLevel__SetEnvironmentGameTimeFactor:
org 104587C8h - shift
CEnvironment__Invalidate dd ?

;восстанавливает солнечный диск, но могут заглючить скриптовые выбросы/погода (примечание by Macron)
org 102AC460h - shift
	jmp		game_cl_GameState__net_import_GameTime_fix

;
org 102A0940h - shift
	jmp		game_GameState__SetGameTimeFactor__INT64_float_dbg_fix

;
org 102A0900h - shift
	jmp		game_GameState__SetGameTimeFactor_dbg_fix

;
org 102D5A00h - shift
	jmp		game_sv_Single__GetGameTime_dbg_fix

org 102A0840h - shift
game_GameState__GetGameTime:

org 102A0848h - shift
	jmp		game_GameState__GetGameTime_dbg_fix

;
org 101E2FC5h - shift
	jmp		CEntityCondition__UpdateConditionTime_dbg


org 10458FBCh - shift
IPureClient__timeServer dd ?
org 1045A260h - shift
float_0p001	dd 0.001 

org 10458A70h - shift
CCameraManager__Update0		dd ? ;public: void CCameraManager::Update(Fvector const &, Fvector const &, Fvector const &, float, float, float, uint)
org 10458518h - shift
CCameraManager__Update1		dd ? ;public: void CCameraManager::Update(CCameraBase const *)

;замена камеры машины
org 1026F820h - shift	; 6 bytes
	jmp		CCar__cam_Update_fix0
	nop
return_CCar__cam_Update_fix0:
;...
org 1026F980h - shift	; 6 bytes
	call	g_CCameraManager__Update3

;скриптовый колбек на предиспользование предмета
org 1020616Dh - shift	; 8 bytes
	jmp		CInventory__Eat_fix
	nop3
return_CInventory__Eat_fix:

; фрагмент из CEntityCondition::ConditionHit
; повторное умножение на коэффициент иммунитета от телепатического урона
; нигде такого нет, поэтому убираем
org 101E35ECh - shift
	nop4

;
org 1019FFA0h - shift	; 5 bytes
	jmp		CEffectorZoomInertion__Process_fix
return_CEffectorZoomInertion__Process_fix:

org 10458028h - shift
LoadLibraryA dd ?
org 1045802Ch - shift
GetProcAddress dd ?
org 1019FEB0h - shift
CEffectorZoomInertion__CalcNextPoint:
org 10074710h - shift
vector3__lerp:
;org 10001630h - shift
;fabs:
org 1001C190h - shift
vector3__similar:
org 1001A2F0h - shift
vector3__add_vector:
org 1001EBA0h - shift
vector3__set:

;
org 10056370h - shift	; 6 bytes
	jmp		CGameGraph__distance_fix
org 10056376h - shift
back_from_CGameGraph__distance_fix:

org 1053C500h - shift
g_mt_config dd ?

org 103FB79Dh - shift
register_CUIWindow_float__void:

;убираем фейковый хит из менеджера памяти
org 10015B4Eh - shift	; 2 bytes
	jmp		loc_10015B66
org 10015B66h - shift
loc_10015B66:

org 10001530h - shift
CDamageManager__HitScale:
org 101DFA30h - shift
CEntity__Hit:
org 102155D0h - shift
RELATION_REGISTRY__FightRegister:
org 10214C70h - shift
RELATION_REGISTRY__Action:

;колбеки на хит объекта CEntityAlive
org 101E1180h - shift
CEntityAlive@@Hit proc pHDS:ptr SHit
CEntityAlive@@Hit endp
org 10073989h - shift	; 5 bytes
	jmp		CEntityAlive@@HitCallback
org 1007B277h - shift	; 5 bytes
	call	CEntityAlive@@HitCallback
org 100F6B00h - shift	; 5 bytes
	jmp		CEntityAlive@@HitCallback
org 101197A1h - shift	; 5 bytes
	call	CEntityAlive@@HitCallback
org 101C665Ah - shift	; 5 bytes
	call	CEntityAlive@@HitCallback
org 101C6717h - shift	; 5 bytes
	call	CEntityAlive@@HitCallback
org 1048504Ch - shift	; 4 bytes
	dd offset	CEntityAlive@@HitCallback
;----------------------------------

org 102ACF30h - shift
game_cl_GameState__StartStopMenu:
; заглушка для регистрация функции, возвращающей диалог
org 10481F40h - shift
off_10481F40 dd ?

;CHangingLamp::net_Spawn
; edi - cse_hanging_lamp
; esi - lamp
org 101F267Fh - shift	; 7 bytes
	jmp		CHangingLamp__net_Spawn_fix
	nop2
return_CHangingLamp__net_Spawn_fix:

org 101F269Ah - shift	; 6 bytes
	jmp		CHangingLamp__net_Spawn_fix_2
	nop
return_CHangingLamp__net_Spawn_fix_2:

;
org 10118C50h - shift	; 5 bytes
	jmp		CAI_Stalker__feel_touch_new_fix
return_CAI_Stalker__feel_touch_new_fix:

; врезка для управления видимостью панели машины
org 102693AEh - shift	; 2 bytes
	push	esi		; m_car_panel_visible	// флаг включения панели
	nop


org 101DF130h - shift
CActor__attach_Vehicle: ; vehicle<eax>, int this<edi>

org 10213A90h - shift
RELATION_REGISTRY__SetGoodwill:
org 10213A40h - shift
RELATION_REGISTRY__GetGoodwill:
org 10213B10h - shift
RELATION_REGISTRY__ChangeGoodwill:

;
org 1025828Ah - shift	; 12 bytes
	jmp		CCustomZone__feel_touch_contact_dbg_fix
org 10258296h - shift
back_from_CCustomZone__feel_touch_contact_dbg_fix:


org 104760D4h - shift	; 4 bytes
	dd	CAI_Stalker__IsVisibleForZones

org 1014E3C0h - shift
register_go_void__vector:

org 1014D600h - shift
register__set_character_rank:

;скриптовый колбек на хит прожектора
org 104A067Ch - shift	; 4 bytes
	dd	Projector__Hit	 ; CGameObject::Hit

; CInventoryItem::CInventoryItem
; заменяем инициализацию неиспользуемого m_nameComplex на создание нашего блока памяти
org 1020921Fh - shift	; 6 bytes
	jmp		CInventoryItem_constructor_fix
	nop
return_CInventoryItem_constructor_fix:


; CInventoryItem_destructor
; заменяем удаление неиспользуемого m_nameComplex на удаление нашего блока памяти
org 102094A8h - shift	; 29 bytes
	jmp		CInventoryItem_destructor_fix
	db		24 dup (090h)
return_CInventoryItem_destructor_fix:

;
org 102178A0h - shift
CShootingObject__Light_Render:

org 101B02FDh - shift
register_level__float__str_int_bool_str:

; тестовый фикс CWeapon__UpdateFireDependencies_internal
org 10219650h - shift
CWeapon__UpdateFireDependencies_internal:

org 102C8E60h - shift
__game_time: ; возвращает 64-х разрядное время - eax, edx соответственно младший и старший разряды

org 101E2FC0h - shift
CEntityCondition__UpdateConditionTime:
org 101E2F40h - shift
CEntityCondition__UpdateWounds:

org 10004990h - shift
xr_new_CAI_Space_:
org 10196130h - shift
CAI_Space__init:
org 10051560h - shift
CALifeTimeManager__game_time:

org 102A0AA0h - shift
game_GameState__SetEnvironmentGameTimeFactor:
org 102A0940h - shift
game_GameState__SetGameTimeFactor:
org 1028E320h - shift
generate_time:

;
org 10101033h - shift	; 6 bytes
	mov		eax, [ecx+0A8h] ; правка для вывода имени непися вместо имени визуала при вылете
; добавить в список правок строку: 0x10101033 6 ; mov	  eax, [ecx+0A8h]
org 1010104Fh - shift
	push	const_static_str$("! visual's error in stalker with name %s")	;offset aErrorInStalker_new
; добавить в список правок строку: 0x1010104F 5 ; push	  offset aErrorInStalker_new
;	push	offset aErrorInStalker ; "! error in stalker with visual %s"
;	call	ds:?Msg@@YAXPBDZZ ; Msg(char const *,...)

org 101AF7EDh - shift
register_level__set_snd_volume:

org 103F8C40h - shift
CUIWindow__Update:

;org 10068158h - shift
;	jmp		CALifeSimulatorBase__register_object_debug_fix
;org 10068160h - shift
;back_from_CALifeSimulatorBase__register_object_debug_fix:

org 102134C0h - shift
story_objects_find:
org 1006CA70h - shift
story_objects_add:

;org 100681C6h - shift
;	call	CALifeStoryRegistry__add


; регистрация sid в базе данных игры
org 1006C9E0h - shift
CALifeStoryRegistry__add: ; аргументы в стеке: this, story_id, object

;функция получения серверного объекта по id, аргументы в стеке: 1 - alife_simulator, 2 - id
; стек чистит вызывающая функция
org 1004BD50h - shift
object_by_id proc C (dword) self:ptr CALifeSimulator, object_id:word
object_by_id endp
;
org 1014A84Bh - shift	; 9 bytes
	call	script_register@@game_object_extended2
	nop2
	push	0

;отладочное сообщение о завершении создания объекта
org 101AC95Ah - shift
	jmp		CLevel__g_sv_Spawn_fix2

org 104584ACh - shift
CObjectList__Create dd ?
; отладочная врезка в CLevel::g_sv_Spawn
org 101AC832h - shift	; 6 bytes
	jmp		CLevel__g_sv_Spawn_fix
	nop
back_from_CLevel__g_sv_Spawn_fix:

;searchlight__turn_on
org 10253E2Bh - shift
	push	0
	call	edx
	pop		edi
	retn

;блокирование кривого движкового переключения гранат (включаем только если имеем альтернативную скриптовую схему)
org 10221D6Ch - shift
CGrenade__Action_exit:
org 10221D75h - shift	; 9 bytes
	mov		al, 1
	jmp		CGrenade__Action_exit
	nop5

org 103BE8C0h - shift
CUITradeWnd__CanMoveToOther:

; модификация механизма фильтрации предметов для торговли. 
; Добавляем дополнительную проверку флажка
org 103BE8C0h - shift
	jmp		CUITradeWnd__CanMoveToOther_fix
	nop4
return_CUITradeWnd__CanMoveToOther_fix:

;кастомная заливка предметов в окне торговли
org 103BF3DBh - shift	; 21 bytes
	call	CUITradeWnd@@GetIndexColor
	.if (al)
		push	edx
		mov		ecx, edi
		mov		eax, [edi]
		call	dword ptr [eax+90h]		; SetColor
		nop
	.endif

org 1014CAE0h - shift
register__void__void:

org 10253E00h - shift
CProjector__TurnOn: ; this = esi

org 10253E70h - shift
CProjector__TurnOff: ; this = esi

;
org 101562D5h - shift	;  bytes
	mov		[esp+64h-48h], offset CScriptGameObject@@disable_info_portion_fix
org 10146D00h - shift
CScriptGameObject@@DisableInfoPortion:
org 10146F80h - shift
CScriptGameObject@@HasInfo:

;тестовое слежение за закрытием диалога разговора
org 103C911Dh - shift
	jmp		CUITalkDialogWnd__Hide_test

org 10055B6Ch - shift
register__MMM_bool__void:

;
org 1005568Fh - shift	; 11 bytes
	jmp		mmm_fix
	mov		ecx, eax
	xor		eax, eax
	push	0
return_mmm_fix:

; попытка восстановить оффлайновое перемещение неписей
org 10054AD7h - shift ; вставить патч 7 байт
	nop7


; исправление идиотской опечатки в имени функции CALifeMonsterDetailPathManager:speed
; в оригинале на конце стоит символ табуляции, из-за чего её невозможно использовать.
org 1045E73Ch - shift	; 6 bytes
aSpeed			db "speed", 0

;
org 10412EB0h - shift	; 5 bytes
	jmp		scroll_vew_fix
back_from_scroll_vew_fix:

org 1013A56Ch - shift
register_matrix__this_float:
org 10139E96h - shift
register_matrix__this_float_float_float:

;скриптовые методы в класс matrix
org 101398CDh - shift	; 5 bytes
	jmp		matrix_fix
return_matrix_fix:
;оптимизация register_matrix__this__pMatrix_pMatrix
org 1013A307h - shift
register_matrix__this__pMatrix_pMatrix:
org 1047940Ch - shift
aMul			dd ?	; "mul"
org 10139820h - shift	; 7 bytes
	push	offset aMul
	nop2
org 1013A41Bh - shift	; 5 bytes
	push	[ebp+16]
	nop2


org 10451920h - shift
__allmul:

;оптимизация CTime_register__void__int_int_int
org 102C54FFh - shift
CTime_register__void__int_int_int:
org 104AEE64h - shift
aSethms			dd ?	; "setHMS"
org 102C4627h - shift	; 7 bytes
	push	offset aSethms
	nop2
org 102C55C1h - shift	; 5 bytes
	push	[ebp+12]
	nop2
;оптимизация CTime_register__void__pu32_pu32_pu32_pu32_pu32_pu32_pu32
org 102C579Fh - shift
CTime_register__void__pu32_pu32_pu32_pu32_pu32_pu32_pu32:
org 10479380h - shift
aGet			dd ?	; "get"
org 102C4686h - shift	; 7 bytes
	push	offset aGet
	nop2
org 102C5861h - shift	; 5 bytes
	push	[ebp+12]
	nop2
;скриптовые методы в классе CTime
org 102C4632h - shift	; 5 bytes
	jmp		ctime_fix
return_ctime_fix:

;скриптовые методы в класс CUIWindow
org 103FB34Fh - shift	; 5 bytes
	jmp		cuiwindow_fix
org 103FB355h - shift
return_cuiwindow_fix:

org 103FB7F3h - shift
register_CUIWindow__SetPPMode:

org 104014F8h - shift
CUIWindow_DetachChild:

org 101F0DE0h - shift
script_death_callback:


; попытка фикса кривого вылезания из машины
org 10272746h - shift
	movss	xmm4, ds:float_car_exit_distance

;10272746
;1027274E 

org 1021C5D0h - shift
CWeapon__UpdateHUDAddonsVisibility:

; активировать слот детекторов (8-й)
org 102042FDh - shift	; 6 bytes
	nop6

org 101E3830h - shift
CEntityCondition__BleedingSpeed:
org 101E2EB0h - shift
CEntityCondition__ChangeBleeding:

; миниправка для снятия ограничения на выкидывание из ящиков
org 101477AFh - shift
	nop6

org 1014D140h - shift
register__get_best_item: ; функция регистрации метода game_object с прототипом game_object* fun(void)

;при попытке удалить объект два раза через alife():release() игра теперь вылетает
org 1004C3D2h - shift	; 8 bytes
	jmp		release_fix
	nop3
org 1004C3DAh - shift
return_release_fix:

;убираем сообщение "[16-9] get_xml_name for ..."
org 103B8DEBh - shift	; 5 bytes
	jmp		addr_103B8DFF
org 103B8DFFh - shift
addr_103B8DFF:

;убираем сообщение "sv destroy object ..."
org 10355D85h - shift	; 6 bytes
	jmp		addr_10355D9B
	nop4
org 10355D9Bh - shift
addr_10355D9B:

;затычка на вылет "по xrServer::Process_event_reject ... e_parent && e_entity"
org 10356433h - shift	; 5 bytes
	jmp		xrServer__Process_event_reject_fix
return_xrServer__Process_event_reject_fix:

;убираем сообщение "sv reject. id_parent ..."
org 1035646Dh - shift	; 7 bytes
	mov		ebx, 16
	jmp		addr_10356489
org 10356489h - shift
addr_10356489:

;убираем сообщение "sv ownership id_parent ..."
org 103561C9h - shift	; 7 bytes
	mov		esi, 16
	jmp		addr_103561E5
org 103561E5h - shift
addr_103561E5:

org 101AD260h - shift
get_object_by_id:

;скриптовый колбек на перемещение предмета в ящик
org 102862FEh - shift	; 5 bytes
	jmp		inventory_box_fix
	nop

org 10011380h - shift
xr_vector_u16___push_back: ; запись идентификатора предмета в список предметов инвентарного ящика

org 1042BF40h - shift
CUIGameSP__StartCarBody: ;(int this<eax>, int pOurInv <stack>, int pBox <stack>)

org 1014C760h - shift
register__run_talk_dialog: ; функция регистрации метода game_object спрототипом void fun(game_object*)

;попытка вылечить вылет при переносе предмета в багажник машины
org 102065B7h - shift	; 6 bytes
	jmp		loc_1020663C_return_true
	nop
org 1020663Ch - shift
loc_1020663C_return_true:

eInventoryGrnBelt		= byte ptr (1 shl 0)
eInventoryAmmoBelt		= byte ptr (1 shl 1)
org 1020DD36h - shift	; 19 bytes
	jmp		CInventoryOwner@@Load_fix
	nop
	mov		[edi].CInventoryOwner.m_need_osoznanie_mode, 0
	jmp		CInventoryOwner@@Load_fix
	db		0CCh

;расширения конструктора CInventory
org 1020432Dh - shift	; 10 bytes
	jmp		CInventory__CInventory_fix
	db		5 dup (0CCh)
org 102041A0h - shift
CInventory@@CInventory:
; ;CInventoryOwner::CInventoryOwner()
; ;m_inventory = xr_new<CInventory>(this);
; org 1020DAB6h - shift	; 15 bytes
	; push	ebp
	; mov		ebp, edi	;owner
	; mov		esi, eax
	; call	CInventory@@CInventory
	; pop		ebp
	; nop4
; ;CCar::CCar()
; ;m_inventory = xr_new<CInventory>(NULL);
; org 10266D80h - shift	; 15 bytes
	; push	ebp
	; xor		ebp, ebp	;owner
	; mov		esi, eax
	; call	CInventory@@CInventory
	; pop		ebp
	; nop4
; в CInventory__Take проверить m_pOwner на нулевое значение и сделать обход ветки, его использующей
org 102046B1h - shift	; 14 bytes
	jmp		CInventory__Take_fix
	nop7
	nop2
return_CInventory__Take_fix:

; в CInventory__Ruck сделать проверку 
org 10204ED4h - shift	; 18 bytes
	jmp		CInventory__Ruck_fix
	nop7
	nop6
return_CInventory__Ruck_fix:

; аналогично в CInventory__DropItem
org 10204A57h - shift	; 12 bytes
	jmp		CInventory__DropItem_fix
	nop7
return_CInventory__DropItem_fix:

;новые консольные команды
org 1028E30Eh - shift	; 5 bytes
	jmp		add_console_commands_fix

org 10173415h - shift
register_gs__bool__void: ; регистрация в глобальном пространстве имён функции с прототипом bool fun(void)

;
org 102D5B17h - shift	; 3 bytes
	jmp		time_fix_jmp_label
	nop
org 102D5B2Ch - shift
time_fix_jmp_label:

;дополнительные врезки для расширения глобального пространства имён
org 10149CA2h - shift	; 7 bytes
	jmp		global_space_ext2
	nop2
return_global_space_ext2:

;скриптовые методы в глобальное пространство имен (часть 3)
org 10149D24h - shift	; 8 bytes
	jmp		global_space_ext2_additional
	nop3
return_global_space_ext2_additional:

; убираем кривую смену визуала при попадании костюма в рюкзак. Это будет делаться скриптом
org 1024C290h - shift	; 1 byte
	retn

; вставки для коррекции скриптового изменения FOV
org 101DE76Fh - shift	; 6 bytes
	fdiv	ds:g_fov

;
org 1023B20Dh - shift	; 8 bytes
	divss	xmm0, ds:g_fov

;
org 1027401Dh - shift	; 8 bytes
	divss	xmm0, ds:g_fov

;
org 10287828h - shift	; 8 bytes
	divss	xmm0, ds:g_fov

;
org 1021B80Fh - shift	; 6 bytes
	nop6

;
org 1021C632h - shift	; 9 bytes
	jmp		UpdateHUDAddonsVisibility_fix
	nop4
return_UpdateHUDAddonsVisibility_fix:

; фрагмент функции CWeapon__UpdateAddonsVisibility
org 1021CA2Fh - shift	; 23 bytes
	jmp		UpdateAddonsVisibility_fix
	db		17 dup (0CCh)

org 1006E8E0h - shift;(int this<esi>, unsigned __int16 id, int game_vertex_id, int level_vertex_id, int position)
CALifeUpdateManager@@teleport_object proc parent_id:dword, game_vertex_id:dword, level_vertex_id:dword, position:dword
CALifeUpdateManager@@teleport_object endp

;скриптовые методы в класс CALifeSimulator
; void __cdecl CALifeSimulator__script_register(int lua_state)
org 1004C9ADh - shift	; 5 bytes
	jmp		alife_simulator_fix
return_alife_simulator_fix:

; create(string <имя секции объекта>, vector* position, int level_vertex_id, int game_vertex_id, int parent_id)
org 1004E602h - shift
CALifeSimulator_register__CSE_Abstract__LPCSTR_pFvector_int_u16_u16:

;переделка CALifeSimulator_register__CSE_Abstract__LPCSTR_pFvector_int_u16_u16
org 1045DB20h - shift
aCreate			dd ?	; "create"
org 1004C99Bh - shift	; 7 bytes
	push	offset aCreate
	nop2
org 1004E6C4h - shift	; 5 bytes
	push	[ebp+12]
	nop2

org 1045094Ch - shift
__RTDynamicCast:

org 10206310h - shift 
CInventory__InBelt: ; int item<eax>, int this<ecx>
org 102062C0h - shift
CInventory__InSlot: ; int this<ebx>, int item<edi>
org 10206390h - shift
CInventory__CanPutInSlot: ; this<ebx>, int item<esi>
org 10206350h - shift
CInventory__CanPutInRuck: ; == ! CInventory__InRuck ; int item<eax>, int this<ecx>
org 10206410h - shift
CInventory__CanPutInBelt: ; item<edi>, int this<esi>
org 10205EC0h - shift
CInventory__CalcTotalWeight:
org 10204D90h - shift
CInventory__Ruck: ; ??????????????????????????
org 10204BE0h - shift
CInventory__Belt: ; this<eax>, int item <stack>
org 10204A90h - shift
CInventory__Slot: ; item<eax>, this<ecx>, bool activate <stack>


;CInventory__Belt
org 10204D75h - shift	; 12 bytes
	jmp		on_belt_callback
	db		7 dup (0CCh)

;CInventory__Ruck
org 10204F13h - shift	; 11 bytes
	jmp		on_ruck_callback

;CInventory__Slot
org 10204BCFh - shift	; 8 bytes
	jmp		on_slot_callback

;void __thiscall CActor::HitSignal(CActor* this, float perc, Fvector* dir, CObject* who, u16 bone)
org 101C6DC0h - shift
CActor@@HitSignal:
org 1048300Ch - shift	; 4 bytes
	dd offset CActor@@HitSignal_callback	;CActorMP
org 10483CFCh - shift	; 4 bytes
	dd offset CActor@@HitSignal_callback	;CActor

;
;org 100138F0h - shift	; 6 bytes
;	jmp		CHitMemoryManager__add3_fix
;	nop
;return_CHitMemoryManager__add3:

; миниправка функции get_rank на предмет блокировки сообщения "'cannot find rank for ..."
; для стволов, не прописанных в mp_ranks
org 10443CEDh - shift	; 8 bytes
	mov		dword ptr [esp+30h-24h], 0

;org 10149CF8h - shift
;	call	script_register_game_object1
;
;org 1014A580h - shift
;script_register_game_object1:
;	ret

; функция лога (в релизной версии ничего не делает)
org 10190080h - shift
LuaLog:

;скриптовые методы в глобальное пространство имен (часть 1)
org 10190492h - shift	; 5 bytes
	jmp		global_space_ext
return_global_space_ext:

; собственно функция, которая регистрирует глобальную скриптовую функция с прототипом void fun(char*);
; годится для любых функций такого вида
org 10190668h - shift
error_log_register:

; функция game_id
org 101A5520h - shift
loc_101A5520_game_id:

; функция, которая регистрирует фцнкцию вида int fff(void) . по идее в пространстве имён level
org 101AF9B1h - shift
game_id_register:

org 101E5720h - shift
CGameObject__lua_game_object: ; аргумент this в edi
org 101E5D60h - shift
CGameObject__callback_helper: ; оба аргумента в стеке
org 101E5AF0h - shift
CGameObject__callback: ; оба аргумента в стеке
org 10014CF0h - shift
script_hit_callback: ; аргументы в стеке

org 10190698h - shift
bit_and_register:

;-------------| Фрагмент script_register_game_object2 |------------------------
;новые скриптовые методы в CScriptGameObject
org 10155D8Ch - shift	; 11 bytes
	call	script_register@@game_object_extended
	nop2
	xor		bl, bl
	push	0
;------------------------------------------------------------------------------
org 10142990h - shift
CScriptGameObject__get_car:

org 103DF710h - shift
ch_info_get_from_id:

org 103F0D90h - shift
CUIStatic__AdjustHeightToText:

org 103F0DE0h - shift
CUIStatic__AdjustWeigthToText:

;скриптовый колбек на выделение контакта в ПДА во вкладке "Контакты"
org 103BFF64h - shift ; 5 bytes
	jmp		call_pda_contact_callback
return_call_pda_contact_callback:
	
org 103E35D0h - shift
SendInfoToActor:

;
org 1013F2F0h - shift
CScriptGameObject__ID:

;добавляет в xml параметры adjust_height_to_text и adjust_width_to_text
org 103E5C6Eh - shift
	jmp		cuistatic_xml_add
org 103E5C73h - shift
return_cuistatic_xml_add:

; Ищутся по именам в окне Names IDA
org 10458DA8h - shift
Msg dword ?

org 104586CCh - shift
CObject__processing_activate dword ?

org 10458B94h - shift
FlushLog dword ?

org 105602E8h - shift
g_Actor dword ?
org 1055FC80h - shift
g_key_bindings	dword ?

org 105602C8h - shift
g_bDisableAllInput db ?

org 104585A8h - shift
pInput dd ?
org 104585ACh - shift
CInput__GetAsyncKeyState:

org 10458A44h - shift
CKinematics__LL_BoneID dword ? ; функция получения номера кости по её имени
org 104588F4h - shift
CKinematics__LL_GetBonesVisible dword ? ; получение видимости всех костей
org 104588F8h - shift
CKinematics__LL_SetBoneVisible dword ? ; установка видимости кости
org 104588C0h - shift
CKinematics__LL_GetBoneVisible dword ? ; получение видимости кости с заданным номером
org 10458970h - shift
CKinematics__CalculateBones_Invalidate dword ?

org 1021C840h - shift
CWeapon__UpdateAddonsVisibility:

org 1053C598h - shift
g_fov dword ?

org 10458DB0h - shift
g_pStringContainer dword ?
org 10458DACh - shift
str_container__dock dword ?

org 10458714h - shift
_ds@CObject@@cNameVisual_set	dd ?
CObject@@cNameVisual_set proc N:dword
CObject@@cNameVisual_set endp
org 101D2D30h - shift
CActor@@ChangeVisual proc NewVisual:dword
CActor@@ChangeVisual endp

org 10458A4Ch - shift
g_pGamePersistent dword ?

org 10458504h - shift
CEnvironment__SetGameTime dword ?

org 10149F6Eh - shift
register__gs_sell_condition__fl_fl:

org 10458EECh - shift
luabind__scope__operator_ dword ?

;-------------------------------------------------------------
; level.get_target_dist()
;-------------------------------------------------------------
org 101AF85Dh - shift
get_snd_volume_register:
org 101B06FBh - shift
register_level__void__u16:

;скриптовые методы в пространство level (часть 1)
org 101AEF0Fh - shift	; 7 bytes
	jmp		level_script_extension_1
	nop2
return_level_script_extension_1:
;пространство actor_stats
org 101AF2DDh - shift	; 7 bytes
	jmp		level_script_extension_2
	nop2
return_level_script_extension_2:
;скриптовые методы в пространство level (часть 2)
org 101AF1C1h - shift	; 8 bytes
	jmp		level_ns_extension_2
	nop
	nop
	nop
return_level_ns_ext_2:
;скриптовые методы в пространство actor_stats (часть 2)
org 101AF31Bh - shift	; 8 bytes
	jmp		level_ns_extension_3
	nop
	nop
	nop
return_level_ns_extension_3:
;-------------------------------------------------------------
org 10458498h - shift
g_hud					dd ? ; class CCustomHUD * g_hud
;-------------------------------------------------------------
; level.get_target_obj()
;-------------------------------------------------------------
org 10458B04h - shift
Memory					dd ?	;?Memory@@3VxrMemory@@A
org 10458DFCh - shift
xrMemory__mem_alloc		dd ?	;?mem_alloc@xrMemory@@QAEPAXI@Z
org 10458AFCh - shift
xrMemory__mem_free		dd ?

org 10458EB4h - shift
luabind__detail__registration__registration		dd ?

org 101AF65Fh - shift
loc_101AF65F:

org 10481E80h - shift
off_10481E80:

org 101AD260h - shift
sub_101AD260:

org 101AF661h - shift
loc_101AF661:

;=================================================
; затычки для регистрации консольной команды на изменение целого с двумя пределами

org 104A7014h - shift
off_104A7014	dd ?

org 10458678h - shift
Console dd ?

org 10450A5Fh - shift
_atexit:

org 104589C0h - shift
CConsole__AddCommand dd ?

org 10458690h - shift
CConsole__Execute dd ?

org 104587FCh - shift
CCC_Integer__CCC_Integer dd ?
org 10458814h - shift
CCC_Integer___CCC_Integer dd ?

org 10458818h - shift
CCC_Mask__CCC_Mask dd ?
org 1045881Ch - shift
CCC_Mask___CCC_Mask dd ?

org 1056063Ch - shift
g_bHudAdjustMode dd ?

;-------------------
org 104A702Ch - shift
off_104A702C dd ?

org 104587D4h - shift
CCC_Float__CCC_Float dd ?

org 104587E4h - shift
CCC_Float___CCC_Float dd ?

org 10560640h - shift
g_fHudAdjustValue dd ?					

; заглушки для функции преобразования SGO в CInventoryBox
org 1054F0B0h - shift
off_1054F0B0	dd ?

; заглушки для функции получения худа
org 1054F0E8h - shift
off_1054F0E8 dd ?

org 1054F0CCh - shift
off_1054F0CC dd ?

org 104589FCh - shift
g_pGameLevel dd ?

; заглушки для фикса инвентаря
org 10458870h - shift
CObject__H_SetParent dd ?
org 10458A9Ch - shift
CObject__setVisible dd ?
org 104586B0h - shift
CObject__getVisible dword ?
org 10458AA8h - shift
CObject__setEnabled dd ?

; для функции вылета
org 10458B00h - shift
Debug dd ?
org 10458DD0h - shift
xrDebug__fail dd ?

; для регистрации глобальных функций
org 10458EC0h - shift
luabind__scope__scope@std__auto_ptr@luabind__detail__registration@@ dd ?
org 10458FB4h - shift
luabind__scope__scope dd ?
org 10458F9Ch - shift
luabind__scope___scope dd ?

org 105602D8h - shift
psActorFlags	dd ?

org 10458478h - shift
CCameraManager__GetPPEffector dd ?
org 10458864h - shift
CCameraManager__GetCamEffector dd ?

; для регистрации метода game_object, возвращающего script_ini
org 10150F20h - shift
sub_10150F20:
org 1015B3E0h - shift
sub_1015B3E0:

;для новых методов в пространстве имен level
org 10190CF7h - shift
register_level__int__int:
org 10173415h - shift
register_level__bool__void:

org 10560864h - shift
g_fTimeFactor dd ?

org 105602B0h - shift
g_ai_space dd ?

org 104589F8h - shift
Device dd ?

org 10458FC0h - shift
IPureClient__timeServer_Async dd ?

org 10458AE0h - shift
CKinematicsAnimated__ID_Cycle dd ?

org 104586D0h - shift
CKinematicsAnimated__PlayCycle dd ?

org 10458B3Ch - shift
Log_vector3 dd ?
org 10458B9Ch - shift
Log_float dd ?

; IRender_Light
org 104588D4h - shift
resptr_base_IRender_Light____dec dd ? ; 
org 104588C8h - shift
resptr_base_IRender_Light____get dd ? ; 

org 104584D4h - shift
Render		dd ?			;IRender_interface*

org 104518A2h - shift
memset: ; dd ? ; void *__cdecl memset(void *Dst, int Val, size_t Size)

org 1045871Ch - shift
_ds@CObjectSpace__RayPick dd ?
CObjectSpace__RayPick proc pos:dword, dir:dword, range:real4, RQ:dword, res:dword, ignor_obj:dword
CObjectSpace__RayPick endp
CObjectSpace@@RayPick MACRO pos:req, dir:req, range:req, RQ:req, res:req, ignor_obj:req
	pushvar	ignor_obj
	pushvar	res
	pushvar	RQ
	pushvar	range
	pushvar	dir
	pushvar	pos
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	add		ecx, CLevel.ObjectSpace
	call	ds:_ds@CObjectSpace__RayPick
	EXITM <eax>
ENDM

;использование патронов на поясе
org 10205D71h - shift	; 5 bytes
	jmp		CInventory__Get
	add		eax, 24h
return_CInventory__Get:
org 1021C266h - shift	; 6 bytes
	jmp		CWeapon__GetCurrentAmmo
	nop
CWeapon__GetCurrentAmmo_not_ammo_on_belt:
org 1021C2BAh - shift
CWeapon__GetCurrentAmmo_not_inventory_owner:

;использование гранат на поясе
org 10205C20h - shift	; 256 bytes
	db		256 dup (0CCh)
org 10205C20h - shift	; 256 bytes
;функция поиска гранат такого же типа, что и pIItem, на поясе
;CInventoryItem *__stdcall CInventory::Same(CInventory *this, CInventoryItem *pIItem)
CInventory@@Same proc uses esi edi ebx _this:ptr CInventory, pIItem:ptr CInventoryItem	;, bSearchRuck:byte
	mov		eax, _this
	.if ([eax].CInventory.m_flags & eInventoryGrnBelt)
		lea		edx, [eax].CInventory.m_belt	;пояс
	.else	;bSearchRuck
		lea		edx, [eax].CInventory.m_ruck	;рюкзак
	.endif
	mov		esi, [edx].xr_vector._Myfirst	;it		= list.begin()
	mov		edi, [edx].xr_vector._Mylast	;it_end	= list.end()
	mov		ebx, pIItem
	mov		eax, [ebx].CInventoryItem.CInventoryItem@m_object
	mov		eax, [eax].CPhysicsShellHolder.NameSection.p_
	mov		edx, [eax].str_value.dwLength
	mov		ecx, [eax].str_value.dwCRC
	.for (: esi!=edi: esi+=4)
		mov		eax, [esi]	;l_pIItem
		.if (eax != ebx)
			mov		eax, [eax].CInventoryItem.CInventoryItem@m_object
			mov		eax, [eax].CPhysicsShellHolder.NameSection.p_
			ASSUME	eax:ptr str_value
			.if ([eax].dwLength==edx && [eax].dwCRC==ecx)
				mov		eax, [esi]
				jmp		exit
			.endif
			ASSUME	eax:nothing
		.endif
	.endfor
	xor		eax, eax
exit:
	ret
CInventory@@Same endp

org 10205D20h - shift
CInventory__SameSlot:

;CGrenade::PutNextToSlot
org 10221C2Ch - shift	; 5 bytes
	call	CInventory__SameSlotInBelt
org 10221BA6h - shift	; 6 bytes
	jmp		CGrenade__fix1
	nop
return_CGrenade__fix1:
;CInventory::dwfGetSameItemCount
org 10205F1Bh - shift	; 5 bytes
	jmp		grenade_counter_fix
	nop
return_grenade_counter_fix:
;CGrenade::GetBriefInfo
org 10222067h - shift	; 8 bytes
	jmp		grenade_counter_fix1
	nop3
return_grenade_counter_fix1:
;CGrenade::PutNextToSlot
org 10221C58h - shift	; 2 bytes
	push	1
;CGrenade::PutNextToSlot
org 10221B83h - shift	; 8 bytes
	mov		eax, [edi].CGrenade.m_pCurrentInventory ; this
	test	eax, eax
;CGrenade::PutNextToSlot
org 10221B93h - shift	; 5 bytes
	call	CInventory__Belt	;(CInventory *this@<eax>, CInventoryItem *pIItem)


;новые слоты в инвентаре (нож, бинокль, фонарь)
org 10418420h - shift	
CUIDragDropListEx@@CUIDragDropListEx:
org 103E6820h - shift	
CUIXmlInit@@InitDragDropListEx:
org 103BBB40h - shift	
CUIInventoryWnd@@BindDragDropListEnents:
org 10418330h - shift	
create_cell_item:
org 10418D70h - shift	
CUIDragDropListEx@@ClearAll:

org 103BA6ADh - shift	; 5 bytes
	jmp		CUIInventoryWnd__Init__
return_CUIInventoryWnd__Init__:
org 103BBD8Dh - shift	; 8 bytes
	jmp		CUIInventoryWnd__InitInventory__
	nop3
return_CUIInventoryWnd__InitInventory__:
org 103BC590h - shift	; 80 bytes
	db		80 dup (0CCh)
org 103BC590h - shift	; 80 bytes
; получение ячейки для слота
CUIInventoryWnd__GetSlotList proc uses edi ebx
;edx	this		CUIInventoryWnd
;ecx	slot_idx	u32
	xor		edi, edi
	.if (ecx<=12)
		;GetInventory()->m_slots[slot_idx]
		mov		ebx, [edx].CUIInventoryWnd.m_pInv
		mov		eax, ecx
		shl		eax, 4	;*16
		add		eax, [ebx].CInventory.m_slots._Myfirst
		.if (![eax].CInventorySlot.m_bPersistent)
			mov		eax, tblUIList[ecx*4]
			.if (eax)
				mov		edi, [edx+eax]
			.endif
		.endif
	.endif
	mov		eax, edi
	ret
CUIInventoryWnd__GetSlotList endp	
org 103BC5E0h - shift	; 5 bytes
	jmp		CUIInventoryWnd__ClearAllLists
org 10204311h - shift	; 5 bytes
	jmp		CInventory__Init__
return_CInventory__Init__:
org 1042AA44h - shift	; 5 bytes
	push	size CUIInventoryWnd
org 1042B8A8h - shift	; 5 bytes
	push	size CUIInventoryWnd
org 10206C02h - shift	; 3 bytes
	cmp		eax, 13
org 10206C1Fh - shift	; 5 bytes
	mov		esi, 13				; 11 + num_of_extra_slots
org 10206C35h - shift	; 6 bytes
	lea		eax, [edx+13*(size CInventorySlot)]		; 11 + num_of_extra_slots
org 10206951h - shift	; 6 bytes
	cmp		edx, 13*(size CInventorySlot)			; 11 + num_of_extra_slots
	
; учет предмета в шлемовом слоте при расчете хита актору
org 101C9B80h - shift	; 5 bytes
	jmp		CActor__HitArtefactsOnBelt
	
; включение сетки под броней
org 103BD9E0h - shift	; 5 bytes
	jmp		CUIWindow__Draw
org 103F8BE0h - shift
CUIWindow__Draw:

org 103BD592h - shift	; 5 bytes
	pop		eax
	nop4

; тень от ГГ на R2
org 104584F4h - shift	
psDeviceFlags		dd ?
org 101C8957h - shift
loc_101C8957:
org 101DEE40h - shift	
sub_101DEE40:
org 1020E560h - shift	
CInventoryOwner@@renderable_Render:
org 101C85CFh - shift	; 6 bytes
	jmp		CActor__Update_fix
	nop
return_CActor__Update_fix:
org 101C8946h - shift	; 20 bytes
	jmp		CActor__renderable_Render_fix
	db		15 dup (0CCh)
;;;return_CActor__renderable_Render_fix:
;org 104253C8h - shift	; 8 bytes
;	jmp		CActor__Update_two_fix
;	nop3
;return_CActor__Update_two_fix:

;-------------------------------------------------------------
; Переключение на болт вращением колеса мышки
; Отключение/включение колеса мышки для переключения между слотами:
; 0 - нож,
; 1 - пистолет,
; 2 - автомат,
; 3 - граната,
; 4 - бинокль,
; 5 - болт
;-------------------------------------------------------------
org 101DEEA0h - shift
CActor@@OnNextWeaponSlot:
org 101DEF40h - shift
CActor@@OnPrevWeaponSlot:
;перехват методов
org 104830E4h - shift	; 4 bytes
	dd offset	CActor@@OnNextWeaponSlotNew
org 10483DD4h - shift	; 4 bytes
	dd offset	CActor@@OnNextWeaponSlotNew
org 104830E8h - shift	; 4 bytes
	dd offset	CActor@@OnPrevWeaponSlotNew
org 10483DD8h - shift	; 4 bytes
	dd offset	CActor@@OnPrevWeaponSlotNew
org 1053C55Ch - shift	; 28 bytes
SlotsToCheck	dd	0, 1, 2, 3, 4, 5, 10	;Небольше 7-ми!!!
;;const_static_int		New, 
NumSlotsToCheck			= 7
;void	CActor::OnNextWeaponSlot(CActor *this)
org 101DEECCh - shift	; 3 bytes
	cmp		eax, NumSlotsToCheck
org 101DEED3h - shift	; 3 bytes
	cmp		eax, NumSlotsToCheck
org 101DEEDBh - shift	; 3 bytes
	cmp		eax, NumSlotsToCheck
org 101DEF04h - shift	; 3 bytes
	cmp		eax, NumSlotsToCheck
;void	CActor::OnPrevWeaponSlot(CActor *this)
org 101DEF6Ch - shift	; 3 bytes
	cmp		eax, NumSlotsToCheck
org 101DEF73h - shift	; 3 bytes
	cmp		eax, NumSlotsToCheck
;-------------------------------------------------------
;-------------------------------------------------------
; Инверсия колеса мышки для смены оружия
;-------------------------------------------------------
; CActor__IR_OnMouseWheel
org 101DE3F2h - shift	; 6 bytes
	mov		eax, [edx+2ACh]

; CActor__IR_OnMouseWheel
org 101DE400h - shift	; 6 bytes
	mov		eax, [edx+2A8h]
	
;-------------------------------------------------------
; Коллбэк актора на выделение предмета (CInventoryItem)
; в инвентаре актора, ящике, трупе, окне торговли
;-------------------------------------------------------
org 103E1B28h - shift	; 5 bytes
	jmp		CUIItemInfo__InitItem_EXT_CHUNK
return_CUIItemInfo__InitItem_EXT_CHUNK:

;Фонарь.
org 102485D0h - shift
CTorch__Switch:

org 104D27F8h - shift ; 0.01745329300562541
dbl_104D27F8 dq ?

org 102485D4h - shift	; 6 bytes
	jmp		CTorch__Switch_Callback
	nop
return_CTorch__Switch_Callback:

org 1045862Ch - shift ; ?LALib@@3VELightAnimLibrary@@A
off_1045862C dd ?
org 10458630h - shift ; ?FindItem@ELightAnimLibrary@@QAEPAVCLAItem@@PBD@Z
off_10458630 dd ?

;------------------------------------------------------
org 10458A00h - shift
g_dedicated_server		dd ?	; bool 

;колбек на хит объекта в аномалии.	(c) NanoBot
org 103AA120h - shift
SHit__Write_Packet:
org 1008F690h - shift
SPHImpact__push_back:
org 101AC970h - shift
CLevel@@spawn_item proc this_:dword, section_:dword, level_vertex_id:dword, parent_id:dword, return_item:dword
CLevel@@spawn_item endp
org 1025A0A1h - shift	; 5 bytes
	jmp		CCustomZone__CreateHit_callback
return_CCustomZone__CreateHit_callback:
;колбек на вход в зону аномалии
org 10258057h - shift	; 8 bytes
	jmp		CCustomZone__enter_Zone_callback
	db		3 dup (090h)
return_CCustomZone__enter_Zone_callback:
;колбек на выход из зоны аномалии
org 102581AFh - shift	; 8 bytes
	jmp		CCustomZone__exit_Zone_callback
	db		3 dup (090h)
return_CCustomZone__exit_Zone_callback:
;Колбек на разрушения объекта в аномалии
org 1008EC24h - shift	; 5 bytes
	jmp		CTeleWhirlwindObject__destroy_object_callback
return_CTeleWhirlwindObject__destroy_object_callback:
;------------------------------------------------------

; Duplicate story id fix
org 1006CA0Fh - shift	; 48 bytes
	db		48 dup (90h)
org 1006CA0Fh - shift	; 48 bytes
	PRINT_UINT "Warning! Was found duplicate story id [%d].", edi
	jmp		loc_1006CA3F
org 1006CA3Fh - shift
loc_1006CA3F:
	
; коллизия актора с мертвыми телами
org 103917AAh - shift	; 2 bytes
	jmp		short collide_label
org 103917F1h - shift
collide_label:

; принудительное убирание оружия на леснице
org 101CF1E4h - shift	; 2 bytes
	push	0FFFFFFFFh	; используется короткая форма
; принудительное убирание оружия в машине
org 1053E810h - shift	; 4 bytes
	dd 0FFFFFFFFh

; смерть от первого лица
org 101C748Ch - shift	; 10 bytes
	mov		dword ptr [edi+530h], 0		; ACTOR_DEFS::eacFirstEye
	
; Выдача инфопоршений при закрытии окна разговора.
org 103CADB8h - shift	; 5 bytes
	jmp		CUITalkWnd__Hide_fix
return_CUITalkWnd__Hide_fix:

org 104C3524h - shift
aUi_talk_hide db ?

; экспорты функций для работы с CHangingLamp
org 10140440h - shift
CScriptGameObject__get_hanging_lamp:
;Вызов коллбека после установки lvid'a 
org 1001AD80h - shift
CMovementManager__set_level_dest_vertex:

org 1014369Fh - shift	; 5 bytes
	jmp		CScriptGameObject__set_dest_level_vertex_id_callback
return_CScriptGameObject__set_dest_level_vertex_id_callback:

org 1011E490h - shift
	CLevelGraph__vertex_id:

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; для новых консольных команд
; ph_timefactor
org 1053B6E8h - shift
phTimefactor dd ?

; ph_gravity
org 103581CEh - shift	; 8 bytes
	movss		xmm0, ds:phGravity
; =========================================================================================
; костыль от вылета при юзе предмета из трупа
;;org 103CC55Eh - shift	; 236 bytes
;;	db		236 dup (0CCh)
org 103CC55Eh - shift	; 6 bytes
	pop		edi
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn
; =========================================================================================
; функции переключения ПНВ
; CTorch::SwitchNightVision(CTorch *this, bool vision_on)
org 102482F0h - shift
CTorch__SwitchNightVision:
; =========================================================================================
; высадка актора из тачки
; CActor::detach_Vehicle(CActor *this)
org 101DF280h - shift
CActor__detach_Vehicle:
; =========================================================================================
; регистрации новых методов в классе CUIStatic
org 103F12C5h - shift	; 5 bytes
	jmp		cuistatic_fix
return_cuistatic_fix:
org 103F1781h - shift
sub_103F1781:
; void __thiscall CUIStatic__SetTextComplexMode(CUIStatic *this, bool md)
org 103F0520h - shift
CUIStatic__SetTextComplexMode:
; void __userpurge CUIStatic__SetVTextAlignment(CUIStatic *this, EVTextAlignment al<ebx>)
org 103F0C80h - shift
CUIStatic__SetVTextAlignment:
; void __thiscall CUIStatic__SetTextPos(CUIStatic *this, float x, float y)
org 103C1A60h - shift
CUIStatic__SetTextPos:
; =========================================================================================
; для регистрации новых cui-методов
; void cui_func(int)
org 1040EFF9h - shift
register_CUIComboBox__SetCurrentID:
; void cui_func(uint)
org 103F15A0h - shift
register_CUIStatic__SetColor:
; void cui_func(bool)
org 1042084Bh - shift
register_CUIListWnd__ActivateList:
; void cui_func(float)
org 103FB7C8h - shift
register_CUIWindow__SetHeight:
; void cui_func(float, float)
org 103FB772h - shift
register_CUIWindow__SetWndPos:
; int cui_func(void)
org 104208CBh - shift
register_CUIListWnd__GetSize:
; =========================================================================================
; для обновления статика веса в инвентаре
; InventoryUtilities::UpdateWeight(CUIStatic *wnd, bool withPrefix)
org 103E3040h - shift
InventoryUtilities__UpdateWeight:
; =========================================================================================
; коллбек на дроп из окна инвентаря актора (контекстное меню или клавиша G)
org 103BB997h - shift	; 9 bytes
	jmp		CUIInventoryWnd__SendEvent_Item_Drop
	nop4
return_CUIInventoryWnd__SendEvent_Item_Drop:
; =========================================================================================
; убираем из описания ножа прогресс бары оружия
org 103E0D97h - shift	; 5 bytes
	jmp		CUIWpnParams__Check_fix
org 103E0DA7h - shift
return_CUIWpnParams__Check_fix:
org 103E0DBEh - shift
loc_103E0DBE:
; xr_strcmp(shared_str const &,char const *)
org 10037320h - shift
xr_strcmp:
; =========================================================================================
; фикс выдачи инфо о вкладках ПДА
org 103C0D87h - shift	; 5 bytes
	jmp		cui_pda_fix_map
org 103C0E05h - shift	; 5 bytes
	jmp		cui_pda_fix_map2
org 103C0E1Fh - shift
return_cui_pda_fix:
; =========================================================================================
; выдача инфо при переключении между описанием задания и картой
org 103DBC23h - shift	; 5 bytes
	jmp		CUITaskRootItem__OnSwitchDescriptionClicked_fix
return_CUITaskRootItem__OnSwitchDescriptionClicked_fix:
org 103DA9B0h - shift
CUIEventsWnd__SetDescriptionMode:
; =========================================================================================
; также учитываем переключение между вкладками активных, выполненных и проваленных заданий
org 103DA737h - shift	; 5 bytes
	jmp		CUIEventsWnd__OnFilterChanged_fix
return_CUIEventsWnd__OnFilterChanged_fix:
org 103DA780h - shift
CUIEventsWnd__ReloadList:
; =========================================================================================
; коллбек на появление хитэффектора от монстра или НПС
org 101C6D69h - shift	; 8 bytes
	jmp		CActor__HitMark_callback
	nop3
return_CActor__HitMark_callback:
org 1007DC5Bh - shift	; 8 bytes
	jmp		CBaseMonster__HitEntity_callback
	nop3
return_CBaseMonster__HitEntity_callback:
org 1007E730h - shift
sprintf_s64:
; =========================================================================================
; фикс биографии в ПДА
org 103E0123h - shift	; 7 bytes
	jmp		CUICharacterInfo__InitCharacter_fix
	nop2
return_CUICharacterInfo__InitCharacter_fix:
; void __thiscall CUIStatic__SetTextColor_script(CUIStatic *this, int a, int r, int g, int b)
org 103F1090h - shift
CUIStatic__SetTextColor_script:
; =========================================================================================
; функция разворота камеры на объект
; void __usercall UpdateCameraDirection(CGameObject *pTo<eax>)
org 103CA530h - shift
UpdateCameraDirection:
; =========================================================================================
; функция получения айди худовой анимации с проверкой на наличие самой анимации
; MotionID *__thiscall CKinematicsAnimated__ID_Cycle_Safe(CKinematicsAnimated *this, MotionID *result, const char *N)
org 10458A50h - shift
CKinematicsAnimated__ID_Cycle_Safe dd ?
; =========================================================================================
; функция получения длительности худовой анимации
; unsigned int __thiscall shared_weapon_hud__motion_length(shared_weapon_hud *this, MotionID M)
org 10239460h - shift
shared_weapon_hud__motion_length:
; =========================================================================================
; функции для работы с эффектами камеры
; CCameraManager::AddCamEffector(class CEffectorCam *)
org 1045886Ch - shift
CCameraManager__AddCamEffector dword ?
; xr_new<CMonsterEffectorHit,float,float,float,float>(float const &,float const &,float const &,float const &)
org 1007E770h - shift
xr_new__CMonsterEffectorHit proc C time:real4, amp:real4, periods:real4, power:real4
xr_new__CMonsterEffectorHit endp
; =========================================================================================
; инерция во время прицеливания из оружия
org 1024DB00h - shift	; 10 bytes
	nop6
	nop4
; =========================================================================================
; круглый курсор, как в билдах
org 1044D15Eh - shift	; 6 bytes
	nop6
; =========================================================================================
; исправление вида от 3-го лица
org 101C43F8h - shift	; 2 bytes
	nop2
org 101D20B0h - shift	; 2 bytes
	jmp		short loc_101D20B9
org 101D20B9h - shift
loc_101D20B9:
; =========================================================================================
; шкала "освещения ГГ" вместо шкалы "заметности ГГ", как в билдах
org 10017E9Bh - shift	; 6 bytes
	jmp		loc_10017F97
	nop
org 10017F97h - shift
loc_10017F97:
org 103D09CFh - shift	; 3 bytes
	cmp		eax, 0
; =========================================================================================
; руки на руле в машине
org 10269AE2h - shift	; 4 bytes
	nop2
	push	1
org 1026F808h - shift	; 3 bytes
	cmp		[eax+77h], ecx
org 1026F9A7h - shift	; 2 bytes
	jmp		short loc_1026F9AC
org 1026F9ACh - shift
loc_1026F9AC:
org 1026F9B6h - shift	; 2 bytes
	nop2
; =========================================================================================
; выключение распознавания неписей перекрестием прицела
org 1044CC94h - shift	; 6 bytes
	jmp		loc_1044CE1A
	nop
org 1044CE1Ah - shift
loc_1044CE1A:
; =========================================================================================
; возможность использовать скрипты в мультиплеере (включение биндеров)
org 101407F3h - shift	; 2 bytes
	jmp		short loc_101407F9
org 101407F9h - shift
loc_101407F9:
; =========================================================================================
; измененная анимация безоружного ГГ ("_torso_0_aim_0" -> "_torso_5_aim_0")
org 101D922Bh - shift	; 5 bytes
	push	const_static_str$("_torso_5_aim_0")	;offset a_torso_5_aim_0
; =========================================================================================
; увеличение дистанции диалога (3.0 -> 150.0)
static_float	TALK_DIST, 150.0
org 103CAD20h - shift	; 6 bytes
	fld		ds:TALK_DIST
; =========================================================================================
; возможность поднимать болты как обычные инвентарные предметы
org 10491C28h - shift	; 4 bytes
	dd	sub_10209B00
org 10209B00h - shift
sub_10209B00:
; =========================================================================================
; замена стандартного шрифта под прицелом на билдовский "DI"
org 1044CB92h - shift	; 3 bytes
	mov		esi, [eax+18h]
; =========================================================================================
; фикс скриптового метода unload_magazine - теперь патроны разряжаются в инвентарь
org 10147737h - shift	; 2 bytes
	push	1
; =========================================================================================
; отключение использования аптечек и бинтов быстрыми клавишами
org 101DE150h - shift	; 6 bytes
	jmp		loc_101DE329
	nop
org 101DE329h - shift
loc_101DE329:
; =========================================================================================
; включение миксовки анимаций у оружия с подствольником (bMixIn = on)
org 1022A155h - shift ; CWeaponMagazinedWGrenade::switch2_Reload()
	push	1
org 1022B4F9h - shift ; CWeaponMagazinedWGrenade::PlayAnimShow()
	push	1
org 1022B66Eh - shift ; CWeaponMagazinedWGrenade::PlayAnimIdle() part 1
	push	1
org 1022B6A4h - shift ; CWeaponMagazinedWGrenade::PlayAnimIdle() part 2
	push	1
org 1022B847h - shift ; CWeaponMagazinedWGrenade::PlayAnimModeSwitch()
	push	1
; =========================================================================================
; замена текстуры трассера ("fx\fx_tracer" -> "effects\bullet_tracer")
org 101BB9B7h - shift	; 5 bytes
	push	const_static_str$("effects\bullet_tracer")	;offset aTracerTexture
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
org 104584D0h - shift
IInputReceiver__IR_GetKeyState		dd ?

; Разработчики видно сделали опечатку и нужная команда не попала в блок условия. Real Wolf.
org 1008F753h - shift
loc_fix:
org 1008F72Dh - shift	; 2 bytes
	jz		short loc_fix

; Коллбеки для машины
org 101DF1D5h - shift	; 5 bytes
	jmp		CActor__attach_Vehicle_callback
CActor__attach_Vehicle_callback_back:

org 101DF2B5h - shift	; 6 bytes
	jmp		CActor__detach_Vehicle_callback
	nop
CActor__detach_Vehicle_callback_back:

org 101DF4E8h - shift	; 5 bytes
	jmp		CActor__use_Vehicle_callback
return_CActor__use_Vehicle_callback:
org 101DF50Ch - shift
CActor__use_Vehicle_callback_skip:
org 101DF534h - shift
CActor__use_Vehicle_callback_exit:

;Скриптовый коллбек (136 для CActor) на создание объекта CUICellItem. Передается игровой объект.
;org 10418330h - shift	; 5 bytes
;	jmp		create_cell_item_fix
;org 10418335h - shift
;create_cell_item_changed:
org 1041835Dh - shift	; 7 bytes
	jmp		create_cell_item_fix
	nop2
org 10418398h - shift	; 7 bytes
	jmp		create_cell_item_fix
	nop2
org 104183B9h - shift	; 7 bytes
	jmp		create_cell_item_fix
	nop2
org 103FAD40h - shift	; 5 bytes
	mov		eax, offset CUIFrameWindow__GetTitleStatic_fix

org 103F0D18h - shift	; 6 bytes
	jmp		CUIStatic__OnFocusRecieve_callback
	nop
return_CUIStatic__OnFocusRecieve_callback:

org 103F0D50h - shift	; 5 bytes
	jmp		CUIStatic__OnFocusLost_callback
return_CUIStatic__OnFocusLost_callback:

org 1006A189h - shift	; 5 bytes
	jmp		after_save_callback

; замена шейдера прицелов
const_static_str	aSh,	"hud\scope"
org 10227C07h - shift	; 5 bytes
	push	offset aSh
org 10227D2Dh - shift	; 5 bytes
	push	offset aSh

; Арты из рюкзака
org 101C9A71h - shift	; 6 bytes
	mov		ebp, [eax+8]
	cmp		[eax+0Ch], ebp
org 101C9B6Fh - shift	; 3 bytes
	cmp		[ecx+0Ch], ebp
org 101C9B95h - shift	; 6 bytes
	mov		esi, [eax+8]
	cmp		[eax+0Ch], esi
org 101C9C12h - shift	; 3 bytes
	cmp		[ecx+0Ch], esi

; принудительная очистка пула моделей при завершении игры
org 101A8C9Dh - shift	; 2 bytes
	push	byte ptr 1

; Чувствительность мыши
org 1044D5A3h - shift	; 6 bytes
	jmp		cursor_change_sens
	nop
return_cursor_change_sens:

; хак для более корректного учета бронебойности патронов
org 1024BEFFh - shift	; 6 bytes
	jmp		armor_piercing_fix
	nop
return_armor_piercing_fix:

; затычка от вылета в деструкторе CGameObject
org 101E6505h - shift	; 5 bytes
	jmp		game_object_destructor_fix
return_game_object_destructor_fix:

; исправление неотключения света при выключении аномалии
org 10257BA4h - shift	; 6 bytes
	jmp		customzonefix
	nop
org 1019EF50h - shift
CZoneEffector@@Stop:

; экспорт состояния включенности для источника света фонаря актора
org 101DE0A2h - shift	; 9 bytes
	jmp		actor_torch_light
	db		4 dup (0CCh)

; фикс сброса положения скролла при перекладывании вещей
org 103CBEE0h - shift
CUICarBodyWnd@@UpdateLists:
org 1041B920h - shift
CUIScrollBar@@UpdateScrollBar:
org 103CC129h - shift	; 10 bytes
	jmp		CUICarBodyWnd@@Update_fix
	call	CUICarBodyWnd@@carbody_scroll_fix
return_CUICarBodyWnd@@Update_fix:

; отладка анимок
; org 10076229h - shift	; 5 bytes
	; jmp		anims_name_fix_1
; org 1007622Eh - shift
; back_from_anims_name_fix_1:
; org 100762BBh - shift	; 5 bytes
	; jmp		anims_name_fix_2
; org 100762C0h - shift
; back_from_anims_name_fix_2:
; org 100762CCh - shift	; 5 bytes
	; jmp		anims_name_fix_3
; org 100762D1h - shift
; back_from_anims_name_fix_3:
; org 100FA47Bh - shift	; 5 bytes
	; jmp		anims_name_fix_4
; org 100FA481h - shift
; back_from_anims_name_fix_4:

;фикс вылета по отсутствию анимации критического хита
org 100FF273h - shift	; 4 bytes
	pop		esi
	pop		edi
	retn
	nop

; отключение автосейва
org 101BE8C0h - shift	; 3 bytes
	retn	4

;-------------------------------------------------------
; Исправление растянутых иконок подбираемых предметов на 16:9
;-------------------------------------------------------
org 103D24D9h - shift	; 5 bytes
	jmp		CUIMainIngameWnd__UpdatePickUpItem_EXT_CHUNK
return_CUIMainIngameWnd__UpdatePickUpItem_EXT_CHUNK:

;------------------------------------------------------------
; Исправление растянутых иконок патронов в ui актора на 16:9
;------------------------------------------------------------
org 103D0D70h - shift	; 6 bytes
	jmp		CUIMainIngameWnd__SetAmmoIcon_EXT_CHUNK
	nop

;------------------------------------------------------------
; Исправление формулы рассчёта статистики убийств в КПК
;------------------------------------------------------------
;Ошибка была в том, что два раза перемножали int_points и int_count.
;Один раз в void CActorStatisticMgr::AddPoints(const shared_str& key, const shared_str& detail_key, s32 cnt, s32 pts)
;и это правильно! Второй раз в s32 SStatSectionData::GetTotalPoints() const, а это уже лишние!
;inline SStatSectionData::GetTotalPoints() в CActorStatisticMgr::GetSectionPoints()
org 102035DDh - shift	; 12 bytes
	;res	+= (*it).int_count*(*it).int_points;		//оригинал
	;res	+= (*it).params[g_select_total_statistic];	//заменил
	ASSUME	eax:ptr SStatDetailBData
;;;	mov		ecx, [eax].int_points		; 3 bytes	//удаляем
;;;	imul	ecx, [eax].int_count		; 4 bytes	//удаляем
	mov		ecx, [esp+24]				; = g_select_total_statistic	0 - int_count, 1 - int_points
	add		esi, [eax+ecx*4].params
	add		eax, sizeof SStatDetailBData
	nop
	ASSUME	eax:nothing
;SStatSectionData::GetTotalPoints()
org 1020342Dh - shift	; 12 bytes
	ASSUME	ecx:ptr SStatDetailBData
;;;	mov		edx, [ecx].int_points		; 3 bytes	//удаляем
;;;	imul	edx, [ecx].int_count		; 4 bytes	//удаляем
	mov		edx, [esp+32]				; = g_select_total_statistic	0 - int_count, 1 - int_points
	add		eax, [ecx+edx*4].params
	add		ecx, sizeof SStatDetailBData
	nop
	ASSUME	ecx:nothing
; Перехват CActorStatisticMgr::GetSectionPoints() и загрузка параметра g_select_total_statistic в стек
org 10203560h - shift
CActorStatisticMgr__GetSectionPoints proc C total_statistic:dword
CActorStatisticMgr__GetSectionPoints endp
;get_actor_points
org 101AEA22h - shift	; 5 bytes
	call	CActorStatisticMgr__GetSectionPointsSelect
;CUIActorInfoWnd::FillPointsInfo(void)
org 103D590Eh - shift	; 5 bytes
	call	CActorStatisticMgr__GetSectionPointsSelect
;------------------------------------------------------------

; фикс вылета there is no proper graph point neighbour
org 100563A5h - shift	; 1 byte
db	0EBh			; this is jmp rel8 opcode
org 10056920h - shift	; 5 bytes
	jmp		game_graph__distance_fix
return_game_graph__distance_fix:
org 100569C9h - shift
loc_100569C9: 


; отключение движкового удаления патронов из неписей после смерти
org 100FA371h - shift	; 6 bytes
	jmp		loc_100FA453
	nop
org 100FA453h - shift
loc_100FA453:

;------------- ; -==НаноБот==-
org 10560718h - shift
materials dd ?

; фикс аттача нескольких вещей
org 10207DF1h - shift	; 2 bytes
	jmp		loc_10207E1F
org 10207E1Fh - shift
loc_10207E1F:
; фикс визуала актора
org 1024C2D2h - shift	; 6 bytes
	jmp		actor_visual_fix
	nop
return_actor_visual_fix:
org 1024C35Fh - shift
loc_1024C35F:
org 102049E1h - shift	; 7 bytes
	jmp		actor_visual_drop_fix
	nop2
return_actor_visual_drop_fix:

; фикс квиксейва
;org 101A7090h - shift	; 7 bytes
;	jmp		quicksave_fix
org 101A7081h - shift	; 2 bytes
	jmp		loc_101A70AF
org 101A70AFh - shift
loc_101A70AF:

; фикс очистки базы отношений
org 1005C7F8h - shift	; 9 bytes
	jmp		alife__release_callback
	nop4
return_alife__release_callback:
org 10213AFDh - shift	; 9 bytes
	jmp		RELATION_REGISTRY__SetGoodwill_callback
	db		4 dup (0CCh)
org 10213B02h - shift
return_RELATION_REGISTRY__SetGoodwill_callback:
org 102138B0h - shift
RELATION_REGISTRY__relation_registry:
org 10069DB0h - shift
SRelation_map__find:
org 1005E8F0h - shift
SRelation_map__erase:
org 10004430h - shift
CAI_Space__ai:
org 102145A0h - shift
RELATION_DATA_map__find:
org 10214420h - shift
CALifeRegistryWrapper__objects_ptr:

; фикс вылета по анимке критхита для анимслотов > 3
org 100FF284h - shift	; 6 bytes
	jmp		global_critical_hit_anim_fix
	nop
return_global_critical_hit_anim_fix:

; explosive->SetInitiator(explosive->Initiator());	// устанавливаем инициатор только если он неизвестен.
org 10250F40h - shift
CExplosive__Initiator:
Virtual_CExplosive__Initiator		= dword ptr 4	; виртуальный адрес
; ebx - explosive	CExplosive*
org 10141716h - shift	; 10 bytes
	mov		edx, [ebx]	; virtual_CExplosive
	mov		ecx, ebx
	call	[edx+Virtual_CExplosive__Initiator]		; explosive->Initiator()
	movzx	eax, ax
;фикс ошибки при взрыве ракеты методом explode(0)
org 10141738h - shift	; 5 bytes
	jmp		CScriptGameObject@@explode_fix
return_CScriptGameObject@@explode_fix:

; масштабирование scope_zoom_factor в зависимости от текущего fov
org 1021CA90h - shift	; 5 bytes
	jmp		CWeapon@@CurrentZoomFactor_fix
org 1022B3F0h - shift	; 5 bytes
	jmp		CWeaponMagazinedWGrenade@@CurrentZoomFactor_fix
org 10234380h - shift	; 5 bytes
	jmp		CWeaponBinoculars@@ZoomInc_fix
org 102343F0h - shift	; 5 bytes
	jmp		CWeaponBinoculars@@ZoomDec_fix
	
org 10459FB8h - shift
float_0p3			dd ?
org 10459FACh - shift
float_0p7			dd ?
org 104D2410h - shift
float_0p33333334	dd ?

; исправление вылета при активации артефактов, не использующих ai_location
org 102413C0h - shift	; 11 bytes
	jmp		art_activation_fix
	nop6
return_art_activation_fix:
org 1011E010h - shift
CLevelGraph__vertex__Fvector3:
;===========================================================================================
;=================================<<< NanoBot >>>===========================================
;===========================================================================================
org 1004BFD0h - shift
CALifeSimulator__spawn_item2:

org 1005BDA0h - shift
alife_spawn_item:

org 10147870h - shift
CScriptGameObject__DropItemAndTeleport:
CScriptGameObject@@DropItemAndTeleport MACRO this_:req, pItem:req, position:req
	pushvar	position.z
	pushvar	position.y
	pushvar	position.x
	pushvar	pItem
	regvar	ecx, this_
	call	CScriptGameObject__DropItemAndTeleport
	EXITM <>
ENDM

org 10147750h - shift
CScriptGameObject__DropItem:

org 1022A2E0h - shift
CWeaponMagazinedWGrenade@@PerformSwitchGL proc
CWeaponMagazinedWGrenade@@PerformSwitchGL endp

org 10458DD8h - shift
pSettings dd ?

org 104509AEh - shift
__RTCastToVoid dd ?

org 10451A40h - shift
__alloca_probe dd ?

org 1004FD6Dh - shift
sub_1004FD6D dd ?

org 10458B0Ch - shift
section_exist dd ?

org 10458E00h - shift
line_exist dd ?

org 10458DF8h - shift
r_string dd ?

org 10458CDCh - shift
r_fvector3 dd ?

org 10458DCCh - shift
r_float dd ?

org 10458D94h - shift
r_u8 dd ?

org 10458DC0h - shift
r_u32 dd ?

org 10458DB4h - shift
r_s32 dd ?

org 10458D7Ch - shift
r_string_wb		 dd ?		; public: class shared_str __thiscall CInifile::r_string_wb

org 10167890h - shift
CScriptIniFile__r_string_wb:

org 10458CE0h - shift
r_bool			dd ?		; public: int __thiscall CInifile::r_bool(char const *, char const *)
org 10458AF4h - shift
r_section		dd ?

org 10458B08h - shift
_ds@_GetItemCount	dd ?
_GetItemCount MACRO src:req, separator:=<','>
	pushvar	separator
	pushvar	src
	call	ds:_ds@_GetItemCount
	add		esp, 8
	EXITM <eax>
ENDM
org 10458DF4h - shift
_ds@_GetItem		dd ?
_GetItem MACRO src:req, index:req, dst:req, separator:=<','>, def:=<offset null_string>, trim:=<true>
	pushvar	trim
	pushvar	def
	pushvar	separator
	pushvar	dst
	pushvar	index
	pushvar	src
	call	ds:_ds@_GetItem
	add		esp, 24
	EXITM <>
ENDM
org 104C885Ah - shift
null_string		dd ?
org 1048D804h - shift
aGrenade_bone	db ?	; "grenade_bone"
;------------------------------------------
org 105421E0h - shift
_AVCCustomMonster:
org 105421C8h - shift
_AVCEntity:
org 1053951Ch - shift
_AVCEntityAlive:
org 10536048h - shift
_AVCObject:
org 1053A6A0h - shift
_AVCGameObject:
org 10556BC8h - shift
_AVCWeapon:
org 1054D664h - shift
_AVCAI_Stalker:
org 10538CDCh - shift
_AVCInventoryItem:
org 105557BCh - shift
_AVCWeaponMagazined:
org 1054E910h - shift
_AVCShootingObject:
org 1054F080h - shift
_AVCCar:
org 1054F02Ch - shift
_AVCHelicopter:
org 105461B4h - shift
_AVCActor:
org 10556FDCh - shift
_AVCWeaponMounted:
org 10557024h - shift
_AVCWeaponStatMgun:
org 1054F470h - shift
_AVCHolderCustom:
org 1053A66Ch - shift
_AVCExplosive:
org 1054F0B0h - shift
_AVCInventoryBox:
org 1054F064h - shift
_AVCScriptZone:
org 1054F5E8h - shift
_AVCProjector:
org 1054D518h - shift
_AVCAI_CTrader:
org 10538CFCh - shift
_AVCTorch:
org 1054F048h - shift
_AVCHangingLamp:
org 10556C20h - shift
_AVCWeaponPistol:
org 10556D50h - shift
_AVCWeaponKnife:
org 10556EC4h - shift
_AVCWeaponBinoculars:
org 10556EF4h - shift
_AVCWeaponShotgun:
org 10556F4Ch - shift
_AVCWeaponBM16:
org 10556CC8h - shift
_AVCWeaponMagazinedWGrenade:
org 10557248h - shift
_AVCMedkit:
org 10557214h - shift
_AVCAntirad:
org 1054F094h - shift
_AVCCustomOutfit:
org 10556C58h - shift
_AVCScope:
org 10556C70h - shift
_AVCSilencer:
org 10556C88h - shift
_AVCGrenadeLauncher:
org 1055578Ch - shift
_AVCFoodItem:
org 105557A4h - shift
_AVCGrenade:
org 1055722Ch - shift
_AVCBottleItem:
org 10556404h - shift
_AVCEatableItem:
org 1053A688h - shift
_AVCMissile:
org 105557DCh - shift
_AVCHudItem:
org 10556BE0h - shift
_AVCWeaponAmmo:
org 10557448h - shift
_AVCMincer:
org 10557460h - shift
_AVCMosquitoBald:
org 1055747Ch - shift
_AVCSmartZone:
org 10557498h - shift
_AVCTeamBaseZone:
org 1054E930h - shift
_AVCCustomZone:
org 1054F0E8h - shift
_AVCUIGameSP:
org 1054F0CCh - shift
_AVCUIGameCustom:
org 10544A20h - shift
_AVCAI_Crow:
org 10542460h - shift
_AVCBaseMonster:
org 10543150h - shift
_AVCAI_Bloodsucker:
org 10543F5Ch - shift
_AVCAI_Boar:
org 10544A68h - shift
_AVCAI_Flesh:
org 10545554h - shift
_AVCAI_PseudoDog:
org 105461F8h - shift
_AVCBurer:
org 10546CA4h - shift
_AVCChimera:
org 105477CCh - shift
_AVCPseudoGigant:
org 105483B8h - shift
_AVCPoltergeist:
org 10548F8Ch - shift
_AVCZombie:
org 105498A4h - shift
_AVCFracture:
org 1054A22Ch - shift
_AVCSnork:
org 1054AC28h - shift
_AVCController:
org 1054B55Ch - shift
_AVCCat:
org 1054BF14h - shift
_AVCTushkano:
org 1054CA34h - shift
_AVCAI_Dog:
org 1053835Ch - shift
_AVCInventoryOwner:
org 1055DE9Ch - shift
_AVCUICellItem:
org 1054FA5Ch - shift
_AVCUIStatic:
org 10556CA8h - shift
_AVCRocketLauncher:
org 10556DF0h - shift
_AVCWeaponRPG7:
org 10556F30h - shift
_AVCWeaponRG6:
org 10556BFCh - shift
_AVCWeaponCustomPistol:
;-----??????-----
org 105507CCh - shift
_AVIRender_Visual:
org 105507ECh - shift
_AVCKinematicsAnimated:
org 1053F1E0h - shift
_AVCSE_Abstract:
org 1055B44Ch - shift
_AVCSE_ALifeItemWeaponShotGun:
org 10555A1Ch - shift
_AVCCustomRocket:
org 10556CF0h - shift
_AVCExplosiveRocket:
org 105421A4h - shift
_AVCPhysicsShellHolder:
;------------------------------------------
org 10458110h - shift
_itoa				dd ?
org 104581D8h - shift
atoi				dd ?
org 104581D0h - shift
atof				dd ?
org 101576C0h - shift
register__void__go_bool:
org 10482240h - shift
aBullet_manager		dd ?
org 10482278h - shift
aGravity_const		dd ?
org 10458C1Ch - shift
CInifile__r_fvector2	dd ?
org 1014D520h - shift
register__u32__void:
org 10391B10h - shift
CCharacterPhysicsSupport@@in_ChangeVisual:
org 10001170h - shift
CDamageManager@@reload:
org 10094920h - shift
CControlAnimation@@restart:
org 101007C0h - shift
CStalkerAnimationManager@@reload:
org 10463AA8h - shift
aDamage:			;db 'damage',0
org 10459250h - shift
aDefault:			;db 'default',0
org 10458730h - shift
CKinematicsAnimated@@LL_GetMotionDef	dd ?
org 10458858h - shift
CKinematicsAnimated@@LL_PartID			dd ?
org 10458AE4h - shift
_ds@CKinematicsAnimated@@LL_PlayCycle	dd ?	; метка для дального вызова через регистр ds, использовать макрос invoke2
;CBlend* CKinematicsAnimated::LL_PlayCycle(u16 part, MotionID motion_ID, BOOL bMixIn, PlayCallback Callback, LPVOID CallbackParam, u8 channel /*=0*/)
CKinematicsAnimated@@LL_PlayCycle proc part:dword, motion_ID:dword, bMixIn:dword, Callback:dword, CallbackParam:dword, channel:dword
CKinematicsAnimated@@LL_PlayCycle endp
org 104586D0h - shift
_ds@CKinematicsAnimated@@PlayCycle		dd ?
CKinematicsAnimated@@PlayCycle proc motion_ID:dword, bMixIn:dword, Callback:dword, CallbackParam:dword, channel:dword
CKinematicsAnimated@@PlayCycle endp
;org 10458AE0h - shift
;CKinematicsAnimated@@ID_Cycle			dd ?
;CKinematicsAnimated@@ID_Cycle
;CKinematicsAnimated@@ID_Cycle
org 100FF200h - shift
CStalkerAnimationManager@@global_play_callback:
org 100FF430h - shift
CStalkerAnimationManager@@head_play_callback:
org 101014F0h - shift
CStalkerAnimationManager@@torso_play_callback:
org 100FF500h - shift
CStalkerAnimationManager@@legs_play_callback:
org 101010D0h - shift
CStalkerAnimationManager@@script_play_callback:
org 104584F4h - shift
psDeviceFlags							dd ?	; _flags<unsigned int>
;======================================================
;;externdef stdcall FormatFlags			  :proto stdcall :dword, :dword, :dword

; при переходе в онлайн кондишен объекта не устанавливается в 1		CGameObject::spawn_supplies
org 101E5177h - shift	; 2 bytes
	jmp		loc_101E5184
org 101E5184h - shift
loc_101E5184:
;======================================================
; загружаем свой список анимации для класса CAI_Stalker
;======================================================
org 10101FD0h - shift
WEAPON_ANIMATIONS__Load:
org 10101F8Ah - shift	; 6 bytes
	jmp		load_anim_params
	nop
return_load_anim_params:
; перехватываем загрузку
org 101021AAh - shift	; 5 bytes
	jmp		load_state_names
return_load_state_names:
org 10102057h - shift	; 11 bytes
	jmp		load_weapon_names
	db		6 dup (090h)
return_load_weapon_names:
org 1010238Eh - shift	; 6 bytes
	jmp		load_weapon_action_names
	nop
return_load_weapon_action_names:
org 10104287h - shift	; 11 bytes
	jmp		load_movement_names
	db		6 dup (090h)
return_load_movement_names:
org 101044DEh - shift	; 6 bytes
	jmp		load_movement_action_names
	nop
return_load_movement_action_names:
org 1010437Eh - shift	; 6 bytes
	jmp		load_in_place_names
	nop
return_load_in_place_names:
org 1010227Ch - shift	; 7 bytes
	jmp		load_head_names
	nop
	nop
return_load_head_names:
org 1010417Eh - shift	; 6 bytes
	jmp		load_global_names
	nop
return_load_global_names:
org 101040A8h - shift	; 5 bytes
	jmp		Load_str__torso__
return_Load_str__torso__:
org 101040B2h - shift
return_Load_str__torso__2:
;--------------------
; CAniFVector::Load
; загружаем принудительно анимацию с номером-префиксом менее указаной в min_count_prefix_num
org 100762F0h - shift
vector_motionID__push_back:
org 10103D80h - shift
CStalkerAnimationPair__play:
org 1007620Bh - shift	; 7 bytes
	jmp		Load_anim_num_prefix
	nop
	nop
return_Load_anim_num_prefix:
;org 10076233h - shift
org 100762C5h - shift	; 5 bytes
	jmp		Load_anim_num_prefix2
return_Load_anim_num_prefix2:
; Если анимация инвалидная(=0FFFFh), то её не играем.
org 10100A58h - shift	; 5 bytes
	call	CStalkerAnimationPair__play_impl
org 10100AB7h - shift	; 5 bytes
	call	CStalkerAnimationPair__play_impl
org 10100B47h - shift	; 7 bytes	inline
	jmp		CStalkerAnimationManager__play_global_impl_CHUNK
	nop
	nop
return_CStalkerAnimationManager__play_global_impl_CHUNK:
org 10100BA8h - shift
return_inlineCStalkerAnimationPair__play__play_global_impl:
org 10100C00h - shift	; 5 bytes
	call	CStalkerAnimationPair__play_impl
org 10100CAEh - shift	; 5 bytes
	call	CStalkerAnimationPair__play_impl
org 10100D1Dh - shift	; 5 bytes
	call	CStalkerAnimationPair__play_impl
org 10100E06h - shift	; 7 bytes	inline
	jmp		CStalkerAnimationManager__play_legs_CHUNK
	nop
	nop
return_CStalkerAnimationManager__play_legs_CHUNK:
org 10100E6Eh - shift
return_inlineCStalkerAnimationPair__play__play_legs:
;--------------------
org 100762BBh - shift	; 5 bytes
	jmp		debug_print_anim2
return_debug_print_anim2:
org 101043C0h - shift	; 6 bytes
	jmp		debug_print_in_place_names
	nop
return_debug_print_in_place_names:
org 101022C0h - shift	; 6 bytes
	jmp		debug_print_head_names
	nop
return_debug_print_head_names:

;======================================================
;Если в модели торговца нет кости "bip01_head" то колбек на поворот головы на камеру не регистрируем.
org 100F783Dh - shift	; 6 bytes
	jmp		fix_if_not_bip01_head_trader
	nop
return_fix_if_not_bip01_head_trader:
org 100F785Fh - shift
no_set_callback_trader:
; Вывод стартового адреса xrGame.dll в логе
org 10288640h - shift	; 7 bytes
	call	StartAdress_xrGame_log__DllMain
	nop
	nop
;===================================================================================
; я использую внятные имена функций, мне так легче (с) НаноБот
org 10458F78h - shift
luabind__detail__overload_rep_base__set_match_fun	dd ?
org 10458F4Ch - shift
luabind__detail__overload_rep__set_fun				dd ?
org 10458F48h - shift
luabind__detail__class_base__add_method				dd ?
org 10458F54h - shift
luabind__detail__overload_rep___overload_rep		dd ?

org 101598F0h - shift
register__void__float_float:
org 101584F0h - shift
register__const@bool__pvector:	;;register__bool__u32:
org 104589DCh - shift
CHW@HW					dd ?	; class CHW HW
org 10458470h - shift
RCache					dd ?	; class CBackend RCache
org 10458584h - shift
resptrcode_shader@@create	dd ?	; public: void __thiscall resptrcode_shader::create(char const *, char const *, char const *, char const *)
;===================================================================================
;Рефакторинг функции колбеков нажатий клавиш.
org 101A6C90h - shift
CLevel__IR_OnMouseWheel:
org 101A6DB0h - shift
CLevel__IR_OnMouseMove:
org 102C2FF0h - shift
nullsub_4:
org 101A6E50h - shift
CLevel__IR_OnKeyboardPress:
org 101A71F0h - shift
CLevel__IR_OnKeyboardRelease:
org 101A7320h - shift
CLevel__IR_OnKeyboardHold:

;CGameObject::CGameObject()
; m_flCallbackKey.zero();
org 101E4400h - shift	; 10 bytes
	ASSUME	edi:ptr CGameObject
	mov		[edi].m_flCallbackKey, bl
	ASSUME	edi:nothing
	mov		eax, edi
	pop		ebx
	retn
; Переопределим адреса виртуальных методов.
org 104811C0h - shift	; 24 bytes
	dd CLevel__IR_OnMouseWheel_callback
	dd CLevel__IR_OnMouseMove_callback
	dd nullsub_4	; CLevel::IR_OnMouseStop	// здесь можно назначить колбек на стоп движении мыши!
	dd CLevel__IR_OnKeyboardPress_callback
	dd CLevel__IR_OnKeyboardRelease_callback
	dd CLevel__IR_OnKeyboardHold_callback
;====================================================================================================
;колбек на выстрел из любого стреляющего объекта
org 1021EEB0h - shift
random_dir:
org 10218509h - shift	; 5 bytes
	jmp		CShootingObject__FireBulletCallback
return_CShootingObject__FireBulletCallback:
;===================================================================================
;старое
org 10255390h - shift
script_callback_int_int: ; this в регистре eax, два аргумента в стеке
;Каллбек для строки и uint. На всякий пожарный. Не проверено... Проверено, работает! 2-й параметр u16. (с) НаноБот
org 10265740h - shift
script_callback_char_uint:
; возвращает в скрипт float, vector и -1, аргументы помещаются в стек.	(c) NanoBot
; push	vec.z
; push	vec.y
; push	vec.x
; push	float
; push	eax		; callback
org 10283280h - shift
script_callback_flt_vec_const:
; возвращает в скрипт float, vector и int, аргументы помещаются в стек.	(c) NanoBot
; push	12345		; int
; push	vec.z
; push	vec.y
; push	vec.x
; push	float		; float
; push	eax			; callback
org 10283170h - shift
script_callback_flt_vec_int:
; передаёт float, float, int и 16-ти битный uint.
org 1027EC60h - shift
script_callback_flt_flt_int_uint:
; передаёт GO, ?
org 101F0DE0h - shift
sub_101F0DE0:
; GO, float, vector, GO, int
org 101F0CA0h - shift
script_callback_go_flt_vec_go_int:
; передаёт GameObject и int.
org 10079660h - shift
script_callback_go_int:
;передаёт GameObject, int и константу -1.
org 10079750h - shift
script_callback_go_int_const:
; передаёт GameObject, GameObject.
org 101E27B0h - shift
script_callback_go_go:
; передаёт GameObject, string.
org 101CC1F0h - shift
script_callback_go_str:
; передаёт GameObject, string, string и int.
org 101F8510h - shift
script_callback_go_str_str_int:
;===================================================================================
;Прототипы callback'ов. ВСЕ!
org 101CA2F0h - shift
script_callback__GO:
org 101E27B0h - shift
script_callback__GO_constGO:
org 10079860h - shift
script_callback__GO_GO_int_vector_float:
org 10255B90h - shift
script_callback__GO_bool_u32:
org 10014CF0h - shift
script_callback__GO_float_vector_GO_s16:
org 101F0CA0h - shift
script_callback__GO_float_vector_GO_u16:
org 101CC1F0h - shift
script_callback__GO_str:
org 101CC0D0h - shift
script_callback__GO_str_str_int:
org 10026940h - shift
script_callback__GO_u32_u32:
org 101F8510h - shift
script_callback__SGameTask_SGameTaskObjective_ETaskState:
org 1027EC60h - shift
script_callback__float_float_int_u32:
org 10283280h - shift
script_callback__float_vector_m1:
org 10283170h - shift
script_callback__float_vector_int:
org 101F0DE0h - shift
script_callback__GO_GO:
org 10265740h - shift
script_callback__str_u16:
org 10255390h - shift
script_callback__u32_u32:
org 100F6B60h - shift
script_callback__void:
;-----------------------------------------------------------------------------------
;===============!!! НОВАЯ БАЛЛИСТИКА !!!===============
;Перепишем метод CBulletManager::CalcBullet
org 104586B4h - shift
;(collide::rq_results& dest, const collide::ray_defs& rq, collide::rq_callback* cb, LPVOID user_data, collide::test_callback* tb, CObject* ignore_object);
_ds@CObjectSpace@@RayQuery	dd ?
CObjectSpace@@RayQuery proc dest:ptr , rq:ptr , cb:ptr , user_data:ptr , tb:ptr , ignore_object:ptr
CObjectSpace@@RayQuery endp
org 101BA100h - shift
CBulletManager@@test_callback proc
CBulletManager@@test_callback endp
org 101BA5F0h - shift
CBulletManager@@firetrace_callback proc
CBulletManager@@firetrace_callback endp
org 1053C5ACh - shift
m_fMinBulletSpeed		dd ?		; 2.0f

org 101B7C30h - shift	; 928 bytes 
	db		928 dup (0CCh)		; затрём старую функцию
org 101B7C30h - shift	; 928 bytes
include new_ballistic.asm		; а в этом файле её перепишем!
;если тип баллистики не равно 0, то хит засчитывается пропорциональна квадрату скорости пули.
org 104D248Ch - shift
float_m0p00001			dd ?
org 101BB225h - shift	; 70 bytes 
	db		70 dup (090h)		; 
org 101BB225h - shift	; 70 bytes 
	;-----врезка 17 байт-----
	;if (m_type_ballistic!=0) speed_factor *= speed_factor;
	mov		eax, [esp+30h+4]				;this	CBulletManager*
	.if ([eax].CBulletManager.m_type_ballistic!=0)
		mulss	xmm0, xmm0
	.endif
	;-----далее оптимизируем код, и у нас есть ещё 3 байта в запасе. :)
	mulss	xmm1, xmm0
	movss	[esp+30h-20h], xmm1				;var_20
	movss	xmm1, dword ptr [ebp+28h]
	mulss	xmm2, xmm1
	subss	xmm1, ds:float_1p0
	mulss	xmm2, xmm0
	movss	[esp+30h-10h], xmm0				;R
	movss	dword ptr [esp+30h-14h], xmm2	;target_material
	comiss	xmm1, ds:float_m0p00001			; if (mtl->fShootFactor >= -0.00001)
	nop3
;загрузим параметры.
org 101B778Ah - shift	; 8 bytes
	jmp		CBulletManager@@Load_ext
	db		3 dup (0CCh)
;тест быстродействия баллистики.
org 101B8570h - shift
CBulletManager@@CommitRenderSet:
org 101A4B63h - shift	; 5 bytes
	call	CBulletManager@@TestBullet
;===================================================================================
;Взрывной объект в пространстве Level. 
; Нужен для снарядов, для быстрого спавна большого количества взрывных объектов.

org 101D2710h - shift
CActor@@net_Relcase:

;выделим больше памяти под CBulletManager
org 101A3678h - shift	; 5 bytes
	push	sizeof CBulletManager		;  200+
;конструктор
org 101B735Bh - shift	; 6 bytes
	jmp		CBulletManager@@CBulletManager_ext
	db		0CCh
;деструктор
org 101B7390h - shift	; 6 bytes
	jmp		CBulletManager@@_CBulletManager_ext
;запускается из CActor::net_Relcase(O);
org 101D27C1h - shift	; 5 bytes
	jmp		CBulletManager@@net_Relcase
;запускается из CBulletManager::CommitEvents();
org 101B8707h - shift	; 10 bytes
	jmp		CBulletManager@@UpdateCExplosive
	db		5 dup (0CCh)
org 1024EF80h - shift
CExplosive@@_CExplosive:
org 104FC638h - shift
dbs_CExplosive:
org 102213A0h - shift
CExplosive@@SetInitiator:
;org 10250F40h - shift
;CExplosive@@Initiator:
org 101C1A10h - shift
CExplosive@@cast_IDamageSource:		; return this;
org 1024EEF0h - shift
CExplosive@@_destructor:
org 1024F090h - shift
CExplosive@@Load:
org 1024F070h - shift
CExplosive@@Load_char_const_:
org 1024F3A0h - shift
CExplosive@@net_Destroy:
org 10250EB0h - shift
CExplosive@@net_Relcase:
org 10250250h - shift
CExplosive@@UpdateCL:
org 1024FBF0h - shift
CExplosive@@Explode:
org 102505E0h - shift
CExplosive@@ExplodeParams:
org 10250530h - shift
CExplosive@@OnEvent:
org 10250400h - shift
CExplosive@@OnAfterExplosion:
org 102504A0h - shift
CExplosive@@OnBeforeExplosion:
org 10221390h - shift
CExplosive@@SetCurrentParentID:
org 1029D1F0h - shift
CExplosive@@UpdateExplosionPos:
org 10250220h - shift
CExplosive@@GetExplVelocity:
org 102501E0h - shift
CExplosive@@GetExplPosition:
org 10250200h - shift
CExplosive@@GetExplDirection:
org 10250630h - shift
CExplosive@@GenExplodeEvent:
org 10250790h - shift
CExplosive@@FindNormal:
org 104509B4h - shift
CExplosive@@cast_game_object:
org 101C1A10h - shift
CExplosive@@cast_explosive:
org 10250930h - shift
CExplosive@@GetRayExplosionSourcePos:
org 10250D50h - shift
CExplosive@@GetExplosionBox:
org 10250D70h - shift
CExplosive@@ActivateExplosionBox:
org 10251040h - shift
CExplosive@@Useful:
org 102504C0h - shift
CExplosive@@HideExplosive:
org 10250880h - shift
CExplosive@@StartLight:
org 10250900h - shift
CExplosive@@StopLight:
org 10250F60h - shift
CExplosive@@UpdateExplosionParticles:
org 1024EE10h - shift
CExplosive@@CExplosive:
;void CExplosive::Load(CInifile *ini,LPCSTR section)	// Инит m_game_object и m_game_object_id
org 1024F38Bh - shift	; 7 bytes
	jmp		CExplosive@@Load_ext
	db		2 dup (0CCh)
;Заменяем cast_game_object() на m_game_object и проверяем на NULL, если это так, то игнорируем вызывающий метод.
; типа так:
; cast_game_object()->processing_activate();				//было так
; if(m_game_object)	m_game_object->processing_activate();	//стало так
;строка 316
org 1024FC09h - shift	; 8 bytes
	ASSUME	ebp:ptr CExplosive
	mov		eax, [ebp].m_game_object
	test	eax, eax
	jz		loc_1024FC19
	nop
org 1024FC19h - shift
loc_1024FC19:
;строка 337
org 1024FC65h - shift	; 14 bytes
	mov		eax, [ebp].m_game_object
	test	eax, eax
	jz		CExplosive@@Explode_vector_vel_zero
	nop3
org 1024FC93h - shift
return@CExplosive@@Explode_vector_vel_zero:
;строка 381
org 1024FF39h - shift	; 7 bytes
	movzx	eax, [ebp].m_game_object_id
;строка 385
org 1024FFBBh - shift	; 10 bytes
;	mov		eax, [ebp].m_game_object
;	nop2
	jmp		CExplosive@@CumulativeJet_fix
return_CExplosive@@CumulativeJet_fix:
	test	eax, eax
	jz		loc_1024FFD9
	nop
org 1024FFD9h - shift
loc_1024FFD9:
;строка 401
org 10250087h - shift	; 10 bytes
	mov		eax, [ebp].m_game_object
	test	eax, eax
	nop
	jz		loc_102500A1
	nop2
	ASSUME	ebp:nothing
org 102500A1h - shift
loc_102500A1:
;строка 467
org 10250266h - shift	; 7 bytes
	ASSUME	edi:ptr CExplosive
	mov		eax, [edi].m_game_object
	test	eax, eax
	jz		loc_10250275
org 10250275h - shift
loc_10250275:
	ASSUME	edi:nothing
;строка 520
org 10250464h - shift	; 9 bytes
	ASSUME	esi:ptr CExplosive
	mov		eax, [esi].m_game_object
	test	eax, eax
	jz		loc_10250490
	nop2
org 10250490h - shift
loc_10250490:
;строка 686
org 10250BA9h - shift	; 16 bytes
	movss	xmm0, xmm0
	nop
	movss	xmm1, xmm1
	mov		ax, [esi].m_game_object_id
	ASSUME	esi:nothing
;Оптимизация класса CExplosive
;переносим булеву m_bAlreadyHidden в другое место структуры, чтобы освободить место для нового свойства!
org 102502E6h - shift	; 7 bytes
	cmp		[edi].CExplosive.m_bAlreadyHidden, 0
org 102504A7h - shift	; 7 bytes
	mov		[ecx].CExplosive.m_bAlreadyHidden, 0
org 10250517h - shift	; 7 bytes
	mov		[edi].CExplosive.m_bAlreadyHidden, 1
;расширения конструктора CExplosive
;;org 1024EEEBh - shift	; 5 bytes
;;	jmp		CExplosive@@CExplosive_ext
;расширения деструктора CExplosive
;;org 1024F060h - shift	; 5 bytes
;;	jmp		CExplosive@@_CExplosive_ext
;===================================================================================
;===================================================================================
; Рефакторинг level_ns_reg_macros.asm
; Указатели на таблицы виртуальных функций.
; Предназначены для скриптовых прототипов функций пространства имён: level и безымяного.
org 1045D598h - shift
virtual_prototype__CEF_Storage__void:
org 10481E80h - shift
virtual_prototype__GO__u32:
org 10481E8Ch - shift
virtual_prototype__void__str_bool:
org 10481E98h - shift
virtual_prototype__CEnvironment__void:
org 10481EA4h - shift
virtual_prototype__void__float:
org 10481EB0h - shift
virtual_prototype__float__void:
org 10481ED4h - shift
virtual_prototype__float__u32_pvector:
org 10481EE0h - shift
virtual_prototype__u32__u32_vector_float:
org 10481EECh - shift
virtual_prototype__vector__u32:
org 10481EF8h - shift
virtual_prototype__CClientSpawnManager__void:
org 10481F04h - shift
virtual_prototype__void__u16_str_str:
org 10481F10h - shift
virtual_prototype__void__u16_str:
org 10481F1Ch - shift
virtual_prototype__u16__u16_str:
org 10481F28h - shift
virtual_prototype__void__CUIDialogWnd_bool:
org 10481F34h - shift
virtual_prototype__void__CUIDialogWnd:
org 10481F40h - shift
virtual_prototype__CUIDialogWnd__void:
org 10481F70h - shift
virtual_prototype__void__luabind@@object:
org 10481F7Ch - shift
virtual_prototype__void__pvector:
org 10481F88h - shift
virtual_prototype__Fbox__void:
org 10481F94h - shift
virtual_prototype__void__str_u32_CScriptCallbackEx:
org 10481FA0h - shift
virtual_prototype__void__str_u32_luabind@@object_CScriptCallbackEx:
org 10481FACh - shift
virtual_prototype__CPHWorld__void:
org 10481FB8h - shift
virtual_prototype__float__str_int_bool_str:
org 10481FC4h - shift
virtual_prototype__void__int:
org 10481FD0h - shift
virtual_prototype__void__str_int_bool:
org 10481FDCh - shift
virtual_prototype__void__int_float_float:
org 10481FE8h - shift
virtual_prototype__void__int_float:
org 10481FF4h - shift
virtual_prototype__void__str_int:
org 10482000h - shift
virtual_prototype__void__str_str_int_int:
org 1048200Ch - shift
virtual_prototype__void__str_str_str:
org 10482018h - shift
virtual_prototype__int__str:
org 10482024h - shift
virtual_prototype__void__u16:
org 10482030h - shift
virtual_prototype__int__void:
org 1048203Ch - shift
virtual_prototype__void__int__str_int:
org 10482048h - shift
virtual_prototype__void__str_int_int:
org 1047F69Ch - shift
virtual_prototype__int__int_int:
org 1047F690h - shift
virtual_prototype__void__void:
org 1047DA70h - shift
virtual_prototype__bool__void:
org 1047F6A8h - shift
virtual_prototype__str__void:
org 1047F6B4h - shift
virtual_prototype__u32__CRenderDevice:
org 1047F6C0h - shift
virtual_prototype__CRenderDevice__void:
org 10460D44h - shift
virtual_prototype__bool__str:
org 1047BF7Ch - shift
virtual_prototype__void__CScriptIniFile_str:
org 1047BF88h - shift
virtual_prototype__void__float_float:
org 1047E6E4h - shift
virtual_prototype__int__int:
org 1047E97Ch - shift
virtual_prototype__CLocatorAPI__void:
org 1047E9ECh - shift
virtual_prototype__CConsole__void:
org 104AF3A4h - shift
virtual_prototype__str__str:
org 104AF3B0h - shift
virtual_prototype__xrTime__void:
org 104C9B54h - shift
virtual_prototype__int__u16_u16_u16_u16:
org 104C9B60h - shift
virtual_prototype__CGameFont__void:
org 104C9B6Ch - shift
virtual_prototype__Frect__void:
org 104C9B78h - shift
virtual_prototype__TEX_INFO__str_str:
org 104CD778h - shift
virtual_prototype__CUIGameCustom__void:
org 10481EBCh - shift
virtual_prototype__void__u32:
org 10481EC8h - shift
virtual_prototype__u32__void:
org 10481F4Ch - shift
virtual_prototype__void__luabind@@functor@bool@_luabind@@functor@void@:
org 10481F58h - shift
virtual_prototype__void__luabind@@object_str_str:
org 10481F64h - shift
virtual_prototype__void__luabind@@object_luabind@@functor@bool@_luabind@@functor@void@:
;===================================================================================
org 1021F3F0h - shift	; ---===NanoBot===---
CCartridge__Load:
CCartridge@@Load MACRO this_:req, sect:req, LocalAmmoType:req
	push	esi
	pushvar	LocalAmmoType
	regvar	eax, sect
	regvar	esi, this_
	call	CCartridge__Load
	pop		esi
	EXITM <>
ENDM
org 1021F360h - shift
CCartridge@@CCartridge proc
CCartridge@@CCartridge endp
org 10458A04h - shift
CObjectList__net_Find		dd ?
;------------Задаём ID стрелка на БТРе------------
org 1027A09Ch - shift	; 13 bytes
	ASSUME	esi:ptr CCarWeapon, eax:ptr CGameObject
	movzx	ebp, [eax].ID ; m_object->ID();net_ID
	mov		ecx, [esi].m_parent_id
	ASSUME	esi:nothing, eax:nothing
;-------------------------------------------------

org 10279EBFh - shift	; 4 bytes
	dd	104D270Ch		; 0.5 град	угол разрешения стрельбы из БТРа

;======================================================================
; колбек на застревание пули, передаётся в объект(биндер) оружия
org 1000B9A0h - shift
CGameMtlLibrary__GetMaterialIt_char_const:
org 101B85D5h - shift
return_CBulletManager@@CommitEvents:
;-------------------------------
org 101B7C30h - shift
CBulletManager__CalcBullet:
;-------------------------------
org 101B8820h - shift
CBulletManager@@RegisterEvent:
org 101B7B9Ch - shift	; 6 bytes
	jmp		CBulletManager@@UpdateWorkload
	nop
return@CBulletManager@@UpdateWorkload:
;подключаемся в CBulletManager@@RegisterEvent
org 101B8887h - shift	; 7 bytes
	jmp		CBulletManager@@RegisterEventCallback
	nop
	nop
return@CBulletManager@@RegisterEventCallback:
; ;попали по динамическому объекту
; org 101B86C2h - shift	; 5 bytes
	; jmp		CBulletManager__DynamicObjectHitCallback
; ;попали по геометрии
; org 101B86FDh - shift	; 5 bytes
	; jmp		CBulletManager__StaticObjectHitCallback
;загрузка параметров
org 1021F624h - shift	; 5 bytes	1021F61Ah
	jmp		CCartridge__Load_callback
return_CCartridge__Load_callback:
;колбек на создании пули, передаётся в объект(биндер) оружия
org 101B72A9h - shift	; 33 bytes
	add		dx, dx					; 3
	and		ecx, 0FFDDh				; 6
	or		dx, cx					; 3
	mov		[esi+4], dx				; 4
	mov		word ptr [esi+60h], 0	; 6
	jmp		SBullet__Init_callback	; 5
	db		6 dup (0CCh)
;====================================================================================================
; Турель на основе класса CCar
org 1026BA90h - shift
CCar__Use:
org 101D95B0h - shift
SVehicleAnimCollection__Create:
org 1023D870h - shift
CWeaponStatMgun__cam_Update:
org 1026F820h - shift
CCar__cam_Update:
org 10278AB0h - shift
CCarWeapon__CCarWeapon:
org 10497404h - shift
aMounted_weapon:
org 1049744Ch - shift
aCamera_bone:
org 104A36E8h - shift
aCar_definition:
org 104972A0h - shift
aFire_bone:			; "fire_bone"
org 10279270h - shift
CCarWeapon__UpdateBarrelDir:

; в этом методе выберим нужный метод в зависимости от CLS_ID
org 104A3E50h - shift	; 4 bytes
	dd CCar__UseSelect
;Дополнительная анимация актора в CCar
;выделим больше памяти для m_vehicles_type_collections
org 101C4665h - shift	; 2 bytes
	push	24+16
;переопределим на наш метод
org 101D2A64h - shift	; 5 bytes
	call	SVehicleAnimCollection__Create_turrel
org 101D2A6Fh - shift	; 4 bytes
	cmp		si, 3
;переопределим метод CCar::cam_Update
org 104A3E4Ch - shift	; 4 bytes
	dd CCar__cam_UpdateSelect
;определим параметр m_camera_bone, кость камеры
;конструктор
org 10278B37h - shift	; 6 bytes
	jmp		CCarWeapon__CCarWeapon_chunk
	nop
return_CCarWeapon__CCarWeapon_chunk:
org 10216F00h - shift
CShootingObject___CShootingObject:
;деструктор
org 10279069h - shift	; 5 bytes
	call	CCarWeapon___CCarWeapon_chunk
;----------------------------------------------------------------------------------------------------
;Водила приаттачен к указаной кости, если эта кость башни, то актор или НПС будет вращатся с башней.
;добавим места для новых параметров
org 1027661Ah - shift	; 5 bytes
	push	sizeof CCar		;1592+20
org 10295EF6h - shift	; 5 bytes
	push	sizeof CCar		;1592+20
org 10269ABDh - shift
	db		26 dup (0)
org 10269ABDh - shift	; 26 bytes
;edi - CHolderCustom	-24Ch = CCar 
	lea		ecx, [edi-24Ch]
	ASSUME	ecx:ptr CCar
	mov		[ecx].m_bone_driver_place, ax
	mov		[ecx].m_car_panel_visible, true
	ASSUME	ecx:nothing
	jmp		CCar__attach_Actor_qqq
org 10269AD7h - shift
CCar__attach_Actor_qqq:
;//if(m_pPhysicsShell->isEnabled())
;//{
;//Owner()->XFORM().mul_43	(XFORM(),m_sits_transforms[0]);	// бывший код
;//}
org 10269120h - shift	;10269135h
	db		578 dup (90h)	;557
org 10269120h - shift	; 578 bytes
;edi - CCar
;esi - this->XFORM()	Fmatrix4
	ASSUME	edi:ptr CCar
	;CKinematics* K	= smart_cast<CKinematics*>(Visual());
	mov		ecx, [edi].Visual_	;6
	mov		eax, [ecx]			;2
	mov		edx, [eax+18h]		;3
	call	edx					;2
	mov		edx, eax	; K		;2
	;CBoneInstance& instance = K->LL_GetTransform(m_bone_driver_place);
	movzx	eax, [edi].m_bone_driver_place	;7
	lea		eax, [eax+eax*4]	;3
	shl		eax, 5	; eax=*160	// sizeof CBoneInstance = 160
	add		eax, [edx+bone_instances]	; CBoneInstance
	;Owner()->XFORM().mul_43(XFORM(), instance.mTransform);
	mov		ecx, [edi].m_owner
	add		ecx, CCar.XFORM_	;m_owner->XFORM()
	ASSUME	ecx:ptr Fmatrix4, esi:ptr Fmatrix4, eax:ptr CBoneInstance, edx:ptr Fvector
	Fmatrix4@mul_43			[ecx], [esi], [eax].mTransform
	;Owner()->XFORM().transform_tiny(XFORM().c, m_offset_driver_place);
	lea		edx, [edi].m_offset_driver_place
	Fmatrix4@transform_tiny	[ecx], [ecx].c_, [edx]
	ASSUME	ecx:nothing, eax:nothing, esi:nothing, edx:nothing
	;фикс перекрутки камеры актора в CCar. Теперь башню танка можно крутить сколько угодно, если limit_x_rot = -181, 181.
	;active_camera.yaw = angle_normalize_signed(active_camera.yaw);
	mov		esi, [edi].active_camera
	ASSUME	esi:ptr CCameraBase
	movss	xmm0, [esi].yaw
	angle_normalize_signed__xmm0
	movss	[esi].yaw, xmm0
	movzx	esi, [edi].m_car_panel_visible
	ASSUME	esi:nothing, edi:nothing
	jmp		CCar__VisualUpdate_ENDIF
org 1026936Fh - shift	;10269362h	
CCar__VisualUpdate_ENDIF:
;перекрестия прицела турели
org 101C7EFAh - shift	; 6 bytes
	jmp		CActor__ShowCrosshairTurrel
	nop
return_CActor__ShowCrosshairTurrel:
org 101C7F26h - shift
endif_CActor__ShowCrosshairTurrel:

org 1044C250h - shift
CHUDCrosshair__SetDispersion:
org 104586E0h - shift
psHUD_Flags			dd ?
;выделяем больше места для структуры CCarWeapon
org 10267806h - shift	; 5 bytes
	push	sizeof CCarWeapon
;
org 10278BA8h - shift	; 7 bytes
	db		7 dup (90h)
;стрельба из многоствольной системы типа Шилка ЗСУ-23-4, ЗУ-23-2
org 1027A090h - shift
CCarWeapon__OnShot:
org 102791C2h - shift	; 2 bytes
	jbe		CCarWeapon__UpdateFire_return
org 102791CBh - shift	; 35 bytes
	;while(fTime<=0){
	ASSUME	esi:ptr CCarWeapon
CCarWeapon__UpdateFire_cycle:
	comiss	xmm1, [esi].fTime
	jb		CCarWeapon__UpdateFire_return
		mov		ecx, esi
		call	CCarWeapon__OnShotExt
		movss	xmm0, [esi].fTimeToFire
		addss	xmm0, [esi].fTime
		movss	[esi].fTime, xmm0
		xorps	xmm1, xmm1
	jmp		CCarWeapon__UpdateFire_cycle
CCarWeapon__UpdateFire_return:
	ASSUME	esi:nothing
	pop		esi
	retn
;гильзы у турели, БТРов.
org 10217F70h - shift
CShootingObject@@OnShellDrop proc play_pos:dword, parent_vel:dword
CShootingObject@@OnShellDrop endp
org 10459968h - shift
zero_vel:
org 1027A12Bh - shift	; 6 bytes	
	jmp		CCarWeapon__OnShot_ext
	db		0CCh
;----------------------------------------------------------------------------------------------------
org 104586D4h - shift
CObject__processing_deactivate	dd ?
;колбек на уничтожение машины
org 1026C54Bh - shift	; 8 bytes
	jmp		CCar__CarExplode_ext
	db		3 dup (0CCh)
;колбек на высадку из машины
org 10269A0Bh - shift	; 5 bytes
	jmp		CCar__detach_Actor_ext
;колбек на посадку в машину
org 10269B37h - shift	; 7 bytes
	jmp		CCar__attach_Actor_ext
	nop
	nop
;При вылезании из машины, смотрим туда, куда смотрели.
org 101DF3A6h - shift	; 10 bytes
	jmp		CActor__init_camera_holder
	db		5 dup (90h)
return_CActor__init_camera_holder:
;====================================================================================================
; колбек на использования вещи, вызывается в собственом биндере
org 10482654h - shift
aInventory:
org 104885B0h - shift
aEat_max_power:
org 102061EDh - shift	; 7 bytes
	jmp		CInventory__Eat_callback
	nop
	nop
return_CInventory__Eat_callback:
; про иницилизируем on_eat_this_callback
org 102086F0h - shift
	db		63 dup (0CCh)
org 102086F0h - shift	; 63 bytes
	ASSUME	esi:ptr CEatableItem
	fldz
	fstp	[esi].m_fMaxPowerUpInfluence
	.if (eax)
		push	offset aEat_max_power ; "eat_max_power"
		push	edi
		mov		eax, ds:pSettings
		mov		ecx, dword ptr[eax]
		call	ds:r_float
		fstp	[esi].m_fMaxPowerUpInfluence
	.endif
	ASSUME	esi:nothing
	jmp		CEatableItem__Load_chank
;====================================================================================================
; Возможность назначать лучшие оружие скриптом.
org 101198C0h - shift
CAI_Stalker__update_best_item_info:
;CAI_Stalker::CAI_Stalker()
org 100F8CACh - shift	; 19 bytes
	ASSUME	ebp:ptr CAI_Stalker
	;m_script_best_weapon = nullptr;	// иницилизируем m_script_best_weapon
	mov		[ebp].m_script_best_weapon, ebx			
	;m_sell_info_actuality = m_script_not_check_can_kill = m_not_drop_wpn_death = false;
	mov		dword ptr [ebp].m_sell_info_actuality, ebx	
	ASSUME	ebp:nothing
	mov		eax, ebp
	pop		ebp
	pop		ebx
	retn	4
; CAI_Stalker::update_best_item_info()
org 101198F6h - shift	; 6 bytes
	jmp		CAI_Stalker__update_best_item_info_fix
	nop
return_CAI_Stalker__update_best_item_info_fix:
;============================================================
; Можно ли выронить оружие при смерти сталкера.
org 10113FFAh - shift	; 8 bytes
	mov		ecx, [ebp+54h]	; object(); // CPhysicsShellHolder
	call	CAI_Stalker__NotDropWeaponDeath
;===================================================================================
org 1000C2C0h - shift
CRandom__randI:
org 10458DDCh - shift
Random			dd ?	; class CRandom 
;Спавн артефактов скриптом
org 101E54F0h - shift
CGameObject__u_EventGen:
org 101E5580h - shift
CGameObject__u_EventSend:
;конструктор
org 102562BDh - shift	; 13 bytes
	ASSUME	esi:ptr CCustomZone
	mov		[esi].m_bAllowScriptSpawnArtefact, bl
	ASSUME	esi:nothing
	mov		eax, esi
	pop		ebx
	add		esp, 8
	retn
org 102597DCh - shift	; 6 bytes
	jmp		CCustomZone@@ScriptSpawnArtefact
	nop
return_CCustomZone@@ScriptSpawnArtefact:
org 10259C46h - shift	; 6 bytes
	jmp		CCustomZone@@TeleportArtefact
	nop
return_CCustomZone@@TeleportArtefact:
org 10259D11h - shift	; 6 bytes
	jmp		CCustomZone@@NormalizeDir
	nop
return_CCustomZone@@NormalizeDir:
;===================================================================================
;
org 10279090h - shift
CCarWeapon__Load:

org 10158450h - shift
register_void__str_str:
;----------------------------------------------------------------
; Толщина трассера индивидуальна для каждого патрона.
org 10482230h - shift
aTracer_width		dd ?	; "tracer_width"
org 10482240h - shift
aBullet_manager		dd ?	; "bullet_manager'
org 101B81A6h - shift	; 81 bytes
_width		= dword ptr -38h
var_20		= dword ptr -20h
var_1C		= dword ptr -1Ch
var_10		= dword ptr -10h
var_C		= dword ptr -0Ch
var_8		= dword ptr -08h
	ASSUME	esi:ptr SBullet
	movzx	eax, [esi-12].m_tracer_width
	mov		ebx, ds:Device
	cvtsi2ss xmm1, eax
	mulss_c	xmm1, 0.0039215686, eax	; = *(1/255.0)
	movss	[esp+4Ch+_width], xmm1
	movss	xmm1, dword ptr [esi-12].dir.x
	movss	[esp+4Ch+var_20], xmm1
	mulss	xmm1, xmm0
	movss	[esp+4Ch+var_10], xmm1
	movss	xmm1, dword ptr [esi-12].dir.y
	movss	[esp+4Ch+var_1C], xmm1
	mulss	xmm1, xmm0
	movss	[esp+4Ch+var_C], xmm1
	nop3
	movss	xmm1, dword ptr [esi-12].dir.z
	ASSUME	esi:nothing
;оператор =, копирования в CCartridge
org 1021E71Bh - shift	; 7 bytes
	ASSUME	ecx:ptr CCartridge, eax:ptr CCartridge
	mov		edx, dword ptr [ecx].m_flags
	nop
	mov		dword ptr [eax].m_flags, edx
	ASSUME	ecx:nothing, eax:nothing
;оператор =, копирования в SBullet
org 101B87A9h - shift	; 6 bytes
	ASSUME	ebx:ptr SBullet, edi:ptr SBullet
	mov		edx, dword ptr [ebx].m_u8ColorID
	mov		dword ptr [edi].m_u8ColorID, edx
org 101B8806h - shift	; 9 bytes
	mov		ecx, dword ptr [ebx].targetID
	nop2
	mov		dword ptr [edi].targetID, ecx
	pop		esi
	ASSUME	ebx:nothing, edi:nothing
org 101B9964h - shift	; 6 bytes
	ASSUME	ecx:ptr SBullet, eax:ptr SBullet
	mov		edx, dword ptr [ecx].m_u8ColorID
	mov		dword ptr [eax].m_u8ColorID, edx
org 101B9992h - shift	; 8 bytes
	mov		edx, dword ptr [ecx].targetID
	nop2
	mov		dword ptr [eax].targetID, edx
	ASSUME	ecx:nothing, eax:nothing
;----------------------------------------------------------------
org 1014C0F0h - shift
register_go_const_vector__void:
org 1014C010h - shift
register_go_vector__void:
;--------------------------------------------------------------------
; Фикс для колбека "хит по вертолёту"
; В оригинале для вредителя: вертолёт, или БТР, хит не вызывается, сейчас будет вызыватся для любого объекта.
;if (pHDS->who){
;	callback(GameObject::eHelicopterOnHit)(pHDS->damage(), pHDS->impulse, pHDS->hit_type, pHDS->who->ID());
;	if(m_flCallbackKey & eCallbackAllHit){
;		CGameObject*	wpn = smart_cast<CGameObject*>(Level().Objects.net_Find(pHDS->weaponID));
;		callback(GameObject::eAllHitObjects)(wpn->lua_game_object(), pHDS->damage(), pHDS->dir, pHDS->who->lua_game_object(), pHDS->boneID);
;	}
;}
org 1027E43Ch - shift	; 131 bytes
;edi - this			CHelicopter*
;esi - pHDS			SHit*
;ecx - pHDS->who	CGameObject*
	ASSUME	esi:ptr SHit, edi:ptr CGameObject
	.if (ecx)
		;callback(GameObject::eHelicopterOnHit)(pHDS->damage(),pHDS->impulse,pHDS->hit_type,pHDS->who->ID());
		movzx	edx, [ecx].CGameObject.ID
		mov		ebp, [esi].power
		CALLBACK__FLOAT_FLOAT_INT_u32	edi, GameObject__eHelicopterOnHit, ebp, [esi].impulse, [esi].hit_type, edx
		.if ([edi].m_flCallbackKey & eCallbackAllHit)
			Level__Objects_net_Find	[esi].weaponID
			mov		eax, eax	;для нужной длины врезки!!!
			call	CGameObject@@lua_game_object
			mov		ebx, eax	; оружие вредителя
			mov		eax, [esi].who
			call	CGameObject@@lua_game_object
			mov		ecx, eax
			CALLBACK__SGO_FLOAT_VECTOR_SGO_u16	edi, eAllHitObjects, ebx, ebp, [esi].dir, ecx, [esi].boneID
		.endif
	.endif
	xor		ecx, ecx
	add		edi, 812
	mov		cl, 18
	rep movsd
	ASSUME	esi:nothing, edi:nothing
;----------------------------------------------------------------
; блокировать использования оружие НПСом
org 1021C170h - shift
CWeapon@@GetAmmoCurrent:
org 10218CA4h - shift	; 10 bytes
	ASSUME	edi:ptr CWeapon
	mov		[edi].m_bNPCBlocked, bl		; m_bNPCBlocked = false;
	mov		eax, edi
	pop		ebx
	retn
	ASSUME	edi:nothing
org 1021D420h - shift	; 48 bytes
	db		48 dup (0CCh)
org 1021D420h - shift	; 48 bytes
	ASSUME	ecx:ptr CWeapon
	push	ecx
	;if(!m_bNPCBlocked && GetAmmoCurrent(true))	return true;
	.if (![ecx].m_bNPCBlocked)
		push	TRUE
		push	ecx
		call	CWeapon@@GetAmmoCurrent
		.if (eax)
			mov		al, true
			pop		ecx
			retn
		.endif
	.endif
	;return false;
	xor		al, al
	pop		ecx
	retn
	ASSUME	ecx:nothing
;----------------------------------------------------------------
; удаляем строчки
;u16 head_bone					= V->LL_BoneID("bip01_head");
;V->LL_GetBoneInstance			(u16(head_bone)).set_callback		(bctPhysics, VehicleHeadCallback,this);
; из-за них актёр выворачивает голову, и смотрит куда не надо, фонарь светит не туда куда смотрит камера.
org 101DF210h - shift	; 2 bytes
	jmp		loc_101DF231
org 101DF231h - shift
loc_101DF231:
;----------------------------------------------------------------
;; задать инициатор для физической оболочки, т.е. кто кинул камень?
;CPHShell::CPHShell()
org 1037F061h - shift	; 12 bytes
	dec		eax
	mov		[edi].CPHShell.m_InitiatorID, ax	;m_InitiatorID = u16(-1);
	mov		eax, edi
	pop		esi
	retn
org 104BE168h - shift	; 4 bytes
	dd	CPHSimpleCharacter@@DamageInitiatorID
org 104BE370h - shift	; 4 bytes
	dd	CPHSimpleCharacter@@DamageInitiatorID
org 104BE5E8h - shift	; 4 bytes
	dd	CPHSimpleCharacter@@DamageInitiatorID
;----------------------------------------------------------------
;Колбек на хит, вызывается для всех объектов, требует включения скриптом.
org 101EC088h - shift	; 18 bytes
	jmp		CPhysicsShellHolder@@Hit_chank
	db		13 dup (0CCh)
;----------------------------------------------------------------
arg_0		= 4
arg_4		= 8
arg_8		= 12
arg_0C		= 16
;Дополнительные скриптовые методы в пространстве vector
org 1013C175h - shift	; 5 bytes
	jmp		vector_script_fix
return_vector_script_fix:
;----------------------
org 1013D835h - shift
registervector__float__void:
org 1013CB85h - shift
registervector__this__void:
org 1013D943h - shift
registervector__float__vector:
org 1013CB2Fh - shift
registervector__this__vector_vector:
org 1013DA65h - shift
registervector__this__float_float:
;----------------------
;оптимизация регистрации скриптовых методов пространства имён vector
org 10479510h - shift
aSethp			dd ?		; "setHP"
;----------------------
;for registervector__this__float_float
org 1013C114h - shift	; 7 bytes
	push	offset aSethp
	nop2
org 1013DB79h - shift	; 5 bytes
	push	[ebp+arg_0C]
	nop2
;----------------------------------------------------------------
;----------------------------------------------------------------
;Фикс пропадания звука дождя при загрузке уровня.
org 101A793Ch - shift	; 15 bytes
	jmp		SoundRain_fix
	db		10 dup (90h)
return_SoundRain_fix:
;------------------------------------------------------------------
;------------------------------------------------------------------
;оптимизация регистрации скриптовых методов в пространстве :
;для того чтобы меньше писать макросов, немного перепишем код,
;чтобы одноразовые функции типа register__*, можно было использовать многократно.
org 101AFE91h - shift
register_level__void__void:
org 10157930h - shift
register__CScriptIniFile__void:
org 1014CC50h - shift
register__bool__string:
org 1014DD20h - shift
register__bool__void:
org 1014DC90h - shift
register__void__bool:
org 1014C880h - shift
register__void__string:
org 1014D690h - shift
register__void__u32:
org 10158CD0h - shift
register__int__go:
org 1014C2B0h - shift
register__u32__void@const:
org 1014BF30h - shift
register__float__void@const:
org 1014BE70h - shift
register__float_rw_property:
org 1014C550h - shift
register__void__float:
org 1014CCE0h - shift
register__string__void:
org 101595E0h - shift
register__bool__pvector_float:
org 10159680h - shift
register__bool__pvector:
org 10158610h - shift
register__uint__vector_pvector:
org 10158880h - shift
register__u32__str_int:
org 101572C0h - shift
register__void__u32_u32:
org 1014DEA0h - shift
register__float__int:
org 10159710h - shift
register__void__vector_float_int:
org 1014E7E0h - shift
register__go__int:
org 10159AD0h - shift
register__bool__go:
org 10157360h - shift
register__void__u32_u32_u32:
org 101583C0h - shift
register__vector__string:
org 1014C910h - shift
register__void__str_bool:
org 10157F70h - shift
register__void__u32_pvector:
org 10158580h - shift
register__bool__u32:
org 1014E4F0h - shift
register__float__pu32:
org 10159990h - shift
register__u32__float_pvector:
;
org 10148B90h - shift
CScriptGameObject@@accessible_nearest:
org 101431C0h - shift
CScriptGameObject@@GetCurrentOutfitProtection:
org 1047CE6Ch - shift
aInside			dd ?		; "inside"
org 1047C938h - shift
aAccessible_nea dd ?		; "accessible_nearest"
org 1047CA2Ch - shift
aGet_task_state dd ?		; "get_task_state"
org 1047C708h - shift
aPlay_sound		dd ?		; "play_sound"
org 1047C3F8h - shift
aGet_current__0 dd ?		; "get_current_outfit_protection"
org 1047CE84h - shift
aSet_const_forc	dd ?		; "set_const_force"
org 1047C6A0h - shift
aItem_in_slot	dd ?		; "item_in_slot"
org 1047CF44h - shift
aMarked_dropped dd ?		; "marked_dropped"
org 1047C89Ch - shift
aBone_position	dd ?		; "bone_position"
org 1047C7D0h - shift
aSpawn_ini		dd ?		; "spawn_ini"
org 1047C0DCh - shift
aPlay_cycle		dd ?		; "play_cycle"
org 1047C884h - shift
aSet_sight		dd ?		; "set_sight"
org 10478A90h - shift
aAccessible		dd ?		; "accessible"
org 1047C56Ch - shift
aLevel_vertex_l	dd ?		; "level_vertex_light"
org 1047CF00h - shift
aLocation_on_pa	dd ?		; "location_on_path"
;for register__bool__pvector_float
org 10156CE3h - shift	; 5 bytes
	push	offset aInside
org 10159653h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__bool__pvector
org 10156D00h - shift	; 6 bytes
	push	edx
	push	offset aInside
org 101596EFh - shift	; 5 bytes
	push	[esp+58h+arg_0]
	nop
;for register__uint__vector_pvector
org 101561A1h - shift	; 14 bytes
	mov		[esp+58h-48h], offset CScriptGameObject@@accessible_nearest
	push	ecx
	push	offset aAccessible_nea
org 10158683h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__u32__str_int
org 101563C2h - shift	; 5 bytes
	push	offset aGet_task_state
org 101588F3h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__void__u32_u32
org 10155A19h - shift	; 5 bytes
	push	offset aPlay_sound
org 10157333h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__float__int
org 1014B661h - shift	; 14 bytes
	mov		[esp+88h-74h], offset CScriptGameObject@@GetCurrentOutfitProtection
	push	edx
	push	offset aGet_current__0
org 1014DF0Fh - shift	; 5 bytes
	push	[esp+58h+arg_0]
	nop
;for register__void__vector_float_int
org 10156D51h - shift	; 5 bytes
	push	offset aSet_const_forc
org 10159783h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__go__int
org 1014BD5Ah - shift	; 6 bytes
	push	edx
	push	offset aItem_in_slot
org 1014E84Fh - shift	; 5 bytes
	push	[esp+58h+arg_0]
	nop
;for register__bool__go
org 10157064h - shift	; 6 bytes
	push	ecx
	push	offset aMarked_dropped
org 10159B3Fh - shift	; 5 bytes
	push	[esp+58h+arg_0]
	nop
;for register__void__u32_u32_u32
org 10155A3Dh - shift	; 5 bytes
	push	offset aPlay_sound
org 101573D3h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__vector__string
org 10155FE1h - shift	; 6 bytes
	push	eax
	push	offset aBone_position
org 1015842Fh - shift	; 5 bytes
	push	[esp+58h+arg_0]
	nop
;for register__CScriptIniFile__void
org 10155C8Ah - shift	; 5 bytes
	push	offset aSpawn_ini
org 101579E6h - shift	; 5 bytes
	push	[esp+58h+arg_8]
	nop
;for register__void__str_bool
org 1014AC72h - shift	; 5 bytes
	push	offset aPlay_cycle
org 1014C983h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__void__u32_pvector
org 10155E88h - shift	; 5 bytes
	push	offset aSet_sight
org 10157FE3h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;for register__bool__u32
org 1015617Ch - shift	; 6 bytes
	push	ecx
	push	offset aAccessible
org 101585EFh - shift	; 5 bytes
	push	[esp+58h+arg_0]
	nop
;for register__float__pu32
org 1014B9E8h - shift	; 6 bytes
	push	edx
	push	offset aLevel_vertex_l
org 1014E55Fh - shift	; 5 bytes
	push	[esp+58h+arg_0]
	nop
;for register__u32__float_pvector
org 10156F95h - shift	; 5 bytes
	push	offset aLocation_on_pa
org 10159A03h - shift	; 5 bytes
	push	[esp+5Ch+arg_4]
	nop
;------------------------------------------------------------------
;------------------------------------------------------------------
org 105602B8h - shift
ph_world		dd ?	;CPHWorld*

;Проверка броска предмета по указаному вектору(transference) со скоротью(throw_vel) и гравитации(gravity_accel).
;Сопротивление воздуха равно нулю!
;Возвращает результат в throw_dir[0]
;char __usercall TransferenceAndThrowVelToThrowDir@<al>(Fvector *transference@<eax>, Fvector *throw_dir@<edi>, float throw_vel, float gravity_accel)
org 10229080h - shift
Func@TransferenceAndThrowVelToThrowDir:	; proc C throw_vel:real4, gravity_accel:real4
TransferenceAndThrowVelToThrowDir MACRO transference:req, throw_vel:req, gravity_accel:req, throw_dir:req
	push	edi
	pushvar	gravity_accel
	pushvar	throw_vel
	regvar	edi, throw_dir
	regvar	eax, transference
	call	Func@TransferenceAndThrowVelToThrowDir
	add		esp, 8
	pop		edi
	EXITM	<al>
ENDM
;------------------------------------------------------------------
;возможность выключать у ракеты способность взрываться от контакта с чем либо.
org 104586C8h - shift
H_Root			dd ?		; public: class CObject * __thiscall CObject::H_Root(void)
;Задаём размер класса CExplosiveRocket
org 10297FF6h - shift	; 5 bytes
	push	size CExplosiveRocket
;CExplosiveRocket::CExplosiveRocket()
org 1022E72Fh - shift	; 5 bytes
	jmp		CExplosiveRocket@@CExplosiveRocket@ext
org 1022C8D0h - shift
CCustomRocket@@_CCustomRocket:
;CExplosiveRocket::~CExplosiveRocket()
org 1022E7FDh - shift	; 5 bytes
	jmp		CExplosiveRocket@@_CExplosiveRocket@ext
;CExplosiveRocket::Load(LPCSTR section)
org 1022E887h - shift	; 5 bytes
	jmp		CExplosiveRocket@@Load@ext
org 1022CD5Ch - shift	; 5 bytes
	jmp		CCustomRocket@@SwitchContact
return_CCustomRocket@@SwitchContact:
;возможность выключать в ракете способность взрываться от самоликвидатора.
org 1022DBA1h - shift	; 2 bytes
	jnz		loc_1022DBD0
;возможность выключать в ракете способность взрываться от контакта
org 1022DBB7h - shift	; 27 bytes
	db		27 dup (0CCh)	;затрём весь кусок!
;CCustomRocket::UpdateCL()
org 1022DBB7h - shift	; 35 bytes
;esi	this	CExplosiveRocket*
;xmm0	Device.fTimeGlobal	float
	ASSUME	esi:ptr CCustomRocket
	jbe		loc_1022DBD0
		jmp		CCustomRocket@@DeleteOrExplode
loc_1022DBD0:
	.if (![esi].m_bOpenParachute && xmm0>[esi].m_fTimeOpenParachute)
		call	CCustomRocket@@OpenParachute
	.endif
	jmp		CExplosiveRocket@@UpdateCL
org 1022D140h - shift
CCustomRocket@@ObjectContactCallback: ;;; do_colide:ptr byte, bo1:byte, cc:ptr , material_1:ptr , material_2:ptr 
org 10224EF0h - shift
CMissile@@ExitContactCallback:
;парашют в ракете.
org 1022CC4Dh - shift	; 9 bytes
	.if (!zero?)
		dec		dword ptr [eax]
	.endif
	jmp		CCustomRocket@@SetLaunchParams_ext
;оптимизация, перемещаем m_bEnginePresent в другое место структуры CCustomRocket
org 1022C790h - shift	; 6 bytes	//CCustomRocket::CCustomRocket
	mov		[esi].m_bEnginePresent, bl
org 1022D765h - shift	; 6 bytes	//CCustomRocket::reload(char *this, char *section)
	mov		[esi-110h].m_bEnginePresent, al
org 1022DBE3h - shift	; 7 bytes	//CCustomRocket::StartEngine()
	cmp		[esi].m_bEnginePresent, 0
	ASSUME	esi:nothing
;CExplosiveRocket::Explode()
org 1048F248h - shift	; 4 bytes
	dd offset CExplosiveRocket@@Explode
;CExplosiveRocket::OnEvent
org 1022EA6Dh - shift	; 5 bytes
	jmp		CExplosiveRocket@@OnEvent@ext
;Задать силу сопротивления воздуха, линейную и угловую.
org 1022CD75h - shift	; 25 bytes
	mov		ecx, esi
	nop7
	call	CCustomRocket@@SetParamsAirResistance
	nop4
	nop7
;------------------------------------------------------------------
;------------------------------------------------------------------
;Переделка гранатомётов CWeaponRG6, CWeaponMagazinedWGrenade, CWeaponRPG7
;Теперь запуск ракеты происходит из метода CWeapon::FireTrace
org 1008DBB0h - shift
OnServer proc (byte)
OnServer endp
org 101A3300h - shift
OnClient proc (byte)
OnClient endp
org 1021F090h - shift
CWeapon@@FireTrace proc P:ptr Fvector, D:ptr Fvector
CWeapon@@FireTrace endp
org 10225FF0h - shift
CWeaponMagazined@@ReloadMagazine proc
CWeaponMagazined@@ReloadMagazine endp
org 10225CE0h - shift
CWeaponMagazined@@UnloadMagazine proc spawn_ammo:byte
CWeaponMagazined@@UnloadMagazine endp
org 102381A0h - shift
CWeaponRG6@@AddCartridge proc cnt:dword
CWeaponRG6@@AddCartridge endp
org 1021ACF0h - shift
CWeapon@@LoadFireParams proc sect:ptr byte, prefix:ptr byte
CWeapon@@LoadFireParams endp
org 1021AF50h - shift
CWeapon@@net_Spawn proc DC:ptr CSE_Abstract
CWeapon@@net_Spawn endp
org 10225A50h - shift
CWeaponMagazined@@FireStart:
org 102200B0h - shift
CWeaponCustomPistol@@switch2_Fire:
org 10226AF0h - shift
CWeaponMagazined@@state_Fire:
org 1021CB40h - shift
CWeapon@@SwitchState:
org 1021B6E0h - shift
CWeapon@@OnH_A_Chield:
org 10225B70h - shift
CWeaponMagazined@@TryReload:
org 10227000h - shift
CWeaponMagazined@@switch2_Fire:
org 10225AF0h - shift
CWeaponMagazined@@FireEnd:
org 10228960h - shift
CWeaponMagazined@@SetQueueSize proc size_:dword
CWeaponMagazined@@SetQueueSize endp
;-------------------
org 1048D824h - shift
aFake_grenade_n		dd ?	; "fake_grenade_name"
org 10492634h - shift
aRocket_class		dd ?	; "rocket_class"
org 1048A5FCh - shift
aRpm				dd ?	; "rpm"
org 1048A630h - shift
aFire_distance		dd ?	; "fire_distance"
org 1048AAD0h - shift
aGrenade_laun_0		dd ?	; "grenade_launcher_name"
org 1048E984h - shift
aForce_explode_		dd ?	; "force_explode_time"
org 1048A8CCh - shift
aCam_max_angle		dd ?	; "cam_max_angle"
org 1048A8DCh - shift
aCam_relax_speed	dd ?	; "cam_relax_speed"
org 1048A900h - shift
aCam_max_angle_		dd ?	; "cam_max_angle_horz"
org 1048A914h - shift
aCam_step_angle		dd ?	; "cam_step_angle_horz"
org 1048A928h - shift
aCam_dispertion		dd ?	; "cam_dispertion_frac"
org 1048A9A0h - shift
aFire_dispers_1		dd ?	; "fire_dispersion_condition_factor"
org 1048A9C4h - shift
aMisfire_probab		dd ?	; "misfire_probability"
org 1048A9D8h - shift
aMisfire_condit		dd ?	; "misfire_condition_k"
org 1048A9ECh - shift
aCondition_shot		dd ?	; "condition_shot_dec"
org 10488BF4h - shift
aInv_weight			dd ?	; "inv_weight"
org 1045CCBCh - shift
aBox_size			dd ?	; "box_size"
org 104D2458h - shift
g_fDeg2rad			dd ?	;=0.017453292 = PI/180.f
const_static_str		aBlock_auto_aim_rg, "block_auto_aim_rg"
org 1022EEF0h - shift
CRocketLauncher@@SpawnRocket proc rocket_section:ptr, parent_rocket_launcher:ptr 
CRocketLauncher@@SpawnRocket endp
org 1022F0E0h - shift
Func@CRocketLauncher@@AttachRocket:	; void (CObject *parent_rocket_launcher@<eax>, unsigned __int16 rocket_id@<cx>, CRocketLauncher *this)
CRocketLauncher@@AttachRocket MACRO parent_rocket_launcher:req, rocket_id:req, this_:req
	pushvar	this_
	regvar	cx, rocket_id
	regvar	eax, parent_rocket_launcher
	call	Func@CRocketLauncher@@AttachRocket
	EXITM <>
ENDM
org 1022F190h - shift
Func@CRocketLauncher@@DetachRocket:	;(unsigned __int16 rocket_id@<cx>, CRocketLauncher *this, bool bLaunch)
CRocketLauncher@@DetachRocket MACRO rocket_id:req, this_:req, bLaunch:req
	pushvar	bLaunch
	pushvar	this_
	regvar	cx, rocket_id
	call	Func@CRocketLauncher@@DetachRocket
	EXITM <>
ENDM
org 1022F2A0h - shift
Func@CRocketLauncher@@LaunchRocket:		;(CRocketLauncher *this@<eax>, Fmatrix *xform, Fvector *vel)
CRocketLauncher@@LaunchRocket MACRO this_:req, xform:req, vel:req
	pushvar	vel
	pushvar	xform
	regvar	eax, this_
	call	Func@CRocketLauncher@@LaunchRocket
	EXITM <>
ENDM
org 1022F350h - shift
Func@CRocketLauncher@@getCurrentRocket:	; CRocketLauncher* CRocketLauncher::getCurrentRocket@<eax>(CRocketLauncher *this@<eax>)
CRocketLauncher@@getCurrentRocket MACRO this_:req
	regvar	eax, this_
	call	Func@CRocketLauncher@@getCurrentRocket
	EXITM <>
ENDM
CRocketLauncher@@dropCurrentRocket MACRO this_:req	;INLINE
	regvar	ecx, this_
	mov		eax, [ecx].CRocketLauncher.m_rockets._Myfirst
	.if (eax && eax!=[ecx].CRocketLauncher.m_rockets._Mylast)
		sub		[ecx].CRocketLauncher.m_rockets._Mylast, 4
	.endif
	EXITM <>
ENDM
;инлайн функция, использовать только в условных блоках .if, .while и т.д.
IsGrenadeLauncherAttached MACRO this_wpn:req
	mov		eax, this_wpn.m_eGrenadeLauncherStatus
	EXITM <((eax==eAddonAttachable && this_wpn.m_flagsAddOnState & eWeaponAddonGrenadeLauncher) || eax==eAddonPermanent)>
ENDM
org 1003E0E0h - shift
Fvector__generate_orthonormal_basis:	;(Fvector *dir@<ebx>, Fvector *up@<edi>, Fvector *right@<esi>)
Fvector@@generate_orthonormal_basis MACRO dir:req, up:req, right:req
	push	esi
	push	edi
	push	ebx
	regvar	esi, dir
	regvar	edi, up
	regvar	ebx, right
	call	Fvector__generate_orthonormal_basis
	pop		ebx
	pop		edi
	pop		esi
	EXITM <>
ENDM
CExplosiveRocket@@RealGravity		PROTO (real4)
;Т.к. метод CWeaponRPG7::switch2_Fire() удалён, на его место помещаем методы StartRocket, DeleteRockets, SpawnRockets
org 10232420h - shift	; 1072 bytes
	db		1072 dup (0CCh)	
org 10232420h - shift	; 1072 bytes
;void	CRocketLauncher::StartRocket(const Fvector& P, const Fvector& D, bool )
CRocketLauncher@@StartRocket proc uses esi edi ebx pos_start:ptr Fvector, dir_start:ptr Fvector, is_aim:byte
local gravity:real4, gravi_min:real4, HasPick:dword, p1:Fvector4, d:Fvector4, launch_matrix:Fmatrix4
local Transference:Fvector4, res[2]:Fvector, RQ:collide__rq_result, P:NET_Packet
	mov		esi, ecx
	ASSUME	esi:ptr CRocketLauncher, edi:ptr CExplosiveRocket, ebx:ptr CObject
	;CExplosiveRocket*	pGrenade = smart_cast<CExplosiveRocket*>(getCurrentRocket());
	CRocketLauncher@@getCurrentRocket(esi)
	smart_cast	CExplosiveRocket, CCustomRocket, eax
	.if (eax)
		mov		edi, eax	;pGrenade
		mov		edx, pos_start
		Fvector_set		p1, [edx].Fvector
		and		p1.w, 0
		mov		edx, dir_start
		Fvector_set		d, [edx].Fvector
		and		d.w, 0
		Fmatrix4@identity (launch_matrix)
		Fvector_set		launch_matrix.k, d
		Fvector@@generate_orthonormal_basis(&launch_matrix.k, &launch_matrix.j, &launch_matrix.i)
		Fvector_set		launch_matrix.c_, p1
		;CGameObject*	obj = smart_cast<CGameObject*>(this);
		smart_cast	CGameObject, CRocketLauncher, esi
		mov		ebx, eax
		;CObject*		parent = obj->H_Parent();
		.if (is_aim)	;//
			CObject@@setEnabled([ebx].Parent, FALSE)
			CObject@@setEnabled(ebx, FALSE)
			;BOOL HasPick = Level().ObjectSpace.RayPick(p1, d, 500.0f, collide::rqtBoth, RQ, obj);
			mov		HasPick, CObjectSpace@@RayPick(&p1, &d, 500.0, 3, &RQ, ebx)
			CObject@@setEnabled(ebx, TRUE)
			CObject@@setEnabled([ebx].Parent, TRUE)
			movflt	gravi_min, 0.001
			;//метод RealGravity возвращает реальную гравитацию с учётом работы двигателя при определёном условии.
			mov		ecx, edi
			movss	gravity, CExplosiveRocket@@RealGravity()	;gravity = pGrenade->RealGravity();
			movss	xmm0, gravi_min
			.if (HasPick && xmm0<gravity)
				;Transference.mul(d, RQ.range);
				movups	xmm0, d
				movss	xmm1, RQ.range
				shufps	xmm1, xmm1, 0
				mulps	xmm0, xmm1
				movups	Transference, xmm0
;				printf("Transference[%.5f, %.5f, %.5f] range=%.3f", ^Transference.x, ^Transference.y, ^Transference.z, ^RQ.range)
				.if (TransferenceAndThrowVelToThrowDir(&Transference, [esi].m_fLaunchSpeed, gravity, &res))
					Fvector_set	d, res[0]
				.endif
			.endif
		.endif
		;d.mul(m_fLaunchSpeed);
		movups	xmm0, d
		movss	xmm1, [esi].m_fLaunchSpeed
		shufps	xmm1, xmm1, 0
		mulps	xmm0, xmm1
		movups	d, xmm0
		CRocketLauncher@@LaunchRocket(esi, &launch_matrix, &d)
		;pGrenade->SetInitiator(parent->ID());
		mov		edx, [ebx].Parent
		mrm		[edi].m_iCurrentParentID, [edx].CObject.ID
		.if (OnServer())
			;u_EventGen(P, GE_LAUNCH_ROCKET, obj->ID());
			CGameObject@@u_EventGen(&P, GE_LAUNCH_ROCKET, [ebx].ID)
			;P.w_u16(pGrenade->ID());
			mov		edx, P.B.count
			mrm		word ptr P.B.data[edx], [edi].ID
			add		P.B.count, 2
			;u_EventSend(P);
			CGameObject@@u_EventSend(&P)
		.endif
		;dropCurrentRocket();
		mov		eax, [esi].m_rockets._Myfirst
		.if (eax && eax!=[esi].m_rockets._Mylast)
			sub		[esi].m_rockets._Mylast, 4
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing, ebx:nothing
	ret
CRocketLauncher@@StartRocket endp

;void			CRocketLauncher::DeleteRockets()
;{
;	xr_vector<CCustomRocket>::const_iterator	I = m_rockets.begin();
;	xr_vector<CCustomRocket>::const_iterator	E = m_rockets.end();
;	for( ; I != E; ++I)
;		CCustomRocket*	rocket = *I;
;		if(rocket->Local())
;			rocket->DestroyObject();
;	}
;	m_rockets.();
;}
align_proc
CRocketLauncher@@DeleteRockets proc uses esi edi ebx
	mov		esi, ecx
	ASSUME	esi:ptr CRocketLauncher
	mov		edi, [esi].m_rockets._Myfirst	;I = m_rockets.begin();
	mov		ebx, [esi].m_rockets._Mylast
	.for (:edi!=ebx: edi+=4)
		mov		ecx, [edi]
		.if ([ecx].CCustomRocket.Props.flags & net_Local)	;rocket->Local()
			;rocket->DestroyObject();
			mov     edx, [ecx]
			mov     eax, [edx+0E8h]
			call	eax
		.endif
	.endfor
	mrm		[esi].m_rockets._Mylast, [esi].m_rockets._Myfirst	;
	ASSUME	esi:nothing
	ret
CRocketLauncher@@DeleteRockets endp

;void			CRocketLauncher::SpawnRockets(xr_vector<CCartridge>& magazine)
;{
;	CGameObject*	obj = smart_cast<CGameObject*>(this);
;	xr_vector<CCartridge>::const_iterator	I = magazine.begin();
;	xr_vector<CCartridge>::const_iterator	E = magazine.end();
;	for( ; I != E; ++I){
;		LPCSTR	sect = (*I).m_ammoSect.c_str();
;		if(pSettings->line_exist(sect, "fake_grenade_name"))
;			sect = pSettings->r_string(sect, "fake_grenade_name");
;		else{
;			CWeaponRPG7* rpg = smart_cast<CWeaponRPG7*>(this);
;			if(!rpg) continue;
;			sect = rpg->m_sRocketSection.c_str();	//оригинальный RPG7
;		}
;		SpawnRocket(sect, obj);
;	}
;}
align_proc
CRocketLauncher@@SpawnRockets proc uses esi edi ebx magazine:ptr xr_vector
local E:dword
;ecx	this CRocketLauncher*
	smart_cast	CGameObject, CRocketLauncher, ecx
	mov		esi, eax
	mov		edx, magazine
	mov		edi, [edx].xr_vector._Myfirst	;I = magazine.begin();
	mrm		E, [edx].xr_vector._Mylast		;E = magazine.end();
	.for (:edi!=E: edi += size CCartridge)
		mov		ebx, [edi].CCartridge.m_ammoSect.p_
		.if (@LINE_EXIST(&[ebx].str_value.value, &aFake_grenade_n))		;"fake_grenade_name"
			mov		edx, @R_STRING(&[ebx].str_value.value, &aFake_grenade_n)
		.else
			smart_cast	CWeaponRPG7, CGameObject, esi
			.continue .if (!eax)
			mov		ecx, [eax].CWeaponRPG7.m_sRocketSection.p_	;оригинальный RPG7
			lea		edx, [ecx].str_value.value
		.endif
		CRocketLauncher@@SpawnRocket(edx, esi)
	.endfor
	ret
CRocketLauncher@@SpawnRockets endp
;=================================================================================

;Переделка класса CWeaponMagazinedWGrenade
;убираем метод void	 CWeaponMagazinedWGrenade::state_Fire(float dt)
CRocketLauncher@@SpawnRockets				PROTO magazine:ptr xr_vector
CRocketLauncher@@DeleteRockets				PROTO
CWeaponMagazinedWGrenade@@UnloadMagazine	PROTO spawn_ammo:byte
CWeaponMagazinedWGrenade@@LoadFireParams	PROTO sect:ptr byte, prefixptr:ptr byte
org 1022A220h - shift
CWeaponMagazinedWGrenade@@SwitchMode proc
CWeaponMagazinedWGrenade@@SwitchMode endp
org 1021DFB0h - shift
CWeapon@@Weight proc
CWeapon@@Weight endp
org 10226F60h - shift
CWeaponMagazined__OnAnimationEnd:
CWeaponMagazined@@OnAnimationEnd MACRO this_:req, state:req
	pushvar	state
	regvar	ecx, this_
	call	CWeaponMagazined__OnAnimationEnd
	EXITM <>
ENDM
;уберём виртуальный метод CWeaponMagazinedWGrenade::state_Fire
org 1048DA34h - shift	; 4 bytes
	dd offset CWeaponMagazined@@state_Fire
org 10490754h - shift	; 4 bytes
	dd offset CWeaponMagazined@@state_Fire
org 104938BCh - shift	; 4 bytes
	dd offset CWeaponMagazined@@state_Fire
;уберём виртуальный метод CWeaponMagazinedWGrenade::SwitchState
org 1048DD4Ch - shift	; 4 bytes
	dd offset CWeapon@@SwitchState		;CWeaponMagazinedWGrenade
org 10490A6Ch - shift	; 4 bytes
	dd offset CWeapon@@SwitchState		;CWeaponGroza
org 10493BD4h - shift	; 4 bytes
	dd offset CWeapon@@SwitchState		;CWeaponAK74
;-----------------------------
;больше места для CWeaponGroza
org 10230E74h - shift	; 5 bytes
	push	sizeof CWeaponMagazinedWGrenade
org 10297256h - shift	; 5 bytes
	push	sizeof CWeaponMagazinedWGrenade
;больше места для CWeaponAK74
org 10233294h - shift	; 5 bytes
	push	sizeof CWeaponMagazinedWGrenade
org 10296996h - shift	; 5 bytes
	push	sizeof CWeaponMagazinedWGrenade
;больше места для CWeaponMagazinedWGrenade
org 10296856h - shift	; 5 bytes
	push	sizeof CWeaponMagazinedWGrenade
;-----------------------------
;расширение конструктора
org 102296EEh - shift	; 5 bytes
	jmp		CWeaponMagazinedWGrenade@@CWeaponMagazinedWGrenade_fix
;CWeaponMagazinedWGrenade::Load
org 10229E74h - shift	; 25 bytes
	jmp		CWeaponMagazinedWGrenade@@Load_fix
	db		20 dup (0CCh)
org 1021E1C0h - shift
CCartridge__push_back:
CCartridge@@push_back MACRO this_:req, val:req
	regvar	eax, val
	regvar	ecx, this_
	call	CCartridge__push_back
	EXITM <>
ENDM
;BOOL CWeaponMagazinedWGrenade::net_Spawn(CSE_Abstract* DC)
org 10229F11h - shift	; 456 bytes
	db		456 dup (0CCh)
org 10229F11h - shift	; 456 bytes
;edi	this	CWeaponMagazinedWGrenade*
;esi	m_DefaultCartridge2	CCartridge*
	ASSUME	edi:ptr CWeaponMagazinedWGrenade
	xor		ebp, ebp	;rockets_empty = m_rockets.empty();//!getRocketCount()	//ракетница пуста?
	mov		eax, [edi].m_rockets._Myfirst
	.if (!eax || eax==[edi].m_rockets._Mylast)
		inc		ebp		;Да
	.endif
	.if ([edx].game_cl_GameState.m_type != 1)	;if(GameID() != GAME_SINGLE)
		.if (![edi].m_bGrenadeMode && IsGrenadeLauncherAttached([edi]) && ebp)
			CCartridge@@push_back(esi, &[edi].m_magazine2)
		.endif
	.endif
	;bool b_if_grenade_mode	= (m_bGrenadeMode && iAmmoElapsed && !getRocketCount());
	;bool b_if_simple_mode	= (!m_bGrenadeMode && !m_magazine2.empty() && !getRocketCount());
	;if(b_if_grenade_mode || b_if_simple_mode)
	mov		eax, [edi].m_magazine2._Myfirst
	.if (ebp && (([edi].m_bGrenadeMode && [edi].iAmmoElapsed) || (![edi].m_bGrenadeMode && eax && eax!=[edi].m_magazine2._Mylast)))
		push	ebx
		mov		bl, [edi].m_bGrenadeMode	;bool	curr_mode = m_bGrenadeMode;
		.if (!bl)							;// если в основном режиме, то перегодим на ПГ.
			mov		eax, edi
			CWeaponMagazinedWGrenade@@PerformSwitchGL()	;SwitchMode()	;
		.endif
		;// заряжаем ПГ ракетами. Ракеты соотвествуют патронам из m_magazine.
		lea		ecx, [edi].CRocketLauncher@vfptr
		CRocketLauncher@@SpawnRockets(&[edi].m_magazine)
		.if (!bl)							;// если текущий режим основной то, переключаем на основной
			mov		eax, edi
			CWeaponMagazinedWGrenade@@PerformSwitchGL()	;SwitchMode()	;
		.endif
		pop		ebx
	.endif
	;перезапустим параметры для подствольного девайса.
	.if ([edi].m_bGrenadeMode && [edi].m_bGrnLauncherShotgun)
		mov		edx, [edi].NameSection.p_	;LPCSTR	sect = cNameSect().c_str();
		mov		edx, @R_STRING(&[edx].str_value.value, &aGrenade_laun_0)	;"grenade_launcher_name"
		mov		ecx, edi
		CWeaponMagazinedWGrenade@@LoadFireParams(edx, &null_string)
	.endif
	mov		eax, [esp+14h-8];l_res
	pop		edi
	pop		esi
	pop		ebp
	add		esp, 8
	retn	4
;void  CWeaponMagazinedWGrenade::PerformSwitchGL()
org 1022A2E6h - shift	; 45 bytes
	sub		esp, 4Ch+4	;добавим места для this
	push	ebx
	push	esi
	push	edi
	mov		edi, eax
	;m_bGrenadeMode		= !m_bGrenadeMode;
	xor		[edi].m_bGrenadeMode, 1
	mov		[ebp-4], edi	;this //хак чтобы сохранить this, т.к. ниже он там затерается!
	nop3
	swap	[edi].iMagazineSize2, [edi].iMagazineSize	;;24 bytes
org 1022A5B9h - shift	; 7 bytes
	jmp		CWeaponMagazinedWGrenade@@PerformSwitchGL_fix
	nop2
;void CWeaponMagazinedWGrenade::UnloadMagazine(bool spawn_ammo)
org 1048DA40h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@UnloadMagazine		;CWeaponMagazinedWGrenade
org 10490760h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@UnloadMagazine		;CWeaponGroza
org 104938C8h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@UnloadMagazine		;CWeaponAK74
;CWeaponMagazinedWGrenade::ReloadMagazine
org 1022AEA9h - shift	; 138 bytes
	db		138 dup (0CCh)
org 1022AEA9h - shift	; 138 bytes
	;// перезарядка подствольного гранатомета  (c) NanoBot
	.if ([edi].m_bGrenadeMode && [edi].m_bCanRocketReload)
		mov		[edi].m_bCanRocketReload, false
		lea		ecx, [edi].CRocketLauncher@vfptr
		CRocketLauncher@@DeleteRockets()
		lea		ecx, [edi].CRocketLauncher@vfptr
		CRocketLauncher@@SpawnRockets(&[edi].m_magazine)
	.endif
	pop		edi
	pop		ecx
	retn
	ASSUME	edi:nothing
;CWeaponMagazinedWGrenade::OnAnimationEnd
org 1022AFBBh - shift	; 24 bytes
	mov		[esi-CWeaponMagazinedWGrenade.CHudItem@vfptr].CWeaponMagazinedWGrenade.m_bCanRocketReload, 1
	jnz		short loc_1022AFC6
		mov		eax, [esi]
		mov		edx, [eax+28h]
		push	0
		call	edx
loc_1022AFC6:
	CWeaponMagazined@@OnAnimationEnd(esi, edi)
	pop		edi
	pop		esi
	retn	4
;Переопределим метод OnH_A_Chield в классе CWeaponMagazinedWGrenade
org 1048DB04h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@OnH_A_Chield
org 10490824h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@OnH_A_Chield
org 1049398Ch - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@OnH_A_Chield
;учёт веса патронов во втором стволе
org 1048D8ECh - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@Weight
org 1049060Ch - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@Weight		;CWeaponGroza
org 10493774h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@Weight		;CWeaponAK74
;фикс бага при отсоединении ПГ
;CWeaponMagazinedWGrenade::Detach
org 1022B2CCh - shift	; 16 bytes
	jnz		return_CWeaponMagazinedWGrenade@@Detach_fix
		jmp		CWeaponMagazinedWGrenade@@Detach_fix
return_CWeaponMagazinedWGrenade@@Detach_fix:
	push	true
	mov		ecx, edi
	call	CWeaponMagazinedWGrenade@@UnloadMagazine
;void CWeaponMagazinedWGrenade::save(NET_Packet &output_packet)
org 1022BBB6h - shift	; 16 bytes
	add		[esi].NET_Packet.B.count, 4
	jmp		CWeaponMagazinedWGrenade@@save_fix
	nop4
org 1022BBE1h - shift	; 16 bytes
	add		[esi].NET_Packet.B.count, 4
	jmp		CWeaponMagazinedWGrenade@@save_fix
	nop4
;void CWeaponMagazinedWGrenade::load(IReader &input_packet)
org 1022BC54h - shift	; 6 bytes
	jmp		CWeaponMagazinedWGrenade@@load_fix
	nop
return_CWeaponMagazinedWGrenade@@load_fix:

;---------------------------------------------------------------------
;---------------------------------------------------------------------
;Переделка класса CWeaponRG6
;переопределим виртуальный метод CWeapon::net_Spawn для CWeaponShotgun
org 10495BB8h - shift	; 4 bytes
	dd offset CWeaponShotgun@@net_Spawn		;было CWeapon::net_Spawn
;переопределим виртуальный метод CWeaponMagazined::ReloadMagazine для CWeaponRG6
org 10496858h - shift	; 4 bytes
	dd offset CWeaponRG6@@ReloadMagazine
;переопределим виртуальный метод CWeaponMagazined::UnloadMagazine(bool spawn_ammo)
org 10496868h - shift	; 4 bytes
	dd offset CWeaponRG6@@UnloadMagazine
;доработка CWeaponRG6::AddCartridge
org 102381C2h - shift	; 11 bytes
	add		eax, 12
	jmp		CWeaponRG6@@AddCartridge_chank
	nop3
return_CWeaponRG6@@AddCartridge_chank:
;доработка CWeaponRG6::net_Spawn
org 10237B2Ch - shift	; 211 bytes
	db		211 dup (0CCh)
org 10237B2Ch - shift	; 211 bytes
;edi	this	CWeapon*
;ebx	l_res	BOOL
	ASSUME	edi:ptr CWeaponMagazined, ecx:ptr CRocketLauncher
	call	CWeaponShotgun@@net_Spawn
	mov		ebx, eax
	;if (iAmmoElapsed>0 && getRocketCount()==0)
	.if (ebx && [edi].iAmmoElapsed>0)
		lea		ecx, [edi-size(CRocketLauncher)]	;CRocketLauncher*
		mov		eax, [ecx].m_rockets._Myfirst
		.if (eax==NULL || [ecx].m_rockets._Mylast==eax)
			;зарядим ракеты которые соотвествуют патронам в m_magazine
			CRocketLauncher@@SpawnRockets(&[edi].m_magazine)
		.endif
	.endif
	push	esi
	push	ebx
	mov		esi, offset aBlock_auto_aim_rg	;"block_auto_aim_rg"
	mov		[edi].m_bBlockAutoAimRG, false
	mov		ebx, [edi].NameSection.p_
	.if (@LINE_EXIST(&[ebx].str_value.value, esi))
		mov		[edi].m_bBlockAutoAimRG, @R_BOOL(&[ebx].str_value.value, esi)
	.endif
	pop		eax	;l_res
	pop		esi
	ASSUME	edi:nothing, ecx:nothing
	pop		edi
	pop		ebx
	add		esp, 8
	retn	4
;уберём виртуальный метод CWeaponRG6::FireStart
org 10496BF4h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireStart	;
;------------------------------------------------------------------
;Перехват метода CWeapon::FireTrace(const Fvector& P, const Fvector& D)
org 10226D7Eh - shift	; 5 bytes
	call	CWeapon@@FireTrace_fix
org 10226D92h - shift	; 5 bytes
	call	CWeapon@@FireTrace_fix
org 10236ADEh - shift	; 5 bytes
	call	CWeapon@@FireTrace_fix
org 10236AEDh - shift	; 5 bytes
	call	CWeapon@@FireTrace_fix
;В классе CRocketLauncher добавляем виртуальный метод FireTraceRocket(Fvector4& P, Fvector4& D)
;Всего есть 5 классов которые содержат CRocketLauncher:
;CWeaponMagazinedWGrenade, CWeaponGroza, CWeaponAK74, CWeaponRPG7, CWeaponRG6
;И некоторые другие, но мы там ничего добавлять не будем.
;Чтобы освободить место, надо передвинуть некоторые данные.
org 1048DE28h - shift	; 7 bytes
aCscope			db "CScope", 0
org 10490B48h - shift	; 6 bytes
aCrgd5			db "CRGD5", 0
org 10493CB0h - shift	; 13 bytes
aCweaponlr300	db "CWeaponLR300", 0
org 10492C10h - shift	; 16 bytes
aCweaponrpg7	db "CWeaponRPG7", 0
aCf1			db "CF1", 0
;поменяем ссылки.
org 1022C114h - shift	; 5 bytes
	push	offset aCscope			; "CScope"
org 10231068h - shift	; 5 bytes
	push	offset aCrgd5			; "CRGD5"
org 10233468h - shift	; 5 bytes
	push	offset aCweaponlr300	; "CWeaponLR300"
org 10232993h - shift	; 5 bytes
	push	offset aCweaponrpg7		; "CWeaponRPG7"
org 10232BD8h - shift	; 5 bytes
	push	offset aCf1				; "CF1"
;дополняем метод в виртуальные таблицы
org 1048DE24h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@FireTraceRocket		;;CWeaponMagazinedWGrenade
org 10490B44h - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@FireTraceRocket		;;CWeaponGroza
org 10493CACh - shift	; 4 bytes
	dd offset CWeaponMagazinedWGrenade@@FireTraceRocket		;;CWeaponAK74
org 10492C0Ch - shift	; 4 bytes
	dd offset CWeaponRPG7@@FireTraceRocket					;;CWeaponRPG7
org 1049667Ch - shift	; 4 bytes
	dd offset CWeaponRG6@@FireTraceRocket					;;CWeaponRG6
;------------------------------------------------------------------
;------------------------------------------------------------------
;Пиротехника
;
org 10458A7Ch - shift
CObject__Center		dd ?	;void __thiscall CObject::Center(Fvector& )const
org 104590C4h - shift
CSound_manager_interface__Sound		dd ?
org 10451A6Ch - shift
_CIacos:
org 1000C1E0h - shift
ref_sound___ref_sound:
ref_sound@@_ref_sound MACRO this_:req
	push	esi
	regvar	esi, this_
	call	ref_sound___ref_sound
	pop		esi
	EXITM <>
ENDM
org 104512A8h - shift
dGeomGetClass proc C geom:dword
dGeomGetClass endp
org 104512AEh - shift
dGeomGetData proc C geom:dword
dGeomGetData endp
org 104512A2h - shift
dGeomTransformGetGeom proc C geom:dword
dGeomTransformGetGeom endp
org 10018440h - shift
Fvector@@setHP:
org 1007E640h - shift
Func@Fvector@@getH:
org 100967A0h - shift
Func@Fvector@@getP:
org 1008AB00h - shift
Func@Fvector@@random_dir:	; Fvector *__usercall Fvector::random_dir@<eax>(Fvector *this@<esi>)
org 10140980h - shift
CScriptGameObject@@bone_position proc res:ptr Fvector, bone_name:ptr byte
CScriptGameObject@@bone_position endp
org 1022EE50h - shift
CRocketLauncher@@CRocketLauncher proc
CRocketLauncher@@CRocketLauncher endp
org 1022EE70h - shift
CRocketLauncher@@_CRocketLauncher proc
CRocketLauncher@@_CRocketLauncher endp
;
org 1022CBA0h - shift
CCustomRocket@@SetLaunchParams proc xform:ptr Fmatrix, vel:ptr Fvector, angular_vel:ptr Fvector
CCustomRocket@@SetLaunchParams endp
;CPyroBattery
org 102087C0h - shift
CEatableItem@@UseBy proc entity_alive:dword
CEatableItem@@UseBy endp
org 101E94E0h - shift
CUsableScriptObject@@use proc who_use:dword
CUsableScriptObject@@use endp
org 1024B290h - shift
CEatableItemObject@@Load proc sect:ptr byte
CEatableItemObject@@Load endp
org 1024B310h - shift
CAntirad@@Load proc sect:ptr byte
CAntirad@@Load endp
org 10209530h - shift
CInventoryItem@@Load proc sect:ptr byte
CInventoryItem@@Load endp
org 1045890Ch - shift
CObject__Load		dd ?
org 1024A940h - shift
CEatableItemObject@@net_Spawn proc DC:ptr CSE_Abstract
CEatableItemObject@@net_Spawn endp
org 1024AA10h - shift
CAntirad@@net_Spawn proc DC:ptr CSE_Abstract
CAntirad@@net_Spawn endp
org 10208CA0h - shift
CEatableItemObject@@UpdateCL proc
CEatableItemObject@@UpdateCL endp
org 10209080h - shift
CAntirad@@UpdateCL proc
CAntirad@@UpdateCL endp
org 10208AA0h - shift
CEatableItemObject@@_CEatableItemObject proc
CEatableItemObject@@_CEatableItemObject endp
org 10208CB0h - shift
CEatableItemObject@@OnEvent proc P:ptr NET_Packet, type_:dword
CEatableItemObject@@OnEvent endp
;увеличим размер CAntirad
org 10297896h - shift	; 5 bytes
	push	size CAntirad
;CAntirad::CAntirad()
org 1024A88Fh - shift	; 5 bytes
	jmp		CPyroBattery@@CPyroBattery_ext
;CAntirad::~CAntirad()
org 1024A937h - shift	; 5 bytes
	jmp		CPyroBattery@@_CPyroBattery_ext
;CAntirad::Load(LPCSTR section)
org 1049CCCCh - shift	; 4 bytes
	dd offset CPyroBattery@@Load		;было CAntirad@@Load
;CAntirad::UseBy(CEntityAlive* entity_alive)
org 1049CC94h - shift	; 4 bytes
	dd offset CPyroBattery@@UseBy		;было CEatableItem::UseBy
;CAntirad::use(CGameObject* who_use)
org 1049CED4h - shift	; 4 bytes
	dd offset CPyroBattery@@use			;было CGameObject::use
;CAntirad::net_Spawn(CSE_Abstract* DC)
org 1049CCD4h - shift	; 4 bytes
	dd offset CPyroBattery@@net_Spawn	;было CAntirad::net_Spawn
;CAntirad::UpdateCL()
org 1049CCD0h - shift	; 4 bytes
	dd offset CPyroBattery@@UpdateCL	;было CAntirad::UpdateCL
org 1049CD78h - shift	; 4 bytes
	dd offset CPyroBattery@@OnEvent		;было CGameObject::CEatableItemObject::OnEvent
;--------------
;Методы класса CScriptParticles
org 1018E4B4h - shift
CScriptParticles@@CScriptParticles:
org 1018D8E0h - shift
CScriptParticles@@_CScriptParticles proc a2:byte
CScriptParticles@@_CScriptParticles endp
org 1018D920h - shift
CScriptParticles@@Play proc
CScriptParticles@@Play endp
org 1018D930h - shift
CScriptParticles@@PlayAtPos proc pos:ptr Fvector
CScriptParticles@@PlayAtPos endp
org 1018D950h - shift
CScriptParticles@@Stop proc 
CScriptParticles@@Stop endp
org 1018D9A0h - shift
CScriptParticles@@StopDeffered proc
CScriptParticles@@StopDeffered endp
org 1018D9F0h - shift
CScriptParticles@@MoveTo proc pos:ptr Fvector, vel:ptr Fvector
CScriptParticles@@MoveTo endp
org 1018DAC0h - shift
CScriptParticles@@IsPlaying proc (byte)
CScriptParticles@@IsPlaying endp
org 1018DB10h - shift
CScriptParticles@@IsLooped proc (byte)
CScriptParticles@@IsLooped endp
org 1018DB20h - shift
CScriptParticles@@LoadPath proc caPathName:ptr byte
CScriptParticles@@LoadPath endp
org 1018DB40h - shift
CScriptParticles@@StartPath proc looped_:byte
CScriptParticles@@StartPath endp
org 1018DB60h - shift
CScriptParticles@@StopPath proc
CScriptParticles@@StopPath endp
org 1018DB70h - shift
CScriptParticles@@PausePath proc val:byte
CScriptParticles@@PausePath endp
org 1047F37Ch - shift
vfptr_CScriptParticles:
org 1018D600h - shift
CScriptParticlesCustom@@CScriptParticlesCustom proc (dword) owner:ptr CScriptParticles, caParticlesName:ptr byte
CScriptParticlesCustom@@CScriptParticlesCustom endp
org 10286B20h - shift
CParticlesObject@@PerformAllTheWork:
org 101E7250h - shift
Func@generate_orthonormal_basis:
generate_orthonormal_basis MACRO dir:req, result:req
	pushvar	dir
	regvar	eax, result
	call	Func@generate_orthonormal_basis
	add		esp, 4
	EXITM <>
ENDM
org 10286C20h - shift
CParticlesObject@@UpdateParent proc m:ptr Fmatrix, vel:ptr Fvector
CParticlesObject@@UpdateParent endp
;--------------
;Серверная часть. Класс CSE_ALifeItemPyrobattary на базе CSE_ALifeItem
;CSE_ALifeItem *__thiscall CSE_ALifeItem::CSE_ALifeItem(CSE_ALifeItem *this)
org 103100EBh - shift	; 5 bytes
	jmp		CSE_ALifeItem@@CSE_ALifeItem_ext
;void __thiscall CSE_ALifeItem::STATE_Read(CSE_ALifeItem *this, NET_Packet *tNetPacket, int size)
org 10310151h - shift	; 6 bytes
	jmp		CSE_ALifeItem@@STATE_Read_ext
	db		0CCh
;void __thiscall CSE_ALifeItem::STATE_Write(CSE_ALifeItem *this, NET_Packet *tNetPacket)
org 10311736h - shift	; 6 bytes
	jmp		CSE_ALifeItem@@STATE_Write_ext
	db		0CCh
org 102978C6h - shift	; 5 bytes
	push	size CSE_ALifeItemPyrobattary
;--------------------------------------------------------
;Возможность добавлять собственые классы.
org 102919C0h - shift
CObjectItemAbstract__CObjectItemAbstract:
org 10291A20h - shift
CObjectFactory__add:
org 104AB5E0h - shift
vfptr?CAntirad?VCSE_ALifeItem:
org 102932BDh - shift	; 5 bytes
	jmp		CObjectFactory@@register_classes_ext
return_CObjectFactory@@register_classes_ext:
;--------------------------------------------------------
;расширение пространства имён CPhysicsShell, скриптовый класс physics_shell
org 1037096Eh - shift
register_shell__void__Fvector:
org 1036FFFDh - shift
register_shell__void__float_float_float:
;оптимизация регистрации скриптовых методов пространства имён physics_shell
org 104BF274h - shift
aApply_force	dd ?	; "apply_force"
org 1036F882h - shift	; 14 bytes
	nop7
	push	0
	push	offset aApply_force
org 103700BFh - shift	; 5 bytes
	nop2
	push	[ebp+12];arg_4
org 1036FA52h - shift	; 5 bytes
	jmp		script_register@@physics_shell_fix
return_script_register@@physics_shell_fix:
;--------------------------------------------------------
;Пули и ракеты вылетают из дула.
org 10118EF0h - shift
CWeapon@@get_LastFP proc (dword)
CWeapon@@get_LastFP endp
org 10118F20h - shift
CWeapon@@get_LastFD proc (dword)
CWeapon@@get_LastFD endp
org 10218700h - shift
CWeapon@@get_LastFP2 proc (dword)
CWeapon@@get_LastFP2 endp
org 101D607Eh - shift	; 6 bytes
	jz		CActor@@g_fireParams_fix
;--------------------------------------------------------
;Переделка класса  CWeaponRPG7
org 10296F36h - shift	; 5 bytes
	push	sizeof(CWeaponRPG7)
org 10232A75h - shift	; 5 bytes
	push	sizeof(CWeaponRPG7)
org 102321DEh - shift	; 13 bytes
	mov		[esi].CWeaponRPG7.m_sRocketSection.p_, eax
	jmp		CWeaponRPG7@@Load_ext
	db		2 dup (0CCh)
;Многозарядный гранатомёт, Многотипозарядный гранатомёт.
CWeaponRPG7@@UpdateMissileVisibility_fun	PROTO pWeaponVisual:dword, pHudVisual:dword, vis_hud:dword, vis_weap:dword
;void	CWeaponRPG7::UpdateMissileVisibility()
org 10232265h - shift	; 121 bytes
	db		121 dup (0CCh)	;затрём функцию
org 10232265h - shift	; 121 bytes
;edi	pHudVisual		CKinematics*
;esi	pWeaponVisual	CKinematics*
	movzx	eax, byte ptr [esp+14h-2];vis_hud
	movzx	edx, byte ptr [esp+14h-1];vis_weap
	mov		ecx, [esp+14h+4];this
	CWeaponRPG7@@UpdateMissileVisibility_fun(esi, edi, eax, edx)
	mov		ecx, esi
	call	ds:CKinematics__CalculateBones_Invalidate
	mov		edx, [esi]
	mov		eax, [edx+40h]
	push	0
	mov		ecx, esi
	call	eax			; pWeaponVisual->CalculateBones();
;---------------------
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	pop		ecx
	retn	4
;BOOL	CWeaponRPG7::net_Spawn(CSE_Abstract *DC)
org 102322F6h - shift	; 95 bytes
	db		95 dup (0CCh)	;затрём функцию
org 102322F6h - shift	; 95 bytes
	ASSUME	esi:ptr CWeaponRPG7, ecx:ptr CRocketLauncher
	.if ([esi].iAmmoElapsed)
		mov		eax, [esi].m_rockets._Myfirst
		.if (eax==NULL || [esi].m_rockets._Mylast==eax);(m_rockets.empty())
			lea		ecx, [esi].CRocketLauncher@vfptr	;-size(CRocketLauncher)CRocketLauncher*
			CRocketLauncher@@SpawnRockets(&[esi].m_magazine)
		.endif
	.endif
	mov		eax, edi
	pop		edi
	pop		esi
	retn	4
;переопределим OnAnimationEnd
org 10492B6Ch - shift	; 4 bytes
	dd offset CWeaponRPG7@@OnAnimationEnd
;уберём виртуальный метод CWeaponRPG7::switch2_Fire
org 104927FCh - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10492854h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10492BB0h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;-------------
;void	CWeaponRPG7::ReloadMagazine()
org 102323A9h - shift	; 73 bytes
	db		73 dup (0CCh)	;затрём функцию
org 102323A9h - shift	; 73 bytes
	.if ([esi].iAmmoElapsed && [esi].m_bCanRocketReload)
		mov		[esi].m_bCanRocketReload, false
		lea		ecx, [esi].CRocketLauncher@vfptr
		CRocketLauncher@@DeleteRockets()
		lea		ecx, [esi].CRocketLauncher@vfptr
		CRocketLauncher@@SpawnRockets(&[esi].m_magazine)
	.endif
	ASSUME	esi:nothing, ecx:nothing
	pop		esi
	pop		ecx
	retn
;--------------------------------------------------------
;Всё оружие(CWeaponMagazined) может стрелять очередями.
WEAPON_ININITE_QUEUE		= dword ptr -1
;int	CWeaponMagazined::GetCurrentFireMode()
org 10225200h - shift	; 32 bytes
	db		32 dup (0CCh)
org 10225200h - shift	; 32 bytes
CWeaponMagazined@@GetCurrentFireMode proc 
	;return m_bHasDifferentFireModes ? m_aFireModes[m_iCurFireMode] : 1;
	ASSUME	ecx:ptr CWeaponMagazined
	mov		eax, 1
	.if ([ecx].m_bHasDifferentFireModes)
		mov		eax, [ecx].m_iCurFireMode
		mov		edx, [ecx].m_aFireModes._Myfirst
		mov		eax, [edx+eax*4]
	.endif
	ASSUME	ecx:nothing
	ret
CWeaponMagazined@@GetCurrentFireMode endp
;CWeaponMagazined::Load
org 10225A25h - shift	; 37 bytes
	ASSUME	edi:ptr CWeaponMagazined
	jz		short loc_10225A3B
	add		dword ptr [ebx], -1
loc_10225A3B:
	jmp		CWeaponMagazined@@Load_fix
	nop5
loc_10225A34:
	mov		[edi].m_bHasDifferentFireModes, false
	mov		[edi].m_iQueueSize, 1
	jmp		CWeaponMagazined@@Load_fix
;void	CWeaponMagazined::OnH_A_Chield()
org 102288E0h - shift	; 128 bytes
	db		128 dup (0CCh)
org 102288E0h - shift	; 128 bytes
CWeaponMagazined@@OnH_A_Chield proc
	push	edi
	mov		edi, ecx
	mov		eax, 1	;queue_size
	.if ([edi].m_bHasDifferentFireModes)
		smart_cast	CActor, [edi].Parent	;;, CGameObject
		.if (eax)
			;queue_size = GetCurrentFireMode();
			mov		ecx, edi
			mov		eax, [edi]
			mov		edx, [eax+208h]
			call	edx
		.else			;НПС всегда переключает на автоматический режим, если он есть, или на максимальную очередь.
			smart_cast	CWeaponBM16, CWeaponMagazined, edi
			TERNARY	eax, 1, WEAPON_ININITE_QUEUE	;НПС из двухстволки дуплетом не стреляет!
		.endif
	.endif
	;SetQueueSize(queue_size);
	push	eax
	mov		ecx, edi
	mov		eax, [edi]
	mov		edx, [eax+1F0h]
	call	edx
	mov		ecx, edi
	pop		edi
	jmp		CWeapon@@OnH_A_Chield
CWeaponMagazined@@OnH_A_Chield endp
;void	CWeaponMagazined::SetQueueSize(int size)
org 10228964h - shift	; 9 bytes
	jmp		CWeaponMagazined@@SetQueueSize_fix
	nop
return_CWeaponMagazined@@SetQueueSize_fix:
	cmp		eax, WEAPON_ININITE_QUEUE
;Всё оружие стреляет очередями, если включен параметр fire_modes, и задан размер очереди больше 1 или -1.
;Для того, чтобы всё оружие(CWeaponMagazined) могло стрелять очередями, надо удалить класс CWeaponCustomPistol.
;Этот класс, отличается от родителя только отличием 3 методов: switch2_Fire, GetCurrentFireMode, FireEnd.
;Удалим эти виртуальные методы из класса CWeaponCustomPistol, переопределив их в наследник CWeaponMagazined.
org 1048B854h - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 1048B8ACh - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 1048BC08h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponPistol
org 1048BF7Ch - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 1048BFD4h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 1048C330h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponWalther
org 1048F4ECh - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 1048F544h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 1048F8A0h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponUSP45
org 104917CCh - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10491824h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10491B80h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponSVU
org 1049221Ch - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10492274h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 104925D0h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponSVD
org 1049363Ch - shift	; 4 bytes
	dd offset CWeaponMagazined__OnAnimationEnd
org 104932CCh - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10493324h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10493680h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponHPSA
org 10494A04h - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10494A5Ch - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10494DB8h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponPM
org 10494FDCh - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10495034h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10495390h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponBinoculars
org 104955C4h - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 1049561Ch - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10495978h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponShotgun
org 10495C84h - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10495CDCh - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10496048h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponFORT
org 1049626Ch - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 104962C4h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10496620h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponRG6
org 10496834h - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 1049688Ch - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10496BF8h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;удаляем виртуальные методы из класса CWeaponBM16
org 10496E7Ch - shift	; 4 bytes
	dd offset CWeaponMagazined@@switch2_Fire
org 10496ED4h - shift	; 4 bytes
	dd offset CWeaponMagazined@@GetCurrentFireMode
org 10497240h - shift	; 4 bytes
	dd offset CWeaponMagazined@@FireEnd
;Удалим все ссылки на класс CWeaponCustomPistol
org 10225220h - shift
CWeaponMagazined@@CWeaponMagazined:
org 102253F0h - shift
CWeaponMagazined@@_CWeaponMagazined:
;CWeaponPistol
org 10220255h - shift	; 5 bytes
	call	CWeaponMagazined@@CWeaponMagazined
org 10220507h - shift	; 5 bytes
	call	CWeaponMagazined@@_CWeaponMagazined
;CWeaponSVU
org 10231BF3h - shift	; 5 bytes
	call	CWeaponMagazined@@CWeaponMagazined
org 10231D2Bh - shift	; 5 bytes
	jmp		CWeaponMagazined@@_CWeaponMagazined
;CWeaponRPG7
org 10231EA3h - shift	; 5 bytes
	call	CWeaponMagazined@@CWeaponMagazined
org 1023209Dh - shift	; 5 bytes
	jmp		CWeaponMagazined@@_CWeaponMagazined
;CWeaponSVD
org 10232D53h - shift	; 5 bytes
	call	CWeaponMagazined@@CWeaponMagazined
org 10232E8Bh - shift	; 5 bytes
	jmp		CWeaponMagazined@@_CWeaponMagazined
;CWeaponBinoculars
org 10233E93h - shift	; 5 bytes
	call	CWeaponMagazined@@CWeaponMagazined
org 10234078h - shift	; 5 bytes
	jmp		CWeaponMagazined@@_CWeaponMagazined
;CWeaponShotgun
org 10236183h - shift	; 5 bytes
	call	CWeaponMagazined@@CWeaponMagazined
org 102364A4h - shift	; 5 bytes
	call	CWeaponMagazined@@_CWeaponMagazined
;Удаляем из таблиц RTTI наследников в классе CWeaponCustomPistol
;Теперь CWeaponCustomPistol класс пустышка.
org 104F63D0h - shift	; 28 bytes
a0_CWeaponCustomPistol0		dd offset _AVCWeaponCustomPistol
							dd 0
							dd 0
							dd -1
							dd 0
							dd 40h
							dd offset db_CWeaponCustomPistol0
org 104F96C4h - shift	; 28 bytes
a28_CWeaponCustomPistol0	dd offset _AVCWeaponCustomPistol
							dd 0
							dd 28h
							dd -1
							dd 0
							dd 40h
							dd offset db_CWeaponCustomPistol0
.data
align 4
db_CWeaponCustomPistol0		dd 0
							dd 0
							dd 1
							dd offset tbl_CWeaponCustomPistol0
tbl_CWeaponCustomPistol0	dd offset a0_CWeaponCustomPistol0
							dd 0
.code
;-----------------------------------------------
;Блокировка автоперезарядки
;void CWeaponMagazined::FireEnd()
org 10225B39h - shift	; 14 bytes
;esi	this	CShootingObject*
;edi	this	CWeaponMagazined
	.if ([edi].m_bAutoReload) ;7+2 bytes
		jmp		CWeaponMagazined@@FireEnd_fix
	.endif
	ASSUME	edi:nothing
;void CWeaponMagazined::switch2_Empty()
org 10227070h - shift	; 64 bytes
	ASSUME	esi:ptr CWeaponMagazined
	push	esi
	mov		esi, ecx		; this
	.if ([esi].m_bAutoReload)
		mov		eax, [esi]
		mov		edx, [eax+154h]
		call	edx				;OnZoomOut();
		call	CWeaponMagazined@@TryReload
		mov		ecx, esi
		.if (!al)
			mov		eax, [esi]
			mov		edx, [eax+1CCh]
			pop		esi
			jmp		edx			;CWeaponMagazined::OnEmptyClick
		.endif
	.endif
	mov		eax, [ecx]
	mov		edx, [eax+188h]
	mov		[esi].bWorking, false
	pop		esi
	jmp		edx					;ClearShotEffector()
	ASSUME	esi:nothing
;--------------------------------------------------------
;
org 101B7950h - shift
CBulletManager__AddBullet:
;CBulletManager *this@<eax>, Fvector *position, Fvector *direction, float starting_speed, float power, float impulse, u16 sender_id, u16 sendersweapon_id, int e_hit_type, float maximum_distance, CCartridge *cartridge, bool SendHit, bool AimBullet
CBulletManager@@AddBullet MACRO pos:req, dir:req, start_speed:req, power:req, impulse:req, sender_id:req, senderswpn_id:req, hit_type:req, max_dist:req, cartridge:req, SendHit:req, AimBullet:=<false>
	pushvar	AimBullet
	pushvar	SendHit
	pushvar	cartridge
	pushvar	max_dist
	pushvar	hit_type
	pushvar	senderswpn_id
	pushvar	sender_id
	pushvar	impulse
	pushvar	power
	pushvar	start_speed
	pushvar	dir
	pushvar	pos
	mov		eax, ds:g_pGameLevel
	mov		edx, [eax]
	mov		eax, [edx].CLevel.m_pBulletManager
	call	CBulletManager__AddBullet
	EXITM <>
ENDM
