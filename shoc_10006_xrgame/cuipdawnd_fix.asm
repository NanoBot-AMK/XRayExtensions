; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
align_proc
cui_pda_fix_map proc
	push	offset aUi_pda_map		; "ui_pda_map"
	call	SendInfoToActor
	add		esp, 4
	; возвращаемся
	jmp back_from_cui_pda_fix
cui_pda_fix_map endp

align_proc
cui_pda_fix_map2 proc
	push	offset aUi_pda_quests	; "ui_pda_quests"
	call	SendInfoToActor
	add		esp, 4
	; возвращаемся
	jmp back_from_cui_pda_fix
cui_pda_fix_map2 endp

const_static_str	aUi_pda_map,					"ui_pda_map"
const_static_str	aUi_pda_quests,					"ui_pda_quests"
const_static_str	aUi_pda_task_description,		"ui_pda_task_description"
const_static_str	aUi_pda_task_description_hide,	"ui_pda_task_description_hide"

; выдача инфо при переключении между описанием задания и картой
align_proc
CUITaskRootItem__OnSwitchDescriptionClicked_fix proc
	; делаем свое
	pusha
	.if (bl)
		push	offset aUi_pda_task_description_hide	; "ui_pda_task_description_hide"
		call	SendInfoToActor
		add		esp, 4
	.else
		push	offset aUi_pda_task_description			; "ui_pda_task_description"
		call	SendInfoToActor
		add		esp, 4
	.endif
	popa
	; делаем выпиленное
	call	CUIEventsWnd__SetDescriptionMode
	; возвращаемся
	jmp		back_from_CUITaskRootItem__OnSwitchDescriptionClicked_fix
CUITaskRootItem__OnSwitchDescriptionClicked_fix endp

; также учитываем переключение между вкладками активных, выполненных и проваленных заданий
align_proc
CUIEventsWnd__OnFilterChanged_fix proc
	; делаем свое
	pusha
	; кастуем актора в CScriptGameObject
	mov		edi, g_Actor
	call	CGameObject__lua_game_object
	.if (eax)
		; проверяем наличие открытого окна описания задания через поршень ui_pda_task_description
		mov		ecx, eax
		push	offset aUi_pda_task_description				; "ui_pda_task_description"
		call	CScriptGameObject@@HasInfo
		.if (al)
			; окно было открыто значит выдаем ui_pda_task_description_hide
			push	offset aUi_pda_task_description_hide	; "ui_pda_task_description_hide"
			call	SendInfoToActor
			add		esp, 4
		.endif
	.endif
	popa
	; делаем выпиленное
	call	CUIEventsWnd__ReloadList
	; возвращаемся
	jmp		back_from_CUIEventsWnd__OnFilterChanged_fix
CUIEventsWnd__OnFilterChanged_fix endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
