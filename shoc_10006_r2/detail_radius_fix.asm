;=====================================================
;== ���������� ����������� ��������� =================
;=====================================================
calculate_stuff:
	push	eax
	push	ebx
	push	edi
	push	esi
	mov		eax, det_rad_value
;rad
	mov		rad, eax		; eax = 49, ebx = ???, edi = ???, esi = ???, 
	mov 	ebx, eax		; eax = 49, ebx = 49, edi = ???, esi = ???, 
;rad_dec
	sub 	ebx, 1			; eax = 49, ebx = 48, edi = ???, esi = ???, 
	mov 	rad_dec, ebx
;sq_rad
	mov		edi, eax		; eax = 49, ebx = 48, edi = 49, esi = ???, 
	imul	eax, edi		; eax = 2401, ebx = 48, edi = 49, esi = ???, 
	mov		sq_rad, eax
;sq_rad_dec
	sub		eax, 1			; eax = 2400, ebx = 48, edi = 49, esi = ???, 
	mov		sq_rad_dec, eax
;det_lev1_size
	mov		esi, ebx		; eax = 2400, ebx = 48, edi = 49, esi = 48, 
	shr		ebx, 2			; eax = 2400, ebx = 12, edi = 49, esi = 48, 
	mov		det_lev1_size, ebx
;sq_det_lev1_size_dec
	mov 	eax, ebx		; eax = 12, ebx = 12, edi = 49, esi = 48, 
	imul	eax, ebx		; eax = 144, ebx = 12, edi = 49, esi = 48, 
	sub		eax, 1			; eax = 143, ebx = 12, edi = 49, esi = 48, 
	mov		sq_det_lev1_size_dec, eax
;lev1_size_line
	mov		eax, edi		; eax = 49, ebx = 12, edi = 49, esi = 48, 
	imul	eax, 4			; eax = 196, ebx = 12, edi = 49, esi = 48, 
	mov		lev1_size_line, eax
;lev1_size_line_dec
	sub		eax, 4			; eax = 192, ebx = 12, edi = 49, esi = 48, 
	mov		lev1_size_line_dec, eax
;act_pos	
	shl		ebx, 1			; eax = 192, ebx = 24, edi = 49, esi = 48, 
	mov		act_pos, ebx
;four_lines_length_in_cache
	add		eax, 4			; eax = 196, ebx = 24, edi = 49, esi = 48, 
	shl		eax, 2			; eax = 784, ebx = 24, edi = 49, esi = 48, 
	mov		four_lines_length_in_cache, eax
;cache_size_w_o_last_line
	imul	edi, esi		; eax = 784, ebx = 24, edi = 2352, esi = 48, 
	shl		edi, 2			; eax = 784, ebx = 24, edi = 9408, esi = 48, 
	mov		cache_size_w_o_last_line, edi
	
;============== ��������� ��������� "����������" ======	
	finit
	fild 	[rad]				;st0 = 49
	fld 	[def_vis_gist]		;st1 = 49, st0 = -1.5
	fadd						;st0 = 47.5 
	fst		[visibility]
	fld 	[visibility]		;st1 = 47.5, st0 = 47.5 
	fmul						;st0 = 2256.25
	fst 	[visibility]
	fild 	[dumb_const]		;st0 = 1, st1 = 2256.25
	fsub	ST(1),ST			;st0 = 1, st1 = 2255.25
	fdivr						;st0 = 0.000443
	fst		[smooth_circle]		
	
; ������ ���� ����������� ����� �������� ��� ������ ������
; 1) �������� cache_level1 ������� �� cache_level1_offset = def_class_mem + current_offset
; 2) �������� cache ���������� �� cache_offset = def_class_mem + 124 * det_lev1_size* det_lev1_siz;
; 3) �������� cache_task ���������� �� cache_task_offset = cache_offset + 4 * rad * rad;
; 4) �������� cache_pool ���������� �� cache_pool_offset = cache_task_offset + 4 * rad * rad;
		
