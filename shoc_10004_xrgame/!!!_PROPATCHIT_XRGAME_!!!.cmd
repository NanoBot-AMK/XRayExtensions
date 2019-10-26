@echo off
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist xrGame.dll del xrGame.dll

if exist addr.inc goto end_if
..\tools\AddCode.exe xrGame_orig.dll
:end_if

..\tools\UASM.exe /c /coff /Fo mydll.obj mydll.asm
..\tools\polink.exe /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 

if exist mydll.obj del mydll.obj

..\tools\AddCode.exe xrGame_orig.dll xrGame.dll mydll.dll corrections_list.txt 0E00000E0h

if exist mydll.dll del mydll.dll

@echo.
@echo ======================================================

pause
