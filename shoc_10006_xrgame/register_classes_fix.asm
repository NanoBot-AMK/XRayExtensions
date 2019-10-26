;======================================================================
;	Project		: XRay - Extensions		
;	Module		: register_classes_fix.asm
;	Created		: 07.08.2019
;	Modified	: 07.08.2019
;	Author		: NanoBot
;	Description : Возможность добавлять собственые классы.
;======================================================================

REGISTER_CLASSES@@ADD MACRO vfptr_class:req, shortname_clsid:req, script_clsid:req
LOCAL clsid, shortname_lo, shortname_hi
	clsid	= -8
	shortname_lo	SUBSTR <&shortname_clsid>, 6, 4
	shortname_hi	SUBSTR <&shortname_clsid>, 2, 4
	shortname_lo	CATSTR <'>,shortname_lo,<'>		;; добавляем кавычки
	shortname_hi	CATSTR <'>,shortname_hi,<'>
	mov		ecx, ds:Memory
	push	size CObjectItemAbstract
	mov		dword ptr [esp+1Ch+clsid+0], shortname_lo
	mov		dword ptr [esp+1Ch+clsid+4], shortname_hi
	call	edi		;xrMemory::mem_alloc(uint size)
	mov		esi, eax				; this
	push	const_static_str$(script_clsid)
	lea		eax, [esp+1Ch+clsid] 	; clsid
	call	CObjectItemAbstract__CObjectItemAbstract
	mov		[esi], offset vfptr_class
	push	esi						; item
	call	CObjectFactory__add
	EXITM <>
ENDM

;
align_proc
CObjectFactory@@register_classes_ext proc
;ebx	this	CObjectFactory*
;esi	obj		CObjectItemAbstract*
;edi	xrMemory::mem_alloc(uint)
	call	CObjectFactory__add
	;---------------------------------
	REGISTER_CLASSES@@ADD (vfptr?CAntirad?VCSE_ALifeItem, 'O_BATTAR', "pyrobattary")
	
	jmp		return_CObjectFactory@@register_classes_ext
CObjectFactory@@register_classes_ext endp
