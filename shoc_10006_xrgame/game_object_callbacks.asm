

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

GameObject__eUseObject						= dword ptr 15		; GO	� GO, GO

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
eDesroyObjectInAnomaly						= dword ptr 34		; ������ �� ���������� ������� � ��������.
eAllHitObjects								= dword ptr 35		; ������ �� ���, ���������� ��� ���� ��������, ������� ��������� ��������.
eEatObject									= dword ptr 36		; ������ �� ��������.
eHitToAnomalyFromObject						= dword ptr 128		; ��� ��������� �������
eOnDropItemInInventory						= dword ptr 129		; ����������� �������� �� ���������
eOnBelt										= dword ptr 130		; ��������� �������� �� ����
eOnRuck										= dword ptr 131		; ��������� �������� � ������
eOnSlot										= dword ptr 132		; ��������� �������� � ����
eOnSelectItem								= dword ptr 133		; ��������� �������� � ���������
eOnSwitchTorch								= dword ptr 134		; ������������ ��������
eSetLevelDestVertex							= dword ptr 135		; ����� ������ set_dest_level_vertex_id ��� ���������, ���������� ����� �������
eOnCreateIcon								= dword ptr 136		; �������� ������
eAttachActorVehicle							= dword ptr 137		; ������� � ������
eUseActorVehicle							= dword ptr 138		; ������������� ������
eDetachActorVehicle							= dword ptr 139		; ������� �� ������
eOnSaveGame									= dword ptr 140		; ���������� ����
;							= dword ptr 		; 
eHitToActorFromMob							= dword ptr 144		; ��� ������ �� �����
eOnInvBoxPutItem							= dword ptr 151		; ��������� �������� � ����
eEntityAliveBeforeHit						= dword ptr 152		; ������ ��������� ����.
eEntityAliveHit								= dword ptr 153		; ���������� ���������
eUpdateAddonsVisibility						= dword ptr 154		; ���������� ��������� ������� ������� ������ ������
eUpdateHudAddonsVisibility					= dword ptr 155		; ���������� ��������� ������� ���� ������
eOnBeforeUseItem							= dword ptr 156		; ������� ����� �������������� ��������
ePDAContact									= dword ptr 180		; ����� �������� � ���
eWeaponOnShoot								= dword ptr 181		; ������ �� �������
eWeaponStartBullet							= dword ptr 182		; ������ �� ����� ����
eWeaponStopBullet							= dword ptr 183		; ������ �� ���� ����
;	};
;};

type_hit_mob_stalker						= dword ptr 0
type_hit_mob_monster						= dword ptr 1

align_proc
CCustomZone__CreateHit_callback proc id_to:dword, id_from:dword, hit_power:dword, bone_id:dword, hit_impulse:dword, hit_type:dword
org		$-3	;�������� (push ebp/mov ebp,esp) ebp � ��� ��������� �� ���������
;ebx - this			CCustomZone*
;esi - pos_in_bone	Fvector
;edi - hit_dir		Fvector
	call	SHit__Write_Packet
	push	esi
	Level__Objects_net_Find  id_to
	mov		esi, eax
	Level__Objects_net_Find  id_from
	mov		edx, eax
	CALLBACK__GO_GO_INT_VECTOR_FLOAT	ebx, eHitToAnomalyFromObject, esi, edx, hit_type, [edi].Fvector, hit_power
	pop		esi
	jmp		return_CCustomZone__CreateHit_callback
CCustomZone__CreateHit_callback endp

align_proc
CCustomZone__enter_Zone_callback proc
;ebp - this		Touch@Feel
;esi - obj		CGameObject*
	lea		edx, [ebp-CCustomZone.Feel@@Touch@vfptr]	;-19Ch = CGameObject
	CALLBACK__GO	edx, GameObject__eZoneEnter, esi
	;����������
	mov		eax, [esi]
	mov		edx, [eax+80h]
	jmp		return_CCustomZone__enter_Zone_callback
CCustomZone__enter_Zone_callback endp

align_proc
CCustomZone__exit_Zone_callback proc
;ebx - this		Touch@Feel
;esi - obj		CGameObject*
	lea		edx, [ebx-CCustomZone.Feel@@Touch@vfptr]	;-19Ch = CGameObject
	CALLBACK__GO	edx,  GameObject__eZoneExit, esi
	;����������
	mov		eax, [esi]
	mov		edx, [eax+80h]
	jmp		return_CCustomZone__exit_Zone_callback
CCustomZone__exit_Zone_callback endp

align_proc
CTeleWhirlwindObject__destroy_object_callback proc
;edi - this		CTeleWhirlwindObject*
	;����������
	call	SPHImpact__push_back
	;----------
	ASSUME	edi:ptr CTeleWhirlwindObject, edx:ptr CTeleWhirlwind
	mov		edx, [edi].m_telekinesis
	smart_cast	CMincer, CGameObject, [edx].m_owner_object
	.if (eax)
		mov		edx, [edi].m_telekinesis
		CALLBACK__GO	[edx].m_owner_object, eDesroyObjectInAnomaly, [edi].object
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
	;����������
	mov		ecx, [esi+18Ch]
	jmp		return_CTorch__Switch_Callback
CTorch__Switch_Callback endp

align_proc
CScriptGameObject__set_dest_level_vertex_id_callback proc
;edi - this				CGameObject*
;esi - level_vertex_id	u32
	;����������
	call	CMovementManager__set_level_dest_vertex
	;----------
	CALLBACK__INT_INT	edi, eSetLevelDestVertex, esi, 0
	jmp		return_CScriptGameObject__set_dest_level_vertex_id_callback
CScriptGameObject__set_dest_level_vertex_id_callback endp

align_proc	
CActor__attach_Vehicle_callback proc
	;����������
	add		esp, 14h
	mov		ebp, eax	; CCar*
	;----------
	CALLBACK__GO	g_Actor, eAttachActorVehicle, ebp
	jmp		CActor__attach_Vehicle_callback_back
CActor__attach_Vehicle_callback endp

align_proc
CActor__detach_Vehicle_callback proc
;eax - CCar*
	push	eax
	CALLBACK__GO	g_Actor, eDetachActorVehicle, eax
	pop		eax
	;����������
	mov		ecx, [eax+1A4h]
	jmp		CActor__detach_Vehicle_callback_back
CActor__detach_Vehicle_callback endp

align_proc
CActor__use_Vehicle_callback proc
;edi - this		CActor*
;esi - object	CHolderCustom*
	smart_cast	CGameObject, CHolderCustom, esi
	CALLBACK__GO	g_Actor, eUseActorVehicle, eax
	;���������
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
; �� �������
align_proc
CActor__HitMark_callback proc
	; ������ ����������
	call	sprintf_s64
	add		esp, 8
	; ������ ����
	pusha
	CALLBACK__INT_INT	g_Actor, eHitToActorFromMob, type_hit_mob_stalker, edi
	popa
	jmp		return_CActor__HitMark_callback
CActor__HitMark_callback endp

; �� ��������
align_proc
CBaseMonster__HitEntity_callback proc
	; ������ ����������
	call	sprintf_s64
	add		esp, 12
	; ������ ����
	pusha
	CALLBACK__INT_INT	g_Actor, eHitToActorFromMob, type_hit_mob_monster, edi
	popa
	jmp		return_CBaseMonster__HitEntity_callback
CBaseMonster__HitEntity_callback endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
