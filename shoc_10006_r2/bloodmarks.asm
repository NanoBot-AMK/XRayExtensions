bloodmarks:
	test	ps_r2_ls_flags, 10000h
	jz		short bm_no
	mov		g_r, 1
	jmp		short bm_exit
bm_no:
	mov		g_r, 0
bm_exit:
	mov     edx, [ebx+500h]			; �������� ������� �������� ����� ������ ��-�� ���������
	jmp		back_to_bloodmarks