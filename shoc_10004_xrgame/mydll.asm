.686
.XMM

.model flat,  stdcall

include addr.inc


.code
; заглушка для линковшика
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP




include types.asm
include macroses.asm
include structures.asm
; вставки из целевой либы
include xrgame_stubs.asm

; позиция в том месте, где в целевой DLL начинается наша секция
org sec1_sec2_dist

include defines.asm
include utils.asm
include debug_info.asm


end LibMain
