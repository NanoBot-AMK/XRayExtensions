
;  Назначаем инициатор методу explode	Nanobot-AMK
CScriptGameObject_explode_fix proc
arg_1		= dword ptr	 4
	; свободны eax, edx	; ecx = &object()
	mov		eax, [esp+14h+arg_1]
	.if		eax != 0
		mov		eax, [eax+4]	; eax = game_object
		.if		eax != 0					; 
			mov		ecx, eax					; ecx = initiator->object();
		.endif
	.endif
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
m_vLastLVel				= oword ptr 944		; Fvector4	sizeof 16 bytes
m_pPhysicsShell			= dword ptr 2D4h	;1A8h
m_dwDestroyTime			= dword ptr 832
m_explosion_flags		= byte	ptr 1116
flExploding				= byte	ptr 1
; локальные переменные
local lvel:Fvector4			; Fvector4	sizeof 16 bytes
;local acc:dword				; float
;-----------------------------------
	; if (OnClient()) return;
	mov		eax, ds:g_pGameLevel
	mov		ecx, [eax]
	call	CLevel__IsClient
	.if		al == 0 && [esi+m_pPhysicsShell] != 0	;// по наличию физ. оболочки определяем момент броска
		.if		[esi+m_bFlying] == 0
			; m_dwSafetyLockTime += Level().timeServer();
			Level__timeServer
			add		[esi+m_dwSafetyLockTime], eax
;			mov		eax, [esi+m_dwSafetyLockTime]
;			PRINT_UINT	"Граната брошена! m_dwSafetyLockTime - %d", eax
			mov		[esi+m_bFlying], 1			; m_bFlying = true;
			jmp		exit
		.endif
		; m_dwDelta += Device.dwTimeDelta;
		Device_dwTimeDelta
		add		[esi+m_dwDelta], eax
		.if		[esi+m_dwDelta] >= 10 
			.if		[esi+m_explosion_flags] & flExploding
;				PRINT "Граната взорвана от самоликвидатора!"
				mov		[esi+m_actived_grn_udz], 0	; m_actived_grn_udz = false;
			.else
				; Fvector4	lvel;	lvel.set(0,0,0,0);
				xorps	xmm0, xmm0
				movups	lvel, xmm0
				; m_pPhysicsShell->get_LinearVel((Fvector*)lvel);
				mov		ecx, [esi+m_pPhysicsShell]
				lea		eax, lvel
				CPhysicsShell__get_LinearVel ecx, eax
				; if (m_dwSafetyLockTime <= Level().timeServer()) 
				Level__timeServer
				.if		[esi+m_dwSafetyLockTime] <= eax
					; local acc = m_vLastLVel.distance_to(lvel)/((float)m_dwDelta * 0.001f)
					movups	xmm0, lvel
					subps	xmm0, [esi+m_vLastLVel]
					mulps	xmm0, xmm0
					movss	xmm1, xmm0
					shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
					addss	xmm1, xmm0				; xmm1 = x + y
					shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
					addss	xmm0, xmm1				; xmm0 = z + xmm1
					sqrtss	xmm0, xmm0
					cvtsi2ss xmm1, dword ptr [esi+m_dwDelta]
					mulss	xmm1, ds:float_1e_3		; * 0.001f
					divss	xmm0, xmm1				; xmm0 = acc
					; if (acc > m_fAccThreshold)
					comiss	xmm0, dword ptr [esi+m_fAccThreshold]
					jbe		_endif
;						movss	acc, xmm0
;						mov		eax, acc
;						PRINT_FLOAT	"Граната взорвана от удара! acc - %f", eax
						mov		[esi+m_actived_grn_udz], 0			; m_actived_grn_udz = false;
						CGameObject__Destroy esi
						mov		[esi+m_dwDestroyTime], 0FFFFFFFFh	; m_dwDestroyTime = 0xFFFFFFFF;
						jmp		exit
					_endif:
				.endif
				; m_vLastLVel = lvel;
				movups	xmm0, lvel
				movups	[esi+m_vLastLVel], xmm0
				mov		[esi+m_dwDelta], 0			; m_dwDelta = 0;
			.endif
		.endif
	.endif
