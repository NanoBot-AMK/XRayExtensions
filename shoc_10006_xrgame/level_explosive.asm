;======================================================================
;	Project		: XRay - Extensions		
;	Module 		: level_explosive.asm
;	Created 	: 02.11.2017
;	Modified 	: 19.10.2018
;	Author		: NanoBot
;	Description : Взрывчатка в классе CBulletExplosive. Вер. 1.0
;======================================================================

LEVEL__MAX_COUNT_EXPLOSIVES			equ 512
;----------------------------------------------------------------------
; Таблица виртуальных функций
.const
align 4
						dd offset dbs_CExplosive								; -4
vtbl@CBulletExplosive	dd offset CExplosive@@SetInitiator						; 0
						dd offset CBulletExplosive@@Initiator					; 4
						dd offset CExplosive@@cast_IDamageSource				; 8
						dd offset CExplosive@@_destructor						; 12
						dd offset CBulletExplosive@@Load						; 16
						dd offset CExplosive@@Load_char_const_ 					; 20	(char const *)
						dd offset CExplosive@@net_Destroy						; 24
						dd offset CExplosive@@net_Relcase						; 28
						dd offset CExplosive@@UpdateCL							; 32
						dd offset CExplosive@@Explode							; 36
						dd offset CBulletExplosive@@ExplodeParams				; 40
						dd offset CBulletExplosive@@OnEvent						; 44
						dd offset CBulletExplosive@@OnAfterExplosion			; 48	// погасить партиклы, удалить объект
						dd offset CBulletExplosive@@OnBeforeExplosion			; 52
						dd offset CExplosive@@SetCurrentParentID				; 56
						dd offset CExplosive@@UpdateExplosionPos				; 60		
						dd offset CBulletExplosive@@GetExplVelocity				; 64
						dd offset CExplosive@@GetExplPosition					; 68
						dd offset CExplosive@@GetExplDirection					; 72
						dd offset CBulletExplosive@@GenExplodeEvent				; 76
						dd offset CBulletExplosive@@FindNormal					; 80
						dd offset CBulletExplosive@@cast_game_object     		; 84		
						dd offset CExplosive@@cast_explosive					; 88		
						dd offset CExplosive@@GetRayExplosionSourcePos			; 92
						dd offset CExplosive@@GetExplosionBox					; 96
						dd offset CBulletExplosive@@ActivateExplosionBox		; 100
						dd offset CExplosive@@Useful							; 104
						dd offset CBulletExplosive@@HideExplosive				; 108
						dd offset CExplosive@@StartLight						; 112
						dd offset CExplosive@@StopLight							; 116
						dd offset CBulletExplosive@@UpdateExplosionParticles	; 120
.code
;----------------------------------------------------------------------

; иницилизация m_game_object и m_game_object_id
align_proc
CExplosive@@Load_ext proc
;edi - this
	ASSUME	edi:ptr CExplosive, eax:ptr CGameObject
	;m_game_object_id = m_game_object ? m_game_object.ID() : 0xFFFF;
	mov		eax, [edi].m_game_object
	xor		edx, edx
	dec		edx			;dx = 0FFFFh
	.if (eax)
		mov		dx, [eax].ID
	.endif
	mov		[edi].m_game_object_id, dx
	ASSUME	edi:nothing, eax:nothing
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	retn	8
CExplosive@@Load_ext endp

align_proc
CExplosive@@Explode_vector_vel_zero proc
;vel		= dword ptr 12
	xor		eax, eax
	lea     ecx, [esp+0C8h-12];vel
	Fvector_set	[ecx].Fvector, eax, eax, eax
	jmp		return@CExplosive@@Explode_vector_vel_zero
CExplosive@@Explode_vector_vel_zero endp
;---------------------------------------------------------------------------------------

