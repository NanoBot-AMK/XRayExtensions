;*******************************************************************************
; S.T.A.L.K.E.R data stubs
;*******************************************************************************

org 104AFD90h - shift
CurrentGameUI:

org 1043DF30h - shift
CDialogHolder__TopInputReceiver:

org 10499B50h - shift
CUIScrollView__GetItem:
org 104AE24Dh - shift
register__cuilistbox__CUIWindows__UINT:

;.text:104AEA4E					xor		eax, eax
;.text:104AEA50					push	eax
;.text:104AEA51					mov		eax, offset CUIScrollView__GetItem
;.text:104AEA56					push	eax
;.text:104AEA57					push	offset aGetitem ; "GetItem"
org 104AEA5Ch - shift
	jmp cuilistbox_fix1
;.text:104AEA5C					xor		eax, eax
;.text:104AEA5E					push	eax
;.text:104AEA5F					mov		eax, offset sub_104A7B90
org 104AEA64h - shift
back_from_cuilistbox_fix1:
;.text:104AEA64					push	eax
;.text:104AEA65					push	offset aGetitembyindex ; "GetItemByIndex"


org 104AEAF3h - shift
	jmp cuilistbox_fix2
;.text:104AEAF3					call	sub_104AE24D
;.text:104AEAF8					mov		ecx, eax
org 104AEAFAh - shift
back_from_cuilistbox_fix2:
;.text:104AEAFA					call	sub_104ADB26



org 100490C0h - shift
script_hit_callback:

; Функция smart_cast<CGameObject*>()
; ищем так:
; находим строку "ph_capture_visuals"
; находим ссылку на строку, их всего две. 
; Из них та функция, у которой есть один аргумент - это CActor::shedule_Update(int dt).
; в этой функции ищем следующий фрагмент (функция длинная, примерно посередине):
;.text:10262968 loc_10262968:							; CODE XREF: CActor__shedule_Update+61Fj
;.text:10262968					mov		eax, ds:?g_hud@@3PAVCCustomHUD@@A ; CCustomHUD * g_hud	<== удобный ориентир - импортированная из dll ф-я
;.text:1026296D					mov		ecx, [eax]
;.text:1026296F					call	sub_104AFE40
;.text:10262974					xor		ebx, ebx
;.text:10262976					cmp		[esi+900h], ebx
;.text:1026297C					mov		ebp, eax
;.text:1026297E					jnz		loc_10262C25
;.text:10262984					mov		eax, [ebp+0]
;.text:10262987					cmp		eax, ebx
;.text:10262989					jz		loc_10262C25
;.text:1026298F					test	dword ptr [eax+0A4h], 2000000h
;.text:10262999					jz		loc_10262C25
;.text:1026299F					movss	xmm0, ds:flt_105B7998
;.text:102629A7					comiss	xmm0, dword ptr [ebp+4]
;.text:102629AB					jbe		loc_10262C25
;.text:102629B1					push	eax
;.text:102629B2					call	sub_1007A4F0  <==	эти два вызова - это и есть вызов smart_cast<CGameObject*>
;.text:102629B7					mov		[esi+510h], eax
;.text:102629BD					mov		ecx, [ebp+0]
;.text:102629C0					push	ecx
;.text:102629C1					call	sub_1007A4F0  <==
;.text:102629C6					mov		ebp, eax

org 1007A4F0h - shift
smart_cast_CGameObject: ; по большому счёту не нужна, поскольку в релизе ничего не делает. 
; странно, что оптимизатор её не повырезал

; миниправка для снятия ограничения на выкидывание из ящиков
;.text:101C7460 CScriptGameObject__DropItem proc near
; функцию находим по рядом с ссылкой на строку "drop_item"
; ...
;.text:101C749C					test	esi, esi		   <== эти 4 строки выполняют проверку на 
;.text:101C749E					jz		short loc_101C74F8 <== то, что выкидывающий - это CInventoryOwner и 
;.text:101C74A0					test	eax, eax		   <== предмет - это CInventoryItem. Какая из них за что отвечает,
;.text:101C74A2					jz		short loc_101C74F8 <== точно не знаю, так что забиваем все. Контроль делайте сами.
;.text:101C74A4					lea		ecx, [esp+4020h+var_4014]

org 101C749Ch - shift ; не забыть вставить в список правок (8 байт)
	nop ; test	  esi, esi			 ;2 байта
	nop
	nop ; jz	  short loc_101C74F8 ;2 байта
	nop
	nop ; test	  eax, eax
	nop
	nop ; jz	  short loc_101C74F8
	nop
; итого: 0x101C74A4 - 0x101C749C = 0xA4 - 0x9C = 8 - сходится
	
