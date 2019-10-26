;(class CScriptGameObject * target, float amount, struct _vector3<float> dir, class CScriptGameObject * who, short bone)

; ���������� ������� CActor::HitSignal
CActor_HitSignal_ext:
; ����� ��������� � ����� ������ ��������� �����, ��������� ���������� ���
; ������������ ���������� � �����:
perc   = dword ptr  08h
dir    = dword ptr  0Ch
who    = dword ptr  10h
elem   = dword ptr  14h

; ��������� ���
	push    ebp   ; +4
	mov     ebp, esp
	push    edi
	push    esi
	push    eax
	push    ebx
	push    ecx
	push    edx
	
	mov     esi, ecx ; this
; �������� ���������� ������ �� ���

; ��������� �������� � �����
	push    [ebp+elem]
	
	mov     edi, [ebp+who] ; who
	call    CGameObject__lua_game_object ; eax = who_go
	push    eax             ; who_go
	
	mov     eax, [ebp+dir]
	mov     ecx, [eax + 8h]
	push    ecx ; push dir_x
	mov     ecx, [eax + 4h]
	push    ecx ; push dir_y
	mov     ecx, [eax]
	push    ecx ; push dir_z
	
	push    [ebp+perc] ; perc
	
	mov     edi, esi
	call    CGameObject__lua_game_object ; target_go
	push    eax             ; target_go
	
	push    10h ; type = hit
	mov     ecx, esi ; ecx = this
	call    CGameObject__callback ; eax = hit_callback
	push    eax ; callback

	call    script_hit_callback

	pop     edx
	pop     ecx
	pop     ebx
	pop     eax
	pop     esi
	pop     edi
	pop     ebp
; ������ ��, ��� ��������
	sub     esp, 0Ch
	push    edi
	mov     edi, ecx
; ������������ �������
	jmp back_to_CActor_HitSignal

