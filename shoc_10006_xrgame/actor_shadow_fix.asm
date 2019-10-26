
align_proc
CActor__Update_fix proc
;edi	this	CActor*
	;вырезанное
	sbb		eax, eax
	add		eax, 1
	;Проверяем тип рендера.
	mov		ecx, ds:psDeviceFlags
	.if ([ecx].Flags32 & rsR2 && [edi].CActor.cam_active==NULL)
		mov		eax, true
	.endif
	push	eax
	jmp		return_CActor__Update_fix
CActor__Update_fix endp

;align_proc
;CActor__Update_two_fix proc
;;esi	this	CActor*
;	mov		ecx, ds:psDeviceFlags
;	.if ([ecx] & rsR2 && [esi].CActor.cam_active==NULL)
;		mov		eax, 1
;		jmp		return_CActor__Update_two_fix
;	.endif
;	push    esi
;	mov     esi, eax
;	call    sub_101DEE40
;	jmp		return_CActor__Update_two_fix
;CActor__Update_two_fix endp

align_proc
CActor__renderable_Render_fix proc
;esi	this	CActor*
	; r2/ не r2
	mov		edx, ds:Render
	mov		ecx, ds:psDeviceFlags
	mov		edx, [edx]
	.if (([ecx].Flags32 & rsR2 && [edx].R_dsgraph_structure.phase) || !eax)
		; рендеринг теней
		lea     ecx, [esi].CActor.CAttachmentOwner@vfptr	;CInventoryOwner
		pop		edi
		pop		esi
		jmp		CInventoryOwner@@renderable_Render
	.endif
	pop		edi
	pop		esi
	retn
CActor__renderable_Render_fix endp