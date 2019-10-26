
;  Назначаем инициатор методу explode	Nanobot-AMK
CScriptGameObject_explode_fix proc
arg_1		= dword ptr	 4
	; свободны eax, edx	; ecx = &object()
	mov		eax, [esp+14h+arg_1]
	test	eax, eax
	jz		value_nil
	mov		eax, [eax+4]	; eax = game_object
	test	eax, eax
	jz		value_nil					; 
	mov		ecx, eax					; ecx = initiator->object();
value_nil:
	movzx	edx, word ptr [ecx+0A4h]	; u16 eax = initiator->object().ID();	// 7 bytes -- вырезаная команда
;	PRINT_UINT "initiatorID = %d", edx
	jmp		back_from_CScriptGameObject_explode_fix
CScriptGameObject_explode_fix endp

;======================================================================
; Гранаты с ударным запалом!!!
; Полностью движковые
; SSE+ рулит!!!!!!!!!!!
; (с) НаноБот			13.11.2015

aSafetyLockTime			db "time_safetylock", 0
aAccThreshold			db "acc_threshold", 0

CMissile__UDZ proc
; esi - CGrenade
ID						= dword ptr 232+164
m_thrown				= dword ptr 1216
m_explosion_flags		= dword ptr 1116
m_vLastLVel				= dword ptr 944		; Fvector4	sizeof 16 bytes
m_pPhysicsShell			= dword ptr 2D4h	;1A8h
m_fake_missile			= dword ptr 916
m_dwDestroyTime			= dword ptr 832
flExploding				= byte	ptr 1
x						= dword ptr 0
y						= dword ptr 4
z						= dword ptr 8
_						= dword ptr 12
; локальные переменные
size_variables			= dword ptr	4+16	; размер поля локальных переменных
acc						= dword ptr 0		; float
lvel					= dword ptr 4		; Fvector4	sizeof 16 bytes
;-----------------------------------
	sub		esp, size_variables
	; if (OnClient()) return;
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	call	CLevel__IsClient
	test	al, al
	jnz		exit
	; if (m_pPhysicsShell)	{	// по наличии физ. оболочки определяем момент броска
	mov		ecx, [esi+m_pPhysicsShell]
	test	ecx, ecx
	jz		exit
	; m_dwDelta += Device.dwTimeDelta;
	mov		eax, ds:Device
	mov		ecx, [esi+m_dwDelta]
	add		ecx, [eax+24h]
	mov		[esi+m_dwDelta], ecx
	; if (m_dwDelta >= 10) {
	cmp		ecx, 10
	jb		exit
		; if (m_explosion_flags.test(flExploding)) {
		test	byte ptr [esi+m_explosion_flags], flExploding
		jnz		exploded	
			; Fvector4	lvel;	lvel.set(0,0,0,0);
			xorps	xmm0, xmm0
			movups	oword ptr [esp+lvel], xmm0
			; m_pPhysicsShell->get_LinearVel((Fvector*)lvel);
			mov		ecx, [esi+m_pPhysicsShell]
			mov		edx, [ecx]
			mov		edx, [edx+15Ch]
			lea		eax, [esp+lvel]
			push	eax
			call	edx				; CPhysicsShell::get_LinearVel
			; if (m_bFlying)	{
			cmp		byte ptr [esi+m_bFlying], 1
			jnz		_else
				; if (m_dwSafetyLockTime <= Level().timeServer()) 
				mov		ecx, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
				mov		eax, [ecx]
				lea		ecx, [eax+40110h]
				call	ds:timeServer				; IPureClient::timeServer(void)
				cmp		[esi+m_dwSafetyLockTime], eax
				ja		lab1
					; local acc = m_vLastLVel.distance_to(lvel) / ((float)m_dwDelta * 0.001)
					movups	xmm0, oword ptr [esp+lvel]
					subps	xmm0, oword ptr [esi+m_vLastLVel]
					mulps	xmm0, xmm0
					movss	xmm1, xmm0
					shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
					addss	xmm1, xmm0		; xmm1 = x + y
					shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
					addss	xmm0, xmm1		; xmm0 = z + xmm1
					sqrtss	xmm0, xmm0
					cvtsi2ss xmm1, dword ptr [esi+m_dwDelta]
					mulss	xmm1, ds:float_1e_3		; * 0.001f
					divss	xmm0, xmm1				; xmm0 = acc
					; if (acc > m_fAccThreshold)	{
					comiss	xmm0, dword ptr [esi+m_fAccThreshold]
					jbe		lab1
						movss	dword ptr [esp+acc], xmm0
						mov		eax, [esp+acc]
						PRINT_FLOAT	"Граната взорвана от удара! acc - %f", eax
						; m_actived_grn_udz = false;
						mov		byte ptr [esi+m_actived_grn_udz], 0
						; m_dwDestroyTime = 0xFFFFFFFF;
						; Destroy();
						mov		edx, [esi]
						mov		eax, [edx+144h]
						mov		ecx, esi
						mov		dword ptr [esi+m_dwDestroyTime], 0FFFFFFFFh
						call	eax				; CMissile::Destroy
						; return;
						jmp		exit
_else:
				; m_dwSafetyLockTime += Level().timeServer();
				mov		ecx, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
				mov		eax, [ecx]
				lea		ecx, [eax+40110h]
				call	ds:timeServer				; IPureClient::timeServer(void)
				add		[esi+m_dwSafetyLockTime], eax
				mov		eax, [esi+m_dwSafetyLockTime]
				PRINT_UINT	"Граната брошена! m_dwSafetyLockTime - %d", eax
				; m_bFlying = true;
				mov		byte ptr [esi+m_bFlying], 1
lab1:	;	}	}
			; m_vLastLVel = lvel;
			movups	xmm0, oword ptr [esp+lvel]
			movups	oword ptr [esi+m_vLastLVel], xmm0
			; m_dwDelta = 0;
			mov		dword ptr [esi+m_dwDelta], 0
	jmp		exit
exploded:	;	}
		PRINT "Граната взорвана от самоликвидатора!"
		; m_actived_grn_udz = false;
		mov		byte ptr [esi+m_actived_grn_udz], 0
exit:	;	}	}	}
;-----------------------------------
	add		esp, size_variables
	pop		edi
	pop		esi
	pop		ecx
	retn		; выходим из функции в которую мы врезались ( void CMissile::UpdateCL() )
