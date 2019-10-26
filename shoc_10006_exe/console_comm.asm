
static_float	sunshafts_exposure, 	0.05
static_float	sunshafts_density, 		1.0
static_int		dwRefreshRateDispHz, 	0

align_proc
con_comm proc
	mov		dword ptr [eax], offset xCCC_Integer	; вырезанное!
	REGISTER_CC_FLOAT	sunshafts_exposure,		"r2_sun_shafts_intensity",	0.0,	1.0
	REGISTER_CC_FLOAT	sunshafts_density,		"r2_sun_shafts_density",	0.0,	1.0
	REGISTER_CC_INT		dwRefreshRateDispHz,	"vid_refresh_rate_hz",		0,		200
	; делаем вырезанное	
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	pop		ecx
	retn
con_comm endp

