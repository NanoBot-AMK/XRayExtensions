
align_proc
CAI_Stalker__IsVisibleForZones proc
	test	[ecx].CAI_Stalker.m_actor_relation_flags, 80000000h
	setz	al
	ret
CAI_Stalker__IsVisibleForZones endp

align_proc
CAI_Stalker__feel_touch_new_fix proc
	; ��������� ���� � ���� ���������, �� �� ������ ������
	.if ([ecx-CAI_Stalker.Feel@@Touch@vfptr].CAI_Stalker.m_actor_relation_flags & 40000000h)
		retn	4
	.endif
	mov		eax, 2010h
	jmp		return_CAI_Stalker__feel_touch_new_fix
CAI_Stalker__feel_touch_new_fix endp

align_proc
CEntityAlive@@HitCallback proc uses esi ebx pHDS:ptr SHit
local ignore_flags:dword, ignore_hit:dword
;ecx	this	CEntityAlive*
	mov		esi, ecx
	mov		ebx, pHDS
	ASSUME	ebx:ptr SHit
	mov		ignore_flags, false
	CALLBACK__INT_INT	esi, eEntityAliveBeforeHit, ebx, &ignore_flags
	mrm		ignore_hit, ignore_flags
	mov		eax, [ebx].who
	.if (eax)
		smart_cast	CEntityAlive, eax
		.if (eax)
			and		g_int_argument_0, 0
			CALLBACK__GO	esi, eEntityAliveHit, eax
			;� ������� ���� ������� set_int_arg0(1), ����� ��� �������������� ���.
			mrm		ignore_hit, g_int_argument_0
			and		g_int_argument_0, 0
		.endif
	.endif
	.if (ignore_hit==false)
		mov		ecx, esi
		CEntityAlive@@Hit(pHDS)
	.endif
	ASSUME	ebx:nothing
	ret
CEntityAlive@@HitCallback endp

align_proc
CAI_Stalker__update_best_item_info_fix proc
; esi - this, CAI_Stalker = CGameObject
	;������ ��� ��������
	mov		[eax+8], ebx
	mov		[eax+12], ebx
	;--------------
	ASSUME	esi:ptr CAI_Stalker, edi:ptr CWeapon
	mov		edi, [esi].m_script_best_weapon		; CWeapon
	.if (edi)
		; if (m_best_item_to_kill==m_script_best_weapon)
		.if ([esi].m_best_item_to_kill==edi)	; ���� ��� ���������
			mov		al, true
			.if (![esi].m_script_not_check_can_kill)
				; if (m_best_item_to_kill->can_kill()) return;	; �������� �������
				mov		ecx, edi
				mov		edx, [ecx]
				mov		eax, [edx+0F8h]
				call	eax
			.endif
			.if (al)
				; ������� �� ������ CAI_Stalker::update_best_item_info()
				pop		edi
				pop		ebx
				mov		esp, ebp
				pop		ebp
				retn
			.endif
		.endif
		; ���� ���������, ���� �� ��� ������� � ��������� ��������
		;CGameObject*	parent = m_script_best_weapon->H_Parent();
		; if (parent && parent->ID()==ID())
		mov		ecx, [edi].Parent	;+216
		.if (ecx)
			ASSUME	ecx:ptr CGameObject
			mov		ax, [ecx].ID
			.if ([esi].ID==ax)
				; ���� ����������� �������� ���������
				; m_best_ammo = m_best_item_to_kill = m_script_best_weapon;	// ��������� ������ �����(item)
				mov		eax, [esi].m_script_best_weapon
				mov		[esi].m_best_item_to_kill, eax
				mov		[esi].m_best_ammo, eax
				; ������� �� ������ CAI_Stalker::update_best_item_info();
				pop		edi
				pop		ebx
				mov		esp, ebp
				pop		ebp
				retn
			.endif
			ASSUME	ecx:nothing
			; � ���� ���� ��������, � ��� �� ������� �������.
		.endif
		; m_script_best_weapon = nullptr;
		xor		eax, eax
		mov		[esi].m_script_best_weapon, eax
	.endif
	ASSUME	esi:nothing, edi:nothing
	jmp		return_CAI_Stalker__update_best_item_info_fix
CAI_Stalker__update_best_item_info_fix endp

; ����� �� ������� ��������� �������� ����.
align_proc
CAI_Stalker__CanPickUpItem proc _item:dword
	mov		al, false
	ret
CAI_Stalker__CanPickUpItem endp

; ����� �� �������� ������ ��� ������ ��������.
align_proc
CAI_Stalker__NotDropWeaponDeath proc
; ecx - this; CAI_Stalker = CPhysicsShellHolder
; eax - CInventoryItem*
	ASSUME	ecx:ptr CAI_Stalker
	.if ([ecx].m_not_drop_wpn_death==false)
		or      [eax].CInventoryItem.m_flags, 1
	.endif
	ASSUME	ecx:nothing
	retn
CAI_Stalker__NotDropWeaponDeath endp
