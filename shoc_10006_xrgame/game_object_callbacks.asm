

;namespace GameObject {
;	enum ECallbackType {
GameObject__eTradeStart 					= dword ptr 0		; void
GameObject__eTradeStop 						= dword ptr 1		; void
GameObject__eTradeSellBuyItem 				= dword ptr 2		; GO, bool, u32
GameObject__eTradePerformTradeOperation 	= dword ptr 3		; u32, u32

GameObject__eZoneEnter 						= dword ptr 4		; GO, GO
GameObject__eZoneExit 						= dword ptr 5		; GO, GO
GameObject__eExitLevelBorder 				= dword ptr 6		; GO
GameObject__eEnterLevelBorder 				= dword ptr 7		; GO
GameObject__eDeath 							= dword ptr 8		; GO, GO

GameObject__ePatrolPathInPoint 				= dword ptr 9		; GO, u32, u32

GameObject__eInventoryPda 					= dword ptr 10		; 
GameObject__eInventoryInfo 					= dword ptr 11		; GO, str
GameObject__eArticleInfo 					= dword ptr 12		; GO, str, str, int
GameObject__eTaskStateChange 				= dword ptr 13		; SGameTask, SGameTaskObjective, ETaskState
GameObject__eMapLocationAdded 				= dword ptr 14		; str, u16

GameObject__eUseObject 						= dword ptr 15		; GO	и GO, GO

GameObject__eHit 							= dword ptr 16		; GO, float, vector, GO, s16 | GO, float, vector, GO, u16

GameObject__eSound 							= dword ptr 17		; GO, GO, int, vector, float

GameObject__eActionTypeMovement 			= dword ptr 18		; GO, u32, -1
GameObject__eActionTypeWatch 				= dword ptr 19		; GO, u32
GameObject__eActionTypeAnimation 			= dword ptr 20		; GO, u32
GameObject__eActionTypeSound 				= dword ptr 21		; GO, u32
GameObject__eActionTypeParticle 			= dword ptr 22		; GO, u32
GameObject__eActionTypeObject 				= dword ptr 23		; GO, u32

GameObject__eActorSleep 					= dword ptr 24		; 

GameObject__eHelicopterOnPoint 				= dword ptr 25		; float, vector, int
GameObject__eHelicopterOnHit 				= dword ptr 26		; float, float, int, u32

GameObject__eOnItemTake 					= dword ptr 27		; GO
GameObject__eOnItemDrop 					= dword ptr 28		; GO

GameObject__eScriptAnimation 				= dword ptr 29		; void

GameObject__eTraderGlobalAnimationRequest 	= dword ptr 30		; void
GameObject__eTraderHeadAnimationRequest 	= dword ptr 31		; void
GameObject__eTraderSoundEnd 				= dword ptr 32		; void

GameObject__eInvBoxItemTake 				= dword ptr 33		; GO, GO
GameObject__eDummy							= dword ptr -1

eAttachActorVehicle							= dword ptr 137		; Посадка в машину
eUseActorVehicle							= dword ptr 138		; Использование машины
eDetachActorVehicle							= dword ptr 139		; Высадка из машины
;	};
;};

;бляцкий быдлокод!!!
CCustomZone__hit_callback:
	push	eax
	push	edi
	call 	CCustomZone__set_callback

	; Вырезанное
	mov		ebp, esp
	and		esp, 0FFFFFFF8h
	
	; Возврат
	jmp 	CCustomZone__hit_callback_back

CCustomZone__PlayHitParticles: ; CCustomZone *this<ebx>, CGameObject *pObject<eax>
	push	eax
	push	ebx

	call	CCustomZone__set_callback

	; Вырезанное.
	fldz
	sub esp, 10h
	
	; Возврат.
	jmp CCustomZone__PlayHitParticles_Back

CCustomZone__set_callback proc
anom = dword ptr 8
obj = dword ptr 0Ch
	push	ebp
	mov		ebp, esp

	push	eax
	push	ecx
	push	edi
	
	mov 	edi, [ebp+obj]
	call 	CGameObject__lua_game_object
	
	push 	eax
	push 	128

	mov 	ecx, [ebp+anom]
	call    CGameObject__callback
	push    eax
	call    script_use_callback

	pop		edi
	pop		ecx
	pop		eax
	pop		ebp
	
	retn	8
CCustomZone__set_callback endp

