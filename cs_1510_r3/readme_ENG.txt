Fixes description:
;=====EXTENDED TUNING OF DETAILS DISTANCE=======
   this fix allows to increase distance of details rendering and adds 
   a console command (r__detail_radius) to tune it.
   Default details radius - 49, this fix change limit to 250.
   If you want more, you can change limit in console_comm.asm (0F0h number)

;========NEW CONSOLE COMMANDS=========
   Allow to add new console commands. Already defined commands:
   r__detail_radius

;==EXTENDED TUNING OF DETAILS DENSITY=
   Change upper limit of detail density option to 0.02,
   so you can get more dense grass

;=========SUN MOVEMENT FIX============
   With this fix you can control sun movement by config files.

;=====LOD SWITCH EXTENDED TUNING======
   Fix extends lod switch upper limit (r__geometry_lod) to 3,0

;====ADDITIONAL SHADOW MAP RESOLUTIONS======
   Fix adds new shadow map resolution - 8192x8192.
   Use it if you want to increase sun shadows quality.

;========EXTENDED R2_SUN_NEAR TUNING========
   Extends upper limit of r2_sun_near to 150. There are graphic bugs when high values
   are used so just increase smap resolution to avoid that bugs.