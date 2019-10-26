;*******************************************************************************
; S.T.A.L.K.E.R data stubs
; 1.0004
;*******************************************************************************
org 1041EB90h - shift
Log			dd ?
org 1041EAF8h - shift
Msg			dd ?
org 101CA330h - shift
CGameObject__lua_game_object:

org 10266720h - shift
CCC_RegisterCommands:
org 101A5C40h - shift
sub_101A5C40:

; Вывод стартового адреса xrGame.dll в логе
org 10265920h - shift	; 32 bytes
hinstDLL		= dword ptr	 4
fdwReason		= dword ptr	 8
lpvReserved		= dword ptr	 0Ch
	call	StartAdress_xrGame_log__DllMain
	mov		eax, [esp+fdwReason]
	sub		eax, 1
	jnz		loc_10265933
	call	CCC_RegisterCommands
	call	sub_101A5C40
loc_10265933:
	mov		eax, 1
	retn	12
;
