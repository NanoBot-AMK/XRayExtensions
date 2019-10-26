
align_proc
CUITradeWnd__CanMoveToOther_fix proc
;eax	this	CUITradeWnd*
;ebx	item	CInventoryItem*
	ASSUME	ebx:ptr CInventoryItem
	.if (g_trade_filtration_active)	; проверяем глобальный флажок
		.if ([ebx].m_flags & 01000h)	; проверяем флажок явной установки торговли предмета
			mov		al, true
			retn
		.endif
		.if ([ebx].m_flags & 02000h)	; проверяем флажок явного запрета торговли предмета
			mov		al, false
			retn
		.endif
	.endif
	; делаем то, что вырезали
	sub		esp, 1Ch
	push	esi
	mov		esi, eax
	mov		eax, [esi+5Ch]
	jmp		return_CUITradeWnd__CanMoveToOther_fix
CUITradeWnd__CanMoveToOther_fix endp

;Логика раскраски следующая:
;1.	если do_colorize == false, значит предмет не в инвентаре актора, не раскрашиваем
;2.	если предмет не продаётся по результату функции CUITradeWnd__CanMoveToOther,
;	что включает также и запрет по состоянию, то закрасить дефолтовым цветом с индексом 0 из палитры
;3.	если влючён флажок активности глобальной закраски и для предмета активен его локальный
;	флажок кастомной закраски, то использовать индекс из палитры m_custom_color
align_proc
CUITradeWnd@@GetIndexColor proc (byte)
;al		bool
;ebx	item	CInventoryItem*
	.if (al==false)		;торговать нельзя, красим в цвет с индексом 0 (обычно красный)
		xor		ecx, ecx
		mov		al, true
	;можно торговать, проверяем кастомную раскраску
	.elseif (g_manual_highlignt_active && [ebx].m_flags & 08000h)	; пользовательский ii флажок "manual_highlighting"
		;подсветить предмет кастомным цветом, индекс которого хранится в 4-х битах в m_custom_color
		movzx	ecx, [ebx].m_custom_color	;+134
		and		ecx, 1111b
		mov		al, true
	.else	; флажок не установлен, поскольку тогуемость уже проверяли, то не раскаршиваем вовсе
		mov		al, false
	.endif
	mov		edx, g_highlight_colors[ecx*4]		;в edx возвращаем цвет
	ASSUME	ebx:nothing
	ret
CUITradeWnd@@GetIndexColor endp
