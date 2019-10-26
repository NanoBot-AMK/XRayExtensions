include global_ns_reg_macro.asm
;===============| расширение регистрации глобального пространства имён |=======
global_space_ext proc ; вставка, дополняющая функцию экспорта глобальных функций
	; здесь делаем то, что вырезали
	call	error_log_register
	; добавляем свой код
	; регистрация функции вывода в лог, вместо нерабочей "log"
	GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR my_log_fun, "log1"
	; регистрация функции крэша игры с выводом причины в лог
	GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR msg_and_fail, "fail"
	; регистрация функции "bind_to_dik"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT bind_to_dik, "bind_to_dik"
	; регистрация функции "set_extensions_flags"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT set_extensions_flags, "set_extensions_flags"
	; функция установки глобальных флагов актора
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT set_actor_flags, "set_actor_flags"
	; функция получения глобальных флагов актора
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT get_actor_flags, "get_actor_flags"
	; регистрация функции "get_extensions_flags"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT get_extensions_flags, "get_extensions_flags"
	;add	 esp, 0Ch
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetIntArg0, "set_int_arg0"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetIntArg1, "set_int_arg1"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetIntArg2, "set_int_arg2"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetIntArg3, "set_int_arg3"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetIntArg4, "set_int_arg4"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetIntArg5, "set_int_arg5"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetIntArg6, "set_int_arg6"
	;GLOBAL_NS_PERFORM_EXPORT__BOOL__VOID IsPdaMenuShown, "is_pda_shown"
	; ; регистрация функции "flush1", вместо нерабочей "flush"
	; ; регистрация тестовой функции "log2"
	 ; lea	   eax, [ebp-1]
	 ; push	   eax
	 ; push	   offset my_log2
	 ; push	   offset alog2	  ; "log2"
	 ; push	   esi
	 ; call	   flush_register
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetTradeFiltrationOn, "set_trade_filtration_on"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetTradeFiltrationOff, "set_trade_filtration_off"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetManualGroupingOn, "set_manual_grouping_on"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetManualGroupingOff, "set_manual_grouping_off"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetManualHighlightOn, "set_manual_highlight_on"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetManualHighlightOff, "set_manual_highlight_off"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT GetManualHighlight, "get_manual_highlight"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SetHighlightColor, "set_highlight_color"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SumArgs, "sum_args"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT SubArgs, "sub_args"
	
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT GetGoodwill, "GetGoodwill"
	
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT DelayedInventoryUpdate, "update_inventory_window"
	
	GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR init_external_libs, "init_external_libs"

	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT print_level_time, "print_level_time"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT print_alife_time, "print_alife_time"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT set_ignore_game_state, "set_ignore_game_state_update"

	; скриншот
	GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR take_screenshot0, "screenshot0"
	GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR take_screenshot1, "screenshot1"
	GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR take_screenshot2, "screenshot2"
	GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR take_screenshot3, "screenshot3"

	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT set_input_language, "set_input_language"
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT get_input_language, "get_input_language"
	
	GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT my_flush, "flush_log"
	
	; идём обратно
	jmp back_from_global_space_ext
global_space_ext endp

align_proc
my_flush proc
	call	ds:FlushLog
	retn
my_flush endp

; align_proc
; my_log2 proc near
	; sub		esp, 8
	; fld		ds:value1
	; fstp	QWORD  ptr [esp]
	; push	static_str$("qwerty %e")
	; call	ds:Msg
	; add		esp, 12
	; retn
; my_log2 endp
; static_float	value1, 1.23456e12
; static_int		value2, 12345678h

align_proc
my_log_fun proc C param_str:dword
	push	param_str
	push	static_str$("%s")
	call	ds:Msg
	add		esp, 8
	ret
my_log_fun endp

align_proc
bind_to_dik proc C action_id:dword
	ASSUME	ecx:ptr _keyboard, edx:ptr _binding
	mov		eax, action_id
	.if (sdword ptr eax>=0 && sdword ptr eax<=76)	; аргумент в пределах допустимого диапазона
		lea		eax, [eax*2+eax]
		lea		edx, g_key_bindings[eax*4]	; &g_key_bindings[cmd];		//_binding*
		mov		ecx, [edx].m_keyboard[0]	; = g_key_bindings[cmd].m_keyboard[0]
		.if (ecx)
			mov		eax, [ecx].dik
			ret
		.endif
		mov		ecx, [edx].m_keyboard[4]	; = g_key_bindings[cmd].m_keyboard[1]
		.if (ecx)
			mov		eax, [ecx].dik
			ret
		.endif
		xor		eax, eax
		ret
	.endif
	ASSUME	ecx:nothing, edx:nothing
	mov		eax, 100000 ; аргумент вне допустимого диапазона
	ret