;конструктор
align_proc
CBulletManager@@CBulletManager_ext proc
;esi - this
	ASSUME	esi:ptr CBulletManager
	xor		eax, eax
	mov		[esi].m_dwTimeRemainder, eax
	mov		[esi].m_explosions._Alval, eax
	mov		[esi].m_explosions._Myfirst, eax
	mov		[esi].m_explosions._Mylast, eax
	mov		[esi].m_explosions._Myend, eax
	mov		[esi].m_explosions._Count, eax
	mov		[esi].m_explo_ids, eax
	mov		[esi].m_free_id, eax
	mov		[esi].m_dwTotalShots, eax
	ASSUME	esi:nothing
	;return;
	pop		edi
	mov		eax, esi
	pop		ebx
	pop		ecx
	retn
CBulletManager@@CBulletManager_ext endp

;деструктор
align_proc
CBulletManager@@_CBulletManager_ext proc
;esi - this
	push	edi
	push	ebx
	ASSUME	esi:ptr CBulletManager, edi:ptr CBulletExplosive
	mov		edi, [esi].m_explosions._Myfirst
	mov		ebx, [esi].m_explosions._Mylast
	.if (edi)
		.while (edi<ebx)
			;mov		eax, [edi].m_id
			;PRINT_UINT "CBulletManager@@_CBulletManager_ext() [edi].m_id=%d", eax
			mov		ecx, edi
			call	CExplosive@@_CExplosive
			add		edi, sizeof CBulletExplosive
		.endw
		xr_mem_free	[esi].m_explosions._Myfirst
		mov		[esi].m_explosions._Myfirst, NULL
		xr_mem_free	[esi].m_explo_ids
		mov		[esi].m_explo_ids, NULL
	.endif
	ASSUME	esi:nothing, edi:nothing
	pop		ebx
	pop		edi
	;return;
	mov		eax, esi
	pop		esi
	retn	4
CBulletManager@@_CBulletManager_ext endp

const_static_str		aHalflength_shell,	"halflength_shell"
const_static_str		aType_ballistic,	"type_ballistic"

align_proc
CBulletManager@@Load_ext proc
	ASSUME	edi:ptr CBulletManager, ebx:ptr CLevel
	mov		eax, ds:g_pGameLevel
	sub     edi, CBulletManager.m_ExplodeParticles
	mov		ebx, [eax]
	Fvector_set [edi].m_BoundingVolume.min, [ebx].ObjectSpace.m_BoundingVolume.min
	Fvector_set [edi].m_BoundingVolume.max, [ebx].ObjectSpace.m_BoundingVolume.max
	xorps	xmm0, xmm0
	movaps	[edi].m_vecGravityConstDeltaTime, xmm0
	;m_vecGravityConstDeltaTime.y = m_fGravityConst*(float)m_dwStepTime*0.001f;
	movss	xmm0, [edi].m_fGravityConst
	cvtsi2ss xmm1, [edi].m_dwStepTime
	mulss	xmm0, xmm1
	mulss	xmm0, float_0p001
	movss	[edi].m_vecGravityConstDeltaTime.y, xmm0
	xor		eax, eax
	mov		[edi].m_BoundingVolume.min.w, eax
	mov		[edi].m_BoundingVolume.max.w, eax
	mov		[edi].m_type_ballistic, al	;=0
	.if (@LINE_EXIST(&aBullet_manager, &aType_ballistic))	;"type_ballistic"
		mov		[edi].m_type_ballistic, @R_U8(&aBullet_manager, &aType_ballistic)
	.endif
	mov		eax, [ebx].game
	.if ([eax].game_cl_GameState.m_type!=GAME_SINGLE)	; мультиплейер
		mov		[edi].m_type_ballistic, 1
	.endif
	ASSUME	edi:nothing, ebx:nothing
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	add		esp, 44
	retn
CBulletManager@@Load_ext endp

