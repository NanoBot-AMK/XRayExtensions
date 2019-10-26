; ���������� ������� CActor::HitSignal
CActor_HitSignal_ext:
; ����� ��������� � ����� ������ ��������� �����, ��������� ���������� ���
; ������������ ���������� � �����:
;perc            = dword ptr  4
;vLocalDir       = dword ptr  8
;who             = dword ptr  0Ch
;element         = dword ptr  10h

; ��������� ���
	push    ebp   ; +4
	mov     ebp, esp
	push    edi
	mov     edi, ecx ; this
	push    ecx
; �������� ���������� ������ �� ���
;callback(GameObject::eHit)(
;		this->lua_game_object(), 
;		amount,
;		vLocalDir,
;		who->lua_game_object(),
;		element);
	;jmp l1
	mov     ecx, dword ptr [ebp+4h+10h]
	push    ecx ; push element
	mov     ecx, dword ptr [ebp+4h+0Ch]
	call    CGameObject__lua_game_object
	push    eax ; push who.game_object
	mov     eax, dword ptr [ebp+4h+08h]
	mov     ecx, [eax + 8h]
	push    ecx ; push dir_x
	mov     ecx, [eax + 4h]
	push    ecx ; push dir_y
	mov     ecx, [eax]
	push    ecx ; push dir_z
	mov     eax, [ebp+4h+4h] ; perc
    push    eax
	
	mov     ecx, edi ; ecx = this
	call    CGameObject__lua_game_object ; CGameObject__lua_game_object
	push    eax ; push this.game_object
l1:

	push    10h ; push 16
	mov     ecx, edi ; ecx = this
	call    CGameObject__callback ; eax = hit_callback
	mov     ecx, eax ; ecx = hit_callback
	
	call    script_hit_callback
	; ----
	pop     ecx
	pop     edi
	pop     ebp
; ������ ��, ��� ��������
	xorps   xmm5, xmm5	
	sub     esp, 0Ch
; ������������ �������
	jmp back_to_CActor_HitSignal

hit_message db "actor get hit", 0
