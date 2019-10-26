;==============================================================================
;===============| расширение регистрации пространства имён level |=============
;
; рефакторинг (с) НаноБот
;==============================================================================

include level_ns_reg_macros.asm

align_proc
level_script_extension_1 proc
	; делаем то, что вырезали
	call	get_snd_volume_register
	pop		ecx
	pop		ecx
;------------< регистрируем функцию получения объекта, на который смотрим >------
PERFORM_EXPORT_LEVEL__GO__U32					GetTargetObject,			"get_target_obj"
;------------< регистрируем функцию получения расстояния до объекта, на который смотрим >------
PERFORM_EXPORT_LEVEL__FLOAT__VOID				GetTargetDistance,			"get_target_dist"
;------------< регистрируем функцию получения активности эффекта камеры по айди >------
PERFORM_EXPORT_LEVEL__INT__INT					GetCamEffector,				"has_cam_effector"
;------------< регистрируем функцию получения активности pp эффекта по айди >------
PERFORM_EXPORT_LEVEL__INT__INT					GetPpEffector,				"has_pp_effector"
;------------< регистрируем функцию получения активности элементов худа >------
PERFORM_EXPORT_LEVEL__BOOL__VOID				HasIndicators,				"has_indicators"
;--< установка степени дождливости >---
;PERFORM_EXPORT_LEVEL__VOID__FLOAT				 set_rain_factor, "set_rain_factor"
PERFORM_EXPORT_LEVEL__INT__INT					advance_game_time,			"advance_game_time"
PERFORM_EXPORT_LEVEL__FLOAT__VOID				get_float_result00,			"get_float_res00"
PERFORM_EXPORT_LEVEL__FLOAT__STR_INT_BOOL_STR	get_memory_float,			"get_memory_float"
PERFORM_EXPORT_LEVEL__INT__INT					get_memory_int,				"get_memory_int"
PERFORM_EXPORT_LEVEL__BOOL__VOID				PerformRayPickQuery,		"perform_ray_pick_query"
PERFORM_EXPORT_LEVEL__FLOAT__VOID				GetRayPickQueryRes,			"get_ray_pick_dist"
PERFORM_EXPORT_LEVEL__GO__U32					GetRayPickQueryObj,			"get_ray_pick_obj"
PERFORM_EXPORT_LEVEL__INT__INT					GetRayPickQueryElement,		"get_ray_pick_element"
PERFORM_EXPORT_LEVEL__DLG__VOID					Level@@GetInventoryWindow,	"get_inventory_wnd"
PERFORM_EXPORT_LEVEL__DLG__VOID					Level@@GetPDAWindow,		"get_pda_wnd"
PERFORM_EXPORT_LEVEL__DLG__VOID					Level@@GetTalkWindow,		"get_talk_wnd"
PERFORM_EXPORT_LEVEL__DLG__VOID					Level@@GetCarBodyWindow,	"get_car_body_wnd"
PERFORM_EXPORT_LEVEL__DLG__VOID					Level@@GetTradeWindow,		"get_trade_wnd"
PERFORM_EXPORT_LEVEL__GO__U32					Level@@GetSecondTalker,		"get_second_talker"