;запускается из метода CActor::net_Relcase
align_proc
CBulletManager@@net_Relcase proc
;ebp - CObject*
	push	esi
	mov		edx, ds:g_pGameLevel
	mov		eax, [edx]	; 
	mov		esi, [eax].CLevel.m_pBulletManager
	ASSUME	esi:ptr CBulletManager,  edi:ptr CBulletExplosive
	mov		edi, [esi].m_explosions._Myfirst
	mov		ebx, [esi].m_explosions._Mylast
	.if (edi)
		.while (edi<ebx)
			.if ([edi].CExplosive@vfptr && [edi].m_explosion_flags)
				push	ebp		; O
				mov		ecx, edi
				call	CExplosive@@net_Relcase
			.endif
			add		edi, sizeof CBulletExplosive
		.endw
	.endif
	ASSUME	esi:nothing, edi:nothing
	pop		esi
;-------------------------
	pop		edi
	pop		ebp
	pop		ebx
	retn	4
CBulletManager@@net_Relcase endp

align_proc
CBulletManager@@UpdateCExplosive proc
;ebp - this		CBulletManager
	ASSUME	ebp:ptr CBulletManager,  edi:ptr CBulletExplosive
	mov		edi, [ebp].m_explosions._Myfirst
	mov		ebx, [ebp].m_explosions._Mylast
	.if (edi)
		.while (edi<ebx)
			.if ([edi].CExplosive@vfptr && [edi].m_explosion_flags)
				mov		ecx, edi
				call	CExplosive@@UpdateCL
			.endif
			add		edi, sizeof CBulletExplosive
		.endw
	.endif
	ASSUME	ebp:nothing, edi:nothing
	; return; // CBulletManager::CommitEvents
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	add		esp, 8
	retn	4
CBulletManager@@UpdateCExplosive endp

;запускаются из скриптовых функций
;создать взрывчатку
align_proc
CBulletManager@@CreateExplosive proc section_explosive:dword, id_weapon:dword
;esi - CBulletManager
;	mov		eax, section_explosive
;	PRINT_UINT "CBulletManager@@CreateExplosive() section_explosive = [%s]", eax
;	mov		eax, id_weapon
;	movzx	eax, ax
;	PRINT_UINT "id_weapon = %d", eax
	push	esi
	push	edi
	mov		esi, ecx
	ASSUME	esi:ptr CBulletManager, edi:ptr CBulletExplosive
	;выделяем памяти сразу на максимальное количество объектов.
	.if ([esi].m_explosions._Myfirst==NULL)
		xr_memory	LEVEL__MAX_COUNT_EXPLOSIVES*sizeof CBulletExplosive
		mov		[esi].m_explosions._Myfirst, eax
		mov		[esi].m_explosions._Mylast, eax
		add		eax, LEVEL__MAX_COUNT_EXPLOSIVES*sizeof CBulletExplosive
		mov		[esi].m_explosions._Myend, eax
		mov		[esi].m_explosions._Alval, offset CExplosive@@_CExplosive
		xr_memory	LEVEL__MAX_COUNT_EXPLOSIVES*sizeof dword
		mov		[esi].m_explo_ids, eax
		xr_memset	eax, 0, LEVEL__MAX_COUNT_EXPLOSIVES
	.endif
	xor		eax, eax
	dec		eax
	mov		edi, [esi].m_explosions._Mylast	;CBulletExplosive*	explo
	.if ([esi].m_explosions._Myend>edi)
		;m_explosions.push_back()
		add		[esi].m_explosions._Mylast, sizeof CBulletExplosive
		inc		[esi].m_explosions._Count
		mov		eax, edi
		call	CBulletExplosive@@CBulletExplosive
		push	section_explosive
		mov		ecx, edi
		call	CExplosive@@Load_char_const_
		;explo.m_game_object_id = (u16)id_weapon;
		mov		eax, id_weapon
		mov		[edi].m_game_object_id, ax
		;explo.m_id = m_free_id;
		mov		eax, [esi].m_free_id
		mov		[edi].m_id, eax
		;m_explo_ids[m_free_id] = explo;
		mov		edx, [esi].m_explo_ids
		mov		[edx+eax*4], edi
		;найти следующий свободный ID
		mov		ecx, LEVEL__MAX_COUNT_EXPLOSIVES
		.while (ecx)
			inc		eax
			.if (eax>=LEVEL__MAX_COUNT_EXPLOSIVES)
				xor		eax, eax
			.endif
			.break .if (dword ptr [edx+eax*4]==NULL)
			dec		ecx
		.endw
		mov		[esi].m_free_id, eax
		;return (explo.m_id);
		mov		eax, [edi].m_id
	.endif
	ASSUME	esi:nothing, edi:nothing
	pop		edi
	pop		esi
	ret		8
