;======================================================================
;	Project		: XRay - Extensions		
;	Module		: pyrotechnics.asm
;	Created		: 24.07.2019
;	Modified	: 06.08.2019
;	Author		: NanoBot
;	Description : Пиротехника. Люсткугель, звёзды.
;======================================================================
;-----типы пироэлементов-----
eNoPyroelement			= dword ptr -1		;
eZvezdka				= dword ptr 0		;обычная звёздка
eZvezdkaExplode			= dword ptr 1		;взрывная звёздка (может взрывается, например драконьи яйца)
eLustkugel				= dword ptr 2		;люсткугель, разбрасывает пироэлементы

;----------------------------
align_proc
Str_Copy proc str1:ptr byte, str2:ptr byte
	StrCopy(str1, str2)
	ret
Str_Copy endp

align_proc
parse_string proc uses ebx source:ptr byte, data:ptr dword, dest:ptr byte, max_count:dword
	StrCopy(source, dest)
	mov		edx, dest
	mov		ebx, data
	xor		ecx, ecx
	dec		max_count
	mov		[ebx+ecx*4], edx	;data[0] = dest
	ASSUME	edx:ptr byte, ebx:ptr dword
	.while (true)
		mov		al, [edx]
		inc		edx
		.break .if (al==0 || max_count==ecx)
		.if (al==',')
			mov		[edx-1], 0
			inc		ecx
			mov		[ebx+ecx*4], edx
		.endif
	.endw
	lea		eax, [ecx+1]
	ASSUME	edx:nothing, ebx:nothing
	ret
parse_string endp

;между векторами vec0 и vec1 90 град., векторы нормализованы, angle - рад. при 0 град указывает на vec0, при 90 град указывает на vec1
align_proc
Fvector4@@rotate_angle90 proc vec0:ptr Fvector4, vec1:ptr Fvector4, angle:real4
local scale_0:real4, scale_1:real4
;ecx	this	Fvector*
	mov		eax, vec0
	mov		edx, vec1
	;local scale_0, scale_1, vec = cos(angle), sin(angle), vector()
	fld		angle
	fsincos
	fstp	scale_0
	movss	xmm0, scale_0
	fstp	scale_1
	movss	xmm1, scale_1
	;vec.add(vec0.mul(scale_0), vec1.mul(scale_1))
	shufps	xmm0, xmm0, 00000000h	;0000v
	shufps	xmm1, xmm1, 00000000h	;0000v
	movups	xmm2, [eax].Fvector4
	mulps	xmm0, xmm2
	movups	xmm3, [edx].Fvector4
	mulps	xmm1, xmm3
	addps	xmm0, xmm1
	;return vec:normalize()
	Fvector4@normalize xmm0
	movups	[ecx].Fvector4, xmm0
	ret
Fvector4@@rotate_angle90 endp

;загрузка данных
align_proc
CExplosiveRocketPyro@@Load proc uses esi edi ebx sect:ptr byte
;ecx	this	CExplosiveRocket*
	ASSUME	esi:ptr CExplosiveRocket
	mov		esi, ecx
	mov		ebx, sect
;	PRINT_UINT "CExplosiveRocketPyro@@Load() sect='%s'", ebx
	@R_FLOAT(ebx, "start_speed")
	fstp	[esi].m_fStartSpeed
	mov		[esi].m_bCanContactExplo, false
	mov		[esi].m_bCanTimerExplo, false
	.if ([esi].m_type_element==eZvezdkaExplode || [esi].m_type_element==eLustkugel)
		mov		[esi].m_bCanTimerExplo, true
	.endif
	ASSUME	esi:nothing
	ret
CExplosiveRocketPyro@@Load endp

CExplosiveRocketPyro@@getCurrentRocket MACRO this_:req	;INLINE
	mov		eax, this_.m_SubElements._Myfirst
	.if (eax)
		mov		edx, this_.m_SubElements._Mylast
		.if (eax!=edx)
			lea		eax, [edx-size SStarParams]
		.else
			xor		eax, eax
		.endif
	.endif
	EXITM <eax>
