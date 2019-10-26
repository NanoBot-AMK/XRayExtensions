; �������� �������������� ���������� � ���������� �� � ������� CEnvDescriptor
envdescriptor_hack_load:
	; ������� � ������ ������ �������
	mov		ecx, ds:Memory
	push	18h	; rain_color(0Ch) + sun_shafts(4) + sun_shafts_density(4) + rain_max_drop_angle(4)
	call	ds:xrMemory__mem_alloc
	mov		[esi+5Ch], eax
	; �������� ���������� rain_color
	mov     ecx, ds:pSettings
	mov     ecx, [ecx]    ; _DWORD
	push    offset aRain_color ; "rain_color"
	push    edi             ; _DWORD
	lea     eax, [esp+40h]
	push    eax             ; _DWORD
	call    ds:CInifile__r_fvector3
	mov		ecx, [esi+5Ch]
	mov     edx, [eax]
	mov     [ecx], edx
	mov     edx, [eax+4]
	mov     [ecx+4], edx
	mov     edx, [eax+8]
	mov     [ecx+8], edx
	; ������ ������ ���� �����
	; sun_shafts
	mov     ecx, ds:pSettings
	mov     ecx, [ecx]    ; _DWORD
	push    offset aSunShafts ; "sun_shafts"
	push    edi             ; _DWORD
	call    ds:CInifile__r_float
	mov		ecx, [esi+5Ch]
	fstp	dword ptr [ecx+0Ch]
	; sun_shafts_density
	mov     ecx, ds:pSettings
	mov     ecx, [ecx]    ; _DWORD
	push    offset aSunShaftsDensity ; "sun_shafts_density"
	push    edi             ; _DWORD
	call    ds:CInifile__r_float
	mov		ecx, [esi+5Ch]
	fstp	dword ptr [ecx+10h]
	; rain_max_drop_angle
	mov     ecx, ds:pSettings
	mov     ecx, [ecx]    ; _DWORD
	push    offset aRainMaxDropAngle ; "rain_max_drop_angle"
	push    edi             ; _DWORD
	call    ds:CInifile__r_float
	mov		ecx, [esi+5Ch]
	fstp	dword ptr [ecx+14h]
	; ������� ������ ���� - ������
	jmp back_to_envdescriptor_hack_load
	
aRain_color db "rain_color", 0	
aSunShafts db "sun_shafts", 0
aSunShaftsDensity db "sun_shafts_density", 0
aRainMaxDropAngle db "rain_max_drop_angle", 0

; ���� ��� ����������� ������������� rain_color
envdescriptor_hack_rain_color_fix:
	mov		eax, [edi+1D0h]
	push	eax
	mov     eax, [eax]
	add     ecx, 40h
	mov     [esp+34h], eax
	pop		eax
	movss   xmm2, dword ptr [esp+30h]
	sar     ecx, 1Fh
	and     edx, ecx
	mov     ecx, [eax+4h]
	xor     edx, esi
	mov     [esp+20h], edx
	mov     edx, [eax+8h]
	jmp back_to_envdescriptor_hack_rain_color_fix

; �� ������ ������ ������ ���������� ������ ������
envdescriptor_hack_destructor:
	mov		ecx, ds:Memory
	mov		edi, esi
	add		edi, 5Ch
	push	edi
	call	ds:xrMemory__mem_free
	mov		[esi+5Ch], ebx
	; ����������
	pop     edi
	pop     esi
	pop     ebp
	pop     ebx
	retn
	
; rain_drop_angle
rain_drop_angle:
	push	eax		; pEnvironment
	mov		eax, [eax+1D0h]
	fld		dword ptr [eax+14h]
	fld		ds:radian
	fmulp
	pop		eax
	jmp back_to_rain_drop_angle
	