bind_to_dik endp

static_int		extensions_flags, 0
align_proc
set_extensions_flags proc C flags:dword
	mrm		extensions_flags, flags
	ret
set_extensions_flags endp

align_proc
get_extensions_flags proc
	mov		eax, extensions_flags
	retn
get_extensions_flags endp

;g_int_argument_0 dword 0
;g_int_argument_1 dword 0
;g_int_argument_2 dword 0
;g_int_argument_3 dword 0
;g_int_argument_4 dword 0
;g_int_argument_5 dword 0

;SetIntArg0 proc
;int_arg = dword ptr  4
;	mov		eax, [esp+int_arg]
;	mov		g_int_argument_0, eax
;	retn
;SetIntArg0 endp


SET_INT_ARG_N 0
SET_INT_ARG_N 1
SET_INT_ARG_N 2
SET_INT_ARG_N 3
SET_INT_ARG_N 4
SET_INT_ARG_N 5
SET_INT_ARG_N 6
align_proc
IsPdaMenuShown proc
	mov		eax, 1
	retn
IsPdaMenuShown endp

msg_and_fail proc near
	push	ebp
	mov		ebp, esp
	
	mov		eax, [ebp+8]
	push	eax
	;push	 offset aS_4	 ; "%s"
	;call	 ds:[Msg] 
	;add	 esp, 8
	mov		ecx, ds:Debug ; this
	push	offset ignore_always
	push	offset aEmpty ; "xrServer::Process_event_ownership"
	push	0h			   ; line
	push	offset aEmpty ; "E:\\stalker\\sources\\trunk\\xr_3da\\xrGame\\"...
	push	eax ; "e_parent"
	call	ds:xrDebug__fail

	pop		ebp
	retn
msg_and_fail endp
ignore_always db 1
aEmpty db 0

align_proc
set_actor_flags proc C flags:dword
	mrm		psActorFlags, flags
	ret
set_actor_flags endp

align_proc
get_actor_flags proc
	mov		eax, psActorFlags
	ret
get_actor_flags endp

static_int	g_trade_filtration_active, 0
static_int	g_manual_grouping_active, 0

align_proc
SetTradeFiltrationOn proc
	mov		g_trade_filtration_active, 1
	ret
SetTradeFiltrationOn endp

align_proc
SetTradeFiltrationOff proc
	mov		g_trade_filtration_active, 0
	ret
SetTradeFiltrationOff endp

align_proc
SetManualGroupingOn proc
	mov		g_manual_grouping_active, 1
	ret
SetManualGroupingOn endp

align_proc
SetManualGroupingOff proc
	mov		g_manual_grouping_active, 0
	ret
SetManualGroupingOff endp

static_int	g_manual_highlignt_active, 0
align_proc
SetManualHighlightOn proc
	mov		g_manual_highlignt_active, 1
	ret
SetManualHighlightOn endp

align_proc
SetManualHighlightOff proc
	mov		g_manual_highlignt_active, 0
	ret
SetManualHighlightOff endp

align_proc
GetManualHighlight proc
	mov		eax, g_manual_highlignt_active
	ret
GetManualHighlight endp

_static		g_highlight_colors dd 16 DUP(0)
align_proc
SetHighlightColor proc C color:dword, col_idx:dword
	mov		edx, col_idx
	and		edx, 0Fh
	mov		eax, color
	mov		[g_highlight_colors+edx*4], eax
	ret
SetHighlightColor endp

align_proc
SumArgs proc C arg1:dword, arg2:dword
	mov		eax, arg1
	add		eax, arg2
	ret
SumArgs endp

align_proc
SubArgs proc C arg1:dword, arg2:dword
	mov		eax, arg1
	sub		eax, arg2
	ret
SubArgs endp

align_proc
GetGoodwill proc C uses edx for_who:dword, to_who:dword
	push	to_who
	push	for_who
	call	RELATION_REGISTRY__GetGoodwill
	ret
GetGoodwill endp

DelayedInventoryUpdate proc
	pusha
	call	GetGameSP
	test	eax, eax
	jz		exit
	mov		eax,[eax+3Ch] ; InventoryMenu
	test	eax, eax
	jz		exit
	mov		byte ptr [eax+64h], 1 ; m_b_need_reinit = true
exit:	
	popa
	ret
DelayedInventoryUpdate endp

