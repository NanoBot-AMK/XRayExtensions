;======================================================================
;	Project		: XRay - Extensions		
;	Module		: pyrobattery.asm
;	Created		: 04.08.2019
;	Modified	: 04.08.2019
;	Author		: NanoBot
;	Description : Дополнительные скриптовый методы для класса CScriptParticles
;======================================================================

align_proc
CScriptParticles@@constructor proc (dword) uses esi caParticlesName:ptr byte
	ASSUME	esi:ptr CScriptParticles
	mov		esi, xr_memory$(size CScriptParticles)
	mov		[esi].vfptr, offset vfptr_CScriptParticles
	xr_memory	size CScriptParticlesCustom
	mov		[esi].m_particles, CScriptParticlesCustom@@CScriptParticlesCustom(esi, caParticlesName)	;this eax
	ASSUME	esi:nothing
	mov		eax, esi
	ret
CScriptParticles@@constructor endp

align_proc
CScriptParticles@@PlayAtPosDir proc uses esi edi pos:ptr Fvector, dir:ptr Fvector
local xform:Fmatrix4
;ecx	this	CScriptParticles*
	mov		edi, [ecx].CScriptParticles.m_particles
	ASSUME	edi:ptr CScriptParticlesCustom
	mov		eax, ds:g_dedicated_server
	.if (byte ptr [eax]==false)
		;IParticleCustom*	V = smart_cast<IParticleCustom*>(renderable.visual);
		mov		ecx, [edi].renderable.visual
		mov		edx, [ecx]
		mov		eax, [edx+20h]
		call	eax
		mov		esi, eax ;V
		generate_orthonormal_basis(dir, &xform)
		mov		edx, pos
		Fvector_set	xform.c_, [edx].Fvector
		;V->UpdateParent(xform, zero_vel, false);
		push	false
		push	offset zero_vel
		lea		eax, xform
		push	eax
		mov		ecx, esi
		mov		edx, [esi]
		mov		eax, [edx+30h]
		call	eax
		;V->Play();
		mov		ecx, esi
		mov		eax, [esi]
		mov		edx, [eax+38h]
		call	edx
		;dwLastTime	= Device.dwTimeGlobal - 33;
		mov		eax, ds:Device
		mov		ecx, [eax].CRenderDevice.dwTimeGlobal
		sub		ecx, 33
		mov		[edi].dwLastTime, ecx
		mov		[edi].mt_dt, 0
		mov		eax, edi
		call	CParticlesObject@@PerformAllTheWork
		mov		[edi].m_bStopping, false
	.endif
	ASSUME	edi:nothing
	ret
CScriptParticles@@PlayAtPosDir endp

align_proc
CScriptParticles@@MoveToPosDir proc uses esi pos:ptr Fvector, dir:ptr Fvector
local xform:Fmatrix4
;ecx	this	CScriptParticles*
	mov		esi, [ecx].CScriptParticles.m_particles
	generate_orthonormal_basis(dir, &xform)
	mov		edx, pos
	Fvector_set	xform.c_, [edx].Fvector
	mov		eax, esi
	CParticlesObject@@UpdateParent(&xform, &zero_vel)
	ret
CScriptParticles@@MoveToPosDir endp