ENDM

CExplosiveRocketPyro@@dropCurrentRocket MACRO this_:req	;INLINE
	mov		eax, this_.m_SubElements._Myfirst
	.if (eax && eax!=this_.m_SubElements._Mylast)
		sub		this_.m_SubElements._Mylast, size SStarParams
	.endif
	EXITM <>
ENDM

MAX_SEGMENTS_PYRO		= 64

SSectorParams struct
	angle			real4 ?
	speed			real4 ?
SSectorParams ends

;ВЫСТРЕЛ! создания списка пироэлементов в инвентаре объекта
align_proc
CExplosiveRocketPyro@@InitStart proc uses esi edi ebx 
local type_figure:dword, count_segments:dword, count_type:dword, count:dword, ii:dword, j:dword, jj:dword, DEG2RAD:real4
local SpeedDescent:real4, num_data:dword, tmp:real4, speed:real4, A:real4
local step:real4, angle:real4, angle0:real4, angle1:real4, sector:dword, count_sec:dword, cos_ang_c:real4, ang_c:real4, ang_b:real4
local step_h:real4, step_p:real4, h:real4, p:real4, disp:real4, dir:Fvector
local dir_forward:Fvector4, dir_up:Fvector4, dir_right:Fvector4, forward:Fvector4, right:Fvector4
local name_line[16]:byte, name_line2[24]:byte, segments[MAX_SEGMENTS_PYRO]:dword, angle_dir[MAX_SEGMENTS_PYRO]:SOrientedHP
local sector_gradient[128]:SSectorParams
local data[MAX_SEGMENTS_PYRO]:dword, str_data[4096]:byte, str_data2[64]:byte
	test	[ebp+1000h], eax	;пробное чтение сторожевой страницы
	mov		esi, ecx
	ASSUME	esi:ptr CExplosiveRocket
