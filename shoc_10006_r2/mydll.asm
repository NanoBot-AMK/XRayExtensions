.686
.XMM

.model flat,  C

include addr.inc

_CODE segment byte public 'CODE' use32
	assume cs:_CODE
	assume ds:_CODE
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

; ������� �� ������� ����
include xrrender_r2_stubs.asm

; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

include misc.asm
include types.asm
include detail_radius_fix.asm	; ������ ��������� �����
include detail_density_fix.asm	; ��������� �����
include sun_details_fix.asm		; ���� �����
include rt_position_fix.asm		; ������� rt_Position ������ ����
include hud_shader_fix.asm		; ���������� ������������ �� ���
include console_comm_reg_macro.asm ; ������� ��� ���������� ���������� ������
include console_comm.asm		; ���������� ���������� ������
include light_fix.asm			; ���� ������������ ������� ����
include bloodmarks.asm			; �������������� ����������
include shader_defines_macro.asm	; ������� ��� ��������� �������� ��� ��������
include shader_defines.asm		; ��������� �������� ��� ��������
include	register_sampler_macro.asm	; ������� ����������� ��������� ��� �������
include	register_sampler_combine.asm	; ����������� ��������� ��� CBlender_combine
include	register_sampler_particle.asm	; ����������� ��������� ��� CBlender_Particle
include noise_texture.asm		; ������� �������� �������� ����������
include mip_bias_fix.asm
include detail_bump.asm
include actor_shadow_fix.asm
include smap_size_macro.asm
include new_smap_sizes.asm
include detail_blink_fix.asm
include sun_near_fix.asm
include hemi_update_fix.asm

_code ENDS

end LibMain

