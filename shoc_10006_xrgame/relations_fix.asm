
align_proc
alife__release_callback proc
	mov		edx, [ebp+8h]
	mov		eax, [edx]
	mov		edx, [eax+7Ch]
	call	edx
	.if (eax)
		pusha
		mov		edx, [ebp+8h]
		add		edx, 36h
		movzx	edx, word ptr [edx]
		push	edx
		; вызываем очистку записи удаляемого непися
		push	edx
		call	RELATION_REGISTRY__ClearRelations
		pop		edx
		; вызываем колбек, чтобы почистить из скриптов зависимые записи
;		CALLBACK__INT_INT	g_Actor, 146, edx, 0
		popa
	.endif
	; делаем вырезанное
	test	bl, bl
	mov		byte ptr [esi+84h], 0
	jmp		return_alife__release_callback
alife__release_callback endp

; колбек на изменение репутации
align_proc
RELATION_REGISTRY__SetGoodwill_callback proc
	;вырезанное
	mov		[eax], esi
	CALLBACK__INT_INT	g_Actor, 145, [ebp+8h], [ebp+0Ch]
;-----------------
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn	8
RELATION_REGISTRY__SetGoodwill_callback endp

; функция для удаления реестра отношений для объекта
align_proc
RELATION_REGISTRY__ClearRelations proc
person_id		= word ptr	4
	call	RELATION_REGISTRY__relation_registry ; CRelationRegistryWrapper * RELATION_REGISTRY::relation_registry()
	movzx	ecx, [esp+person_id]
	mov		eax, [eax+4]
	push	ecx				; id
	call	CALifeRegistryWrapper__objects_ptr ; CALifeRegistryWrapper<CALifeAbstractRegistry<ushort,RELATION_DATA>>::objects_ptr_no_insert(ushort)
	.if (eax)
		mov		edx, [eax]
		mov		ecx, eax
		mov		eax, [edx+4]
		call	eax
		; отладка
;		movzx	eax, [esp+person_id]
;		PRINT_UINT "RELATIONS CLEARED FOR OBJECT %d", eax
	.endif
	retn	4
RELATION_REGISTRY__ClearRelations endp

; функция для удаления записи отношений одного объекта к другому
align_proc
RELATION_REGISTRY__ClearPersonalRecord proc
rel_it			= dword ptr -8
_Where			= dword ptr -4
from			= word ptr  4
to				= word ptr  8
	sub		esp, 8
	push	esi
	call	RELATION_REGISTRY__relation_registry ; CRelationRegistryWrapper * RELATION_REGISTRY::relation_registry()
	movzx	ecx, [esp+0Ch+from] ; this
	mov		eax, [eax+4]
	push	ecx				; id
	call	CALifeRegistryWrapper__objects_ptr ; CALifeRegistryWrapper<CALifeAbstractRegistry<ushort,RELATION_DATA>>::objects_ptr(ushort)
	.if (eax)
		lea		esi, [eax+8]
		lea		ebx, [esp+0Ch+to] ; _Keyval
		lea		eax, [esp+0Ch+rel_it]
		mov		ecx, esi
		call	SRelation_map__find
		mov		eax, [esp+0Ch+rel_it]
		.if (eax!=[esi+4])
			push	eax
			lea		edx, [esp+10h+_Where]
			push	edx				; _Where
			push	esi				; result
			call	SRelation_map__erase
			; отладка
;			movzx	eax, [esp+0Ch+to]
;			PRINT_UINT "RELATION RECORD DELETED FOR OBJECT %d", eax
		.endif
	.endif
	pop		esi
	add		esp, 8
	retn	8
RELATION_REGISTRY__ClearPersonalRecord endp