;============== ��������� ����� ������� �������� ======
;cache_level1_size																				124 * det_lev1_size* det_lev1_size
	mov 	eax, ds:[det_lev1_size]		; eax = 12, ebx = 24, edi = 9408, esi = 48, 
	mov		ebx, eax					; eax = 12, ebx = 12, edi = 9408, esi = 48, 
	imul	eax, ebx					; eax = 144, ebx = 12, edi = 9408, esi = 48, 
	imul	eax, 7Ch					; eax = 4B80h, ebx = 12, edi = 9408, esi = 48,
	mov		cache_level1_size, eax
;cache_size, c_task_size																		4 * rad * rad
	mov 	eax, ds:[rad]				; eax = 49 ebx = 12, edi = 9408, esi = 48,
	mov		ebx, eax					; eax = 49 ebx = 49, edi = 9408, esi = 48,
	imul	eax, ebx					; eax = 2401 ebx = 49, edi = 9408, esi = 48,
	mov		edi, eax					; eax = 2401 ebx = 49, edi = 2401, esi = 48,
	shl		eax, 2						; eax = 2584h, ebx = 49, edi = 2401, esi = 48,
	mov		cache_size, eax
	mov		c_task_size, eax
;cache_pool_size																				340 * rad * rad
	imul	edi, 154h					; eax = 2584h, ebx = 49, edi = 0C74D4h, esi = 48,
	mov		c_pool_size, edi
	
;============== ��������� �������� ��������� ======
;0x5C0	- ������ ������� cache_level1 = def_class_mem
;0x4B80 - ������ ������� cache
;0x4B88 - ������ ������� cache
;0x4C40 - ��������� ������� ������ ������ cache
;0x7040 - ������ ������� ��������� ������ cache
;0x7104 - ������ ������� cache_task
;0x7108 - ������ ������� cache_task
;0x9688 - ��������� ���� � cache_task (count)
;0x968C - ������ ������� cache_pool

;cache_level1_offset						0x5C0
	mov		esi, [def_class_mem]		; eax = 2584h, ebx = 49, edi = 0C74D4h, esi = 0D0BB8h,
	mov		cache_level1_offset, esi	   ;0xD0BB8
;cache_first_el_offset						0x4B80h
	add		esi, [cache_level1_size]
	mov		cache_first_el_offset, esi	   ;0xD5178
;cache_third_el_offset						0x4B88
	add		esi, 8
	mov		cache_third_el_offset, esi	   ;0xD5180
;cache_last_el_first_line_offset			0x4C40
	mov		esi, [cache_first_el_offset]
	add		esi, [lev1_size_line_dec]
	mov		cache_last_el_first_line_offset, esi	   ;0xD5178+0C0h = 0xD5238
;cache_first_el_last_line_offset			0x7040
	mov		esi, [lev1_size_line]			
	imul	esi, [rad_dec]
	add		esi, [cache_first_el_offset]
	mov		cache_first_el_last_line_offset, esi		;0xD5178+0x24C0 = D7638
;cache_task_first_offset					0x7104
	mov		esi, [cache_first_el_offset]	
	add		esi, [cache_size]
	mov		cache_task_first_offset, esi	;0xD5178 + 2584h = 0xD76FC
;cache_task_second_offset					;0x7108
	add		esi, 4
	mov		cache_task_second_offset, esi	;0xD7700
;cache_task_last_offset						0x9688
	mov		esi, [cache_task_first_offset]
	add		esi, [c_task_size]
	mov		cache_task_last_offset, esi		;0xD76FC + 2584h = D9C80
;cache_pool_offset							;0x968C
	add		esi, 4	
	mov		cache_pool_offset, esi			;0xD9C84
	
;============== ��������� ������ ��� ����� ======
;class_mem
	add		esi, ds:[c_pool_size]
	mov		class_mem, esi
	pop 	esi	
	pop 	edi	
	pop 	ebx
	pop 	eax
	push 	class_mem
	jmp back_to_calculate_stuff
	
def_class_mem	dd 0D0BB8h
def_cl1_size	dd 45C0h
def_cache_size	dd 2584h
def_c_task_size	dd 2584h
def_c_pool_size	dd 0C74D4h
def_vis_gist	dd -1.5
dumb_const dd 1

;=====================================================
;== �������� ��� ��������� �� ���� ���������� ========
;=====================================================

;----------------------
;������ ��������� � 31h
;----------------------
cache_initialize_1: 
	add edi, 154h
	cmp esi, ds:[rad]
	jmp back_to_cache_initialize_1
	