;-----------< регистрация глобального пространства имён >----------------------
; функция, которая регистрирует глобальную скриптовую функцию с прототипом:
; void fun(char*)
; ссылку см. ниже
org 10222902h - shift 
error_log_register:

; функция, которая регистрирует глобальную скриптовую функцию с прототипом:
; void fun(void)
; адрес ищем рядом со ссылкой на строку "flush"
org 102225EEh - shift
flush_register:

; Функция CScriptEngine::script_register
; ищем по ссылке на строку "error_log"

;.text:1022398C					push	esi
;.text:1022398D					call	sub_102225BB
;.text:10223992					push	offset sub_102214A0
;.text:10223997					push	offset aError_log ; "error_log"
;.text:1022399C					push	esi
org 1022399Dh - shift
	jmp global_space_ext ; врезка с инструкцией перехода - 5 байт
;.text:1022399D					call	sub_10222902; error_log_register
org 102239A2h - shift
back_to_global_space_ext:
;.text:102239A2					lea		eax, [ebp+var_1]


;--------------< Регистрации пространства имён level >-------------------------

; функция регистрирующая в пространстве имён level функцию с прототипом:
; game_object* fun(int);
; аргумент при вызове можно игнорировать
; используется для регистрации level.object_by_id. Ищем по ссылке на строку "object_by_id". 
; Там будет:

;.text:1024A74C					push	offset loc_1023F5A0; <== Это сама функция level.object_by_id   будет нужна
;.text:1024A751					lea		eax, [ebp+var_8]
;.text:1024A754					push	offset aObject_by_id ; "object_by_id"
;.text:1024A759					push	eax
;.text:1024A75A					call	sub_10241611; object_by_id_register <== это наш адрес
;.text:1024A75F					add		esp, 18h

org 10241611h - shift
register_level__go__void: 

; функция регистрирующая в пространстве имён level функцию с прототипом:
; float fun(void);
; ссылку см. ниже
org 1024177Dh - shift
register_level__float__void: 

; метод CLevel::script_register
; ищем по ссылке на строку "get_snd_volume"

; Первый фрагмент
;.text:1024A345					push	offset aGet_snd_volume ; "get_snd_volume" - этот адрес нам неинтересен
;.text:1024A34A					push	eax
org 1024A34Bh - shift
	jmp level_ns_extension_1
;.text:1024A34B					call	sub_1024177D; регистрация get_snd_volume - см. метку выше
org 1024A350h - shift
back_to_level_ns_ext_1:
;.text:1024A350					pop		ecx
;.text:1024A351					pop		ecx
;.text:1024A352					mov		eax, esp
;.text:1024A354					push	offset loc_10243A00
;.text:1024A359					push	offset aPhysics_world ; "physics_world"

; Второй фрагмент. Начинается сразу за первым и состоит из нескольких повторов mov ecx, eax;   call esi;
; Этих повторов столько, сколько выше было регистраций функций. Значит, на каждую свою дорегистрацию
; надо добавить по одной такой паре.
;.text:1024A764					call	esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
org 1024A766h - shift
	jmp level_ns_extension_2 ; врезка с инструкцией перехода - 5 байт
;.text:1024A766					mov		ecx, eax
;.text:1024A768					call	esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
;.text:1024A76A					mov		ecx, eax
;.text:1024A76C					call	esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
org 1024A76Eh - shift
back_to_level_ns_ext_2: ; расстояние 8 байт, хватает, чтобы вставить 5 байт врезки
;.text:1024A76E					mov		ecx, eax


;------------------------------------------------------------------------------
;void __thiscall CActor::HitSignal(CActor *this, float perc, _vector3<float> *vLocalDir, CObject* who, __int16 element)
; как найти: ищем в idata элемент с адресом функции CBoneInstance::get_param
; смотрим все ссылки на эту функцию. Есть две функции, из которых идёт по одной ссылке.
; в одной из них ссылка идёт по смещению +46h, из другой - по смещению +379h. Вторая нам и нужна.
; скорее всего, в других билдах смещения будут немного другими.

; фрагмент в начале этой функции. В начале потому, что в конце из-за оптимизации портится часть
; аргументов (их место используется под локальные переменные). Для простоты приходится
; игнорировать проверку на живость актора. Колбек будет вызываться всегда. Для актора
; в сингле это по большому счёту фиолетово.

org 10260120h - shift
	jmp CActor_HitSignal_ext
;.text:10260120					xorps	xmm5, xmm5
;.text:10260123					sub		esp, 0Ch
org 10260126h - shift
back_to_CActor_HitSignal:
;.text:10260126					push	edi
;.text:10260127					mov		edi, ecx
;.text:10260129					mov		eax, [edi+200h]

