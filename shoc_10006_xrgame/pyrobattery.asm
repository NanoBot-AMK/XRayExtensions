;======================================================================
;	Project		: XRay - Extensions		
;	Module		: pyrobattery.asm
;	Created		: 30.07.2019
;	Modified	: 09.08.2019
;	Author		: NanoBot
;	Description : Салютная установка. 
;======================================================================

;enum StatePyroBattery {	//Состояние батареи.
eBatteryDummy				= 0		;не батарея или заблокировано!
eBatteryNotActived			= 1		;батарея не активирована, можно взять в инвентарь.
eBatteryDrop				= 2		;в процессе активирования, выбрасываем в фокус, настраеваем.
eBatteryActived				= 3		;батарея активирована, взятие в инвентарь заблокировано, ожидание активации.
eBatteryInitialized			= 4		;батарея инициализирована, подожгли фитиль.
eBatteryAction				= 5		;батарея в процессе работы, стреляет.
eBatteryEmpty				= 6		;батарея отстреляла, пустая.
;}

const_static_str		aSt_init_pyrobattary, "st_init_pyrobattary"		;// Поджечь фитиль.

;конструктор
align_proc
CPyroBattery@@CPyroBattery_ext proc
;esi	this	CAntirad*
	ASSUME	esi:ptr CAntirad
	xor		ecx, ecx
	mov		[esi].m_params._Alval, ecx
	mov		[esi].m_params._Myfirst, ecx
	mov		[esi].m_params._Mylast, ecx
	mov		[esi].m_params._Myend, ecx
	mov		[esi].m_state_battery, cl	;=eBatteryDummy
	mov		[esi].m_fuse_particles, ecx
;---------------------
	mov		eax, esi
	pop		esi
	retn
CPyroBattery@@CPyroBattery_ext endp

;деструктор
align_proc
CPyroBattery@@_CPyroBattery_ext proc
;ecx	this	CAntirad*
	push	esi
	mov		esi, ecx
	CEatableItemObject@@_CEatableItemObject()
	.if ([esi].m_state_battery!=eBatteryDummy)
		mov		edx, [esi].m_params._Myfirst
		.if (edx)
			xr_mem_free	edx
			xor		ecx, ecx
			mov		[esi].m_params._Myfirst, ecx
			mov		[esi].m_params._Mylast, ecx
			mov		[esi].m_params._Myend, ecx
		.endif
		mov		ecx, [esi].m_fuse_particles
		.if (ecx)
			CScriptParticles@@_CScriptParticles(1)
			mov		[esi].m_fuse_particles, NULL
		.endif
	.endif
	pop		esi
	retn
CPyroBattery@@_CPyroBattery_ext endp

align_proc
CPyroBattery@@Load proc uses esi edi section:ptr byte
;ecx	this	CGameObject*
	lea		esi, [ecx-CAntirad.CGameObject@vfptr]	;CAntirad*
	mov		edi, section
	.if (EQ_QWORD([esi].CLS_ID, 'O_BATTAR'))	;пиротехника
		push	edi
		lea		ecx, [esi].CGameObject@vfptr
		call	ds:CObject__Load
		and		[esi].spatial._type, NOT STYPE_REACTTOSOUND	;spatial.type &= ~STYPE_REACTTOSOUND;
		mov		ecx, esi
		CInventoryItem@@Load(edi)
	.else
		lea		ecx, [esi].CGameObject@vfptr
		CAntirad@@Load(edi)
	.endif
	ret
CPyroBattery@@Load endp

