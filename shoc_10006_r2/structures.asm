;Только для структур

Fvector struct
	x					real4 ?
	y					real4 ?
	z					real4 ?
Fvector ends

Fvector2 struct
	x					real4 ?
	y					real4 ?
Fvector2 ends

Fvector4 struct
	x					real4 ?
	y					real4 ?
	z					real4 ?
	w					real4 ?
Fvector4 ends

Fcolor struct
	r					real4 ?
	g					real4 ?
	b					real4 ?
	a					real4 ?
Fcolor ends

Fsphere	 struct ; (sizeof=16, align=4)
	P					Fvector <>		; 0
	R					real4 ?			; 12
Fsphere	 ends							; 16

Fmatrix struct
	i					Fvector <>
	_14_				real4 ?
	j					Fvector <>
	_24_				real4 ?
	k					Fvector <>
	_34_				real4 ?
	c_					Fvector <>
	_44_				real4 ?
Fmatrix ends

; для регистров xmm 16 байт SSE инструкций
Fmatrix4 struct ; (sizeof=64, align=4)
	i					Fvector4 <>			; 0
	j					Fvector4 <>			; 16
	k					Fvector4 <>			; 32
	c_					Fvector4 <>			; 48
Fmatrix4 ends								; 64

Fquaternion struct ; (sizeof=16, align=4)
	x					real4 ?				; 
	y					real4 ?				; 
	z					real4 ?				; 
	w					real4 ?				; 
Fquaternion ends

xr_vector struct ; (sizeof=16, align=4)
	_Alval				dword ?				; 0		allocator object for values			; объект{цель} программы распределения для значений
	_Myfirst			dword ?				; 4		pointer to beginning of array		; указатель на начало массива
	_Mylast				dword ?				; 8		pointer to current end of sequence	; указатель на текущий конец последовательности
	_Myend				dword ?				; 12	pointer to end of array				; указатель на конец массива
xr_vector ends								; 16

xr_vector2 struct ; (sizeof=20, align=4)
	xr_vector <>
	_Count				dword ?				; 16	количество элементов
xr_vector2 ends								; 20

xr_deque struct ; (sizeof=20, align=4)
	_Myproxy			dword ?				; 0	offset		; 0
	_Map				dword ?				; 4	offset
	_Mapsize			dword ?				; 8
	_Myoff				dword ?				; 12
	_Mysize				dword ?				; 16 
xr_deque ends								; 20

shared_str struct ; (sizeof=4, align=4)
	p_					dword ?				; 4		str_value*
shared_str ends

resptr_core struct ; (sizeof=4, align=4,)
	p_					dword ?				; 4
resptr_core ends

Frect struct ; (sizeof=16, align=4)
	union
		struct
			x1				real4 ?			; 0
			y1				real4 ?			; 4
			x2				real4 ?			; 8
			y2				real4 ?			; 12
		ends
		struct
			left			real4 ?			; 0
			top				real4 ?			; 4
			right			real4 ?			; 8
			bottom			real4 ?			; 12
		ends
		struct
			_lt				Fvector2 <>		; 0		Tvector
			_rb				Fvector2 <>		; 8		Tvector
		ends
	ends
Frect ends									; 16

_RECT struct ; (sizeof=16, align=4)
	Frect <>
_RECT ends

Fbox struct ; (sizeof=24, align=4)
	union
		struct
			min				Fvector <>		; 0
			max				Fvector <>		; 12
		ends
		struct
			x1				real4 ?			; 0
			y1				real4 ?			; 4
			z1				real4 ?			; 8
			x2				real4 ?			; 12
			y2				real4 ?			; 16
			z2				real4 ?			; 20
		ends
	ends
Fbox ends

Fbox4 struct ; (sizeof=32, align=16)
	min						Fvector4 <>		; 0
	max						Fvector4 <>		; 16
Fbox4 ends									; 32

;===================================================================================
;==============================	  CGameObject  =====================================
;===================================================================================

