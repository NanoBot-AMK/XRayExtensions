
PERFORM_EXPORT_PHSHELL__VOID__PVECTOR MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		pTmp, offset fun_to_export
	lea		eax, pTmp
	call	register_shell__void__Fvector
ENDM

align_proc
script_register@@physics_shell_fix proc
	call	register_shell__void__Fvector	;вырезанное
	call	script_register@@physics_shell
	jmp		return_script_register@@physics_shell_fix
script_register@@physics_shell_fix endp

align_proc
script_register@@physics_shell proc
local pTmp:dword
	PERFORM_EXPORT_PHSHELL__VOID__PVECTOR		CScriptCPHShell@@setTorque,				"set_torque"
	PERFORM_EXPORT_PHSHELL__VOID__PVECTOR		CScriptCPHShell@@getTorque,				"get_torque"
	PERFORM_EXPORT_PHSHELL__VOID__PVECTOR		CScriptCPHShell@@set_LinearVel,			"set_linear_vel"
	PERFORM_EXPORT_PHSHELL__VOID__PVECTOR		CScriptCPHShell@@set_AngularVel,		"set_angular_vel"
	PERFORM_EXPORT_PHSHELL__VOID__PVECTOR		CScriptCPHShell@@get_AngularVel,		"get_angular_vel"
	ret
script_register@@physics_shell endp

align_proc
CScriptCPHShell@@setTorque proc ;torque:ptr Fvector
	mov		eax, [ecx]
	mov		edx, [eax+64h]
	jmp		edx			;CPHShell::setTorque(const Fvector& torque)
CScriptCPHShell@@setTorque endp

align_proc
CScriptCPHShell@@getTorque proc ;torque:ptr Fvector
	mov		eax, [ecx].CPHShell.elements._Myfirst
	mov		ecx, [eax]
	mov		eax, [ecx]
	mov		edx, [eax+164h]
	jmp		edx			;CPHElement::getTorque(const Fvector& torque)
CScriptCPHShell@@getTorque endp

align_proc
CScriptCPHShell@@set_LinearVel proc ;velocity:ptr Fvector
	mov		eax, [ecx]
	mov		edx, [eax+0A4h]
	jmp		edx			;CPHShell::set_LinearVel(const Fvector& velocity)
CScriptCPHShell@@set_LinearVel endp

align_proc
CScriptCPHShell@@set_AngularVel proc ;velocity:ptr Fvector
	mov		eax, [ecx]
	mov		edx, [eax+0A8h]
	jmp		edx			;CPHShell::set_AngularVel(const Fvector& velocity)
CScriptCPHShell@@set_AngularVel endp

align_proc
CScriptCPHShell@@get_AngularVel proc ;velocity:ptr Fvector
	mov		eax, [ecx]
	mov		edx, [eax+0A0h]
	jmp		edx			;CPHShell::get_AngularVel(const Fvector& velocity)
CScriptCPHShell@@get_AngularVel endp