cache_initialize_2: 
	add ebp, 1
	cmp ebp, ds:[rad]
	jmp back_to_cache_initialize_2

cache_update_1: 
	push eax
	mov eax, ds:[lev1_size_line]
	add dword ptr [esp+24h+iteration], eax
	pop eax
	add eax, 1
	cmp eax, ds:[rad]
	jmp back_to_cache_update_1	
	
cache_update_2: 
	add esi, ds:[lev1_size_line]
	cmp eax, ds:[rad]
	jmp back_to_cache_update_2	
	
cache_update_3: 
	add esi, 4
	cmp eax, ds:[rad]
	jmp back_to_cache_update_3	
	
cache_update_4: 
	add esi, 4
	cmp eax, ds:[rad]
	jmp back_to_cache_update_4

;----------------------
;������ ��������� � 30h
;----------------------
	
update_30h_1:
	mov ecx, ds:[rad_dec]
	jmp back_to_update_30h_1	
		
update_30h_2:
	mov ecx, ds:[rad_dec]
	push edx
	add edx, ds:[lev1_size_line_dec]
	mov [edx], eax
	pop edx
	jmp back_to_update_30h_2
		
update_30h_3:
	mov ecx, ds:[rad_dec]
	jmp back_to_update_30h_3
		
update_30h_4:
	mov ecx, ds:[rad_dec]
	jmp back_to_update_30h_4
		
update_30h_5:
	mov ecx, ds:[rad_dec]
	jmp back_to_update_30h_5
	
update_30h_6: 
	push ds:[rad_dec]
	push ebx
	add	esi, [cache_size_w_o_last_line]
	mov [esi], edi
	sub esi, [cache_size_w_o_last_line]
	jmp back_to_update_30h_6	
	
;----------------------
;������ ��������� � 0�h
;----------------------	
	
cache_upvism_1: 
	add esi, 1
	cmp esi, ds:[det_lev1_size]
	jmp back_to_cache_upvism_1	
	
cache_upvism_2: 
	add ebx, 1
	cmp ebx, ds:[det_lev1_size]
	jmp back_to_cache_upvism_2	

; � ��������� ���� ����� ����������� �������� ��������� ��� �������� � ����� ������ � cache_level1.
; �������� ����� ������ �� ������� �������� cache_level1, � ��������� ���������� ����� ������������:
; lea edi, [ebx+ebx*2]
; add edi, edi
; add edi, edi
; ��� ��� �� ����� ������ ������� �������� cache_level1, ������������.

cache_upvism_3:
	lea edi, [ebx]
	xor esi, esi
	imul edi, ds:[det_lev1_size]
	jmp back_to_cache_upvism_3		
	
;.text:10023D8D                 lea     edi, [eax+4B88h]	
;.text:10023D93                 lea     esi, [eax+600h]
;.text:10023D99                 mov     [esp+14h+this], edi
;.text:10023D9D                 mov     [esp+14h+var_4], 0Ch
cache_init_4: 
	push eax
	add eax, ds:[cache_third_el_offset]
	lea edi, [eax]
	pop eax
	push eax
	add eax, ds:[cache_level1_offset]
	lea esi, [eax+40h]
	mov dword ptr [esp+18h+4h], edi
	mov eax, ds:[det_lev1_size]
	mov dword ptr [esp+18h+var_4], eax
	pop eax
	jmp back_to_cache_init_4
	
cache_init_5: 
	mov ebx, ds:[det_lev1_size]
	jmp back_to_cache_init_5
	
;.text:10024420                 lea     esi, [ebx+5E8h]
;.text:10024426                 mov     [esp+24h+z], 0Ch
;.text:1002442E                 mov     [esp+24h+iteration], 0Ch	
cache_upd_6: 
	push ebx
	add ebx, ds:[cache_level1_offset]
	lea esi, [ebx+28h]
	pop ebx
	push eax
	mov eax, ds:[det_lev1_size]
	mov dword ptr [esp+28h+z], eax
	mov dword ptr [esp+28h+iteration], eax
	pop eax
	jmp back_to_cache_upd_6	
	
cache_upd_7: 
	push eax
	mov eax, ds:[det_lev1_size]
	mov dword ptr [esp+28h+iteration], eax
	pop eax
	jmp back_to_cache_upd_7	