CBulletManager@@CreateExplosive endp

;взорвать взрывчатку
align_proc
CBulletManager@@Explode proc id_explosive:dword, pPosition:dword, pDirection:dword, id_initiator:dword
local direction:Fvector4, position:Fvector4
;esi - this
	push	esi
	push	edi
	mov		esi, ecx
	ASSUME	esi:ptr CBulletManager, edi:ptr CBulletExplosive
	mov		ecx, id_explosive
	xor		eax, eax
	.if (ecx>=0 && ecx<LEVEL__MAX_COUNT_EXPLOSIVES)
		mov		edx, [esi].m_explo_ids
		mov		edi, [edx+ecx*4]	; explosive
		.if (edi && ![edi].m_explosion_flags)
			push	id_initiator
			mov		ecx, edi
			call	CExplosive@@SetInitiator
			ASSUME	edx:ptr Fvector4, eax:ptr Fvector4
			xorps	xmm2, xmm2
			mov		edx, pPosition
			Fvector4_set	position, [edx].x, [edx].y, [edx].z, 0
			movups	xmm0, position
			mov		edx, pDirection
			Fvector4_set 	direction, [edx].x, [edx].y, [edx].z, 0
			movups	xmm1, direction
			movss	xmm2, [edi].m_halflength_shell
			shufps	xmm2, xmm2, 11000000b	; 3000t
			mulps	xmm1, xmm2
			subps	xmm0, xmm1
			movups	position, xmm0
			ASSUME	edx:nothing, eax:nothing
			Fvector4_set 	direction, 0.0, 1.0, 0.0, 0
			mov		ecx, edi
			invoke	CBulletExplosive@@ExplodeParams, addr position, addr direction
			mov		ecx, edi
			call	CExplosive@@Explode
			mrm		[edi].m_fExplodeDuration, [edi].m_fExplodeDurationMax
			mov		eax, TRUE
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing
	pop		edi
	pop		esi
	ret		16
CBulletManager@@Explode endp

;удалить взрывчатку
align_proc
CBulletManager@@DeleteExplosive proc id_explosive:dword
;esi - this
;	mov		eax, id_explosive
;	PRINT_UINT "CBulletManager@@DeleteExplosive() id_explosive = %d", eax
	push	esi
	push	edi
	mov		esi, ecx
	ASSUME	esi:ptr CBulletManager, edi:ptr CBulletExplosive
	;CBulletExplosive*	del_explo = m_explo_ids[id_explosive];
	mov		ecx, id_explosive
	xor		eax, eax
	.if (ecx>=0 && ecx<LEVEL__MAX_COUNT_EXPLOSIVES)
		mov		edx, [esi].m_explo_ids
		mov		edi, [edx+ecx*4]	;del_explo
		.if (edi)
			;m_explo_ids[id_explosive] = NULL;
			mov		[edx+ecx*4], eax
			mov		ecx, edi
			call	CExplosive@@_CExplosive
			mov		eax, [esi].m_explosions._Mylast
			sub		eax, sizeof CBulletExplosive		;указатель на последний элемент
			.if ([esi].m_explosions._Myfirst!=eax && eax!=edi)	;если это не последний элемент, то последний элемент копируем на место удалёного.
				xr_memcopy	edi, eax, sizeof CBulletExplosive
				ASSUME	eax:ptr CBulletExplosive
				mov		[eax].CExplosive@vfptr, NULL		; знак(флаг) того, что этот объект уже удалён!
				ASSUME	eax:nothing
				;m_explo_ids[del_explo.m_id] = del_explo;
				mov		eax, [edi].m_id		;обновим в айдишнике указатель на перемещёный элемент.
				mov		edx, [esi].m_explo_ids
				mov		[edx+eax*4], edi
			.endif
			;m_explosions.pop_back();
			sub		[esi].m_explosions._Mylast, sizeof CBulletExplosive
			dec		[esi].m_explosions._Count
			;return (TRUE);
			mov		eax, TRUE
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing
	pop		edi
	pop		esi
	ret		4