;	PRINT_UINT "CExplosiveRocketPyro@@InitStart() sect = '%s'", ebx
	mov		edx, [esi].NameSection.p_
	lea		ebx, [edx].str_value.value
	;---Зададим силу сопротивления воздуха, ввиде скорости свободного падения.
	@R_FLOAT(ebx, "speed_descent")
	fstp	SpeedDescent
	mov		ecx, esi
	CPhysicsShellHolder@@SetSpeedDescent(SpeedDescent)
	;-----------------------------
	.if ([esi].m_type_element==eLustkugel)	;инициализация люсткугеля, зарядим его пироэлементами!
		;Если люсткугель запустила батарея, то партикл и звук выстрела, запускаем в самом люсткугеле!!!
		;партикл выстрела
		.if ([esi].m_start_particles)
			CPhysicsShell@@get_LinearVel([esi].m_pPhysicsShell, &dir_up)
			mov		ecx, [esi].m_start_particles
			CScriptParticles@@PlayAtPosDir(&[esi].XFORM_.c_, &dir_up)
		.endif
		;звук выстрела
		.if ([esi].m_start_sound)
			ref_sound@@play_at_pos(&[esi].m_start_sound, NULL, &[esi].XFORM_.c_)
		.endif
		;----------------
		mov		type_figure, @R_U32(ebx, "type_figure")
		mov		edx, const_static_str$("element_")
		Str_Copy(edx, &name_line)
		mov		edx, const_static_str$("gradient_speed_")
		Str_Copy(edx, &name_line2)
		movflt	DEG2RAD, 0.01745329252
		and		ii, 0
		and		j, 0
		.for (edi=0: edi<MAX_SEGMENTS_PYRO: edi++)
			;name_line = "element_"..n
			@ITOA(edi, &name_line[8], 10)
			.break .if (!@LINE_EXIST(ebx, &name_line))
			mov		edx, @R_STRING(ebx, &name_line)
			parse_string(edx, &data, &str_data, MAX_SEGMENTS_PYRO)
			push	ebx
			.if (type_figure==0 || type_figure==3)
				dec		eax
				mov		count_type, eax		;count_type = #data-1
				mov		count, @ATOI(data[0*4])
				mov		num_data, 1
			.elseif (type_figure==1 || type_figure==2)
				sub		eax, 3
				mov		count_type, eax		;count_type = #data-3
				mov		count, @ATOI(data[0*4])
				;angle_dir[n].P = atof(data[1])*DEG2RAD;
				@ATOF(data[1*4])
				fmul	DEG2RAD
				fstp	angle_dir[edi*8].P
				;angle_dir[n].H = atof(data[2])*DEG2RAD;
				@ATOF(data[2*4])
				fmul	DEG2RAD
				fstp	angle_dir[edi*8].H
				mov		num_data, 3
				and		count_sec, 0
				@ITOA(edi, &name_line2[15], 10)
				.if (@LINE_EXIST(ebx, &name_line2))
					push	edi
					ASSUME	edi:ptr byte, edx:ptr byte
					mov		edi, @R_STRING(ebx, &name_line2)
					.for (ebx=0: [edi]: ebx++)
						lea		edx, str_data2
						.while (true)
							mov		al, [edi]
							.if (al==',')
								inc		edi
								xor		al, al
							.endif
							mov		[edx], al
							.break .if (al==0)
							inc		edi
							inc		edx
						.endw
						.if ([edi]==0)
							R_ASSERT  "Неполные данные!", "CExplosiveRocketPyro@@InitStart"
						.endif
						@ATOF(&str_data2)
						fmul	DEG2RAD
						fstp	sector_gradient[ebx*8].angle
						lea		edx, str_data2
						.while (true)
							mov		al, [edi]
							.if (al==',')
								inc		edi
								xor		al, al
							.endif
							mov		[edx], al
							.break .if (al==0)
							inc		edi
							inc		edx
						.endw
						@ATOF(&str_data2)
						fstp	sector_gradient[ebx*8].speed
					.endfor
					mov		count_sec, ebx
					ASSUME	edi:nothing, edx:nothing
					pop		edi
				;	PRINT_UINT "count_sec = %d", count_sec
				.endif
			.else
				R_ASSERT	"Unknown type_figure!", "CExplosiveRocketPyro@@InitStart"
			.endif
			;step = PI_MUL_2/count
			movflt	step, PI_MUL_2
			movss	xmm0, step
			cvtsi2ss xmm1, count
			divss	xmm0, xmm1
			movss	step, xmm0
			xor		eax, eax
			mov		sector, eax
			mov		angle, eax
			mov		angle0, eax
			mov		angle1, eax
			.for (ebx=count: ebx>0: ebx--)
				inc		j
				mov		edx, ii
				.if (edx>=count_type)
					xor		edx, edx
				.endif
				mov		ii, edx
				add		edx, num_data
				CRocketLauncher@@SpawnRocket(data[edx*4], esi)
				inc		ii
				.if (count_sec)
					movss	xmm0, angle
					.if (xmm0 >= angle1)
						mov		edx, sector
						mrm		angle0, sector_gradient[edx*8].angle
						movss	xmm5, sector_gradient[edx*8].speed		;=A
						movss	A, xmm5
						inc		edx
						;sector	= sector>count_sec and 1 or sector
						.if (edx>=count_sec)
							xor		edx, edx
						.endif
						movss	xmm3, sector_gradient[edx*8].angle
						.if (xmm3<angle0)
							;angle1 = angle1+PI_MUL_2
							addss	xmm3, FP4(PI_MUL_2)
						.endif
						movss	xmm4, sector_gradient[edx*8].speed		;=B
						movss	angle1, xmm3
						mov		sector, edx
						subss	xmm3, angle0	;ang_c = angle1 - angle0
						;cos_ang_c = cos(ang_c)
						movss	ang_c, xmm3
						fld		ang_c
						fcos
						fstp	cos_ang_c
						;ang_b = PI - acos((B-A*cos(ang_c))/sqrt(A*A+B*B-2*A*B*cos(ang_c))) - ang_c
						movss	xmm2, xmm4	;=B
						movss	xmm1, xmm5	;=A
						mulss	xmm1, cos_ang_c
						subss	xmm2, xmm1	;(B-A*cos_ang_c)
						movss	xmm1, xmm5	;=A
						movss	xmm0, xmm4	;=B
						mulss	xmm1, xmm1
						mulss	xmm0, xmm0
						addss	xmm1, xmm0	;A*A+B*B
						movss	xmm0, xmm5	;=A
						mulss	xmm0, xmm4	;*=B
						mulss	xmm0, cos_ang_c
						addss	xmm0, xmm0	;*2
						subss	xmm1, xmm0
						sqrtss	xmm0, xmm1	;sqrt(A*A+B*B-2*A*B*cos(ang_c))
						divss	xmm2, xmm0
						movss	cos_ang_c, xmm2
						fld		cos_ang_c
						call	_CIacos
						fchs
						fldpi
						fadd	
						fsub	ang_c
						fstp	ang_b
					.endif
					;ang_c1 = angle - angle0
					;speed = A*sin(ang_b)/sin(PI-ang_b-ang_c1)
					fld		ang_b
					fsin
					fmul	A
					fldpi
					fsub	ang_b
					fsub	angle
					fadd	angle0
					fsin
					fdiv
					fstp	speed
					;angle = angle+step
					movss	xmm0, angle
					addss	xmm0, step
					movss	angle, xmm0
				.else
					mrm		speed, [esi].m_fStartSpeed
				.endif
				mov		edx, xr_vector@@push_back(&[esi].m_SubElements, size(SStarParams))
				mrm		[edx].SStarParams.speed, speed
			.endfor
			pop		ebx
			mrm		segments[edi*4], count
		.endfor
		mov		count_segments, edi
		@R_FLOAT(ebx, "dispersion_base")
		fmul	DEG2RAD
		fstp	disp
		xor		edx, edx
		mov		h, edx		; угол по горизонтали(азимут)
		movflt	p, PI_DIV_2	; угол по вертикали(склонение)
		mov		step_h, edx	;=0;
		mov		ii, edx		;=0;
		and		[esi].m_number_pyro, 0
		ASSUME	ebx:ptr SStarParams
		mov		ebx, [esi].m_SubElements._Myfirst
		.if (type_figure==0)			; сфера
			movflt	step_p, PI
			movss	xmm0, step_p
			cvtsi2ss xmm1, edi
			divss	xmm0, xmm1
			movss	step_p, xmm0
			.for (edi=0: edi<count_segments: edi++)
				mov		eax, segments[edi*4]
				movflt	step_h, PI_MUL_2
				movss	xmm0, step_h
				cvtsi2ss xmm1, eax
				divss	xmm0, xmm1
				movss	step_h, xmm0
				mov		count_type, eax
				mov		h, 0
				.while (count_type)
					Fvector_setHP	dir, h, p
					movss	xmm0, disp
					.if (xmm0>FP4(0.0001))
						@random_dir(&dir, &dir, disp)
					.endif
					Fvector@@getH(&dir)
					fstp	[ebx].dir.H
					Fvector@@getP(&dir)
					fstp	[ebx].dir.P
					and		[ebx].m_rocket, 0
					;h=h+step_h
					movss	xmm0, h
					addss	xmm0, step_h
					movss	h, xmm0
					dec		count_type
					add		ebx, size SStarParams
				.endw
				;p=p-step_p
				movss	xmm0, p
				subss	xmm0, step_p
				movss	p, xmm0
			.endfor
		.elseif (type_figure==1)		; осесимметричная произвольная фигура
			.for (edi=0: edi<count_segments: edi++)
				mov		eax, segments[edi*4]
				movflt	step_h, PI_MUL_2
				movss	xmm0, step_h
				cvtsi2ss xmm1, eax
				divss	xmm0, xmm1
				movss	step_h, xmm0
				mov		count_type, eax
				mrm		h, angle_dir[edi*8].H
				.while (count_type)
					Fvector_setHP	dir, h, angle_dir[edi*8].P
					movss	xmm0, disp
					.if (xmm0>FP4(0.0001))
						@random_dir(&dir, &dir, disp)
					.endif
					Fvector@@getH(&dir)
					fstp	[ebx].dir.H
					Fvector@@getP(&dir)
					fstp	[ebx].dir.P
					and		[ebx].m_rocket, 0
					;h=h+step_h
					movss	xmm0, h
					addss	xmm0, step_h
					movss	h, xmm0
					dec		count_type
					add		ebx, size SStarParams
				.endw
			.endfor
		.elseif (type_figure==2)		; набор колец
			Fvector4_set  dir_forward,	0.0, 0.0, 1.0, 0.0
			Fvector4_set  dir_up, 		0.0, 1.0, 0.0, 0.0
			Fvector4_set  dir_right, 	1.0, 0.0, 0.0, 0.0
			.for (edi=0: edi<count_segments: edi++)
				mov		eax, segments[edi*4]
				movflt	step_h, PI_MUL_2
				movss	xmm0, step_h
				cvtsi2ss xmm1, eax
				divss	xmm0, xmm1
				movss	step_h, xmm0
				mov		count_type, eax
				mov		h, 0
				lea		ecx, forward
				Fvector4@@rotate_angle90(&dir_forward, &dir_up, angle_dir[edi*8].P)
				;tmp = angle_h[j] + DEG90	;DEG90 = PI_DIV_2
				movflt	tmp, PI_DIV_2
				movss	xmm0, angle_dir[edi*8].H
				addss	xmm0, tmp
				movss	tmp, xmm0
				lea		ecx, right
				Fvector4@@rotate_angle90(&forward, &dir_right, tmp)
				lea		ecx, forward
				Fvector4@@rotate_angle90(&forward, &dir_right, angle_dir[edi*8].H)
				.while (count_type)
					lea		ecx, dir
					Fvector4@@rotate_angle90(&forward, &right, h)
					movss	xmm0, disp
					.if (xmm0>FP4(0.0001))
						@random_dir(&dir, &dir, disp)
					.endif
					Fvector@@getH(&dir)
					fstp	[ebx].dir.H
					Fvector@@getP(&dir)
					fstp	[ebx].dir.P
					and		[ebx].m_rocket, 0
					;h=h+step_h
					movss	xmm0, h
					addss	xmm0, step_h
					movss	h, xmm0
					dec		count_type
					add		ebx, size SStarParams
				.endw
			.endfor
		.elseif (type_figure==3)		; случайный разлёт
			.for (edi=0: edi<count_segments: edi++)
				mrm		count_type, segments[edi*4]
				.while (count_type)
					Fvector@@random_dir(&dir)
					Fvector@@getH(eax)
					fstp	[ebx].dir.H
					Fvector@@getP(&dir)
					fstp	[ebx].dir.P
					and		[ebx].m_rocket, 0
					dec		count_type
					add		ebx, size SStarParams
				.endw
			.endfor
		.endif
		ASSUME	ebx:nothing
	.endif
