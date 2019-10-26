Fixes description:
;=============FULLSCREEN INTROS==============
   Stretches intro texture to full screen size.

;==========VERTEX BUFFER IMPROVEMENT=========
   Fixes crash with bytes_need <= mSize & & vl_Count in log

;===READING OF RUSSIAN GAMEDATA ARCHIVES=====
   Lets english exe to read russian archives. If you use english version of stalker
   do not enable it.

;=======UNIFORM VARIABLES FOR SHADERS========
   Fix allows to create new global uniform variables for shaders.
   Enable when use OGSE shader pack

;============NEW CONSOLE COMMANDS============
   Fix allows to add new console commands in exe.
   Enable when use OGSE shader pack

;============WEATHER PARAMETERS==============
   Fix adds new parameters in weather configs:
   sun_shafts - sunshafts intensity
   sun_shafts_density - sunshafts density
   rain_max_drop_angle - max angle for falling rain drops (10 degrees by default)

  Also you should add these lines into all weather sections.

;======VSYNC FIXX============================
   rs_v_sync works now properly