;===============| расширение регистрации пространства имён level |=============
level_ns_extension_1:
	call	register_level__float__void ; делаем то, что вырезали
;------------< регистрируем функцию получения расстояния до объекта, на который смотрим >------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset GetTargetDistance
	push	offset aGet_target_dist ; "get_target_dist"
	push	eax
	call	register_level__float__void ; регистрируем функцию с прототипом как у	get_snd_volume
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset GetTargetObject
	push	offset aGet_target_obj ; "get_target_obj"
	push	eax
	call	register_level__go__void ; регистрируем функцию с прототипом как у	  object_by_id
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset GetActorBodyState
	push	offset aGet_actor_body_state ; "get_actor_body_state"
	push	eax
	call	register_level__uint__void ; регистрируем функцию с прототипом как у   get_time_days
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset SetFov
	push	offset aSet_fov ; "set_fov"
	push	eax
	call	register_level__void__float ; регистрируем функцию с прототипом как у	set_snd_volume
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset GetFov
	push	offset aGet_fov ; "get_fov"
	push	eax
	call	register_level__float__void ; регистрируем функцию с прототипом как у	get_snd_volume
;--------------------------------------
;	---===RayPick===---
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickSetParams1
	push	offset aRayPickSetParams1 ; "raypick_set_flags_dir_dist"
	push	eax
	call	register_level__uint__uint_vector_float ; регистрируем функцию
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickSetParams2
	push	offset aRayPickSetParams2 ; "raypick_set_ignore_pos"
	push	eax
	call	register_level__float__uint_vector ; регистрируем функцию
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickQuery
	push	offset aRayPickQuery ; "raypick_query"
	push	eax
	call	register_level__bool__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetObject
	push	offset aRayPickGetObject ; "raypick_get_object"
	push	eax
	call	register_level__go__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetDist
	push	offset aRayPickGetDist ; "raypick_get_distance"
	push	eax
	call	register_level__float__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetElement
	push	offset aRayPickGetElement ; "raypick_get_element"
	push	eax
	call	register_level__uint__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetNameBone
	push	offset aRayPickGetNameBone ; "raypick_get_name_bone"
	push	eax
	call	register_level__str__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetNormal
	push	offset aRayPickGetNormal ; "raypick_get_normal"
	push	eax
	call	register_level__vector__uint
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetEndPoint
	push	offset aRayPickGetEndPoint ; "raypick_get_end_point"
	push	eax
	call	register_level__vector__uint
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetShootFactor
	push	offset aRayPickGetShootFactor ; "raypick_get_shoot_factor"
	push	eax
	call	register_level__float__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetFlags
	push	offset aRayPickGetFlags 	; "raypick_get_flags"
	push	eax
	call	register_level__uint__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset RayPickGetTransparencyFactor
	push	offset aRayPickGetTransparencyFactor ; "raypick_get_transparency_factor"
	push	eax
	call	register_level__float__void
;--------------------------------------
;	---===RayPick===---
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset Level__CurrentEntity
	push	offset aCurrentEntity 		; "current_actor"
	push	eax
	call	register_level__go__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset Level__OnServer
	push	offset aOnServer ; "on_server"
	push	eax
	call	register_level__bool__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset Level__OnClient
	push	offset aOnClient ; "on_client"
	push	eax
	call	register_level__bool__void
;--------------------------------------
	pop		ecx
	pop		ecx
	mov		eax, esp
	push	offset Level__OnDedicatedServer
	push	offset aOnDedicatedServer ; "on_dedicated_server"
	push	eax
	call	register_level__bool__void
;--------------------------------------
	jmp back_to_level_ns_ext_1
	
aGet_target_dist 		db "get_target_dist", 0
aGet_target_obj			db "get_target_obj", 0
aGet_actor_body_state 	db "get_actor_body_state", 0
aSet_fov 				db "set_fov", 0
aGet_fov 				db "get_fov", 0
;	---===RayPick===---
aRayPickSetParams1				db "raypick_set_flags_dir_dist", 0
aRayPickSetParams2				db "raypick_set_ignore_pos", 0
aRayPickQuery					db "raypick_query", 0
aRayPickGetObject				db "raypick_get_object", 0
aRayPickGetDist					db "raypick_get_distance", 0
aRayPickGetElement				db "raypick_get_element", 0
aRayPickGetNameBone				db "raypick_get_name_bone", 0
aRayPickGetNormal				db "raypick_get_normal", 0
aRayPickGetEndPoint				db "raypick_get_end_point", 0
aRayPickGetShootFactor			db "raypick_get_shoot_factor", 0
aRayPickGetFlags 				db "raypick_get_flags", 0
aRayPickGetTransparencyFactor 	db "raypick_get_transparency_factor", 0