; -----------------------------------------------------------------------------
; Метод класса CGameObject, который возвращает для него скриптовый объект game_object
; аргументов нет, this передаётся через ecx
; ищем так:
; сначала находим функцию level.object_by_id (см. выше поиск object_by_id_register)
; затем в этой функции в конце видим переход:
;.text:1023F5CE					mov		ecx, eax
;.text:1023F5D0					jmp		sub_1027FD40 ; CGameObject__lua_game_object <== это наш адрес
org 1027FD40h - shift
CGameObject__lua_game_object:

org 10281920h - shift
CGameObject__callback:

;--------------< регистрация класса CUIStatic >--------------------------------
; метод класса CUIStatic::SetTextureRect - ccылку ищем в первом фрагменте ниже
org 1047B6E0h - shift
CUIStatic__SetTextureRect:

; фрагменты функции CUIStatic::::script_register
; Функцию ищем по ссылке на строку "SetTextureRect"

; ---------- первый фрагмент: аргументы пишутся в стек
;.text:1047F4B0					push	offset aSetstretchtext ; "SetStretchTexture"
org 1047F4B5h - shift
	jmp CUIStatic_extention_1 ; врезка с инструкцией перехода - 5 байт
;.text:1047F4B5					xor		eax, eax
;.text:1047F4B7					push	eax
;.text:1047F4B8					mov		eax, offset sub_1047B6E0; CUIStatic__SetTextureRect - см. выше
;.text:1047F4BD					push	eax
;.text:1047F4BE					push	offset aSettexturerect ; "SetTextureRect"
org 1047F4C3h - shift
back_to_CUIStatic_ext_1:
;.text:1047F4C3					push	[ebp+var_10]
;.text:1047F4C6					mov		eax, offset sub_103F1DAF
;.text:1047F4CB					push	eax

; ---------- второй фрагмент: вызываются функции регистрации в обратном порядке
;.text:1047F4DF					push	[ebp+var_C]
;.text:1047F4E2					push	offset aCuistatic ; "CUIStatic"
;.text:1047F4E7					lea		ecx, [ebp+var_34]
;.text:1047F4EA					call	sub_1047D536	; register class CUIStatic
;.text:1047F4EF					mov		ecx, eax
;.text:1047F4F1					call	sub_1047CF5A	; register constructor CUIStatic()
;.text:1047F4F6					mov		ecx, eax
;.text:1047F4F8					call	sub_1047F2B1	; TextControl
;.text:1047F4FD					mov		ecx, eax
;.text:1047F4FF					call	sub_1047EE96	; InitTexture
org 1047F504h - shift
	jmp CUIStatic_extention_2 ; врезка с инструкцией перехода - 5 байт
;.text:1047F504					mov		ecx, eax
;.text:1047F506					call	sub_1047EEC1	; register SetTextureRect
org 1047F50Bh - shift
back_to_CUIStatic_ext_2:
;.text:1047F50B					mov		ecx, eax

; Шаблонная функция для регистрации функции с прототипом:
; void fun(CUIStatic* this, Frect* r)
; адрес ищем во втором фрагменте выше
org 1047EEC1h - shift
SetTextureRect_register:

org 104AFE40h - shift
CCustomHUD__GetRQ:

; миниправка функции get_rank на предмет блокировки сообщения "'cannot find rank for ..."
; для стволов, не прописанных в mp_ranks
; Сейчас, если ранг не найден, функция будет возвращать ранг 0 
org 104CCC2Eh + 4 - shift ; в список правок впишем 0x104CCC32 4
		 dword 00000000h ; второй аргумент инструкции	mov		[esp+34h+var_24], 0FFFFFFFFh

; ищется по названию atexit
; используется для вызова деструкторов у статических объектов
org 10509FD0h - shift
_atexit:

; void __cdecl CCC_RegisterCommands()
; как найти: находим DllMain по названию и первая вызываемая функция будет она
org 103349CDh - shift
CCC_RegisterCommands_part_0:
	;было
;.text:103349CD		mov		eax, 4000h
	;стало
	jmp		CCC_RegisterCommands_chunk_0
	
CCC_RegisterCommands_1:
;.text:103349D2		test	dword_1064FB44, eax
;.text:103349D8		jnz		short loc_10334A0D

; void __cdecl InventoryUtilities::SendInfoToActor(const char info_portion)
; как найти: ищем строчку "ui_pda_hide", переходим по ссылке на код, который на нее ссылается
; там будет что-то вида:
;.text:10442B5E		push	offset aUi_pda_hide ; "ui_pda_hide"
;.text:10442B63		call	sub_10466290 <= это и есть нужная функция InventoryUtilities__SendInfoToActor
org 10466290h - shift
InventoryUtilities__SendInfoToActor:

; void __thiscall CUIPdaWnd::SetActiveSubdialog(CUIPdaWnd *this, EPdaTabs section)
;как найти: ищем строку "CUIPdaWnd::SetActiveSubdialog" - функция, в которой она используется, и есть нужная
;.text:104428B0		CUIPdaWnd__SetActiveSubdialog proc near 
;.text:104428B0		section			= dword ptr	 4
;.text:104428B0
;.text:104428B0		push	esi
;.text:104428B1		mov		esi, ecx
;.text:104428B3		mov		eax, [esi+7Ch]
;.text:104428B6		push	edi
;.text:104428B7		mov		edi, [esp+8+section]
org 104428BBh - shift
CUIPdaWnd__SetActiveSubdialog_ext:
	;было
;.text:104428BB		cmp		eax, [edi]
;.text:104428BD		jz		loc_104429F8
	;стало
	jmp		CUIPdaWnd__SetActiveSubdialog_chunk
	nop
	nop
	nop
	
CUIPdaWnd__SetActiveSubdialog_1:	
;.text:104428C3		mov		eax, [esi+78h]
;.text:104428C6		test	eax, eax

;ищется по названию
org 10509D9Ah - shift
__RTDynamicCast:
;.text:10509D9A					jmp		ds:__imp___RTDynamicCast

org 1026F8C0h - shift
CActor__SetWeaponHideState:

; public: void __thiscall CPHMovementControl::DestroyCharacter(void)
org 104FE590h - shift
CPHMovementControl__DestroyCharacter:

; protected: bool __thiscall CActor::use_Vehicle(class CHolderCustom *)
org 10278B8Ah - shift
CActor__use_Vehicle_part:
	;было
;.text:10278B8A					mov		dword ptr [esi+540h], 0
	;стало
	jmp		CActor__use_Vehicle_chunk_1
	nop
	nop
	nop
	nop
	nop
	
loc_10278B94:
;.text:10278B94					pop		edi
;.text:10278B95					mov		al, 1
;.text:10278B97					pop		esi
;.text:10278B98					add		esp, 0Ch
;.text:10278B9B					retn	4

; public: void __thiscall CScriptGameObject::UnloadMagazine(void)
;как найти: ищем строку "unload_magazine" gjgflftv yf rjl dblf^
;.text:101EDED1					push	offset aUnload_magazin ; "unload_magazine"
;.text:101EDED6					mov		ecx, eax
;.text:101EDED8					mov		[esp+64h+var_38], offset sub_101c97c0 ; <<< искомая функция
;.text:101EDEE0					call	sub_101D4350
org 101C9835h - shift
CScriptGameObject__UnloadMagazine_part:
push	1


;==============================================================================
; ищется по ссылке на строку "li_pause_key"
;.text:10237540 CLevel__IR_OnKeyboardPress proc near	; DATA XREF: .rdata:1054857Co
;.text:10237540					mov		eax, ds:?Device@@3VCRenderDevice@@A ; CRenderDevice Device
org 10237545h - shift
	jmp level_input_fix
;.text:10237545					sub		esp, 410h
org 1023754Bh - shift
back_from_level_input_fix:
;.text:1023754B					cmp		dword ptr [eax+0Ch], 0


org 103065C0h - shift
script_callback_int_int: ; this - в ecx, два аргумента в стеке

org 1026A790h - shift
Actor:

;===================| Секция .idata	 |=========================================
; Ищутся по именам в окне Names IDA
org 10512558h - shift
FlushLog dword ? ; void __cdecl FlushLog(void)
org 10512820h - shift 
Msg		 dword ? ; void __cdecl Msg(char const *, ...)
org 10512D30h - shift
g_hud	 dword ? ; class CCustomHUD * g_hud
org 10512B0Ch - shift
_CCC_Float_	dd ? ; public: __thiscall CCC_Float::CCC_Float(char const *, float *, float, float)
org 10512AF4h - shift
_1CCC_Float_	dd ?  ; public: virtual __thiscall CCC_Float::~CCC_Float(void)
org 10512DB8h - shift
_Console_	dd ?  ; class CConsole * Console
org 10513264h - shift
_phTimefactor_	dd ? ; float phTimefactor
org 1062CD54h - shift
_R0_AVCCar dd ?	 ; class CCar `RTTI Type Descriptor'
org 1062D130h - shift
_R0_AVCHolderCustom	dd ?  ; class CHolderCustom `RTTI Type Descriptor'
org 10512258h - shift
__imp___RTDynamicCast dd ? ; __imp___RTDynamicCast

;===================| Секция .data	|=========================================
;сначала находится в билде 2947, а потом ищется в аналогичных функциях COP
org 10635C44h - shift
g_fov dd ?
org 1064EA60h - shift
INV_STATE_CAR	 dw ?	; unsigned int INV_STATE_CAR