exit:
;-----------------------------------
	leave
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
	.if		al == 0
		mov		edi, [esi+NameSection]
		.if		edi != 0
			add		edi, 10h		; edi = section
			push	offset aSafetyLockTime			; "time_safetylock"
			push	edi
			mov		eax, ds:pSettings				; CInifile const * const pSettings
			mov		ecx, [eax]
			call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
			.if		eax != 0
				push	offset aSafetyLockTime		; "time_safetylock"
				push	edi
				mov		eax, ds:pSettings			; CInifile const * const pSettings
				mov		ecx, [eax]
				call	ds:r_u32
				mov		[esi+m_dwSafetyLockTime], eax
				push	offset aAccThreshold			; "acc_threshold"
				push	edi
				mov		eax, ds:pSettings				; CInifile const * const pSettings
				mov		ecx, [eax]
				call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
				.if		eax != 0
					push	offset aAccThreshold		; "acc_threshold"
					push	edi
					mov		eax, ds:pSettings			; CInifile const * const pSettings
					mov		ecx, [eax]
					call	ds:r_float
					fstp	dword ptr [esi+m_fAccThreshold]
					mov		[esi+m_actived_grn_udz], 1
					mov		dword ptr [esi+m_dwDelta], 0
				.endif
			.endif
		.endif
	.endif
;-------------------------------
	pop		esi
	pop		edi
	pop		ebx
	pop		ecx
	; делаем что вырезали
	mov		bl, 1
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
local cartridge:CCartridge		;	sizeof 60 bytes
local cumul_pos:Fvector			;	sizeof 12 bytes
;---------------------------------
	mov		eax, [esi]
	mov		edx, [eax+54h]
	mov		ecx, esi
	call	edx					; cast_game_object()
;	PRINT_UINT	"cast_game_object - %x", eax
;	PRINT_UINT	"CExplosive - %x", esi
	mov		edi, [eax+NameSection]
	.if		edi != 0
		add		edi, 10h		; edi = section
	;	PRINT_UINT	"Cumulative effect, section bomb - %s", edi
		push	offset aCumulativeSect			; "cumulative_sect"
		push	edi
		mov		eax, ds:pSettings				; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
		.if		eax != 0
	;		LPCSTR	cumul_sect	= ini->r_string(section, "cumulative_sect");
			push	offset aCumulativeSect			; "cumulative_sect"
			push	edi
			mov		eax, ds:pSettings			; CInifile const * const pSettings
			mov		ecx, [eax]
			call	ds:r_string
	;		PRINT_UINT	"Cumulative effect, section - %s", eax
	;		CCartridge cartridge;
			.if		eax != 0
				push	0
				push	eax
				lea		ecx, cartridge
				call	CCartridge__CCartridge
		;		cartridge->Load(cumul_sect, 0);
				lea		ecx, cartridge
				call	CCartridge__Load
				; CGameObject	obj = cast_game_object()	
				mov		eax, [esi]
				mov		edx, [eax+54h]
				mov		ecx, esi
				call	edx					; cast_game_object()
				mov		edi, eax			; edi = obj;
				mov		ecx, [edi]
				mov		edx, [ecx+10h]
				lea		ecx, cumul_pos
				push	ecx
				mov		ecx, edi
				call	edx					; Center(cumul_pos)
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
				lea		ecx, cartridge
				push	ecx				; const CCartridge& cartridge	= cartridge
				fld1
				push	ecx	
				fstp	dword ptr [esp]	; float maximum_distance		= 1.f
				push	6				; ALife::EHitType e_hit_type	= ALife::eHitTypeFireWound	// = 6
				movzx	ecx, word ptr [edi+0A4h]
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
				push	kum_speed		; float starting_speed			= 1000.f (447A0000h)
				lea		ecx, [edi+direction]
				push	ecx				; Fvector& direction			= Direction()
				lea		ecx, cumul_pos
				push	ecx				; Fvector& position				= Center()
				mov		ecx, ds:g_pGameLevel
				mov		eax, [ecx]
				mov		ecx, [eax+487C4h]
				call	CBulletManager__AddBullet
			.endif
		.endif
	.endif
	leave
	; делаем что вырезали
	mov		edx, [esi]
	mov		eax, [edx+54h]
	jmp		back_from_cumulative_effect
cumulative_effect endp