align_proc
CPyroBattery@@net_Spawn proc uses esi edi ebx DC:ptr CSE_Abstract
local count:dword, DEG2RAD:real4, n:dword, section:dword, res:dword
local name_line[20]:byte, data[7]:dword, str_data[4096]:byte
;ecx	this	CGameObject*
	lea		esi, [ecx-CAntirad.CGameObject@vfptr]	;CAntirad*
	CAntirad@@net_Spawn(DC)
	.if (eax && EQ_QWORD([esi].CLS_ID, 'O_BATTAR'))
		mov		res, eax
		mov		edx, g_ai_space
		mov		edi, object_by_id([edx].CAI_Space.m_alife_simulator, [esi].ID)
		PRINT_UINT "CPyroBattery@@net_Spawn() DC = %08X", edi
		ASSUME	edi:ptr CSE_ALifeItemPyrobattary
		mov		[esi].m_pServerObj, edi
		;загрузка данных из нетпакета
		mrm		[esi].m_state_battery, [edi].m_StateBattery
		;загрузка данных из конфига
		mov		edx, [esi].NameSection.p_
		lea		ebx, [edx].str_value.value
		mov		section, ebx
		.if ([esi].m_state_battery == eBatteryAction || [esi].m_state_battery == eBatteryInitialized)
			mrm		[esi].m_number_pyro, [edi].m_dwNumberPyro
			mrm		[esi].m_fuse_time, [edi].m_dwFuseTime
		.else
			mov		[esi].m_fuse_time, @R_U32(ebx, "fuse_time")
		.endif
		.if ([esi].m_state_battery != eBatteryNotActived)
			and		[esi].m_flags, not FCanTake
		.endif
		.if ([esi].m_state_battery == eBatteryActived)
			mov		edx, offset aSt_init_pyrobattary	;tips = "st_init_pyrobattary";
		.else
			mov		edx, offset null_string				;tips = "";
		.endif
		;set_tip_text(tips);
		lea		ecx, [esi].m_sTipText
		mov		[esi].m_sTipText, set_shared@@_set(edx)
		movzx	eax, [esi].m_state_battery
		PRINT_UINT "m_state_battery = %d", eax
		PRINT_UINT "m_number_pyro = %d", [esi].m_number_pyro
		PRINT_UINT "m_fuse_time = %d", [esi].m_fuse_time
		mov		[esi].m_bone_fuse, @R_STRING(ebx, "bone_fuse")
		mov		edx, @R_STRING(ebx, "fuse_particles")
		mov		[esi].m_fuse_particles, CScriptParticles@@constructor(edx)
		ASSUME	edi:nothing
		mov		edx, const_static_str$("element_")
		Str_Copy(edx, &name_line)
		movflt	DEG2RAD, 0.01745329252
		and		n, 0	;=0
		.while (true)
			;name_line = "element_"..n
			@ITOA(n, &name_line[8], 10)
			.break .if (!@LINE_EXIST(section, &name_line))
			mov		edx, @R_STRING(section, &name_line)
			parse_string(edx, &data, &str_data, 7)
			mov		count, @ATOI(data[0*4])
			.for (edi=0: edi<count: edi++)
				ASSUME	ebx:ptr SLustkugelParams
				mov		ebx, xr_vector@@push_back(&[esi].m_params, size(SLustkugelParams), 128)
				@R_SECTION(data[1*4])
				mov		edx, [eax].CInifile@@Sect.Name_.p_		;shared_str
				lea		eax, [edx].str_value.value
				mov		[ebx].name_sect, eax
				mov		[ebx].delay, @ATOI(data[2*4])
				@ATOF(data[3*4])
				fmul	DEG2RAD
				fstp	[ebx].dir.x
				@ATOF(data[4*4])
				fmul	DEG2RAD
				fstp	[ebx].dir.y
				@ATOF(data[5*4])
				fmul	DEG2RAD
				fstp	[ebx].rot.x
				@ATOF(data[6*4])
				fmul	DEG2RAD
				fstp	[ebx].rot.y
				ASSUME	ebx:nothing
			.endfor
			inc		n
		.endw
		;m_current_kugel = m_params[m_number_pyro];
		xor		edx, edx
		imul	eax, [esi].m_number_pyro, size(SLustkugelParams)
		add		eax, [esi].m_params._Myfirst
		mov		[esi].m_current_kugel, eax
		mov		[esi].m_bInitVisual, true
		mov		eax, res
	.endif
	ret
CPyroBattery@@net_Spawn endp

