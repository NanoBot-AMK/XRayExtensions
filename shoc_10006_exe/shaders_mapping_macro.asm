REGISTER_CONSTANT_VECTOR MACRO 
	.if (byte ptr [ecx+0Ah] & 1)
		movzx	eax, word ptr [ecx+0Ch]
		shl		eax, 4
		add		eax, offset RCache_constants_a_pixel
		movss	dword ptr [eax], xmm0
		movss	dword ptr [eax+4], xmm1
		movss	dword ptr [eax+8], xmm2
		movss	dword ptr [eax+0Ch], xmm3
		movzx	eax, word ptr [ecx+0Ch]
		lea		edx, [eax+1]
		.if (eax<dword_50D3D4)
			mov		dword_50D3D4, eax
		.endif
		.if (eax>dword_50D3D8)
			mov		dword_50D3D8, edx
		.endif
		mov		RCache_constants_a_pixel_b_dirty, 1
	.endif
	.if (byte ptr [ecx+0Ah] & 2)
		movzx	eax, word ptr [ecx+10h]
		shl		eax, 4
		add		eax, offset RCache_constants_a_vertex
		movss	dword ptr [eax], xmm0
		movss	dword ptr [eax+4], xmm1
		movss	dword ptr [eax+8], xmm2
		movss	dword ptr [eax+0Ch], xmm3
		movzx	eax, word ptr [ecx+10h]
		lea		ecx, [eax+1]
		.if (eax<dword_50E3F4)
			mov		dword_50E3F4, eax
		.endif
		.if (eax>dword_50E3F8)
			mov		dword_50E3F8, ecx
		.endif
		mov		RCache_constants_a_vertex_b_dirty, 1
	.endif
ENDM

REGISTER_CONSTANT_MATRIX MACRO 
	push	ebp
	push	edi
	mov		edi, [esp+0Ch]
;;;	mov		[ecx+194h], edi
	lea		ebp, [ecx]
	.if (edi)
		push	esi
		.if (byte ptr [edi+0Ah] & 1)
			lea		eax, [edi+0Ch]
			mov		ecx, ebp
			mov		esi, offset RCache_constants_a_pixel
			call	R_constant_array__set
			mov		RCache_constants_a_pixel_b_dirty, 1
		.endif
		.if (byte ptr [edi+0Ah] & 2)
			lea		eax, [edi+10h]
			mov		ecx, ebp
			mov		esi, offset RCache_constants_a_vertex
			call	R_constant_array__set
			mov		RCache_constants_a_vertex_b_dirty, 1
		.endif
		pop		esi
	.endif
	pop		edi
	pop		ebp
	retn	4
ENDM
