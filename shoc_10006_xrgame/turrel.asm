;===============================================================================
;		“урель на классе CCar
;
; (с) ЌаноЅот		27.09.2017		7.12.2017
;===============================================================================
;#define CLSID_TURREL		MK_CLSID('C','_','T','U','R','R','E','L')
angle_use_turrel_cos		equ 0.17364818	; = cos(80.0) ; минимальный угол от направлени€ ствола и взгл€да актора дл€ использовани€ турели.
;const float angle_use_turrel			= 80.f;
const_static_str	aOffset_driver_pl,	"offset_driver_place"
const_static_str	aHeight_pos,		"height_pos"

align_proc
CCar__UseSelect proc pos_:dword, dir_:dword, foot_pos:dword
local offset_vodila:Fvector4
; ecx - CCar_CHolderCustom	// 24Ch
	push	edi
	push	ebx
	lea		edi, [ecx-24Ch]		; CCar = CGameObject*
	ASSUME	edi:ptr CCar
	;CInifile* pUserData = smart_cast<CKinematics*>(Visual())->LL_UserData();
	mov		ecx, [edi].Visual_
	mov		eax, [ecx]
	mov		edx, [eax+18h]
	call	edx
	mov		ebx, [eax+pUserData]  ;pUserData 
	;m_offset_driver_place:set(vector_zero);
	xorps	xmm0, xmm0
	movups	[edi].m_offset_driver_place, xmm0
	;if(pUserData->line_exist("car_definition", "offset_driver_place"))
	push	offset aOffset_driver_pl		; "offset_driver_place"
	push	offset aCar_definition			; "car_definition"
	mov		ecx, ebx
	call	ds:line_exist
	.if (eax)
		;m_offset_driver_place		= K->LL_BoneID(pUserData->r_fvector3("car_definition", "offset_driver_place"));
		push	offset aOffset_driver_pl	; "offset_driver_place"
		push	offset aCar_definition		; "car_definition"
		lea		eax, offset_vodila
		push	eax
		mov		ecx, ebx
		call	ds:r_fvector3
		ASSUME	edx:ptr Fvector4
		lea		edx, [edi].m_offset_driver_place
		Fvector4_set	[edx], offset_vodila.x, offset_vodila.y, offset_vodila.z, 0
		ASSUME	edx:nothing
	.endif
	xor		eax, eax
	mov		[edi].m_height_pos, eax
	;if(pUserData->line_exist("car_definition", "offset_driver_place"))
	push	offset aHeight_pos				; "height_pos"
	push	offset aCar_definition			; "car_definition"
	mov		ecx, ebx
	call	ds:line_exist
	.if (eax)
		push	offset aHeight_pos			; "height_pos"
		push	offset aCar_definition		; "car_definition"
		mov		ecx, ebx
		call	ds:r_float
		fstp	[edi].m_height_pos
	.endif
	; if(this->CLS_ID == CLSID_TURREL)
	lea		ecx, [edi].CHolderCustom@vfptr		; CHolderCustom
	.if (EQ_QWORD([edi].CLS_ID, 'C_TURREL'))
		push	foot_pos
		push	dir_
		push	pos_
		call	CCarTurrel__Use
	.else
		push	foot_pos
		push	dir_
		push	pos_
		call	CCar__Use
	.endif
	ASSUME	edi:nothing
	pop		ebx
	pop		edi
	ret		12
CCar__UseSelect endp

