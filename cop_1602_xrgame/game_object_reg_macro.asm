
PERFORM_EXPORT_BOOL__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+04h], bl
	mov		ecx, [esp+50h+04h]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+04h]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__bool__void
ENDM

PERFORM_EXPORT_UINT__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+4], bl
	mov		ecx, [esp+50h+4]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+4]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__uint__void
ENDM

PERFORM_EXPORT_FLOAT__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+4], bl
	mov		ecx, [esp+50h+4]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+4]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__float__void
ENDM

PERFORM_EXPORT_STRING__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+4], bl
	mov		ecx, [esp+50h+4]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+4]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__str__void
ENDM

PERFORM_EXPORT_VOID__FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+4], bl
	mov		ecx, [esp+50h+4]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+4]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__void__float
ENDM

PERFORM_EXPORT_VOID__STRING_BOOL MACRO fun_to_export:REQ, fun_name_str:REQ		; "play_cycle"
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
;	mov		byte ptr [esp+0A0h-080h], bl
;	mov		edx, [esp+0A0h-080h]
;	push	edx
;	mov		byte ptr [esp+0A4h-08Ch], bl
;	mov		ecx, [esp+0A4h-08Ch]
;	push	ecx
;	lea		edx, [esp+0A8h-090h]
;	push	edx
;	lea		ecx, [esp+0ACh-088h]
;	push	ecx
;	push	offset fun_name
;	mov		ecx, eax
;	mov		[esp+0B4h-088h], offset fun_to_export
	
	mov		byte ptr [esp+50h+4], bl
	mov		ecx, [esp+50h+4]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+4]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__void__str_bool
ENDM

PERFORM_EXPORT_BOOL__STRING MACRO fun_to_export:REQ, fun_name_str:REQ		; "disable_info_portion"
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+4], bl
	mov		ecx, [esp+50h+4]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+4]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__bool__str
ENDM

PERFORM_EXPORT_VOID__BOOL MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+04h], bl
	mov		ecx, [esp+50h+04h]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+04h]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__void__bool
ENDM

PERFORM_EXPORT_BOOL__GO MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+04h], bl
	mov		ecx, [esp+50h+04h]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+04h]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__bool__go
ENDM

PERFORM_EXPORT__VOID__GO_STRING_VECTOR_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+04h], bl
	mov		ecx, [esp+50h+04h]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+04h]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__void__go_str_pvector_float
ENDM

PERFORM_EXPORT__VOID__FLOAT_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp		lab1
fun_name db fun_name_str, 0
lab1:
	mov		byte ptr [esp+50h+04h], bl
	mov		ecx, [esp+50h+04h]
	push	ecx
	mov		byte ptr [esp+54h-030h], bl
	mov		edx, [esp+54h-030h]
	push	edx
	lea		ecx, [esp+58h+04h]
	push	ecx
	lea		edx, [esp+5Ch-038h]
	push	edx
	push	offset fun_name
	mov		ecx, eax
	mov		[esp+64h-038h], offset fun_to_export
	call	register__void__float_float
ENDM
