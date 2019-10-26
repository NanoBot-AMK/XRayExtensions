

align_proc
call_pda_contact_callback proc
	; вызываем колбек для актора
	CALLBACK__INT_INT	g_Actor, 180, eax, 0
	; Делаем что вырезали
	call	ch_info_get_from_id
	jmp		return_call_pda_contact_callback
call_pda_contact_callback endp

