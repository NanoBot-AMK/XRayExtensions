
align_proc
TransferenceToThrowVel proc in_transference_out_vel:ptr Fvector4, time:real4, gravity_accel:real4
;	in_transference_out_vel.mul(1.f/time);
	mov		edx, in_transference_out_vel
	movss	xmm2, time
	movflt	xmm1, 1.0
	divss	xmm1, xmm2
	shufps	xmm1, xmm1, 00000000b	; 0000v
	movups	xmm0, [edx].Fvector4
	mulps	xmm0, xmm1
	movups	[edx].Fvector4, xmm0
;	in_transference_out_vel.y += time*gravity_accel/2.f;
	mulss	xmm2, gravity_accel
	mulss	xmm2, FP4(0.5)
	movss	xmm0, [edx].Fvector4.y
	addss	xmm0, xmm2
	movss	[edx].Fvector4.y, xmm0
	ret
TransferenceToThrowVel endp

align_proc
ThrowMinVelTime proc transference:ptr Fvector4, gravity_accel:real4
;return _sqrt(2.f*transference.magnitude()/gravity_accel);
	mov		edx, transference
	Fvector4@magnitude [edx].Fvector4
	addss	xmm0, xmm0	;*2.f
	divss	xmm0, gravity_accel
	sqrtss	xmm0, xmm0
	ret
ThrowMinVelTime endp

const_static_xmm4		const_xmm_fchs, 80000000h, 80000000h, 80000000h, 80000000h
const_static_xmm4		const_xmm_fabs, 7FFFFFFFh, 7FFFFFFFh, 7FFFFFFFh, 7FFFFFFFh
const_static_xmm4		const_xmm_0p5, 0.5, 0.5, 0.5, 0.5

;// result = start_position + velocity*time + gravity*time*time*0.5
trajectory_get_position MACRO result:req, start_position:req, velocity:req, gravity:req, time:req
	movss	xmm2, time
	shufps	xmm2, xmm2, 00000000b	; 0000v
	movups	xmm0, velocity
	mulps	xmm0, xmm2
	movups	xmm1, start_position
	addps	xmm0, xmm1
	movups	xmm1, gravity
	mulps	xmm2, xmm2
	mulps	xmm2, const_xmm_0p5
	addps	xmm0, xmm2
	movups	result, xmm0
	EXITM	<>
ENDM

align_proc
trajectory_pick_error proc uses ebx low_:real4, high_:real4, position:ptr Fvector4, velocity:ptr Fvector4, gravity:ptr Fvector4
local start:Fvector4, target:Fvector4, start_to_max_error:Fvector4, magnitude:real4
	mov		eax, position
	mov		ecx, velocity
	mov		edx, gravity
	trajectory_get_position(start, [eax].Fvector4, [ecx].Fvector4, [edx].Fvector4, low_)
	trajectory_get_position(target, [eax].Fvector4, [ecx].Fvector4, [edx].Fvector4, high_)
	;max_error_time = (low_+high_)*0.5f;
	movss	xmm0, low_
	addss	xmm0, high_
	mulss	xmm0, const_xmm_0p5
	trajectory_get_position(start_to_max_error, [eax].Fvector4, [ecx].Fvector4, [edx].Fvector4, xmm0)
	movups	xmm2, start
	subps	xmm0, xmm2
	movaps	xmm4, xmm0	;start_to_max_error
	Fvector4@magnitude	xmm0
	movss	magnitude, xmm0
	movflt	xmm3, 1.0
	movss	xmm1, xmm3
	divss	xmm1, xmm0
	shufps	xmm1, xmm1, 00000000b	; 0000v
	mulps	xmm4, xmm1	;start_to_max_error.mul(1.f/magnitude);
	;Fvector	start_to_target = Fvector().sub(target,start).normalize();
	movups	xmm0, target
	subps	xmm0, xmm2
	Fvector4@normalize	xmm0
	movaps	xmm1, xmm0
	Fvector4@dotproduct	xmm4, xmm1
	;float	sine_alpha = _sqrt(1.f - _sqr(cosine_alpha));
	mulss	xmm0, xmm0
	subss	xmm3, xmm0
	sqrtss	xmm0, xmm3
	;return (magnitude*sine_alpha);
	mulss	xmm0, magnitude
	ret