ref_sound struct ; (sizeof=4, align=4)
_p										dword ?			; 0		resptr_core<ref_sound_data,resptr_base<ref_sound_data> > ?
ref_sound ends

CObject__SavedPosition struct ; (sizeof=16, align=4)
	dwTime						dword ?					; 0
	vPosition					Fvector <>				; 4
CObject__SavedPosition ends								; 16

DLL_Pure struct ; (sizeof=16, align=8)
	DLL_Pure@vfptr				dword ?					; 0 offset
								dword ? ; undefined
	struct CLS_ID										; 8		qword ?
		lo					dword ?						; 8
		hi					dword ?						; 12
	ends
DLL_Pure ends											; 16

ISpatial struct ; (sizeof=52, align=4)
	ISpatial@vfptr				dword ?					; 0 offset
	struct spatial
		_type					dword ?					; 4
		sphere					Fsphere <>				; 8
		node_center				Fvector <>				; 24
		node_radius				dword ?					; 36
		node_ptr				dword ?					; 40 offset
		sector					dword ?					; 44 offset
		space					dword ?					; 48 offset
	ends
ISpatial ends											; 52

ISheduled struct ; (sizeof=8, align=4)
	ISheduled@vfptr				dword ?					; 0		offset
	struct shedule										; 4		
		_bf0					dword ?					; 4
	ends
ISheduled ends											; 8

IRenderable	 struct ; (sizeof=80, align=4)
	IRenderable@vfptr			dword ?					; 0 offset
	union
		struct renderable
			xform				Fmatrix4 <>				; 4
			visual				dword ?					; 68 IRender_Visual*
			pROS				dword ?					; 72 IRender_ObjectSpecific*
			pROS_Allowed		dword ?					; 76 BOOL
		ends
		struct
			XFORM_				Fmatrix4 <>				; 4
			Visual_				dword ?					; 68 IRender_Visual*
		ends
	ends
IRenderable	 ends										; 80

ICollidable	 struct ; (sizeof=8, align=4)
	ICollidable@vfptr			dword ?					;  offset
	union
		struct collidable
			model				dword ?					; 4 ICollisionForm*
		ends
		CFORM					dword ?					; 4 ICollisionForm*
	ends
ICollidable	 ends	; 8

bEnabled				= byte ptr (1 shl 0);
bVisible				= byte ptr (1 shl 1);
bDestroy				= byte ptr (1 shl 2);
net_Local				= byte ptr (1 shl 3);
net_Ready				= byte ptr (1 shl 4);
net_SV_Update			= byte ptr (1 shl 5);
crow					= byte ptr (1 shl 6);
bPreDestroy				= byte ptr (1 shl 7);

CObject struct ; (sizeof=260, align=8)
	DLL_Pure <>											; 0
	ISpatial <>											; 16
	ISheduled <>										; 68
	IRenderable <>										; 76
	ICollidable <>										; 156
	union
		struct Props
			net_ID				word ?					; 164
			bActiveCounter		byte ?					; 166
			flags				byte ?					; 167
		ends
		ID						word ?					; 164
		storage					dword ?					; 164	CObject::ObjectProperties
	ends
	NameObject					shared_str <>			; 168	
	NameSection					shared_str <>			; 172	shared_str
	NameVisual					shared_str <>			; 176	shared_str
	Parent						dword ?					; 180	offset
	struct PositionStack
		array			CObject__SavedPosition 4 dup (<>); 184
		count					dword ?					; 248
	ends
	dwFrame_UpdateCL			dword ?					; 252
	dwFrame_AsCrow				dword ?					; 256
CObject ends											; 260	

CUsableScriptObject struct ; (sizeof=12, align=4)
	CUsableScriptObject@vfptr	dword ?					; 0		offset
	m_sTipText					dword ?					; 4		shared_str
	m_bNonscriptUsable			byte ?					; 8	
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CUsableScriptObject ends								; 12

CScriptBinder struct ; (sizeof=8, align=4)
	CScriptBinder@vfptr			dword ?					; 0		offset
	CScriptBinder@m_object		dword ?					; 4		CScriptBinderObject*