PERFORM_EXPORT_LEVEL__INT__INT					Level@@VertexId,			"vertex_id"

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; имитация ввода
PERFORM_EXPORT_LEVEL__INT__INT					SendEventMouseWheel,		"send_event_mouse_wheel"
PERFORM_EXPORT_LEVEL__INT__INT					SendEventKeyHold,			"send_event_key_hold"
PERFORM_EXPORT_LEVEL__INT__INT					SendEventKeyRelease,		"send_event_key_release"
PERFORM_EXPORT_LEVEL__INT__INT					SendEventKeyPressed,		"send_event_key_press"
; доступ к внутреннему классу камэффектора
PERFORM_EXPORT_LEVEL__VOID__FLOAT				CE_Set_Time,				"set_ce_time"
PERFORM_EXPORT_LEVEL__VOID__FLOAT				CE_Set_Amplitude,			"set_ce_amplitude"
PERFORM_EXPORT_LEVEL__VOID__FLOAT				CE_Set_PeriodNumber,		"set_ce_period_number"
PERFORM_EXPORT_LEVEL__VOID__FLOAT				CE_Set_Power,				"set_ce_power"
PERFORM_EXPORT_LEVEL__BOOL__VOID				CE_Add,						"add_ce"
; возвращает номер элемента на который смотрим
PERFORM_EXPORT_LEVEL__INT__INT					GetTargetElement,			"get_target_element"
; =========================================================================================
; ======================================= END =============================================
; ===========================================================================
;------------< регистрируем функции получения вершин статического треугольника по индексу >------
PERFORM_EXPORT_LEVEL__VECTOR__U32				GetTriangleVertex1,			"get_tri_vertex1"
PERFORM_EXPORT_LEVEL__VECTOR__U32				GetTriangleVertex2,			"get_tri_vertex2"
PERFORM_EXPORT_LEVEL__VECTOR__U32				GetTriangleVertex3,			"get_tri_vertex3"
;------------< регистрируем функции получения свойства статического треугольника по индексу: простреливаемость>------
PERFORM_EXPORT_LEVEL__FLOAT__STR_INT_BOOL_STR	Level@@GetMtlShootFactor,	"get_tri_shootfactor"
;------------< регистрируем функции получения свойства статического треугольника по индексу: флаги>------
PERFORM_EXPORT_LEVEL__INT__INT					Level@@GetMtlFlags,			"get_tri_flags"
;---взрывчатка CBulletExplosive---
PERFORM_EXPORT_LEVEL__INT__STR_INT				Level@@CreateExplosive,		"create_explosive"
PERFORM_EXPORT_LEVEL__U32__U32_VECTOR_FLOAT		Level@@Explode,				"explode"
PERFORM_EXPORT_LEVEL__INT__INT					Level@@DeleteExplosive,		"delete_explosive"
;------------< блокировка цифр(0..9) на основной клавиатуре. >-----------
PERFORM_EXPORT_LEVEL__VOID__VOID				Level@@EnableInputNumbase,	"enable_input_numbase"
PERFORM_EXPORT_LEVEL__VOID__VOID				Level@@DisableInputNumbase,	"disable_input_numbase"
;------------------------------------------------------------------------
;улучшеная функция трассировки пересечения луча и геометрии.
PERFORM_EXPORT_LEVEL__U32__U32_VECTOR_FLOAT		RayPickFlagsDirRange,		"test_raypick_flg_dir_dist"
PERFORM_EXPORT_LEVEL__FLOAT__U32_PVECTOR		SetPrmRayPickIdPos,			"set_raypick_id_pos"
;нормаль треугольника геометрии
PERFORM_EXPORT_LEVEL__VECTOR__U32				GetStaticNormalTriangle,	"get_static_normal_triangle"
;--------------------------------------
	jmp		return_level_script_extension_1
level_script_extension_1 endp

;===============| расширение регистрации пространства имён actor_stats |=============
align_proc
level_script_extension_2 proc
	;вырезаное
	call	register_level__void__u16
	pop		ecx
	pop		ecx
;----------------------------------------------------
;Тип подсчёта статистики в КПК
PERFORM_EXPORT_LEVEL__VOID__U32					Level@@SetTypeStatistic,	"set_type_statistic"
PERFORM_EXPORT_LEVEL__U32__VOID					Level@@GetTypeStatistic,	"get_type_statistic"

;----------------------------------------------------
	jmp		return_level_script_extension_2
level_script_extension_2 endp
;==============================================================================

align_proc
level_ns_extension_2: ; здесь надо добавлять столько раз   "mov ecx, eax" + "call esi", сколько добавляли функций
; делаем то, что вырезали
	mov		ecx, eax
	call	esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
	mov		ecx, eax
	call	esi ; luabind::scope::operator,(luabind::scope) ; luabind::scope::operator,(luabind::scope)
