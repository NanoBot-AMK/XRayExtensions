; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; ������ ����������� ��������-����� ���������������� � �.�. � ����, ������� � ������ ���������
; ��� ������������� �������� ����� ������
CUIWPN_PARAMS_CHECK_SECTION MACRO sect_name_str:REQ
LOCAL lab1
LOCAL sect_name
	jmp     lab1
sect_name db sect_name_str, 0
lab1:
	test    eax, eax
	jz      loc_103E0DBE
	mov     ecx, offset sect_name
	mov     eax, ebx
	call    xr_strcmp
ENDM

CUIWpnParams__Check_fix:
	; ������ ����
	CUIWPN_PARAMS_CHECK_SECTION "wpn_knife"
	CUIWPN_PARAMS_CHECK_SECTION "mp_wpn_knife"
	ifdef OGSE_BUILD
		CUIWPN_PARAMS_CHECK_SECTION "wpn_knife_m1"
		CUIWPN_PARAMS_CHECK_SECTION "wpn_montirovka"
	endif
	; ������ ����������
	CUIWPN_PARAMS_CHECK_SECTION "wpn_binoc"
	; ������������
	jmp     back_from_CUIWpnParams__Check_fix
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