trajectory_pick_error endp

align_proc
trajectory_select_pick_time proc uses ebx start0:ptr real4, high_:real4, start:ptr Fvector4, velocity:ptr Fvector4, gravity:ptr Fvector4, epsilon:real4
local low_:real4, check_time:real4, time_epsilon:real4
	mov		eax, start
	mrm		low_, [eax]
	mrm		check_time, high_
	;float	time_epsilon = .1f / velocity.magnitude();
	mov		edx, velocity
	Fvector4@magnitude [edx].Fvector4
	movflt	xmm1, 0.1
	divss	xmm1, xmm0
	.while (true)
		;fsimilar(low, high, time_epsilon)
		movss	xmm0, low_
		subss	xmm0, high_
		andps	xmm0, ds:const_xmm_fabs
		.break .if (xmm0<time_epsilon)
		;float	distance = 
		trajectory_pick_error(start0, check_time, start, velocity, gravity);
		.if (xmm0 < epsilon)
			mrm		low_, check_time
		.else
			mrm		high_, check_time
		.endif
		;check_time		= (low_ + high_)*.5f;
		movss	xmm0, low_
		addss	xmm0, high_
		mulss	xmm0, const_xmm_0p5
		movss	check_time, xmm0
	.endw
	movss	xmm0, low_
	ret
trajectory_select_pick_time endp

align_proc
trajectory_query_callback proc result:ptr collide__rq_result, params:ptr
	;*(float*)params	= result.range;
	mov		edx, result
	mov		eax, [edx].collide__rq_result.range
	mov		ecx, params
	mov		[ecx], eax
	xor		eax, eax
	ret
trajectory_query_callback endp
;, ignor_obj:ptr
align_proc
trajectory_check_collision proc low_:real4, high_:real4, position:ptr Fvector4, velocity:ptr Fvector4, gravity:ptr Fvector4, \
								obj:ptr, collide_pos:ptr Fvector4, tmp_rq_results:ptr collide@@rq_results
local start:Fvector4, target:Fvector4, start_to_target:Fvector4
local distance:real4, range:real4, ray_defs:collide@@ray_defs, previous_enabled:byte, throw_ignore_object_enabled:byte
	mov		eax, position
	mov		ecx, velocity
	mov		edx, gravity
	trajectory_get_position(start, [eax].Fvector4, [ecx].Fvector4, [edx].Fvector4, low_)
	trajectory_get_position(target, [eax].Fvector4, [ecx].Fvector4, [edx].Fvector4, high_)
	;Fvector	start_to_target = Fvector().sub(target, start);
	movups	xmm2, target
	movups	xmm1, start
	subps	xmm2, xmm1
	movups	start_to_target, xmm2
	;float		distance = start_to_target.magnitude();
	Fvector4@magnitude	xmm2
	movss	distance, xmm0
	.if (xmm0 < FP4(0.01))
		xor		al, al
		ret
	.endif
	;start_to_target.mul(1.f/distance);
	movflt	xmm1, 1.0
	divss	xmm1, xmm0
	shufps	xmm1, xmm1, 00000000b	; 0000v
	mulps	xmm2, xmm1
	movups	start_to_target, xmm2
	;collide::ray_defs	ray_defs(start, start_to_target, distance, CDB::OPT_CULL, collide::rqtBoth);
	Fvector_set1	ray_defs.start, start
	Fvector_set1	ray_defs.dir, start_to_target
	mov		eax, distance
	mov		ray_defs.range, eax
	mov		ray_defs.flags, 1
	mov		ray_defs.tgt, 3
	mov		range, eax		;float range = distance;
	;BOOL	previous_enabled = self_object->getEnabled();
	mov		edx, obj
	ASSUME	edx:ptr CObject
	mov		al, [edx].Props.flags
	and		al, bEnabled
	mov		previous_enabled, al
	;self_object->setEnabled(FALSE);
	and		[edx].Props.flags, not bEnabled