align_proc
CCarTurrel__Use proc pos_:dword, dir_:dword, foot_pos:dword
local fire_dir:Fvector4, cam_dir:Fvector4, angle_cos:dword
; ecx - CCar_CHolderCustom	// 24Ch
	push	esi
	push	edi
	push	ebx
	lea		edi, [ecx-24Ch]
	ASSUME	edi:ptr CCar, esi:ptr CCarWeapon, ebx:ptr Fvector
	mov		esi, [edi].m_car_weapon
	.if (![edi].m_owner)	; владельца нет	//вход
		;return (m_fire_dir.yaw_degree3d_cos(dir_)<cos(angle_use_turrel));
		xor		eax, eax	; ID актора в сингле - ноль
		mov		[esi].m_parent_id, eax
		mov		ebx, dir_
		;fire_dir:set(m_fire_dir.x, 0.f, m_fire_dir.z, 0.f);
		Fvector4_set fire_dir, [esi].m_fire_dir.x, 0.0, [esi].m_fire_dir.z, 0
		;cam_dir:set(dir_.x, dir_.y, dir_.z, 0.f);
		Fvector4_set cam_dir, [ebx].x, [ebx].y, [ebx].z, 0
		;	lea		eax, fire_dir
		;	PRINT_VECTOR "fire_dir ", eax
		;	lea		eax, cam_dir
		;	PRINT_VECTOR "cam_dir ", eax
		;function yaw_degree3d( v1, v2 )
		;(math.acos((v1.x*v2.x + v1.y*v2.y + v1.z*v2.z)/(math.sqrt(v1.x*v1.x + v1.y*v1.y + v1.z*v1.z)*math.sqrt(v2.x*v2.x + v2.y*v2.y + v2.z*v2.z)))*57.2957)
		movups	xmm2, fire_dir
		movups	xmm3, cam_dir
		Fvector4@dotproduct	xmm2, xmm2
		movss	xmm4, xmm0	; dot_fire_dir = (fire_dir.x*fire_dir.x + fire_dir.y*fire_dir.y + fire_dir.z*fire_dir.z);
		Fvector4@dotproduct	xmm3, xmm3
		mulss	xmm4, xmm0	;  = (cam_dir.x*cam_dir.x + cam_dir.y*cam_dir.y + cam_dir.z*cam_dir.z) * dot_fire_dir
		sqrtss	xmm4, xmm4
		; fire_dir.dotproduct(cam_dir);
		Fvector4@dotproduct	xmm2, xmm3
		;fire_dir.dotproduct(cam_dir)/sqrt(fire_dir.dotproduct(fire_dir)*cam_dir.dotproduct(cam_dir));
		divss	xmm0, xmm4
		movflt	angle_cos, angle_use_turrel_cos
		comiss	xmm0, angle_cos
		seta	al			; al = xmm0 > angle_use_turrel_cos
	.else		;// выход
		movups	xmm2, [edi].XFORM_.c_	; this->position() //turrel
		;fire_dir:set(m_fire_dir.x, 0.f, m_fire_dir.z, 0.f);
		Fvector4_set fire_dir, [esi].m_fire_dir.x, 0, [esi].m_fire_dir.z, 0
		movups	xmm1, fire_dir
		xorps	xmm0, xmm0
		movflt	xmm0, -1.0	; дистанци€ выхода
		shufps	xmm0, xmm0, 11000000b	; 3000t
		mulps	xmm0, xmm1
		addps	xmm0, xmm2
		movups	fire_dir, xmm0
		;fire_dir.y-=m_height_pos;
		movss	xmm0, fire_dir.y
		subss	xmm0, [edi].m_height_pos
		movss	fire_dir.y, xmm0
		;m_exit_position.set(fire_dir.x, fire_dir.y, fire_dir.z);
		Fvector_set [edi].m_exit_position, fire_dir.x, fire_dir.y, fire_dir.z
		; return (!!smart_cast<CActor*>(m_owner));
		smart_cast	CActor, [edi].m_owner
		test	eax, eax
		setnz	al	; al = eax != 0
	.endif
	ASSUME	edi:nothing, esi:nothing, ebx:nothing
	pop		ebx
	pop		edi
	pop		esi
	ret		12
CCarTurrel__Use endp

; анимаци€ пулемЄтчика дл€ турели ѕ ћ
;const_static_str	aPkm_attack_0,		"pkm_attack_0"			;стрел€ем

align_proc
SVehicleAnimCollection__Create_turrel proc m_vehicles_type_collections:dword, V:dword
local p_motion_ID:dword
;si - i	u16
	.if (si==2)
		push	ecx
		push	ebx
		push	edi
		mov		edi, m_vehicles_type_collections
		ASSUME	edi:ptr SVehicleAnimCollection
		;idles[0] = V->ID_Cycle("pkm_idle_0");
		mov		ebx, ds:CKinematicsAnimated__ID_Cycle ; CKinematicsAnimated::ID_Cycle(char const *)
		push	const_static_str$("pkm_idle_0")			;идлова€
		lea		eax, p_motion_ID
		push	eax
		mov		ecx, V
		call	ebx ; CKinematicsAnimated::ID_Cycle(char const *)
		mov		cx, [eax]
		mov		[edi].idles[0], cx
		;steer_left = V->ID_Cycle("pkm_turn_left_0");
		push	const_static_str$("pkm_turn_left_0")		;разворот влево
		lea		edx, p_motion_ID
		push	edx
		mov		ecx, V
		call	ebx ; CKinematicsAnimated::ID_Cycle(char const *)
		mov		ax, [eax]
		mov		[edi].steer_left, ax
		;steer_right = V->ID_Cycle("pkm_turn_right_0");
		push	const_static_str$("pkm_turn_right_0")		;разворот вправо
		lea		ecx, p_motion_ID
		push	ecx
		mov		ecx, V
		call	ebx ; CKinematicsAnimated::ID_Cycle(char const *)
		mov		dx, [eax]
		mov		[edi].steer_right, dx
		ASSUME	edi:nothing
		pop		edi
		pop		ebx
		pop		ecx
	.else
		push	V
		push	m_vehicles_type_collections
		call	SVehicleAnimCollection__Create
	.endif
	ret		8
