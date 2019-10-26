SET_INT_ARG_N MACRO argnum:REQ
g_int_argument_&argnum& dword ?
SetIntArg&argnum& proc
int_arg = dword ptr  4
	mov     eax, [esp+int_arg]
	mov     g_int_argument_&argnum&, eax
	retn
SetIntArg&argnum& endp
ENDM

GLOBAL_NS_PERFORM_EXPORT__INT__INT_INT MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
	jmp     lab1
fun_name db fun_name_str, 0
lab1:
	push    offset fun_to_export
	push    offset fun_name
	push    [ebp+8h]
	call    bit_and_register
	add     esp, 0Ch
ENDM

GLOBAL_NS_PERFORM_EXPORT__BOOL__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
LOCAL var1
	jmp     lab1
fun_name db fun_name_str, 0
var1 dd 0
lab1:
	push    offset fun_to_export
	push    offset fun_name
	lea     eax, [var1]
	push    eax
	call    register_gs__bool__void
	add     esp, 0Ch
ENDM

GLOBAL_NS_PERFORM_EXPORT__VOID__PCHAR MACRO fun_to_export:REQ, fun_name_str:REQ
LOCAL lab1
LOCAL fun_name
LOCAL var1
	jmp     lab1
fun_name db fun_name_str, 0
var1 dd 0
lab1:
	add     esp, 0Ch
    push    offset fun_to_export
    push    offset fun_name
	push    [ebp+8h]
    call    error_log_register
ENDM


