
align_proc
CUITalkWnd__Hide_fix proc
	push	offset aUi_talk_hide
	call	SendInfoToActor
	add		esp, 4
	;вырезанное.
	mov		eax, [esi]
	mov		edx, [eax+74h]
	jmp		return_CUITalkWnd__Hide_fix
CUITalkWnd__Hide_fix endp