;----------------------
;������ ��������� � 0�4h
;----------------------	
	
cache_init_C4_1: 
	add eax, ds:[lev1_size_line]
	jmp back_to_cache_init_C4_1	
	
cache_upd_C4_2: 
	sub eax, ds:[lev1_size_line]
	mov edx, [eax]
	add eax, ds:[lev1_size_line]
	mov [eax], edx
	sub ecx, 1
	sub eax, ds:[lev1_size_line]
	jmp back_to_cache_upd_C4_2		
	
cache_upd_C4_3: 
	add eax, ds:[lev1_size_line]
	mov edx, [eax]
	sub eax, ds:[lev1_size_line]
	mov [eax], edx
	add eax, ds:[lev1_size_line]
	jmp back_to_cache_upd_C4_3			

;----------------------
;������ ��������� � 960h
;----------------------	
		
const_960_1: 
	push esi
	add esi, ds:[cache_task_last_offset]			;��� �� �������� � 960h, �������� ������ � �������� cache_pool � cache_task.count
	mov [esi], edi
	lea ebx, [esi+4]
	pop esi
	mov ebp, ds:[sq_rad_dec]
	jmp back_to_const_960_1		
	
;.text:100224E1                 mov     ebp, 960h
;.text:100224E6                 lea     edi, [esi+0D0BA4h]
const_960_2: 
	mov ebp, ds:[sq_rad_dec]
	push esi
	add esi, ds:[class_mem]
	lea edi, [esi+44h]
	pop esi
	jmp back_to_const_960_2		

;----------------------
;������
;----------------------	
		
;.text:1002223F                 lea     ecx, [this+5C0h]		this = esi
;.text:10022245                 mov     edx, 8Fh
cache_level1_length: 
	push esi
	add esi, ds:[cache_level1_offset]
	lea ecx, [esi]
	pop esi
	mov edx, ds:[sq_det_lev1_size_dec]
	jmp back_to_cache_level1_length		
		
red_cl1_line_size_minus: 
	sub esi, lev1_size_line_dec
	mov [esi], edi
	add esi, lev1_size_line_dec
	jmp back_to_red_cl1_line_size_minus					
		
cache_size_w_o_last_line_minus: 
	sub esi, cache_size_w_o_last_line
	mov [esi], edi
	add esi, cache_size_w_o_last_line
	jmp back_to_cache_size_w_o_last_line_minus		
		
cache_length: 
;.text:100242A6                 mov     eax, [ebx+9688h]
	push ebx
	add ebx, ds:[cache_task_last_offset]
	mov eax, [ebx]
	pop ebx
	xor ecx, ecx
	cmp eax, ds:[sq_rad]
	jmp back_to_cache_length	
		
four_lines_length: 
	add edi, ds:[four_lines_length_in_cache]
	jmp back_to_four_lines_length	

vis: 
	comiss xmm0, ds:[visibility]
	jmp back_to_vis	

circle: 
	mulss xmm1, ds:[smooth_circle]
	jmp back_to_circle	
	
;----------------------
;���� �������� ������ ������
;----------------------
;.text:10023D57                 lea     edi, [eax+968Ch] ; D
;.text:10023D5D                 lea     ebx, [eax+4B80h]
offset_1:
	push eax
	add eax, ds:[cache_pool_offset]
	lea edi, [eax]
	pop eax
	push eax
	add eax, ds:[cache_first_el_offset]
	lea ebx, [eax]	
	pop eax
	jmp back_to_offset_1	

;.text:10024077                 mov     gx, [esi+9688h]			gx = ecx
;.text:1002407D                 mov     [esi+gx*4+7104h], D		D = edi
;.text:10024084                 add     [esi+9688h], eax
offset_3:
	push ebx
	push esi
	mov ebx, esi
	add esi, ds:[cache_task_last_offset]
	add ebx, ds:[cache_task_first_offset]
	mov ecx, [esi]
	mov [ebx+ecx*4], edi
	add [esi], eax
	pop esi
	pop ebx
	jmp back_to_offset_3
	
