art_activation_fix proc
	; � ecx ���� ��������� �����-����� ���������� �������� level_vertex_id. ���� �� ����� ������.
	call    CAI_Space__ai
	mov     eax, [eax+0Ch]			; eax = ai().level_graph()
	lea     ebx, [esp+2100h-20E4h]	; position
	push	ebx
	push	eax
	call	CLevelGraph__vertex__Fvector3
	mov		ecx, eax
	
	jmp	back_from_art_activation_fix
art_activation_fix endp