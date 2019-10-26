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

;.text:104AEA4E                 xor     eax, eax
;.text:104AEA50                 push    eax
;.text:104AEA51                 mov     eax, offset CUIScrollView__GetItem
;.text:104AEA56                 push    eax
;.text:104AEA57                 push    offset aGetitem ; "GetItem"
org 104AEA5Ch - shift
	jmp cuilistbox_fix1
;.text:104AEA5C                 xor     eax, eax
;.text:104AEA5E                 push    eax
;.text:104AEA5F                 mov     eax, offset sub_104A7B90
org 104AEA64h - shift
back_from_cuilistbox_fix1:
;.text:104AEA64                 push    eax
;.text:104AEA65                 push    offset aGetitembyindex ; "GetItemByIndex"


org 104AEAF3h - shift
	jmp cuilistbox_fix2
;.text:104AEAF3                 call    sub_104AE24D
;.text:104AEAF8                 mov     ecx, eax
org 104AEAFAh - shift
back_from_cuilistbox_fix2:
;.text:104AEAFA                 call    sub_104ADB26



org 100490C0h - shift
script_hit_callback:

; ������� smart_cast<CGameObject*>()
; ���� ���:
; ������� ������ "ph_capture_visuals"
; ������� ������ �� ������, �� ����� ���. 
; �� ��� �� �������, � ������� ���� ���� �������� - ��� CActor::shedule_Update(int dt).
; � ���� ������� ���� ��������� �������� (������� �������, �������� ����������):
;.text:10262968 loc_10262968:                           ; CODE XREF: CActor__shedule_Update+61Fj
;.text:10262968                 mov     eax, ds:?g_hud@@3PAVCCustomHUD@@A ; CCustomHUD * g_hud  <== ������� �������� - ��������������� �� dll �-�
;.text:1026296D                 mov     ecx, [eax]
;.text:1026296F                 call    sub_104AFE40
;.text:10262974                 xor     ebx, ebx
;.text:10262976                 cmp     [esi+900h], ebx
;.text:1026297C                 mov     ebp, eax
;.text:1026297E                 jnz     loc_10262C25
;.text:10262984                 mov     eax, [ebp+0]
;.text:10262987                 cmp     eax, ebx
;.text:10262989                 jz      loc_10262C25
;.text:1026298F                 test    dword ptr [eax+0A4h], 2000000h
;.text:10262999                 jz      loc_10262C25
;.text:1026299F                 movss   xmm0, ds:flt_105B7998
;.text:102629A7                 comiss  xmm0, dword ptr [ebp+4]
;.text:102629AB                 jbe     loc_10262C25
;.text:102629B1                 push    eax
;.text:102629B2                 call    sub_1007A4F0  <==   ��� ��� ������ - ��� � ���� ����� smart_cast<CGameObject*>
;.text:102629B7                 mov     [esi+510h], eax
;.text:102629BD                 mov     ecx, [ebp+0]
;.text:102629C0                 push    ecx
;.text:102629C1                 call    sub_1007A4F0  <==
;.text:102629C6                 mov     ebp, eax

org 1007A4F0h - shift
smart_cast_CGameObject: ; �� �������� ����� �� �����, ��������� � ������ ������ �� ������. 
; �������, ��� ����������� � �� ���������

; ���������� ��� ������ ����������� �� ����������� �� ������
;.text:101C7460 CScriptGameObject__DropItem proc near
; ������� ������� �� ����� � ������� �� ������ "drop_item"
; ...
;.text:101C749C                 test    esi, esi           <== ��� 4 ������ ��������� �������� �� 
;.text:101C749E                 jz      short loc_101C74F8 <== ��, ��� ������������ - ��� CInventoryOwner � 
;.text:101C74A0                 test    eax, eax           <== ������� - ��� CInventoryItem. ����� �� ��� �� ��� ��������,
;.text:101C74A2                 jz      short loc_101C74F8 <== ����� �� ����, ��� ��� �������� ���. �������� ������� ����.
;.text:101C74A4                 lea     ecx, [esp+4020h+var_4014]

