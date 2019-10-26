
align_proc
armor_piercing_fix proc
AP = dword ptr 8
; схитрим, там xmm2 дальше перезаписывается
	movss   xmm1, FP4(1.0)
	movss   xmm2, [esp+10h+AP]
	divss	xmm2, FP4(2.0)
	subss	xmm1, xmm2
	jmp	back_from_armor_piercing_fix
armor_piercing_fix endp
