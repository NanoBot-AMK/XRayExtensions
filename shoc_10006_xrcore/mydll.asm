.686
.XMM

.model flat,  stdcall

include addr.inc


.code
; заглушка для линковшика
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

include common_macro.asm
; вставки из целевой либы
include xrcore_stubs.asm

; позиция в том месте, где в целевой DLL начинается наша секция
org sec1_sec2_dist

include texture_loading_fix.asm
	

end LibMain