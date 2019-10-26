
PERFORM_EXPORT_CUIWND__VOID__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIWindow__SetPPMode
ENDM

PERFORM_EXPORT_CUIWND__FLOAT__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIWindow_float__void
ENDM

PERFORM_EXPORT_CUI__BOOL__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register__UI__bool__void
ENDM

PERFORM_EXPORT_CUI_VOID__INT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIComboBox__SetCurrentID
ENDM

PERFORM_EXPORT_CUI_VOID__UINT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIStatic__SetColor
ENDM

PERFORM_EXPORT_CUI_VOID__BOOL MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIListWnd__ActivateList
ENDM

PERFORM_EXPORT_CUI_VOID__FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIWindow__SetHeight
ENDM

PERFORM_EXPORT_CUI_VOID__FLOAT_FLOAT MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIWindow__SetWndPos
ENDM

PERFORM_EXPORT_CUI_INT__VOID MACRO fun_to_export:REQ, fun_name_str:REQ
	push	0
	push	offset fun_to_export
	push	const_static_str$(fun_name_str)
	push	eax
	call	register_CUIListWnd__GetSize
ENDM