CScriptBinder ends										; 8

svector_void___stdcall_CKinematics_6 struct
	array						dword 6 dup(?)			; 316	offset
	count						dword ?					; 240
svector_void___stdcall_CKinematics_6 ends

;------------------------------CGameObject------------------------------------
virt@@CGameObject struct
											dword 27 dup(?)
;Таблица виртуальных методов для приведения типов.	//functions used for avoiding most of the smart_cast
	cast_CAttachmentOwner					dword ?		; 108		; CAttachmentOwner*
	cast_CInventoryOwner					dword ?		; 112		; CInventoryOwner*
	cast_CInventoryItem						dword ?		; 116		; CInventoryItem*
	cast_CEntity							dword ?		; 120		; CEntity*
	cast_CEntityAlive						dword ?		; 124		; CEntityAlive*
	cast_CActor								dword ?		; 128		; CActor*
	cast_CGameObject						dword ?		; 132		; CGameObject*
	cast_CCustomZone						dword ?		; 136		; CCustomZone*
	cast_CPhysicsShellHolder				dword ?		; 140		; CPhysicsShellHolder*
	cast_IInputReceiver						dword ?		; 144		; IInputReceiver*
	cast_CParticlesPlayer					dword ?		; 148		; CParticlesPlayer*
	cast_CArtefact							dword ?		; 152		; CArtefact*
	cast_CCustomMonster						dword ?		; 156		; CCustomMonster*
	cast_CAI_Stalker						dword ?		; 160		; CAI_Stalker*
	cast_CScriptEntity						dword ?		; 164		; CScriptEntity*
	cast_CWeapon							dword ?		; 168		; CWeapon*
	cast_CExplosive							dword ?		; 172		; CExplosive*
	cast_CSpaceRestrictor					dword ?		; 176		; CSpaceRestrictor*
	cast_CAttachableItem					dword ?		; 180		; CAttachableItem*
	cast_CHolderCustom						dword ?		; 184		; CHolderCustom*
	cast_CBaseMonster						dword ?		; 188		; CBaseMonster*
;------------------------------------------------
virt@@CGameObject ends

CGameObject struct ; (sizeof=360, align=4)
	union
	CObject <>											; 0
	CGameObject@vfptr			dword ?					; 0		virtual table
	ends
	CUsableScriptObject <>								; 260
	CScriptBinder <>									; 272
	m_spawned					byte ?					; 280
	m_server_flags				dword ?					; 284	Flags32
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_ai_location				dword ?					; 288	CAI_ObjectLocation*
	m_story_id					dword ?					; 292
	m_anim_mov_ctrl				dword ?					; 296	animation_movement_controller*
	m_bObjectRemoved			byte ?					; 300
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_ini_file					dword ?					; 304	CInifile*
	m_bCrPr_Activated			byte ?					; 308
	m_flCallbackKey				byte ?					; 309	Flags8	NEW!!!	флаги на включения колбеков
								byte ? ; undefined
								byte ? ; undefined
	m_dwCrPr_ActivationStep		dword ?					; 312
	m_visual_callback	svector_void___stdcall_CKinematics_6 <>
	m_lua_game_object			dword ?					; 344	mutable CScriptGameObject*
	m_script_clsid				dword ?					; 348
	m_spawn_time				dword ?					; 352
	m_callbacks					dword ?					; 356	CALLBACK_MAP*
CGameObject ends										; 360 

CScriptGameObject struct ; (sizeof=8, align=4)
	vfptr						dword ?					; 0		offset
	union
	m_game_object				dword ?					; 4		mutable CGameObject*
	object						dword ?					; 4		mutable CGameObject*	// имитируем инлайн функцию
	ends
CScriptGameObject ends									; 8

FixedMAP_float_MatrixItemS struct
	nodes						dword ?
	pool						dword ?
	limit						dword ?
FixedMAP_float_MatrixItemS ends

xr_resource struct ; (sizeof=4, align=4)
	dwReference					dword ?
xr_resource ends