;	---===RayPick===---
aCurrentEntity 			db "current_actor", 0
aOnServer 				db "on_server", 0
aOnClient 				db "on_client", 0
aOnDedicatedServer 		db "on_dedicated_server", 0

level_ns_extension_2: ; здесь надо добавлять столько раз   "mov ecx, eax" + "call esi", сколько добавляли функций
; делаем то, что вырезали
	mov		ecx, eax
	call	esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
	mov		ecx, eax
	call	esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
; добавляем своё
	; для get_target_dist
	mov		ecx, eax
	call	esi 
	; для get_target_obj
	mov		ecx, eax
	call	esi 
	; для get_actor_body_state
	mov		ecx, eax
	call	esi 
	; для set_fov
	mov		ecx, eax
	call	esi 
	; для get_fov
	mov		ecx, eax
	call	esi
;	---===RayPick===---
	; для RayPickSetParams1
	mov		ecx, eax
	call	esi 
	; для RayPickSetParams2
	mov		ecx, eax
	call	esi 
	; для RayPickQuery
	mov		ecx, eax
	call	esi 
	; для RayPickGetObject
	mov		ecx, eax
	call	esi 
	; для RayPickGetDist
	mov		ecx, eax
	call	esi 
	; для RayPickGetElement
	mov		ecx, eax
	call	esi
	; для RayPickGetNameBone
	mov		ecx, eax
	call	esi
	; для RayPickGetNormal
	mov		ecx, eax
	call	esi
	; для RayPickGetEndPoint
	mov		ecx, eax
	call	esi
	; для RayPickGetShootFactor
	mov		ecx, eax
	call	esi
	; для RayPickGetFlags
	mov		ecx, eax
	call	esi
	; для RayPickGetTransparencyFactor
	mov		ecx, eax
	call	esi
;	---===RayPick===---
	; для Level__CurrentEntity
	mov		ecx, eax
	call	esi
	; для Level__OnServer
	mov		ecx, eax
	call	esi
	; для Level__OnClient
	mov		ecx, eax
	call	esi
	; для Level__OnDedicatedServer
	mov		ecx, eax
	call	esi
; идём обратно
	jmp back_to_level_ns_ext_2


GetTargetDistance proc
	mov		eax, [g_hud] ; CCustomHUD * g_hud
	mov		ecx, [eax]
	call	CCustomHUD__GetRQ ; eax = RQ
	fld		dword ptr [eax+4] ; return EQ.range
	retn
GetTargetDistance endp

GetTargetObject proc
	mov		eax, [g_hud] ; CCustomHUD * g_hud
	mov		ecx, [eax]
	call	CCustomHUD__GetRQ ; eax = RQ
	push	dword ptr [eax] ; RQ.O
	call	smart_cast_CGameObject ; eax = smart_cast<CGameObject*>
	pop		ecx
	.if		eax == null ; если ничего не нашли, то возвращаем nil
		retn
	.endif ; иначе - конвертируем в game_object
	mov		ecx, eax ; this = <найденный CGameObject>
	jmp		CGameObject__lua_game_object
GetTargetObject endp

GetActorBodyState proc
	mov		eax, [g_Actor]
	.if		eax != 0
		mov		eax, [eax+1428] ; mstate_real (0x594 = 1428)
	.endif
	retn
GetActorBodyState endp

SetFov proc
arg_0			= dword ptr	 4
	mov		eax, [esp+arg_0]
	mov		[g_fov], eax
	retn
SetFov endp

GetFov proc
	fld		dword ptr [g_fov]
	retn
GetFov endp

