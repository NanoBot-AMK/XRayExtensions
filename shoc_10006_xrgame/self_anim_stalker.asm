;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;				����������� ����� ��������� �������� ��� ������ CAI_Stalker
;;;					��������� ������� ��� �������� �� ����� ������.
;;; ������� ��� �������� �� ������ CAI_Stalker ��������� �������, ����� ����� �� ����� 1098,
;;; ��� ������ ����� �������� � �������� � �������������� ����������. 
;;; �������� ������ ������������� � ��������, ����� ������� ���. � ��� ������ ��� ��������
;;; ����������� �������, � ���� �������� ��� �������� - 663. ���� ��� ����� ����������
;;; ������ ����� ������ �� ������ ��������, �� �� �� ����������� ������ �������, �� �������
;;; ������� ��� ���� ������ ����� ����������� ������ ��������, ��� ����� ��������, ���� 
;;; ���� ������������ ���������. � ���� ������� ���������� ����������� �������� �����
;;; ���� ��������� �� ���� ��������. ��� � �������� �������� ��������: �����, �����, �����,
;;; ������ � �.�. ���� ��������� ������������ ��������, ���: death_init, waunded_1_idle_0
;;; � $editor ��� ���.
;;; 
;;;													������:				18.09.2016
;;;	 (�) �������									������� ���������:	07.10.2018	14:00
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;---------- CKinematics -------------
pUserData				= dword ptr 128		; CInifile*
bone_instances			= dword ptr 132		; CBoneInstance*	//bone instances	

;- NEW -
m_anim_flags			= byte	ptr 142		; Flags8
flNoPrefix				equ 1
flPrintNameAnim			equ 2
flPrintAnimPlay			equ 4
flAbortIfNoAnim			equ 8
flPrintIfNoAnim			equ 16

;-------
invalidate				equ -1
;------------------------------------

Load_anim_from_file MACRO	user_data:req, tab_name:req, i:req, res:req
	xor		eax, eax
	mov		min_count_anims, eax
	.if (user_data)
		push	offset tab_name
		mov		ecx, user_data
		call	ds:section_exist
		.if (eax)
			lea		eax, line_name_i_
			push	10				; int
			push	eax				; char *
			push	i				; int
			call	ds:_itoa
			add		esp, 12
			push	offset line_name_i_
			push	offset tab_name
			mov		ecx, user_data
			call	CScriptIniFile__r_string_wb
			mov		res, eax
			; Msg("Load: '%s': %s = '%s'", tab_name, line_name_i_, res);
			;lea		ecx, line_name_i_
			;lea		edx, tab_name
			;PRINT_INT_INT_INT "Load: '%s': %s = '%s'", edx, ecx, eax
		.endif
	.endif
ENDM

Load_anim_from_file2 MACRO	user_data:req, tab_name:req, i:req, res:req, tab_count_name:req
	xor		eax, eax
	mov		min_count_anims, eax
	.if (user_data)
		push	offset tab_name
		mov		ecx, user_data
		call	ds:section_exist
		.if (eax)
			lea		eax, line_name_i_
			push	10				; int
			push	eax				; char *
			push	i				; int
			call	ds:_itoa
			add		esp, 12
			push	offset line_name_i_
			push	offset tab_name
			mov		ecx, user_data
			call	CScriptIniFile__r_string_wb
			mov		res, eax
			; Msg("Load: '%s': %s = '%s'", tab_name, line_name_i_, res);
			;lea		ecx, line_name_i_
			;lea		edx, tab_name
			;PRINT_INT_INT_INT "Load: '%s': %s = '%s'", edx, ecx, eax
			mov		eax, [tab_count_name+i*4]
			mov		min_count_anims, eax
		.endif
	.endif
ENDM

PRINT_INT_INT_INT MACRO fmt_txt:REQ, val1:REQ, val2:REQ, val3:REQ
	pusha
	push	val3
	push	val2
	push	val1
	push	const_static_str$(fmt_txt)
	call	Msg
	add		esp, 16
	popa
ENDM

;-------------------
const_static_str		aAnim_params	, "anim_params"
const_static_str		aNo_prefix		, "no_prefix"
const_static_str		aPrint_anim_l	, "print_anim_load"

const_static_str		aState_name		, "tbl_state_names"
const_static_str		aWeapon_name	, "tbl_weapon_names"
const_static_str		aWeapon_acti	, "tbl_weapon_action_names"
const_static_str		aMovement_na	, "tbl_movement_names"
const_static_str		aMovement_ac	, "tbl_movement_action_names"
const_static_str		aIn_place_na	, "tbl_in_place_names"
const_static_str		aGlobal_name	, "tbl_global_names"
const_static_str		aHead_names		, "tbl_head_names"
										;	0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
