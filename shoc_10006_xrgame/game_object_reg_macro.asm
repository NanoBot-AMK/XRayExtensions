
PERFORM_EXPORT_BOOL__STRING MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__bool__string
ENDM

PERFORM_EXPORT_PROPERTY__FLOAT_RW MACRO get_fun:REQ, set_fun:REQ, property_name_str:REQ
	mov		edi, eax
	push	0
	push	offset set_fun
	push	const_static_str$(property_name_str) 
	mov		edx, offset get_fun
	call	register__float_rw_property
ENDM

PERFORM_EXPORT_VECTOR__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register_go_vector__void
ENDM

PERFORM_EXPORT_VOID__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__void
ENDM

PERFORM_EXPORT_BOOL__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__bool__void
ENDM

PERFORM_EXPORT_VOID__BOOL MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__bool
ENDM

PERFORM_EXPORT_STRING__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__string__void
ENDM

PERFORM_EXPORT_VOID__STRING MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__string
ENDM

PERFORM_EXPORT_INT__GO MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__int__go
ENDM

PERFORM_EXPORT_UINT__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	mov		ppFuncExport, offset fun_to_export
	lea		ecx, ppFuncExport
	push	ecx
	push	const_static_str$(fun_name_str)
	push	eax
	call	register__u32__void@const
ENDM

PERFORM_EXPORT_FLOAT__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	mov		ppFuncExport, offset fun_to_export
	lea		ecx, ppFuncExport
	push	ecx
	push	const_static_str$(fun_name_str)
	push	eax
	call	register__float__void@const
ENDM

PERFORM_EXPORT_VOID__FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__float
ENDM

PERFORM_EXPORT_BOOL__GO MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__bool__go
ENDM

PERFORM_EXPORT_GO__INT MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__go__int
ENDM

PERFORM_EXPORT_FLOAT__PU32 MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__float__pu32
ENDM

PERFORM_EXPORT_FLOAT__INT MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__float__int
ENDM

PERFORM_EXPORT_VOID__VECTOR_FLOAT_INT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__vector_float_int
ENDM

PERFORM_EXPORT_U32__STRING_INT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__u32__str_int
ENDM

PERFORM_EXPORT_VOID__INT_INT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__u32_u32
ENDM

PERFORM_EXPORT_VOID__GO MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__run_talk_dialog
ENDM

PERFORM_EXPORT_VOID__GO_BOOL MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__go_bool
ENDM

PERFORM_EXPORT_GO__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__get_best_item
ENDM

PERFORM_EXPORT_VECTOR__STRING MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__vector__string
ENDM

PERFORM_EXPORT_INIFILE__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		ecx, ppFuncExport
	push	ecx
	push	eax
	call	register__CScriptIniFile__void
ENDM

PERFORM_EXPORT_VOID__STR_BOOL MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__str_bool
ENDM

PERFORM_EXPORT_VOID__VECTOR MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register_go_void__vector
ENDM

PERFORM_EXPORT_VOID__INT MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__set_character_rank
ENDM

PERFORM_EXPORT_VOID__U32_U32_U32 MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__u32_u32_u32
ENDM

PERFORM_EXPORT_U32__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__u32__void
ENDM

PERFORM_EXPORT_VOID__U32_PVECTOR MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__u32_pvector
ENDM

PERFORM_EXPORT_VOID__FLOAT_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__void__float_float
ENDM

PERFORM_EXPORT_BOOL__U32 MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__bool__u32
ENDM

PERFORM_EXPORT_VOID__STR_STR MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register_void__str_str
ENDM

PERFORM_EXPORT_UINT__VECTOR_PVECTOR MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__uint__vector_pvector
ENDM

PERFORM_EXPORT_BOOL__PVECTOR_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__bool__pvector_float
ENDM

PERFORM_EXPORT_BOOL__PVECTOR MACRO fun_to_export:REQ, fun_name_str:REQ
	mov		ebx, eax
	push	0
	push	const_static_str$(fun_name_str)
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__bool__pvector
ENDM

PERFORM_EXPORT_U32__FLOAT_PVECTOR MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	const_static_str$(fun_name_str)
	push	eax
	mov		ppFuncExport, offset fun_to_export
	lea		eax, ppFuncExport
	call	register__u32__float_pvector
ENDM
