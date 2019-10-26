; =========================================================================================
; ========================= added by Ray Twitty (aka Shadows) =============================
; =========================================================================================
; ====================================== START ============================================
; =========================================================================================
; запрет отображения прогресс-баров скорострельности и т.п. у ножа, бинокля и других предметов
; при необходимости добавьте новые секции
CUIWPN_PARAMS_CHECK_SECTION MACRO sect_name_str:REQ
	test    eax, eax
	jz      loc_103E0DBE
	mov     ecx, const_static_str$(sect_name_str)
	mov     eax, ebx
	call    xr_strcmp
ENDM

align_proc
CUIWpnParams__Check_fix proc
	CUIWPN_PARAMS_CHECK_SECTION "wpn_knife"
	CUIWPN_PARAMS_CHECK_SECTION "mp_wpn_knife"
IFDEF OGSE_BUILD
	CUIWPN_PARAMS_CHECK_SECTION "wpn_knife_m1"
	CUIWPN_PARAMS_CHECK_SECTION "wpn_montirovka"
ENDIF
	;вырезанное
	CUIWPN_PARAMS_CHECK_SECTION "wpn_binoc"
	jmp     return_CUIWpnParams__Check_fix
CUIWpnParams__Check_fix endp
; =========================================================================================
; ======================================= END =============================================
; =========================================================================================