CTorch__Switch_Callback:      ; CTorch* <esi>, light_on <al>
	push	edi
	
	xor		ebx, ebx
	mov		bl, al
	
	push    0               
	push    offset ??_R0?AVCGameObject@@@8
	push    offset off_10538CFC ; AVCTorch
	push    0
	push    esi             
	call    __RTDynamicCast
	add     esp, 14h	

	push    0
	push    ebx

	push    134 
	mov     ecx, eax
	call    CGameObject__callback
	push    eax
	call    script_callback_int_int	

	pop		edi
	mov		eax, ebx

	mov 	ecx, [esi+18Ch]

	jmp 	CTorch__Switch_Callback_Back
CMovementManager__set_level_dest_vertex_callback:
	;PRINT 	"be"
	call	CMovementManager__set_level_dest_vertex

	push	eax
	push	ecx
	
	push    0
	push    esi ;level_vertex_id	
	
	;PRINT_UINT "lvid: %d", esi

	push    135 
	mov     ecx, edi 
	call    CGameObject__callback
	push    eax
	call    script_callback_int_int	

	pop		ecx
	pop		eax
	
	jmp		CMovementManager__set_level_dest_vertex_callback_back
	
CActor__attach_Vehicle_callback proc
	; Вырезанное в начале.
	add     esp, 14h
	mov     ebp, eax
	
	; eax = ebp = CCar*
	pusha
	test	eax, eax
	jz		short exit

	mov 	edi, eax
	call 	CGameObject__lua_game_object	
	
	test	eax, eax
	jz		short exit
	
	push 	eax
	push 	137

	mov 	ecx, g_Actor
	call    CGameObject__callback
	push    eax
	call    script_use_callback
exit:	
	popa
	jmp		CActor__attach_Vehicle_callback_back
CActor__attach_Vehicle_callback endp

CActor__detach_Vehicle_callback proc
	; Вырезанное
	add     esp, 14h
	test	eax, eax
	
	; eax = CCar*
	pusha
	jz		short exit

	mov 	edi, eax
	call 	CGameObject__lua_game_object
	
	test	eax, eax
	jz		short exit
	
	push 	eax
	push 	139

	mov 	ecx, g_Actor
	call    CGameObject__callback
	push    eax
	call    script_use_callback
exit:	
	popa
	test	eax, eax
	jmp		CActor__detach_Vehicle_callback_back
CActor__detach_Vehicle_callback endp

CActor__use_Vehicle_callback proc
	; Вырезанное
	call    edx
	test    al, al
	jnz		CActor__use_Vehicle_callback_skip
	
	; esi = CHolderCustom*
	pusha

	RT_DYNAMIC_CAST ??_R0?AVCHolderCustom@@@8, ??_R0?AVCCar@@@8, esi
	
	test	eax, eax
	jz		short exit
	
	mov 	edi, eax
	call 	CGameObject__lua_game_object
	
	test	eax, eax
	jz		short exit
	
	push 	eax
	push 	138

	mov 	ecx, g_Actor
	call    CGameObject__callback
	push    eax
	call    script_use_callback	
exit:
	popa
	jmp		CActor__use_Vehicle_callback_exit
CActor__use_Vehicle_callback endp

after_save_callback proc
	mov		ecx, g_Actor
	test	ecx, ecx
	jz		short exit

	push 	0
	push 	140
	call    CGameObject__callback
	push    eax
	call    script_use_callback		
exit:
	pop     edi
	pop     esi
	pop     ebp
	pop     ebx
	pop     ecx
	retn    4
after_save_callback endp

; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; от неписей
CActor__HitMark_callback proc
	; делаем вырезанное
	call    sprintf_s64
	add     esp, 8
	; делаем свое
	pusha
	push    edi ; side
	push    0 ; mob type: 0 - stalker, 1 - monster
	push    144
	mov     ecx, g_Actor
	call    CGameObject__callback
	push    eax
	call    script_callback_int_int
	popa
	; возвращаемся
	jmp     back_from_CActor__HitMark_callback
CActor__HitMark_callback endp

; от монстров
CBaseMonster__HitEntity_callback proc
	; делаем вырезанное
	call    sprintf_s64
	add     esp, 0Ch
	; делаем свое
	pusha
	push    edi ; side
	push    1 ; mob type: 0 - stalker, 1 - monster
	push    144
	mov     ecx, g_Actor
	call    CGameObject__callback
	push    eax
	call    script_callback_int_int
	popa
	; возвращаемся
	jmp     back_from_CBaseMonster__HitEntity_callback
CBaseMonster__HitEntity_callback endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
