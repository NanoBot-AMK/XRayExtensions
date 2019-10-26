.686
.XMM

.model flat,  stdcall

include addr.inc

.code
; заглушка для линковшика
LibMain proc STDCALL instance:DWORD,reason:DWORD,unused:DWORD 
    ret
LibMain ENDP

CHW@@ValidityRefreshRate		PROTO dwWidth:dword, dwHeight:dword, fmt:dword, refresh_rate:dword

include macroses.asm
include xr_3da_stubs.asm 	; вставки из целевой либы

; позиция в том месте, где в целевой DLL начинается наша секция
org sec1_sec2_dist

;include empty.asm ; затычка для патчера
include structures.asm
include shaders_mapping_macro.asm
include shaders_mapping.asm
include console_comm_reg_macro.asm
include console_comm.asm
include loadscreen_fix.asm
include weather_parameters.asm
include vsync_fix.asm


end LibMain
