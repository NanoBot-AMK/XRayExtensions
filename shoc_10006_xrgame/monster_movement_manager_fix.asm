include monster_movement_manager_reg_macro.asm

align_proc
mmm_fix proc
	MMM_PERFORM_EXPORT__BOOL__VOID		CALifeMonsterMovementManager__SetPathType,	"set_path_type"
	
	jmp		return_mmm_fix
mmm_fix endp

align_proc
CALifeMonsterMovementManager__SetPathType proc
	xor		eax, eax
	mov		[ecx+0Ch], eax
	retn
CALifeMonsterMovementManager__SetPathType endp
