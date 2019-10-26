
align_proc
CALifeStoryRegistry__add_fix proc
	cmp     eax, [ebp+8]
	jz      loc_1006CA49
	PRINT_UINT "Warning! Was found duplicate story id [%d].", edi
	jmp		loc_1006CA65
CALifeStoryRegistry__add_fix endp