;	PRINT_UINT "CExplosiveRocketPyro@@InitStart() this=%08X", esi
	ret
CExplosiveRocketPyro@@InitStart endp

;взрыв, запуск всех пироэлементов
align_proc	;launch_matrix:Fmatrix
CExplosiveRocketPyro@@Explode proc uses esi edi ebx
local radius_kugel:real4, radius:real4, dir:Fvector4, vel:Fvector4, P:NET_Packet
;ecx	this	CExplosiveRocket*_
	ASSUME	esi:ptr CExplosiveRocket, edi:ptr CExplosiveRocket, ebx:ptr SStarParams
	mov		esi, ecx
;	PRINT_UINT "CExplosiveRocketPyro@@Explode() this = %08X", esi
	CObject@@Radius(esi)
	fstp	radius_kugel
	mrm		[esi].m_IgnorCollideID, [esi].ID
	.while (true)
		mov		ebx, CExplosiveRocketPyro@@getCurrentRocket([esi])
		.break .if (ebx==NULL)
		mov		edi, [ebx].m_rocket	;rocket	CExplosiveRocket*
		lea		ecx, dir
		Fvector4@@rotate_angle90(&[esi].XFORM_.k, &[esi].XFORM_.j, [ebx].dir.H)
		lea		ecx, dir
		Fvector4@@rotate_angle90(&dir, &[esi].XFORM_.i, [ebx].dir.P)
		movss	xmm0, [ebx].speed
		shufps	xmm0, xmm0, 00000000h	;0000v
		movups	xmm1, dir
		mulps	xmm0, xmm1
		movups	vel, xmm0
		mov		ecx, edi	;this	CExplosiveRocket*
		CCustomRocket@@SetLaunchParams(&[esi].XFORM_, &vel, &zero_vel)
		;подкорректируем точку спавна на границу сферы. Чтобы было меньше колизий при старте!
		CObject@@Radius(edi)
		fstp	radius
		movss	xmm0, radius_kugel
		xorps	xmm1, xmm1
		subss	xmm0, radius
		.if (xmm0<xmm1)
			movss	xmm0, xmm1
		.endif
		shufps	xmm0, xmm0, 00000000h	;0000v
		movups	xmm1, dir
		mulps	xmm0, xmm1
		movups	xmm1, [edi].m_LaunchXForm.c_
		addps	xmm0, xmm1
		movups	[edi].m_LaunchXForm.c_, xmm0
		mrm		[edi].m_IgnorCollideID, [esi].ID
		mrm		[edi].m_iCurrentParentID, [esi].m_iCurrentParentID
		.if (OnServer())
			;u_EventGen(P, GE_LAUNCH_ROCKET, ID());
			movzx	edx, [esi].ID
			CGameObject@@u_EventGen(&P, GE_LAUNCH_ROCKET, edx)
			;P.w_u16(rocket->ID());
			mov		edx, P.B.count
			mrm		word ptr P.B.data[edx], [edi].ID
			add		P.B.count, 2
			;u_EventSend(P);
			CGameObject@@u_EventSend(&P)
		.endif
		CExplosiveRocketPyro@@dropCurrentRocket([esi])
	.endw
	ASSUME	esi:nothing, edi:nothing, ebx:nothing
	ret
CExplosiveRocketPyro@@Explode endp

align_proc
CExplosiveRocketPyro@@AttachRocket proc uses esi edi rocket_id:word
;ecx	this	CExplosiveRocket
	ASSUME	esi:ptr CExplosiveRocket, edi:ptr CExplosiveRocket
	mov		esi, ecx
	Level__Objects_net_Find	rocket_id
	smart_cast	CExplosiveRocket, CGameObject, eax
	mov		edi, eax	;pRocket
	mov		[edi].m_pOwner, CObject@@H_Root(esi)
	CObject@@H_SetParent(edi, esi)
	mov		ecx, [esi].m_SubElements._Myfirst
	.if (ecx)
		imul	eax, [esi].m_number_pyro, size SStarParams
		add		eax, ecx
		.if ([eax].SStarParams.m_rocket==NULL)
			mov		[eax].SStarParams.m_rocket, edi
		.endif
		inc		[esi].m_number_pyro
	.endif
	ASSUME	esi:nothing, edi:nothing
	ret
CExplosiveRocketPyro@@AttachRocket endp

align_proc
CExplosiveRocketPyro@@DetachRocket proc rocket_id:word, bLaunch:byte
	.if (!OnClient())
		mov		edx, Level@@Objects_net_Find(rocket_id)
		.if (edx)
			mrm		[edx].CExplosiveRocket.m_bLaunched, bLaunch
			CObject@@H_SetParent(edx, NULL)
		.endif
	.endif
	ret
