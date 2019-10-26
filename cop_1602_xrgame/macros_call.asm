
; используютс€ eax, ecx, edx
IKinematics__CalculateBones_Invalidate MACRO _this:REQ
	mov		eax, [_this]
	mov		edx, [eax+70h]
	mov		ecx, _this
	call	edx				; CalculateBones_Invalidate
ENDM

IKinematics__LL_BoneID MACRO _this:REQ, param1:REQ
	push	param1
	push	_this
	mov		eax, [_this]
	mov		edx, [eax+14h]
	call	edx
ENDM

IKinematics__LL_SetBoneVisible MACRO _this:REQ, param1:REQ, param2:REQ, param3:REQ
	push	param3			; TRUE
	push	param2			; visible
	push	param1			; bone_id
	mov		eax, [_this]
	mov		edx, [eax+60h]
	mov		ecx, _this
	call	edx				; LL_SetBoneVisible
ENDM

IKinematics__CalculateBones MACRO _this:REQ, param1:REQ
	push	param1
	mov		eax, [_this]
	mov		edx, [eax+6Ch]
	mov		ecx, _this
	call	edx
ENDM

IKinematics__LL_GetBoneVisible MACRO _this:REQ, param1:REQ
	push	param1			; bone_id
	push	_this
	mov		eax, [_this]
	mov		edx, [eax+5Ch]
	call	edx				; LL_GetBoneVisible
ENDM

CGameObject__Destroy MACRO _this:REQ
	mov		eax, [_this]
	mov		edx, [eax+144h]
	mov		ecx, _this
	call	edx				; CGameObject::Destroy
ENDM

CPhysicsShell__get_LinearVel MACRO _this:REQ, param1:REQ
	push	param1
	mov		eax, [_this]
	mov		edx, [eax+15Ch]
	call	edx				; CPhysicsShell::get_LinearVel
ENDM

Level__timeServer MACRO
	mov		ecx, ds:g_pGameLevel		; IGame_Level * g_pGameLevel
	mov		eax, [ecx]
	lea		ecx, [eax+40110h]
	call	ds:timeServer				; IPureClient::timeServer(void)
ENDM

Device_dwTimeDelta MACRO
	mov		eax, ds:Device
	mov		eax, [eax+24h]
ENDM

Device_fTimeDelta MACRO param1:REQ
	mov		eax, ds:Device
	mov		param1, [eax+1Ch]
ENDM

; ограничитель (с оптимизацией)
clamp MACRO reg:REQ, param1:REQ, param2:REQ
	.if		reg < param1
		IF	param1 EQ 0
			xor		reg, reg
		ELSE
			mov		reg, param1
		ENDIF
	.elseif	reg > param2
		IF	param2 EQ 0
			xor		reg, reg
		ELSE
			mov		reg, param2
		ENDIF
	.endif
ENDM

CGameObject__DestroyObject MACRO _this:REQ
	mov		edx, [_this]
	mov		ecx, _this
	mov		edx, [edx+100h]
	call	edx
ENDM