;используем объект в инвентаре
align_proc
CPyroBattery@@UseBy proc uses esi edi entity_alive:ptr CEntityAlive
local pos:Fvector4, dir:Fvector4, dist:real4
;ecx	this	CEatableItem*
	mov		esi, ecx
	.if ([esi].m_state_battery == eBatteryNotActived)
		PRINT_UINT "CPyroBattery@@UseBy() %08X", esi
		;выкинуть из инвентаря в фокус.
		mov		eax, ds:g_pGameLevel
		mov		edx, [eax]
		mov		ecx, [edx].CLevel.m_pCameras
		ASSUME	ecx:ptr CCameraManager
		movflt	dist, 1.0
		Fvector4_set	pos, [ecx].vPosition.x, [ecx].vPosition.y, [ecx].vPosition.z, 0.0
		Fvector4_set	dir, [ecx].vDirection.x, [ecx].vDirection.y, [ecx].vDirection.z, 0.0
		ASSUME	ecx:nothing
		movups	xmm0, pos
		movups	xmm1, dir
		movss	xmm2, dist
		shufps	xmm2, xmm2, 00000000h	;0000v
		mulps	xmm1, xmm2
		addps	xmm0, xmm1
		movups	pos, xmm0
		mov		edx, entity_alive
		CScriptGameObject@@DropItemAndTeleport([edx].CEntityAlive.m_lua_game_object, [esi].m_lua_game_object, pos)
		mov		[esi].m_state_battery, eBatteryDrop
	.else
		CEatableItem@@UseBy(entity_alive)
	.endif
	ret
CPyroBattery@@UseBy endp

;используем объект вне инвентаря
align_proc
CPyroBattery@@use proc uses esi who_use:ptr CGameObject
local pos:Fvector4
;ecx	this	CUsableScriptObject*
	lea		esi, [ecx-CAntirad.CUsableScriptObject@vfptr]	;CAntirad*
	.if ([esi].m_state_battery == eBatteryActived)
		PRINT_UINT "CPyroBattery@@use() %08X", esi
		mov		[esi].m_state_battery, eBatteryInitialized
		;запустить партикл фитиля.
		mov		edx, [esi].m_bone_fuse
		.if (edx)
			mov		ecx, [esi].m_lua_game_object
			CScriptGameObject@@bone_position(&pos, edx)
		.else
			Fvector4_set	pos, [esi].XFORM_.c_
		.endif
		mov		ecx, [esi].m_fuse_particles
		CScriptParticles@@PlayAtPos(&pos)
		;set_tip_text("");
		lea		ecx, [esi].m_sTipText
		mov		[esi].m_sTipText, set_shared@@_set(&null_string)
		;if (processing_enabled())	processing_activate();
		.if ([esi].Props.bActiveCounter==0)
			lea		ecx, [esi].CGameObject@vfptr
			call	ds:CObject__processing_activate
		.endif
	.else
		CUsableScriptObject@@use(who_use)
	.endif
	ret
CPyroBattery@@use endp

