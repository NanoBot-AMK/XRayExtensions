include global_ns_reg_macro2.asm

global_space_ext2 proc ; вставка, дополняющая функцию экспорта глобальных функций
	; здесь делаем то, что вырезали
	call	register__gs_sell_condition__fl_fl
	pop		ecx
	pop		ecx
	; добавляем свой код
	GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT		SetGameTime,			"set_game_time"
	GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT		SetFloatArgs12,			"set_float_args_12"
	GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT		SetFloatArgs34,			"set_float_args_34"
	;
	GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT		SetHudInertia,			"set_hud_inertia"
	GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT		SetHudInertiaParam2,	"set_hud_inertia_param2"
	;
	GLOBAL_NS_PERFORM_EXPORT__VOID__FLOAT_FLOAT		SetStaticRescalefactor,	"set_static_rescale_factor"
	GLOBAL_NS_PERFORM_EXPORT__FLOAT__VOID			GetStaticRescalefactor, "get_static_rescale_factor"
	; идём обратно
	jmp back_from_global_space_ext2
global_space_ext2 endp

global_space_ext2_additional proc
	; здесь делаем то, что вырезали
	GLOBAL_NS_SCOPE_ADD
	GLOBAL_NS_SCOPE_ADD
	; добавляем свой код
	GLOBAL_NS_SCOPE_ADD
	GLOBAL_NS_SCOPE_ADD
	GLOBAL_NS_SCOPE_ADD
	;
	GLOBAL_NS_SCOPE_ADD
	GLOBAL_NS_SCOPE_ADD
	;
	GLOBAL_NS_SCOPE_ADD
	GLOBAL_NS_SCOPE_ADD
	; идём обратно
	jmp back_from_global_space_ext2_additional
global_space_ext2_additional endp

align_proc
SetGameTime proc C time:dword, time_factor:dword
	mov		ecx, ds:g_pGamePersistent
	mov		eax, [ecx]
	mov		ecx, [eax+46Ch] ; _DWORD
	push	time
	push	time_factor
	call	ds:CEnvironment__SetGameTime
	ret
SetGameTime endp

static_float	g_float_arg1, 0.0
static_float	g_float_arg2, 0.0
static_float	g_float_arg3, 0.0
static_float	g_float_arg4, 0.0

static_int		stub_test, 9 dup(0)

align_proc
SetFloatArgs12 proc C arg1:dword, arg2:dword
	mrm		g_float_arg1, arg1
	mrm		g_float_arg2, arg2
	ret
SetFloatArgs12 endp

align_proc
SetFloatArgs34 proc C arg1:dword, arg2:dword
	mrm		g_float_arg3, arg1
	mrm		g_float_arg4, arg2
	ret
SetFloatArgs34 endp

ifdef PZ_BUILD
	; PZ settings
static_float		g_hud_inertia_factor, 5.0
static_float		g_hud_inertia_param_2, 0.07
else
	; default settings
static_float		g_hud_inertia_factor, 5.0 ; TENDTO_SPEED
static_float		g_hud_inertia_param_2, 0.050000001 ; CHWON_CALL_UP_SHIFT
endif
align_proc
SetHudInertia proc C hud_inertia:dword, arg2:dword
	mrm		g_hud_inertia_factor, hud_inertia
	ret
SetHudInertia endp

align_proc
SetHudInertiaParam2 proc C hud_inertia:dword, arg2:dword
	mrm		g_hud_inertia_param_2, hud_inertia
	ret
SetHudInertiaParam2 endp

static_float		g_static_rescale_correction, 0.83333333
align_proc
SetStaticRescalefactor proc C rescale_factor:dword, arg2:dword
	mrm		g_static_rescale_correction, rescale_factor
	ret
SetStaticRescalefactor endp

align_proc
GetStaticRescalefactor proc
	fld		dword ptr [g_static_rescale_correction]
	retn
GetStaticRescalefactor endp

; Вывод стартового адреса xrGame.dll в логе
static_byte		first_start_log, true
align_proc
StartAdress_xrGame_log__DllMain proc
	.if (first_start_log)
		mov		eax, [esp]
		sub		eax, 00288645h
		PRINT_UINT	"xrGame.dll Start adress: %08X", eax
		mov		first_start_log, false
	.endif
	; делаем что вырезали
	mov		eax, [esp+4+8];fdwReason
	sub		eax, 1
	retn
StartAdress_xrGame_log__DllMain endp

;Фикс пропадания звука дождя при загрузке уровня.
;if (g_pGamePersistent->pEnvironment){
;	CEffect_Rain*	rain = g_pGamePersistent->pEnvironment->eff_Rain;
;	if (rain)
;		rain->state = CEffect_Rain::stIdle;
;}
align_proc
SoundRain_fix proc
	mov		edx, ds:g_pGamePersistent
	mov		eax, [edx]
	ASSUME	eax:ptr IGame_Persistent, ecx:ptr CEnvironment, edx:ptr CEffect_Rain
	mov		ecx, [eax].pEnvironment
	.if (ecx)
		mov		edx, [ecx].eff_Rain
		.if (edx)
			and		[edx].state, CEffect_Rain@stIdle
		.endif
	.endif
	ASSUME	eax:nothing, ecx:nothing, edx:nothing
	jmp		return_SoundRain_fix
SoundRain_fix endp