CMissile__UDZ endp

InitFakeMissile proc
NameSection				= dword ptr 194h
	push	ecx
	push	ebx
	push	edi
	push	esi
;-------------------------------		
	mov		esi, eax	; esi = m_fake_missile
	; if (OnClient()) return;
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	call	CLevel__IsClient
	test	al, al
	jnz		exit
	mov		edi, [esi+NameSection]
	test	edi, edi
	jz		exit
	add		edi, 10h		; edi = section
;	PRINT_UINT	"Активируем гранату! section - %s", edi
	push	offset aSafetyLockTime			; "time_safetylock"
	push	edi
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	test	eax, eax
	jz		exit
		push	offset aSafetyLockTime		; "time_safetylock"
		push	edi
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_u32
		mov		[esi+m_dwSafetyLockTime], eax
;		PRINT_UINT	"time_safetylock - %d", eax
	push	offset aAccThreshold			; "acc_threshold"
	push	edi
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	test	eax, eax
	jz		exit
		push	offset aAccThreshold		; "acc_threshold"
		push	edi
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_float
		fstp	dword ptr [esi+m_fAccThreshold]
;		mov		eax, [esi+m_fAccThreshold]
;		PRINT_FLOAT	"m_fAccThreshold - %f", eax
		mov		byte ptr [esi+m_actived_grn_udz], 1
		mov		dword ptr [esi+m_dwDelta], 0
