include CSE_Abstract_fix_macro.asm

CSE_ABSTRACT_REGISTER_FVECTOR_RW_PROP register_cse_abstract_angle, "angle", 064h

CSE_Abstract__script_register_fix proc
	; ������ ����������
	call    cse_abstract__register_position
	; ��������� ���
	push    eax
	call    register_cse_abstract_angle
	; ��� �������
	jmp back_from_CSE_Abstract__script_register_fix
CSE_Abstract__script_register_fix endp