; добавляем своё
	; для get_target_obj не требуется ?
	mov		ecx, eax
	call	esi
	; для get_target_dist
	mov		ecx, eax
	call	esi
	; для has_cam_effector
	mov		ecx, eax
	call	esi
	; для has_pp_effector
	mov		ecx, eax
	call	esi
	; для has_indicators
	mov		ecx, eax
	call	esi
	; для set_rain_factor
	;mov	 ecx, eax
	;call	 esi
	; для advance_game_time
	mov		ecx, eax
	call	esi
	; для get_float_result00
	mov		ecx, eax
	call	esi
	; для get_memory_float
	mov		ecx, eax
	call	esi
	; для get_memory_int
	mov		ecx, eax
	call	esi
	; для perform_ray_pick_query
	mov		ecx, eax
	call	esi
	; для get_ray_pick_query_res
	mov		ecx, eax
	call	esi
	; get_ray_pick_obj
	mov		ecx, eax
	call	esi
	; get_ray_pick_element
	mov		ecx, eax
	call	esi
	; get_inventory_wnd
	mov		ecx, eax
	call	esi
	; get_pda_wnd
	mov		ecx, eax
	call	esi
	; get_talk_wnd
	mov		ecx, eax
	call	esi
	; get_car_body_wnd
	mov		ecx, eax
	call	esi
	; get_trade_wnd
	mov		ecx, eax
	call	esi
	; get_second_talker
	mov		ecx, eax
	call	esi
	; для vertex_ix
	mov		ecx, eax
	call	esi	
	; имитация ввода
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	; доступ к внутреннему классу камэффектора
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	; для get_target_element
	mov		ecx, eax
	call	esi
	; для get_tri_vertex1/2/3
	mov		ecx, eax
	call	esi	
	mov		ecx, eax
	call	esi	
	mov		ecx, eax
	call	esi	
	; get_tri_shootfactor
	mov		ecx, eax
	call	esi
	; get_tri_flags
	mov		ecx, eax
	call	esi
	; ---rev232---
	; create_explosive
	mov		ecx, eax
	call	esi
	; explode
	mov		ecx, eax
	call	esi
	; delete_explosive
	mov		ecx, eax
	call	esi
	; для enable_input_numbase
	mov		ecx, eax
	call	esi
	; для disble_input_numbase
	mov		ecx, eax
	call	esi
	; для RayPickFlagsDirRange
	mov		ecx, eax
	call	esi
	; для SetPrmRayPickIdPos
	mov		ecx, eax
	call	esi
	; для GetStaticNormalTriangle
	mov		ecx, eax
	call	esi
	
; идём обратно
	jmp 	back_to_level_ns_ext_2
;===============| расширение регистрации пространства имён actor_stats |=============
level_ns_extension_3 proc
	;вырезаное
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
;------------------------
	; для set_type_statistic, get_type_statistic
	mov		ecx, eax
	call	esi
	mov		ecx, eax
	call	esi
	
	jmp 	return_level_ns_extension_3
level_ns_extension_3 endp
;#####################################################################################
align_proc
CCustomHUD__GetRQ proc
	mov		edx, g_hud ; CCustomHUD * g_hud
	mov		ecx, [edx]
	mov		eax, [ecx].CHUDManager.m_pHUDTarget
	add		eax, CHUDTarget.RQ	; collide__rq_result*
	retn
CCustomHUD__GetRQ endp

align_proc
GetTargetDistance proc
	call	CCustomHUD__GetRQ
	ASSUME	eax:ptr collide__rq_result
	fld		[eax].range
	ret
GetTargetDistance endp

align_proc
GetTargetObject proc C uses edi obj:dword
	call	CCustomHUD__GetRQ
	mov		eax, [eax].O
	.if (eax)
		mov		edi, eax
		call	CGameObject__lua_game_object
	.endif
	ret
GetTargetObject endp

; возвращает номер элемента на который смотрим
align_proc
GetTargetElement proc int_param:dword
	call	CCustomHUD__GetRQ
	mov		eax, [eax].element
	ASSUME	eax:nothing
	ret
GetTargetElement endp

align_proc
GetCamEffector proc C id:dword
	mov		edx, id
	and		edx, 0FFFFh
	mov		ecx, g_Actor
	mov		ecx, [ecx+554h]
	push	edx
	call	ds:CCameraManager__GetCamEffector
	test	eax, eax
	setnz	al
	ret
GetCamEffector endp

align_proc
GetPpEffector proc C id:dword
	mov		ecx, g_Actor
	mov		ecx, [ecx+554h]
	push	id
	call	ds:CCameraManager__GetPPEffector
	test	eax, eax
	setnz	al
	ret
GetPpEffector endp

align_proc
HasIndicators proc
	mov		ecx, ds:g_pGameLevel
	mov		edx, [ecx]
	mov		ecx, [edx+148h]
	mov		eax, [ecx]
	mov		edx, [eax+18h]
	call	edx
	cmp		byte ptr [eax+30h], 0
	setnz	al
	retn
HasIndicators endp

