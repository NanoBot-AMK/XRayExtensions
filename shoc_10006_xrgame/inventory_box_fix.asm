
align_proc
inventory_box_fix proc
	; ������ ��, ��� ��������
	call	ds:CObject__setEnabled
	; �������� ������ ��� �����
	CALLBACK__GO	ebx, eOnInvBoxPutItem, esi ; item
;---------------
	pop		edi
	pop		esi
	pop		ebx
	retn	8
inventory_box_fix endp