SVehicleAnimCollection__Create_turrel endp

align_proc
CCar__cam_UpdateSelect proc uses esi edi _dt:dword, fov:dword
; ecx - CCar_CHolderCustom	// 24Ch
	lea		esi, [ecx-24Ch]
	ASSUME	esi:ptr CCar, edx:ptr CCarWeapon
	mov		edx, [esi].m_car_weapon
	.if (edx && [edx].m_camera_bone!=-1)
		push	fov
		push	_dt
		call	CCar__cam_Update_turrel
	.else
		push	fov
		push	_dt
		call	CCar__cam_Update
	.endif
	ASSUME	edx:ptr CCameraBase, edi:ptr CCameraBase
	;скопировать камеру машины в камеру актора от первого лица. Ќадо дл€ работы фонарика актора, когда он находитс€ в турели.
	mov		ecx, [esi].m_ownerActor
	.if (ecx)
		mov		edi, [esi].camera[0]
		ASSUME	ecx:ptr CActor
		;cam_actor = OwnerActor()->cameras[0];
		mov		edx, [ecx].cameras[0]
		;cam_actor.yaw		= camera[0]->yaw;
		mrm		[edx].yaw, [edi].yaw
		;cam_actor.pitch	= camera[0]->pitch;
		mrm		[edx].pitch, [edi].pitch
		ASSUME	ecx:nothing
	.endif
	ASSUME	esi:nothing, edi:nothing, edx:nothing
	ret		8
CCar__cam_UpdateSelect endp

align_proc
CCar__cam_Update_turrel proc _dt:dword, fov:dword
local mat_cam_bone:Fmatrix4, P:Fvector4, Da:Fvector4
; esi - CCar_CHolderCustom	// 24Ch
; edi - K	CKinematics*
	push	esi
	push	edi
	push	ebx
	lea		esi, [ecx-24Ch]		; CCar* = CGameObject*
	;mov		esi, ecx
	ASSUME	esi:ptr CCar
	xorps	xmm0, xmm0
	movups	Da, xmm0
	;CKinematics*	K = smart_cast<CKinematics*>(Visual());
	mov		ecx, [esi].Visual_
	mov		eax, [ecx]
	mov		edx, [eax+18h]
	call	edx
	mov		edi, eax
	;K->CalculateBones_Invalidate();
	mov		ecx, edi
	call	ds:CKinematics__CalculateBones_Invalidate
	;K->CalculateBones();
	mov		eax, [edi]
	mov		edx, [eax+40h]
	push	0
	mov		ecx, edi
	call	edx
	;CBoneInstance& instance = K->LL_GetTransform(m_camera_bone);
	mov		ebx, [esi].m_car_weapon
	ASSUME	ebx:ptr CCarWeapon;;, esi:ptr CHolderCustom
	movzx	eax, [ebx].m_camera_bone
	lea		eax, [eax+eax*4]
	shl		eax, 5	; eax=*160	// sizeof CBoneInstance = 160
	add		eax, [edi+bone_instances]	; CBoneInstance
	;mat_cam_bone.mul_43(XFORM(), instance.mTransform);
	ASSUME	eax:ptr CBoneInstance, edx:ptr Fmatrix4, ecx:ptr Fvector
	lea		edx, [esi].XFORM_
	Fmatrix4@mul_43	mat_cam_bone, [edx], [eax].mTransform
	;mat_cam_bone.transform_tiny(P, m_camera_position);
	lea		ecx, [esi].m_camera_position
	Fmatrix4@transform_tiny	mat_cam_bone, P, [ecx]
	ASSUME	eax:nothing, edx:nothing, ecx:nothing
	;if (active_camera.tag==ectFirst)
	mov		edx, [esi].active_camera
	ASSUME	edx:ptr CCameraBase
	.if ([edx].tag==ectFirst)
		;if (OwnerActor())
		mov		ecx, [esi].m_ownerActor
		.if (ecx)
			ASSUME	ecx:ptr CActor
			;OwnerActor()->Orientation().yaw	= -active_camera->yaw;
			float_fchs	[ecx].r_torso.yaw, [edx].yaw		; мен€ем знак
			;OwnerActor()->Orientation().pitch	= -active_camera->pitch;
			float_fchs	[ecx].r_torso.pitch, [edx].pitch
			ASSUME	ecx:nothing
		.endif
	.endif
	;active_camera->f_fov = fov;
	mrm		[edx].f_fov, fov
	ASSUME	ebx:nothing, edx:nothing
	;active_camera->Update	(P,Da);
	mov		ecx, edx
	mov		eax, [edx]
	mov		eax, [eax+14h]
	lea		edx, Da
	push	edx
	lea		edx, P
	push	edx
	call	eax
	;Level().Cameras().Update		(active_camera);
	mov		ecx, [esi].active_camera
	mov		edx, ds:g_pGameLevel
	mov		eax, [edx]
	push	ecx
	mov		ecx, [eax+40h]
	call	ds:CCameraManager__Update1
	ASSUME	esi:nothing
	pop		ebx
	pop		edi
	pop		esi
	ret		8