org 101C749Ch - shift ; �� ������ �������� � ������ ������ (8 ����)
    nop ; test    esi, esi           ;2 �����
	nop
	nop ; jz      short loc_101C74F8 ;2 �����
	nop
	nop ; test    eax, eax
	nop
	nop ; jz      short loc_101C74F8
	nop
; �����: 0x101C74A4 - 0x101C749C = 0xA4 - 0x9C = 8 - ��������
	
;-----------< ����������� ����������� ������������ ��� >----------------------
; �������, ������� ������������ ���������� ���������� ������� � ����������:
; void fun(char*)
; ������ ��. ����
org 10222902h - shift 
error_log_register:

; �������, ������� ������������ ���������� ���������� ������� � ����������:
; void fun(void)
; ����� ���� ����� �� ������� �� ������ "flush"
org 102225EEh - shift
flush_register:

; ������� CScriptEngine::script_register
; ���� �� ������ �� ������ "error_log"

;.text:1022398C                 push    esi
;.text:1022398D                 call    sub_102225BB
;.text:10223992                 push    offset sub_102214A0
;.text:10223997                 push    offset aError_log ; "error_log"
;.text:1022399C                 push    esi
org 1022399Dh - shift
	jmp global_space_ext ; ������ � ����������� �������� - 5 ����
;.text:1022399D                 call    sub_10222902; error_log_register
org 102239A2h - shift
back_to_global_space_ext:
;.text:102239A2                 lea     eax, [ebp+var_1]


;--------------< ����������� ������������ ��� level >-------------------------

; ������� �������������� � ������������ ��� level ������� � ����������:
; game_object* fun(int);
; �������� ��� ������ ����� ������������
; ������������ ��� ����������� level.object_by_id. ���� �� ������ �� ������ "object_by_id". 
; ��� �����:

;.text:1024A74C                 push    offset loc_1023F5A0; <== ��� ���� ������� level.object_by_id   ����� �����
;.text:1024A751                 lea     eax, [ebp+var_8]
;.text:1024A754                 push    offset aObject_by_id ; "object_by_id"
;.text:1024A759                 push    eax
;.text:1024A75A                 call    sub_10241611; object_by_id_register <== ��� ��� �����
;.text:1024A75F                 add     esp, 18h

org 10241611h - shift
object_by_id_register: 

; ������� �������������� � ������������ ��� level ������� � ����������:
; float fun(void);
; ������ ��. ����
org 1024177Dh - shift
get_snd_volume_register: 

; ����� CLevel::script_register
; ���� �� ������ �� ������ "get_snd_volume"

; ������ ��������
;.text:1024A345                 push    offset aGet_snd_volume ; "get_snd_volume" - ���� ����� ��� �����������
;.text:1024A34A                 push    eax
org 1024A34Bh - shift
	jmp level_ns_extension_1
;.text:1024A34B                 call    sub_1024177D; ����������� get_snd_volume - ��. ����� ����
org 1024A350h - shift
back_to_level_ns_ext_1:
;.text:1024A350                 pop     ecx
;.text:1024A351                 pop     ecx
;.text:1024A352                 mov     eax, esp
;.text:1024A354                 push    offset loc_10243A00
;.text:1024A359                 push    offset aPhysics_world ; "physics_world"

; ������ ��������. ���������� ����� �� ������ � ������� �� ���������� �������� mov ecx, eax;   call esi;
; ���� �������� �������, ������� ���� ���� ����������� �������. ������, �� ������ ���� �������������
; ���� �������� �� ����� ����� ����.
;.text:1024A764                 call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
org 1024A766h - shift
	jmp level_ns_extension_2 ; ������ � ����������� �������� - 5 ����
;.text:1024A766                 mov     ecx, eax
;.text:1024A768                 call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
;.text:1024A76A                 mov     ecx, eax
;.text:1024A76C                 call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
org 1024A76Eh - shift
back_to_level_ns_ext_2: ; ���������� 8 ����, �������, ����� �������� 5 ���� ������
;.text:1024A76E                 mov     ecx, eax


;------------------------------------------------------------------------------
;void __thiscall CActor::HitSignal(CActor *this, float perc, _vector3<float> *vLocalDir, CObject* who, __int16 element)
; ��� �����: ���� � idata ������� � ������� ������� CBoneInstance::get_param
; ������� ��� ������ �� ��� �������. ���� ��� �������, �� ������� ��� �� ����� ������.
; � ����� �� ��� ������ ��� �� �������� +46h, �� ������ - �� �������� +379h. ������ ��� � �����.
; ������ �����, � ������ ������ �������� ����� ������� �������.

; �������� � ������ ���� �������. � ������ ������, ��� � ����� ��-�� ����������� �������� �����
; ���������� (�� ����� ������������ ��� ��������� ����������). ��� �������� ����������
; ������������ �������� �� ������� ������. ������ ����� ���������� ������. ��� ������
; � ������ ��� �� �������� ����� ���������.

org 10260120h - shift
	jmp CActor_HitSignal_ext
;.text:10260120                 xorps   xmm5, xmm5
;.text:10260123                 sub     esp, 0Ch
org 10260126h - shift
back_to_CActor_HitSignal:
;.text:10260126                 push    edi
;.text:10260127                 mov     edi, ecx
;.text:10260129                 mov     eax, [edi+200h]

; -----------------------------------------------------------------------------
; ����� ������ CGameObject, ������� ���������� ��� ���� ���������� ������ game_object
; ���������� ���, this ��������� ����� ecx
; ���� ���:
; ������� ������� ������� level.object_by_id (��. ���� ����� object_by_id_register)
; ����� � ���� ������� � ����� ����� �������:
;.text:1023F5CE                 mov     ecx, eax
;.text:1023F5D0                 jmp     sub_1027FD40 ; CGameObject__lua_game_object <== ��� ��� �����
org 1027FD40h - shift
CGameObject__lua_game_object:

org 10281920h - shift
CGameObject__callback:

;--------------< ����������� ������ CUIStatic >--------------------------------
; ����� ������ CUIStatic::SetTextureRect - cc���� ���� � ������ ��������� ����
org 1047B6E0h - shift
CUIStatic__SetTextureRect:

; ��������� ������� CUIStatic::::script_register
; ������� ���� �� ������ �� ������ "SetTextureRect"

; ---------- ������ ��������: ��������� ������� � ����
;.text:1047F4B0                 push    offset aSetstretchtext ; "SetStretchTexture"
org 1047F4B5h - shift
	jmp CUIStatic_extention_1 ; ������ � ����������� �������� - 5 ����
;.text:1047F4B5                 xor     eax, eax
;.text:1047F4B7                 push    eax
;.text:1047F4B8                 mov     eax, offset sub_1047B6E0; CUIStatic__SetTextureRect - ��. ����
;.text:1047F4BD                 push    eax
;.text:1047F4BE                 push    offset aSettexturerect ; "SetTextureRect"
org 1047F4C3h - shift
back_to_CUIStatic_ext_1:
;.text:1047F4C3                 push    [ebp+var_10]
;.text:1047F4C6                 mov     eax, offset sub_103F1DAF
;.text:1047F4CB                 push    eax

; ---------- ������ ��������: ���������� ������� ����������� � �������� �������
;.text:1047F4DF                 push    [ebp+var_C]
;.text:1047F4E2                 push    offset aCuistatic ; "CUIStatic"
;.text:1047F4E7                 lea     ecx, [ebp+var_34]
;.text:1047F4EA                 call    sub_1047D536    ; register class CUIStatic
;.text:1047F4EF                 mov     ecx, eax
;.text:1047F4F1                 call    sub_1047CF5A    ; register constructor CUIStatic()
;.text:1047F4F6                 mov     ecx, eax
;.text:1047F4F8                 call    sub_1047F2B1    ; TextControl
;.text:1047F4FD                 mov     ecx, eax
;.text:1047F4FF                 call    sub_1047EE96    ; InitTexture
org 1047F504h - shift
	jmp CUIStatic_extention_2 ; ������ � ����������� �������� - 5 ����
;.text:1047F504                 mov     ecx, eax
;.text:1047F506                 call    sub_1047EEC1    ; register SetTextureRect
org 1047F50Bh - shift
back_to_CUIStatic_ext_2:
;.text:1047F50B                 mov     ecx, eax

; ��������� ������� ��� ����������� ������� � ����������:
; void fun(CUIStatic* this, Frect* r)
; ����� ���� �� ������ ��������� ����
org 1047EEC1h - shift
SetTextureRect_register:

org 104AFE40h - shift
CCustomHUD__GetRQ:

; ���������� ������� get_rank �� ������� ���������� ��������� "'cannot find rank for ..."
; ��� �������, �� ����������� � mp_ranks
; ������, ���� ���� �� ������, ������� ����� ���������� ���� 0 
org 104CCC2Eh + 4 - shift ; � ������ ������ ������ 0x104CCC32 4
		 dword 00000000h ; ������ �������� ����������   mov     [esp+34h+var_24], 0FFFFFFFFh

; ������ �� �������� atexit
; ������������ ��� ������ ������������ � ����������� ��������
org 10509FD0h - shift
_atexit:

; void __cdecl CCC_RegisterCommands()
; ��� �����: ������� DllMain �� �������� � ������ ���������� ������� ����� ���
org 103349CDh - shift
CCC_RegisterCommands_part_0:
	;����
;.text:103349CD		mov     eax, 4000h
	;�����
	jmp		CCC_RegisterCommands_chunk_0
	
CCC_RegisterCommands_1:
;.text:103349D2		test    dword_1064FB44, eax
;.text:103349D8		jnz     short loc_10334A0D

; void __cdecl InventoryUtilities::SendInfoToActor(const char info_portion)
; ��� �����: ���� ������� "ui_pda_hide", ��������� �� ������ �� ���, ������� �� ��� ���������
; ��� ����� ���-�� ����:
;.text:10442B5E		push    offset aUi_pda_hide ; "ui_pda_hide"
;.text:10442B63		call    sub_10466290 <= ��� � ���� ������ ������� InventoryUtilities__SendInfoToActor
org 10466290h - shift
InventoryUtilities__SendInfoToActor:

; void __thiscall CUIPdaWnd::SetActiveSubdialog(CUIPdaWnd *this, EPdaTabs section)
;��� �����: ���� ������ "CUIPdaWnd::SetActiveSubdialog" - �������, � ������� ��� ������������, � ���� ������
;.text:104428B0     CUIPdaWnd__SetActiveSubdialog proc near 
;.text:104428B0     section         = dword ptr  4
;.text:104428B0
;.text:104428B0		push    esi
;.text:104428B1		mov     esi, ecx
;.text:104428B3		mov     eax, [esi+7Ch]
;.text:104428B6		push    edi
;.text:104428B7		mov     edi, [esp+8+section]
org 104428BBh - shift
CUIPdaWnd__SetActiveSubdialog_ext:
	;����
;.text:104428BB		cmp     eax, [edi]
;.text:104428BD		jz      loc_104429F8
	;�����
	jmp		CUIPdaWnd__SetActiveSubdialog_chunk
	nop
	nop
	nop
	
CUIPdaWnd__SetActiveSubdialog_1:	
;.text:104428C3		mov     eax, [esi+78h]
;.text:104428C6 	test    eax, eax

;������ �� ��������
org 10509D9Ah - shift
__RTDynamicCast:
;.text:10509D9A                 jmp     ds:__imp___RTDynamicCast