CBulletManager@@DeleteExplosive endp

;конструктор
align_proc
CBulletExplosive@@CBulletExplosive proc
;eax - this
	ASSUME	eax:ptr CBulletExplosive
	call	CExplosive@@CExplosive
	mov		[eax].CExplosive@vfptr, offset vtbl@CBulletExplosive
	ASSUME	eax:nothing
	retn
CBulletExplosive@@CBulletExplosive endp

;---------------------------------------------------------------------------------------
;	Переопределяем виртуальные методы CBulletExplosive

align_proc
CBulletExplosive@@Initiator proc
	ASSUME	ecx:ptr CBulletExplosive
	xor		eax, eax
	mov		ax, [ecx].m_iCurrentParentID
	.if (ax==0FFFFh)
		mov		ax, [ecx].m_game_object_id
	.endif
	ASSUME	ecx:nothing
	retn
CBulletExplosive@@Initiator endp

align_proc
CBulletExplosive@@Load proc ini:dword, name_section:dword
	push	esi
	push	edi
	push	ebx
	mov		esi, ecx
	mov		ebx, name_section
	mov		edi, ini
	ASSUME	esi:ptr CBulletExplosive
	push	ebx
	push	edi
	call	CExplosive@@Load
	mov		[esi].m_bDynamicParticles, FALSE
	mov		[esi].m_bHideInExplosion, TRUE
	;m_halflength_shell = 0.f;
	mov		[esi].m_halflength_shell, 0
	; if(pSettings->line_exist(section, "halflength_shell"))
	push	offset aHalflength_shell 		; "halflength_shell"
	push	ebx
	mov		ecx, edi
	call	ds:line_exist ; CInifile::line_exist(char const *,char const *) ; 
	.if (eax)
		;m_halflength_shell = pSettings->r_float(section, "halflength_shell"));
		push	offset aHalflength_shell 	; "halflength_shell"
		push	ebx
		mov		ecx, edi
		call	ds:r_float		; CInifile::r_bool(char const *,char const *) ; 
		fstp	[esi].m_halflength_shell
	.endif
;	;
;	push	offset aWallmark_section			; "wallmark_section"
;	push	ebx
;	mov		ecx, edi
;	call	ds:line_exist
;	.if (eax)
;		
;	.endif
	ASSUME	esi:nothing
	pop		ebx
	pop		edi
	pop		esi
	ret		8
CBulletExplosive@@Load endp

align_proc
CBulletExplosive@@ExplodeParams proc pos_:dword, dir_:dword	
	ASSUME	ecx:ptr CBulletExplosive, edx:ptr Fvector
	or		[ecx].m_explosion_flags, flReadyToExplode
	mov		edx, pos_
	Fvector_set	[ecx].m_vExplodePos, [edx].x, [edx].y, [edx].z
	mov		edx, dir_
	Fvector_set	[ecx].m_vExplodeDir, [edx].x, [edx].y, [edx].z
	ASSUME	ecx:nothing, edx:nothing
	ret		8
CBulletExplosive@@ExplodeParams endp

;Здесь запускается событие взрыв, но в нашем случае взрыв запускается в другом методе. Так что заглушка.
align_proc
CBulletExplosive@@OnEvent proc	;P:dword, _type:word
	retn	8
CBulletExplosive@@OnEvent endp

