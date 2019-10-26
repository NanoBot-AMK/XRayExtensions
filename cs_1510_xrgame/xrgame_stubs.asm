;*******************************************************************************
; S.T.A.L.K.E.R data stubs
;*******************************************************************************

org 1032A8BCh - shift
CUIWindow__Show: ; this � ECX

org 101E0BF1h - shift
register_level_disable_input: ; ����������� � ������������ ��� level ������� � ���������� void fun(void)

org 101A5207h - shift
register_is_wfx_playing: ; ����������� � ������������ ��� level ������� � ���������� bool fun(void)

org 1017AA30h - shift
register__object_count: ; ����������� ������ game_object ��� ����������, ������������ int


org 1017B4F0h - shift
register_sound_prefix:  ; ����������� ������ game_object � ���������� void fun(string* s)

org 1004EFE0h - shift
xr_string__assign_operator:



;.text:1042EB51                 mov     byte ptr [ecx+4], 1
org 1042EB51h - shift
	nop
	nop
	nop
	nop

;.text:104316DE                 mov     byte ptr [esi+4], 1
org 104316DEh - shift
	nop
	nop
	nop
	nop

;.text:10438809                 mov     byte ptr [eax+4], 0
org 10438809h - shift
	nop
	nop
	nop
	nop

;.text:1043C994                 mov     byte ptr [eax+4], 1
org 1043C994h - shift
	nop
	nop
	nop
	nop
	
; ��������� ���������. � ��������� ���� ���� ������ ���������, �� �� ��������� ���-�� �������������� � true
; ��� ��� ������ ���� � ������ ������ � ������� ���������

;.text:10438A10 CUIActorMenu__Draw proc near
;...
;.text:10438A30                 mov     esi, [eax+1564h]
org 10438A36h - shift
	jmp minimap_draw_fix
;.text:10438A36                 cmp     byte ptr [esi+4], 0 ; <== ��� ����
;.text:10438A3A                 jz      short loc_10438A69
org 10438A3Ch - shift
back_from_minimap_draw_fix__draw_minimap:
;.text:10438A3C                 mov     edx, [esi+3D8h]
;...
;.text:10438A69
;.text:10438A69 loc_10438A69:    
org 10438A69h - shift
back_from_minimap_draw_fix__skip_minimap_drawing:
;.text:10438A69                 mov     ecx, [edi+0A0h]



; ���������� ������� get_rank �� ������� ���������� ��������� "'cannot find rank for ..."
; ��� �������, �� ����������� � mp_ranks
; ������, ���� ���� �� ������, ������� ����� ���������� ���� 0 

;var_24          = dword ptr -24h

;.text:104A2DCC                 push    edi
;.text:104A2DCD                 mov     [esp+30h+var_24], 0FFFFFFFFh
org 104A2DCDh - shift ; 8 ����
	mov     dword ptr [esp+30h +(-24h)], 0h
;.text:104A2DD5                 jz      short loc_104A2DDD

; -----------< ������ ������������� ���������� ����� �� ����� >--------------------------
; ������ � ������� CCustomOutfit::Load
;.text:10284535                 mov     [esi+32Ch], eax
;.text:1028453B                 mov     eax, 5 <== ����
org 1028453Bh - shift ; �� ������ ������ � ������ ���������� 5 ����
	mov     eax, 10  ; <== �����
;.text:10284540                 cmp     [esi+32Ch], eax

; ������ � ������� CCustomOutfit::Load
;.text:102850A7                 add     esp, 8
;.text:102850AA                 cmp     dword ptr [ebx], 5  <== ����
org 102850AAh - shift  ; 3 �����
	cmp     dword ptr [ebx], 10 ;  <== �����
;.text:102850AD                 mov     al, cl
;.text:102850AF                 jbe     short loc_102850B7
;.text:102850B1                 mov     dword ptr [ebx], 5  <== ����
org 102850B1h - shift  ; 3 �����
	mov     dword ptr [ebx], 10 ;  <== �����



;-----------< ����������� ����������� ������������ ��� >----------------------
; �������, ������� ������������ ���������� ���������� ������� � ����������:
; void fun(char*)
; ������ ��. ����
org 101C2788h - shift 
error_log_register:

; �������, ������� ������������ ���������� ���������� ������� � ����������:
; void fun(void)
; ����� ���� ����� �� ������� �� ������ "flush"
org 101C27F0h - shift
flush_register:

; ������� CScriptEngine::script_register
; ���� �� ������ �� ������ "error_log"

;.text:101C26AA                 push    offset aError_log ; "error_log"
;.text:101C26AF                 push    esi
;.text:101C26B0                 mov     eax, offset sub_101C22C0
org 101C26B5h - shift
	jmp global_space_ext ; ������ � ����������� �������� - 5 ����
;.text:101C26B5                 call    sub_101C2788 ; ��� ����
back_to_global_space_ext:
;.text:101C26BA                 push    offset aFlush   ; "flush"
;.text:101C26BF                 push    esi
;.text:101C26C0                 mov     eax, offset nullsub_2
;.text:101C26C5                 call    sub_101C27F0

;--------------< ����������� ������������ ��� level >-------------------------
; ������� �������������� � ������������ ��� level ������� � ����������:
; float fun(void);
; ������ ��. ����
org 101E0589h - shift
get_snd_volume_register: 

org 101E0517h - shift
register_set_snd_volume:



; ������� ����������� ��� object_by_id. � ���������, ������������ ��������������� � ������
; �.�. ����������� ������� �������� ����������
org 101E0375h - shift
object_by_id_register:
; ����� CLevel::script_register
; ���� �� ������ �� ������ "get_snd_volume"

; ������ ��������

;.text:101DFA85                 call    sub_101E0517
;.text:101DFA8A                 add     esp, 0Ch
;.text:101DFA8D                 mov     eax, esp
;.text:101DFA8F                 push    offset loc_101DF250
;.text:101DFA94                 push    offset aGet_snd_volume ; "get_snd_volume"
;.text:101DFA99                 push    eax
org 101DFA9Ah - shift
	jmp level_ns_extension_1
;.text:101DFA9A                 call    sub_101E0589 ; get_snd_volume_register
;.text:101DFA9F                 pop     ecx
;.text:101DFAA0                 pop     ecx
org 101DFAA1h - shift
back_to_level_ns_ext_1: 
;.text:101DFAA1                 mov     eax, esp



; ������ ��������. ���������� ����� �� ������ � ������� �� ���������� �������� mov ecx, eax;   call esi;
; ���� �������� �������, ������� ���� ���� ����������� �������. ������, �� ������ ���� �������������
; ���� �������� �� ����� ����� ����.

;.text:101DFDCA                 call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
org 101DFDCCh - shift
	jmp level_ns_extension_2 ; ������ � ����������� �������� - 5 ����
;.text:101DFDCC                 mov     ecx, eax
;.text:101DFDCE                 call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
;.text:101DFDD0                 mov     ecx, eax
;.text:101DFDD2                 call    esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
org 101DFDD4h - shift
back_to_level_ns_ext_2: ; ���������� 8 ����, �������, ����� �������� 5 ���� ������
;.text:101DFDD4                 mov     ecx, eax


;==============================================================================
; ������ �� ������ �� ������ "li_pause_key"
;.text:101D8690 CLevel__IR_OnKeyboardPress proc near    ; DATA XREF: .rdata:1050DD88o
;.text:101D8690
org 101D8690h - shift
	jmp call_key_press_callback
;.text:101D8690                 push    ebp
;.text:101D8691                 mov     ebp, esp
;.text:101D8693                 and     esp, 0FFFFFFF8h
org 101D8696h - shift
back_from_key_press_callback:
;.text:101D8696                 mov     eax, ds:?Device@@3VCRenderDevice@@A ; CRenderDevice Device

org 10003F70h - shift
luabind__functor_void_:  ; int __cdecl luabind__functor<void>()
org 1005A6D0h - shift
ai___script_engine___functor:
org 101CF2C0h - shift
functor__operator_call:
org 1007B650h - shift
unref:


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

org 101FA960h - shift
	jmp CActor_HitSignal_ext
;.text:101FA960                 sub     esp, 0Ch
;.text:101FA963                 push    edi
;.text:101FA964                 mov     edi, ecx
org 101FA966h - shift
back_to_CActor_HitSignal:
;.text:101FA966                 mov     eax, [edi+200h]
;.text:101FA96C                 movss   xmm0, dword ptr [eax+4]
;.text:101FA971                 comiss  xmm0, ds:dword_104DF078