IRender_Light struct ; (sizeof=8, align=4)
	vfptr						dword ?					; 0		offset
	xr_resource <>										; 4
IRender_Light ends										; 8

R_feedback struct ; (sizeof=4, align=4)
	vfptr						dword ?					   ; offset
R_feedback ends

smapvis struct ; (sizeof=48, align=4)
	R_feedback <>										; 0
	state						dword ?					; 4		enum $2CED4E0780D8A2B8FC96D26DAAF6A213
	invisible					xr_vector <>			; 8		xr_vector<IRender_Visual *,xalloc<IRender_Visual *> > ?
	frame_sleep					dword ?					; 24
	test_count					dword ?					; 28
	test_current				dword ?					; 32
	testQ_V						dword ?					; 36	offset
	testQ_id					dword ?					; 40
	testQ_frame					dword ?					; 44
smapvis ends											; 48

light@@_vis struct ; (sizeof=16, align=4)
	frame2test					dword ?					; 0
	query_id					dword ?					; 4
	query_order					dword ?					; 8
	visible						byte ?					; 12
	pending						byte ?					; 13
	smap_ID						word ?					; 14
light@@_vis ends										; 16

light@@_xform@@_D struct ; (sizeof=84, align=4)
	combine						Fmatrix <>				; 0
	minX						dword ?					; 64
	maxX						dword ?					; 68
	minY						dword ?					; 72
	maxY						dword ?					; 76
	transluent					dword ?					; 80
light@@_xform@@_D ends									; 84

light@@_xform@@_P struct ; (sizeof=256, align=4)
	world						Fmatrix <>				; 0
	view						Fmatrix <>				; 64
	project						Fmatrix <>				; 128
	combine						Fmatrix <>				; 192
light@@_xform@@_P ends									; 256

light@@_xform@@_S struct ; (sizeof=208, align=4)
	view						Fmatrix <>				; 0
	project						Fmatrix <>				; 64
	combine						Fmatrix <>				; 128
	size_						dword ?					; 192
	posX						dword ?					; 196
	posY						dword ?					; 200
	transluent					dword ?					; 204
light@@_xform@@_S ends									; 208

light@@_xform union ; (sizeof=256, align=4)
	D							light@@_xform@@_D <>	; 0
	P							light@@_xform@@_P <>	; 0
	S							light@@_xform@@_S <>	; 0
light@@_xform ends										; 256

vis_data struct ; (sizeof=56, align=4)
	sphere						Fsphere <>				; 0
	box							Fbox <>					; 16
	marker						dword ?					; 40
	accept_frame				dword ?					; 44
	hom_frame					dword ?					; 48
	hom_tested					dword ?					; 52
vis_data ends											; 56

light struct ; (sizeof=624, align=4)
	IRender_Light <>									; 0
	ISpatial <>											; 8
	flags						dword ?					; 60	Flags32
	position					Fvector <>				; 64
	direction					Fvector <>				; 76
	right						Fvector <>				; 88
	range						dword ?					; 100
	cone						dword ?					; 104
	color						Fcolor <>				; 108
	hom							vis_data <>				; 124
	frame_render				dword ?					; 180
	omnipart					dword 6 dup(?)			; 184	offset
	indirect					xr_vector <>			; 208	xr_vector<light_indirect,xalloc<light_indirect> > ?
	indirect_photons			dword ?					; 224
	svis						smapvis <>				; 228
	s_spot						resptr_core <>			; 276	resptr_core<Shader,resptrcode_shader> ?
	s_point						resptr_core <>			; 280	resptr_core<Shader,resptrcode_shader> ?
	m_xform_frame				dword ?					; 284
	m_xform						Fmatrix <>				; 288
	vis							light@@_vis <>			; 352
	X							light@@_xform <>		; 368
;---------------------------NEW------------------------------
	m_f270h						real4 ?					; 
	m_f274h						real4 ?					; 
	m_fLSFSpeed					real4 ?					; 
	m_fLSFAmount				real4 ?					; 
	m_fLSFSMAPJitter			real4 ?					; 
light ends												; 624

