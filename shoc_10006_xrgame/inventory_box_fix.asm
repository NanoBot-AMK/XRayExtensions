
align_proc
inventory_box_fix proc
	; делаем то, что вырезали
	call	ds:CObject__setEnabled
	; вызываем колбек дл€ €шика
	CALLBACK__GO	ebx, eOnInvBoxPutItem, esi ; item
;---------------
	pop		edi
	pop		esi
	pop		ebx
	retn	8
inventory_box_fix endp