; стабилизированная ракета (ракета разворачивается по курсу)	void CCustomRocket::UpdateCL()
stabilized_rocket proc
; esi - CCustomRocket
m_pPhysicsShell			= dword ptr 1ECh
m_explosion_flags		= byte	ptr 1108
Direction				= dword ptr 070h	;
Position				= dword ptr 080h	;
flExploding				= byte	ptr 1
; локальные переменные
local lvel:Fvector4				; sizeof 16 bytes
;---------------------------------------------
	mov		ecx, [esi+m_pPhysicsShell]
	.if		ecx != 0
		; Fvector4	lvel.set(0,0,0,0);
		xorps	xmm0, xmm0
		movups	lvel, xmm0
		; m_pPhysicsShell->get_LinearVel((Fvector*)lvel);
		lea		eax, lvel
		CPhysicsShell__get_LinearVel ecx, eax
		; float	speed = lvel.magnidute()
		movups	xmm0, lvel
		movaps	xmm2, xmm0
		mulps	xmm0, xmm0
		movss	xmm1, xmm0
		shufps	xmm0, xmm0, 11100101b	; 3211t		копируем 1-й элемент в 0-й элемент
		addss	xmm1, xmm0				; xmm1 = x + y
		shufps	xmm0, xmm0, 11100110b	; 3212t		копируем 2-й элемент в 0-й элемент
		addss	xmm0, xmm1				; xmm0 = z + xmm1
		sqrtss	xmm0, xmm0				; xmm0 = speed
		movss	xmm1, ds:float_1
		; if (speed > 1.f)	{
		comiss	xmm0, xmm1
		jbe		_endif
			; lvel.mul(1/speed);
			divss	xmm1, xmm0		; xmm1 = 1/speed
			shufps	xmm1, xmm1, 00000000b	; 0000t		копируем из 0-вого во все остальные
			mulps	xmm2, xmm1
			movups	lvel, xmm2
			; Direction().set((Fvector*)lvel);
			ASSUME	ecx:ptr Fvector
			lea		ecx, [esi+Direction]
			mov		eax, lvel.x
			mov		[ecx].x, eax
			mov		eax, lvel.y
			mov		[ecx].y, eax
			mov		eax, lvel.z
			mov		[ecx].z, eax
			ASSUME	ecx:nothing
		_endif:
	.endif
	; // если ракета взорвана, то её останавливаем!
	; if (m_explosion_flags.test(flExploding))	CCustomRocket::Contact(Position(), Direction())
	.if		[esi+m_explosion_flags] & flExploding
		lea		eax, [esi+Direction]
		push	eax
		lea		ecx, [esi+Position]
		push	ecx
		mov		ecx, esi
		call	CCustomRocket__Contact
	.endif
	leave
	jmp		back_from_stabilized_rocket
stabilized_rocket endp

;==================================================================
;		---=== Осветительная ракета ===---
; (c) НаноБот
aNotExplosive			db "not_explosive", 0
; Загрузка булевой: not_explosive
CCustomRocket__reloadFlareRocket proc
; esi - CCustomRocket
; edi - section
;m_bFlareRocket			= byte  ptr 377	; = 649-110h
;-----------------------------------
	push	eax
	mov		[esi+m_bFlareRocket-110h], 0
	push	offset aNotExplosive			; "not_explosive"
	push	edi
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	.if		eax != 0
		push	offset aNotExplosive		; "not_explosive"
		push	edi
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_bool
		mov		[esi+m_bFlareRocket-110h], al
;		lea		eax, [esi+m_bFlareRocket-110h]
;		PRINT_UINT "adress  m_bFlareRocket: - %x", eax
		movzx	eax, [esi+m_bFlareRocket-110h]
		PRINT_UINT "m_bFlareRocket: - %x", eax
	.endif
	pop     eax
	; делаем что вырезали
	mov     [esi+376], al
	jmp		back_from_CCustomRocket__reloadFlareRocket
CCustomRocket__reloadFlareRocket endp

; если время вышло, то гасим партиклы и удаляем ракету.
CExplosiveRocket__EndFlareRocket proc
;	lea		ecx, [esi+m_bFlareRocket]
;	PRINT_UINT "adress  m_bFlareRocket: - %x", ecx
;	movzx	ecx, [esi+m_bFlareRocket]
;	PRINT_UINT "EndFlareRocket: m_bFlareRocket: - %x", ecx
	.if [esi+m_bFlareRocket]
		push	edi
		push	ebx
		mov		ecx, esi
		call	CCustomRocket__Contact
		mov		ecx, esi
		call	CCustomRocket__PlayContact
		CGameObject__DestroyObject esi
		pop		edi
		pop		ebx
		pop		esi
		retn	8		; выходим из void CExplosiveRocket::Contact(const Fvector &pos, const Fvector &normal)
	.endif
	; делаем что вырезали
	lea		ecx, [esi+3C8h]
	jmp		back_from_CExplosiveRocket__EndFlareRocket
CExplosiveRocket__EndFlareRocket endp

; отключаем колбек на контакт с геометрией и объектами.
CCustomRocket__notcontact_FlareRocket proc
;	lea		eax, [esi+m_bFlareRocket]
;	PRINT_UINT "adress  m_bFlareRocket: - %x", eax
;	movzx	ecx, [esi+m_bFlareRocket]
;	PRINT_UINT "notcontact_FlareRocket: m_bFlareRocket: - %x", ecx
	; делаем что вырезали
	mov     ecx, [esi+1ECh]
	;--------------------
	.if [esi+m_bFlareRocket]
		mov     eax, [ecx]
		mov     edx, [eax+94h]
		push    0
		call    edx             ; set_ObjectContactCallback
		jmp		back_from__notcontact_FlareRocket2
	.endif
	jmp		back_from__notcontact_FlareRocket
CCustomRocket__notcontact_FlareRocket endp
;==================================================================
