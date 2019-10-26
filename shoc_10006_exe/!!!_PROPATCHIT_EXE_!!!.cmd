@echo on
if exist src.obj del src.obj
if exist src.exe del src.exe
if exist src.exp del src.exp
if exist src.lib del src.lib
if exist XR_3DA.exe del XR_3DA.exe

..\tools\ml /c /coff /Fo src.obj src.asm
..\tools\link.exe /SUBSYSTEM:WINDOWS /BASE:0x400000 /OUT:src.exe /DEF:src.def src.obj 

del src.obj
del src.exp
del src.lib



rem pause



if exist xr_3DA.exe del xr_3DA.exe
..\tools\bspatch.exe XR_3DA_orig.exe XR_3DA.exe XR_3DA.exe.diff 



rem pause



..\tools\patcher.exe XR_3DA.exe src.exe corrections_list.txt



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