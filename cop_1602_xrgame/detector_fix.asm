;	---=== СКРИПТОВЫЙ ДЕТЕКТОР ===---
; Управление отображением разных объектов из скрипта
; методами: detector_clear, detector_draw_object
; (с) НаноБот		30.11.2015 г.

aScriptMode		db "script_mode", 0		; параметр который включает скриптовый метод отображения
aScriptDetector	db "script_detector", 0

m_bScriptMode				= byte  ptr 837
m_artefacts					= dword ptr 844
m_items_to_draw				= dword ptr	824

CEliteDetectorLoadParam proc
; esi - CEliteDetector
; edi - section
;	m_bScriptMode	= READ_IF_EXISTS(pSettings, r_bool, section, "script_mode", false);
	mov		[esi+m_bScriptMode], 0
	push	offset aScriptMode				; "script_mode"
	push	edi
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	.if		eax != 0
		push	offset aScriptMode			; "script_mode"
		push	edi
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_bool
		mov		[esi+m_bScriptMode], al
	.endif
	; делаем что вырезали
	mov		edx, [esi+m_artefacts]
	jmp		back_from__CEliteDetectorLoadParam
CEliteDetectorLoadParam endp

CEliteDetectorUpdateAfScriptExt proc
; edi - CEliteDetector
	; делаем что вырезали
	mov		esi, [edi+m_items_to_draw]
;	if (m_bScriptMode)	return;	
	cmp		[edi+m_bScriptMode], 0
	jz		back_from__CEliteDetectorUpdateAfScriptExt
	pop		edi
	pop		esi
	pop		ebx
	add		esp, 14h
	retn	; выходим из void CEliteDetector::UpdateAf()
CEliteDetectorUpdateAfScriptExt endp

CEliteDetector__ui_xml_tag_ext proc
; ecx - CEliteDetector*
	.if		[ecx+m_bScriptMode] != 0
		mov		eax, offset aScriptDetector	; "script_detector"
	.endif
	retn
CEliteDetector__ui_xml_tag_ext endp