CExplosiveRocketPyro@@DetachRocket endp

;регистрация пироэлементов
align_proc
CExplosiveRocketPyro@@OnEvent proc uses esi edi ebx P:ptr NET_Packet, type_:dword
;ecx	this	CExplosiveRocket
	mov		esi, ecx
	mov		edi, P
	mov		ebx, type_
	ASSUME	esi:ptr CExplosiveRocket, edi:ptr NET_Packet
	.if (bx==GE_OWNERSHIP_TAKE)
		;P.r_u16(id);
		mov		eax, [edi].r_pos
		mov		dx, word ptr [edi].B.data[eax]	;rocket_id
		add		[edi].r_pos, 2
		mov		ecx, esi
		CExplosiveRocketPyro@@AttachRocket(dx)
	.elseif (bx==GE_OWNERSHIP_REJECT || bx==GE_LAUNCH_ROCKET)
		;P.r_u16(id);
		mov		eax, [edi].r_pos
		mov		dx, word ptr [edi].B.data[eax]	;rocket_id
		add		[edi].r_pos, 2
		;bool	bLaunch = (type==GE_LAUNCH_ROCKET);
		cmp		bx, GE_LAUNCH_ROCKET
		setz	al
		CExplosiveRocketPyro@@DetachRocket(dx, al)
	.endif
	ASSUME	esi:nothing, edi:nothing
	ret