; ������������ ���������� ����� �������������
descriptor_mixer_lerp:
; this = esi, A = eax, B = ebx, f = xmm0, m_power = xmm3
	; ������� � ������ ������ �������
	push	eax
	mov		ecx, ds:Memory
	push	18h	; rain_color(0Ch) + sun_shafts(4) + sun_shafts_density(4) + rain_max_drop_angle(4)
	call	ds:xrMemory__mem_alloc
	mov		[esi+5Ch], eax
	mov     ecx, [ebp+18h]
	pop		eax
	; ���������������� ���������
	push	eax
	push	ebx
	push	esi
	mov		eax, [eax+5Ch]
	mov		ebx, [ebx+5Ch]
	mov		esi, [esi+5Ch]
	; rain_color.x
	movss   xmm4, dword ptr [ebx]
	mulss   xmm4, xmm0
	movaps  xmm6, xmm3
	mulss   xmm6, dword ptr [eax]
	addss   xmm4, xmm6
	movss   dword ptr [esi], xmm4
	; rain_color.y
	movss   xmm4, dword ptr [ebx+4]
	mulss   xmm4, xmm0
	movaps  xmm6, xmm3
	mulss   xmm6, dword ptr [eax+4]
	addss   xmm4, xmm6
	movss   dword ptr [esi+4], xmm4
	; rain_color.z
	movss   xmm4, dword ptr [ebx+8]
	mulss   xmm4, xmm0
	movaps  xmm6, xmm3
	mulss   xmm6, dword ptr [eax+8]
	addss   xmm4, xmm6
	movss   dword ptr [esi+8], xmm4
	; sun_shafts
	movss   xmm4, dword ptr [ebx+0Ch]
	mulss   xmm4, xmm0
	movaps  xmm6, xmm3
	mulss   xmm6, dword ptr [eax+0Ch]
	addss   xmm4, xmm6
	movss   dword ptr [esi+0Ch], xmm4
	; sun_shafts_density
	movss   xmm4, dword ptr [ebx+10h]
	mulss   xmm4, xmm0
	movaps  xmm6, xmm3
	mulss   xmm6, dword ptr [eax+10h]
	addss   xmm4, xmm6
	movss   dword ptr [esi+10h], xmm4
	; rain_max_drop_angle
	movss   xmm4, dword ptr [ebx+14h]
	mulss   xmm4, xmm0
	movaps  xmm6, xmm3
	mulss   xmm6, dword ptr [eax+14h]
	addss   xmm4, xmm6
	movss   dword ptr [esi+14h], xmm4
	pop		esi
	pop		ebx
	pop		eax
	jmp back_to_descriptor_mixer_lerp

; �������� ����������� ��� CEnvDescriptor
descriptor_copy_operator:
	; ������� � ������ ������ �������
	mov		ecx, ds:Memory
	push	18h	; rain_color(0Ch) + sun_shafts(4) + sun_shafts_density(4) + rain_max_drop_angle(4)
	call	ds:xrMemory__mem_alloc
	mov		[edi+5Ch], eax
	; rain_color
	push	ebx
	push	edi
	mov		ebx, [ebx+5Ch]
	mov		edi, [edi+5Ch]
	mov     eax, [ebx]
	mov     [edi], eax
	mov     ecx, [ebx+4h]
	mov     [edi+4h], ecx
	mov     edx, [ebx+8h]
	mov     [edi+8h], edx
	; sun_shafts
	fld		dword ptr [ebx+0Ch]
	fstp	dword ptr [edi+0Ch]
	; sun_shafts_density
	fld		dword ptr [ebx+10h]
	fstp	dword ptr [edi+10h]
	; rain_max_drop_angle
	fld		dword ptr [ebx+14h]
	fstp	dword ptr [edi+14h]
	pop		edi
	pop		ebx
	jmp back_to_descriptor_copy_operator

; ����������� ����������� ��� CEnvDescriptor
;.text:0040D426                 mov     edx, [this+5Ch]
;.text:0040D429                 mov     [eax+5Ch], edx
;.text:0040D42C                 mov     edx, [this+60h]
;.text:0040D42F                 mov     [eax+60h], edx
;.text:0040D432                 mov     edx, [this+64h]
;.text:0040D435                 mov     [eax+64h], edx
descriptor_copy_constructor:
	; ������� � ������ ������ �������
	push	eax
	push	ecx
	mov		ecx, ds:Memory
	push	18h	; rain_color(0Ch) + sun_shafts(4) + sun_shafts_density(4) + rain_max_drop_angle(4)
	call	ds:xrMemory__mem_alloc
	mov		edx, eax
	pop		ecx
	pop		eax
	mov		[eax+5Ch], edx
	; rain_color
	push	ebx
	push	edi
	mov		ebx, [eax+5Ch]
	mov		edi, [ecx+5Ch]
	mov     edx, [ebx]
	mov     [edi], edx
	mov     edx, [ebx+4h]
	mov     [edi+4h], edx
	mov     edx, [ebx+8h]
	mov     [edi+8h], edx
	; sun_shafts
	fld		dword ptr [ebx+0Ch]
	fstp	dword ptr [edi+0Ch]
	; sun_shafts_density
	fld		dword ptr [ebx+10h]
	fstp	dword ptr [edi+10h]
	; rain_max_drop_angle
	fld		dword ptr [ebx+14h]
	fstp	dword ptr [edi+14h]
	pop		edi
	pop		ebx
	jmp back_to_descriptor_copy_constructor
	
radian dd 0.0174532925