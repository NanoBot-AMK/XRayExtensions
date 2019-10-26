@echo off
if exist src.obj del src.obj
if exist src.exe del src.exe
if exist XR_3DA.exe del XR_3DA.exe

if exist addr.inc goto mmm1
..\tools\add_code.exe XR_3DA_orig.exe addr.inc
:mmm1

..\tools\UASM.exe /c /coff /Fo src.obj src.asm
..\tools\polink.exe /SUBSYSTEM:WINDOWS /BASE:0x400000 /OUT:src.exe /DEF:src.def src.obj 

del src.obj

..\tools\add_code.exe XR_3DA_orig.exe XR_3DA.exe src.exe corrections_list.txt

if exist src.exe del src.exe


@echo.
@echo =============================================================
@echo.
pause