CExplosiveRocketPyro@@OnEvent endp
;------------------------------------------------------------------------
retrieveGeomUserData MACRO geom:req		;INLINE
	dGeomGetClass(geom)
	.if (eax==6)
		dGeomTransformGetGeom(geom)
	.else
		mov		eax, geom
	.endif
	dGeomGetData(eax)
	EXITM <eax>
ENDM

align_proc
CExplosiveLustkugel__ExitContactCallback proc C uses esi edi ebx do_colide:ptr byte, bo1:byte, cc:ptr dContact, material_1:ptr, material_2:ptr
	mov		ebx, cc
	ASSUME	ebx:ptr dContact, esi:ptr dxGeomUserData, edi:ptr dxGeomUserData
	;dxGeomUserData		*gd1<esi>=NULL, *gd2<edi>=NULL;
	.if (bo1)
		mov		esi, retrieveGeomUserData([ebx].geom.g1)
		mov		edi, retrieveGeomUserData([ebx].geom.g2)
	.else
		mov		edi, retrieveGeomUserData([ebx].geom.g1);
		mov		esi, retrieveGeomUserData([ebx].geom.g2);
	.endif
	ASSUME	ebx:nothing
	.if (edi && esi)
		mov		eax, [esi].callback_data
		.if ([edi].ph_ref_object==eax)
			mov		eax, do_colide
			mov		byte ptr [eax], false
			jmp		exit
		.endif
		smart_cast	CExplosiveRocket, CPhysicsShellHolder, [esi].ph_ref_object
		.if (eax)
			mov		ebx, eax
			smart_cast	CExplosiveRocket, CPhysicsShellHolder, [edi].ph_ref_object
			.if (eax)
				mov		dx, [eax].CExplosiveRocket.m_IgnorCollideID
				.if ([ebx].CExplosiveRocket.m_IgnorCollideID==dx)
					mov		eax, do_colide
					mov		byte ptr [eax], false
				.endif
			.endif
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing
exit:
	ret
CExplosiveLustkugel__ExitContactCallback endp
