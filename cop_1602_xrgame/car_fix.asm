; можно кататься в ЗП на машинках

;на стеке указатель на машину(CHolderCustom)
CActor__attach_Vehicle proc
pCar           = dword ptr  8

	push    ebp
	mov     ebp, esp
	push    ebx
	push    esi
	push    edi
	mov     edi, [ebp+pCar]
	xor     ebx, ebx
	cmp     edi, ebx
	mov     esi, ecx
	jz      m_end
	;call    CActor__PickupModeOff
	mov     [esi+4C4h], edi
	mov     ecx, [esi+4C4h]
	mov     eax, [ecx]
	push    esi
	;CHolderCustom::attach_Actor
	call    dword ptr [eax+28h] 
	test    al, al
	jnz     m_1
	mov     [esi+4C4h], ebx
	jmp     m_end
m_1:
	mov     eax, [esi+4C4h]
	cmp     eax, ebx
	jnz     loc_101C19B5
	xor     edi, edi
	jmp     loc_101C19BE

loc_101C19B5:  
	push    eax
	call    SmartDynamicCast__CSmartMatcher_CCar_CHolderCustom___smart_cast_
	pop     ecx
	mov     edi, eax

loc_101C19BE:
	mov     eax, [esi]
	mov     ecx, esi
	call    dword ptr [eax+194h]
	mov     ecx, [eax+0A4h]
	call    CPHMovementControl__DestroyCharacter

	mov     ax, [edi+0A4h]
	mov     [esi+4C8h], ax
	
	movzx   eax, INV_STATE_CAR
	push    1
	push    eax
	mov     ecx, esi
	call 	CActor__SetWeaponHideState
	
m_end:
	pop     edi
	pop     esi
	pop     ebx
	pop     ebp
	retn    4	
CActor__attach_Vehicle endp

CActor__use_Vehicle_chunk_1 proc
	mov     dword ptr [esi+540h], 0
	mov     ebx, [esp+14h+arg_0]
	push    ebx
	mov     ecx, esi
	call    CActor__attach_Vehicle;CActor__attach_Vehicle
	jmp		loc_10278B94
CActor__use_Vehicle_chunk_1 endp

SmartDynamicCast__CSmartMatcher_CCar_CHolderCustom___smart_cast_ proc
arg_0           = dword ptr  4

	push    0
	push    offset _R0_AVCCar ; CCar `RTTI Type Descriptor'
	push    offset _R0_AVCHolderCustom ; CHolderCustom `RTTI Type Descriptor'
	push    0
	push    [esp+10h+arg_0]
	call    __RTDynamicCast
	add     esp, 14h
	retn
SmartDynamicCast__CSmartMatcher_CCar_CHolderCustom___smart_cast_ endp
;---rev231---
; Фикс вылета "смерть актора в машине".
; Вылет происходит при попытке создать физ. оболочку актора, когда актор гибнет в машине.
; Тут мы определяем: что объект(m_EntityAlife) это актор и он в машине, и при его смерти, физ. оболочку не создаём,
; как это происходит в ТЧ.
; (с) НаноБот
; 10.09.2015 г.

die_actor_holder_fix proc
; CEntityAlive    ebp = &m_EntityAlife
	cmp     dword ptr [ebp+88h], 0 			; if( m_eType == etActor )
	jnz     not_actor
		mov     eax, [ebp+94h]
		push    eax
		call    smart_cast_CActor				; smart_cast<CActor*>( &m_EntityAlife );
		add     esp, 4
		mov     ecx, eax        			; CActor* ecx = A
;		mov		eax, [ecx+4C4h]
;		PRINT_UINT	"ecx->Holder - %x", eax
		cmp     dword ptr [ecx+4C4h], 0 	; if( ecx->Holder() );
		jnz		back_from_die_actor_holder_fix	; актор внутри машины. Обходим функцию KillHit(H) и не создаём физ. оболочку актора.
not_actor:
	push    ebx
	mov     ecx, ebp
	call    CCharacterPhysicsSupport__KillHit
	jmp		back_from_die_actor_holder_fix
die_actor_holder_fix endp

die_actor_holder_fix2 proc
; CEntityAlive    esi = &m_EntityAlife
	cmp     dword ptr [esi+88h], 0 			; if( m_eType == etActor )
	jnz     not_actor
		mov     eax, [esi+94h]
		push    eax
		call    smart_cast_CActor				; smart_cast<CActor*>( &m_EntityAlife );
		add     esp, 4
		mov     ecx, eax        			; CActor* ecx = A
;		mov		eax, [ecx+4C4h]
;		PRINT_UINT	"ecx->Holder - %x", eax
		cmp     dword ptr [ecx+4C4h], 0 	; if( ecx->Holder() );
		jnz		back_from_die_actor_holder_fix2	; актор внутри машины. Обходим функцию ActivateShell(NULL) и не создаём физ. оболочку актора.
not_actor:
	push    0
	mov     ecx, esi
	call    CCharacterPhysicsSupport__ActivateShell
	jmp		back_from_die_actor_holder_fix2
die_actor_holder_fix2 endp



