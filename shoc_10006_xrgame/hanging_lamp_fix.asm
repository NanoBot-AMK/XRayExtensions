CHangingLamp__net_Spawn_fix proc
; edi - cse_hanging_lamp
; esi - lamp
	; ��������� ���������� virtual size � ��������� ������ �������� ����� ������
	push    eax
	; ��������� ��� �������
;	call get_render_generation
	;PRINT_UINT "render_generation: %d", eax
;	cmp     eax, 90
;	jnz not_r2_render
	mov		ecx, psDeviceFlags
	mov		ecx, [ecx]
	test	ecx, 80000h		;psR2
	jz		not_r2_render
	;PRINT "is_r2"
	;--
	;mov     eax, [edi + 336]
	fld     dword ptr [edi + 336]
	;mov eax, [some_vs]
	mov     ecx, [esi]	
	fst     dword ptr [ecx + 270h]
	fchs
	fstp    dword ptr [ecx + 274h]
	;mov     [ecx + 270h], eax
	;mov eax, [ecx + 270h]
	;PRINT_FLOAT "virtual_size: %f", eax
	;fld     dword ptr [edi + 336] ; virtual_size
	;fdiv    dword ptr [fld_0_01] ; virtual_size / 0.01
	
	;fist    dword ptr [rounded_virtual_size] ; round(virtual_size / 0.01)
	;movzx   eax, byte ptr [rounded_virtual_size]
	;PRINT_UINT "rounded_virtual_size: %d", eax
	;mov     ecx, [esi]
	;mov     byte ptr [ecx + 3Ch + 3], al
	;--
not_r2_render:
	pop     eax
	; ������ ����������
	mov     ecx, [esi]
	mov     edx, [ecx]
	mov     edx, [edx+30h]
	; ��� �������
	jmp back_from_CHangingLamp__net_Spawn_fix
CHangingLamp__net_Spawn_fix endp

fld_0_01 dd 0.01
fpu_cr dw ?
rounded_virtual_size dd ?
vs dd ?
some_vs dd 0.34

;FLDCW instruction loads the control register from the specified memory location, 
;FSTCW stores the control register into the specified memory location.

get_render_generation proc
	push    ecx
	;
	mov     eax, ds:Render
	mov     ecx, [eax]
	mov     eax, [ecx]
	mov     eax, [eax]
	call    eax
	; 
	pop     ecx
	retn
get_render_generation endp

; next fix assumes extended CSE_ALifeObjectHangingLamp::flags field
;	flPhysic		= 0x01,
;	flCastShadow	= 0x02,
;	flR1			= 0x04,
;	flR2			= 0x08,
;	flTypeSpot		= 0x10,
;	flPointAmbient	= 0x20,
;	flVolumetric	= 0x40,
;	flUseFlare		= 0x80,
CHangingLamp__net_Spawn_fix_2 proc
;.text:101F269A                 push    ecx
;.text:101F269B                 fstp    [esp+2Ch+var_2C]
;.text:101F269E                 call    edx

	push    ecx
	fstp    dword ptr [esp]
	call    edx

	push    eax
	; ��������� ��� �������
;	call get_render_generation
	;PRINT_UINT "render_generation: %d", eax
;	cmp     eax, 90
;	jnz not_r2_render

	mov		ecx, psDeviceFlags
	mov		ecx, [ecx]
	test	ecx, 80000h		;psR2
	jz		not_r2_render
	
	; new code
	; mark flare flag
	mov		ecx, [esi]	;light_render
	
	mov     ax, [edi+138h]	; flags
;	and		al, 80h		;flUseFlare
;	cmp		al, 80h
	test	ax, 80h
	jz		check_volumetric
	mov		eax, [ONE]
	mov		[ecx+284h], eax

check_volumetric:
	; handle volumetric spots
	mov     ax, [edi+138h]	; flags
;	and		al, 40h		;flVolumetric
;	cmp		al, 40h
	test	ax, 40h
	jz		exit
;	mov     al, [edi+138h]	; flags
;	and		al, 10h		;flTypeSpot
;	cmp		al, 10h
	test	ax, 10h
	jz		exit
	mov		eax, [ONE]
	mov		[ecx+288h], eax
	
exit:
	pop     eax
	jmp back_from_CHangingLamp__net_Spawn_fix_2
	
not_r2_render:
	pop     eax
	; ��� �������
	jmp back_from_CHangingLamp__net_Spawn_fix_2
CHangingLamp__net_Spawn_fix_2 endp

ONE dd 1