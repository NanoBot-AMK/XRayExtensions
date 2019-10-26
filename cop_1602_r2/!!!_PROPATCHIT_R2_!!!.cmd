@echo off
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist xrRender_R2.dll del xrRender_R2.dll

if exist addr.inc goto end_if
..\tools\AddCode.exe xrRender_R2_orig.dll
:end_if

..\tools\UASM.exe /c /coff /Fo mydll.obj mydll.asm
..\tools\polink.exe /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 

if exist mydll.obj del mydll.obj

..\tools\AddCode.exe xrRender_R2_orig.dll xrRender_R2.dll mydll.dll corrections_list.txt 0xE00000E0

if exist mydll.dll del mydll.dll

@echo.
@echo ======================================================

pause
