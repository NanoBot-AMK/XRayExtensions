; ���� ������ "������ ������ � ������".
; ����� ���������� ��� ������� ������� ���. �������� ������, ����� ����� ������ � ������.
; ��� �� ����������: ��� ������(m_EntityAlife) ��� ����� � �� � ������, � ��� ��� ������, ���. �������� �� ������,
; ��� ��� ���������� � ��.
; (�) �������
; 10.09.2015 �.

die_actor_holder_fix proc
; CEntityAlive    ebp = &m_EntityAlife
	cmp     dword ptr [ebp+8Ch], 0 			; if( m_eType == etActor )
	jnz     not_actor
		mov     ecx, [ebp+98h]
		mov     eax, [ecx]
		mov     eax, [eax+90h]
		call    eax							; smart_cast<CActor*>( &m_EntityAlife );
		mov     ecx, eax        			; CActor* ecx = A
;		mov		eax, [ecx+4BCh]
;		PRINT_UINT	"ecx->Holder - %x", eax
		cmp     dword ptr [ecx+4BCh], 0 	; if( ecx->Holder() );
		jnz		back_from_die_actor_holder_fix	; ����� ������ ������. ������� ������� KillHit(H) � �� ������ ���. �������� ������.
not_actor:
	push    ebx
	push    ebp
	call	CCharacterPhysicsSupport__KillHit
	jmp		back_from_die_actor_holder_fix
die_actor_holder_fix endp

die_actor_holder_fix2 proc
; CEntityAlive    edi = &m_EntityAlife
	cmp     dword ptr [edi+8Ch], 0 			; if( m_eType == etActor )
	jnz     not_actor
		mov     ecx, [edi+98h]
		mov     eax, [ecx]
		mov     eax, [eax+90h]
		call    eax							; smart_cast<CActor*>( &m_EntityAlife );
		mov     ecx, eax        			; CActor* ecx = A
;		mov		eax, [ecx+4BCh]
;		PRINT_UINT	"ecx->Holder - %x", eax
		cmp     dword ptr [ecx+4BCh], 0 	; if( ecx->Holder() );
		jnz		back_from_die_actor_holder_fix2	; ����� ������ ������. ������� ������� ActivateShell() � �� ������ ���. �������� ������.
not_actor:
	call    CCharacterPhysicsSupport__ActivateShell
	jmp		back_from_die_actor_holder_fix2
die_actor_holder_fix2 endp

