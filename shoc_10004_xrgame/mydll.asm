.686
.XMM

.model flat,  stdcall

include addr.inc


.code
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP




include types.asm
include macroses.asm
include structures.asm
; ������� �� ������� ����
include xrgame_stubs.asm

; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

include defines.asm
include utils.asm
include debug_info.asm


end LibMain