align_proc
set_rain_factor proc C rain_factor:dword
	mov		eax, ds:g_pGamePersistent
	mov		eax, [eax]
	mov		eax, [eax+46Ch]
	mov		edx, rain_factor
	mov		dword ptr [eax+1CCh], edx
	ret
set_rain_factor endp

align_proc
game_sv_Single__AdvanceGameTime proc uses esi edi additional_time:dword
	mov		esi, ecx
	cmp		g_ai_space, 0
	jnz		ai_space_exists
	call	xr_new_CAI_Space_
	mov		ecx, eax
	mov		g_ai_space, eax
	call	CAI_Space__init
ai_space_exists:
	mov		eax, g_ai_space
	mov		eax, [eax+18h]
	test	eax, eax
	jz		exit
	mov		ecx, [eax+0Ch]
	mov		edx, [ecx+4]
	cmp		byte ptr [edx+eax+40h], 0
	jz		exit
	mov		esi, [esi+120h]
	mov		eax, [esi+0Ch]
	mov		ecx, [eax+4]
	mov		edi, [ecx+esi+18h]
	call	CALifeTimeManager__game_time
	;PRINT "CALifeTimeManager__game_time"
	;PRINT_UINT "eax=%x", eax
	;PRINT_UINT "edx=%x", edx
	add		eax, additional_time
	jnc		no_carry
	inc		edx
no_carry:
	mov		[edi+8], eax
	mov		[edi+0Ch], edx
	mov		edx, ds:Device
	mov		eax, [edx+204h]
	mov		[edi+18h], eax
exit:
	ret
game_sv_Single__AdvanceGameTime endp

align_proc
advance_game_time proc C additional_time:dword
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	mov		eax, [eax+45F4h]
	mov		ecx, [eax+108D4h]
	push	ecx
	invoke	game_sv_Single__AdvanceGameTime, additional_time
	pop		ecx
	call	game_GameState__UpdateTime
	ret
advance_game_time endp

align_proc
game_GameState__UpdateTime proc uses esi edi
	mov		eax, ds:g_pGameLevel
	mov		edi, [eax]
	ASSUME	edi:ptr CLevel, esi:ptr game_cl_GameState
	mov		esi, [edi].game		; = game
	mov		eax, [esi].m_qwStartGameTime.lo
	mov		edx, [esi].m_qwStartGameTime.hi
	call	__game_time
	mov		[esi].m_qwStartGameTime.lo, eax
	mov		[esi].m_qwStartGameTime.hi, edx
	lea		ecx, [edi].MultipacketReciever@vfptr	;IPureClient
	call	ds:IPureClient__timeServer_Async
	mov		[esi].m_qwStartProcessorTime.lo, eax
	mov		[esi].m_qwStartProcessorTime.hi, 0
	ASSUME	edi:nothing, esi:nothing
	ret
game_GameState__UpdateTime endp

_static		g_float_res00 real4 0.0

align_proc
get_float_result00 proc
	fld		g_float_res00
	retn
get_float_result00 endp

align_proc
get_memory_float proc C str_param1:dword, addres:dword, bool_param3:byte, str_param4:dword
	mov		eax, addres
	fld		dword ptr [eax]
	ret
get_memory_float endp

align_proc
get_memory_int proc C addres:dword
	mov		edx, addres
	mov		eax, [edx]
	ret
get_memory_int endp

_static		rq_res		collide__rq_result {0, 123.0, 0}
;g_vector_arg_1		-- db.actor:set_vector_global_arg_1(v)
;g_int_argument_1	-- set_int_arg0(n)
;g_float_arg1		-- set_float_args_12(a,b)
;g_object_arg_1		-- db.actor:set_object_arg_1(obj)
align_proc
PerformRayPickQuery proc
	mov		edx, g_object_arg_1						; CScriptGameObject*
	.if (edx)
		mov		edx, [edx].CScriptGameObject.object	; CGameObject*
	.endif
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	add		ecx, CLevel.ObjectSpace
;	CObjectSpace__RayPick(Fvector const &, Fvector const &, float, collide::rq_target, collide::rq_result &, CObject *)
	invoke2	CObjectSpace__RayPick, addr g_vector_arg_2, addr g_vector_arg_1, g_float_arg1, g_int_argument_1, addr rq_res, edx
	retn
PerformRayPickQuery endp

_static		raypick_test_pos	Fvector {0.0, 0.0, 0.0}
_static		raypick_ignore_obj	dword	0

