.686
.XMM

.model flat,  stdcall

include addr.inc

.code
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

; ������� �� ������� ����
include xrrender_r1_stubs.asm


; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

include console_comm_reg_macro.asm
include console_comm.asm
include detail_radius_fix.asm
include detail_density_fix.asm
include mip_bias_fix.asm
	

end LibMain

