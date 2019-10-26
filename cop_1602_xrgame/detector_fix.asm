;	---=== ���������� �������� ===---
; ���������� ������������ ������ �������� �� �������
; ��������: detector_clear, detector_draw_object
; (�) �������		30.11.2015 �.

aScriptMode		db "script_mode", 0		; �������� ������� �������� ���������� ����� �����������
aScriptDetector	db "script_detector", 0

m_bScriptMode				= dword ptr 837
m_artefacts					= dword ptr 844
m_items_to_draw				= dword ptr	824

CEliteDetectorLoadParam proc
; esi - CEliteDetector
; edi - section
;	m_bScriptMode	= READ_IF_EXISTS(pSettings, r_bool, section, "script_mode", false);
	mov		byte ptr [esi+m_bScriptMode], 0
	push	offset aScriptMode				; "script_mode"
	push	edi
	mov		eax, ds:pSettings				; CInifile const * const pSettings
	mov		ecx, [eax]
	call	ds:line_exist					; CInifile::line_exist(char const *,char const *)
	test	eax, eax
	jz		exit
		push	offset aScriptMode			; "script_mode"
		push	edi
		mov		eax, ds:pSettings			; CInifile const * const pSettings
		mov		ecx, [eax]
		call	ds:r_bool
		mov		byte ptr [esi+m_bScriptMode], al
exit:
	; ������ ��� ��������
	mov		edx, [esi+m_artefacts]
	jmp		back_from__CEliteDetectorLoadParam
CEliteDetectorLoadParam endp

CEliteDetectorUpdateAfScriptExt proc
; edi - CEliteDetector
	; ������ ��� ��������
	mov		esi, [edi+m_items_to_draw]
;	if (m_bScriptMode)	return;	
	cmp		byte ptr [edi+m_bScriptMode], 0
	jz		back_from__CEliteDetectorUpdateAfScriptExt
	pop		edi
	pop		esi
	pop		ebx
	add		esp, 14h
	retn				; ������� �� void CEliteDetector::UpdateAf()
CEliteDetectorUpdateAfScriptExt endp

CEliteDetector__ui_xml_tag_ext proc
; ecx - CEliteDetector*
	cmp		byte ptr [ecx+m_bScriptMode], 0
	jz		_if
	mov		eax, offset aScriptDetector	; "script_detector"
_if:	
	retn
;	mov		eax, offset aElite			; "elite"
;	retn
CEliteDetector__ui_xml_tag_ext endp