;удаление объекта
align_proc
CBulletExplosive@@OnAfterExplosion proc
;ecx - this
	ASSUME	ecx:ptr CBulletExplosive
	;объект отработал, удаляем.
	mov		edx, ds:g_pGameLevel
	mov		eax, [edx]	; 
	push	[ecx].m_id
	mov		ecx, [eax].CLevel.m_pBulletManager
	call	CBulletManager@@DeleteExplosive
	ASSUME	ecx:nothing
	retn
CBulletExplosive@@OnAfterExplosion endp

align_proc
CBulletExplosive@@OnBeforeExplosion proc
	ASSUME	ecx:ptr CBulletExplosive
	mov     [ecx].m_bAlreadyHidden, FALSE
	ASSUME	ecx:nothing
	retn
CBulletExplosive@@OnBeforeExplosion endp

align_proc
CBulletExplosive@@GetExplVelocity proc v:dword
	ASSUME	edx:ptr Fvector
	xor		eax, eax
	mov     edx, v
	mov		[edx].x, eax
	mov		[edx].y, eax
	mov		[edx].z, eax
	ASSUME	edx:nothing
	ret		4
CBulletExplosive@@GetExplVelocity endp

;Здесь регистрируется событие взрыв, но нам тут это не нужно. Так что заглушка.
align_proc
CBulletExplosive@@GenExplodeEvent proc
	retn	8
CBulletExplosive@@GenExplodeEvent endp

;Найти нормаль, у нас объект не имеет оболочки. Так что вертикаль (0.f, 1.f, 0.f)
align_proc
CBulletExplosive@@FindNormal proc normal:dword
	ASSUME	edx:ptr Fvector
	mov		edx, normal
	Fvector_set	[edx], 0.0, 1.0, 0.0
	ASSUME	edx:nothing
	ret		4
CBulletExplosive@@FindNormal endp

;Нету такого класса у нас.
align_proc
CBulletExplosive@@cast_game_object proc
	xor		eax, eax
	retn
CBulletExplosive@@cast_game_object endp

align_proc
CBulletExplosive@@ActivateExplosionBox proc
	retn	8
CBulletExplosive@@ActivateExplosionBox endp

;скрыть объект. Скрывать нечего!
align_proc
CBulletExplosive@@HideExplosive proc
	ASSUME	ecx:ptr CBulletExplosive
	mov     [ecx].m_bAlreadyHidden, TRUE
	ASSUME	ecx:nothing
	retn
CBulletExplosive@@HideExplosive endp

;переместить партикл
align_proc
CBulletExplosive@@UpdateExplosionParticles proc
	retn
CBulletExplosive@@UpdateExplosionParticles endp
;---------------------------------------------------------------------------------------
;
OVERHEAD	= 171
; void __usercall CBulletManager::TestBullet(CBulletManager *this@<eax>)
align_proc
CBulletManager@@TestBullet proc uses esi
local TICS:_QWORD, dTics:real8
	mov		esi, eax
	xor		eax, eax
	CPUID					; не спариваемая инструкция
	RDTSC
	mov		TICS.lo, eax	; сохраняем его
	mov		TICS.hi, edx
	xor		eax, eax
	CPUID					; не спариваемая инструкция
	mov		eax, esi
	call	CBulletManager@@CommitRenderSet
	xor		eax, eax
	CPUID										; не спариваемая инструкция
	RDTSC										; снова читаем счетчик
	sub		eax, TICS.lo						; вычисляем разность
	sub		eax, OVERHEAD						; вычитаем такты, которые использовали
	sbb		edx, TICS.hi
	mov		TICS.lo, eax
	mov		TICS.hi, edx
	PRINT_UINT "tics int = %d", eax
	cvtpi2pd xmm0, TICS
	movsd	dTics, xmm0
	push	ecx
	push	ecx
	movsd	real8 ptr [esp], xmm0
	push	const_static_str$("tics = %.0f")
	call	Msg
	add		esp, 12
	;PRINT_UINT "tics = %d", eax
	
	ret
CBulletManager@@TestBullet endp