;	mov		edx, ignor_obj
;	mov		throw_ignore_object_enabled, false
;	.if (edx)
;		;throw_ignore_object_enabled	= ignored_object->getEnabled();
;		mov		al, [edx].Props.flags
;		and		al, bEnabled
;		mov		throw_ignore_object_enabled, al
;		;ignored_object->setEnabled(FALSE);
;	.endif
	;Level().ObjectSpace.RayQuery(tmp_rq_results, ray_defs, trajectory_query_callback, &range, NULL, self_object);
	mov		ecx, ds:g_pGameLevel
	mov		eax, [ecx]
	lea		ecx, [eax].CLevel.ObjectSpace
	invoke2	CObjectSpace@@RayQuery, tmp_rq_results, addr ray_defs, addr trajectory_query_callback, addr range, NULL, obj
;	mov		edx, ignor_obj
;	.if (edx)
;		;ignored_object->setEnabled(throw_ignore_object_enabled);
;		mov		al, [edx].Props.flags
;		or		al, throw_ignore_object_enabled
;		mov		[edx].Props.flags, al
;	.endif
	;self_object->setEnabled(previous_enabled);
	mov		edx, obj
	mov		al, [edx].Props.flags
	or		al, previous_enabled
	mov		[edx].Props.flags, al
	ASSUME	edx:nothing
	movss	xmm0, range
	.if (xmm0 < distance)
		;collide_pos.mad(start, start_to_target, range);
		shufps	xmm0, xmm0, 00000000b	; 0000v
		movaps	xmm1, start_to_target
		mulps	xmm0, xmm1
		movaps	xmm1, start
		addps	xmm0, xmm1
		mov		eax, collide_pos
		movaps	[eax].Fvector4, xmm0
	.endif
	;return (range == distance);
	movss	xmm0, range
	mov		al, false
	.if (xmm0 == distance)
		mov		al, true
	.endif
	ret
trajectory_check_collision endp
 
align_proc
trajectory_intersects_geometry proc trTime:real4, trStart:ptr Fvector4, trEnd:ptr Fvector4, trVel:ptr Fvector4, gravity:real4, obj:ptr, ignor_obj:ptr
local vGravity:Fvector4, collide_pos:Fvector4, tmp_rq_results:collide@@rq_results
local epsilon:real4, _low:real4, _high:real4, time:real4
	Fvector4_set	collide_pos, flt_max, flt_max, flt_max, 0
	xor		eax, eax
	mov		tmp_rq_results.rq_results._Myfirst, eax
	mov		tmp_rq_results.rq_results._Mylast, eax
	mov		tmp_rq_results.rq_results._Myend, eax
	xorps	xmm0, xmm0
	movaps	vGravity, xmm0
	subss	xmm0, gravity
	movss	vGravity.y, xmm0
	movflt	epsilon, 0.1
	mov		_low, 0
	mrm		_high, trTime
	.while (true)
		trajectory_select_pick_time(&_low, _high, trStart, trStart, &vGravity, epsilon)
		movss	time, xmm0
		trajectory_check_collision(_low, time, trStart, trVel, &vGravity, obj, &collide_pos, &tmp_rq_results)
		.if (!al)
			movss	xmm0, time
			subss	xmm0, _high
			andps	xmm0, ds:const_xmm_fabs
			.if (xmm0>FP4(0.001))
				;if (collide_pos.similar(trajectory_end, 0.2f)) break;
				movss	xmm2, FP4(0.2)
				mov		ecx, collide_pos
				shufps	xmm2, xmm2, 00000000b	; 0000v
				mov		edx, trEnd
				movups	xmm0, [ecx].Fvector4
				movups	xmm1, [edx].Fvector4
				subps	xmm0, xmm1
				andps	xmm0, ds:const_xmm_fabs
				cmpltps	xmm0, xmm2
				movmskps eax, xmm0
				.break .if (eax==1111b)
			.endif
			mov		al, true
			.break
		.endif
		movss	xmm0, time
		subss	xmm0, _high
		andps	xmm0, ds:const_xmm_fabs
		.break .if (xmm0<FP4(0.001))
		mrm		_low, time
	.endw
	ret
trajectory_intersects_geometry endp
