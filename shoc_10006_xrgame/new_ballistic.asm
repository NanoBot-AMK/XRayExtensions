
; Перепишем полность метод CBulletManager::CalcBullet
; Главное чтобы наш код уместился в 928 байт!

static_xmm4		mask_vec4_to_vec3, 0FFFFFFFFh, 0FFFFFFFFh, 0FFFFFFFFh, 0	; маска для обнуления xmm0.w

;выравнивать не надо!!!
;bool CBulletManager::CalcBullet@<al>(u32 delta_time@<eax>, collide::rq_results *rq_storage@<edi>, SBullet *bullet@<esi>, CBulletManager *this)
CBulletManager@@CalcBullet proc (byte) uses ebx _this:dword
local cur_dir:Fvector4, cur_pos:Fvector4, range:real4, const_1p0:real4;, delta_time_sec:real4
local RD:collide@@ray_defs, bullet_data:bullet_test_callback_data
	ASSUME	edi:ptr collide@@rq_results, esi:ptr SBullet
	;float	delta_time_sec = float(delta_time)/1000.f;
	cvtsi2ss xmm0, eax
	mulss	xmm0, float_0p001
;	movss	delta_time_sec, xmm0
	;float		range = bullet->speed*delta_time_sec;
	mulss	xmm0, [esi].speed
	;float		max_range = bullet->max_dist - bullet->fly_dist;
	movss	xmm1, [esi].max_dist
	subss	xmm1, [esi].fly_dist
	;range = _min(range, max_range);
	minss	xmm0, xmm1
	movss	range, xmm0
	;bullet_data.pBullet			= bullet;
	;bullet_data.bStopTracing		= true;
	mov		bullet_data.pBullet, esi
	mov		bullet_data.bStopTracing, true
	;bullet->flags.ricochet_was		= 0;
	and		[esi].flags, not(ricochet_was)
	;//запомнить текущую скорость пули, т.к. в RayQuery() она может поменяться из-за рикошетов и столкновений с объектами
	;Fvector	cur_dir = bullet->dir;
	movups	xmm1, oword ptr [esi].dir
	movups	cur_dir, xmm1
	;collide::ray_defs		RD(bullet->pos, bullet->dir, range, CDB::OPT_CULL, collide::rqtBoth);
	Fvector_set1	RD.start, [esi].pos
	Fvector_set1	RD.dir, [esi].dir
	movss	RD.range, xmm0
	mov		RD.flags, 1
	mov		RD.tgt, 3
	;result = Level().ObjectSpace.RayQuery(rq_storage, RD, firetrace_callback, &bullet_data, test_callback, NULL);
	mov		ecx, ds:g_pGameLevel
	mov		eax, [ecx]
	lea		ecx, [eax].CLevel.ObjectSpace
	invoke2	CObjectSpace@@RayQuery, edi, addr RD, addr CBulletManager@@firetrace_callback, addr bullet_data, addr CBulletManager@@test_callback, NULL
	movss	xmm0, range
	.if (al & bullet_data.bStopTracing)
		;range = (rq_storage.r_begin()+rq_storage.r_count()-1)->range;
		mov		ebx, [edi].rq_results._Myfirst
		mov		ecx, [edi].rq_results._Mylast
		sub		ecx, ebx
		mov		eax, 2AAAAAABh
		imul	ecx
		sar		edx, 1
		mov		eax, edx
		shr		eax, 31
		add		eax, edx
		lea		edx, [eax+eax*2]
		movss	xmm0, [ebx+edx*4-sizeof collide__rq_result].collide__rq_result.range
	.endif
	;bullet->flags.skipped_frame = (Device.dwFrame >= bullet->frame_num);
	mov		eax, ds:Device
	mov		ecx, [eax].CRenderDevice.dwFrame
	cmp		ecx, [esi].frame_num
	sbb		edx, edx
	inc		edx
	shl		dl, 5
	xor		dl, byte ptr [esi].flags
	and		edx, skipped_frame
	xor		[esi].flags, dx
	;if(!bullet->flags.ricochet_was)	{
	.if (!([esi].flags & ricochet_was))
		movaps	xmm6, mask_vec4_to_vec3
		;range = _max(EPS_L, range);
		maxss	xmm0, float_0p001
		;//изменить положение пули
		;bullet->pos.mad(bullet->pos, cur_dir, range);
		movups	xmm1, cur_dir
		andps	xmm1, xmm6
		movups	xmm2, oword ptr [esi].pos
		shufps	xmm0, xmm0, 00000000b
		andps	xmm2, xmm6
		mulps	xmm1, xmm0
		addps	xmm2, xmm1
		movups	cur_pos, xmm2
		Fvector_set1	[esi].pos, cur_pos
		;bullet->fly_dist += range;
		movss	xmm1, [esi].fly_dist
		addss	xmm1, xmm0
		movss	[esi].fly_dist, xmm1
		;if(bullet->fly_dist>=bullet->max_dist)
		.if (xmm1>=[esi].max_dist)
			return	false
		.endif
		;if(!Fbox4::point_in_box(m_BoundingVolume, bullet->pos))
		mov		ebx, _this
		ASSUME	ebx:ptr CBulletManager
		.if (!Fbox4@point_in_box([ebx].m_BoundingVolume, xmm2))
			return	false
		.endif
		xorps	xmm2, xmm2
		movflt	const_1p0, 1.0
		;//изменить скорость и направление ее полета и с учетом гравитации
		movups	xmm7, oword ptr [esi].dir
		andps	xmm7, xmm6
		;float	k_speed = bullet->air_resistance;
		movss	xmm2, const_1p0
		movss	xmm0, [esi].air_resistance
		;if (m_type_ballistic != 0)	k_speed *= bullet->speed;
		.if ([ebx].m_type_ballistic!=0)	; мультиплейер или неоригинальная баллистика.
			mulss	xmm0, [esi].speed
		.endif
		;bullet->dir.mul(bullet->speed*(1.0-k_speed));
		subss	xmm2, xmm0
		mulss	xmm2, [esi].speed
		shufps	xmm2, xmm2, 11000000b
		mulps	xmm7, xmm2
		xorps	xmm1, xmm1
		;bullet->dir.sub(m_vecGravityConstDeltaTime);
		subps	xmm7, [ebx].m_vecGravityConstDeltaTime
		;bullet->speed = bullet->dir.magnitude();
		Fvector4@magnitude	xmm7
		movss	xmm1, const_1p0
		movss	[esi].speed, xmm0
		;bullet->dir.div(bullet->speed);
		divss	xmm1, xmm0
		shufps	xmm1, xmm1, 11000000b
		mulps	xmm7, xmm1
		movups	cur_dir, xmm7
		Fvector_set1	[esi].dir, cur_dir
	.endif
	;return (m_fMinBulletSpeed < bullet->speed);
	movss	xmm0, m_fMinBulletSpeed
	comiss	xmm0, [esi].speed
	setb	al
	ASSUME	edi:nothing, esi:nothing, ebx:nothing
	ret
CBulletManager@@CalcBullet endp

align_proc
SBullet__Init_callback proc
;esi - *bullet
	ASSUME	esi:ptr SBullet, edi:ptr CCartridge, ebx:ptr CBulletManager, ecx:ptr CLevel
	;========================================
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	mov		ebx, [ecx].m_pBulletManager
	mov		dl, [ebx].m_type_ballistic
	cvtsi2ss xmm0, [ebx].m_dwStepTime
	mulss	xmm0, float_0p001
	.if (dl==0)	; синглплейер
		mulss	xmm0, [ebx].m_fAirResistanceK
	.elseif (dl==1)	; мультиплейер
		mulss	xmm0, [esi].air_resistance
		divss	xmm0, [esi].max_speed
	.else	; type == 2
		mulss	xmm0, [esi].air_resistance
		mulss	xmm0, float_0p001	;/=1000
	.endif
	movss	[esi].air_resistance, xmm0
	ASSUME	ecx:nothing
	;========================================
	; Колбек на старт пули.
	; bullet->m_dwID = g_dwTotalShots++
	mov		eax, [ebx].m_dwTotalShots
	inc		eax
	mov		[esi].m_dwID, eax
	mov		[ebx].m_dwTotalShots, eax
	; bullet->flags.callback_on = cartridge.m_flags.test(CCartridge::cfCallbackOn);
	.if ([edi].m_flags & cfCallbackOn)
		or		[esi].flags, bull_callback_on
		; CObject	*weapon = Level().Objects.net_Find(bullet->weapon_id);
		movzx	ecx, [esi].weapon_id
		Level__Objects_net_Find	 ecx
		.if (eax)
			; weapon->callback(eWeaponStartBullet)(cartridge, bullet);
			CALLBACK__INT_INT	eax, eWeaponStartBullet, edi, esi
		.endif
	.endif
	.if ([edi].m_flags & cfShellExplosive)
		mov		edx, ds:pSettings ; CInifile * pSettings
		push	offset aSect_explosive	; "sect_explosive"
		mov		eax, [edi].m_ammoSect
		add		eax, 12
		push	eax
		mov		ecx, [edx]
		call	ds:r_string
		movzx	edx, [esi].weapon_id
		mov		ecx, ebx
		invoke	CBulletManager@@CreateExplosive, eax, edx
		.if (ax!=0FFFFh)
			;explosive_id = explo_id;
			mov		[esi].explosive_id, ax
			;flags.set(shell_explosive, TRUE);
			or		[esi].flags, shell_explosive
		.endif
	.endif
	mrm		[esi].m_tracer_width, [edi].m_tracer_width
	ASSUME	esi:nothing, edi:nothing, ebx:nothing
	pop		edi
	pop		ebp
	pop		ebx
	retn	24h
SBullet__Init_callback endp
