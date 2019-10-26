@echo off
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist xrRender_R3.dll del xrRender_R3.dll

if exist addr.inc goto end_if
..\tools\AddCode.exe xrRender_R3_orig.dll
:end_if

..\tools\UASM.exe /c /coff /Fo mydll.obj mydll.asm
..\tools\polink.exe /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 

if exist mydll.obj del mydll.obj

..\tools\AddCode.exe xrRender_R3_orig.dll xrRender_R3.dll mydll.dll corrections_list.txt

if exist mydll.dll del mydll.dll

@echo.
@echo ======================================================

pause
