
eHit							= dword ptr 16		; ������ �� ���
eExtendedHit					= dword ptr 186		; ����������� ������ �� ���

; ���������� ������� CActor::HitSignal
CActor_HitSignal_ext proc
; ����� ��������� � ����� ������ ��������� �����, ��������� ���������� ���
; ������������ ���������� � �����:
;perc			 = dword ptr  4
;vLocalDir		 = dword ptr  8
;who			 = dword ptr  0Ch
;element		 = dword ptr  10h

; ��������� ���
	push	ebp	  ; +4
	mov		ebp, esp
	push	edi
	mov		edi, ecx ; this
	push	ecx
; �������� ���������� ������ �� ���
;callback(GameObject::eHit)(
;		this->lua_game_object(), 
;		amount,
;		vLocalDir,
;		who->lua_game_object(),
;		element);
	mov		ecx, dword ptr [ebp+4h+10h]
	push	ecx						; element
	mov		ecx, dword ptr [ebp+4h+0Ch]
	call	CGameObject__lua_game_object
	push	eax						; who.game_object
	mov		eax, dword ptr [ebp+4h+08h]
	mov		ecx, [eax + 8h]
	push	ecx						; dir.x
	mov		ecx, [eax + 4h]
	push	ecx						; dir.y
	mov		ecx, [eax]
	push	ecx						; dir.z
	mov		eax, [ebp+4h+4h] 
	push	eax						; amount
	mov		ecx, edi				; ecx = this
	call	CGameObject__lua_game_object ; 
	push	eax						; this.game_object
	push	eHit					; ��� �������
	mov		ecx, edi				; ecx = this
	call	CGameObject__callback
	mov		ecx, eax
	call	script_hit_callback
	; ----
	pop		ecx
	pop		edi
	pop		ebp
; ������ ��, ��� ��������
	xorps	xmm5, xmm5	
	sub		esp, 0Ch
; ������������ �������
	jmp		back_to_CActor_HitSignal
CActor_HitSignal_ext endp


CEntityHitCallback proc entityHDS:dword
	push	esi
	push	edi
	;---------------------
	mov		edi, ecx
	mov		esi, entityHDS
	ASSUME	esi:ptr SHit
	mov		eax, [esi].hit_type
	imul	eax, 40h
	movzx	ecx, [esi].boneID
	add		eax, ecx
	push	eax						; hit_type*64+u32(boneID);	// ����������� ��� ��������� � ����
	mov		ecx, [esi].who
	call	CGameObject__lua_game_object
	push	eax						; who.game_object
	push	[esi].dir.x
	push	[esi].dir.y
	push	[esi].dir.z
	push	[esi].power
	ASSUME	esi:nothing
	mov		ecx, edi				; ecx = this
	call	CGameObject__lua_game_object ; 
	push	eax						; this.game_object
	push	eExtendedHit			; ��� �������
	mov		ecx, edi				; ecx = this
	call	CGameObject__callback
	mov		ecx, eax
	call	script_hit_callback
	;---------------------
	pop		edi
	pop		esi
	ret		4
CEntityHitCallback endp