;	---===RayPick===---
RP_position		Fvector {0.0, 0.0, 0.0}
RP_direction	Fvector {0.0, 0.0, 0.0}
RP_distance		dd 0
RP_flags		dd 0
RP_ignore_id	dd 0
rq_res			collide__rq_result {0, 123.0, 0}
normal			Fvector {0.0, 0.0, 0.0}
vector_0		Fvector {0.0, 0.0, 0.0}
end_point		Fvector {0.0, 0.0, 0.0}

RayPickSetParams1 proc	flags:dword, direction_x:dword, direction_y:dword, direction_z:dword, distance:dword
;---------------------------------------------
	mov		eax, flags
	mov		[RP_flags], eax
	mov		eax, direction_x
	mov		[RP_direction.x], eax
	mov		eax, direction_y
	mov		[RP_direction.y], eax
	mov		eax, direction_z
	mov		[RP_direction.z], eax
	mov		eax, distance
	mov		[RP_distance], eax
;---------------------------------------------
	ret
RayPickSetParams1 endp

RayPickSetParams2 proc ignore_id:word, position:dword
x				= dword ptr	0
y				= dword ptr	4
z				= dword ptr	8

	push	ecx
;---------------------------------------------
	movzx	eax, ignore_id
	mov		[RP_ignore_id], eax
	mov		ecx, position
	mov		eax, [ecx+x]
	mov		[RP_position.x], eax
	mov		eax, [ecx+y]
	mov		[RP_position.y], eax
	mov		eax, [ecx+z]
	mov		[RP_position.z], eax
;---------------------------------------------
	pop		ecx
	ret
RayPickSetParams2 endp

RayPickQuery proc
	mov		eax, dword ptr [RP_ignore_id]	; ID GameObject
	; CObject *O = Level().Objects.net_Find(RP_ignore_id)
	.if		ax != 0FFFFh
		mov		ecx, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
		mov		ecx, [ecx]
		mov		eax, [ecx+eax*4+4Ch]		; CObject eax = *O
	.endif
;	PRINT_UINT	"CObject *O - %d", eax
	push	eax								; CObject *O
	push	offset rq_res					; collide::rq_result &
	push	dword ptr [RP_flags]			; collide::rq_target
	push	dword ptr [RP_distance]			; float range
	push	offset RP_direction				; dir
	push	offset RP_position				; start
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	add		ecx, 40094h		;
	call	ds:CObjectSpace__RayPick
	movss	xmm3, dword ptr [rq_res.range] ; R.range
	movss	xmm0, dword ptr [RP_direction.x]
	mulss	xmm0, xmm3
	movss	xmm1, dword ptr [RP_position.x]
	addss	xmm1, xmm0
	movss	dword ptr [end_point.x], xmm1
	movss	xmm0, dword ptr [RP_direction.y]
	mulss	xmm0, xmm3
	movss	xmm1, dword ptr [RP_position.y]
	addss	xmm1, xmm0
	movss	dword ptr [end_point.y], xmm1
	movss	xmm0, dword ptr [RP_direction.z]
	mulss	xmm0, xmm3
	movss	xmm1, dword ptr [RP_position.z]
	addss	xmm1, xmm0
	movss	dword ptr [end_point.z], xmm1
	retn
RayPickQuery endp

RayPickGetObject proc
	mov		eax, [rq_res.O]
	.if		eax != 0
		mov		ecx, eax
		jmp		CGameObject__lua_game_object
	.endif
	retn
RayPickGetObject endp

RayPickGetDist proc
	fld		rq_res.range
	retn
RayPickGetDist endp

RayPickGetElement proc
	mov		eax, [rq_res.element]
	retn
RayPickGetElement endp

RayPickGetNameBone proc
	push	ecx
	push	edx
	mov		eax, [rq_res.O]		; CObject	Obj = rq_res.O
	.if		eax != 0
		mov		eax, [eax+90h]		; IRenderVisual vis* = Obj->Visual()
		.if		eax != 0
			mov		ecx, [eax]
			mov		edx, [ecx+0Ch]
			push	eax
			call	edx					; IKinematics *IK = smart_cast<IKinematics*>(vis)
			mov		ecx, [eax]
			mov		edx, [ecx+18h]
			push	[rq_res.element]	; u16 BoneID
			push	eax
			call	edx					; LPCSTR eax = namebone = IK->LL_BoneName_dbg(BoneID)
		.endif
	.endif
	pop		edx
	pop		ecx
	retn