print_level_time proc
	mov		eax, ds:g_pGameLevel
	mov		eax, [eax]
	mov		ecx, [eax+45D0h]
	mov		eax, ecx
	mov		edx, [eax]
	mov		eax, [edx+1Ch]
	call	eax
	PRINT "print_level_time"
	ret
print_level_time endp

print_alife_time proc uses edi
	mov		eax, g_ai_space
	mov		eax, [eax+18h]
	mov		ecx, [eax+0Ch]
	mov		edx, [ecx+4]
	mov		edi, [edx+eax+18h]
	call	CALifeTimeManager__game_time
	PRINT "print_alife_time"
	ret
print_alife_time endp

align_proc
set_ignore_game_state proc
	mov		g_ignore_game_state_update, 1
	ret
set_ignore_game_state endp

LOAD_DLL MACRO module_name_str:REQ, g_lib_hinst:REQ
LOCAL module_name
static_str		module_name, module_name_str
	mov		eax, g_lib_hinst
	.if (!eax)
		push	offset module_name
		call	LoadLibraryA
		.if (!eax)
			PRINT_UINT "Failed to load library '%s'", offset module_name
			push	offset module_name
			call	msg_and_fail
			add		esp, 4
			retn
		.endif
	.endif
	mov		g_lib_hinst, eax
	PRINT_UINT "Loaded: %s", offset module_name
ENDM

GET_PROC_ADDR MACRO g_lib_hinst:REQ, fun_name_str:REQ, g_fun_addr:REQ
LOCAL fun_name
static_str		fun_name, fun_name_str
	push	offset fun_name
	push	g_lib_hinst
	call	GetProcAddress
	.if (!eax)
		PRINT_UINT "can't get address of '%s'", offset fun_name
		push	offset fun_name
		call	msg_and_fail
		add		esp, 4
		retn
	.endif
	mov		g_fun_addr, eax
ENDM

static_int		g_ogse_lib_hinst, 0
g_CEffectorZoomInertion__Process dd ?
g_CCameraManager__Update3 dd ?	
g_CCar__cam_Update dd ?

align_proc
init_external_libs proc
	LOAD_DLL "extensions\ogse.dll", g_ogse_lib_hinst
	GET_PROC_ADDR g_ogse_lib_hinst, "CEffectorZoomInertion__Process", g_CEffectorZoomInertion__Process
	GET_PROC_ADDR g_ogse_lib_hinst, "CCameraManager__Update3",		  g_CCameraManager__Update3
	GET_PROC_ADDR g_ogse_lib_hinst, "CCar__cam_Update",				  g_CCar__cam_Update
	ret
init_external_libs endp

align_proc
take_screenshot0 proc C fname:dword
	push	fname
	push	0 ; code: 0 - normal, 1 - cubemap, 2 - save, 3 - levelmap
	mov		eax, ds:Render
	mov		ecx, [eax]
	mov		edx, [ecx]
	mov		eax, [edx+0D0h]
	call	eax
	ret
take_screenshot0 endp

align_proc
take_screenshot1 proc C fname:dword
	push	fname
	push	1 ; code: 0 - normal, 1 - cubemap, 2 - save, 3 - levelmap
	mov		eax, ds:Render
	mov		ecx, [eax]
	mov		edx, [ecx]
	mov		eax, [edx+0D0h]
	call	eax
	ret
take_screenshot1 endp

align_proc
take_screenshot2 proc C fname:dword
	push	fname
	push	2 ; code: 0 - normal, 1 - cubemap, 2 - save, 3 - levelmap
	mov		eax, ds:Render
	mov		ecx, [eax]
	mov		edx, [ecx]
	mov		eax, [edx+0D0h]
	call	eax
	ret
take_screenshot2 endp

align_proc
take_screenshot3 proc C fname:dword
	push	fname
	push	3 ; code: 0 - normal, 1 - cubemap, 2 - save, 3 - levelmap
	mov		eax, ds:Render
	mov		ecx, [eax]
	mov		edx, [ecx]
	mov		eax, [edx+0D0h]
	call	eax
	ret
take_screenshot3 endp

align_proc
set_input_language proc C lang:dword
	m2m		g_input_language, lang
	ret
set_input_language endp

align_proc
get_input_language proc
	mov		eax, g_input_language
	ret
get_input_language endp

rescan_pathes proc
	push ecx
	push eax
	mov		ecx, ds:xr_FS
	mov		ecx, [ecx]
	call	CLocatorAPI__rescan_pathes
	pop eax
	pop ecx
	retn
rescan_pathes endp
