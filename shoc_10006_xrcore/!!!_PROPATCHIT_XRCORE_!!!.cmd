@echo on
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist mydll.exp del mydll.exp
if exist mydll.lib del mydll.lib
if exist xrcore.dll del xrcore.dll

..\tools\ml /c /coff /Fo mydll.obj mydll.asm
rem ..\tools\Link /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj /SAFESEH:NO /MAP:map.txt
..\tools\link.exe  /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 
rem /SAFESEH:NO /MAP:map.txt


del mydll.obj
del mydll.exp
del mydll.lib



rem pause



if exist xrcore.dll del xrcore.dll

..\tools\bspatch.exe xrcore_orig.dll xrcore.dll xrcore.dll.diff
..\tools\patcher.exe xrcore.dll mydll.dll corrections_list.txt

if exist mydll.dll del mydll.dll



rem pause



@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo  GOTOVO
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@echo.
@pause