align_proc
SetPrmRayPickIdPos proc C id_ignor_obj:dword, pos_test:dword
	mov		eax, id_ignor_obj
	.if (eax>0FFFFh)
		xor		eax, eax
	.else
		Level__Objects_net_Find	eax
	.endif
	mov		raypick_ignore_obj, eax
	mov		edx, pos_test
	ASSUME	edx:ptr Fvector
	Fvector_set	raypick_test_pos, [edx].x, [edx].y, [edx].z
	ASSUME	edx:nothing
	fldz
	ret
SetPrmRayPickIdPos endp

align_proc
RayPickFlagsDirRange proc C flags:dword, dir_test:Fvector, range:real4
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	add		ecx, CLevel.ObjectSpace
;	_RayPick(const Fvector &start, const Fvector &dir, float range, collide::rq_target tgt, collide::rq_result& R, CObject* ignore_object)
	invoke2	CObjectSpace__RayPick, addr raypick_test_pos, addr dir_test, range, flags, addr rq_res, raypick_ignore_obj
	mov		eax, rq_res.element
	ret
RayPickFlagsDirRange endp

align_proc
GetRayPickQueryRes proc
	fld		rq_res.range
	retn
GetRayPickQueryRes endp

align_proc
GetRayPickQueryObj proc C uses edi obj:dword
	mov		edi, rq_res.O
	xor		eax, eax
	.if (edi)
		call	CGameObject__lua_game_object
	.endif
	ret
GetRayPickQueryObj endp

align_proc
GetRayPickQueryElement proc
	mov		eax, rq_res.element
	retn
GetRayPickQueryElement endp

align_proc
Level@@GetInventoryWindow proc
	call	GetGameSP
	.if (eax)
		mov		eax, [eax].CUIGameSP.InventoryMenu
	.endif
	retn
Level@@GetInventoryWindow endp

align_proc
Level@@GetPDAWindow proc
	call	GetGameSP
	.if (eax)
		mov		eax, [eax].CUIGameSP.PdaMenu
	.endif
	retn
Level@@GetPDAWindow endp

align_proc
Level@@GetTalkWindow proc
	call	GetGameSP
	.if (eax)
		mov		eax, [eax].CUIGameSP.TalkMenu
	.endif
	retn
Level@@GetTalkWindow endp

align_proc
Level@@GetCarBodyWindow proc
	call	GetGameSP
	.if (eax)
		mov		eax, [eax].CUIGameSP.UICarBodyMenu
	.endif
	retn
Level@@GetCarBodyWindow endp

align_proc
Level@@GetTradeWindow proc
	call	Level@@GetTalkWindow
	.if (eax)
		mov		eax, [eax].CUITalkWnd.UITradeWnd
	.endif
	retn
Level@@GetTradeWindow endp

; % echo @CatStr(% CHelicopter.m_light_range)
; % echo @CatStr(%sizeof CWeaponMounted);
align_proc
Level@@GetSecondTalker proc uses edi param:dword
	call	Level@@GetTalkWindow
	.if (eax)
		mov		ecx, [eax].CUITalkWnd.m_pOthersInvOwner		;CInventoryOwner*
		xor		eax, eax
		.if (ecx)
			smart_cast	CGameObject, CInventoryOwner, ecx
			mov		edi, eax
			call	CGameObject__lua_game_object
		.endif
	.endif
	ret
Level@@GetSecondTalker endp

align_proc
Level@@VertexId proc
	mov		eax, g_ai_space		; CAI_Space
	mov		eax, [eax].CAI_Space.m_level_graph
	push	offset g_vector_arg_1
	call	CLevelGraph__vertex_id
	retn
Level@@VertexId endp

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; имитации нажатий кнопок и колеса
align_proc
SendEventMouseWheel proc C direction:dword
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	mov		edx, [eax+10h]
	mov		edx, [edx+14h]
	lea		ecx, [eax+10h]
	push	direction
	call	edx
	ret
SendEventMouseWheel endp

align_proc
SendEventKeyHold proc C id:dword
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	mov		edx, [eax+10h]
	mov		edx, [edx+28h]
	lea		ecx, [eax+10h]
	push	id
	call	edx
	ret
SendEventKeyHold endp

align_proc
SendEventKeyRelease proc C id:dword
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	mov		edx, [eax+10h]
	mov		edx, [edx+24h]
	lea		ecx, [eax+10h]
	push	id
	call	edx
	ret