align_proc
CPyroBattery@@UpdateCL proc uses esi edi ebx
local pos:Fvector4, dir:Fvector4, mass:real4, angle:real4, matrix_start:Fmatrix4
;ecx	this	CGameObject*
	lea		esi, [ecx-CAntirad.CGameObject@vfptr]			;CAntirad*
	ASSUME	esi:ptr CAntirad, edi:ptr CPHShell
	CAntirad@@UpdateCL ()
	.if ([esi].m_state_battery!=eBatteryDummy)
		mov		eax, ds:Device
		.if ([eax].CRenderDevice.dwPrecacheFrame==0)
			mov		edx, [eax].CRenderDevice.dwTimeDelta	;u32	delta = Device.dwTimeDelta;
			.if ([esi].m_state_battery==eBatteryDrop)					;выбрасываем
				mov		edi, [esi].m_pPhysicsShell
				.if (edi)
					;m_flags.set(FCanTake, FALSE);	//заблокировать взятие
					and		[esi].m_flags, not FCanTake
					;затормозить начальную скорость.
					CPhysicsShell@@get_LinearVel(edi, &dir)
					CPhysicsShell@@getMass(edi)
					fmul	FP4(-100.0)
					fstp	mass
					CPhysicsShell@@applyForce(edi, &dir, mass)
					;сориентировать объект относительно актора
					mov		eax, ds:g_pGameLevel
					mov		edx, [eax]
					mov		ecx, [edx].CLevel.m_pCameras
					ASSUME	ecx:ptr CCameraManager
					Fvector4_set	dir, [ecx].vDirection.x, 0.0, [ecx].vDirection.z, 0.0
					ASSUME	ecx:nothing
					Fvector4@normalize	dir
					movups	dir, xmm0
					Fvector@@getH(&dir)
					fstp	angle
					Fmatrix4_set	matrix_start, [edi].mXFORM.i, [edi].mXFORM.j, dir, [edi].mXFORM.c_
					lea		ecx, matrix_start.i
					Fvector4@@rotate_angle90(&[edi].mXFORM.i, &[edi].mXFORM.k, angle)
					CPhysicsShell@@SetTransform(edi, &matrix_start)
					lea		ecx, [esi].m_sTipText
					mov		[esi].m_sTipText, set_shared@@_set(&aSt_init_pyrobattary)
					mov		[esi].m_bInitVisual, true
					mov		[esi].m_state_battery, eBatteryActived
				.endif
			.elseif ([esi].m_state_battery == eBatteryInitialized)		;горит фитиль
				sub		[esi].m_fuse_time, edx	;m_fuse_time -= delta;
				.if (sdword ptr [esi].m_fuse_time <= 0)
					PRINT_UINT "m_state_battery = eBatteryAction  time[%d]", edx
					;остановить партикл
					mov		ecx, [esi].m_fuse_particles
					.if (CScriptParticles@@IsPlaying())
						mov		ecx, [esi].m_fuse_particles
						CScriptParticles@@Stop()
					.endif
					;запустить состояние стрельбы.
					mov		[esi].m_state_battery, eBatteryAction
					xor		eax, eax
					mov		[esi].m_fuse_time, eax
					mov		[esi].m_number_pyro, eax
					mrm		[esi].m_current_kugel, [esi].m_params._Myfirst
				.else
					;запустить партикл фитиля.
					mov		edx, [esi].m_bone_fuse
					.if (edx)
						mov		ecx, [esi].m_lua_game_object
						CScriptGameObject@@bone_position(&pos, edx)
					.else
						Fvector4_set	pos, [esi].XFORM_.c_
					.endif
					mov		ecx, [esi].m_fuse_particles
					.if (CScriptParticles@@IsPlaying())
						mov		ecx, [esi].m_fuse_particles
						CScriptParticles@@MoveTo(&pos, &zero_vel)
					.else
						mov		ecx, [esi].m_fuse_particles
						CScriptParticles@@PlayAtPos(&pos)
					.endif
				.endif
			.elseif ([esi].m_state_battery == eBatteryAction)			;стреляем
				sub		[esi].m_fuse_time, edx	;m_fuse_time -= delta;
				.if (sdword ptr [esi].m_fuse_time <= 0)
					ASSUME	ebx:ptr SLustkugelParams
					mov		ebx, [esi].m_current_kugel
					mrm		[esi].m_fuse_time, [ebx].delay
					CRocketLauncher@@SpawnRocket([ebx].name_sect, &[esi].CGameObject@vfptr)
					PRINT_UINT "CRocketLauncher@@SpawnRocket() name_sect[%s]", [ebx].name_sect
					add		ebx, size SLustkugelParams
					mov		[esi].m_current_kugel, ebx
					.if ([esi].m_params._Mylast==ebx)	;снаряды кончились, прекращаем стрельбу
						mov		[esi].m_state_battery, eBatteryEmpty
						PRINT_UINT "CPyroBattery STOP! %08X", esi
					.endif
					ASSUME	ebx:nothing
				.endif
			.endif
			ASSUME	edi:ptr CSE_ALifeItemPyrobattary
			mov		edi, [esi].m_pServerObj
			mrm		[edi].m_StateBattery, [esi].m_state_battery
			mrm		[edi].m_dwFuseTime, [esi].m_fuse_time
		.endif
		;if (processing_enabled())	processing_activate();
		.if ([esi].m_state_battery != eBatteryEmpty && [esi].Props.bActiveCounter==0)
			lea		ecx, [esi].CGameObject@vfptr
			call	ds:CObject__processing_activate
		.endif
		.if ([esi].m_bInitVisual && !([esi].m_flags & FCanTake))	;изменить визуал
			mov		[esi].m_bInitVisual, false
			mov		ebx, const_static_str$("visual_actived")
			mov		edx, [esi].NameSection.p_
			lea		edi, [edx].str_value.value
			.if (@LINE_EXIST(edi, ebx))
				mov		ebx, @R_STRING(edi, ebx)
				lea		eax, [esi].CGameObject@vfptr
				mov		ecx, CGameObject@@lua_game_object()
				CScriptGameObject@@SetVisualName(ebx)
			.endif
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing
	ret
