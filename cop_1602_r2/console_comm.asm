con_comm:

REGISTER_CC_INT det_rad_value, "r__detail_radius", 31h, 1F5h

	; ������ ����������
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	add		esp, 18h
	retn

; ��������� �������� ���������� (int)
det_rad_value dd 31h