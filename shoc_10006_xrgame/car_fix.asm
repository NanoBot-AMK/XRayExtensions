;======================================================================
;		Класс CCar и CCarWeapon
;
; (с) Рефакторинг НаноБот
;======================================================================

align 4
float_car_exit_distance dd 5.0

;При вылезании из машины, смотрим туда, куда смотрели.
align_proc
CActor__init_camera_holder proc
;edi - this				CActor
;eax - active_camera	CCameraBase
	;CCameraBase* holder_cam = m_holder->Camera();
	mov		ecx, eax					; = holder_cam
	ASSUME	edi:ptr CActor, edx:ptr CCameraBase, ecx:ptr CCameraBase
	;CCameraBase* actor_cam = cam_Active();
	mov		eax, [edi].cam_active
	mov     edx, [edi+eax*4].cameras	; = actor_cam
	;actor_cam.yaw 		= holder_cam.yaw;
	;actor_cam.pitch 	= holder_cam.pitch;
	mrm		[edx].yaw,	[ecx].yaw
	mrm		[edx].pitch, [ecx].pitch
	mov     [edi].m_holder, NULL	;вырезанное
	ASSUME	edi:nothing, edx:nothing, ecx:nothing
	jmp		return_CActor__init_camera_holder
CActor__init_camera_holder endp

; скриптовый колбек на смерть машины
align_proc
CCar__CarExplode_ext proc
;edi - CCar	= CGameObject*	+0h
	CALLBACK__GO	edi, GameObject__eDeath, NULL
	; return;		// выход из CCar::CarExplode()
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	mov		esp, ebp
	pop		ebp
	retn
CCar__CarExplode_ext endp

; Задаём ID стрелка на БТРе, если он есть. Требуется для нормальной отработки хит колбека.	(с) NanoBot
; Колбеки на вход и выход машины, идут в биндер машины.
align_proc
CCar__detach_Actor_ext proc
;edi - CHolderCustom* CCar	= +24Ch
;esi - CGameObject*	CCar	= +0h
	ASSUME	edi:ptr CHolderCustom, esi:ptr CCar
	mov		ebx, [edi].m_owner
	mov		edx, [esi].m_car_weapon
	.if(edx)
		ASSUME	edx:ptr CCarWeapon
		movzx	eax, [esi].ID
		mov		[edx].m_parent_id, eax
;		PRINT_UINT	"CCar__detach_Actor_ext() ID=%d", eax
		ASSUME	edx:nothing
	.endif
	ASSUME	edi:nothing, esi:nothing
	CALLBACK__VOID	esi, eDetachActorVehicle
	;return;	//
	mov		ecx, esi
	pop		esi
	pop		edi
	pop		ebx
	jmp		ds:CObject__processing_deactivate
CCar__detach_Actor_ext endp

align_proc
CCar__attach_Actor_ext proc
;edi - CCar	= CHolderCustom*  +24Ch
	push	ebx
	lea		esi, [edi-24Ch]
	ASSUME	edi:ptr CHolderCustom, esi:ptr CCar
	mov		ebx, [edi].m_owner	; CGameObject*
	mov		edx, [esi].m_car_weapon
	.if(edx)
		ASSUME	edx:ptr CCarWeapon, ebx:ptr CGameObject
		movzx	eax, [ebx].ID
		mov		[edx].m_parent_id, eax
;		PRINT_UINT	"CCar__attach_Actor_ext() ID=%d", eax
		ASSUME	edx:nothing, ebx:nothing
	.endif
	ASSUME	edi:nothing, esi:nothing
	mov		edi, ebx	; actor
	call	CGameObject__lua_game_object
	CALLBACK__GO	esi, eAttachActorVehicle, eax
	;return;	//
	pop		ebx
	pop		esi
	mov		al, true
	pop		edi
	retn	4
CCar__attach_Actor_ext endp