CPyroBattery@@UpdateCL endp

align_proc
CPyroBattery@@AttachRocket proc uses esi edi ebx rocket_id:word
local dir_forward:Fvector4, dir_up:Fvector4, dir_right:Fvector4
local tmp:real4, DEG90:real4, dir:Fvector4, vel:Fvector4, launch_matrix:Fmatrix4, P:NET_Packet
;ecx	this	CAntirad
	ASSUME	esi:ptr CAntirad, edi:ptr CExplosiveRocket, ebx:ptr SLustkugelParams
	mov		esi, ecx
	Level__Objects_net_Find		rocket_id
	smart_cast	CExplosiveRocket, CGameObject, eax
	mov		edi, eax	;pRocket
	mov		[edi].m_pOwner, CObject@@H_Root(&[esi].CGameObject@vfptr)
	CObject@@H_SetParent(edi, &[esi].CGameObject@vfptr)
	PRINT_UINT "m_number_pyro = %d", [esi].m_number_pyro
	;загрузить стартовые партиклы и звук для люсткугеля, если они есть.
	push	esi
	mov		edx, [edi].NameSection.p_
	lea		esi, [edx].str_value.value
	mov		ebx, const_static_str$("start_particles")
	.if (@LINE_EXIST(esi, ebx))
		mov		edx, @R_STRING(esi, ebx)
		.if (edx)
			mov		[edi].m_start_particles, CScriptParticles@@constructor(edx)
		.endif
	.endif
	mov		ebx, const_static_str$("start_sound")
	.if (@LINE_EXIST(esi, ebx))
		mov		edx, @R_STRING(esi, ebx)
		.if (edx)
			ref_sound@@create(&[edi].m_start_sound, edx, st_Effect, SOUND_TYPE_WEAPON_SHOOTING)
		.endif
	.endif
	pop		esi
	;Запускам люсткугель!!!
	mov		ecx, [esi].m_params._Myfirst
	.if (ecx)
		imul	ebx, [esi].m_number_pyro, size SLustkugelParams
		add		ebx, ecx
		movflt	DEG90, PI_DIV_2
		mrm		dir_forward,[esi].XFORM_.k
		mrm		dir_up,		[esi].XFORM_.j
		mrm		dir_right,	[esi].XFORM_.i
		lea		ecx, dir
		Fvector4@@rotate_angle90(&dir_up, &dir_forward, [ebx].dir.x)
		movss	xmm0, [ebx].dir.x
		addss	xmm0, DEG90
		movss	tmp, xmm0
		lea		ecx, dir_forward
		Fvector4@@rotate_angle90(&dir_up, &dir_forward, tmp)
		lea		ecx, dir_up
		Fvector4@@rotate_angle90(&dir, &dir_right, [ebx].dir.y)		;//направление полёта
		movss	xmm0, [ebx].dir.y
		addss	xmm0, DEG90
		movss	tmp, xmm0
		lea		ecx, dir_right
		Fvector4@@rotate_angle90(&dir, &dir_right, tmp)
		;vel.mul(dir_up, pRocket->m_fStartSpeed);
		movss	xmm0, [edi].m_fStartSpeed
		shufps	xmm0, xmm0, 00000000h	;0000v
		movups	xmm1, dir_up
		mulps	xmm0, xmm1
		movups	vel, xmm0
		;//запомним ориентацию люсткугеля при старте
		lea		ecx, dir
		Fvector4@@rotate_angle90(&dir_up, &dir_forward, [ebx].rot.x)
		movss	xmm0, [ebx].rot.x
		addss	xmm0, DEG90
		movss	tmp, xmm0
		lea		ecx, dir_forward
		Fvector4@@rotate_angle90(&dir_up, &dir_forward, tmp)
		lea		ecx, dir_up
		Fvector4@@rotate_angle90(&dir, &dir_right, [ebx].rot.y)
		movss	xmm0, [ebx].rot.y
		addss	xmm0, DEG90
		movss	tmp, xmm0
		lea		ecx, dir_right
		Fvector4@@rotate_angle90(&dir, &dir_right, tmp)
		mrm		launch_matrix.k, dir_forward
		mrm		launch_matrix.j, dir_up
		mrm		launch_matrix.i, dir_right
		movflt	launch_matrix.c_.w, 1.0
		CObject@@Center(&[esi].CGameObject@vfptr, &launch_matrix.c_)
		mov		ecx, edi	;this	CExplosiveRocket*
		CCustomRocket@@SetLaunchParams(&launch_matrix, &vel, &zero_vel)
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
		ASSUME	ebx:ptr CSE_ALifeItemPyrobattary
		mov		ebx, [esi].m_pServerObj
		inc		[esi].m_number_pyro
		mrm		[ebx].m_dwNumberPyro, [esi].m_number_pyro
		.if ([esi].m_state_battery == eBatteryEmpty)
			mov		[ebx].m_bEmpty, true
			;m_pServerObj->m_dwTimeEmpty = __game_time;
			call	__game_time
			mov		[ebx].m_dwTimeEmpty, eax
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing, ebx:nothing
	ret
