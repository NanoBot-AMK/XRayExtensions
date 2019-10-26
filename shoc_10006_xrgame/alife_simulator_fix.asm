include alife_simulator_reg_macro.asm

align_proc
alife_simulator_fix proc
	; делаем то, что вырезали
	call	CALifeSimulator_register__CSE_Abstract__LPCSTR_pFvector_int_u16_u16
	; делаем то, что хотели
	ALIFE_SIM_PERFORM_EXPORT__LPCSTR_PFVECTOR_INT_U16_U16	CALifeSimulator__TeleportObject,		"teleport_object"
	ALIFE_SIM_PERFORM_EXPORT__LPCSTR_PFVECTOR_INT_U16_U16	CALifeSimulator__RegisterStoryObject,	"assign_story_id"
	
	; идём обратно
	jmp		return_alife_simulator_fix
alife_simulator_fix endp

align_proc
CALifeSimulator__TeleportObject proc C uses esi this_:ptr, section:ptr, position:ptr, level_vertex_id:dword, game_vertex_id:dword, parent_id:dword
;	CALifeUpdateManager::teleport_object(int this<esi>, u16 id, int game_vertex_id, int level_vertex_id, int position)
	mov		esi, this_
	invoke	CALifeUpdateManager@@teleport_object, parent_id, game_vertex_id, level_vertex_id, position
	xor		eax, eax
	ret
CALifeSimulator__TeleportObject endp

align_proc
release_fix proc
	; делаем то, что вырезали
	test	esi, esi
	; если указатель не нулевой, то идём обратно
	jnz		return_release_fix
	; иначе крашим игру
	R_ASSERT "Object to release is a zero pointer.", "CALifeSimulator::release"
release_fix endp

align_proc
CALifeSimulator__RegisterStoryObject proc C this_:dword, dummy1_str:dword, dummy2:dword, object_id:dword, story_id:dword, dummy3:dword
	push	object_id
	push	this_
	call	object_by_id
	add		esp, 8
	.if (eax) ; eax = server_object
		push	eax				; object
		mov		edx, story_id
		mov		dword ptr [eax+0B8h], edx ; прописываем объекту story_id
		push	edx
		mov		eax, this_ ; alife_simulator
		mov		eax, [eax+294h+20h]
		push	eax				; this == story_registry
		call	CALifeStoryRegistry__add
		xor		eax, eax
	.endif
	ret
CALifeSimulator__RegisterStoryObject endp

