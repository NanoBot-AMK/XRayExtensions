
align_proc
customzonefix proc
;	xorps   xmm1, xmm1
;	movss   dword ptr [ecx+2FCh], xmm1		;m_fLightTimeLeft = 0.f;
;	mov		esi, ecx
;	jmp		back_from_customzonefix
	push	ecx
	mov     esi, [esi+1D4h]
	call    CZoneEffector@@Stop
	pop		ecx
	; ��������� ���� �������
	xorps   xmm1, xmm1
	movss   dword ptr [ecx+2FCh], xmm1		;m_fLightTimeLeft = 0.f;
	; ��������, ���� �� ���������� ����
	mov     esi, [ecx+2BCh]
	mov		eax, esi
	neg     eax
	sbb     eax, eax
;	test    ds:resptr_base_IRender_Light____get, eax ; resptr_base<IRender_Light>::_get(void)
;	jz      short exit
	.if (resptr_base_IRender_Light____get & eax)
		; ��������, ������� �� ���������� ����
		mov     edx, [esi]
		mov     eax, [edx+8]
		call    eax
		.if (al)
			; �������� ���������� ����, ���� �������
			mov     eax, [edx+4]
			push    0
			call    eax								;m_pLight->set_active(false);
		.endif
	.endif
;exit:
;	mov		esi, ecx
;	jmp		back_from_customzonefix
	pop		edi
	pop		esi
	retn 4
customzonefix endp
