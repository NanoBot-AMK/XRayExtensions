@echo off
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist xrGame.dll del xrGame.dll

if exist addr.inc goto mmm1
..\tools\add_code.exe xrGame_orig.dll
:mmm1

..\tools\UASM.exe /c /coff /Fo mydll.obj mydll.asm
..\tools\polink.exe /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 

if exist mydll.obj del mydll.obj

..\tools\add_code.exe xrGame_orig.dll xrGame.dll mydll.dll corrections_list.txt

if exist mydll.dll del mydll.dll

@echo.
@echo ======================================================

pause
