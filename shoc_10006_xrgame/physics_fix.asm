
;задать инициатор для физической оболочки, т.е. определить, кто кинул камень?
align_proc
CPHSimpleCharacter@@DamageInitiatorID proc uses esi edi
	mov		esi, ecx
	movzx	edx, word ptr [esi+9Ch]
	Level__Objects_net_Find	edx
	mov		edi, eax		;CPhysicsShellHolder* object
	xor		eax, eax
	dec		eax				;ret = -1;
	ASSUME	edi:ptr CPhysicsShellHolder
	.if (edi && !([edi].Props.flags & bDestroy))
		mov		edx, [edi]
		mov		eax, [edx+160h]
		mov		ecx, edi
		call	eax
		.if (eax)
			mov		edx, [eax]
			mov		ecx, eax
			mov		eax, [edx+4]
			call	eax
			movzx	eax, ax
		.else
			dec		eax		;= -1
		.endif
		.if (ax==0FFFFh)
			mov		edx, [edi].m_pPhysicsShell	;CPHShell*
			.if (edx)
				movzx	eax, [edx].CPHShell.m_InitiatorID
			.endif
		.endif
	.endif
	.if (ax==0FFFFh)
		mov		edi, [esi-48h]
		movzx	eax, [edi].ID
	.endif
	ASSUME	edi:nothing
	ret
CPHSimpleCharacter@@DamageInitiatorID endp

;Колбек на хит, вызывается для всех объектов, требует включения скриптом.
align_proc
CPhysicsShellHolder@@Hit_chank proc
	mov		edi, eax	; SHit *pHDS
	mov		eax, [esi+194h]
	push	edx
	mov		esi, ecx	; CPhysicsShellHolder* this
	push	ecx
	fstp	dword ptr [esp]
	call	eax				; CPhysicsShellHolder::PHHit
	.if ([esi].CGameObject.m_flCallbackKey & eCallbackAllHit)
		ASSUME	edi:ptr SHit
		Level__Objects_net_Find	[edi].weaponID
		mov		edx, eax
		CALLBACK__GO_FLOAT_VECTOR_GO_u16	esi, eAllHitObjects, edx, [edi].power, [edi].dir, [edi].who, [edi].boneID
		ASSUME	edi:nothing
	.endif
	pop		edi
	pop		esi
	retn	4
CPhysicsShellHolder@@Hit_chank endp

;задать скорость свободного падения для физ. тела
align_proc
CPhysicsShellHolder@@SetSpeedDescent proc uses esi speed_descent:real4
local k_l:real4, mass:real4
;ecx	this	CExplosiveRocket*
	ASSUME	esi:ptr CPhysicsShellHolder	;CCustomRocket
	mov		esi, ecx
	;//Решается уравнение: mass*gravity = vel*vel*k_l, компенсировать силу гравитации
	;float	mass = m_pPhysicsShell->getMass();
	mov		ecx, [esi].m_pPhysicsShell
	mov		edx, [ecx]
	mov		eax, [edx+48h]
	call	eax
	fstp	mass
	smart_cast	CCustomRocket, CPhysicsShellHolder, esi
	;k_l = (mass*ph_world->m_gravity - m_fEngineImpulseUp)/(speed_descent*speed_descent);
	mov		edx, ph_world
	movss	xmm0, mass
	xorps	xmm2, xmm2
	mulss	xmm0, [edx].CPHWorld.m_gravity
	.if (eax && [eax].CCustomRocket.m_bEnginePresent)
		subss	xmm0, [eax].CCustomRocket.m_fEngineImpulseUp
		.if (xmm0<xmm2)
			movss	xmm0, xmm2
		.endif
	.endif
	movss	xmm1, speed_descent
	mulss	xmm1, xmm1
	divss	xmm0, xmm1
	movss	k_l, xmm0
	;m_pPhysicsShell->SetAirResistance(k_l, 0.f);
	push	0	;angular
	push	k_l	;linear
	mov		ecx, [esi].m_pPhysicsShell
	mov		edx, [ecx]
	mov		eax, [edx+70h]
	call	eax
	ASSUME	esi:nothing
	ret
CPhysicsShellHolder@@SetSpeedDescent endp