org 1064E2C0h - shift
g_Actor	 dd ?

; функция регистрирующая в пространстве имён level функцию с прототипом:
; int fun(void)
org 1024199Fh - shift
register_level__uint__void: 

; функция регистрирующая в пространстве имён level функцию с прототипом:
; void fun(float)
org 1024188Eh - shift
register_level__void__float: 

org 10512514h - shift
CObjectSpace__RayPick dd ?

;---rev231---
; Вывод начального адреса xrGame.dll в логе
org 1034A990h - shift	; 7 bytes
	call	StartAdress_xrGame_log__DllMain
	nop
	nop

; фикс вылета 'смерть актора в машине'.
org 104E3310h - shift	; 8 bytes
	jmp		die_actor_holder_fix
	nop
	nop
	nop
back_from_die_actor_holder_fix:
org 104E3030h - shift	; 
CCharacterPhysicsSupport__KillHit:
org 10348400h - shift
smart_cast_CActor:
; часть 2
org 104E37A7h - shift	; 9 bytes
	jmp		die_actor_holder_fix2
	nop
	nop
	nop
	nop
back_from_die_actor_holder_fix2:
org 104E2190h - shift	; 
CCharacterPhysicsSupport__ActivateShell:
;---rev232---
org 10241AB0h - shift	; 
register_level__uint__uint_vector_float:
org 10241A55h - shift	; 
register_level__float__uint_vector:
org 101FF277h - shift	; 
register_level__bool__void:
org 1024166Ch - shift	; 
register_level__str__void:
org 10241B0Bh - shift	; 
register_level__vector__uint:

org 10512BDCh - shift
g_pGameLevel dd ?

org 105124F4h - shift
GetStaticVerts dd ?

org 1051252Ch - shift
GetStaticTris dd ?

org 102504E0h - shift	; Вычисления нормали
mknormal:

org 10512FE4h - shift
_ElementCenter dd ?

org 105B79A8h - shift
float_1 dd ?

org 10549C0Ch - shift
const_1e_7 dd ?

org 10514A0Ch - shift
const_minus dd ?

org 10634450h - shift
off_10634450 dd ?

org 106196A8h - shift
off_106196A8 dd ?

org 10512BF4h - shift
GetMaterialByIdx dd ?

org 10512BD4h - shift
GMLib dd ?

org 102C3260h - shift	; 5 bytes
	jmp		CWeapon__CallbackOnShoot
back_from_CWeapon__CallbackOnShoot:

;org 102D065Ch - shift	; 6 bytes
;	jmp		test_adr_weapon
;	nop
;back_from_test_adr_weapon:

org 10512BCCh - shift	; CRenderDevice Device
Device		dd ?
org 105127A0h - shift
r_string	dd ?
org 105127E8h - shift
pSettings	dd ?
org 1051292Ch - shift
r_bool		dd ?

org 102A57C0h - shift
script_callback_str_uint:
org 1032DBD0h - shift
script_callback_float_vector_int2:
org 1032E2D0h - shift
script_callback_float_vector_int:

; возможность использовать скрипты в мультиплеере (включение биндеров)
org 100C172Eh - shift	; 2 bytes
	nop
	nop

org 101EC1D3h - shift	; 5 bytes
	jmp		game_object_fix
back_from_game_object_fix:

org 101D3D20h - shift
register__bool__void:
org 101D3990h - shift
register__uint__void:
org 101D3F90h - shift
register__void__go:
org 101D3B70h - shift
register__float__void:
org 101D45C0h - shift
register__str__void:
org 101D3C60h - shift
register__void__float:
org 101D41D0h - shift
register__void__str_bool:
org 101D4500h - shift
register__bool__str:

; for game_object_castings.asm
org 1061842Ch - shift
off_1061842C:
org 10619C60h - shift
off_10619C60:
org 1062CD94h - shift
off_1062CD94:
org 1062CD38h - shift
off_1062CD38:
org 1062D2DCh - shift
off_1062D2DC:
org 10628D10h - shift
off_10628D10:
org 1062CD54h - shift
off_1062CD54:
org 1062CC74h - shift
off_1062CC74:
org 1061844Ch - shift
off_1061844C:
org 1062CC90h - shift
off_1062CC90:
org 10637320h - shift
off_10637320:
org 10635EF0h - shift
off_10635EF0:
org 106376D8h - shift
off_106376D8:
org 10637720h - shift
off_10637720:
org 10637748h - shift
off_10637748:
org 10636A7Ch - shift
off_10636A7C:
org 10637578h - shift
off_10637578:
org 10637590h - shift
off_10637590:
org 1062CD70h - shift
off_1062CD70:
org 10637380h - shift
off_10637380:
org 10637398h - shift
off_10637398:
org 106373B0h - shift
off_106373B0:
org 106375A8h - shift
off_106375A8:
org 1061AD4Ch - shift
off_1061AD4C:
org 106375C0h - shift
off_106375C0:

org 101D8378h - shift	; 5 bytes
	call	register__void__go

org 101C1887h - shift	; 7 bytes
	jmp		CScriptGameObject_explode_fix
	nop
	nop
back_from_CScriptGameObject_explode_fix:

org 1004B8B0h - shift
CVisualMemoryManager__object_luminocity:

org 10512BF0h - shift
ROS	dd ?

org 105127A4h - shift
line_exist	dd ?
org 10512BE0h - shift
H_Parent	dd ?
org 10513150h - shift
timeServer	dd ?
org 10514330h - shift
float_1e_3	dd ?
org 105127F0h - shift
r_float		dd ?
org 10512808h - shift
r_u32		dd ?

org 103483F0h - shift
smart_cast_CEntityAlive:
org 10348420h - shift
smart_cast_CWeapon:
org 10348450h - shift
smart_cast_CWeaponMagazined:
org 103483C0h - shift
smart_cast_IKinematics:
org 103486A0h - shift
smart_cast_CInventoryItem:

org 10512D10h - shift
IGame_Level__CurrentEntity dd ?

org 10512BE8h - shift
g_dedicated_server dd ?

org 10232E20h - shift
CLevel__IsServer:

org 10232E50h - shift
CLevel__IsClient:

org 10515A60h - shift
float_60 dd ?

org 102CE2E0h - shift	; 6 bytes
	call	CWeapon__Callback_SwitchMode
	nop
org 102CE340h - shift	; 6 bytes
	call	CWeapon__Callback_SwitchMode
	nop

; callback	UpdateAddonsVisibility
org 102BDB77h - shift	; 9 bytes
	jmp		UpdateAddonsVisibility_fix
back_from_UpdateAddonsVisibility_fix:
	pop		edi
	pop		esi
	pop		ebx
	retn
; callback	HUDUpdateAddonsVisibility
org 102BC34Bh - shift	; 6 bytes
	jmp		UpdateHUDAddonsVisibility_fix
	nop
back_from_UpdateHUDAddonsVisibility_fix:
org 102F97A0h - shift
CHudItem__HudItemData:

org 102F9C80h - shift
CHudItem__GetHUDmode:

;================================================================
; Возможность стрелять картечью из подствольного гранатомёта.
;================================================================
org 102D2C83h - shift	; 5 bytes
	call	shotgun_gl
; при дробовым патроне для ПГ ракета не спавнится.
org 102CC6F9h - shift	; 9 bytes
	jz		no_spawn_rocket
	add		eax, 10h
org 102CC877h - shift
no_spawn_rocket:

	
org 102C3080h - shift
CWeapon__FireTrace:
org 102D0350h - shift
CWeaponMagazined__state_Fire:
org 102D1350h - shift
CWeaponMagazinedWGrenade__OnShot:
org 102CC650h - shift
CRocketLauncher__getRocketCount:
org 102CC660h - shift
CRocketLauncher__getCurrentRocket:
org 102CC680h - shift
CRocketLauncher__dropCurrentRocket:
org 102C2D50h - shift
CWeapon__StartFlameParticles2:
org 102D3E40h - shift
CWeaponMagazinedWGrenade__Load:


org 105561CCh - shift
aGrenade_laun_0 dd ?
org 10556530h - shift
aAmmo_mag_size	dd ?
org 102BAE10h - shift
CShootingObject__LoadFireParams:
org 102CD470h - shift
CWeaponMagazined__switch2_Reload:
org 102CCD80h - shift
CWeaponMagazined__OnAnimationEnd:
;================================================================
iMagazineSize			= dword ptr 1684
iMagazineSize2			= dword ptr 2024
m_bGrenadeMode			= dword ptr 7F8h
; Подствольный гранатомёт: перезарядка параметров: подствол. - основной ствол.
org 102D3A52h - shift	; 5 bytes
	jmp		switshGL_params
back_from_switshGL_params:
; Подствольный гранатомёт: смена ракеты при смене типа боеприпаса.
org 102D1FE9h - shift	; 7 bytes
	jmp		reload_GL
	nop
	nop
back_from_reload_GL:
; Подствольный гранатомёт: блокируем перезарядку, если есть ещё патроны.
org 102D15A0h - shift	; 2 bytes
jnz     short loc_102D15D4
org 102D15B7h - shift	; 51 bytes
	cmp		byte ptr [esi+m_bGrenadeMode-2E0h], 0
	jz		loc_102D15D4 			; if (m_bGrenadeMode)
	cmp		byte ptr [esi+iAmmoElapsed-2E0h], 0
	jnz		loc_102D15D4			; if (iAmmoElapsed==0)
	mov		eax, [esi-2E0h]
	mov		edx, [eax+188h]
	lea		ecx, [esi-2E0h]
	call	edx				; CWeaponMagazined::Reload