_static			count_weapon_action_names	dd 	1, 4, 1, 1, 3, 0, 4, 2, 2, 2, 0, 2, 4, 2, 2, -1
_static			count_global_names			dd 	0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, -1
_static			count_movement_action_names dd 	2, 1, 1, 1, -1

_static			line_name_i_		dd 0, 0
_static			min_count_anims		dd 0
_static			aNull				db 0

align_proc
load_anim_params proc
; ebp - kinematics*		CKinematics
	push	esi
	ASSUME	ebp:ptr CKinematics
	mov		[ebp].m_anim_flags, 0
	mov		esi, [ebp].pUserData
	.if (esi)
		push	offset aAnim_params
		mov		ecx, esi
		call	ds:section_exist
		.if (eax)
			push	offset aNo_prefix
			push	offset aAnim_params
			mov		ecx, esi
			call	ds:r_bool
			.if (eax)
				or		[ebp].m_anim_flags, flNoPrefix
			.endif
			push	offset aPrint_anim_l
			push	offset aAnim_params
			mov		ecx, esi
			call	ds:r_bool
			.if (eax)
				or		[ebp].m_anim_flags, flPrintNameAnim
			.endif
		.endif
	.endif
	ASSUME	ebp:nothing
	PRINT "load_anim_params"
	pop		esi
	; ���������	
	xor		eax, eax
	mov		[esi+4], eax
	mov		[esi+8], eax
	jmp		return_load_anim_params
load_anim_params endp


; ���� � ������ [anim_params] ������� no_prefix, �� ������� "torso_" ���������� �� ������ ������ ""
align_proc
Load_str__torso__ proc
; edi - CKinematics
	.if ([edi].CKinematics.m_anim_flags & flNoPrefix)
		; ��������� ������ ������ "" � ������������� push	 offset aTorso_	 ; "torso_"
		; ���������
		mov		edx, 256
		push	offset aNull
		jmp		return_Load_str__torso__2
	.endif
	; ���������		
	mov		edx, 256
	jmp		return_Load_str__torso__
Load_str__torso__ endp

DEGUB_PRINT_ANIM_NAME MACRO reg_kinematics:req, anim_name:req
	.if ([reg_kinematics].m_anim_flags & flPrintNameAnim)
		lea		ecx, anim_name
		PRINT_UINT "Loaded animation: '%s'", ecx
	.endif
ENDM

; CAniFVector::Load
; � ���� ������ ����������� � ������� ����� �������� (MotionID) �� ����� ������, � ����� caBaseName
; ������������ ����� �� 0 �� 10, ���� �� �����, �� �������� ��������� ���������.
; ������������� ��������� � ������� ������� ����������� ���������� ���������� ��������! 
; ��� �� ��������� � ����������(-1) ��������.
align_proc
Load_anim_num_prefix proc
; ax - MotionID		// �����_�������_���������
S1						= byte ptr -204h
tpMotionDef				= word	ptr -210h
motion_default			= word	ptr -20Eh
i						= dword ptr -20Ch
tpKinematics			= dword ptr	 8
;------------------------
	; ���������
	mov		ax, [eax]
	;----------
	.if ([esp+21Ch+i] == 0)
		mov		[esp+21Ch+motion_default], ax		; ���������� ������� ��������
		mov		esi, [esp+21Ch+tpKinematics]
		ASSUME	esi:ptr CKinematics
		.if ([esi].m_anim_flags & flPrintNameAnim)
			movzx	eax, ax
			PRINT_UINT "motion_default: %d", eax
		.endif
	.endif
	.if (ax != invalidate)
		mov		esi, [esp+21Ch+tpKinematics]
		DEGUB_PRINT_ANIM_NAME esi, [esp+21Ch+S1]
	.endif
	; ���������
	cmp		ax, -1
	mov		[esp+21Ch+tpMotionDef], ax
	jmp		return_Load_anim_num_prefix
Load_anim_num_prefix endp

