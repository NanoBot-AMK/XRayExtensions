; int this<eax>, int item<ebx>
CUITradeWnd__CanMoveToOther_fix proc
	; ������ ���
	; ��������� ���������� ������
	push    eax
	mov     eax, [g_trade_filtration_active]
	test    eax, eax
	pop     eax
	jz      no_filtration
	; ��������� ������ ����� ��������� �������� ��������
	push    eax
	push    ebx
	;mov     eax, [ebx]      ; item
	mov     eax, [ebx+132] ; ������ ��������
	and     eax, 01000h
	pop     ebx
	pop     eax
	jz      no_explicit_enable
	mov     eax, 1
	retn
no_explicit_enable:
	; ��������� ������ ������ ������� �������� ��������
	push    eax
	push    ebx
	mov     eax, [ebx+132] ; ������ ��������
	and     eax, 02000h
	pop     ebx
	pop     eax
	jz      no_explicit_disable
	xor     eax, eax
	retn
no_explicit_disable:
;
no_filtration:
	; ������ ��, ��� ��������
	sub     esp, 1Ch
	push    esi
	mov     esi, eax
	mov     eax, [esi+5Ch]
	; ��� �������
	jmp     back_from_CUITradeWnd__CanMoveToOther_fix
CUITradeWnd__CanMoveToOther_fix endp

; ������ ��������� ���������:
; 1. ���� do_colorize == 0, ������ ������� �� � ��������� ������, �� ������������
; 2. ���� ������� �� �������� �� ���������� ������� CUITradeWnd__CanMoveToOther,
;    ��� �������� ����� � ������ �� ���������, �� ��������� ���������� ������ � �������� 0 �� �������
; 3. ���� ������ ������ ���������� ���������� �������� � ��� �������� ������� ��� ���������
;    ������ ��������� ��������, �� ������������ ������ �� ���� ���� ����� �� ������
;    ��������� �� ������� ���� � ��������� ��
CUITradeWnd__FillList_fix proc
this_           = dword ptr  4
do_colorize     = byte ptr  0Ch
	; ������, ��� ��������
	mov     edi, eax
	mov     ebx, [esi]      ; a2
	; ��������� ��������� �������� �������, ����� �� ����������� ������� � ��������
	cmp     [esp+10h+do_colorize], 0 ; z set if do_colorize == 0
	jz     no_colorization
	;
	;mov     eax, [ebx+132] ; ������ ��������
	;test    eax, 01000h ; always_tradable
	;jnz     no_colorization ; ����������� ������, �� ������������� ����
	; ����� ��������� ��������� ���������
	mov     eax, [esp+10h+this_] ; this
	call    CUITradeWnd__CanMoveToOther
	test    al, al
	jnz     check_manual_colorization ; al == 1, ����� ���������, ��� ��������� ��������� ���������
	; � ����� ������ � ���� � �������� 0 (������ �������)
	mov     eax, [g_highlight_colors]
	push    eax
	jmp     manual_color_defined
check_manual_colorization:
	; ���������, ��� ����������� ���������� ����� ������������� ������ ���������
	cmp     [g_manual_highlignt_active], 1 ; z set if g_manual_highlignt_active == 1
	jnz     no_colorization ; ������ �� ����������, ��������� ���������� ��� ���������, �� �� ������������ �����
	; �������� ���� ������ ���������
	mov     eax, [ebx+132] ; ������ ��������
	test    eax, 08000h ; ���������������� ii ������ "manual_highlighting"
	jz      no_colorization ; ������ �� ����������, ��������� ���������� ��� ���������, �� �� ������������ �����
	; ������ ���������� ������� ��������� ������, ������ �������� �������� � 4-� ����� �� �������� 134
	push    esi
	mov     esi, [ebx+134]
	and     esi, 0Fh
	mov     eax, [g_highlight_colors + esi*4]
	pop     esi
	push    eax
manual_color_defined:
	mov     eax, [edi]
	mov     edx, [eax+90h]
	mov     ecx, edi
	call    edx ; SetColor
no_colorization:
	; ��� �������
	jmp     back_from_CUITradeWnd__FillList_fix
CUITradeWnd__FillList_fix endp
