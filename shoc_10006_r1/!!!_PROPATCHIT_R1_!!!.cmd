@echo on
if exist mydll.obj del mydll.obj
if exist mydll.dll del mydll.dll
if exist mydll.exp del mydll.exp
if exist mydll.lib del mydll.lib
if exist xrRender_R1.dll del xrRender_R1.dll

..\tools\ml /c /coff /Fo mydll.obj mydll.asm
..\tools\Link /SUBSYSTEM:WINDOWS /DLL /OUT:mydll.dll /DEF:mydll.def mydll.obj 

del mydll.obj
del mydll.exp
del mydll.lib



rem pause




if exist xrRender_R1.dll del xrRender_R1.dll
..\tools\bspatch.exe xrRender_R1_orig.dll xrRender_R1.dll xrRender_R1.dll.diff 




rem pause




..\tools\patcher.exe xrRender_R1.dll mydll.dll corrections_list.txt




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