; -----------------------------------------------------------------------------
; ����� ������ CGameObject, ������� ���������� ��� ���� ���������� ������ game_object
; ���������� ���, this ��������� ����� ecx
; ���� ���:
; ������� ������� ������� level.object_by_id (��. ���� ����� object_by_id_register)
; ����� � ���� ������� � ����� ����� �������:
;.text:1023F5CE                 mov     ecx, eax
;.text:1023F5D0                 jmp     sub_1027FD40 ; CGameObject__lua_game_object <== ��� ��� �����

org 1021B240h - shift
CGameObject__lua_game_object:

; -----------------------------------------------------------------------------
; ������� ��� ������ ������� �� ���
; ���� � ������� 
;org 1021BA10h - shift
;CGameObject__callback_helper:
org 1021B5D0h - shift
CGameObject__callback:


org 10012E90h - shift
script_hit_callback:
org 10293250h - shift
script_callback_int_int:

org 10205510h - shift
Actor:

;-----------------<����� ������� ����������� game_object>----------------------------------------
;.text:10178D57                 call    sub_1017AD30
;.text:10178D5C                 mov     byte ptr [esp+80h+arg_0], bl
;.text:10178D63                 mov     ecx, [esp+80h+arg_0]
;.text:10178D6A                 push    ecx
;.text:10178D6B                 mov     byte ptr [esp+84h+var_68], bl
;.text:10178D6F                 mov     edx, [esp+84h+var_68]
;.text:10178D73                 push    edx
;.text:10178D74                 lea     ecx, [esp+88h+var_6C]
;.text:10178D78                 push    ecx
;.text:10178D79                 push    offset aGet_corpse ; "get_corpse"
;.text:10178D7E                 push    eax
;.text:10178D7F                 mov     [esp+94h+var_6C], offset sub_1016FCC0
org 10178D87h - shift
jmp game_object_fix
;.text:10178D87                 call    sub_1017AD30  <== ��� ��������
back_from_game_object_fix: ; jmp ����� ����� �� ������ ��� � call

org 1017AD30h - shift
get_corpse_registration:


; void __thiscall CActor__IR_OnMouseMove(int *this, int d_x, int d_y)
; ������ �� ������ �� ���������� ���������� psMouseSensScale. ������ ���� 4 �����.
; ������� � ����� ������� ��������� �� ������ - ����.
;.text:102140A0 CActor__IR_OnMouseMove proc near        ; DATA XREF: .rdata:10510654o
;.text:102140A0                 push    ecx
;.text:102140A1                 cmp     hud_adj_mode, 0 <== ����� ���������, �� �������� ��� ����� �������� jmp
;.text:102140A8                 push    esi
;.text:102140A9                 mov     esi, ecx
;.text:102140AB                 jnz     loc_10214247

; ���� ���������� g_bDisableAllInput. ��� ������������ � ���������� �������� enable_input � disable_input
; ��� ������� ���������� ����� �����, ��� ����� �� ������ ���������, ���������� ��������� ��������
; ���� ����������
; ����� �� ������� �� ��� ���������� ���� ������� 
; CLevel::IR_OnKeyboardRelease
; CLevel::IR_OnKeyboardHold
; CLevel::IR_OnMouseWheel
; CLevel::IR_OnMouseMove
; CLevel::IR_OnKeyboardPress ������ ���� ��� ������� �����
; ��� �� �������� ���� �� ������:
; � CLevel::IR_OnMouseWheel, CLevel::IR_OnMouseMove � CLevel::IR_OnKeyboardHold ������ �� g_bDisableAllInput
; ����� � ����� ������, ����� ������� (������� ����������) ��������� CLevel::IR_OnKeyboardRelease
; CLevel::IR_OnMouseMove ��� �������������� ������� ����� ��� ���������, � ��������� �� ������
; ����� �������� CLevel::IR_OnMouseWheel �� CLevel::IR_OnKeyboardHold ���� ����� 
; ������� get_binded_action. ��� �������������� ��� ������ dik_to_bind. ���� ������ �� ��� ������
; � ����� ������ �� �������, � ������� ���������� get_binded_action. ������ �������, � ����� �� ���� 
; ������� ������� ������ ��  get_binded_action.
; ��� ����� CLevel::IR_OnKeyboardHold.  �� ��� �������� - ��� CLevel::IR_OnMouseWheel

