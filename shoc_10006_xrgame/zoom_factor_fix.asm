
const_static_float		default_fov, 70.0

align_proc
CWeapon@@CurrentZoomFactor_fix proc
	ASSUME	ecx:ptr CWeapon
	mov		eax, [ecx].m_eScopeStatus
	.if ((eax==2 && [ecx].m_flagsAddOnState & 1) || eax==1)
		fld		[ecx].m_fScopeZoomFactor
	.else
		fld		[ecx].m_fIronSightZoomFactor
	.endif
	fdiv	default_fov
	fmul	g_fov
	ASSUME	ecx:nothing
	ret
CWeapon@@CurrentZoomFactor_fix endp

align_proc
CWeaponBinoculars@@ZoomInc_fix proc
	ASSUME	ecx:ptr CWeaponBinoculars
	movss	xmm3, [ecx].m_fScopeZoomFactor
	mulss	xmm3, g_fov
	movss	xmm1, default_fov
	divss	xmm3, xmm1
	movaps	xmm0, xmm1
	subss	xmm0, xmm3
	movaps	xmm2, xmm0
	mulss	xmm0, ds:float_0p7
	mulss	xmm2, ds:float_0p3
	mulss	xmm0, ds:float_0p33333334
	subss	xmm1, xmm2
	movss	xmm2, [ecx].m_fZoomFactor
	subss	xmm2, xmm0
	movaps	xmm0, xmm2
	movss	[ecx].m_fZoomFactor, xmm2
	.if ( xmm3 > xmm0 )
		movss	[ecx].m_fZoomFactor, xmm3
	.else
		.if ( xmm0 > xmm1 )
			movss	[ecx].m_fZoomFactor, xmm1
		.endif
	.endif
	retn
CWeaponBinoculars@@ZoomInc_fix endp

align_proc
CWeaponBinoculars@@ZoomDec_fix proc
	movss	xmm3, [ecx].m_fScopeZoomFactor
	mulss	xmm3, g_fov
	movss	xmm1, default_fov
	divss	xmm3, xmm1
	movaps	xmm0, xmm1
	subss	xmm0, xmm3
	movaps	xmm2, xmm0
	mulss	xmm0, ds:float_0p7
	mulss	xmm2, ds:float_0p3
	mulss	xmm0, ds:float_0p33333334
	addss	xmm0, [ecx].m_fZoomFactor
	subss	xmm1, xmm2
	movss	[ecx].m_fZoomFactor, xmm0
	.if ( xmm3 > xmm0 )
		movss	[ecx].m_fZoomFactor, xmm3
		retn
	.endif
	.if ( xmm0 > xmm1 )
		movss	[ecx].m_fZoomFactor, xmm1
	.endif
	ASSUME	ecx:nothing
	retn
CWeaponBinoculars@@ZoomDec_fix endp

align_proc
CWeaponMagazinedWGrenade@@CurrentZoomFactor_fix proc
	ASSUME	ecx:ptr CWeaponMagazinedWGrenade
	mov		eax, [ecx].m_eGrenadeLauncherStatus
	.if ((eax==2 && [ecx].m_flagsAddOnState & 2 || eax==1) && [ecx].m_bGrenadeMode)
		fld		[ecx].m_fIronSightZoomFactor
	.else
		mov		eax, [ecx].m_eScopeStatus
		.if (eax==2 && [ecx].m_flagsAddOnState & 1 || eax==1)
			fld		[ecx].m_fScopeZoomFactor
		.else
			fld		[ecx].m_fIronSightZoomFactor
		.endif
	.endif
	fdiv	default_fov
	fmul	g_fov
	ASSUME	ecx:nothing
	ret
CWeaponMagazinedWGrenade@@CurrentZoomFactor_fix endp
