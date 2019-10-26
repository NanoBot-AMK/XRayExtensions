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

include macros_smart_cast.asm
include macros_call.asm
include global_ns_fix.asm
include level_ns_fix.asm
include cuistatic_fix.asm
include actor_hit_callback.asm
include console_fix.asm
include pda_fix.asm
include car_fix.asm
include level_input_fix.asm
include cuilistbox_fix.asm
include weapon_fix.asm
include game_object_fix.asm
include game_object_castings.asm
include explosive_fix.asm
include detector_fix.asm


end LibMain