SendEventKeyRelease endp

align_proc
SendEventKeyPressed proc C id:dword
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	mov		edx, [eax+10h]
	mov		edx, [edx+20h]
	lea		ecx, [eax+10h]
	push	id
	call	edx
	ret
SendEventKeyPressed endp

; доступ к внутреннему классу камэффектора
static_float	global_ce_time, 0.0
static_float	global_ce_amplitude, 0.0
static_float	global_ce_period_number, 0.0
static_float	global_ce_power, 0.0

align_proc
CE_Set_Time proc C time:dword
	mrm		global_ce_time, time
	ret
CE_Set_Time endp

align_proc
CE_Set_Amplitude proc C amp:dword
	mrm		global_ce_amplitude, amp
	ret
CE_Set_Amplitude endp

align_proc
CE_Set_PeriodNumber proc C periods:dword
	mrm		global_ce_period_number, periods
	ret
CE_Set_PeriodNumber endp

align_proc
CE_Set_Power proc C power:dword
	mrm		global_ce_power, power
	ret
CE_Set_Power endp

align_proc
CE_Add proc
	invoke	xr_new__CMonsterEffectorHit, addr global_ce_time, addr global_ce_amplitude, addr global_ce_period_number, addr global_ce_power
	mov		ecx, g_Actor
	mov		ecx, [ecx].CActor.m_pActorEffector
	push	eax
	call	ds:CCameraManager__AddCamEffector
	retn
CE_Add endp

; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
align_proc
GetTriangleVertex1 proc C uses edi res:dword, index:dword
	mov		eax, index ; results.element
	.if (eax!=-1)
		mov		ecx, ds:g_pGameLevel
		mov		ecx, [ecx]
		ASSUME	ecx:ptr CLevel, edx:ptr CDB@@TRI
		mov		edx, [ecx].ObjectSpace.Static.tris 	;+0DCh CDB::TRI* pTri = Level().ObjectSpace.GetStaticTris()
		mov		edi, [ecx].ObjectSpace.Static.verts ;+0E4h Fvector*  pVerts = Level().ObjectSpace.GetStaticVerts();
		shl		eax, 4			; eax = results.element * 8
		lea		edx, [eax+edx]	; eax = *(game_level + 0dch) + results.element*8 == pTri
		mov		eax, [edx].verts[0*4]	   ; index of second vertex
		; умножим eax на 12
		lea		eax, [eax+eax*2] ; eax = ind * 3
		lea		ecx, [edi+eax*4] ; ecx = edi + ind * 12
		ASSUME	edx:ptr Fvector, ecx:ptr Fvector
		mov		edx, res
		Fvector_set	[edx], [ecx].x, [ecx].y, [ecx].z
	.else
		mov		edx, res
		xor		eax, eax
		Fvector_set	[edx], eax, eax, eax
		ASSUME	edx:nothing, ecx:nothing
	.endif
	mov		eax, edx
	ret
GetTriangleVertex1 endp

align_proc
GetTriangleVertex2 proc C uses edi res_pvector:dword, index:dword
	mov		eax, index ; results.element
	.if (eax!=-1)
		mov		ecx, ds:g_pGameLevel
		mov		ecx, [ecx]
		ASSUME	ecx:ptr CLevel, edx:ptr CDB@@TRI
		mov		edx, [ecx].ObjectSpace.Static.tris		; CDB::TRI* pTri
		mov		edi, [ecx].ObjectSpace.Static.verts		; Fvector*  pVerts
		shl		eax, 4			; eax = results.element * 8
		lea		edx, [eax+edx]	; eax = *(game_level + 0dch) + results.element*8 == pTri
		mov		eax, [edx].verts[1*4]	   ; index of second vertex
		; умножим eax на 12
		lea		eax, [eax+eax*2] ; eax = ind * 3
		lea		ecx, [edi+eax*4] ; ecx = edi + ind * 12
		ASSUME	edx:ptr Fvector, ecx:ptr Fvector
		mov		edx, res_pvector
		Fvector_set	[edx], [ecx].x, [ecx].y, [ecx].z
	.else
		mov		edx, res_pvector
		xor		eax, eax
		Fvector_set	[edx], eax, eax, eax
		ASSUME	edx:nothing, ecx:nothing
	.endif
	mov		eax, edx
	ret
