; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
cui_pda_fix_map proc
	push    offset aUi_pda_map ; "ui_pda_map"
	call    SendInfoToActor
	add     esp, 4
	; ������������
	jmp back_from_cui_pda_fix
cui_pda_fix_map endp

cui_pda_fix_map2 proc
	push    offset aUi_pda_quests ; "ui_pda_quests"
	call    SendInfoToActor
	add     esp, 4
	; ������������
	jmp back_from_cui_pda_fix
cui_pda_fix_map2 endp

aUi_pda_map db "ui_pda_map", 0
aUi_pda_quests db "ui_pda_quests", 0

; ������ ���� ��� ������������ ����� ��������� ������� � ������
CUITaskRootItem__OnSwitchDescriptionClicked_fix proc
	; ������ ����
	pusha
	cmp     bl, 0
	jz      short show_descr
	push    offset aUi_pda_task_description_hide ; "ui_pda_task_description_hide"
	call    SendInfoToActor
	add     esp, 4
	jmp     short exit
show_descr:
	push    offset aUi_pda_task_description ; "ui_pda_task_description"
	call    SendInfoToActor
	add     esp, 4
exit:
	popa
	; ������ ����������
	call    CUIEventsWnd__SetDescriptionMode
	; ������������
	jmp     back_from_CUITaskRootItem__OnSwitchDescriptionClicked_fix
CUITaskRootItem__OnSwitchDescriptionClicked_fix endp

; ����� ��������� ������������ ����� ��������� ��������, ����������� � ����������� �������
CUIEventsWnd__OnFilterChanged_fix proc
	; ������ ����
	pusha
	; ������� ������ � CScriptGameObject
	mov     edi, g_Actor
	call    CGameObject__lua_game_object
	test    eax, eax
	jz      short exit
	; ��������� ������� ��������� ���� �������� ������� ����� ������� ui_pda_task_description
	mov     ecx, eax
	push    offset aUi_pda_task_description ; "ui_pda_task_description"
	call    CScriptGameObject__HasInfo
	and     eax, 0FFh
	test    eax, eax
	jz      short exit
	; ���� ���� ������� ������ ������ ui_pda_task_description_hide
	push    offset aUi_pda_task_description_hide ; "ui_pda_task_description_hide"
	call    SendInfoToActor
	add     esp, 4
exit:
	popa
	; ������ ����������
	call    CUIEventsWnd__ReloadList
	; ������������
	jmp     back_from_CUIEventsWnd__OnFilterChanged_fix
CUIEventsWnd__OnFilterChanged_fix endp

aUi_pda_task_description db "ui_pda_task_description", 0
aUi_pda_task_description_hide db "ui_pda_task_description_hide", 0
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
