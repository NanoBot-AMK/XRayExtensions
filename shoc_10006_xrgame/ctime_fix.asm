include ctime_reg_macro.asm

align_proc
ctime_fix proc
	call	CTime_register__void__int_int_int
	;---------------------
	CTIME_PERFORM_EXPORT__VOID__INT_INT_INT							CTime__set_value,	"set_value"
	CTIME_PERFORM_EXPORT__VOID__PINT_PINT_PINT_PINT_PINT_PINT_PINT	CTime__get_value,	"get_value"
	jmp		return_ctime_fix
ctime_fix endp

align_proc
CTime__set_value proc time_lo:dword, time_hi:dword, dummy:dword
	ASSUME	ecx:ptr xrTime
	mrm		[ecx].m_time.lo, time_lo
	mrm		[ecx].m_time.hi, time_hi
	ret
CTime__set_value endp

align_proc
CTime__get_value proc year:ptr dword, mon:ptr dword, day:ptr dword, hour:ptr dword, mi:ptr dword, sec:ptr dword, ms:ptr dword
	xor		eax, eax
	mov		edx, ms
	mov		[edx], eax
	mov		edx, sec
	mov		[edx], eax
	mov		edx, mi
	mov		[edx], eax
	mov		edx, hour
	mov		[edx], eax
	mov		edx, day
	mov		[edx], eax
	mov		edx, mon
	mrm		[edx], [ecx].m_time.hi
	mov		edx, year
	mrm		[edx], [ecx].m_time.lo
	ASSUME	ecx:nothing
	ret
CTime__get_value endp
