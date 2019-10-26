

;namespace GameObject {
;	enum ECallbackType {
GameObject__eTradeStart						= dword ptr 0		; void
GameObject__eTradeStop						= dword ptr 1		; void
GameObject__eTradeSellBuyItem				= dword ptr 2		; GO, bool, u32
GameObject__eTradePerformTradeOperation		= dword ptr 3		; u32, u32

GameObject__eZoneEnter						= dword ptr 4		; GO, GO
GameObject__eZoneExit						= dword ptr 5		; GO, GO
GameObject__eExitLevelBorder				= dword ptr 6		; GO
GameObject__eEnterLevelBorder				= dword ptr 7		; GO
GameObject__eDeath							= dword ptr 8		; GO, GO

GameObject__ePatrolPathInPoint				= dword ptr 9		; GO, u32, u32

GameObject__eInventoryPda					= dword ptr 10		; 
GameObject__eInventoryInfo					= dword ptr 11		; GO, str
GameObject__eArticleInfo					= dword ptr 12		; GO, str, str, int
GameObject__eTaskStateChange				= dword ptr 13		; SGameTask, SGameTaskObjective, ETaskState
GameObject__eMapLocationAdded				= dword ptr 14		; str, u16

GameObject__eUseObject						= dword ptr 15		; GO	и GO, GO

GameObject__eHit							= dword ptr 16		; GO, float, vector, GO, s16 | GO, float, vector, GO, u16

GameObject__eSound							= dword ptr 17		; GO, GO, int, vector, float

GameObject__eActionTypeMovement				= dword ptr 18		; GO, u32, -1
GameObject__eActionTypeWatch				= dword ptr 19		; GO, u32
GameObject__eActionTypeAnimation			= dword ptr 20		; GO, u32
GameObject__eActionTypeSound				= dword ptr 21		; GO, u32
GameObject__eActionTypeParticle				= dword ptr 22		; GO, u32
GameObject__eActionTypeObject				= dword ptr 23		; GO, u32

GameObject__eActorSleep						= dword ptr 24		; 

GameObject__eHelicopterOnPoint				= dword ptr 25		; float, vector, int
GameObject__eHelicopterOnHit				= dword ptr 26		; float, float, int, u32

GameObject__eOnItemTake						= dword ptr 27		; GO
GameObject__eOnItemDrop						= dword ptr 28		; GO

GameObject__eScriptAnimation				= dword ptr 29		; void

GameObject__eTraderGlobalAnimationRequest	= dword ptr 30		; void
GameObject__eTraderHeadAnimationRequest		= dword ptr 31		; void
GameObject__eTraderSoundEnd					= dword ptr 32		; void

GameObject__eInvBoxItemTake					= dword ptr 33		; GO, GO
GameObject__eDummy							= dword ptr -1

;NEW
eDesroyObjectInAnomaly						= dword ptr 34		; Колбек на разрушения объекта в аномалии.
eAllHitObjects								= dword ptr 35		; Колбек на хит, вызывается для всех объектов, требует включения скриптом.
eEatObject									= dword ptr 36		; Колбек на поедание.
eHitToAnomalyFromObject						= dword ptr 128		; хит аномалией объекта
eOnSwitchTorch								= dword ptr 134		; переключение фонарика
eSetLevelDestVertex							= dword ptr 135		; Вызов метода set_dest_level_vertex_id для сталкеров, передается левел вертекс
eAttachActorVehicle							= dword ptr 137		; Посадка в машину
eUseActorVehicle							= dword ptr 138		; Использование машины
eDetachActorVehicle							= dword ptr 139		; Высадка из машины
eOnSaveGame									= dword ptr 140		; сохранение игры
eHitToActorFromMob							= dword ptr 144		; Хит актора от мобов
;	};
;};

type_hit_mob_stalker						= dword ptr 0
type_hit_mob_monster						= dword ptr 1

align_proc
CCustomZone__CreateHit_callback proc id_to:dword, id_from:dword, hit_power:dword, bone_id:dword, hit_impulse:dword, hit_type:dword
org		$-3	;зачистим (push ebp/mov ebp,esp) ebp и так указывает на параметры
;ebx - this			CCustomZone*
;esi - pos_in_bone	Fvector
;edi - hit_dir		Fvector
	call	SHit__Write_Packet
	push	esi
	ASSUME	edi:ptr Fvector
	Level__Objects_net_Find  id_to
	mov		ecx, eax
	call	CGameObject@@lua_game_object
	mov		esi, eax
	Level__Objects_net_Find  id_from
	mov		ecx, eax
	call	CGameObject@@lua_game_object
	CALLBACK__GO_GO_INT_VECTOR_FLOAT	ebx, eHitToAnomalyFromObject, esi, eax, hit_type, [edi], hit_power
	ASSUME	edi:nothing
	pop		esi
	jmp		return_CCustomZone__CreateHit_callback
CCustomZone__CreateHit_callback endp

align_proc
CCustomZone__enter_Zone_callback proc
;ebp - this		Touch@Feel
;esi - obj		CGameObject*
	mov		ecx, esi
	call	CGameObject@@lua_game_object
	lea		edx, [ebp-CCustomZone.Feel@@Touch@vfptr]	;-19Ch = CGameObject
	CALLBACK__GO	edx, GameObject__eZoneEnter, eax
	;Вырезанное
	mov		eax, [esi]
	mov		edx, [eax+80h]
	jmp		return_CCustomZone__enter_Zone_callback
