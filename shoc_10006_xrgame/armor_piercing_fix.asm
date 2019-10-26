
align_proc
armor_piercing_fix proc
;xmm1 = 1.0
	;1.0f - AP*0.5f
	movss   xmm2, dword ptr [esp+10h+8];AP
	mulss	xmm2, FP4(0.5)
	subss	xmm1, xmm2
	jmp		return_armor_piercing_fix
armor_piercing_fix endp