org 1026F8C0h - shift
CActor__SetWeaponHideState:

; public: void __thiscall CPHMovementControl::DestroyCharacter(void)
org 104FE590h - shift
CPHMovementControl__DestroyCharacter:

; protected: bool __thiscall CActor::use_Vehicle(class CHolderCustom *)
org 10278B8Ah - shift
CActor__use_Vehicle_part:
    ;����
;.text:10278B8A                 mov     dword ptr [esi+540h], 0
	;�����
	jmp		CActor__use_Vehicle_chunk_1
	nop
	nop
	nop
	nop
	nop
	
loc_10278B94:
;.text:10278B94                 pop     edi
;.text:10278B95                 mov     al, 1
;.text:10278B97                 pop     esi
;.text:10278B98                 add     esp, 0Ch
;.text:10278B9B                 retn    4

; public: void __thiscall CScriptGameObject::UnloadMagazine(void)
;��� �����: ���� ������ "unload_magazine" gjgflftv yf rjl dblf^
;.text:101EDED1                 push    offset aUnload_magazin ; "unload_magazine"
;.text:101EDED6                 mov     ecx, eax
;.text:101EDED8                 mov     [esp+64h+var_38], offset sub_101c97c0 ; <<< ������� �������
;.text:101EDEE0                 call    sub_101D4350
org 101C9835h - shift
CScriptGameObject__UnloadMagazine_part:
push    1


;==============================================================================
; ������ �� ������ �� ������ "li_pause_key"
;.text:10237540 CLevel__IR_OnKeyboardPress proc near    ; DATA XREF: .rdata:1054857Co
;.text:10237540                 mov     eax, ds:?Device@@3VCRenderDevice@@A ; CRenderDevice Device
org 10237545h - shift
	jmp level_input_fix
;.text:10237545                 sub     esp, 410h
org 1023754Bh - shift
back_from_level_input_fix:
;.text:1023754B                 cmp     dword ptr [eax+0Ch], 0


org 103065C0h - shift
script_callback_int_int: ; this - � ecx, ��� ��������� � �����

org 1026A790h - shift
Actor:

;===================| ������ .idata  |=========================================
; ������ �� ������ � ���� Names IDA
org 10512558h - shift
FlushLog dword ? ; void __cdecl FlushLog(void)
org 10512820h - shift 
Msg      dword ? ; void __cdecl Msg(char const *, ...)
org 10512D30h - shift
g_hud    dword ? ; class CCustomHUD * g_hud
org 10512B0Ch - shift
_CCC_Float_	dd ? ; public: __thiscall CCC_Float::CCC_Float(char const *, float *, float, float)
org 10512AF4h - shift
_1CCC_Float_	dd ?  ; public: virtual __thiscall CCC_Float::~CCC_Float(void)
org 10512DB8h - shift
_Console_	dd ?  ; class CConsole * Console
org 10513264h - shift
_phTimefactor_	dd ? ; float phTimefactor
org 1062CD54h - shift
_R0_AVCCar dd ?  ; class CCar `RTTI Type Descriptor'
org 1062D130h - shift
_R0_AVCHolderCustom	dd ?  ; class CHolderCustom `RTTI Type Descriptor'
org 10512258h - shift
__imp___RTDynamicCast dd ? ; __imp___RTDynamicCast

;===================| ������ .data  |=========================================
;������� ��������� � ����� 2947, � ����� ������ � ����������� �������� COP
org 10635C44h - shift
g_fov dd ?
org 1064EA60h - shift
INV_STATE_CAR	 dw ?	; unsigned int INV_STATE_CAR


org 1064E2C0h - shift
g_Actor  dd ?

; ������� �������������� � ������������ ��� level ������� � ����������:
; int fun(void)
org 1024199Fh - shift
get_time_days_register: 

; ������� �������������� � ������������ ��� level ������� � ����������:
; void fun(float)
org 1024188Eh - shift
set_snd_volume_register: 

