;0 - knife
;1 - pistol
;2 - automatic
;3 - grenades
;5 - bolt
;6 - outfit
;7 - pda
; new
;4 - bunocular
;8 - detector
;9 - torch
;10 - helmet
; extra
;11 - nightvision googles
;12 - biodetector
INVENTORY__INIT_ADD_SLOT MACRO name_tip:req, name_param:req
LOCAL uiXml
	uiXml	= dword ptr -290h
	ASSUME	ebp:ptr CUIInventoryWnd
	mov		ecx, ds:Memory
	push	size CUIDragDropListEx
	call	esi
	mov		ecx, eax
	call	CUIDragDropListEx@@CUIDragDropListEx
	mov		edx, [ebp]
	mov		[ebp].name_param, eax
	push	eax
	mov		eax, [edx+34h]
	mov		ecx, ebp
	call	eax
	mov		ecx, [ebp].name_param
	mov		[ecx].CUIDragDropListEx.m_bAutoDelete, 1
	push	[ebp].name_param
	lea		eax, [esp+2B4h+uiXml]
	push	eax
	xor		ebx, ebx
	mov		edi, const_static_str$(name_tip)
	call	CUIXmlInit@@InitDragDropListEx
	mov		eax, [ebp].name_param
	add		esp, 8
	mov		ecx, ebp
	call	CUIInventoryWnd@@BindDragDropListEnents
	ASSUME	ebp:nothing
ENDM

; создание и инициализация объектов CUIDagDropListEx для слотов
align_proc
CUIInventoryWnd__Init__ proc 
;ebp	this	CUIInventoryWnd*
;esi	xrMemory::mem_alloc(uint size)
	call	CUIInventoryWnd@@BindDragDropListEnents
	INVENTORY__INIT_ADD_SLOT	"dragdrop_knife", 		m_pUIKnifeList				;Нож
	INVENTORY__INIT_ADD_SLOT	"dragdrop_binocular",	m_pUIBinocularList			;Бинокль
IFDEF OGSE_BUILD
	INVENTORY__INIT_ADD_SLOT	"dragdrop_detector", 	m_pUIDetectorList			;Детектор
ENDIF
	INVENTORY__INIT_ADD_SLOT	"dragdrop_torch", 		m_pUITorchList				;Фонарик
IFDEF OGSE_BUILD
	INVENTORY__INIT_ADD_SLOT	"dragdrop_helmet", 		m_pUIHelmetList				;Шлем
	INVENTORY__INIT_ADD_SLOT	"dragdrop_nv",			m_pUINightVisionList		;Прибор ночного видения
	INVENTORY__INIT_ADD_SLOT	"dragdrop_biodetector",	m_pUIBiodetectorList		;Биодетектор
ENDIF
	jmp		return_CUIInventoryWnd__Init__
CUIInventoryWnd__Init__ endp

INVENTORY__INITINVENTORY_ADD_SLOT MACRO slot_idx:req, name_slot:req
	ASSUME	edi:ptr CUIInventoryWnd
	mov		ecx, [edi].m_pInv
	mov		eax, [ecx].CInventory.m_slots._Myfirst
IF slot_idx NE 0
	add		eax, slot_idx*10h
ENDIF
	mov		eax, [eax].CInventorySlot.m_pIItem		; CInventoryItem*
	.if (eax)
		call	create_cell_item
		mov		ecx, [edi].name_slot
		mov		edx, [ecx]
		push	eax
		mov		eax, [edx+90h]
		call	eax
	.endif
	ASSUME	edi:nothing
ENDM

; создание объектов CUICellItem для слотов
align_proc
CUIInventoryWnd__InitInventory__ proc
;edi	this	CUIInventoryWnd*
	mov		eax, [edx+90h]
	call	eax
;-----------------------
	INVENTORY__INITINVENTORY_ADD_SLOT	0,	m_pUIKnifeList				;Нож
	INVENTORY__INITINVENTORY_ADD_SLOT	4,	m_pUIBinocularList			;Бинокль
ifdef OGSE_BUILD
	INVENTORY__INITINVENTORY_ADD_SLOT	8,	m_pUIDetectorList			;Детектор
endif
	INVENTORY__INITINVENTORY_ADD_SLOT	9,	m_pUITorchList				;Фонарик
ifdef OGSE_BUILD
	INVENTORY__INITINVENTORY_ADD_SLOT	10,	m_pUIHelmetList				;Шлем
	INVENTORY__INITINVENTORY_ADD_SLOT	11,	m_pUINightVisionList		;Прибор ночного видения
	INVENTORY__INITINVENTORY_ADD_SLOT	12,	m_pUIBiodetectorList		;Биодетектор
endif
	jmp		return_CUIInventoryWnd__InitInventory__
CUIInventoryWnd__InitInventory__ endp

