
align_proc
actor_shadow_fix proc
	mov		eax, ds:g_pGameLevel
	.if (eax)
; 4253E3 - CHUDManager::Render_First()	set_invisible (false/true)
; 1C8948 - CActor::renderable_Render() убрали hudview
		mov		eax, [eax]
		push	eax
		mov		eax, [eax+148h]
		mov		edx, [eax]
		mov		ecx, eax
		mov		eax, [edx+0Ch]
		call	eax
		pop		eax
	.endif
	; old
	add		[edi+320h], ebx
	jmp back_to_actor_shadow_fix
actor_shadow_fix endp

; Вывод стартового адреса xrRender_R2.dll в логе
static_byte		first_start_log, true
align_proc
StartAdress_xrGame_log__DllMain proc
	.if (first_start_log)
		mov		eax, [esp]
		sub		eax, 00002DC5h
		PRINT_UINT	"xrRender_R2.dll Start adress: %08X", eax
		mov		first_start_log, false
	.endif
	; делаем что вырезали
	mov		eax, [esp+4+8];fdwReason
	sub		eax, 1
	retn
StartAdress_xrGame_log__DllMain endp