RayPickGetNameBone endp

RayPickGetNormal proc
size_variables			= dword ptr	5*4		; размер поля локальных переменных
e_center_x				= dword ptr -16
e_center_y				= dword ptr -12
e_center_z				= dword ptr -8
len						= dword ptr -4

	sub		esp, size_variables
	push	ebp
	push	edi
	mov		eax, [rq_res.O]
	test	eax, eax
	jz		static
		mov		eax, [eax+0A0h]			; rq_res.O->CFORM()
		test	eax, eax
		jz		vec_0
			push	0
			push	offset off_10634450
			push	offset off_106196A8
			push	0
			push	eax
			call	__RTDynamicCast
			add		esp, 20
			test	eax, eax
			jz		vec_0
				mov		ebp, offset normal
				xorps	xmm0, xmm0
				movss	dword ptr [ebp+0], xmm0
				movss	dword ptr [ebp+4], xmm0
				movss	dword ptr [ebp+8], xmm0		; hit_normal.set  (0,0,0);
				movzx	edx, word ptr [ebx+8]		; R.element
				lea		ecx, [esp+size_variables+8+e_center_x]
				push	ecx
				push	edx
				mov		ecx, eax
				call	ds:_ElementCenter			; CCF_Skeleton::_ElementCenter(ushort,_vector3<float> &)
				test	al, al
				jz		end_if
					mov		eax, offset end_point
					movss	xmm0, dword ptr [eax]
					subss	xmm0, [esp+size_variables+8+e_center_x]
					movss	dword ptr [ebp+0], xmm0
					movss	xmm0, dword ptr [eax+4]
					subss	xmm0, [esp+size_variables+8+e_center_y]
					movss	dword ptr [ebp+4], xmm0
					movss	xmm0, dword ptr [eax+8]
					subss	xmm0, [esp+size_variables+8+e_center_z]
					movss	dword ptr [ebp+8], xmm0
end_if:
				movss	xmm2, dword ptr [ebp+4]
				movss	xmm3, dword ptr [ebp+0]
				movss	xmm1, dword ptr [ebp+8]
				movaps	xmm0, xmm3
				mulss	xmm0, xmm3
				movaps	xmm4, xmm2
				mulss	xmm4, xmm2
				addss	xmm0, xmm4
				movaps	xmm4, xmm1
				mulss	xmm4, xmm1
				addss	xmm0, xmm4
				movss	[esp+size_variables+8+len], xmm0
				fld		[esp+size_variables+8+len]
				fld		st
				fabs
				fld		ds:const_1e_7
				fcomip	st, st(1)
				fstp	st
				ja		else_
					fsqrt
					movss	xmm0, ds:float_1				; 1.0f
					fstp	[esp+size_variables+8+len]
					divss	xmm0, [esp+size_variables+8+len]
					movaps	xmm4, xmm0
					mulss	xmm4, xmm3
					movaps	xmm3, xmm0
					mulss	xmm3, xmm2
					mulss	xmm0, xmm1
					movss	dword ptr [ebp+0], xmm4
					movss	dword ptr [ebp+4], xmm3
					movss	dword ptr [ebp+8], xmm0
				jmp		exit
else_:
					movss	xmm0, ds:const_minus
					fstp	st
					movaps	xmm1, xmm0
					subss	xmm1, dword ptr [esi+14h]
					movss	dword ptr [ebp+0], xmm1
					movaps	xmm1, xmm0
					subss	xmm1, dword ptr [esi+18h]
					movss	dword ptr [ebp+4], xmm1
					subss	xmm0, dword ptr [esi+1Ch]
					movss	dword ptr [ebp+8], xmm0
				jmp		exit
