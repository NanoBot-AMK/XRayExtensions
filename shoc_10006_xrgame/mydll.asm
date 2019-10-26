.686
.XMM

.model flat,  stdcall
option casemap:none

include addr.inc


.code
; заглушка для линковшика
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

;;___INSTRUCTION__SSE3	equ <> 

calc_bullet							PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
calc_future_position				PROTO :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
;
CBulletManager@@CreateExplosive 	PROTO :DWORD, :DWORD
CBulletManager@@Explode				PROTO :DWORD, :DWORD, :DWORD, :DWORD
CBulletManager@@DeleteExplosive 	PROTO :DWORD
CBulletExplosive@@ExplodeParams		PROTO :DWORD, :DWORD
CBaseMonster@@SetVisualName			PROTO NewVisual:dword
CAI_Stalker@@SetVisualName			PROTO NewVisual:dword
CEntity@@SetVisualName				PROTO NewVisual:dword
CGameObject@@GetTexture				PROTO n_child:dword, n_texture:dword
CGameObject@@Get_ref_texture		PROTO n_child:dword, n_texture:dword
;calc_bullet							PROTO (byte) pos_start:ptr, pos_target:ptr, bullet:ptr, h_line_throw:ptr, time_bullet:ptr
matrix_transform_tiny_2args			PROTO pVecRes:dword, pVec:dword
matrix_transform_tiny_1args			PROTO pVecRes:dword


include types.asm
include macroses.asm
include structures.asm
; вставки из целевой либы
include xrgame_stubs.asm

; позиция в том месте, где в целевой DLL начинается наша секция
org sec1_sec2_dist

include defines.asm
include utils.asm
include xr_vector.asm
include actor_input_fix.asm
include global_ns_fix.asm
include global_ns_fix2.asm
include game_object_castings.asm
include game_object_fix.asm
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
include physics_fix.asm
include self_anim_stalker.asm
include trader.asm
include ballistics_calc.asm
include turrel.asm
include particle_fix.asm
include pyrotechnics.asm
include pyrobattery.asm
include explosive_rocket.asm
include level_explosive.asm
include anomaly.asm
include vector_fix.asm
include physics_script.asm
include register_classes_fix.asm

% echo globalCountProcedures = @CatStr(%globalCountProcedures)
end LibMain