CPyroBattery@@AttachRocket endp

align_proc
CPyroBattery@@DetachRocket proc rocket_id:word, bLaunch:byte
	.if (!OnClient())
		mov		edx, Level@@Objects_net_Find(rocket_id)
		.if (edx)
			mrm		[edx].CExplosiveRocket.m_bLaunched, bLaunch
			CObject@@H_SetParent(edx, NULL)
		.endif
	.endif
	ret
CPyroBattery@@DetachRocket endp

;регистрация пироэлементов
align_proc
CPyroBattery@@OnEvent proc uses esi edi ebx P:ptr NET_Packet, type_:dword
;ecx	this	CGameObject*
	ASSUME	esi:ptr CAntirad, edi:ptr NET_Packet
	lea		esi, [ecx-CAntirad.CGameObject@vfptr]
	mov		ecx, esi
	CEatableItemObject@@OnEvent(P, type_)
	.if ([esi].m_state_battery != eBatteryDummy)
		mov		edi, P
		mov		ebx, type_
		.if (bx==GE_OWNERSHIP_TAKE)
			;P.r_u16(id);
			mov		eax, [edi].r_pos
			mov		dx, word ptr [edi].B.data[eax]	;rocket_id
			add		[edi].r_pos, 2
			mov		ecx, esi
			CPyroBattery@@AttachRocket(dx)
		.elseif (bx==GE_OWNERSHIP_REJECT || bx==GE_LAUNCH_ROCKET)
			;P.r_u16(id);
			mov		eax, [edi].r_pos
			mov		dx, word ptr [edi].B.data[eax]	;rocket_id
			add		[edi].r_pos, 2
			;bool	bLaunch = (type==GE_LAUNCH_ROCKET);
			cmp		bx, GE_LAUNCH_ROCKET
			setz	al
			CPyroBattery@@DetachRocket(dx, al)
		.endif
	.endif
	ASSUME	esi:nothing, edi:nothing
	ret
CPyroBattery@@OnEvent endp
;------------------------------------------------------
;Серверная часть пиробатареи.
;расширение конструктора 
align_proc
CSE_ALifeItem@@CSE_ALifeItem_ext proc
;ebx	this	CSE_ALifeItem*
	ASSUME	ebx:ptr CSE_ALifeItemPyrobattary
	mov		[ebx].m_StateBattery, eBatteryDummy
	.if (EQ_QWORD([ebx].m_tClassID, 'O_BATTAR'))
		PRINT_UINT "CSE_ALifeItem@@CSE_ALifeItem_ext() %08X", ebx
		mov		[ebx].m_StateBattery, eBatteryNotActived
		mov		[ebx].m_bEmpty, false
		mov		[ebx].m_dwNumberPyro, 0
		mov		[ebx].m_dwFuseTime, -1
		mov		[ebx].m_dwTimeEmpty, -1
	.endif
	ASSUME	ebx:nothing
