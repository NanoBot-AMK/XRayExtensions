.686
.XMM

.model flat,  C

include addr.inc

_CODE segment public 'CODE' use32
	assume cs:_CODE
	assume ds:_CODE
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

; ������� �� ������� ����
include xrgame_stubs.asm

; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

include global_ns_fix.asm
include level_ns_fix.asm
include actor_input_fix.asm
include actor_hit_callback.asm
include game_object_fix.asm
include cuiwindow_fix.asm
_CODE ENDS

end LibMain