loc_102D15D4:
	push	edi
	mov		ecx, esi
	call	CWeaponMagazined__OnAnimationEnd
	pop		edi
	pop		esi
	retn	4
	
; Подствольный гранатомёт: задаём размер магазина.
org 102D4063h - shift	; 12 bytes
	mov		ecx, edi
	call	load_param_GL
	nop
	nop
	nop
	nop
	nop
org 102D407Ch - shift	; 12 bytes
	mov		ecx, edi
	call	load_param_GL
	nop
	nop
	nop
	nop
	nop
; Подствольный гранатомёт: размер магазана.
org 102D3748h - shift	; 38 bytes
;	m_bGrenadeMode = !m_bGrenadeMode;
	xor		byte ptr [esi+m_bGrenadeMode], 1
	push	edi
	nop
	nop
	nop
	nop
	nop
	nop
;	swap(iMagazineSize2, iMagazineSize);
	mov		ecx, [esi+iMagazineSize]
	mov		eax, [esi+iMagazineSize2]
	mov		[esi+iMagazineSize2], ecx
	mov		[esi+iMagazineSize], eax


; колбек на удар ножа, вызывается в объекте ножа
org 102D73D2h - shift	; 7 bytes
	jmp		CWeaponKnife__CallbackOnShoot
	nop
	nop
back_from_CWeaponKnife__CallbackOnShoot:

; -------======== граната с ударным запалом ========-------
; (c) NanoBot
org 102C8268h - shift	; 17 bytes		//	void CMissile::UpdateCL()
	; if (m_actived_grn_udz)	CMissile__UDZ();
	mov		cl, byte ptr [esi+m_actived_grn_udz]
	test	cl, cl
	jnz		CMissile__UDZ
	nop
	nop
	nop

org 102C80E1h - shift	; 12 bytes		//	void CMissile::OnEvent(NET_Packet& P, u16 type)
	and		dword ptr [esi+394h], 0		; m_fake_missile &= 0;
	jmp		InitFakeMissile
back_from_InitFakeMissile:

; переопределяем адрес bool m_constpower с 3A8h на 33Dh, а на её место назначаем u32 m_dwSafetyLockTime
m_throw					= dword ptr 828
m_constpower			= dword ptr 829
m_actived_grn_udz		= dword ptr 830		; bool граната УДЗ активирована (без чеки)
m_bFlying				= dword ptr 831		; граната полетела
m_dwSafetyLockTime		= dword ptr 3A8h	; u32 время взвода ударного взрывателя, мс
m_fAccThreshold			= dword ptr 960
m_dwDelta				= dword ptr 964

org 102C6A10h - shift	; 6 bytes
	mov		byte ptr [esi+m_constpower], al
org 102C8D44h - shift	; 7 bytes
	cmp		byte ptr [ebx+m_constpower], 0
org 102C707Ch - shift	; 6 bytes
	mov		byte ptr [esi+m_constpower], cl
org 102C70D9h - shift	; 7 bytes
	mov		byte ptr [esi+m_constpower], 1
org 102C73EFh - shift	; 12 bytes
	mov		[esi+m_throw], eax		; обнуляем разом 4 булевы	m_throw = m_constpower = m_actived_grn_udz = m_bFlying = false;
	mov		eax, eax
	mov		eax, eax
	mov		eax, eax
;----------------------------------------------------------
; кумулятивный эффект
org 10301BF5h - shift	; 5 bytes
	jmp		cumulative_effect
back_from_cumulative_effect:

org 10300320h - shift
CExplosive__Initiator:
org 102C4B40h - shift
CCartridge__CCartridge:
org 102C4180h - shift
CCartridge__Load:
org 1024EF70h - shift
CBulletManager__AddBullet:

; стабилизированная ракета (ракета разворачивается по курсу)
org 102CA953h - shift	; 2 bytes
	jnz		short back_from_stabilized_rocket
org 102CA97Fh - shift	; 7 bytes
	jmp		stabilized_rocket
back_from_stabilized_rocket:
	pop		esi
	retn
org 102CA7F0h - shift
CCustomRocket__Contact:

org 102C7130h - shift	; 0 bytes
CMissile__ExitContactCallback:
;	mov		byte ptr [eax], 1
org 102CBCDEh - shift	; 5 bytes
	push	CMissile__ExitContactCallback