; void __thiscall CLevel__IR_OnKeyboardRelease(int *this, int key)
;.text:101D8B10 CLevel__IR_OnKeyboardRelease proc near  ; DATA XREF: .rdata:1050DD8Co
org 101D8B10h - shift
jmp call_key_release_callback
;.text:101D8B10                 push    ecx
;.text:101D8B11                 push    ebx
;.text:101D8B12                 push    ebp
;.text:101D8B13                 mov     ebp, ecx
org 101D8B15h - shift
back_from_key_release_callback:
;.text:101D8B15                 cmp     dword ptr [ebp+400F4h], 0

; void __thiscall CLevel__IR_OnKeyboardHold(int *this, int key)
;.text:101D8C40 CLevel__IR_OnKeyboardHold proc near     ; DATA XREF: .rdata:1050DD90o
;.text:101D8C40                 cmp     g_bDisableAllInput, 0
;.text:101D8C47                 push    edi
;.text:101D8C48                 mov     edi, ecx
;.text:101D8C4A                 jnz     loc_101D8D41
org 101D8C50h - shift
jmp call_key_hold_callback
;.text:101D8C50                 cmp     dword ptr [edi+400F4h], 0
org 101D8C57h - shift
back_from_key_hold_callback:
;.text:101D8C57                 push    ebx

; void __thiscall CLevel__IR_OnMouseWheel(int *this, int direction)
;.text:101D84A0 CLevel__IR_OnMouseWheel proc near       ; DATA XREF: .rdata:1050DD7Co
;.text:101D84A0                 cmp     g_bDisableAllInput, 0
;.text:101D84A7                 push    ebx
;.text:101D84A8                 mov     ebx, ecx
;.text:101D84AA                 jnz     loc_101D8561
;.text:101D84B0                 mov     eax, ds:?g_pGameLevel@@3PAVIGame_Level@@A ; IGame_Level * g_pGameLevel
org 101D84B5h - shift
jmp call_mouse_wheel_callback
;.text:101D84B5                 mov     ecx, [eax]
;.text:101D84B7                 mov     ecx, [ecx+40104h]
org 101D84BDh - shift
back_from_mouse_wheel_callback:
;.text:101D84BD                 mov     edx, [ecx]
;.text:101D84BF                 mov     eax, [edx+18h]

; void __thiscall CLevel__IR_OnMouseMove(int *this, int d_x, int d_y)
;.text:101D85D0 CLevel__IR_OnMouseMove proc near        ; DATA XREF: .rdata:1050DD80o
;.text:101D85D0                 cmp     g_bDisableAllInput, 0
;.text:101D85D7                 push    ebp
;.text:101D85D8                 mov     ebp, ecx
;.text:101D85DA                 jnz     loc_101D8682
org 101D85E0h - shift
jmp call_mouse_move_callback
;.text:101D85E0                 mov     ecx, [ebp+400F4h]
;.text:101D85E6                 mov     eax, [ecx]
org 101D85E8h - shift
back_from_mouse_move_callback:
;.text:101D85E8                 mov     edx, [eax+18h]

org 101AE777h - shift
dik_to_bind_register:

org 101C2858h - shift
bit_and_register:


;.text:10455487                 push    ecx
;.text:10455488                 push    offset aSetwndpos ; "SetWndPos"     // 1

org 1045548Dh - shift
jmp cuiwindow_fix
;.text:1045548D                 push    eax
;.text:1045548E                 call    sub_10455AAC                        // [1]  SetWndPos + SetWndSize
;.text:10455493                 pop     ecx
org 10455494h - shift
back_from_cuiwindow_fix:
;.text:10455494                 push    eax
;.text:10455495                 call    sub_10455AAC                        // [1]
;.text:1045549A                 pop     ecx


org 10455AACh - shift
SetWndPos_register:

org 10455AD7h - shift
GetWidth_register:


;*(_BYTE *)(*(_DWORD *)(*((_DWORD *)&g_pGamePersistent + 329) + 340) + 4) = 1; ��������� ������� �������
;.text:1040D88F                 mov     edx, ds:?g_pGamePersistent@@3PAVIGame_Persistent@@A ; IGame_Persistent * g_pGamePersistent
;.text:1040D895                 mov     eax, [edx]
;.text:1040D897                 mov     ecx, [eax+524h] ; ui_core
;.text:1040D89D                 mov     edx, [ecx+154h] ; CUICursor
;.text:1040D8A3                 mov     byte ptr [edx+4], 1

; ��� ������

org 1016F760h - shift
CScriptGameObject__get_car:

org 1017A440h - shift
register_get_bleeding:

org 1017AEB0h - shift
register_set_actor_direction:


org 1017A730h - shift
position_register:

; CActor__IR_OnMouseMove
;.text:1021414B                 mov     edx, ds:?psMouseSensScale@@3MA ; float psMouseSensScale
;.text:10214151                 fmul    ds:_1_fov
org 10214151h - shift ; 6 ����
CActor__IR_OnMouseMove_fix1 proc
	;fmul   ds:writable_1_fov
	fdiv  g_fov
;CActor__IR_OnMouseMove_fix1 dd 	offset g_fov
	;adr1 dd dword ptr [g_fov]
;.text:10214157                 mov     eax, ds:?psMouseSens@@3MA ; float psMouseSens
CActor__IR_OnMouseMove_fix1 endp

; CCar__OnMouseMove
;.text:102AF548                 movss   xmm0, dword ptr [esi+70h]
;.text:102AF54D                 mulss   xmm0, ds:_1_fov
org 102AF54Dh - shift ; 8 ����
CCar__OnMouseMove_fix1:
	;mulss   xmm0, ds:writable_1_fov
	divss   xmm0, ds:g_fov
;.text:102AF555                 mov     ecx, ds:?psMouseSensScale@@3MA ; float psMouseSensScale

;CSpectator__IR_OnMouseMove
;.text:102C3063                 movss   xmm0, dword ptr [edx+70h]
;.text:102C3068                 mulss   xmm0, ds:_1_fov
org 102C3068h - shift ; 8 ����
CSpectator__IR_OnMouseMove_fix1:
	;mulss   xmm0, ds:writable_1_fov
	divss   xmm0, ds:g_fov
;.text:102C3070                 mulss   xmm0, dword ptr [eax]


;===================| ������ .idata  |=========================================
; ������ �� ������ � ���� Names IDA
org 104DAC68h - shift
g_pGameLevel dword ? ; CLevel* g_pGameLevel
org 104DAA94h - shift
FlushLog dword ? ; void __cdecl FlushLog(void)
org 104DAA44h - shift 
Msg      dword ? ; void __cdecl Msg(char const *, ...)

org 104DACB4h - shift
g_pGamePersistent dword ? 



;===================| ������ .rdata  |=========================================
org 104DAFC8h - shift
CEnvironment_SetGameTime dword ? ;CEnvironment::SetGameTime(float time, float factor)
org 104DB014h - shift
g_hud    dword ? ; class CCustomHUD * g_hud


;===================| ������ .data  |=========================================
;������� ��������� � ����� 2947, � ����� ������ � ����������� �������� ������

org 10606334h - shift
g_actor         dword ?

org 10605650h - shift
g_key_bindings  dd ?



org 10606320h - shift
g_bDisableAllInput db ?

org 105DB958h - shift
phTimefactor    dd 1.0 ; ������ ���� � ������� CLevel::Send, ������� 
; ������ �� ������ ���������������� ������ Send@IPureClient. ������� ���������, ���� ����� ����������
; ����������, ������� ������������� �������� 1.0



org 1056FFB0h - shift
g_1_fov          dd ?
org 105DC8F8h - shift
g_fov            dd ?



;==============| ����������� ������� ��� item_in_slot_registration |===========
org 104DA69Ch - shift
??1overload_rep@detail@luabind@@QAE@XZ dd ?
org 104DA674h - shift
?add_method@class_base@detail@luabind@@QAEXPBDABUoverload_rep@23@@Z dd ?
org 104DA6D0h - shift
?allocator@luabind@@3P6APAXPAXPBXI@ZA dd ?
org 104DA6CCh - shift
?allocator_parameter@luabind@@3PAXA dd ?
org 104DA684h - shift
?set_fun@overload_rep@detail@luabind@@QAEXABV?$function1@HPAUlua_State@@V?$memory_allocator@Vfunction_base@boost@@@luabind@@@boost@@@Z dd ?
org 104DA6C4h - shift
?set_match_fun@overload_rep_base@detail@luabind@@QAEXABV?$function1@HPAUlua_State@@V?$memory_allocator@Vfunction_base@boost@@@luabind@@@boost@@@Z dd ?
org 101814B0h - shift
loc_101814B0:
org 100DF320h - shift
sub_100DF320:
org 10181110h - shift
sub_10181110:
org 10181BE0h - shift
sub_10181BE0:
org 10181C20h - shift
sub_10181C20:
