; � ��� ����� ��������� ���� ������� - �� ����� �������� ����������� ��� ������ ������ �������
; !!! �� �������� ���������� ���������� �� ������ ������� ����� �� ����� ����������� �������� �� ��������� �����������

;edi - ��������� �� id ��������� ��������
CUIPdaWnd__SetActiveSubdialog_chunk proc
	push	edx
	push	ecx
	push	eax
	
	mov		eax, [edi]
	add		eax, 10h
	push	eax
	call	InventoryUtilities__SendInfoToActor
	add     esp, 4
	
	pop		eax
	pop		ecx
	pop		edx
	
	cmp     eax, [edi]
	jnz     CUIPdaWnd__SetActiveSubdialog_1
	pop     edi
	pop     esi
	retn    4
CUIPdaWnd__SetActiveSubdialog_chunk endp


;CUIPdaWnd__Show_ex proc
	
;	jmp		back_from_CUIPdaWnd__Show_ex
;CUIPdaWnd__Show_ex endp
