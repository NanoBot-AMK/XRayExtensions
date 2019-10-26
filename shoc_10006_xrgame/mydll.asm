.686
.XMM

.model flat,  C

include addr.inc
_CODE segment para public 'CODE' use32
	assume cs:_CODE
	assume ds:_CODE
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP
; ������� �� ������� ����
include xrgame_stubs.asm

ALIGN_8 MACRO
	;ALIGN 8
ENDM

PRINT MACRO msg_txt:REQ
LOCAL lab1_
LOCAL a_msg
	jmp     lab1_
a_msg db msg_txt, 0
lab1_:
	pusha
	push    offset a_msg
	call    Msg
	add     esp, 04h
	popa
ENDM

PRINT_UINT MACRO fmt_txt:REQ, val:REQ
LOCAL lab1_
LOCAL a_msg
	jmp     lab1_
a_msg db fmt_txt, 0
lab1_:
	pusha
	push    val
	push    offset a_msg
	call    Msg
	add     esp, 08h
	popa
ENDM

PRINT_FLOAT MACRO fmt_txt:REQ, val:REQ
LOCAL lab1_
LOCAL a_msg
LOCAL value1
	jmp     lab1_
a_msg db fmt_txt, 0
value1 dd ?
lab1_:
	pusha
	mov     [value1], val
	sub     esp, 8
	fld     [value1]
	fstp    QWORD ptr [esp]
	push    offset a_msg
	call    Msg
	add     esp, 0Ch
	
	popa
ENDM

FLUSH_LOG MACRO
	pusha
	call    [FlushLog]
	popa
ENDM

RT_DYNAMIC_CAST MACRO source, dest, reg
	push    0
	push    offset dest
	push    offset source
	push    0
	push    reg
	call    __RTDynamicCast
	add     esp, 14h
ENDM

; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

include types.asm
include defines.asm
include actor_input_fix.asm
include global_ns_fix.asm
include global_ns_fix2.asm
include game_object_fix.asm
include game_object_castings.asm
include actor_hit_callback.asm
include hit_memory_manager_fix.asm
include actor_inventory_callbacks.asm
include alife_simulator_fix.asm
include weapon_fix.asm
include console_commands_reg_fix.asm
include CInventory_fix.asm
include inventory_box_fix.asm
include	level_ns_fix.asm
include car_fix.asm
include cuiwindow_fix.asm
include ctime_fix.asm
include matrix_fix.asm
include monster_movement_manager_fix.asm
include alife_smart_terrain_task_fix.asm
include debug_fixes.asm
include cuitradewnd_fix.asm
include actor_input_fix_pda.asm
include cuipdawnd_fix.asm
include cuistatic_add.asm
include misc.asm
include inventory_item_fix.asm
include projector_fix.asm
include ammo_on_belt_fix.asm
include weapon_stat_mgun_fix.asm
include stalker_fix.asm
include hanging_lamp_fix.asm
include CEffectorZoomInertion_fix.asm
include new_engine_slots.asm
include car_camera_fix.asm
include game_cl_GameState_fix.asm
include actor_shadow_fix.asm
include mouse_wheel_slot_fix.asm
include cuilistwnd_fix.asm
include CUICustomEdit_fix.asm
include cuitrackbar_fix.asm
include controller_fix.asm
include cuicombobox_fix.asm
include cuioptionsitem_fix.asm
include game_object_callbacks.asm
include collide_fix.asm
include no_weapon_fix.asm
include cuitalkwnd_fix.asm
include CSE_Abstract_fix.asm
include CSE_ALifeObject_fix.asm
include xrServer_fix.asm
include CUIInventoryCellItem_fix.asm
include cuicarbodywnd_fix.asm
include cuistatic_fix.asm
include create_cell_item_fix.asm
include CUICursor_fix.asm
include cuicharacterinfo_initcharacter_fix.asm
include cuiwpnparams_check_fix.asm
include armor_piercing_fix.asm
include game_object_destructor_fix.asm
include customzone_fix.asm
include actor_torch_light.asm
include carbody_scroll_fix.asm
include anims_name_fix.asm
include critical_hit_anim_fix.asm
include widescreen_fixes.asm
include game_graph_distance_fix.asm
include actor_visual_fix.asm
include quicksave_fix.asm
include relations_fix.asm
include zoom_factor_fix.asm
include art_activation_fix.asm
include self_anim_stalker.asm

_CODE ENDS

end LibMain

