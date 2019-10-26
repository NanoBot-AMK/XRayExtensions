; 		Баллистический вычислитель
; Расчёт упрежденной позицией.
; Ballistic calculator
; The calculation of the anticipated position.

bullet_info struct
	k_air_res				real4 ?
	delta_time_sec			real4 ?
	gravi_const				real4 ?
	sqr_min_dist_target		real4 ?
	bullet_speed			real4 ?
	threshold_vel_x			real4 ?
	m_type_ballistic		byte ?
							byte ? ; undefined
							byte ? ; undefined
							byte ? ; undefined
bullet_info ends

; Пуля вылетает из pos_start со скоростью start_bullet_speed в точку pos_target 
; Функция возвращает через указатель: h_line_throw и time_bullet, это высота падения м. и точное подлётное время сек.
; и так же возвращает булеву true если цель достижима, или false если нет.
;bool calc_bullet(const Fvector4& pos_start, const Fvector4& pos_target, const bullet_info* bullet, float& h_line_throw, float& time_bullet)
align_proc
calc_bullet proc uses ebx pos_start:ptr, pos_target:ptr, bullet:ptr, h_line_throw:ptr, time_bullet:ptr
local bullet_dir:Fvector4, const_1p0:Fvector4	;, bullet_pos:Fvector4, bullet_pos_last:Fvector4, time_bull:dword
local h_line_throw_target:dword, dist_target:dword
	;const_1p0.set(1.0, 1.0, 0.0, 0.0);
	xorps	xmm0, xmm0
	movups	const_1p0, xmm0
	movflt	eax, 1.0
	mov		const_1p0.x, eax
	mov		const_1p0.y, eax
	; Fvector4	xmm3 = bullet_pos = pos_target
	mov		ecx, pos_target
	mov		eax, pos_start
	mov		edx, bullet
	ASSUME	eax:ptr Fvector4, ecx:ptr Fvector4, edx:ptr bullet_info
	movups	xmm0, [ecx]
	movups	xmm1, [eax]
	; pos_target.sub(bullet_pos)
	subps	xmm0, xmm1	; 
	movaps	xmm4, xmm0
	;movups	bullet_dir, xmm4
	; dist_xz =pos_target.sub(bullet_pos).magnitude_xz()	// вычислим длину вектора xmm0
	mulps	xmm0, xmm0
	movss	xmm1, xmm0
	shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
	addss	xmm0, xmm1				; xmm0 = z + xmm1
	sqrtss	xmm0, xmm0
	movss	dist_target, xmm0	; dist
	movss	xmm4, xmm0	; bullet_dir.x = dist_xz
	shufps	xmm4, xmm4, 11110100b	; 3310t
	; bullet_dir.set_length(start_bullet_speed);
	movaps	xmm0, xmm4
	mulps	xmm0, xmm0
	movss	xmm1, xmm0
	shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
	addss	xmm0, xmm1				; xmm0 = y + xmm1
	;haddps	xmm0, xmm0
	; bullet_pos.set(0,0);
	xorps	xmm3, xmm3	; bullet_pos
	sqrtss	xmm0, xmm0
	.if (xmm0 == xmm3)
		mov		al, false
		ret
	.endif
	movss	xmm1, [edx].bullet_speed
	divss	xmm1, xmm0
	shufps	xmm1, xmm1, 00000000b	; 0000t
	mulps	xmm4, xmm1	; xmm4 = bullet_dir
	movups	bullet_dir, xmm4
	; xmm7 = bullet.delta_time_sec;
	xorps	xmm7, xmm7
	movss	xmm7, [edx].delta_time_sec
	shufps	xmm7, xmm7, 11110000b	; 3300t
	; Ktrn_delta_time = 1.0-bullet.k_air_res;
	xorps	xmm6, xmm6
	movss	xmm6, [edx].k_air_res
	shufps	xmm6, xmm6, 11110000b	; 3300t
	; gravi_delta_time.set(0, 0, m_fGravityConst*delta_time_sec, 0);
	xorps	xmm5, xmm5
	movss	xmm5, [edx].gravi_const
	shufps	xmm5, xmm5, 11100011b	; 3203t
	mulps	xmm5, xmm7
	; k_angle:=bullet_dir.y/bullet_dir.x;
	movss	xmm2, bullet_dir.y
	movss	xmm0, bullet_dir.x	; 
	.if (xmm0 == xmm3)
		mov		al, false
		ret
	.endif
	divss	xmm2, xmm0
	mulss	xmm2, dist_target
	movss	h_line_throw_target, xmm2	; 
	; time_it = 0;
	xor		ebx, ebx
	mov		cl, [edx].m_type_ballistic
	align 16
	.repeat
		;// изменить положение пули
		; bullet_pos_last.mad(bullet_pos, bullet_dir, delta_time_sec);	85.1021
		movaps	xmm0, xmm4
		movaps	xmm2, xmm3	;bullet_pos_last
		mulps	xmm0, xmm7
		addps	xmm2, xmm0
		; if(bullet_pos_last.x>=dist_target) break;
		mov		al, true
		.break .if (xmm2 >= dist_target)
		;bullet_dir.mul(Ktrn_delta_time)
		.if (cl!=0)	; мультиплейер или неоригинальная баллистика.
			movaps	xmm1, xmm4
			mulps	xmm1, xmm1
			movss	xmm0, xmm1
			shufps	xmm1, xmm1, 11100101b	; 3211v
			addss	xmm1, xmm0
			sqrtss	xmm1, xmm1
			movss	xmm0, const_1p0
			mulss	xmm1, xmm6
			subss	xmm0, xmm1
			shufps	xmm0, xmm0, 11100000b	; 3200v
		.else
			movups	xmm0, const_1p0
			subps	xmm0, xmm6
		.endif
		mulps	xmm4, xmm0
		inc		ebx		;time_it++;
		; bullet_dir.y -= m_fGravityConst*delta_time_sec;
		subps	xmm4, xmm5
		; bullet_pos.set(bullet_pos_last);
		movaps	xmm3, xmm2
		; if (bullet_dir.x<threshold_vel_x) break;
		mov		al, false
	.until (xmm4 < [edx].threshold_vel_x)	; контролируем горизонтальную скорость
	.if (al)
		; d_time=(dist_target-bullet_pos_last.x)/bullet_dir.x;	// подлётное время от последней итерации к цели по горизонтали	85.1021 2241
		movss	xmm1, dist_target
		subss	xmm1, xmm3
		divss	xmm1, xmm4
		; time_bullet* = (float)time_it*delta_time_sec + d_time;
		mov		ecx, time_bullet
		cvtsi2ss xmm2, ebx
		mulss	xmm2, [edx].delta_time_sec
		addss	xmm2, xmm1
		movss	real4 ptr [ecx], xmm2
		;// уточним падение относительно линии бросания
		; надо узнать высоту пули в момент косания вертикали цели.
		; float h_line_throw = h_line_throw_target - (bullet_pos.y + bullet_dir.y * d_time);
		shufps	xmm3, xmm3, 11111101b	; 3331t	// xmm3.0 = xmm3.y
		shufps	xmm4, xmm4, 11111101b	; 3331t	// xmm4.0 = xmm4.y
		mulss	xmm4, xmm1
		addss	xmm3, xmm4
		movss	xmm0, h_line_throw_target	; высота точки бросания у цели
		subss	xmm0, xmm3
		mov		ecx, h_line_throw
		movss	real4 ptr [ecx], xmm0
	.endif
	ASSUME	eax:nothing, ecx:nothing, edx:nothing
	ret
