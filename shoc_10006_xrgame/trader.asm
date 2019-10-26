
;Если в модели торговца нет кости "bip01_head" то колбек на поворот головы на актора не регистрируем.
align_proc
fix_if_not_bip01_head_trader proc
	.if (ax==0FFFFh)	; такой кости нет
		movzx	eax, ax
		jmp		no_set_callback_trader
	.endif
	jmp		return_fix_if_not_bip01_head_trader
fix_if_not_bip01_head_trader endp
