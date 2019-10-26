@echo off
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist xrcore.dll del xrcore.dll

if exist addr.inc goto mmm1
..\tools\AddCode.exe xrcore_orig.dll
:mmm1

..\tools\UASM.exe /c /coff /Fo mydll.obj mydll.asm
..\tools\polink.exe /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 

if exist mydll.obj del mydll.obj

..\tools\AddCode.exe xrcore_orig.dll xrcore.dll mydll.dll corrections_list.txt

if exist mydll.dll del mydll.dll

@echo.
@echo ======================================================

pause
