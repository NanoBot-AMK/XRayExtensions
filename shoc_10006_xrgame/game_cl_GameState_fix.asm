
static_int		g_ignore_game_state_update, 0

align_proc
game_cl_GameState__net_import_GameTime_fix proc
var_1C			= dword ptr -1Ch
var_C			= dword ptr -0Ch
var_8			= dword ptr -8
arg_0			= dword ptr	 8
	;PRINT "game_cl_GameState__net_import_GameTime_dbg_fix"
	.if (g_ignore_game_state_update)
		and		g_ignore_game_state_update, 0
		;PRINT "ignore_once"
		retn	4
	.endif
	push	ebp
	mov		ebp, esp
	and		esp, 0FFFFFFF8h
	sub		esp, 0Ch
	push	ebx
	push	esi
	mov		esi, [ebp+arg_0]
	mov		eax, [esi+2004h]
	mov		ecx, [eax+esi]
	mov		edx, [eax+esi+4]
	add		eax, 8
	mov		[esi+2004h], eax
	push	edi
	mov		edi, [eax+esi]
	add		eax, 4
	mov		[esi+2004h], eax
	mov		eax, ds:g_pGameLevel
	mov		[esp+18h+var_C], edi
	mov		edi, [eax]
	mov		edi, [edi+45D0h]
	;PRINT "m_qwStartGameTime before"
	;PRINT_UINT "%x", [esi+70h]
	;PRINT_UINT "%x", [esi+74h]
	mov		[edi+70h], ecx
	mov		[edi+74h], edx
	mov		eax, [eax]
	lea		ecx, [eax+160h]
	call	ds:IPureClient__timeServer_Async
	movss	xmm0, [esp+18h+var_C]
	mov		edx, ds:g_pGameLevel
	mov		[edi+68h], eax
	mov		dword ptr [edi+6Ch], 0
	movss	dword ptr [edi+78h], xmm0
	mov		eax, [esi+2004h]
	mov		ebx, [eax+esi]
	mov		edi, [eax+esi+4]
	add		eax, 8
	mov		[esi+2004h], eax
	mov		ecx, [eax+esi]
	add		eax, 4
	mov		[esi+2004h], eax
	mov		eax, [edx]
	mov		[esp+18h+var_C], ecx
	mov		ecx, [eax+45D0h]
	mov		eax, [ecx]
	mov		edx, [eax+28h]
	call	edx
	fld		[esp+18h+var_C]
	push	ecx
	fstp	[esp+1Ch+var_1C]
	mov		[esp+1Ch+var_8], eax
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	push	edi
	push	ebx
	mov		esi, edx
	call	CLevel__SetEnvironmentGameTimeFactor
	pop		edi
	pop		esi
	pop		ebx
	mov		esp, ebp
	pop		ebp
	retn	4
game_cl_GameState__net_import_GameTime_fix endp
