

align_proc
CGameObject@@SpawnObject proc id_obj:dword
local P:NET_Packet
	push	esi
	ASSUME	ecx:ptr CGameObject
	.if ([ecx].Props.flags & net_Local)
		movzx	edx, [ecx].ID
		push	edx
		push	GE_OWNERSHIP_REJECT
		lea		esi, P
		call	CGameObject__u_EventGen
		add		esp, 8
		mov		eax, P.B.count
		mov		edx, id_obj
		mov		[esi+eax], dx	;word ptr P.B.data[eax]
		add		P.B.count, 2
		push	8
		push	esi
		call	CGameObject__u_EventSend
		add		esp, 8
	.endif
	ASSUME	ecx:nothing
	pop		esi
	ret		4
CGameObject@@SpawnObject endp

CGameObject@TeleportObject MACRO id_obj:req, pPosition:req
	push	esi
	sub		esp, sizeof NET_Packet
	mov		esi, esp
	ASSUME	esi:ptr NET_Packet, eax:ptr Fvector
	movzx	eax, id_obj
	push	eax
	push	GE_CHANGE_POS
	call	CGameObject__u_EventGen
	mov		eax, [esi].B.count
	add		eax, esi
	mov		edx, pPosition.x
	mov		[eax].x, edx
	mov		ecx, pPosition.y
	mov		[eax].y, ecx
	mov		edx, pPosition.z
	mov		[eax].z, edx
	add		[esi].B.count, 12
	push	8
	push	esi
	call	CGameObject__u_EventSend
	add		esp, 8+8+sizeof NET_Packet
	ASSUME	esi:nothing, eax:nothing, edi:nothing
	pop		esi
ENDM

align_proc
CCustomZone@@ScriptSpawnArtefact proc
;ebp - this			CCustomZone*
;edi - pArtefact	CArtefact*
;esi - pArtefact	CGameObject*
	ASSUME	ebp:ptr CCustomZone, esi:ptr CGameObject
	.if ([ebp].m_bAllowScriptSpawnArtefact)
		mov		ecx, ebp	; CCustomZone = CGameObject
		invoke	CGameObject@@SpawnObject, [esi].ID
		;return;
		pop		edi
		pop		esi
		pop		ebp
		retn	4
	.endif
	ASSUME	ebp:nothing, esi:nothing
	mov		edx, [ebp+328h]
	jmp		return_CCustomZone@@ScriptSpawnArtefact
CCustomZone@@ScriptSpawnArtefact endp

align_proc
CCustomZone@@TeleportArtefact proc
;ebx - this						CCustomZone*
;ebp - pArtefact				CArtefact*
;esi - pArtefact->Position		Fvector
	ASSUME	ebp:ptr CArtefact
;	lea		eax, [ebp].XFORM_.c_
;	PRINT_VECTOR "1 TeleportArtefact: pos", eax
;	movflt	xmm1, 0.000018311665	; = 0.3/16383.f	
;	mov		edx, ds:Random
;	mov		eax, edx
;	call	CRandom__randI
;	sub		eax, 16383
;	cvtsi2ss xmm0, eax
;	mulss	xmm0, xmm1
;	addss	xmm0, [ebp].XFORM_.c_.x
;	movss	[ebp].XFORM_.c_.x, xmm0
;	mov		eax, edx
;	call	CRandom__randI
;	sub		eax, 16383
;	cvtsi2ss xmm0, eax
;	mulss	xmm0, xmm1
;	addss	xmm0, [ebp].XFORM_.c_.y
;	movss	[ebp].XFORM_.c_.y, xmm0
;	mov		eax, edx
;	call	CRandom__randI
;	sub		eax, 16383
;	cvtsi2ss xmm0, eax
;	mulss	xmm0, xmm1
;	addss	xmm0, [ebp].XFORM_.c_.z
;	movss	[ebp].XFORM_.c_.z, xmm0
;	lea		eax, [ebp].XFORM_.c_
;	PRINT_VECTOR "2 TeleportArtefact: pos", eax
	CGameObject@TeleportObject	[ebp].ID, [ebp].XFORM_.c_
	ASSUME	ebp:nothing
	;вырезаное
	mov		eax, [ebx+340h]
	jmp		return_CCustomZone@@TeleportArtefact
CCustomZone@@TeleportArtefact endp

align_proc
CCustomZone@@NormalizeDir proc
;esi - dir	Fvector*
	ASSUME	esi:ptr Fvector
;	PRINT_VECTOR "1 dir", esi
	Fvector@normalize	[esi]
;	PRINT_VECTOR "2 dir", esi
	ASSUME	esi:nothing
	;вырезаное
	fld     dword ptr [ebx+338h]
	jmp		return_CCustomZone@@NormalizeDir
CCustomZone@@NormalizeDir endp