;-------------------
	mov		eax, ebx
	pop		ebx
	retn
CSE_ALifeItem@@CSE_ALifeItem_ext endp

align_proc
CSE_ALifeItem@@STATE_Read_ext proc
;esi	this		CPureServerObject*
;edi	tNetPacket	NET_Packet*
;ebx	size		u16
	lea		esi, [esi-CSE_ALifeItem.IPureSerializeObject_IReader@vfptr]		;CSE_ALifeItem*
	ASSUME	esi:ptr CSE_ALifeItemPyrobattary, edi:ptr NET_Packet
	.if (EQ_QWORD([esi].m_tClassID, 'O_BATTAR'))
		PRINT_UINT "CSE_ALifeItem@@STATE_Read_ext() %08X", esi
		PRINT_UINT "tNetPacket.r_pos = %d", [edi].r_pos
		;tNetPacket.r_u8(m_StateBattery);
		mov		edx, [edi].r_pos
		mrm		[esi].m_StateBattery, [edi].B.data[edx]
		inc		edx
		;tNetPacket.r_bool(m_bEmpty);
		mrm		[esi].m_bEmpty, [edi].B.data[edx]
		inc		edx
		;tNetPacket.r_u32(m_dwNumberPyro);
		mrm		[esi].m_dwNumberPyro, dword ptr [edi].B.data[edx]
		add		edx, 4
		;tNetPacket.r_u32(m_dwFuseTime);
		mrm		[esi].m_dwFuseTime, dword ptr [edi].B.data[edx]
		add		edx, 4
		;tNetPacket.r_u32(m_dwTimeEmpty);
		mrm		[esi].m_dwTimeEmpty, dword ptr [edi].B.data[edx]
		add		edx, 4
		mov		[edi].r_pos, edx
	.endif
	ASSUME	esi:nothing, edi:nothing
;-------------------
	pop		edi
	pop		esi
	pop		ebx
	retn	8
CSE_ALifeItem@@STATE_Read_ext endp

align_proc
CSE_ALifeItem@@STATE_Write_ext proc
;edi	this		CPureServerObject*
;esi	tNetPacket	NET_Packet*
	lea		edi, [edi-CSE_ALifeItem.IPureSerializeObject_IReader@vfptr]		;CSE_ALifeItem*
	ASSUME	edi:ptr CSE_ALifeItemPyrobattary, esi:ptr NET_Packet
	.if (EQ_QWORD([edi].m_tClassID, 'O_BATTAR'))
		PRINT_UINT "CSE_ALifeItem@@STATE_Write_ext() %08X", edi
		PRINT_UINT "tNetPacket.B.count = %d", [esi].B.count
		;tNetPacket.w_u8(m_StateBattery);
		mov		edx, [esi].B.count
		mrm		[esi].B.data[edx], [edi].m_StateBattery
		inc		edx
		;tNetPacket.w_bool(m_bEmpty);
		mrm		[esi].B.data[edx], [edi].m_bEmpty
		inc		edx
		;tNetPacket.w_u32(m_dwNumberPyro);
		mrm		dword ptr [esi].B.data[edx], [edi].m_dwNumberPyro
		add		edx, 4
		;tNetPacket.w_u32(m_dwFuseTime);
		mrm		dword ptr [esi].B.data[edx], [edi].m_dwFuseTime
		add		edx, 4
		;tNetPacket.w_u32(m_dwTimeEmpty);
		mrm		dword ptr [esi].B.data[edx], [edi].m_dwTimeEmpty
		add		edx, 4
		mov		[esi].B.count, edx
	.endif
	ASSUME	esi:nothing, edi:nothing
;-------------------
	pop		edi
	pop		esi
	pop		ebx
	retn	4
CSE_ALifeItem@@STATE_Write_ext endp