;------------------------------
;таблица со смещениями CUIDragDropListEx*, для CUIInventoryWnd__GetSlotList
.const
align 4
tblUIList	dd	CUIInventoryWnd.m_pUIKnifeList					; 0		Нож
			dd	CUIInventoryWnd.m_pUIPistolList					; 1		Пистолет
			dd	CUIInventoryWnd.m_pUIAutomaticList				; 2		Автомат
			dd	0												; 3		Гранаты
			dd	CUIInventoryWnd.m_pUIBinocularList				; 4		Бинокль
			dd	CUIInventoryWnd.m_pUIBeltList					; 5		Болт
			dd	CUIInventoryWnd.m_pUIBagList					; 6		Костюм
			dd	0												; 7		ПДА
			dd	CUIInventoryWnd.m_pUIDetectorList				; 8		Детектор
			dd	CUIInventoryWnd.m_pUITorchList					; 9		Фонарик
			dd	CUIInventoryWnd.m_pUIHelmetList					; 10	Шлем
			dd	CUIInventoryWnd.m_pUINightVisionList			; 11	Прибор ночного видения
			dd	CUIInventoryWnd.m_pUIBiodetectorList			; 12	Биодетектор
.code
;------------------------------

M@CUIDragDropListEx@@ClearAll MACRO this_:req, bDestroy:req
	mov		eax, this_
	push	bDestroy
	call	CUIDragDropListEx@@ClearAll
	EXITM <>
ENDM

; очистка ячеек для слотов
align_proc
CUIInventoryWnd__ClearAllLists proc	
	push	ecx
	ASSUME	esi:ptr CUIInventoryWnd
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIBagList, 			true)
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIBeltList, 			true)
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIOutfitList, 		true)
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIPistolList, 		true)
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIAutomaticList,		true)
	;-----NEW-----
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIKnifeList, 		true)
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIBinocularList, 	true)
IFDEF OGSE_BUILD
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIDetectorList, 		true)
ENDIF
	M@CUIDragDropListEx@@ClearAll([esi].m_pUITorchList, 		true)
IFDEF OGSE_BUILD
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIHelmetList, 		true)
	M@CUIDragDropListEx@@ClearAll([esi].m_pUINightVisionList, 	true)
	M@CUIDragDropListEx@@ClearAll([esi].m_pUIBiodetectorList, 	true)
ENDIF
	ASSUME	esi:nothing
	pop		ecx
	retn
CUIInventoryWnd__ClearAllLists endp
	
; блок худа слотов
align_proc
CInventory__Init__ proc
	;------------------
	mov		eax, [esi].CInventory.m_slots._Myfirst
IFDEF OGSE_BUILD
	ASSUME	eax:ptr CInventorySlot
	mov		[eax+10*(size CInventorySlot)].m_bVisible, bl		;+0A9h helmet
	mov		[eax+11*(size CInventorySlot)].m_bVisible, bl		;+0B9h nightvision
	mov		[eax+12*(size CInventorySlot)].m_bVisible, bl		;+0C9h biodetector
	ASSUME	eax:nothing
ENDIF
	jmp		return_CInventory__Init__
CInventory__Init__ endp

; заставляем движок учитывать предмет из шлемового слота при подсчете хита актору
align_proc
CActor__HitArtefactsOnBelt proc uses esi ebx hit_power:real4, hit_type:dword
local res_hit_power_k:real4, _af_count:real4, const1p0:real4
;ecx	this	CActor*
	mov		ebx, [ecx].CActor.m_inventory
	ASSUME	ebx:ptr CInventory
	movflt	eax, 1.0
	mov		res_hit_power_k, eax
	mov		const1p0, eax
	and		_af_count, 0	;=0.f;
	.for (esi=[ebx].m_belt._Myfirst: [ebx].m_belt._Mylast!=esi: esi+=4)
		mov		ecx, [esi]
		call	localFunc@CalcHit
	.endfor
	; получаем итем в слоте
	mov		eax, [ebx].m_slots._Myfirst
	mov		ecx, [eax+10*size(CInventorySlot)].CInventorySlot.m_pIItem	; item in slot #10 (CInventoryItem *)
	call	localFunc@CalcHit
	ASSUME	ebx:nothing
	fld		res_hit_power_k
	fsub	_af_count
	fmul	hit_power
	ret
localFunc@CalcHit:
	.if (ecx)
		smart_cast	CGameObject, CInventoryItem, ecx
		smart_cast	CArtefact, eax
		.if (eax)
			; узнаем защиту от хита
			lea		ecx, [eax+318h]	; m_ArtefactHitImmunities
			mov		edx, [ecx]
			mov		eax, [edx+8]
			push	hit_type
			pushflt	1.0
			call	eax		;AffectHit(1.0, hit_type)
			; подсчитываем хит
			fadd	res_hit_power_k
			movss	xmm0, _af_count
			addss	xmm0, const1p0
			movss	_af_count, xmm0
			fstp	res_hit_power_k
		.endif
	.endif
	retn
CActor__HitArtefactsOnBelt endp