;	jmp		loc_102CBB25
;	nop
org 102CBB25h - shift
loc_102CBB25:
org 102CA968h - shift	; 23 bytes
	lea		eax, [esi+70h]
	push	eax
	lea		ecx, [esi+80h]
	push	ecx
	mov		ecx, esi
	call	CExplosiveRocket__Contact
	nop
	nop
	nop
	nop
	nop
org 102CBF90h - shift
CExplosiveRocket__Contact:

; блокировка автоперезарядки
m_iPrefferedFireMode	= dword ptr 1968
m_bAutoReload			= dword ptr 1973
; if (m_pInventory && !iAmmoElapsed && actor && GetState()!=eReload && m_bAutoReload) 
org 102CFFBEh - shift	; 60 bytes
	cmp		dword ptr [esi-2ACh], 0
	jz		short FireEnd_exit
	cmp		dword ptr [esi+358h], 0
	jnz		short FireEnd_exit
	test	eax, eax
	jz		short FireEnd_exit
	cmp		dword ptr [esi-54h], 7
	jz		short FireEnd_exit
	cmp		byte ptr [esi-824+m_bAutoReload], 1
	jnz		short FireEnd_exit
	mov		eax, [esi-338h]
	mov		edx, [eax+188h]
	lea		ecx, [esi-338h]
	pop		esi
	jmp		edx
FireEnd_exit:
	pop		esi
	retn
org 102CFE17h - shift	; 8 bytes
	jmp		LoadBoolAutoload
	nop
back_from_LoadBoolAutoload:
	test	edi, edi

org 1055AD10h - shift
aFake_grenade_n		dd ?
org 10001160h - shift
LPCSTR2shared_str:
org 102CC6D0h - shift
CRocketLauncher__SpawnRocket:

; for game_object_castings.asm
org 10637538h - shift
off_10637538:
org 1063779Ch - shift
off_1063779C:
org 106373E8h - shift
off_106373E8:
org 1063E6A8h - shift
off_1063E6A8:
org 10637B58h - shift
off_10637B58:

org 1051224Ch - shift
memmove		dd ?

;org 102D9703h - shift	; 5 bytes
;	push	offset aGrenadeAny
	
; При разрядке оружия ракеты удаляются.
org 102CF67Eh - shift	; 6 bytes
	jmp		unload_delete_rockets
	nop
back_from_unload_delete_rockets:
; Стрельба картечью из РГ-6
org 102DF6DDh - shift	; 39 bytes
	mov		ecx, ebp
	call	CWeaponMagazined__FireStart
	cmp		dword ptr [ebp-54h], 0
	jnz		loc_102DFBE5
	lea		ecx, [ebp-358h]
	call	CRocketLauncher__getRocketCount
	test	eax, eax
	jz		loc_102DFBE5
	push	ebx
	push	esi
	push	edi
org 102DFBE5h - shift
loc_102DFBE5:
org 102CFE50h - shift
CWeaponMagazined__FireStart:

; Реальные ракеты при заряжании. (Ракеты соотвествуют секции fake_grenade_name патрона)	CWeaponRPG7__ReloadMagazine
org 102D9452h - shift	; 5 bytes
	jmp		CWeaponRPG7__RealReloadRockets
org 102D9740h - shift	; 5 bytes
	jmp		CWeaponRPG7__RealReloadRockets2

;
org 101D3ED0h - shift
register__void__bool:
org 101D5EB0h - shift
register__bool__go:
org 101D4E00h - shift
register__void__go_str_pvector_float:

; Блокировка пуска ракет для класса CWeaponRPG7
org 102D9948h - shift	; 5 bytes
	call	BlockedRPG7

; Callback	CWeaponRPG7__UpdateMissileVisibility
org 102D9658h - shift	; 6 bytes
	jmp		Callback_UpdateMissileVisibility
	nop
back_from__Callback_UpdateMissileVisibility:

;
;org 102F07C0h - shift	; 3 bytes
;	retn	8

org 102F07C0h - shift
CUIArtefactDetectorElite__RegisterItemToDraw:
org 102FB430h - shift
HUD_SOUND_COLLECTION__LoadSound:
org 10512814h - shift
str_container__g_pStringContainer	dd ?
org 10512810h - shift
str_container__dock		dd ?
org 1056C2B4h - shift
aElite		dd ?

; Скриптовый детектор
org 102EC7F1h - shift	; 6 bytes
	jmp		CEliteDetectorLoadParam
	nop
back_from__CEliteDetectorLoadParam:
org 102F0BC8h - shift	; 6 bytes
	jmp		CEliteDetectorUpdateAfScriptExt
	nop
back_from__CEliteDetectorUpdateAfScriptExt:
org 102EF315h - shift	; 5 bytes
	jmp		CEliteDetector__ui_xml_tag_ext