CCar__cam_Update_turrel endp

;offset aCar_definition	;'car_definition'			;;
const_static_str	aLimit_x_rot, "limit_x_rot"
const_static_str	aLimit_y_rot, "limit_y_rot"

align_proc
CCarWeapon__CCarWeapon_chunk proc
local vector2:Fvector2, deg2rad:dword
local fire_bones:dword, count:dword, it:dword
local strFire_bone[128]:byte
; esi - CKinematics* K
; edi - CCarWeapon
	ASSUME	edi:ptr CCarWeapon
	;вырезаное
	mov		ebx, [esi+80h]	; CInifile* pUserData = K->LL_UserData();
	mov		[edi].m_camera_bone, -1
	;if(pUserData->line_exist("mounted_weapon_definition", "camera_bone"))
	push	offset aCamera_bone				; "camera_bone"
	push	offset aMounted_weapon			; "mounted_weapon_definition"
	mov		ecx, ebx
	call	ds:line_exist
	.if (eax)
		;m_camera_bone		= K->LL_BoneID(pUserData->r_string("mounted_weapon_definition", "camera_bone"));
		push	offset aCamera_bone			; "camera_bone"
		push	offset aMounted_weapon		; "mounted_weapon_definition"
		mov		ecx, ebx
		call	ds:r_string
;		PRINT_UINT "CCarWeapon__CCarWeapon_chunk: camera_bone[%s]", eax
		push	eax
		mov		ecx, esi
		call	ds:CKinematics__LL_BoneID
		mov		[edi].m_camera_bone, ax
;		movzx	eax, ax
;		PRINT_UINT "CCarWeapon__CCarWeapon_chunk: m_camera_bone[%d]", eax
	.endif
	push	esi
	movflt	deg2rad, 0.017453293
	ASSUME	eax:ptr CCar
	mov		eax, [edi].m_object		; CPhysicsShellHolder = CGameObject
	mov		esi, [eax].active_camera
	;m_parent_id = (u32)m_object->ID();
	movzx	eax, [eax].ID
	mov		[edi].m_parent_id, eax
	ASSUME	esi:ptr CCameraBase, eax:nothing
	;if(pUserData->line_exist("mounted_weapon_definition", "limit_x_rot"))
	push	offset aLimit_x_rot				; "limit_x_rot"
	push	offset aMounted_weapon			; "mounted_weapon_definition"
	mov		ecx, ebx
	call	ds:line_exist
	.if (eax)
		;vector2	= pUserData->r_fvector2("mounted_weapon_definition", "limit_x_rot");
		push	offset aLimit_x_rot			; "limit_x_rot"
		push	offset aMounted_weapon		; "mounted_weapon_definition"
		lea		eax, vector2
		push	eax
		mov		ecx, ebx
		call	ds:CInifile__r_fvector2
		;m_lim_x_rot.mul(vector2, deg2rad);
		;lim_yaw.set(m_lim_x_rot);
		movss	xmm0, vector2.x
		mulss	xmm0, deg2rad
		movss	[edi].m_lim_x_rot.x, xmm0
		movss	[esi].lim_yaw.x, xmm0