exit:
;-------------------------------
	pop		esi
	pop		edi
	pop		ebx
	pop		ecx
	; делаем что вырезали
	mov		bl, 1		;cmp		cx, 0FFFFh
	jmp		back_from_InitFakeMissile
InitFakeMissile endp

;======================================================================
; Кумулятивный эффект
; создаётся пулей,
aCumulativeSect			db "cumulative_sect", 0		; секция кумулятивной пули
kum_speed				dd 1000.0

cumulative_effect proc
; ebx - pos
; esi - CExplosive
; eax, edx, ecx, edi - свободны
; смещения для CGameObject
NameSection				= dword ptr 0ACh	;
direction				= dword ptr 070h	;
position				= dword ptr 080h	;
; локальные переменные
size_variables			= dword ptr	60+12	; размер поля локальных переменных
;_						= dword ptr	0		; float			sizeof 4 bytes
cartridge				= dword ptr	0		; CCartridge	sizeof 60 bytes
cumul_pos				= dword ptr	60		; Fvector		sizeof 12 bytes
;---------------------------------
	sub		esp, size_variables
	mov     eax, [esi]
	mov     edx, [eax+54h]
	mov		ecx, esi
	call    edx					; cast_game_object()
;	PRINT_UINT	"cast_game_object - %x", eax
;	PRINT_UINT	"CExplosive - %x", esi
	mov		edi, [eax+NameSection]
	test	edi, edi
	jz		exit
	add		edi, 10h		; edi = section
;	PRINT_UINT	"Cumulative effect, section bomb - %s", edi
	push	offset aCumulativeSect			; "cumulative_sect"
	push	edi
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	test	eax, eax
	jz		exit
;		LPCSTR	cumul_sect	= ini->r_string(section, "cumulative_sect");
		push	offset aCumulativeSect			; "cumulative_sect"
		push	edi
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_string
;		PRINT_UINT	"Cumulative effect, section - %s", eax
;		CCartridge cartridge;
		test	eax, eax
		jz		exit
		push	0
		push	eax
		lea		ecx, [esp+8+cartridge]
		call	CCartridge__CCartridge
;		cartridge->Load(cumul_sect, 0);
		lea		ecx, [esp+8+cartridge]
		call	CCartridge__Load
		; CGameObject	obj = cast_game_object()	
		mov     eax, [esi]
		mov     edx, [eax+54h]
		mov		ecx, esi
		call    edx					; cast_game_object()
		mov		edi, eax			; edi = obj;
		mov     ecx, [edi]
		mov     edx, [ecx+10h]
		lea     ecx, [esp+cumul_pos]
		push    ecx
		mov     ecx, edi
		call    edx					; Center(cumul_pos)
;		Level().BulletManager().AddBullet(	obj->Center(), obj->Direction(), 1000.f,
;											1.f, 1.f, Initiator(),
;											obj->ID(), ALife::eHitTypeFireWound, 1.f, 
;											cartridge, 1.f, OnServer() );
		push	0				; bool	AimBullet				= false
		mov		eax, ds:g_pGameLevel
		mov		ecx, [eax]
		call	CLevel__IsServer
		movzx	eax, al
		push	eax				; bool	SendHit					= OnServer()
		fld1
		push	ecx	
		fstp	dword ptr [esp]	; float air_resistance_factor	= 1.f
		lea		ecx, [esp+12+cartridge]
		push	ecx				; const CCartridge& cartridge	= cartridge
		fld1
		push	ecx	
		fstp	dword ptr [esp]	; float maximum_distance		= 1.f
		push	6				; ALife::EHitType e_hit_type	= ALife::eHitTypeFireWound	// = 6
		movzx   ecx, word ptr [edi+0A4h]
		push	ecx				; u16	sendersweapon_id		= cast_game_object()->ID()
		mov		ecx, esi
		call	CExplosive__Initiator
		push	eax				; u16	sender_id				= Initiator()
		fld1
		push	ecx	
		fstp	dword ptr [esp]	; float impulse					= 1.f
		fld1
		push	ecx	
		fstp	dword ptr [esp]	; float power					= 1.f
		push	447A0000h		; float starting_speed			= 1000.f
		lea     ecx, [edi+direction]
		push	ecx				; Fvector& direction			= Direction()
		lea     ecx, [esp+48+cumul_pos]
		push	ecx				; Fvector& position				= Center()
		mov		ecx, ds:g_pGameLevel
		mov		eax, [ecx]
		mov		ecx, [eax+487C4h]
		call	CBulletManager__AddBullet
