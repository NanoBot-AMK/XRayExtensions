
align_proc
cuistatic_xml_add proc
arg_0= dword ptr  8
arg_8= dword ptr  10h
	mov     ecx, [ebp+arg_0]
	push    0
	push    const_static_str$("adjust_height_to_text")
	push    esi
	push    edi
	call    ebx ; CXml::ReadAttribInt(char const *,int,char const *,int) ; CXml::ReadAttribInt(char const *,int,char const *,int)
	.if (eax)
		push	edi
		mov 	edi, [ebp+arg_8]
		call	CUIStatic__AdjustHeightToText
		pop		edi
	.endif
	mov     ecx, [ebp+arg_0]
	push    0
	push    const_static_str$("adjust_width_to_text")
	push    esi
	push    edi
	call    ebx ; CXml::ReadAttribInt(char const *,int,char const *,int) ; CXml::ReadAttribInt(char const *,int,char const *,int)
	.if (eax)
		push	esi
		mov 	esi, [ebp+arg_8]
		call	CUIStatic__AdjustWeigthToText
		pop		esi
	.endif
	;Делаем то что вырезали
	mov     ecx, [ebp+arg_0]
	push    0
	jmp		return_cuistatic_xml_add
cuistatic_xml_add endp

;------------------------------------------------------------
; Исправление формулы рассчёта статистики убийств в КПК
;------------------------------------------------------------
static_int		g_select_total_statistic, 0	; тип подсчёта: 0 - подсчёт по штукам, 1 - подсчёт по очкам.

align_proc
CActorStatisticMgr__GetSectionPointsSelect proc
	invoke	CActorStatisticMgr__GetSectionPoints, g_select_total_statistic
	retn
CActorStatisticMgr__GetSectionPointsSelect endp
;------------------------------------------------------------