;.text:100240FE                 lea     edx, [ebx+4B80h]
offset_4:
	push ebx
	add ebx, ds:[cache_first_el_offset]
	lea edx, [ebx]
	pop ebx
	jmp back_to_offset_4	
	
;.text:1002416B                 lea     esi, [ebx+4C40h]
offset_5:
	push ebx
	add ebx, ds:[cache_last_el_first_line_offset]
	lea esi, [ebx]
	pop ebx
	jmp back_to_offset_5	
	
;.text:100241F2                 lea     esi, [ebx+7040h]
offset_6:
	push ebx
	add ebx, ds:[cache_first_el_last_line_offset]
	lea esi, [ebx]
	pop ebx
	jmp back_to_offset_6
	
;.text:10024245                 lea     esi, [ebx+4B80h]
offset_7:
	push ebx
	add ebx, ds:[cache_first_el_offset]
	lea esi, [ebx]
	pop ebx
	jmp back_to_offset_7
	
;.text:100242F6                 mov     esi, [ebx+9688h]
offset_8:
	push ebx
	add ebx, ds:[cache_task_last_offset]
	mov esi, [ebx]
	pop ebx
	jmp back_to_offset_8
	
;.text:10024306                 cmp     [ebx+9688h], ecx
offset_9:
	push ebx
	add ebx, ds:[cache_task_last_offset]
	cmp [ebx], ecx
	pop ebx
	jmp back_to_offset_9

;.text:10024323                 mov     edi, [ebx+9688h]
;.text:10024329                 movss   [esp+20h+var_4], xmm0
;.text:1002432F                 lea     edx, [ebx+7104h]
offset_10:
	push ebx
	add ebx, ds:[cache_task_last_offset]
	mov edi, [ebx]
	pop ebx
	movss   dword ptr [esp+20h+var_4], xmm0
	push ebx
	add ebx, ds:[cache_task_first_offset]
	lea edx, [ebx]
	pop ebx	
	jmp back_to_offset_10
	
;.text:100243BD                 mov     edx, [ebx+esi*4+7104h]
offset_11:
	push ebx
	add ebx, ds:[cache_task_first_offset]
	mov edx, [ebx+esi*4]
	pop ebx
	jmp back_to_offset_11
	
;.text:100243CB                 add     dword ptr [ebx+9688h], 0FFFFFFFFh
;.text:100243D2                 mov     ecx, [ebx+9688h]
offset_12:
	push ebx
	add ebx, ds:[cache_task_last_offset]
	add dword ptr [ebx], 0FFFFFFFFh
	mov ecx, [ebx]
	pop ebx
	jmp back_to_offset_12
	
;.text:100243E0                 mov     ecx, [ebx+this*4+7108h]			this = eax
;.text:100243E7                 mov     [ebx+this*4+7104h], ecx
;.text:100243EE                 add     this, 1
;.text:100243F1                 cmp     this, [ebx+9688h]
offset_13:
	push ebx
	add ebx, ds:[cache_task_second_offset]
	mov	ecx, [ebx+eax*4]
	mov [ebx+eax*4-4], ecx
	add eax, 1
	pop ebx
	push ebx
	add ebx, ds:[cache_task_last_offset]
	cmp eax, [ebx]
	pop ebx
	jmp back_to_offset_13
	
;.text:100243FE                 cmp     dword ptr [ebx+9688h], 0
offset_14:
	push ebx
	add ebx, ds:[cache_task_last_offset]
	cmp dword ptr [ebx], 0
	pop ebx
	jmp back_to_offset_14
	
;.text:10022A76                 cmp     dword ptr [ecx+ebp+5C0h], 0
;.text:10022A7E                 lea     eax, [ecx+ebp+5C0h]	
offset_15:
	push ecx
	add ecx, ds:[cache_level1_offset]
	cmp dword ptr [ecx+ebp], 0
	lea eax, [ecx+ebp]
	pop ecx
	jmp back_to_offset_15
	
;----------------------
;������ ��������� � 18h
;----------------------		
	
cache_task_1: 
	add ebx, ds:[act_pos]
	add eax, ecx
	sub eax, ds:[act_pos]
	lea ebp, [eax]
	jmp back_to_cache_task_1
	
var_4           = dword ptr  -4h
iteration       = dword ptr  -0Ch
z          		= dword ptr  -10h