.686
.XMM

.model flat,  stdcall

include addr.inc


.code
; �������� ��� ����������
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

include common_macro.asm
; ������� �� ������� ����
include xrcore_stubs.asm

; ������� � ��� �����, ��� � ������� DLL ���������� ���� ������
org sec1_sec2_dist

include texture_loading_fix.asm
	

end LibMain