CCustomZone__enter_Zone_callback endp

align_proc
CCustomZone__exit_Zone_callback proc
;ebx - this		Touch@Feel
;esi - obj		CGameObject*
	mov		ecx, esi
	call	CGameObject@@lua_game_object
	lea		edx, [ebx-CCustomZone.Feel@@Touch@vfptr]	;-19Ch = CGameObject
	CALLBACK__GO	edx,  GameObject__eZoneExit, eax
	;Вырезанное
	mov		eax, [esi]
	mov		edx, [eax+80h]
	jmp		return_CCustomZone__exit_Zone_callback
CCustomZone__exit_Zone_callback endp

align_proc
CTeleWhirlwindObject__destroy_object_callback proc
;edi - this		CTeleWhirlwindObject*
	;Вырезанное
	call	SPHImpact__push_back
	;----------
	ASSUME	edi:ptr CTeleWhirlwindObject, edx:ptr CTeleWhirlwind
	mov		edx, [edi].m_telekinesis
	smart_cast	CMincer, CGameObject, [edx].m_owner_object
	.if (eax)
		mov		ecx, [edi].object
		call	CGameObject@@lua_game_object
		mov		edx, [edi].m_telekinesis
		CALLBACK__GO	[edx].m_owner_object, eDesroyObjectInAnomaly, eax
	.endif
	ASSUME	edi:nothing, edx:nothing
	jmp		return_CTeleWhirlwindObject__destroy_object_callback
CTeleWhirlwindObject__destroy_object_callback endp

align_proc
CTorch__Switch_Callback proc
;esi - this		CTorch*
;al - light_on	bool
	movzx	ebx, al
	smart_cast	CGameObject, CTorch, esi
	CALLBACK__INT_INT	eax, eOnSwitchTorch, ebx, 0
	mov		eax, ebx
	;Вырезанное
	mov		ecx, [esi+18Ch]
	jmp		return_CTorch__Switch_Callback
CTorch__Switch_Callback endp

align_proc
CScriptGameObject__set_dest_level_vertex_id_callback proc
;edi - this				CGameObject*
;esi - level_vertex_id	u32
	;Вырезанное
	call	CMovementManager__set_level_dest_vertex
	;----------
	CALLBACK__INT_INT	edi, eSetLevelDestVertex, esi, 0
	jmp		return_CScriptGameObject__set_dest_level_vertex_id_callback
CScriptGameObject__set_dest_level_vertex_id_callback endp

align_proc	
CActor__attach_Vehicle_callback proc
	;Вырезанное
	add		esp, 14h
	mov		ebp, eax	; CCar*
	;----------
	push	edi
	mov		edi, eax
	call	CGameObject__lua_game_object
	CALLBACK__GO	g_Actor, eAttachActorVehicle, eax
	pop		edi
	jmp		CActor__attach_Vehicle_callback_back
CActor__attach_Vehicle_callback endp

align_proc
CActor__detach_Vehicle_callback proc
;eax - CCar*
	push	eax
	push	edi
	mov		edi, eax
	call	CGameObject__lua_game_object
	CALLBACK__GO	g_Actor, eDetachActorVehicle, eax
	pop		edi
	pop		eax
	;Вырезанное
	mov		ecx, [eax+1A4h]
	jmp		CActor__detach_Vehicle_callback_back
CActor__detach_Vehicle_callback endp

align_proc
CActor__use_Vehicle_callback proc
;edi - this		CActor*
;esi - object	CHolderCustom*
	push	edi
	smart_cast	CGameObject, CHolderCustom, esi
	.if (eax)
		mov		edi, eax
		call	CGameObject__lua_game_object
		CALLBACK__GO	g_Actor, eUseActorVehicle, eax
	.endif
	pop		edi
	;вырезаное
	mov		edx, [esi]
	mov		edx, [edx+24h]
	jmp		return_CActor__use_Vehicle_callback
CActor__use_Vehicle_callback endp

align_proc
after_save_callback proc
	mov		edx, g_Actor
	.if (edx)
		CALLBACK__VOID	edx, eOnSaveGame
	.endif
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	pop		ecx
	retn	4
after_save_callback endp

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; от неписей
align_proc
CActor__HitMark_callback proc
	; делаем вырезанное
	call	sprintf_s64
	add		esp, 8
	; делаем свое
	pusha
	CALLBACK__INT_INT	g_Actor, eHitToActorFromMob, type_hit_mob_stalker, edi
	popa
	; возвращаемся
	jmp		back_from_CActor__HitMark_callback
CActor__HitMark_callback endp

; от монстров
align_proc
CBaseMonster__HitEntity_callback proc
	; делаем вырезанное
	call	sprintf_s64
	add		esp, 12
	; делаем свое
	pusha
	CALLBACK__INT_INT	g_Actor, eHitToActorFromMob, type_hit_mob_monster, edi
	popa
	; возвращаемся
	jmp		back_from_CBaseMonster__HitEntity_callback
CBaseMonster__HitEntity_callback endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