;		mov		eax, [edi].m_lim_x_rot.x
;		PRINT_FLOAT "m_lim_x_rot.x = %.7f", eax
		movss	xmm0, vector2.y
		mulss	xmm0, deg2rad
		movss	[edi].m_lim_x_rot.y, xmm0
		movss	[esi].lim_yaw.y, xmm0
;		mov		eax, [edi].m_lim_x_rot.y
;		PRINT_FLOAT "m_lim_x_rot.y = %.7f", eax
	.endif
	;if(pUserData->line_exist("mounted_weapon_definition", "limit_y_rot"))
	push	offset aLimit_y_rot				; "limit_y_rot"
	push	offset aMounted_weapon			; "mounted_weapon_definition"
	mov		ecx, ebx
	call	ds:line_exist
	.if (eax)
		;vector2	= pUserData->r_fvector2("mounted_weapon_definition", "limit_y_rot");
		push	offset aLimit_y_rot			; "limit_y_rot"
		push	offset aMounted_weapon		; "mounted_weapon_definition"
		lea		eax, vector2
		push	eax
		mov		ecx, ebx
		call	ds:CInifile__r_fvector2
		;m_lim_y_rot.mul(vector2, deg2rad);
		;lim_pitch.set(m_lim_y_rot);
		movss	xmm0, vector2.x
		mulss	xmm0, deg2rad
		movss	[edi].m_lim_y_rot.x, xmm0
		movss	[esi].lim_pitch.x, xmm0
;		mov		eax, [edi].m_lim_y_rot.x
;		PRINT_FLOAT "m_lim_y_rot.x = %.7f", eax
		movss	xmm0, vector2.y
		mulss	xmm0, deg2rad
		movss	[edi].m_lim_y_rot.y, xmm0
		movss	[esi].lim_pitch.y, xmm0
;		mov		eax, [edi].m_lim_y_rot.y
;		PRINT_FLOAT "m_lim_y_rot.y = %.7f", eax
	.endif
	mov		[edi].m_bShowCrosshair, true
	ASSUME	esi:nothing
	pop		esi
;-------------------------
; esi - K			IKinematics
; edi - this		CCarWeapon
	push	offset aFire_bone			; "fire_bone"
	push	offset aMounted_weapon		; "mounted_weapon_definition"
	mov		ecx, ebx
	call	ds:r_string
	;PRINT_UINT "fire_bones - %s", eax
	; int count = _GetItemCount( str );
	mov		fire_bones, eax
	push	','
	push	eax
	call	ds:_GetItemCount				; _GetItemCount(char const *,char)
	add		esp, 8
	mov		count, eax
	mov		[edi].m_count_firebones, eax
	;lea		eax, [eax*2+0]
	add		eax, eax		; eax*=2;
	xr_memory	eax
	mov		[edi].m_firebones, eax
	; for ( int it = 0; it < count; ++it )
	xor		ecx, ecx
	mov		it, ecx
	.while (ecx < count)
		; _GetItem(fire_bones, it, strFire_bone);
		push	true
		push	offset null_string
		push	','
		lea		edx, strFire_bone
		push	edx
		push	it
		push	fire_bones
		call	ds:_GetItem				 ; _GetItem(char const *,int,char *,uint,char,char const *,bool)
		add		esp, 24
		; u16	num_bone = K->LL_BoneID(strFire_bone);
		lea		eax, strFire_bone
;		PRINT_UINT "name fire_bone - %s", eax
		push	eax
		mov		ecx, esi
		call	ds:CKinematics__LL_BoneID
;		movzx	eax, ax
;		PRINT_UINT "num fire_bone - %d", eax
		; m_firebones[it] = num_bone;
		mov		ecx, it
		mov		edx, [edi].m_firebones
		mov		[edx+ecx*2], ax
		inc		ecx
		mov		it, ecx
	.endw
	mov		[edi].m_num_firebones, 0
	mov		ax, [edx]
	mov		[edi].m_fire_bone, ax
;-------------------------
	ASSUME	edi:nothing
	leave
	jmp		return_CCarWeapon__CCarWeapon_chunk
CCarWeapon__CCarWeapon_chunk endp

