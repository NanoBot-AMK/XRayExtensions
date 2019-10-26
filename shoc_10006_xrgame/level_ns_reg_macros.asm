;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Прототипы скриптовых функций в пространстве имён Level
; (c) NanoBot						12.11.2017		25.09.2018
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

align_proc
register_level__base_prototype proc uses esi _result:dword, name_func:dword, func:dword, virtual_table:dword
local reg:dword
	xr_memory	20
	mov		esi, eax
	mov		ecx, eax
	call	ds:luabind__detail__registration__registration ; luabind::detail::registration::registration(void)
	mrm		[esi], virtual_table
	mrm		[esi+8], name_func
	mrm		[esi+12], func
	push	esi
	lea		ecx, reg
	call	ds:luabind__scope__scope@std__auto_ptr@luabind__detail__registration@@
	mov		ecx, _result
	push	eax
	call	ds:luabind__scope__scope ; luabind::scope::scope(scope::scope const &)
	lea		ecx, reg
	call	ds:luabind__scope___scope ; luabind::scope::~scope(void)
	mov		eax, _result
	ret		12
register_level__base_prototype endp

PERFORM_EXPORT_LEVEL__BASEPROTOTYPE MACRO func_to_export:REQ, fun_name_str:REQ, virtual_tabl_name:REQ
	mov		eax, esp
	invoke	register_level__base_prototype, eax, const_static_str$(fun_name_str), addr func_to_export, addr virtual_tabl_name
ENDM

PERFORM_EXPORT_LEVEL__VOID__FLOAT					MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__void__float
ENDM

PERFORM_EXPORT_LEVEL__INT__INT						MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__int__int
ENDM
	
PERFORM_EXPORT_LEVEL__FLOAT__VOID					MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__float__void
ENDM

PERFORM_EXPORT_LEVEL__FLOAT__STR_INT_BOOL_STR		MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__float__str_int_bool_str
ENDM

PERFORM_EXPORT_LEVEL__BOOL__VOID					MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__bool__void
ENDM

PERFORM_EXPORT_LEVEL__VOID__VOID					MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__void__void
ENDM

PERFORM_EXPORT_LEVEL__GO__U32						MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__GO__u32
ENDM

PERFORM_EXPORT_LEVEL__DLG__VOID						MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__CUIDialogWnd__void
ENDM

PERFORM_EXPORT_LEVEL__VECTOR__U32					MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__vector__u32
ENDM

PERFORM_EXPORT_LEVEL__U32__U32_VECTOR_FLOAT			MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__u32__u32_vector_float
ENDM

PERFORM_EXPORT_LEVEL__INT__STR_INT					MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__void__int__str_int
ENDM

PERFORM_EXPORT_LEVEL__VOID__U32						MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__void__u32
ENDM

PERFORM_EXPORT_LEVEL__U32__VOID						MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__u32__void
ENDM

PERFORM_EXPORT_LEVEL__VOID__INT_FLOAT_FLOAT			MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__void__int_float_float
ENDM

PERFORM_EXPORT_LEVEL__VOID__FLOAT_FLOAT				MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__void__float_float
ENDM

PERFORM_EXPORT_LEVEL__FLOAT__U32_PVECTOR			MACRO	fun_to_export:REQ, fun_name_str:REQ
	PERFORM_EXPORT_LEVEL__BASEPROTOTYPE		fun_to_export, fun_name_str, virtual_prototype__float__u32_pvector
ENDM