align_proc
Load_anim_num_prefix2 proc
; ax - MotionID		// �����_�������_���������
S1						= byte	ptr -204h
tpMotionDef				= word	ptr -210h
motion_default			= word	ptr -20Eh
i						= dword ptr -20Ch
tpKinematics			= dword ptr	 8
_A						= dword ptr	 4			; ANIM_VECTOR	CAniVector::A
	;;;mov		al, [esi+m_min_count_num_anims]
	mov		eax, min_count_anims
	.if (eax > [esp+21Ch+i])
		; A.push_back(motion_default);
		mov		esi, [esp+21Ch+_A]
		lea		edx, [esp+21Ch+motion_default]
		call	vector_motionID__push_back
		mov		esi, [esp+21Ch+tpKinematics]
		.if ([esi].m_anim_flags & flPrintNameAnim)
			mov		ecx, [esp+21Ch+i]
			PRINT_UINT "load motion_default: i - %d", ecx
		.endif
		ASSUME	esi:nothing
	.endif
	; ���������
	cmp		[esp+21Ch+i], 10
	jmp		return_Load_anim_num_prefix2
Load_anim_num_prefix2 endp

; ���� �������� ����������(=0FFFFh), �� � �� ������.
align_proc
CStalkerAnimationPair__play_impl proc
; ecx - CStalkerAnimationPair
	ASSUME	ecx:ptr CStalkerAnimationPair
	.if ([ecx].m_animation != invalidate)
		jmp		CStalkerAnimationPair__play
	.endif
	mov		[ecx].m_actual, false
	ASSUME	ecx:nothing
	retn	16
CStalkerAnimationPair__play_impl endp
align_proc
CStalkerAnimationManager__play_global_impl_CHUNK proc
; edi - CStalkerAnimationPair
	ASSUME	edi:ptr CStalkerAnimationPair
	.if ([edi].m_animation == invalidate)
		mov		[edi].m_actual, false
		jmp		return_inlineCStalkerAnimationPair__play__play_global_impl
	.endif
	; ���������
	mov     ax, [edi].m_array_animation
	cmp     ax, [edi].m_animation
	jmp		return_CStalkerAnimationManager__play_global_impl_CHUNK
CStalkerAnimationManager__play_global_impl_CHUNK endp
align_proc
CStalkerAnimationManager__play_legs_CHUNK proc
; edi - CStalkerAnimationPair
	.if ([edi].m_animation == invalidate)
		mov		[edi].m_actual, false
		jmp		return_inlineCStalkerAnimationPair__play__play_legs
	.endif
	; ���������
	mov     dx, [edi].m_array_animation
	cmp     dx, [edi].m_animation
	ASSUME	edi:nothing
	jmp		return_CStalkerAnimationManager__play_legs_CHUNK
CStalkerAnimationManager__play_legs_CHUNK endp
;------------------------------------------------------

align_proc
load_state_names proc
; ebp - i
kinematics		= dword ptr	 8
	push	eax
	push	ecx
	push	esi
;-----------------
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+120h+12+kinematics]
	mov		esi, [ecx+pUserData]
	Load_anim_from_file esi, aState_name, ebp, edi
;-----------------
	pop		esi
	pop		ecx
	pop		eax
	; ���������
	push	256
	jmp		return_load_state_names
load_state_names endp

align_proc
load_weapon_names proc
; edx = weapon_names[esi*4], esi - i
caBaseNames		= dword ptr -104h
kinematics		= dword ptr	 8
base_name		= dword ptr	 0Ch
	; ���������
	mov		[esp+118h+caBaseNames], edx
	;----------
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+118h+kinematics]
	mov		edi, [ecx+pUserData]
	Load_anim_from_file edi, aWeapon_name, esi, [esp+118h+caBaseNames]
	; ���������
	mov		edx, [esp+118h+base_name]
	jmp		return_load_weapon_names
load_weapon_names endp

align_proc
load_weapon_action_names proc
; esi - i, ecx - weapon_names[esi*4]
caBaseNames		= dword ptr -104h
kinematics		= dword ptr	 8
	; ���������
	mov		eax, edx
	mov		[esp+118h+caBaseNames], ecx
	;----------
	push	eax
	push	edx
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+118h+8+kinematics]
	mov		edi, [ecx+pUserData]
	Load_anim_from_file2 edi, aWeapon_acti, esi, [esp+118h+8+caBaseNames], count_weapon_action_names
	pop		edx
	pop		eax
	jmp		return_load_weapon_action_names
load_weapon_action_names endp

