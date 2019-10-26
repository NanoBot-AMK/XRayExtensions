UpdateAddonsVisibility_fix proc
	;
	; ������ ��� ������ �������
	; �������� ������ ��� ������� ������
	push ecx
	push eax
	push edi
	;
	movzx eax, byte ptr [edi + 936]
	;PRINT_UINT "UpdateAddonsVisibility: %x", eax
	test eax, 040h
	jz disable_callback
	;PRINT "UpdateAddonsVisibility_fix 1"
	;PRINT_UINT "object: %x", edi
	
	push    777 ; ��������
	push    888 ; ��������
	push    154 ; ��������� - ��� �������
	mov     ecx, edi ; this
	add     ecx, 0d8h
;item: 172fd6f8 obj
;item: 172fd620 wpn

	call    CGameObject__callback ; eax = callback
	;PRINT_UINT "aaa: %x", eax
	push    eax ; callback
	; ��������
	call    script_callback_int_int
	;
disable_callback:
	pop edi
	pop eax
	pop ecx
	;
	;PRINT "UpdateAddonsVisibility_fix 2"
	; ������ ����������
	mov     ecx, esi ; <== ��� ����
	call    ds:CKinematics__CalculateBones_Invalidate ; <== ��� ��� ������� ����� ��������� ����������, ���� ��������� �����
	mov     eax, [esi]
	mov     edx, [eax+40h]
	push    0
	mov     ecx, esi
	call    edx
	;
	;PRINT "UpdateAddonsVisibility_fix 3"
	;
	pop     esi
	pop     ebp
	pop     ebx
	retn
UpdateAddonsVisibility_fix endp

UpdateHUDAddonsVisibility_fix proc
	push ecx
	push eax
	
	movzx eax, byte ptr [ebp + 936]
	;PRINT_UINT "UpdateHUDAddonsVisibility: %x", eax
	test eax, 040h
	jz disable_callback
	;PRINT "UpdateHUDAddonsVisibility 1"
	;
	push    777 ; ��������
	push    888 ; ��������
	push    155 ; ��������� - ��� �������
	mov     ecx, ebp ; this
	add     ecx, 0d8h
	call    CGameObject__callback ; eax = callback
	push    eax ; callback
	call    script_callback_int_int
disable_callback:
	pop eax
	pop ecx

	; ������ ����������
	push    ebx
	push    edi
	push    offset aWpn_scope ; "wpn_scope"
	mov     ecx, esi
	; ��� �������
	jmp back_from_UpdateHUDAddonsVisibility_fix
UpdateHUDAddonsVisibility_fix endp
aWpn_scope db "wpn_scope", 0

CWeaponMagazinedWGrenade__UseScopeTexture_fix proc
	mov    al, byte ptr [ecx+3A8h] ; m_flagsAddOnState
	and     al, 080h
	jz     go_as_usual
	xor     eax, eax
	;mov     eax, 1
	retn
go_as_usual:
	mov     eax, [ecx+3B4h]
	cmp     eax, 2 ; IsGrenadeLauncherAttached()
	jnz     short loc_1022B3D3
	test    [ecx+3A8h], al
	jnz     short loc_1022B3D8
loc_1022B3D3:
	cmp     eax, 1 ; m_bGrenadeMode
	jnz     short return_true
loc_1022B3D8:
	cmp     byte ptr [ecx+958h], 0
	jz      short return_true
	xor     eax, eax ; return false
	retn
; ---------------------------------------------------------------------------
return_true:
	mov     eax, 1 ; return true
	retn
CWeaponMagazinedWGrenade__UseScopeTexture_fix endp

CWeapon__UseScopeTexture_fix proc
	mov     al, [ecx+3A8h] ; m_flagsAddOnState
	and     eax, 080h
	jnz     lab1
	; return true
	mov     eax, 1
	;PRINT_UINT "eax=%x", eax
	retn
lab1:
	; return false
	xor     eax, eax
	;PRINT_UINT "eax=%x", eax
	retn
CWeapon__UseScopeTexture_fix endp