align_proc
CCarWeapon___CCarWeapon_chunk proc
;edi - CCarWeapon
	call	CShootingObject___CShootingObject
	; удалим динамический массив m_firebones
	ASSUME	edi:ptr CCarWeapon
	mov		eax, [edi].m_firebones
	.if (eax)
		xr_mem_free	eax
	.endif
	ASSUME	edi:nothing
	retn
CCarWeapon___CCarWeapon_chunk endp

;перекрести€ прицела машины с оружием CCarWeapon
;вызываетс€ из void CActor::UpdateCL()
align_proc
CActor__ShowCrosshairTurrel proc
;edi - CActor*
	ASSUME	edi:ptr CActor
	mov		edx, [edi].m_holder		;CHolderCustom*
	.if (edx)
		push	ebx
		mov		ebx, eax
		smart_cast	CCar, CHolderCustom, edx
		.if (eax)
			ASSUME	eax:ptr CCar
			push	esi
			mov		esi, [eax].m_car_weapon
			ASSUME	esi:ptr CCarWeapon, eax:nothing
			.if (esi && [esi].m_bShowCrosshair)
				.if (psHUD_Flags & HUD_CROSSHAIR_DYNAMIC)
					;fire_disp_full = fireDispersionBase;//*m_holder->m_car_weapon->m_Ammo->m_kDisp;
					movss	xmm0, [esi].fireDispersionBase
					;mov		eax, [esi].m_Ammo
					;ASSUME	eax:ptr CCartridge
					;mulss	xmm0, [eax].m_kDisp
					;ASSUME	eax:nothing
					push1xmm xmm0
				.else
					pushflt 0.02			; float
				.endif
				;HUD().SetCrosshairDisp(fire_disp_full, 0.02f);
				mov		eax, [ebx+148h]
				mov		eax, [eax+34h]
				add		eax, 2Ch
				push	eax				; int
				call	CHUDCrosshair__SetDispersion
				;HUD().ShowCrosshair(true);
				mov		ecx, ds:g_pGameLevel ; IGame_Level * g_pGameLevel
				mov		edx, [ecx]
				mov		eax, [edx+148h]
				mov		ecx, [eax+34h]
				mov		byte ptr [ecx+28h], true
				pop		esi
				pop		ebx
				jmp		endif_CActor__ShowCrosshairTurrel
			.endif
			ASSUME	esi:nothing
			pop		esi
		.endif
		mov		eax, ebx
		pop		ebx
	.endif
	ASSUME	edi:nothing
	mov		eax, [eax+148h]
	jmp		return_CActor__ShowCrosshairTurrel
CActor__ShowCrosshairTurrel endp

align_proc
CCarWeapon__OnShotExt proc
;esi - CCarWeapon
	call	CCarWeapon__OnShot
	ASSUME	esi:ptr CCarWeapon, edi:ptr CCar
	.if ([esi].m_count_firebones>1)
		push	edi
		mov		edi, [esi].m_object
		;CKinematics*	K = smart_cast<CKinematics*>(m_object->Visual());
		smart_castV	CKinematics, IRender_Visual, [edi].Visual_
		mov		ecx, [esi].m_num_firebones
		mov		edx, [esi].m_firebones
		inc		ecx
		.if ([esi].m_count_firebones==ecx)
			xor		ecx, ecx
		.endif
		mov		[esi].m_num_firebones, ecx
		mov		dx, [edx+ecx*2]
		mov		[esi].m_fire_bone, dx
		;m_fire_bone_xform	= K->LL_GetTransform(m_fire_bone);
		movzx	edx, dx
		lea		edx, [edx+edx*4]
		shl		edx, 5	; eax=*160	// sizeof CBoneInstance = 160
		add		edx, [eax+bone_instances]	; CBoneInstance
		ASSUME	edx:ptr CBoneInstance, ecx:ptr Fmatrix4
		;m_fire_bone_xform.mulA_43(m_object->XFORM());
		lea		ecx, [edi].XFORM_
		Fmatrix4@mul_43	[esi].m_fire_bone_xform, [ecx], [edx].mTransform
		ASSUME	ecx:nothing, edx:nothing
		Fvector_set	[esi].m_fire_pos, [esi].m_fire_bone_xform.c_
		pop		edi
	.endif
	ASSUME	esi:nothing, edi:nothing
	retn
CCarWeapon__OnShotExt endp


