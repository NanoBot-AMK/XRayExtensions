
align_proc
shaders_mapping proc
	;ss_params
	call	CBlender_Compile__r_Constant
	push	offset ss_params
	push	offset ss_name
	mov		ecx, edi
	;common_params
	call	CBlender_Compile__r_Constant
	push	offset common_params
	push	offset common_name
	mov		ecx, edi
	;common_params2
	call	CBlender_Compile__r_Constant
	push	offset common_params2
	push	offset common_name2
	mov		ecx, edi
	;script_params
	call	CBlender_Compile__r_Constant
	push	offset script_params
	push	offset script_params_name
	mov		ecx, edi
	; делаем то, что вырезали
	call	CBlender_Compile__r_Constant ; CBlender_Compile::r_Constant(char const *,R_constant_setup *)
	jmp		return_shaders_mapping
shaders_mapping endp

static_int		ss_vfptr, offset ss_setup
static_int		ss_params, offset ss_vfptr
static_str		ss_name, "sunshafts_params"

static_int		common_vfptr2, offset common_setup2
static_int		common_params2, offset common_vfptr2
static_str		common_name2, "common_params2"

static_int		common_vfptr, offset common_setup
static_int		common_params, offset common_vfptr
static_str		common_name, "common_params"

static_int		script_vfptr, offset script_setup
static_int		script_params, offset script_vfptr
static_str		script_params_name, "script_params"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ѕараметры саншафтов
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
align_proc
ss_setup proc
	mov		ecx, [esp+4]
	.if (ecx)
		; вычисление константы
		mov		eax, ds:g_pGamePersistent
		mov		eax, [eax+46Ch]	;pEnvironment
		mov		eax, [eax+1D0h]
		movss	xmm0, dword ptr [eax+0Ch]	;x
		movss	xmm1, dword ptr [eax+10h]	;y
;		xorps	xmm0, xmm0					;z
;		xorps	xmm1, xmm1					;z
		xorps	xmm2, xmm2					;z
		xorps	xmm3, xmm3					;w
		; регистраци€ константы в системе 
		REGISTER_CONSTANT_VECTOR
	.endif
	retn	4
ss_setup endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ќбщие параметры
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
align_proc
common_setup proc
	mov		ecx, [esp+4]
	.if (ecx)
		; вычисление константы	
		mov		eax, offset ds:Device	;CRenderDevice *Device
		fild	dword ptr [eax+100h]	;Device.dwWidth
		fstp	width_float
		movss	xmm0, width_float		;x
		fild	dword ptr [eax+104h]	;Device.dwHeight	
		fstp	height_float
		movss	xmm1, height_float		;y
		fld1
		fdiv	width_float				;Device.dwWidth
		fstp	inv_width
		movss	xmm2, inv_width			;z
		fld1
		fdiv	height_float			;Device.dwHeight
		fstp	inv_height
		movss	xmm3, inv_height		;w
		; регистраци€ константы в системе 
		REGISTER_CONSTANT_VECTOR
	.endif
	retn	4
common_setup endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ќбщие параметры 2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
align_proc
common_setup2 proc
	mov		ecx, [esp+4]
	.if (ecx)
		; вычисление константы	
		mov		eax, offset ds:Device	;CRenderDevice *Device
		fld		dword ptr [eax+33Ch]	;Device.fFOV
		fmul	to_rad
		fstp	ffov
		movss	xmm0, ffov				;x
		movss	xmm1, dword ptr [eax+340h]		;y,		;Device.fASPECT
		xorps	xmm2, xmm2					;z
		xorps	xmm3, xmm3					;w
		; регистраци€ константы в системе 
		REGISTER_CONSTANT_VECTOR
	.endif
	retn	4
common_setup2 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ѕараметры, передаваемые из скриптов
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
align_proc
script_setup proc
	mov		ecx, [esp+4]
	.if (ecx)
		; вычисление константы	
		movss	xmm0, sunshafts_exposure	;x
		movss	xmm1, sunshafts_density		;y
		xorps	xmm2, xmm2					;z
		xorps	xmm3, xmm3					;w
		; регистраци€ константы в системе 
		REGISTER_CONSTANT_VECTOR
	.endif
	retn	4
script_setup endp

; нужные константы
static_float	sun_shafts_weather_defined, 1.0
static_float	dumb_one, 1.0
static_float	width_float, 0.0
static_float	height_float, 0.0
static_int		inv_width, 0
static_int		inv_height, 0
static_float	ffov, 0.0
static_float	to_rad, 0.017453292
;aF dd "%f", 0
