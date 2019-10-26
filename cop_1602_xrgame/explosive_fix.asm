
;  Назначаем инициатор функции explode	Nanobot-AMK
CScriptGameObject_explode_fix proc
arg_1		= dword ptr  4
	; свободны eax, edx	; ecx = &object()
	mov		eax, [esp+14h+arg_1]
	test	eax, eax
	jz		value_nil
	mov		eax, [eax+4]	; eax = game_object
	test	eax, eax
	jz		value_nil					; 
	mov		ecx, eax					; ecx = initiator->object();
value_nil:
	movzx	edx, word ptr [ecx+0A4h]	; u16 eax = initiator->object().ID(); 	// 7 bytes -- вырезаная команда
;	PRINT_UINT "initiatorID = %d", edx
	jmp		back_from_CScriptGameObject_explode_fix
CScriptGameObject_explode_fix endp