static:
	test	[rq_res.element], -1
	jz		vec_0
		mov		eax, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
		mov		eax, [eax]
		lea		ecx, [eax+40094h]
		call	ds:GetStaticVerts			; CObjectSpace::GetStaticVerts(void)
		mov		ecx, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
		mov		edi, eax
		mov		eax, [ecx]
		lea		ecx, [eax+40094h]
		call	ds:GetStaticTris			; CObjectSpace::GetStaticTris(void)
		mov		edx, [rq_res.element]
		shl		edx, 4
		mov		ecx, [eax+edx+8]
		add		eax, edx
		lea		ecx, [ecx+ecx*2]
		lea		edx, [edi+ecx*4]
		mov		ecx, [eax+4]
		mov		eax, [eax]
		lea		ecx, [ecx+ecx*2]
		push	edx
		lea		edx, [edi+ecx*4]
		lea		eax, [eax+eax*2]
		lea		ecx, [edi+eax*4]
		push	edx
		push	ecx
		mov		ecx, offset normal
		call	mknormal
		mov		eax, offset normal
		jmp		exit
vec_0:
	mov		eax, offset vector_0
exit:
	pop		edi
	pop		ebp
	add		esp, size_variables
	retn
RayPickGetNormal endp

RayPickGetEndPoint proc
	mov		eax, offset end_point
	retn
RayPickGetEndPoint endp

RayPickGetShootFactor proc
	call	GetMaterial
	.if		eax != 0
		fld		dword ptr [eax+28h]
	.else
		fldz
	.endif
	retn
RayPickGetShootFactor endp

RayPickGetFlags proc
	call	GetMaterial
	.if		eax != 0
		mov		eax, dword ptr [eax+0Ch]
	.endif
	retn
RayPickGetFlags endp

RayPickGetTransparencyFactor proc
	call	GetMaterial
	.if		eax != 0
		fld		dword ptr [eax+38h]
	.else
		fld1
	.endif
	retn
RayPickGetTransparencyFactor endp

GetMaterial proc
	mov		eax, [rq_res.O]
	.if		eax != 0
		mov		eax, [eax+90h]		; IRenderVisual vis* = Obj->Visual()
		.if		eax == 0
			retn
		.endif
		mov		ecx, [eax]
		mov		edx, [ecx+0Ch]
		push	eax
		call	edx					; IKinematics *IK = smart_cast<IKinematics*>(vis)
		mov		ecx, [eax]
		mov		edx, [ecx+28h]
		push	[rq_res.element]	; u16 BoneID
		push	eax
		call	edx					; CBoneData eax = bone_data = IK->LL_GetData(BoneID)
		movzx	eax, word ptr [eax+13Ch]	; bone_data.game_mtl_idx
	.else
		.if		[rq_res.element] == -1
			xor		eax, eax
			retn
		.endif
		mov		ecx, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
		mov		eax, [ecx]
		lea		ecx, [eax+40094h]
		call	ds:GetStaticTris			; CObjectSpace::GetStaticTris(void)
		mov		edx, [rq_res.element]
		shl		edx, 4
		add		eax, edx
		movzx	eax, word ptr [eax+0Ch]
		and		eax, 0FFFF3FFFh				; u16 eax = tgt_material
	.endif
	mov		ecx, ds:GMLib				; CGameMtlLibrary GMLib
	push	eax							; tgt_material
	call	ds:GetMaterialByIdx			; CGameMtlLibrary::GetMaterialByIdx(ushort)
	retn
GetMaterial endp
;	---===RayPick===---

Level__CurrentEntity proc
	mov     edx, ds:g_pGameLevel		 		; IGame_Level * g_pGameLevel
	mov     ecx, [edx]
	call    ds:IGame_Level__CurrentEntity 		; IGame_Level::CurrentEntity(void)
	.if		eax != 0
		mov		ecx, eax
		jmp		CGameObject__lua_game_object
	.endif
	retn
Level__CurrentEntity endp

Level__OnServer proc
	mov     eax, ds:g_pGameLevel				; IGame_Level * g_pGameLevel
	mov     ecx, [eax]
	call    CLevel__IsServer
	movzx	eax, al
	retn
Level__OnServer endp

Level__OnClient proc
	mov     eax, ds:g_pGameLevel				; IGame_Level * g_pGameLevel
	mov     ecx, [eax]
	call    CLevel__IsClient
	movzx	eax, al
	retn
Level__OnClient endp

Level__OnDedicatedServer proc
	mov     eax, ds:g_dedicated_server
	movzx	eax, byte ptr [eax]
	retn
Level__OnDedicatedServer endp
