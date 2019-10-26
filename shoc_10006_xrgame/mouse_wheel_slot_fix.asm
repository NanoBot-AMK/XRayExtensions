

align_proc
CActor@@OnNextWeaponSlotNew proc
	.if (g_mouse_wheel_sc)
		jmp		CActor@@OnNextWeaponSlot
	.endif
	retn
CActor@@OnNextWeaponSlotNew endp

align_proc
CActor@@OnPrevWeaponSlotNew proc
	.if (g_mouse_wheel_sc)
		jmp		CActor@@OnPrevWeaponSlot
	.endif
	retn
CActor@@OnPrevWeaponSlotNew endp