exit:
	add		esp, size_variables
	; делаем что вырезали
	mov		edx, [esi]
	mov		eax, [edx+54h]
	jmp		back_from_cumulative_effect
cumulative_effect endp

; стабилизированная ракета (ракета разворачивается по курсу)	void CCustomRocket::UpdateCL()
stabilized_rocket proc
; esi - CCustomRocket
m_pPhysicsShell			= dword ptr 1ECh
m_explosion_flags		= dword ptr 1108
Direction				= dword ptr 070h	;
Position				= dword ptr 080h	;
flExploding				= byte	ptr 1
x						= dword ptr 0
y						= dword ptr 4
z						= dword ptr 8
; локальные переменные
size_variables			= dword ptr	4+16	; размер поля локальных переменных
_						= dword ptr	0		; float			sizeof 4 bytes
lvel					= dword ptr 4		; Fvector4		sizeof 16 bytes
;---------------------------------------------
	sub		esp, size_variables
	mov		ecx, [esi+m_pPhysicsShell]
	test	ecx, ecx
	jz		exit
		; Fvector4	lvel.set(0,0,0,0);
		xorps	xmm0, xmm0
		movups	oword ptr [esp+lvel], xmm0
		; m_pPhysicsShell->get_LinearVel((Fvector*)lvel);
		mov		edx, [ecx]
		mov		edx, [edx+15Ch]
		lea		eax, [esp+lvel]
		push	eax
		call	edx				; CPhysicsShell::get_LinearVel
		; float	speed = lvel.magnidute()
		movups	xmm0, oword ptr [esp+lvel]
		movaps	xmm2, xmm0
		mulps	xmm0, xmm0
		movss	xmm1, xmm0
		shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
		addss	xmm1, xmm0		; xmm1 = x + y
		shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
		addss	xmm0, xmm1		; xmm0 = z + xmm1
		sqrtss	xmm0, xmm0		; xmm0 = speed
		movss	xmm1, ds:float_1
		; if (speed > 1.f)	{
		comiss	xmm0, xmm1
		jbe		exit
			; lvel.mul(1/speed);
			divss	xmm1, xmm0		; xmm1 = 1/speed
			shufps	xmm1, xmm1, 00000000b	; 0000t		копируем из 0-вого во все остальные
			mulps	xmm2, xmm1
			movups	oword ptr [esp+lvel], xmm2
			; Direction().set((Fvector*)lvel);
			lea     ecx, [esi+Direction]
			mov		eax, [esp+lvel+x]
			mov		[ecx+x], eax
			mov		eax, [esp+lvel+y]
			mov		[ecx+y], eax
			mov		eax, [esp+lvel+z]
			mov		[ecx+z], eax
exit:	;	}
	; // если ракета взорвана, то её останавливаем!
	; if (m_explosion_flags.test(flExploding))	CCustomRocket::Contact(Position(), Direction())
	test	byte ptr [esi+m_explosion_flags], flExploding
	jz		no_exploded
		lea     eax, [esi+Direction]
		push    eax
		lea     ecx, [esi+Position]
		push    ecx
		mov     ecx, esi
		call	CCustomRocket__Contact
no_exploded:
	add		esp, size_variables
	; делаем что вырезали, 0 bytes
	jmp		back_from_stabilized_rocket
stabilized_rocket endp