GetTriangleVertex2 endp

align_proc
GetTriangleVertex3 proc C uses edi res_pvector:dword, index:dword
	mov		eax, index ; results.element
	.if (eax!=-1)
		mov		ecx, ds:g_pGameLevel
		mov		ecx, [ecx]
		ASSUME	ecx:ptr CLevel, edx:ptr CDB@@TRI
		mov		edx, [ecx].ObjectSpace.Static.tris	; CDB::TRI* pTri = Level().ObjectSpace.GetStaticTris()
		mov		edi, [ecx].ObjectSpace.Static.verts ; Fvector*  pVerts = Level().ObjectSpace.GetStaticVerts();
		shl		eax, 4			; *(16=sizeof CDB::TRI)
		lea		edx, [eax+edx]	; eax = results.element*16 == pTri
		mov		eax, [edx].verts[2*4]
		lea		eax, [eax+eax*2] ; умножим eax на 12
		lea		ecx, [edi+eax*4]
		ASSUME	edx:ptr Fvector, ecx:ptr Fvector
		mov		edx, res_pvector
		Fvector_set	[edx], [ecx].x, [ecx].y, [ecx].z
	.else
		mov		edx, res_pvector
		xor		eax, eax
		Fvector_set	[edx], eax, eax, eax
		ASSUME	edx:nothing, ecx:nothing
	.endif
	mov		eax, edx
	ret
GetTriangleVertex3 endp

; --------=====НаноБот=====---------
align_proc
Level@@GetMtlShootFactor proc C arg1_str:dword, element:dword, arg_bool:byte, arg2_str:dword
; string, integer, boolean (byte), string
	mov		eax, element
	;PRINT_UINT "element = %d", eax
	.if (eax!=-1)
		mov		ecx, ds:g_pGameLevel
		mov		ecx, [ecx]
		ASSUME	ecx:ptr CLevel, edx:ptr CDB@@TRI
		mov		edx, [ecx].ObjectSpace.Static.tris		; CDB::TRI*
		shl		eax, 4				; eax = results.element * 8
		mov		cx, [edx+eax].material
		and		ecx, 3FFFh			; hit_material_idx
		mov		eax, ds:materials
		mov		ecx, [eax+ecx*4]
		ASSUME	ecx:ptr SGameMtl
		fld		[ecx].fShootFactor
		ASSUME	edx:nothing, ecx:nothing
	.else
		fldz						; в стек сопроц. ноль
	.endif
	;----------------------
	ret
Level@@GetMtlShootFactor  endp

align_proc
Level@@GetMtlFlags proc C uses esi index:dword
	mov		eax, index
	.if (eax!=-1)	; if (element != -1)
		mov		ecx, ds:g_pGameLevel
		mov		ecx, [ecx]
		ASSUME	ecx:ptr CLevel, edx:ptr CDB@@TRI
		mov		edx, [ecx].ObjectSpace.Static.tris		; CDB::TRI*
		shl		eax, 4				; eax = results.element * 8
		mov		cx, [edx+eax].material
		and		ecx, 3FFFh			; hit_material_idx
		mov		eax, ds:materials
		mov		ecx, [eax+ecx*4]
		ASSUME	ecx:ptr SGameMtl
		mov		eax, [ecx].Flags
		ASSUME	edx:nothing, ecx:nothing
	.endif
	ret
Level@@GetMtlFlags	endp
; --------===============---------
;========CBulletExplosive========
align_proc
Level@@CreateExplosive proc C name_section:dword, id_weapon:dword
	;return		(Level().BulletManager().CreateExplosive(name_section, id_weapon));
	mov		eax, ds:g_pGameLevel
	mov		edx, [eax]	; CLevel
	mov		ecx, [edx].CLevel.m_pBulletManager
	invoke	CBulletManager@@CreateExplosive, name_section, id_weapon
	ret
Level@@CreateExplosive endp

align_proc
Level@@Explode proc C id_explosive:dword, pos_x:dword, pos_y:dword, pos_z:dword, id_initiator:dword
local pos_explo:Fvector, direction1:Fvector
	Fvector_set	pos_explo, pos_x, pos_y, pos_z
	Fvector_set direction1, 0.0, 1.0, 0.0
	;Level().BulletManager().Explode(id_explosive, &pos_explo, &direction1, (int)id_initiator);
	mov		ecx, ds:g_pGameLevel
	mov		eax, [ecx]	; CLevel
	movss	xmm0, id_initiator
	cvttss2si edx, xmm0
	mov		ecx, [eax].CLevel.m_pBulletManager
	invoke	CBulletManager@@Explode, id_explosive, addr pos_explo, addr direction1, edx
	ret