align_proc
load_movement_names proc
; esi - i, ecx - weapon_names[esi*4]
caBaseNames		= dword ptr -104h
kinematics		= dword ptr	 8
Src				= dword ptr	 0Ch
	; ���������
	mov		[esp+118h+caBaseNames], edx
	;----------
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+118h+kinematics]
	mov		edi, [ecx+pUserData]
	Load_anim_from_file2 edi, aMovement_na, esi, [esp+118h+caBaseNames], count_movement_action_names
	; ���������
	mov		edx, [esp+118h+Src]
	jmp		return_load_movement_names
load_movement_names endp

align_proc
load_movement_action_names proc
; esi - i, ecx - weapon_names[esi*4]
caBaseNames		= dword ptr -104h
kinematics		= dword ptr	 8
	; ���������
	mov		eax, edx
	mov		[esp+118h+caBaseNames], ecx
	;----------
	push	eax
	push	edx
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+118h+8+kinematics]
	mov		edi, [ecx+pUserData]
	Load_anim_from_file edi, aMovement_ac, esi, [esp+118h+8+caBaseNames]
	pop		edx
	pop		eax
	jmp		return_load_movement_action_names
load_movement_action_names endp

align_proc
load_in_place_names proc
; esi - i, ecx - weapon_names[esi*4]
caBaseNames		= dword ptr -108h
kinematics		= dword ptr	 8
	; ���������
	mov		eax, edx
	mov		[esp+118h+caBaseNames], ecx
	;----------
	push	eax
	push	edx
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+118h+8+kinematics]
	mov		edi, [ecx+pUserData]
	Load_anim_from_file edi, aIn_place_na, esi, [esp+118h+8+caBaseNames]
	pop		edx
	pop		eax
	jmp		return_load_in_place_names
load_in_place_names endp

align_proc
load_head_names proc
; esi - i
caBaseNames		= dword ptr -108h
kinematics		= dword ptr	 8
Src				= dword ptr -10Ch
	; ���������
	mov		[esp+11Ch+Src], ecx
	;----------
	push	eax
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+11Ch+4+kinematics]
	mov		edi, [ecx+pUserData]
	Load_anim_from_file edi, aHead_names, esi, [esp+11Ch+4+Src]
	pop		eax
	; ���������
	lea		edi, [eax+1]
	jmp		return_load_head_names
load_head_names endp

align_proc
load_global_names proc
; esi - i, ecx - weapon_names[esi*4]
caBaseNames		= dword ptr -104h
kinematics		= dword ptr	 8
	; ���������
	mov		eax, edx
	mov		[esp+118h+caBaseNames], ecx
	;----------
	push	eax
	push	edx
	; CInifile* pUserData	= kinematics->LL_UserData();
	mov		ecx, [esp+118h+8+kinematics]
	mov		edi, [ecx+pUserData]
	Load_anim_from_file2 edi, aGlobal_name, esi, [esp+118h+8+caBaseNames], count_global_names
	pop		edx
	pop		eax
	jmp		return_load_global_names
load_global_names endp

;------------------------------------------
; ���������� ��� ��������
; �������� � ��� ������ ���������� ��������
debug_print_anim2 proc
Dst					= byte ptr -204h
var_20C				= dword ptr -20Ch
tpKinematics		= dword ptr	 8
	;���������
	add		[esp+21Ch+var_20C], 1
	;---------
	mov		eax, [esp+21Ch+tpKinematics]
	.if ([eax+m_anim_flags] & flPrintNameAnim)
		lea		eax, [esp+21Ch+Dst]
		PRINT_UINT "2 Loaded animation: '%s'", eax
	.endif
	jmp		return_debug_print_anim2
debug_print_anim2 endp

debug_print_in_place_names proc
Dst					= byte ptr -100h
tpKinematics		= dword ptr	 8
	mov		eax, [esp+118h+tpKinematics]
	.if ([eax+m_anim_flags] & flPrintNameAnim)
		lea		eax, [esp+118h+Dst+12]
		PRINT_UINT "in_place_names Loaded animation: '%s'", eax
	.endif
	;���������
	mov		eax, [ebp+4]
	add		esp, 0Ch
	jmp		return_debug_print_in_place_names
debug_print_in_place_names endp

debug_print_head_names proc
Dst					= byte ptr -104h
tpKinematics		= dword ptr	 8
	;���������
	mov		eax, [ebp+4]
	add		esp, 0Ch
	;---------
	mov		ecx, [esp+11Ch+tpKinematics]
	.if ([ecx+m_anim_flags] & flPrintNameAnim)
		lea		ecx, [esp+11Ch+Dst]
		PRINT_UINT "head_names Loaded animation: '%s'", ecx
	.endif
	jmp		return_debug_print_head_names
debug_print_head_names endp
