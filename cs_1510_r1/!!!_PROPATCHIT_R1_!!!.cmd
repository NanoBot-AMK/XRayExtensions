@echo off
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist xrRender_R1.dll del xrRender_R1.dll

if exist addr.inc goto end_if
..\tools\AddCode.exe xrRender_R1_orig.dll
:end_if

..\tools\UASM.exe /c /coff /Fo mydll.obj mydll.asm
..\tools\polink.exe /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 

if exist mydll.obj del mydll.obj

..\tools\AddCode.exe xrRender_R1_orig.dll xrRender_R1.dll mydll.dll corrections_list.txt

if exist mydll.dll del mydll.dll

@echo.
@echo ======================================================

pause
