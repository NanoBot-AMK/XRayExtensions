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

;======RESTORING OF SUN DETAILS=======
   This fix restores sun details, which were broken in 1.0004 patch

;=====LOD SWITCH EXTENDED TUNING======
   Fix extends lod switch upper limit (r__geometry_lod) to 3,0

;===MIPMAPS SWITCH EXTENDED TUNING====
   Fix extends mipmaps switch limits (r1_tf_mipbias) to [-3.0;3,0]