calc_bullet endp

static_str		aMin_dist_target, "min_dist_target"
static_str		aThreshold_vel_x, "threshold_vel_x"

; расчёт упреждающей точки для движущейся цели
align_proc
;BOOL calc_future_position(const Fvector& ppos_start, float bullet_speed, float k_air_res, const Fvector& velocity_target, Fvector& res_pos_target)
calc_future_position proc uses esi ppos_start:dword, bullet_speed:dword, k_air_res:dword, velocity_target:dword, res_pos_target:dword
local pos_start:Fvector4, pos_target:Fvector4, dir_vel_target:Fvector4, result_pos_target:Fvector4
local future_pos_target:Fvector4, bullet_pos:Fvector4, start_pos_target:Fvector4, dist:dword, result:byte
local h_line_throw:dword, time_bullet:dword, bullet:bullet_info
	; result_pos_target.set(res_pos_target.x, res_pos_target.y, res_pos_target.z, 0);
	mov		ecx, res_pos_target
	ASSUME	ecx:ptr Fvector4
	Fvector4_set	result_pos_target, [ecx].x, [ecx].y, [ecx].z, 0
	movups	xmm0, result_pos_target
	movups	start_pos_target, xmm0
	; pos_start.set(ppos_start.x, ppos_start.y, ppos_start.z, 0);
	mov		ecx, ppos_start
	Fvector4_set	pos_start, [ecx].x, [ecx].y, [ecx].z, 0
	ASSUME	ecx:nothing
	; pos_target.set(result_pos_target);
	movups	xmm0, result_pos_target
	movups	pos_target, xmm0
	; dir_vel_target.set(velocity_target);
	mov		ecx, velocity_target
	movups	xmm0, [ecx]
	movups	dir_vel_target, xmm0
	mov		dir_vel_target.w, 0
	; bullet.sqr_min_dist_target = READ_IF_EXISTS(pSettings, r_float, "bullet_manager", "min_dist_target", 0.1f);
	movflt	bullet.sqr_min_dist_target, 0.1
	.if	(@LINE_EXIST(&aBullet_manager, &aMin_dist_target))
		@R_FLOAT (&aBullet_manager, &aMin_dist_target)
		fstp    bullet.sqr_min_dist_target
	.endif
	; bullet.sqr_min_dist_target *= bullet.sqr_min_dist_target;
	movss	xmm0, bullet.sqr_min_dist_target
	mulss	xmm0, xmm0
	movss	bullet.sqr_min_dist_target, xmm0
	; bullet.threshold_vel_x = READ_IF_EXISTS(pSettings, r_float, "bullet_manager", "threshold_vel_x", 1.0f);
	movflt	bullet.threshold_vel_x, 1.0
	.if	(@LINE_EXIST(&aBullet_manager, &aThreshold_vel_x))
		@R_FLOAT (&aBullet_manager, &aThreshold_vel_x)
		fstp    bullet.threshold_vel_x
	.endif
	; bullet.delta_time_sec = (float)(Level().BulletManager().m_dwStepTime)*0.001f;
	mov		ecx, ds:g_pGameLevel
	mov		eax, [ecx]
	mov		ecx, [eax].CLevel.m_pBulletManager	; CBulletManager*
	ASSUME	ecx:ptr CBulletManager
	cvtsi2ss xmm0, [ecx].m_dwStepTime		; time_step
	mulss	xmm0, FP4(0.001)
	movss	bullet.delta_time_sec, xmm0
	; bullet.gravi_const = Level().BulletManager().m_fGravityConst;
	mrm		bullet.gravi_const, [ecx].m_fGravityConst	; gravity_const