Level@@Explode endp

align_proc
Level@@DeleteExplosive proc C id_explosive:dword
	mov		edx, ds:g_pGameLevel
	mov		eax, [edx]	; 
	mov		ecx, [eax].CLevel.m_pBulletManager
	invoke	CBulletManager@@DeleteExplosive, id_explosive
	ret
Level@@DeleteExplosive endp

;;; (с) НаноБот
static_byte		g_bDisableNumBaseInput, false	; булева для блокировки цифр(0..9) на основной клавиатуре.
; заблокировать клавиатуру
align_proc
Level@@EnableInputNumbase proc
	mov		g_bDisableNumBaseInput, false
	retn
Level@@EnableInputNumbase endp

; разблокировать клавиатуру
align_proc
Level@@DisableInputNumbase proc
	mov		g_bDisableNumBaseInput, true
	retn
Level@@DisableInputNumbase endp

;Тип подсчёта статистики в КПК: 0 - подсчёт по штукам, 1 - подсчёт по очкам.
align_proc
Level@@SetTypeStatistic proc C type_stat:dword
	mov		eax, type_stat
	test	eax, eax
	setnz	al
	movzx	eax, al		; разрешёные индексы только 0 и 1
	mov		g_select_total_statistic, eax
	ret
Level@@SetTypeStatistic endp

align_proc
Level@@GetTypeStatistic proc
	mov		eax, g_select_total_statistic
	retn
Level@@GetTypeStatistic endp

align_proc
GetStaticNormalTriangle proc C uses ebx res_pvector:dword, element:dword
local _a:Fvector4, _b:Fvector4, _c:Fvector4, _n:Fvector4
;	local _n = vector()
;	local _a = level.get_tri_vertex1(element)
;	local _b = level.get_tri_vertex2(element)
;	local _c = level.get_tri_vertex3(element)
;	_n.x = ((_b.z-_a.z)*(_c.y-_a.y))-((_b.y-_a.y)*(_c.z-_a.z))
;	_n.y = ((_b.x-_a.x)*(_c.z-_a.z))-((_b.z-_a.z)*(_c.x-_a.x))
;	_n.z = ((_b.y-_a.y)*(_c.x-_a.x))-((_b.x-_a.x)*(_c.y-_a.y))
;	return _n:normalize()
	mov		ebx, element
	.if (ebx==-1)
		xorps	xmm0, xmm0
		movups	_n, xmm0
	.else
		xor		eax, eax
		mov		_a.w, eax
		mov		_b.w, eax
		mov		_c.w, eax
		invoke	GetTriangleVertex1, addr _a, ebx
		invoke	GetTriangleVertex2, addr _b, ebx
		invoke	GetTriangleVertex3, addr _c, ebx
		movups	xmm0, _a
		movups	xmm1, _b
		movups	xmm2, _c
		movaps	xmm3, xmm1
		movaps	xmm4, xmm2
		subps	xmm3, xmm0	; = _b-_a
		subps	xmm4, xmm0	; = _c-_a
		movaps	xmm5, xmm4 ;|w|z|y|x|
		shufps	xmm5, xmm5, 11010010b	; 3102v	// перемещаем члены x->z, y->x, z->y
		mulps	xmm5, xmm3	; левая часть готова!
		movaps	xmm6, xmm4 ;|w|z|y|x|
		shufps	xmm6, xmm6, 11001001b	; 3021v	// перемещаем члены x->y, y->z, z->x
		mulps	xmm6, xmm3	; правая часть готова!
		shufps	xmm6, xmm6, 11010010b	; 3102v	// перемещаем члены x->z, y->x, z->y
		subps	xmm5, xmm6
		shufps	xmm5, xmm5, 11010010b	; 3102v	// перемещаем члены x->z, y->x, z->y
		movups	_n, xmm5
		Fvector@normalize	_n
	.endif
	mov		edx, res_pvector
	ASSUME	edx:ptr Fvector
	Fvector_set	[edx], _n.x, _n.y, _n.z
	ASSUME	edx:nothing
	mov		eax, edx
	ret
GetStaticNormalTriangle endp
