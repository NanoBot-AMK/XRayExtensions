
; Вывод стартового адреса xrGame.dll в логе
static_byte		first_start_log, true
align_proc
StartAdress_xrGame_log__DllMain proc
	.if (first_start_log)
		mov		eax, [esp]
		sub		eax, 00265925h
		PRINT_UINT	"xrGame.dll Start adress: %08X", eax
		mov		first_start_log, false
	.endif
	retn
StartAdress_xrGame_log__DllMain endp