;	.if([ecx].m_type_ballistic==0)
;		mov		eax, [ecx].m_fAirResistanceK
;	.else
;		mov		eax, k_air_res
;	.endif
;	mov		bullet.k_air_res, eax
	mov		dl, [ecx].m_type_ballistic
	mov		bullet.m_type_ballistic, dl
	.if (dl==0)	; синглплейер
		mulss	xmm0, [ecx].m_fAirResistanceK
	.elseif (dl==1)	; мультиплейер
		mulss	xmm0, k_air_res
		divss	xmm0, bullet_speed
	.else	; type == 2
		mulss	xmm0, k_air_res
		mulss	xmm0, float_0p001	;/=1000
	.endif
	movss	bullet.k_air_res, xmm0
	mrm		bullet.bullet_speed, bullet_speed
	xor		esi, esi
	.repeat
		inc		esi
		; выстрелим в result_pos_target и определим: высоту падения пули, и её подлётное время.
		; if (!calc_bullet(pos_start, result_pos_target, &bullet, &h_line_throw, &time_bullet))	break;
		calc_bullet(&pos_start, &result_pos_target, &bullet, &h_line_throw, &time_bullet)
		.break .if (!al);al==false
		; // определим позицию цели за время подлёта пули
		; future_pos_target.add(pos_target, Fvector4().mul(dir_vel_target, time_bullet));
		movups	xmm0, dir_vel_target
		movss	xmm1, time_bullet
		shufps	xmm1, xmm1, 00000000b	; 0000t
		mulps	xmm0, xmm1
		movups	xmm2, pos_target
		addps	xmm0, xmm2
		movaps	xmm4, xmm0	;future_pos_target
		; bullet_pos.set(result_pos_target);
		movups	xmm3, result_pos_target
		; bullet_pos.y -= h_line_throw;	// пуля просела на h_line_throw метров.
		xorps	xmm5, xmm5
		movss	xmm5, h_line_throw
		shufps	xmm5, xmm5, 11100001b	; 3201t
		subps	xmm3, xmm5	; bullet_pos
		; стреляем в будущую точку цели, плюс добавим высоту падения пули на этой дистанции.
		; result_pos_target.set(future_pos_target);
		; result_pos_target.y += h_line_throw;
		addps	xmm4, xmm5
		movups	result_pos_target, xmm4
		; определим дистанцию между пулей у цели и самой целью.
		; float dist_sqr = bullet_pos.distance_to_sqr(future_pos_target);
		movups	future_pos_target, xmm0
		movups	bullet_pos, xmm3
		subps	xmm0, xmm3
		mulps	xmm0, xmm0
		movss	xmm1, xmm0
		shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
		addss	xmm1, xmm0				; xmm1 = x + y
		shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
		addss	xmm0, xmm1				; xmm0 = z + xmm1
		.break .if (esi>1000)	; костыль для особо сложных ситуаций.
		; if(dist_sqr<sqr_min_dist_target) break;	// пуля у цели!!!
	.until (xmm0<bullet.sqr_min_dist_target)
	mov		result, al
	; res_pos_target.set(result_pos_target.x, result_pos_target.y, result_pos_target.z);
	ASSUME	ecx:ptr Fvector
	mov		ecx, res_pos_target
	Fvector_set [ecx], result_pos_target.x, result_pos_target.y, result_pos_target.z
	ASSUME	ecx:nothing
	movzx	eax, result
	ret
calc_future_position endp

