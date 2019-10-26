include console_commands_reg_macro.asm

align_proc
add_console_commands_fix proc 
	xor		 eax, eax
	mov		 g_bHudAdjustMode, eax
REGISTER_CC_INT2	g_bHudAdjustMode,	"hud_adjust_mode",	0, 5
	;xor	 eax, eax
	;mov	 [g_fHudAdjustValue], eax
REGISTER_CC_FLOAT2	g_fHudAdjustValue,	"hud_adjust_value", 0.0, 1.0
REGISTER_CC_FLOAT2	g_ui_mouse_sens,	"mouse_ui_sens",	1.0, 10.0
ifndef OGSE_BUILD
REGISTER_CC_FLAG	g_ammo_on_belt, 1h, "g_ammunition_on_belt"
endif
REGISTER_CC_FLAG	g_mouse_wheel_sc, 1h,	"mouse_wheel_slot_changing"

ifdef OGSE_BUILD
	REGISTER_CC_INT2   g_ogse_nv_bind,			 "ogse_nv_bind",		   0, 07FFFFFFFh
	REGISTER_CC_INT2   g_ogse_antirad_bind,		 "ogse_antirad_bind",	   0, 07FFFFFFFh
	REGISTER_CC_INT2   g_ogse_energy_drink_bind, "ogse_energy_drink_bind", 0, 07FFFFFFFh
	REGISTER_CC_INT2   g_ogse_yod_bind,			 "ogse_yod_bind",		   0, 07FFFFFFFh
	REGISTER_CC_INT2   g_ogse_bipsizon_bind,	 "ogse_bipsizon_bind",	   0, 07FFFFFFFh
	REGISTER_CC_INT2   g_ogse_handradio_bind,	 "ogse_handradio_bind",		0, 07FFFFFFFh
	REGISTER_CC_INT2   g_ogse_quicksave_bind,	 "ogse_quicksave_bind",		0, 07FFFFFFFh
	REGISTER_CC_FLAG   g_ogse_flag,			1h,	 "write_debug_log"
endif

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
REGISTER_CC_FLOAT2	g_fov,			"cam_fov",			55.0, 90.0
REGISTER_CC_FLOAT2	00506BA4h,		"hud_fov",			0.0, 1.0
REGISTER_CC_FLOAT2	phTimefactor,	"ph_timefactor",	0.0, 10.0
REGISTER_CC_FLOAT2	phGravity,		"ph_gravity",		0.0, 100.0
ifdef DEBUG_COMMANDS
	REGISTER_CC_FLAG psActorFlags, 8, "g_unlimitedammo"
	REGISTER_CC_FLAG psActorFlags, 1, "g_god"
endif
ifdef PZ_BUILD
	REGISTER_CC_FLAG g_storyline_music, 1h, "g_storyline_music"
	REGISTER_CC_FLAG hud_date, 1h, "hud_date"
	REGISTER_CC_FLAG dump_info, 1h, "dump_info"
endif
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================

	; делаем то, что вырезали, включая возврат из функции
	pop		edi
	pop		esi
	pop		ebx
	retn
add_console_commands_fix endp

static_float	g_ui_mouse_sens, 3.3
ifdef PZ_BUILD
static_int		g_ammo_on_belt, 1
else
static_int		g_ammo_on_belt, 0
endif
static_int		g_mouse_wheel_sc, 1

ifdef OGSE_BUILD
static_int		g_ogse_nv_bind			 , 100000
static_int		g_ogse_antirad_bind		 , 100000
static_int		g_ogse_energy_drink_bind , 100000
static_int		g_ogse_yod_bind			 , 100000
static_int		g_ogse_bipsizon_bind	 , 100000
static_int		g_ogse_handradio_bind	 , 100000
static_int		g_ogse_quicksave_bind	 , 100000
static_int		g_ogse_flag				 , 0
endif

static_float	phGravity, 19.62
ifdef PZ_BUILD
static_int		g_storyline_music, 1
static_int		hud_date, 1
static_int		dump_info, 0
endif
