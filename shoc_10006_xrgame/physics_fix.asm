
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
CPhysicsShellHolder__Hit_chank proc
	mov		edi, eax	; SHit *pHDS
	mov		eax, [esi+194h]
	push	edx
	mov		esi, ecx	; CPhysicsShellHolder* this
	push	ecx
	fstp	dword ptr [esp]
	call	eax				; CPhysicsShellHolder::PHHit
	.if ([esi].CGameObject.m_flCallbackKey & eCallbackAllHit)
		push	ebx
		ASSUME	edi:ptr SHit
		Level__Objects_net_Find	[edi].weaponID
		mov		ecx, eax
		call	CGameObject@@lua_game_object
		mov		ebx, eax
		mov		ecx, [edi].who
		call	CGameObject@@lua_game_object
		mov		ecx, eax
		CALLBACK__GO_FLOAT_VECTOR_GO_u16	esi, eAllHitObjects, ebx, [edi].power, [edi].dir, ecx, [edi].boneID
		ASSUME	edi:nothing
		pop		ebx
	.endif
	pop		edi
	pop		esi
	retn	4
CPhysicsShellHolder__Hit_chank endp
