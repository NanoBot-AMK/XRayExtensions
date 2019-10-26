
static_float	flt_default_SMAP_near_plane, 0.1
static_float	flt_default_SMAP_near_plane_neg, -0.1

align_proc
light__light_fix proc
	ASSUME	esi:ptr light
	;вырезаное
	movss	[esi].light.position.x, xmm0
	;---------
	mrm		[esi].m_f270h, flt_default_SMAP_near_plane
	mrm		[esi].m_f274h, flt_default_SMAP_near_plane_neg
	ASSUME	esi:nothing
	jmp		return_light__light_fix
light__light_fix endp

align_proc
light__export_fix proc
	ASSUME	esi:ptr light, ebp:ptr light
	mrm		[esi].m_f270h, [ebp].m_f270h ; 
	mrm		[esi].m_f274h, [ebp].m_f274h ; 
	ASSUME	esi:nothing, ebp:nothing
	jmp		return_light__export_fix
light__export_fix endp

