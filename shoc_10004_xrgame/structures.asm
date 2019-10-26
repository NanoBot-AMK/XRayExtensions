;================================================================================
;		Структуры, структуры классов.
;
; (с) НаноБот
;================================================================================
__LevelExplosive			equ <>

IInterface_Function0Proto		typedef proto
IInterface_Function1Proto		typedef proto :DWORD
IInterface_Function2Proto		typedef proto :DWORD, :DWORD
IInterface_Function3Proto		typedef proto :DWORD, :DWORD, :DWORD
IInterface_Function4Proto		typedef proto :DWORD, :DWORD, :DWORD, :DWORD
IInterface_Function5Proto		typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
IInterface_Function6Proto		typedef proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD

IInterface_Function0			typedef ptr IInterface_Function0Proto
IInterface_Function1			typedef ptr IInterface_Function1Proto
IInterface_Function2			typedef ptr IInterface_Function2Proto
IInterface_Function3			typedef ptr IInterface_Function3Proto
IInterface_Function4			typedef ptr IInterface_Function4Proto
IInterface_Function5			typedef ptr IInterface_Function5Proto
IInterface_Function6			typedef ptr IInterface_Function6Proto

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

shared_str struct ; (sizeof=4, align=4)
	p_					dword ?				; 4		str_value*
shared_str ends

resptr_core struct ; (sizeof=4, align=4,)
	p_					dword ?				; 4
resptr_core ends

Frect struct ; (sizeof=16, align=4)
	union
		struct
			x1				dword ?			; 0
			y1				dword ?			; 4
			x2				dword ?			; 8
			y2				dword ?			; 12
		ends
		struct
			left			dword ?			; 0
			top				dword ?			; 4
			right			dword ?			; 8
			bottom			dword ?			; 12
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

SHit struct ; (sizeof=72, align=4)
	Time				dword ?				; 0
	PACKET_TYPE			word ?				; 4
	DestID				word ?				; 6
	power				real4 ?				; 8
	dir					Fvector <>			; 12
	who					dword ?				; 24
	whoID				word ?				; 28
	weaponID			word ?				; 30
	boneID				word ?				; 32
	p_in_bone_space		Fvector <>			; 34
						byte ? ; undefined
						byte ? ; undefined
	impulse				real4 ?				; 48
	hit_type			dword ?				; 52
	ap					dword ?				; 56
	aim_bullet			byte ?				; 60
						byte ? ; undefined
						byte ? ; undefined
						byte ? ; undefined
	BulletID			dword ?				; 64
	SenderID			dword ?				; 68
SHit ends									; 72

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

std@@pair@u32_ref_texture@ struct ; (sizeof=8, align=4)
	first				dword ?				; 0
	second				resptr_core <>		; 4		resptr_core<CTexture,resptrcode_texture> ?
std@@pair@u32_ref_texture@ ends

_Node@std@@pair@u32_ref_texture@ struct ; (sizeof=24, align=4)
	_Left				dword ?						; 0		_Nodeptr	// left subtree, or smallest element if head
	_Parent				dword ?						; 4		_Nodeptr	// parent, or root of tree if head
	_Right				dword ?						; 8		_Nodeptr	// right subtree, or largest element if head
	_Myval				std@@pair@u32_ref_texture@ <>; 12	value_type	// the stored value, unused if head
	_Color				byte ?						; 20	char		// _Red or _Black, _Black if head
	_Isnil				byte ?						; 21	char		// true only if head (also nil) node
						byte ?
						byte ?
_Node@std@@pair@u32_ref_texture@ ends

xr_map struct ; (sizeof=12, align=4)
	_Alval				dword ?				; 0
	_Myhead				dword ?				; 4		_Nodeptr
	_Mysize				dword ?				; 8
xr_map ends									; 12

xr_tree struct ; (sizeof=12, align=4)
	_Alval				dword ?				; 0		_Nodeptr	// allocator object for element values
	_Myhead				dword ?				; 4`	size_type	// pointer to head node
	_Mysize				dword ?				; 8		_Alty		// number of elements
xr_tree ends								; 12	_Alnod;		// allocator object for nodes

xr_list struct ; (sizeof=12, align=4)
	_Alval				dword ?				; 0
	_Myhead				dword ?				; 4		_Nodeptr
	_Mysize				dword ?				; 8
xr_list ends

intrusive_ptr struct ; (sizeof=8, align=4)
	first				dword ?				; 0
	second				dword ?				; 4
intrusive_ptr ends

collide__rq_result struct ; (sizeof=12, align=4)
	O					dword ?				; 0		CObject*
	range				real4 ?				; 4		float
	element				dword ?				; 8		int
collide__rq_result ends

collide__rq_results struct ; (sizeof=16, align=4)
	results				xr_vector <>		; 0		xr_vector<collide::rq_result,xalloc<collide::rq_result> > ?
collide__rq_results ends

collide@@ray_defs struct ; (sizeof=36, align=4)
	start				Fvector <>			; 0
	dir					Fvector <>			; 12
	range				dword ?				; 24
	flags				dword ?				; 28
	tgt					dword ?				; 32
collide@@ray_defs ends						; 36

HUD_SOUND struct			; sizeof 20 bytes 
	m_activeSnd			dword ?				; 0		SSnd*
	sounds				xr_vector <>		; 4		xr_vector<SSnd>
HUD_SOUND ends

SRotation struct ; (sizeof=12, align=4)
	yaw					dword ?				; 0		float
	pitch				dword ?				; 4		float
	roll				dword ?				; 8		float
SRotation ends

str_value struct ; (sizeof=12, align=4, variable size)
	dwReference			dword ?				; 0		u32
	dwLength			dword ?				; 4		u32
	dwCRC				dword ?				; 8		u32
	value				byte 0 dup(?)		; 12	char[]
str_value ends

xr_string struct ; (sizeof=28, align=4)
	union _Bx
		_Buf					byte 16 dup(?)		; 0
		_Ptr					dword ?				; 0		offset
		_Alias					byte 16 dup(?)		; 0
	ends
	_Mysize						dword ?				; 16
	_Myres						dword ?				; 20
	_Alval						dword ?				; 24
xr_string ends										; 28

collide@@rq_results struct ; (sizeof=16, align=4)
	rq_results					xr_vector <>		; 0		collide::rq_result
collide@@rq_results ends							; 16

string16 struct
								byte 16 dup(?)
string16 ends

NET_PacketSizeLimit				equ 8192	; макс. рамер пакета 8 килобайт

NET_Buffer struct ; (sizeof=8196, align=4)
	data						byte NET_PacketSizeLimit dup(?)	; 0
	count						dword ?							; 8192
NET_Buffer ends													; 8196

NET_Packet struct ; (sizeof=8204, align=4)
	B							NET_Buffer <>		; 0
	r_pos						dword ?				; 8196
	timeReceive					dword ?				; 8200
NET_Packet ends										; 8204

ISE_Abstract	struct ; (sizeof=8, align=4)
	ISE_Abstract@vfptr			dword ?				; 0		offset
	m_editor_flags				dword ?				; 4		flags32
ISE_Abstract	ends								; 8

CScriptValueContainer struct ; (sizeof=20, align=4)
	CScriptValueContainer@vfptr	dword ?				; 0		offset
	m_values					xr_vector <>		; 4		xr_vector<CScriptValue *,xalloc<CScriptValue *> > ?
CScriptValueContainer ends							; 20

CPureServerObject struct ; (sizeof=8, align=4)
	IPureSerializeObject_IReader@vfptr		dword ?	; 0
	IPureSerializeObject_IWriter@vfptr		dword ?	; 4
CPureServerObject ends

CSE_Abstract struct ; (sizeof=160, align=8)	__cppobj __declspec(align(8))  : ISE_Abstract, CPureServerObject, CScriptValueContainer
	ISE_Abstract <>									; 0
	CPureServerObject <>							; 8
	CScriptValueContainer <>						; 16
	s_name_replace				dword ?				; 36	LPSTR
	net_Ready					dword ?				; 40	int
	net_Processed				dword ?				; 44	int
	m_wVersion					word ?				; 48	unsigned __int16
	m_script_version			word ?				; 50	u16
	RespawnTime					word ?				; 52	u16
	ID							word ?				; 54	u16
	ID_Parent					word ?				; 56	u16
	ID_Phantom					word ?				; 58	u16
	owner						dword ?				; 60	xrClientData*
	s_name						shared_str <>		; 64
	s_gameid					byte ?				; 68	u8
	s_RP						byte ?				; 69	u8
	s_flags						word ?				; 70	_flags<u16>
	children					xr_vector <>		; 72	xr_vector<u16,xalloc<u16> > 
	o_Position					Fvector <>			; 88
	o_Angle						Fvector <>			; 100
	m_tClassID					qword ?				; 112	unsigned __int64 
	m_script_clsid				dword ?				; 120	int 
	m_ini_string				shared_str <>		; 124
	m_ini_file					dword ?				; 128	CInifile *
	m_bALifeControl				byte ?				; 132	bool 
								byte ?	
	m_tSpawnID					word ?				; 134	u16 
	m_spawn_flags				dword ?				; 136	Flags32 
	client_data					xr_vector <>		; 140	xr_vector<unsigned char,xalloc<unsigned char> > 
								dword ?	; 156
CSE_Abstract ends									; 160

MotionID struct; (sizeof=2, align=2)
	union
		;struct
		idx						word ?					; 0		:14
		slot					word ?					; 0		:2
		;ends
		val						word ?					; 0	u16
	ends
MotionID ends

CHolderCustom struct	; 12 sizeof
	CHolderCustom@vfptr			dword ?				; 0
	m_owner						dword ?				; 4		CGameObject*
	m_ownerActor				dword ?				; 8		CActor*
CHolderCustom ends									; 12

CShootingObject struct		; sizeof 200 bytes 
	CShootingObject@vfptr				dword ?		; 0
	m_vCurrentShootDir					Fvector <>	; 4		Fvector	
	m_vCurrentShootPos					Fvector <>	; 16	Fvector	
	CShootingObject@m_iCurrentParentID	word  ?		; 28	u16		; ID персонажа который иницировал действие
	bWorking							byte  ?		; 30	bool	; Weapon fires now
										byte ? ; undefined
	fTimeToFire							dword ?		; 32	float	
	fvHitPower							Fvector4 <>	; 36	Fvector4
	fHitImpulse							dword ?		; 52	float	
	m_fStartBulletSpeed					dword ?		; 56	float	; скорость вылета пули из ствола
	fireDistance						dword ?		; 60	float	; максимальное расстояние стрельбы
	fireDispersionBase					dword ?		; 64	float	; рассеивание во время стрельбы
	fTime								dword ?		; 68	float	; счетчик времени, затрачиваемого на выстрел
	; для сталкеров, чтоб они знали эффективные границы использования оружия
	CShootingObject@m_fMinRadius		dword ?		; 72	float	
	CShootingObject@m_fMaxRadius		dword ?		; 76	float	
	; Lights
	light_base_color					Fcolor <>	; 80	Fcolor		
	light_base_range					dword ?		; 96	float		
	light_build_color					Fcolor <>	; 100	Fcolor		
	light_build_range					dword ?		; 116	float		
	light_render						dword ?		; 120	ref_light	
	light_var_color						dword ?		; 124	float		
	light_var_range						dword ?		; 128	float		
	light_lifetime						dword ?		; 132	float		
	light_frame							dword ?		; 136	u32			
	light_time							dword ?		; 140	float		
	m_bLightShotEnabled					byte  ?		; 144	bool				; включение подсветки во время выстрела
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_sShellParticles					dword ?		; 148	shared_str			; имя пратиклов для гильз
	vLoadedShellPoint					Fvector <>	; 152	Fvector					
	m_fPredBulletTime					dword ?		; 164	float					
	m_fTimeToAim						dword ?		; 168	float					
	m_bUseAimBullet						dword ?		; 172	BOOL					
	m_sFlameParticlesCurrent			dword ?		; 176	shared_str			; имя пратиклов для огня
	m_sFlameParticles					dword ?		; 180	shared_str			; для выстрела 1м и 2м видом стрельбы
	m_pFlameParticles					dword ?		; 184	CParticlesObject*	; объект партиклов огня
	m_sSmokeParticlesCurrent			dword ?		; 188	shared_str			; имя пратиклов для дыма
	m_sSmokeParticles					dword ?		; 192	shared_str			
	m_sShotParticles					dword ?		; 196	shared_str			; имя партиклов следа от пули
CShootingObject ends

; class CCarWeapon :public CShootingObject
CCarWeapon struct		; sizeof 564 bytes 
	CShootingObject <>
	m_object					dword ?		; 200	CPhysicsShellHolder*
	m_bActive					byte  ?		; 204	bool
	m_bAutoFire					byte  ?		; 205	bool
	m_bShowCrosshair			byte  ?		; 206	bool	//NEW
								byte ? ; undefined
	m_weapon_h					dword ?		; 208	float
	m_rotate_x_bone				word  ?		; 212	u16
	m_rotate_y_bone				word  ?		; 214	u16
	m_fire_bone					word  ?		; 216	u16
	m_camera_bone				word  ?		; 218	u16
	m_tgt_x_rot					dword ?		; 220	float
	m_tgt_y_rot					dword ?		; 224	float
	m_cur_x_rot					dword ?		; 228	float
	m_cur_y_rot					dword ?		; 232	float
	m_bind_x_rot				dword ?		; 236	float
	m_bind_y_rot				dword ?		; 240	float
	m_bind_x					Fvector <>	; 244	Fvector
	m_bind_y					Fvector <>	; 256	Fvector
	m_fire_dir					Fvector <>	; 268	Fvector
	m_fire_pos					Fvector <>	; 280	Fvector
	m_fire_norm					Fvector <>	; 292	Fvector
	m_i_bind_x_xform			Fmatrix4 <>	; 304	Fmatrix
	m_i_bind_y_xform			Fmatrix4 <>	; 368	Fmatrix
	m_fire_bone_xform			Fmatrix4 <>	; 432	Fmatrix
	m_lim_x_rot					Fvector2 <>	; 496	Fvector2
	m_lim_y_rot					Fvector2 <>	; 504	Fvector2	//in bone space
	m_min_gun_speed				dword ?		; 512	float
	m_max_gun_speed				dword ?		; 516	float
	m_Ammo						dword ?		; 520	CCartridge*	
	m_barrel_speed				dword ?		; 524	float
	m_destEnemyDir				Fvector <>	; 528	Fvector
	m_allow_fire				byte  ?		; 540	bool
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_sndShot					HUD_SOUND <>; 544	HUD_SOUND
;------NEW------
	m_firebones					dword ?		; 564	
	m_count_firebones			dword ?		; 568	int
	m_num_firebones				dword ?		; 572	int
	m_parent_id					dword ?		; 542	int		// ID текущего владельца, если его нет, то ID самого CCar
CCarWeapon ends								; 576	sizeof

;------MONSTER_COMMUNITY------
MONSTER_COMMUNITY struct ; (sizeof=8, align=4)
	MONSTER_COMMUNITY@vfptr		dword ?
	m_current_index				dword ?
MONSTER_COMMUNITY ends
;-----------------------------
MAX_IDLES				equ 3
SVehicleAnimCollection struct ; sizeof 12 bytes
	idles_num					word  ?							; 0		u16				
	idles						MotionID  MAX_IDLES dup (<>)	; 2	
	steer_left					MotionID <>						; 8	
	steer_right					MotionID <>						; 10	
SVehicleAnimCollection ends

MAX_BONE_PARAMS			equ 4
CBoneInstance struct ; sizeof 160 bytes
	mTransform				Fmatrix4 <>		; 0		Fmatrix			// final x-form matrix (local to model)
	mRenderTransform		Fmatrix4 <>		; 64	Fmatrix			// final x-form matrix (model_base -> bone -> model)
	Callback				dword ?			; 128	BoneCallback
	Callback_Param			dword ?			; 132	void*
	Callback_overwrite		dword ?			; 136	BOOL			// performance hint - don't calc anims
	param					dword MAX_BONE_PARAMS dup(?); 140	float
	Callback_type			dword ?			; 156	u32				//
CBoneInstance ends	; 160

flRelativeLink			= dword ptr 1
flPositionRigid			= dword ptr 2
flDirectionRigid		= dword ptr 4
CCameraBase struct ; 124 bytes
	CCameraBase@vfptr		dword ?			; 0		виртуальная таблица
	parent					dword ?			; 4		CObject*
	bClampYaw				dword ?			; 8		BOOL
	bClampPitch				dword ?			; 12	BOOL
	bClampRoll				dword ?			; 16	BOOL
	yaw						dword ?			; 20	float
	pitch					dword ?			; 24	float
	roll					dword ?			; 28	float
	m_Flags					dword ?			; 32	Flags32
	style					dword ?			; 36	ECameraStyle
	lim_yaw					Fvector2 <>		; 40	Fvector2
	lim_pitch				Fvector2 <>		; 48	Fvector2
	lim_roll				Fvector2 <>		; 56	Fvector2
	rot_speed				Fvector <>		; 64	Fvector
	vPosition				Fvector <>		; 76	Fvector
	vDirection				Fvector <>		; 88	Fvector
	vNormal					Fvector <>		; 100	Fvector
	f_fov					dword ?			; 112	float
	f_aspect				dword ?			; 116	float
	tag						dword ?			; 120	int
CCameraBase ends							; 124

TEX_INFO struct ; (sizeof=20, align=4)
	file					shared_str <>	; 0		shared_str
	rect					Frect <>		; 4		Frect
TEX_INFO ends								; 20

fastdelegate@@DelegateMemento struct ; (sizeof=8, align=4)
	m_pthis					dword ?			; 0
	m_pFunction				dword ?			; 4
fastdelegate@@DelegateMemento ends

cfTracer					= byte ptr (1 shl 0)
cfRicochet					= byte ptr (1 shl 1)
cfCanBeUnlimited			= byte ptr (1 shl 2)
cfExplosive					= byte ptr (1 shl 3)
cfCallbackOn				= byte ptr (1 shl 4)
cfShellExplosive			= byte ptr (1 shl 5)

CCartridge struct ; (sizeof=56, align=4)		// патрон
	m_ammoSect				shared_str <>	; 0		
	m_kDist					real4 ?			; 4		float
	m_kDisp					real4 ?			; 8		float
	m_kHit					real4 ?			; 12	float
	m_kImpulse				real4 ?			; 16	float
	m_kPierce				real4 ?			; 20	float
	m_kAP					real4 ?			; 24	float
	m_kAirRes				real4 ?			; 28	float
	m_buckShot				dword ?			; 32	int
	m_impair				real4 ?			; 36	float
	fWallmarkSize			real4 ?			; 40	float
	m_u8ColorID				byte ?			; 44	u8
	m_LocalAmmoType			byte ?			; 45	u8
	bullet_material_idx		word ?			; 46	u16
	m_flags					byte ?			; 48	Flags8
	m_tracer_width			byte ?			; 49	byte	NEW Ширина трассера
							byte ? ; undefined
							byte ? ; undefined
	m_InvShortName			shared_str <>	; 52	
CCartridge ends								; 56

;bullet_flag	struct
ricochet_was				= word ptr (1 shl 0)	; пуля срикошетила
explosive					= word ptr (1 shl 1)	; зажигательная пуля, при попадании даёт соотвествующий партикл
allow_tracer				= word ptr (1 shl 2)	; включить трасер
allow_ricochet				= word ptr (1 shl 3)	; разрешить рикошет
allow_sendhit				= word ptr (1 shl 4)	; statistics
skipped_frame				= word ptr (1 shl 5)	; пропуск первой отрисовки
aim_bullet					= word ptr (1 shl 6)	; прицеленная пуля( вылетевшая первой после длительного молчания оружия (1-3 сек.))
bull_callback_on			= word ptr (1 shl 7)	; включить колбек на старт и стоп пули
shell_explosive				= word ptr (1 shl 8)	; арт. снаряд, т.е. это взрывная пуля
shell_exploding				= word ptr (1 shl 9)	; снаряд взорван
;bullet_flag	ends

;//структура, описывающая пулю и ее свойства в полете
SBullet struct ; (sizeof=100, align=4)
	frame_num				dword ?			; 0		u32			//номер кадра на котором была запущена пуля
	flags					word ?			; 4		bullet_flag
	bullet_material_idx		word ?			; 6		u16
	pos						Fvector <>		; 8		Fvector		//текущая позиция
	dir						Fvector <>		; 20	Fvector			
	speed					real4 ?			; 32	float		//текущая скорость
	parent_id				word ?			; 36	u16			//ID персонажа который иницировал действие
	weapon_id				word ?			; 38	u16			//ID оружия из которого была выпущены пуля
	fly_dist				real4 ?			; 40	float		//дистанция которую пуля пролетела
	; //коэфициенты и параметры патрона
	hit_power				real4 ?			; 44	float		// power*cartridge
	hit_impulse				real4 ?			; 48	float		// impulse*cartridge
	; //-------------------------------------------------------------------
	ap						real4 ?			; 52	float
	air_resistance			real4 ?			; 56	float
	; //-------------------------------------------------------------------
	max_speed				real4 ?			; 60	float		// maxspeed*cartridge
	max_dist				real4 ?			; 64	float		// maxdist*cartridge
	pierce					real4 ?			; 68	float
	wallmark_size			real4 ?			; 72	float
	; //-------------------------------------------------------------------
	m_u8ColorID				byte ?			; 76	u8
	m_tracer_width			byte ?			; 77	byte	NEW Ширина трассера
							byte ? ; undefined
							byte ? ; undefined
	; //тип наносимого хита
	hit_type				dword ?			; 80	ALife::EHitType
	; //---------------------------------
	m_dwID					dword ?			; 84	u32
	m_whine_snd				dword ?			; 88	ref_sound
	m_mtl_snd				dword ?			; 92	ref_sound
	; //---------------------------------
	targetID				word ?			; 96	u16
	explosive_id			word ?			; 98	u16		NEW ID объекта CBulletExplosive
SBullet ends	;	// size	 bytes (100)

bullet_test_callback_data struct ; (sizeof=8, align=4)
	pBullet					dword ?			; 0		SBullet*
	bStopTracing			byte ?			; 4		bool
bullet_test_callback_data ends

_hit struct ; (sizeof=8, align=4)
	first					dword ?						; 
	second					dword ?						; 
_hit ends

_event struct ; (sizeof=160, align=4)
	Type_					byte ?						; 0
							byte ? ; undefined
							byte ? ; undefined
							byte ? ; undefined
	dynamic					dword ?						; 4
	Repeated				dword ?						; 8
	result					_hit <>						; 12
	bullet					SBullet <>					; 20
	normal					Fvector <>					; 120
	point					Fvector <>					; 132
	R						collide__rq_result <>		; 144
	tgt_material			word ?						; 156
							byte ? ; undefined
							byte ? ; undefined
_event ends												; 160

xrCriticalSection struct ; (sizeof=4, align=4)
	pmutex						dword ?					; offset
xrCriticalSection ends

ref_shader struct
	p_							dword ?					; 0		resptr_core<Shader,resptrcode_shader>
ref_shader ends

ref_geom struct
	p_							dword ?					; 0		resptr_core<SGeometry,resptrcode_geom>
ref_geom ends

CTracer struct ; (sizeof=24, align=4)
	sh_Tracer					ref_shader <>			; 0		resptr_core<Shader,resptrcode_shader>
	sh_Geom						ref_geom <>				; 4		resptr_core<SGeometry,resptrcode_geom>
	m_aColors					xr_vector <>			; 8		xr_vector<u32,xalloc<u32> >
CTracer ends											; 24

xr_resource struct ; (sizeof=4, align=4)
	dwReference					dword ?
xr_resource ends


CBulletManager struct ; (sizeof=200, align=4)
	CBulletManager@vfptr		dword ?					; 0	offset
	rq_storage					collide@@rq_results <>	; 4		
	rq_spatial					xr_vector <>			; 20	xr_vector<ISpatial *,xalloc<ISpatial *>
	m_rq_results				collide@@rq_results <>	; 36	
	m_WhineSounds				xr_vector <>			; 52	xr_vector<ref_sound,xalloc<ref_sound> >
	m_ExplodeParticles			xr_vector <>			; 68	xr_vector<shared_str,xalloc<shared_str> >
	m_Lock						xrCriticalSection <>	; 84	
	m_Bullets					xr_vector <>			; 88	xr_vector<SBullet,xalloc<SBullet> > ?
	m_BulletsRendered			xr_vector <>			; 104	xr_vector<SBullet,xalloc<SBullet> > ?
	m_Events					xr_vector <>			; 120	xr_vector<CBulletManager::_event,xalloc<CBulletManager::_event> >
	m_dwTimeRemainder			dword ?					; 136	
	tracers						CTracer <>				; 140	
	m_dwStepTime				dword ?					; 164
	m_fHPMaxDist				real4 ?					; 168
	m_fGravityConst				real4 ?					; 172
	m_fAirResistanceK			real4 ?					; 176
	m_fCollisionEnergyMin		real4 ?					; 180
	m_fCollisionEnergyMax		real4 ?					; 184
	m_fTracerWidth				real4 ?					; 188
	m_fTracerLengthMax			real4 ?					; 192
	m_fTracerLengthMin			real4 ?					; 196
;------------------------NEW------------------------
	m_explosions				xr_vector2 <>			; 200	xr_vector<CExplosive,xalloc<CExplosive> > ?
	m_explo_ids					dword ?					; 220	указатель на таблицу с айдишниками.
	m_free_id					dword ?					; 224	крайний свободный айдишник
	m_dwTotalShots				dword ?					; 228	суммарное количество пуль, используется для m_dwID пуль.
	m_type_ballistic			byte ?					; 232
								byte ? ; undefined	
								byte ? ; undefined
								byte ? ; undefined
								dword ?; undefined	236
	m_BoundingVolume			Fbox4 <>				; 240	копия CLevel.ObjectSpace.m_BoundingVolume для быстрого доступа movaps
	m_vecGravityConstDeltaTime	Fvector4 <>				;
CBulletManager ends										; 

;//флаг состояния взрыва
;enum{
flExploding						= byte ptr (1 shl 0)
flExplodEventSent				= byte ptr (1 shl 1)
flReadyToExplode				= byte ptr (1 shl 2)
flExploded						= byte ptr (1 shl 3)
;};

CWalmarkManager struct ; (sizeof=32, align=4)
	m_wallmarks					xr_vector <>	; 0		xr_vector<resptr_core<Shader,resptrcode_shader>,xalloc<resptr_core<Shader,resptrcode_shader>>>
	m_pos						Fvector <>		; 16
	m_owner						dword ?			; 28	CGameObject*
CWalmarkManager ends							; 32

CExplosive struct ; (sizeof=232, align=4)
	CExplosive@vfptr			dword ?					; 0		IDamageSource
	rq_storage					collide@@rq_results <>	; 4		
	union
		m_wallmark_manager		CWalmarkManager <>		; 20	
		struct
								dword 7 dup(?)
			m_game_object		dword ?					; 48	CGameObject*	NEW	смещение = m_wallmark_manager.m_owner
		ends
	ends
	m_iCurrentParentID			word ?					; 52	u16
	m_vExplodePos				Fvector <>				; 54
	m_vExplodeSize				Fvector <>				; 66
	m_vExplodeDir				Fvector <>				; 78
								byte ? ; undefined 90	
								byte ? ; undefined 91
	m_fBlastHit					dword ?					; 92
	m_fBlastHitImpulse			dword ?					; 96
	m_fBlastRadius				dword ?					; 100
	m_fFragsRadius				dword ?					; 104
	m_fFragHit					dword ?					; 108
	m_fFragHitImpulse			dword ?					; 112
	m_iFragsNum					dword ?					; 116
	m_eHitTypeBlast				dword ?					; 120	enum ALife::EHitType
	m_eHitTypeFrag				dword ?					; 124	enum ALife::EHitType
	m_fUpThrowFactor			dword ?					; 128
	m_blasted_objects			xr_vector <>			; 132	<CPhysicsShellHolder *,xalloc<CPhysicsShellHolder *> > ?
	m_fExplodeDuration			dword ?					; 148
	m_fExplodeDurationMax		dword ?					; 152
	m_fExplodeHideDurationMax	dword ?					; 156
	m_explosion_flags			byte ?					; 160	Flags8
								byte ?					; 161
	m_game_object_id			word ?					; 162	u16		NEW	ID собственого объекта или оружия из которого выпустили снаряд
	m_bHideInExplosion			dword ?					; 164
	m_bAlreadyHidden			byte ?					; 168
								byte ? ; undefined 169
								byte ? ; undefined 170
								byte ? ; undefined 171
	m_fFragmentSpeed			dword ?					; 172
	sndExplode					dword ?					; 176	ref_sound
	m_eSoundExplode				dword ?					; 180	enum ESoundTypes
	fWallmarkSize				dword ?					; 184
	m_sExplodeParticles			shared_str <>			; 188	
	m_pLight					dword ?					; 192	resptr_core<IRender_Light,resptrcode_light>
	m_LightColor				Fcolor <>				; 196
	m_fLightRange				dword ?					; 212
	m_fLightTime				dword ?					; 216
	m_bDynamicParticles			dword ?					; 220
	m_pExpParticle				dword ?					; 224	offset
	struct effector
		effect_sect_name		shared_str <>			; 228	
	ends
CExplosive ends											; 232	sizeof

CBulletExplosive struct
	CExplosive <>										; 0
	m_id						dword ?					; 232
	m_halflength_shell			dword ?					; 236	float	полудлина снаряда, м.
CBulletExplosive ends									; 240	sizeof

SStatDetailBData struct ; (sizeof=24, align=4)
	SStatDetailBData@vfptr				dword ?			; 0
	IPureSavableObject_IWriter_@vfptr	dword ?			; 4	
	key									dword ?			; 8
	union
		struct
			int_count					dword ?			; 12
			int_points					dword ?			; 16
		ends
		params							dword 2 dup(?)	; 12	доступ к int_count и int_points через массив
	ends
	str_value							dword ?			; 20
SStatDetailBData ends									; 24

SStatSectionData struct ; (sizeof=28, align=4)
	SStatSectionData@vfptr				dword ?			; 0
	IPureSavableObject_IWriter_@vfptr	dword ?			; 4	
	key									dword ?			; 8
	data								xr_vector <>	; 12
SStatSectionData ends									; 28

CAI_ObjectLocation struct ; (sizeof=12, align=4)
	vfptr								dword ?			; 0
	m_level_vertex_id					dword ?			; 4		u32
	m_game_vertex_id					word ?			; 8		GameGraph::_GRAPH_ID
										byte ? ; undefined
										byte ? ; undefined
CAI_ObjectLocation ends

ICollisionForm	struct ; (sizeof=56, align=4)
	vfptr								dword ?					; 0		offset
	owner								dword ?					; 4		offset
	dwQueryID							dword ?					; 8		u32
	bv_box								Fbox <>					; 12
	bv_sphere							Fsphere <>				; 36
	m_type								dword ?					; 52	enum ECollisionFormType
ICollisionForm	ends											; 56

_QWORD struct ; (sizeof=8, align=4)
	union
	struct
		lo			dword ?			; 0
		hi			dword ?			; 4
	ends
					qword ?			; 0
	ends
_QWORD ends								; 8

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

CUIGameCustom	struct ; (sizeof=56, align=8)
	DLL_Pure <>											; 0
	ISheduled <>										; 16
	uFlags						dword ?					; 24
	m_pgameCaptions				dword ?					; 28	offset
	m_msgs_xml					dword ?					; 32	offset
	m_custom_statics			xr_vector <>			; 36	xr_vector<SDrawStaticStruct,xalloc<SDrawStaticStruct> > ?
								dword ? ; 
CUIGameCustom	ends									; 56

CUIGameSP struct ; (sizeof=80, align=8)
	CUIGameCustom <>									; 0
	m_game						dword ?					; 56	game_cl_Single*
	InventoryMenu				dword ?					; 60	CUIInventoryWnd*
	PdaMenu						dword ?					; 64	CUIPdaWnd*
	TalkMenu					dword ?					; 68	CUITalkWnd*
	UICarBodyMenu				dword ?					; 72	CUICarBodyWnd*
	UIChangeLevelWnd			dword ?					; 76	CChangeLevelWnd*
CUIGameSP ends											; 80

IUISimpleWindow struct ; (sizeof=4, align=4)
	vfptr						dword ?					; offset
IUISimpleWindow ends

CUISimpleWindow struct ; (sizeof=28, align=4)
	IUISimpleWindow <>									; 0
	m_bShowMe					byte ?					; 4
	m_wndPos					Fvector2 <>				; 5
	m_wndSize					Fvector2 <>				; 13
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_alignment					dword ?					; 24	enum EWindowAlignment
CUISimpleWindow ends									; 28

CUIWindow struct ; (sizeof=92, align=4)
	CUISimpleWindow <>
	m_windowName				shared_str <>			; 28
	m_ChildWndList				xr_list <>				; 32	ui_list<CUIWindow *> ?
	m_pParentWnd				dword ?					; 44	offset
	m_pMouseCapturer			dword ?					; 48	offset
	m_pOrignMouseCapturer		dword ?					; 52	offset
	m_pKeyboardCapturer			dword ?					; 56	offset
	m_pMessageTarget			dword ?					; 60	offset
	m_pFont						dword ?					; 64	offset
	cursor_pos					Fvector2 <>				; 68
	m_dwLastClickTime			dword ?					; 76
	m_dwFocusReceiveTime		dword ?					; 80
	m_bAutoDelete				byte ?					; 84
	m_bPP						byte ?					; 85
	m_bIsEnabled				byte ?					; 86
	m_bCursorOverWindow			byte ?					; 87
	m_bClickable				byte ?					; 88
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CUIWindow ends											; 92

CUIDialogWnd struct ; (sizeof=0x64, align=4)
	CUIWindow <>
	m_pHolder					dword ?					; offset
	m_bWorkInPause				byte ?					; 
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CUIDialogWnd ends

CUITalkWnd struct ; (sizeof=144, align=4)
	CUIDialogWnd <>										; 0
	m_sound						ref_sound <>			; 100
	UITradeWnd					dword ?					; 104	offset
	UITalkDialogWnd				dword ?					; 108	offset
	m_pActor					dword ?					; 112	offset
	m_pOurInvOwner				dword ?					; 116	offset
	m_pOthersInvOwner			dword ?					; 120	offset
	m_pOurDialogManager			dword ?					; 124	offset
	m_pOthersDialogManager		dword ?					; 128	offset
	m_bNeedToUpdateQuestions	byte ?					; 132
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_pCurrentDialog			intrusive_ptr <>		; 136	intrusive_ptr<CPhraseDialog,intrusive_base> ?
CUITalkWnd ends

pure_relcase	struct ; (sizeof=8, align=4)
	pure_relcase@vfptr			dword ?					; offset
	m_ID						dword ?
pure_relcase	ends

Feel@@Vision	struct ; (sizeof=104, align=4)
	;pure_relcase <>									; 0
	Feel@@Vision@vfptr			dword ?					; 0		offset
	Feel@@Vision@m_ID			dword ?					; 4		int
	seen						xr_vector <>			; 8		xr_vector<CObject *,xalloc<CObject *> > ?
	query						xr_vector <>			; 24	xr_vector<CObject *,xalloc<CObject *> > ?
	diff						xr_vector <>			; 40	xr_vector<CObject *,xalloc<CObject *> > ?
	RQR							collide@@rq_results <>	; 56	
	r_spatial					xr_vector <>			; 72	xr_vector<ISpatial *,xalloc<ISpatial *> > ?
	feel_visible				xr_vector <>			; 88	xr_vector<Feel::Vision::feel_visible_Item,xalloc<Feel::Vision::feel_visible_Item> > ?
Feel@@Vision	ends									; 104

IInputReceiver	struct ; (sizeof=4, align=4)
	IInputReceiver@vfptr		dword ?					; offset
IInputReceiver	ends

Feel@@Sound		struct ; (sizeof=4, align=4)
	Feel@@Sound@vfptr			dword ?					; offset
Feel@@Sound		ends

Feel@@Touch		struct ; (sizeof=56, align=4)
	;pure_relcase <>									; 0
	Feel@@Touch@vfptr			dword ?					; 0		offset
	Feel@@Touch@m_ID			dword ?					; 4		int
	feel_touch_disable			xr_vector <>			; 8		xr_vector<Feel::Touch::DenyTouch,xalloc<Feel::Touch::DenyTouch> > ?
	feel_touch					xr_vector <>			; 24	xr_vector<CObject *,xalloc<CObject *> > ?
	q_nearest					xr_vector <>			; 40	xr_vector<CObject *,xalloc<CObject *> > ?
Feel@@Touch		ends									; 56

CObject__ObjectProperties struct ; (sizeof=4, align=4)
	union __s0
		_bf0					dword ?
	ends
	storage						dword ?
CObject__ObjectProperties ends

CParticlesPlayer struct ; (sizeof=56, align=8)
	CParticlesPlayer@vfptr		dword ?					; 0 offset
								dword ? ; undefined
	bone_mask					qword ?					; 8
	m_Bones						xr_vector <>			; 16
	m_self_object				dword ?					; 32 offset
	m_bActiveBones				byte ?					; 36
	parent_vel					Fvector <>				; 37
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
								dword ? ; undefined
CParticlesPlayer ends									; 56

dMass struct ; (sizeof=68, align=4)
	mass						dword ?					; 0
	c_							dword 4 dup(?)			; 4
	I							dword 12 dup(?)			; 20
dMass ends												; 68

CCycleConstStorage@_vector3@float@2@ struct ; (sizeof=26, align=2)
	array						Fvector 2 dup(<>)		; 0
	first						word ?					; 24
CCycleConstStorage@_vector3@float@2@ ends				; 26

CCycleConstStorage@_quaternion@float@2@ struct ; (sizeof=34, align=2)
	array						Fquaternion 2 dup(<>)	; 0
	first						word ?					; 32
CCycleConstStorage@_quaternion@float@2@ ends			; 34

CPHInterpolation struct ; (sizeof=64, align=4)
	m_body						dword ?					; 0		offset
	qPositions					CCycleConstStorage@_vector3@float@2@ <>	; 4
	qRotations					CCycleConstStorage@_quaternion@float@2@ <>	; 30
CPHInterpolation ends									; 64

CPHSynchronize	struct ; (sizeof=4, align=4)
	CPHSynchronize@vfptr		dword ?					; 0		offset
CPHSynchronize	ends									; 4

SDisableVector	struct ; (sizeof=24, align=4)
	sum							Fvector <>				; 0
	previous					Fvector <>				; 12
SDisableVector	ends									; 24

SOneDDOParams	struct ; (sizeof=8, align=4)
	velocity					dword ?					; 0
	acceleration				dword ?					; 4
SOneDDOParams	ends									; 8

CPHDisablingBase struct ; (sizeof=80, align=0x10)
	CPHDisablingBase@vfptr		dword ?					; 0		offset
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_mean_velocity				SDisableVector <>		; 8
	m_mean_acceleration			SDisableVector <>		; 32
	m_params					SOneDDOParams <>		; 56
	gap40						byte 16 dup(?)			; 64
CPHDisablingBase ends									; 80

CPHDisablingTranslational struct ; (sizeof=84, align=4)
	CPHDisablingBase <>									; 0
	gap50						byte 4 dup(?)			; 80
CPHDisablingTranslational ends							; 84

CPHDisablingFull struct ; (sizeof=0x94, align=4)
	CPHDisablingTranslational <>						; 0
	anonymous_0					byte 64 dup(?)			; 84
CPHDisablingFull ends									; 148

CPhysicsBase struct ; (sizeof=68, align=4)
	CPhysicsBase@vfptr			dword ?					; 0		offset
	mXFORM						Fmatrix <>				; 4
CPhysicsBase ends										; 68

CPhysicsElement struct ; (sizeof=0x48, align=4)
	CPhysicsBase <>										; 0
	m_SelfID					word ?					; 68
								byte ? ; undefined
								byte ? ; undefined
CPhysicsElement ends									; 72

CPHElement struct ; (sizeof=460, align=4)
	CPhysicsElement <>									; 0
	CPHSynchronize <>									; 72
	CPHDisablingFull <>									; 76
	anonymous_1					byte 40 dup(?)			; 224
	m_mass						dMass <>				; 264
	m_body						dword ?					; 332	dBodyID
	m_l_scale					dword ?					; 336
	m_w_scale					dword ?					; 340
	m_parent_element			dword ?					; 344	CPHElement*
	m_shell						dword ?					; 348	CPHShell*
	m_body_interpolation		CPHInterpolation <>		; 352
	m_fratures_holder			dword ?					; 416	CPHFracturesHolder*
	m_w_limit					dword ?					; 420
	m_l_limit					dword ?					; 424
	k_w							dword ?					; 428
	k_l							dword ?					; 432
	m_flags						byte ?					; 436	Flags8
	gap1B5						byte 23 dup(?)			; 437
CPHElement ends											; 460

; ---------------------------------------------------------------------------

dxWorld struct ; (sizeof=16, align=4)
	firstbody					dword ?					; 0
	firstjoint					dword ?					; 4
	nb							dword ?					; 8
	nj							dword ?					; 12
dxWorld ends											; 16

CPHIslandFlags	struct ; (sizeof=1)
	flags						byte ?					; 0		Flags8
CPHIslandFlags	ends									; 1

CPHIsland struct ; (sizeof=0x30, align=4)
	dxWorld <>											; 0
	CPHIsland@m_flags			CPHIslandFlags <>		; 16
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_first_body				dword ?					; 20
	m_first_joint				dword ?					; 24
	m_joints_tail				dword ?					; 28
	m_bodies_tail				dword ?					; 32
	m_self_active				dword ?					; 36
	m_nj						dword ?					; 40
	m_nb						dword ?					; 44
CPHIsland ends											; 48

CPHMoveStorage struct ; (sizeof=16, align=4)
	m_trace_geometries			xr_vector <>			; 0		xr_vector<CODEGeom *,xalloc<CODEGeom *> > ?
CPHMoveStorage ends										; 16


CPhysicsShell struct ; (sizeof=72, align=4)
	CPhysicsBase <>										; 0
	m_pKinematics				dword ?					; 68	offset
CPhysicsShell ends										; 72

CPHObject struct ; (sizeof=136, align=4)
	ISpatial <>											; 0
	next						dword ?					; 52
	tome						dword ?					; 56
	CPHObject@m_flags			byte ?					; 60	Flags8
								byte ? ; undefined
	m_InitiatorID				word ?					; 62	NEW!!!	u16 ID вредителя, кто бросил камень?
	m_island					CPHIsland <>			; 64
	m_collide_bits				dword ?					; 112
	m_check_count				byte ?					; 116
	m_collide_class_bits		dword ?					; 117	flags32
	AABB						Fvector <>				; 121
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CPHObject ends											; 136

CPHShell struct ; (sizeof=332, align=4)
	CPhysicsShell <>									; 0
	CPHObject <>										; 72
	m_active_count				word ?					; 208
	m_flags						byte ?					; 210	Flags8
								byte ? ; undefined
	elements					xr_vector <>			; 212	xr_vector<CPHElement *,xalloc<CPHElement *> > ?
	joints						xr_vector <>			; 228	xr_vector<CPHJoint *,xalloc<CPHJoint *> > ?
	m_spliter_holder			dword ?					; 244	offset
	m_traced_geoms				CPHMoveStorage <>		; 248
	m_space						dword ?					; 264	offset
	m_object_in_root			Fmatrix <>				; 268
CPHShell ends											; 332

CPHSplitedShell struct ; (sizeof=336, align=4)
	CPHShell <>											; 0
	m_max_AABBradius			real4 ?					; 332
CPHSplitedShell ends									; 336

CPhysicsShellHolder struct ; (sizeof=424, align=8)
	CGameObject <>										; 0
	CParticlesPlayer <>									; 360
	b_sheduled					byte ?					; 416
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_pPhysicsShell				dword ?					; 420	CPHShell*
CPhysicsShellHolder ends								; 424

CDamageManager	struct ; (sizeof=16, align=4)
	CDamageManager@vfptr		dword ?					; 0 offset
	m_default_hit_factor		dword ?					; 4
	m_default_wound_factor		dword ?					; 8
	CDamageManager@m_object		dword ?					; 12	CObject*
CDamageManager	ends									; 16

CInventorySlot	struct ; (sizeof=16, align=4)
	CInventorySlot@vfptr			dword ?				; 0		offset
	m_pIItem						dword ?				; 4		PIItem
	m_bPersistent					byte ?				; 8
	m_bVisible						byte ?				; 9
									byte ? ; undefined
									byte ? ; undefined
	m_blockCounter					dword ?				; 12
CInventorySlot	ends									; 16

CInventory struct ; (sizeof=128, align=4)
	CInventory@vfptr			dword ?					; 0		offset
	m_all						xr_vector <>			; 4		xr_vector<CInventoryItem *,xalloc<CInventoryItem *> > ?
	m_ruck						xr_vector <>			; 20	xr_vector<CInventoryItem *,xalloc<CInventoryItem *> > ?
	m_belt						xr_vector <>			; 36	xr_vector<CInventoryItem *,xalloc<CInventoryItem *> > ?
	m_slots						xr_vector <>			; 52	xr_vector<CInventorySlot,xalloc<CInventorySlot> > ?
	m_pTarget					dword ?					; 68	PIItem
	m_iActiveSlot				dword ?					; 72
	m_iNextActiveSlot			dword ?					; 76
	m_iPrevActiveSlot			dword ?					; 80
	m_iLoadActiveSlot			dword ?					; 84
	m_iLoadActiveSlotFrame		dword ?					; 88
	m_ActivationSlotReason		dword ?					; 92	enum EActivationReason
	m_pOwner					dword ?					; 96	CInventoryOwner*
	m_bBeltUseful				byte ?					; 100
	m_bSlotsUseful				byte ?					; 101
								byte ? ; undefined
								byte ? ; undefined
	m_fMaxWeight				dword ?					; 104
	m_fTotalWeight				dword ?					; 108
	m_iMaxBelt					dword ?					; 112
	m_fTakeDist					dword ?					; 116
	m_dwModifyFrame				dword ?					; 120
	m_drop_last_frame			byte ?					; 124
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CInventory ends											; 128

CAttachmentOwner struct ; (sizeof=36, align=4)
	CAttachmentOwner@vfptr		dword ?					; 0		offset
	m_attach_item_sections		xr_vector <>			; 4		xr_vector<shared_str,xalloc<shared_str> > ?
	m_attached_objects			xr_vector <>			; 20	xr_vector<CAttachableItem *,xalloc<CAttachableItem *> > ?
CAttachmentOwner ends									; 36

CInventoryOwner struct ; (sizeof=120, align=4)
	CAttachmentOwner <>									; 0
	m_inventory					dword ?					; 36	CInventory*
	m_money						dword ?					; 40
	m_pTrade					dword ?					; 44	offset
	m_bTalking					byte ?					; 48
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_pTalkPartner				dword ?					; 52	offset
	m_bAllowTalk				byte ?					; 56
	m_bAllowTrade				byte ?					; 57
								byte ? ; undefined
								byte ? ; undefined
	m_tmp_active_slot_num		dword ?					; 60
	m_known_info_registry		dword ?					; 64	offset
	m_pCharacterInfo			dword ?					; 68	offset
	m_game_name					xr_string <>			; 72	std::basic_string<char,std::char_traits<char>,xalloc<char> > ?	sizeof 28 bytes
	m_item_to_spawn				shared_str <>			; 100
	m_ammo_in_box_to_spawn		dword ?					; 104
	m_trade_parameters			dword ?					; 108	offset
	m_purchase_list				dword ?					; 112	offset
	m_need_osoznanie_mode		dword ?					; 116
CInventoryOwner ends									; 120

CInventoryBox	struct ; (sizeof=380, align=4)
	CGameObject <>										; 0
	m_items						xr_vector <>			; 360	xr_vector<u16,xalloc<u16> > ?
	m_in_use					byte ?					; 376
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CInventoryBox	ends									; 380

CPhraseDialogManager struct ; (sizeof=52, align=4)
	CPhraseDialogManager@vfptr	dword ?					; 0		offset
	m_CheckedDialogs			xr_vector <>			; 4		xr_vector<shared_str,xalloc<shared_str> > ?
	m_ActiveDialogs				xr_vector <>			; 20	xr_vector<intrusive_ptr<CPhraseDialog,intrusive_base>,xalloc<intrusive_ptr<CPhraseDialog,intrusive_base> > > ?
	m_AvailableDialogs			xr_vector <>			; 36	xr_vector<intrusive_ptr<CPhraseDialog,intrusive_base>,xalloc<intrusive_ptr<CPhraseDialog,intrusive_base> > > ?
CPhraseDialogManager ends								; 52

SStepParam_step struct ; (sizeof=8, align=4)
	time						dword ?						; 0
	power						dword ?						; 4
SStepParam_step ends

SStepParam struct ; (sizeof=36, align=4)
	step						SStepParam_step 4 dup(<>)	; 0
	cycles						byte ?						; 32
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
SStepParam ends												; 36

SStepInfo_activity struct ; (sizeof=2)
	handled						byte ?
	cycle						byte ?
SStepInfo_activity ends

SStepInfo struct ; (sizeof=48, align=4)
	activity					SStepInfo_activity 4 dup(<>); 0
	params						SStepParam <>				; 8
	disable						byte ?						; 44
	cur_cycle					byte ?						; 45
								byte ? ; undefined
								byte ? ; undefined
SStepInfo ends												; 48

associative_vector struct ; (sizeof=0x14, align=4)
	; xr_vector<std::pair<MotionID,SStepParam>,xalloc<std::pair<MotionID,SStepParam> > > ?
	_Myfirst					dword ?	; pointer to beginning of array			; указатель на начало массива
	_Mylast						dword ?	; pointer to current end of sequence	; указатель на текущий конец последовательности
	_Myend						dword ?	; pointer to end of array				; указатель на конец массива
	_Alval						dword ?	; allocator object for values			; объект{цель} программы распределения для значений
	gap							byte ?
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
associative_vector ends

CStepManager struct ; (sizeof=96, align=4)
	CStepManager@vfptr			dword ?					; 0		offset
	m_legs_count				byte ?					; 4
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_steps_map					associative_vector <>	; 8		associative_vector<MotionID,SStepParam,std::less<MotionID> > ?
	m_step_info					SStepInfo <>			; 28
	CStepManager@m_object		dword ?					; 76	CEntityAlive*
	m_foot_bones				word 4 dup(?)			; 80
	m_blend						dword ?					; 88	offset
	m_time_anim_started			dword ?					; 92
CStepManager ends										; 96
; ---------------------------------------------------------------------------

CEntity struct ; (sizeof=496, align=8) 
	CPhysicsShellHolder <>								; 0
	CDamageManager <>									; 424
	CEntity@m_entity_condition		dword ?				; 440 CEntityConditionSimple*
									dword ? ; undefined
	m_dwBodyRemoveTime				qword ?				; 448
	m_fMorale						dword ?				; 456
	id_Team							dword ?				; 460
	id_Squad						dword ?				; 464
	id_Group						dword ?				; 468
	m_fFood							dword ?				; 472
	m_level_death_time				dword ?				; 476
	m_game_death_time				qword ?				; 480
	m_killer_id						word ?				; 488
	m_registered_member				byte ?				; 490
									byte ? ; undefined
									dword ? ; undefined
CEntity ends											; 496

CEntityAlive struct ; (sizeof=568, align=8)
	CEntity <>											; 0
	m_bMobility						byte ?				; 496
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_fAccuracy						dword ?				; 500
	m_fIntelligence					dword ?				; 504
	m_ParticleWounds				xr_vector <>		; 508	xr_vector<CWound *,xalloc<CWound *> >
	m_BloodWounds					xr_vector <>		; 524	xr_vector<CWound *,xalloc<CWound *> >
	monster_community				dword ?				; 540	offset
	CEntityAlive@m_entity_condition	dword ?				; 544	CEntityCondition*
	m_material_manager				dword ?				; 548	offset
	m_ef_creature_type				dword ?				; 552
	m_ef_weapon_type				dword ?				; 556
	m_ef_detector_type				dword ?				; 560
									dword ? ; undefined
CEntityAlive ends										; 568

CScriptEntity	struct ; (sizeof=76, align=4)
	CScriptEntity@vfptr			dword ?					; 0		offset
	CScriptEntity@m_object		dword ?					; 4		CGameObject*
	m_monster					dword ?					; 8		offset
	m_initialized				byte ?					; 12
	m_can_capture				byte ?					; 13
								byte ? ; undefined
								byte ? ; undefined
	m_tpActionQueue				xr_deque <>				; 16	xr_deque<CScriptEntityAction *,xalloc<CScriptEntityAction *> >
	m_bScriptControl			byte ?					; 36
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_caScriptName				dword ?					; 40	shared_str
	m_tpNextAnimation			word ?					; 44	MotionID
	m_use_animation_movement_controller byte ?			; 46
								byte ? ; undefined
	m_tpCurrentEntityAction		dword ?					; 48	offset
	m_tpScriptAnimation			word ?					; 52	MotionID
								byte ? ; undefined
								byte ? ; undefined
	m_current_sound				dword ?					; 56	offset
	m_saved_sounds				xr_vector <>			; 60	xr_vector<CScriptEntity::CSavedSound,xalloc<CScriptEntity::CSavedSound> >
CScriptEntity	ends									; 76

CPHUpdateObject struct ; (sizeof=16, align=4)
	CPHUpdateObject@vfptr		dword ?					; 0
	next						dword ?					; 4	offset
	tome						dword ?					; 8	offset
	b_activated					byte ?					; 12
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CPHUpdateObject ends									; 16

CPHDestroyableNotificate struct ; (sizeof=4, align=4)
	CPHDestroyableNotificate@vfptr	dword ?				; 0 offset
CPHDestroyableNotificate ends							; 4

CPHSkeleton	struct ; (sizeof=36, align=4)
	CPHDestroyableNotificate <>							; 0
	b_removing					byte ?					; 4
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_remove_time				dword ?					; 8
	m_unsplited_shels			xr_vector <>			; 12	xr_vector<std::pair<CPhysicsShell *,u16>,xalloc<std::pair<CPhysicsShell *,u16> > >
	m_startup_anim				dword ?					; 28	shared_str
	m_flags						byte ?					; 32	_flags<unsigned char>
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
CPHSkeleton	ends										; 36

CDamagableItem	struct ; (sizeof=16, align=4)
	CDamagableItem@vfptr		dword ?					; 0 offset
	m_levels_num				word ?					; 4
								byte ? ; undefined
								byte ? ; undefined
	m_max_health				dword ?					; 8
	m_level_applied				word ?					; 12
								byte ? ; undefined
								byte ? ; undefined
CDamagableItem	ends									; 16

CPHDestroyableNotificator struct ; (sizeof=4, align=4)
	CPHDestroyableNotificator@vfptr		dword ?					; 0 offset
CPHDestroyableNotificator ends									; 4

CPHDestroyable	struct ; (sizeof=112, align=4)
	CPHDestroyableNotificator <>								; 0
	m_destroyed_obj_visual_names		xr_vector <>			; 4		xr_vector<shared_str,xalloc<shared_str> > 
	m_notificate_objects				xr_vector <>			; 20	xr_vector<CPHDestroyableNotificate *,xalloc<CPHDestroyableNotificate *> >
	m_depended_objects					word ?					; 36
	CPHDestroyable@m_flags				byte ?					; 38	_flags<unsigned char>
										byte ? ; undefined
	m_fatal_hit							SHit <>					; 40
CPHDestroyable	ends											; 112

CPHCollisionDamageReceiver struct ; (sizeof=20, align=4)
	CPHCollisionDamageReceiver@vfptr	dword ?					; 0 offset
	m_controled_bones					xr_vector<>				; 4		xr_vector<std::pair<u16,float>,xalloc<std::pair<u16,float> > > ?
CPHCollisionDamageReceiver ends									; 20

svector@float_11@ struct ; (sizeof=48, align=4)
	array								dword 11 dup(?)			; 0
	count								dword ?					; 44
svector@float_11@ ends											; 48

CHitImmunity struct ; (sizeof=52, align=4)
	CHitImmunity@vfptr					dword ?					; 0 offset
	m_HitTypeK							svector@float_11@ <>	; 4		HitImmunity::HitTypeSVec
CHitImmunity ends												; 52

CEntityCondition@@SConditionChangeV struct ; (sizeof=32, align=4)
	m_fV_Radiation						dword ?					; 0
	m_fV_PsyHealth						dword ?					; 4
	m_fV_Circumspection					dword ?					; 8
	m_fV_EntityMorale					dword ?					; 12
	m_fV_RadiationHealth				dword ?					; 16
	m_fV_Bleeding						dword ?					; 20
	m_fV_WoundIncarnation				dword ?					; 24
	m_fV_HealthRestore					dword ?					; 28
CEntityCondition@@SConditionChangeV ends						; 32

CEntityConditionSimple struct ; (sizeof=12, align=4)
	CEntityConditionSimple@vfptr		dword ?					; 0		offset
	m_fHealth							dword ?					; 4
	m_fHealthMax						dword ?					; 8
CEntityConditionSimple ends										; 12

CEntityCondition struct ; (sizeof=240, align=8)
	CEntityConditionSimple <>									; 0
	CHitImmunity <>												; 12
	m_use_limping_state					byte ?					; 64
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	CEntityCondition@m_object			dword ?					; 68	offset
	m_WoundVector						xr_vector <>			; 72	xr_vector<CWound *,xalloc<CWound *> > ?
	m_fPower							dword ?					; 88
	m_fRadiation						dword ?					; 92
	m_fPsyHealth						dword ?					; 96
	m_fEntityMorale						dword ?					; 100
	m_fPowerMax							dword ?					; 104
	m_fRadiationMax						dword ?					; 108
	m_fPsyHealthMax						dword ?					; 112
	m_fEntityMoraleMax					dword ?					; 116
	m_fDeltaHealth						dword ?					; 120
	m_fDeltaPower						dword ?					; 124
	m_fDeltaRadiation					dword ?					; 128
	m_fDeltaPsyHealth					dword ?					; 132
	m_fDeltaCircumspection				dword ?					; 136
	m_fDeltaEntityMorale				dword ?					; 140
	m_change_v							CEntityCondition@@SConditionChangeV <>; 144
	m_fMinWoundSize						dword ?					; 176
	m_bIsBleeding						byte ?					; 180
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_fHealthHitPart					dword ?					; 184
	m_fPowerHitPart						dword ?					; 188
	m_fHealthLost						dword ?					; 192
										dword ? ; undefined
	m_iLastTimeCalled					qword ?					; 200
	m_fDeltaTime						dword ?					; 208
	m_pWho								dword ?					; 212	offset
	m_iWhoID							word ?					; 216
										byte ? ; undefined
										byte ? ; undefined
	m_fHitBoneScale						dword ?					; 220
	m_fWoundBoneScale					dword ?					; 224
	m_limping_threshold					dword ?					; 228
	m_bTimeValid						byte ?					; 232
	m_bCanBeHarmed						byte ?					; 233
										byte ? ; undefined
										byte ? ; undefined
										dword ? ; undefined
CEntityCondition ends											; 240

CDelayedActionFuse struct ; (sizeof=16, align=4)
	CDelayedActionFuse@vfptr		dword ?				; 0 offset
	m_dafflags						byte ?				; 4		_flags<unsigned char>
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_fTime							dword ?				; 8
	m_fSpeedChangeCondition			dword ?				; 12
CDelayedActionFuse ends									; 16

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
	sphere								Fsphere <>		; 0
	box									Fbox <>			; 16
	marker								dword ?			; 40
	accept_frame						dword ?			; 44
	hom_frame							dword ?			; 48
	hom_tested							dword ?			; 52
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
	m_f278h						real4 ?					; 
	m_f27Ch						real4 ?					; 
	m_f280h						real4 ?					; 
light ends												; 624

CCarDamageParticles struct ; (sizeof=48, align=4)
	bones1						xr_vector <>			; 0		xr_vector<u16,xalloc<u16> >
	bones2						xr_vector <>			; 16	xr_vector<u16,xalloc<u16> >
	m_wheels_damage_particles1	dword ?					; 32	shared_str
	m_wheels_damage_particles2	dword ?					; 36	shared_str
	m_car_damage_particles1		dword ?					; 40	shared_str
	m_car_damage_particles2		dword ?					; 44	shared_str
CCarDamageParticles ends								; 48

CCarLights struct ; (sizeof=20, align=4)
	m_lights					xr_vector <>			; 0		xr_vector<SCarLight *,xalloc<SCarLight *> >
	m_pcar						dword ?					; 16	offset
CCarLights ends											; 20

ectFirst						equ 0
ectChase						equ 1
ectFree							equ 2

CCar struct ; (sizeof=1592, align=8)
;------------------------Classes-----------------------------
	CEntity <>											; 0
	CScriptEntity <>									; 496
	CPHUpdateObject <>									; 572
	CHolderCustom <>									; 588
	CPHSkeleton <>										; 600
	CDamagableItem <>									; 636
	CPHDestroyable <>									; 652
	CPHCollisionDamageReceiver <>						; 764
	CHitImmunity <>										; 784
	CExplosive <>										; 836
	CDelayedActionFuse <>								; 1068
;----------------------Properties-----------------------------
	RQR							collide@@rq_results <>	; 1084	
	async_calls					word ?					; 1100	Flag16_flags<u16>
								byte ? ; undefined
								byte ? ; undefined
	m_damage_particles			CCarDamageParticles <>	; 1104
	rsp							byte ?					; 1152
	lsp							byte ?					; 1153
	fwp							byte ?					; 1154
	bkp							byte ?					; 1155
	brp							byte ?					; 1156
	m_root_transform			Fmatrix <>				; 1157
	m_exit_position				Fvector <>				; 1221
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	e_state_drive				dword ?					; 1236	enum CCar::eStateDrive
	e_state_steer				dword ?					; 1240	enum CCar::eStateSteer
	b_wheels_limited			byte ?					; 1248
	b_engine_on					byte ?					; 1249
	b_clutch					byte ?					; 1250
	b_starting					byte ?					; 1251
	b_stalling					byte ?					; 1252
	b_breaks					byte ?					; 1253
	b_transmission_switching	byte ?					; 1254
								byte ? ; undefined
	m_dwStartTime				dword ?					; 1252
	m_fuel						dword ?					; 1256
	m_fuel_tank					dword ?					; 1260
	m_fuel_consumption			dword ?					; 1264
	m_driver_anim_type			word ?					; 1268
								byte ? ; undefined
								byte ? ; undefined
	m_break_start				dword ?					; 1272
	m_break_time				dword ?					; 1276
	m_breaks_to_back_rate		dword ?					; 1280
	m_power_neutral_factor		dword ?					; 1284
	b_exploded					byte ?					; 1288
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_car_sound					dword ?					; 1292	offset
	m_car_weapon				dword ?					; 1296	CCarWeapon*
	m_steer_angle				dword ?					; 1300
	m_repairing					byte ?					; 1304
								byte ? ; undefined
	m_bone_steer				word ?					; 1306
	camera						dword 3 dup(?)			; 1308	[3]CCameraBase*
	active_camera				dword ?					; 1320	CCameraBase*
	m_camera_position			Fvector <>				; 1324
	m_wheels_map				xr_map <>				; 1336	xr_map<u16,CCar::SWheel,std::less<u16>,xalloc<std::pair<u16,CCar::SWheel> > >
	m_driving_wheels			xr_vector <>			; 1348	xr_vector<CCar::SWheelDrive,xalloc<CCar::SWheelDrive> > 
	m_steering_wheels			xr_vector <>			; 1364	xr_vector<CCar::SWheelSteer,xalloc<CCar::SWheelSteer> >
	m_breaking_wheels			xr_vector <>			; 1380	xr_vector<CCar::SWheelBreak,xalloc<CCar::SWheelBreak> >
	m_exhausts					xr_vector <>			; 1396	xr_vector<CCar::SExhaust,xalloc<CCar::SExhaust> >
	m_exhaust_particles			dword ?					; 1412	shared_str
	m_doors						xr_map <>				; 1416	xr_map<u16,CCar::SDoor,std::less<u16>,xalloc<std::pair<u16,CCar::SDoor> > >
	m_doors_update				xr_vector <>			; 1428	xr_vector<CCar::SDoor *,xalloc<CCar::SDoor *> >
	m_gear_ratious				xr_vector <>			; 1444	xr_vector<_vector3<float>,xalloc<_vector3<float> > >
	m_sits_transforms			xr_vector <>			; 1460	xr_vector<_matrix<float>,xalloc<_matrix<float> > >
	m_current_gear_ratio		dword ?					; 1476
	b_auto_switch_transmission	byte ?					; 1480
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	m_doors_torque_factor		dword ?					; 1484
	m_max_power					dword ?					; 1488
	m_power_increment_factor	dword ?					; 1492
	m_power_decrement_factor	dword ?					; 1496
	m_rpm_increment_factor		dword ?					; 1500
	m_rpm_decrement_factor		dword ?					; 1504
	m_a							dword ?					; 1508
	m_b							dword ?					; 1512
	m_c							dword ?					; 1516
	m_current_engine_power		dword ?					; 1520
	m_current_rpm				dword ?					; 1524
	m_axle_friction				dword ?					; 1528
	m_fSaveMaxRPM				dword ?					; 1532
	m_max_rpm					dword ?					; 1536
	m_min_rpm					dword ?					; 1540
	m_power_rpm					dword ?					; 1544
	m_torque_rpm				dword ?					; 1548
	m_steering_speed			dword ?					; 1552
	m_ref_radius				dword ?					; 1556
	m_current_transmission_num	dword ?					; 1560
	m_lights					CCarLights <>			; 1564
	inventory					dword ?					; 1584 offset
	m_memory					dword ?					; 1588 offset
;------------------------NEW-------------------------------------
	m_offset_driver_place		Fvector4 <>				; 1592	Fvector4	// смещение водителя от кости m_bone_driver_place
	m_bone_driver_place			word ?					; 1608	u16			// номер кости места водителя
	m_car_panel_visible			byte ?					; 1610	bool		// флаг включения видимости панели
								byte ? ; undefined
	m_height_pos				dword ?					; 1612	float		// высота от нижней части до position, метры
	;Tracks
	m_length_step				dword ?					; 1616	float		// длина шага кадра, метры.
	m_textures_tracks			dword ?					; 1620	IDirect3DBaseTexture9*[]
	m_count_frame				dword ?					; 1624	int			// количество кадров гусениц
	m_track_texture				dword ?					; 1628	CTexture*	// индивидуальная(для каждого объекта) текстура гусеницы
	m_source_texture			dword ?					; 1632	CTexture*	// текстура источник, из неё вырезаем кусок в основную т. 
CCar ends												; 1636	new sizeof

CCustomMonster@@net_update struct ; (sizeof=36, align=4)
	dwTimeStamp					dword ?					; 0
	o_model						dword ?					; 4
	o_torso						SRotation <>			; 8
	p_pos						Fvector <>				; 20
	fHealth						dword ?					; 32
CCustomMonster@@net_update ends							; 36

CCustomMonster	struct ; (sizeof=1112, align=8)
;----------------------------Classes----------------------------------
	CEntityAlive <>													; 0
	CScriptEntity <>												; 568
	Feel@@Vision <>													; 644
	Feel@@Sound <>													; 748
	Feel@@Touch <>													; 752
;---------------------------Properties--------------------------------
	m_memory_manager						dword ?					; 808	offset
	CCustomMonster@m_movement_manager		dword ?					; 812	offset
	m_sound_player							dword ?					; 816	offset
	m_client_update_delta					dword ?					; 820
	m_last_client_update_time				dword ?					; 824
	m_killer_clsids							xr_vector <>			; 828 xr_vector<unsigned __int64,xalloc<unsigned __int64> > ?
	eye_matrix								Fmatrix <>				; 844
	eye_bone								dword ?					; 908
	eye_fov									dword ?					; 912
	eye_range								dword ?					; 916
	m_fCurSpeed								dword ?					; 920
	eye_pp_stage							dword ?					; 924
	eye_pp_timestamp						dword ?					; 928
	m_tEyeShift								Fvector <>				; 932
	m_fEyeShiftYaw							dword ?					; 944
	NET_WasExtrapolating					dword ?					; 948
	tWatchDirection							Fvector <>				; 952
	m_fTimeUpdateDelta						dword ?					; 964
	m_dwLastUpdateTime						dword ?					; 968
	m_current_update						dword ?					; 972
	m_dwCurrentTime							dword ?					; 976
	NET										xr_deque <>				; 980	xr_deque<CCustomMonster::net_update,xalloc<CCustomMonster::net_update> > ?
	NET_Last								CCustomMonster@@net_update <>; 1000
	NET_WasInterpolating					dword ?					; 1036
	NET_Time								dword ?					; 1040
	m_panic_threshold						dword ?					; 1044
	CCustomMonster@m_sound_user_data_visitor dword ?				; 1048	offset
	m_far_plane_factor						dword ?					; 1052
	m_fog_density_factor					dword ?					; 1056
	m_already_dead							byte ?					; 1060
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_last_hit_time							dword ?					; 1064
	m_critical_wound_threshold				dword ?					; 1068
	m_critical_wound_decrease_quant			dword ?					; 1072
	m_critical_wound_accumulator			dword ?					; 1076
	m_critical_wound_type					dword ?					; 1080
	m_bones_body_parts						associative_vector <>	; 1084	associative_vector<u16,u32,std::less<u16> > ?
	m_invulnerable							byte ?					; 1104
	m_update_rotation_on_frame				byte ?					; 1105
	m_movement_enabled_before_animation_controller byte ?			; 1106
											byte ? ; undefined
											dword ?					; 1108	undefined
CCustomMonster	ends												; 1112

CMonsterEnemyMemory struct ; (sizeof=20, align=4)
	monster									dword ?		; 0		offset
	time_memory								dword ?		; 4
	m_objects								xr_map <>	; 8		xr_map<CEntityAlive const *,SMonsterEnemy,std::less<CEntityAlive const *>,xalloc<std::pair<CEntityAlive const *,SMonsterEnemy> > > ?
CMonsterEnemyMemory ends								; 20

CMonsterSoundMemory struct ; (sizeof=36, align=4)
	CMonsterSoundMemory@vfptr				dword ?		; 0		offset
	time_memory								dword ?		; 4
	Sounds									xr_vector <>; 8		xr_vector<tagSoundElement,xalloc<tagSoundElement> > ?
	monster									dword ?		; 24	offset
	m_time_help_sound						dword ?		; 28
	m_help_node								dword ?		; 32
CMonsterSoundMemory ends								; 36

CMonsterCorpseMemory struct ; (sizeof=20, align=4)
	monster									dword ?		; 0		offset
	time_memory								dword ?		; 4
	m_objects								xr_map <>	; 8		xr_map<CEntityAlive const *,SMonsterCorpse,std::less<CEntityAlive const *>,xalloc<std::pair<CEntityAlive const *,SMonsterCorpse> > > ?
CMonsterCorpseMemory ends								; 20

CMonsterHitMemory struct ; (sizeof=24, align=4)
	monster									dword ?		; 0		offset
	time_memory								dword ?		; 4
	m_hits									xr_vector <>; 8		xr_vector<SMonsterHit,xalloc<SMonsterHit> > ?
CMonsterHitMemory ends									; 24

CMonsterEnemyManager struct ; (sizeof=76, align=4)
	monster									dword ?		; 0		offset
	enemy									dword ?		; 4		offset
	position								Fvector <>	; 8
	vertex									dword ?		; 20
	time_last_seen							dword ?		; 24
	flags									dword ?		; 28	Flags32
	forced									byte ?		; 32
	expediency								byte ?		; 33
											byte ? ; undefined
											byte ? ; undefined
	prev_enemy								dword ?		; 36	offset
	prev_enemy_position						Fvector <>	; 40
	enemy_see_me							byte ?		; 52
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	danger_type								dword ?		; 56	enum EDangerType
	my_vertex_enemy_last_seen				dword ?		; 60
	enemy_vertex_enemy_last_seen			dword ?		; 64
	m_time_updated							dword ?		; 68
	m_time_start_see_enemy					dword ?		; 72
CMonsterEnemyManager ends								; 76

CMonsterCorpseManager struct ; (sizeof=32, align=4)
	monster									dword ?		; 0		offset
	corpse									dword ?		; 4		offset
	position								Fvector <>	; 8
	vertex									dword ?		; 20
	time_last_seen							dword ?		; 24
	forced									byte ?		; 28
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
CMonsterCorpseManager ends								; 32

CMonsterEventManager struct ; (sizeof=12, align=4)
	m_event_storage							xr_map <>		;xr_map<enum EEventType,xr_vector<CMonsterEventManager::event_struc,xalloc<CMonsterEventManager::event_struc> >,std::less<enum EEventType>,xalloc<std::pair<enum EEventType,xr_vector<CMonsterEventManager::event_struc,xalloc<CMonsterEventManager::event_struc> > > > > ?
CMonsterEventManager ends

CMeleeChecker	struct ; (sizeof=44, align=4)
	r_res									collide@@rq_results <>	; 0
	m_object								dword ?					; 16	offset
	m_min_attack_distance					dword ?					; 20
	m_max_attack_distance					dword ?					; 24
	m_as_min_dist							dword ?					; 28
	m_as_step								dword ?					; 32
	m_hit_stack								byte 2 dup(?)			; 36
											byte ? ; undefined
											byte ? ; undefined
	m_current_min_distance					dword ?					; 40
CMeleeChecker	ends												; 44

CMonsterMorale	struct ; (sizeof=40, align=4)
	m_hit_quant								dword ?					; 0
	m_attack_success_quant					dword ?					; 4
	m_team_mate_die							dword ?					; 8
	m_v_taking_heart						dword ?					; 12
	m_v_despondent							dword ?					; 16
	m_v_stable								dword ?					; 20
	m_despondent_threshold					dword ?					; 24
	m_object								dword ?					; 28	offset
	m_state									dword ?					; 32	enum CMonsterMorale::EState
	m_morale								dword ?					; 36
CMonsterMorale	ends												; 40

SControlMeleeJumpData struct ; (sizeof=4, align=2)
	anim_ls									MotionID <>
	anim_rs									MotionID <>
SControlMeleeJumpData ends

CControl_Com	struct ; (sizeof=16, align=4)
	CControl_Com@vfptr						dword ?					; 0		offset
	m_man									dword ?					; 4		offset
	m_object								dword ?					; 8		offset
	m_active								byte ?					; 12
	m_inited								byte ?					; 13
											byte ? ; undefined
											byte ? ; undefined
CControl_Com	ends												; 16

CControl_ComControlling struct ; (sizeof=20, align=4)
	CControl_ComControlling@vfptr			dword ?					; 0		offset
	m_controlled							xr_vector <>			; 4	xr_vector<CControl_Com *,xalloc<CControl_Com *> > ?
CControl_ComControlling ends										; 20

CControl_ComBase struct ; (sizeof=36, align=4)
	CControl_Com <>									; 0
	CControl_ComControlling <>						; 16
CControl_ComBase ends								; 36

CControlManagerCustom struct ; (sizeof=112, align=4)
	CControl_ComBase <>												; 0
	m_nearest								xr_vector <>			; 36	xr_vector<CObject *,xalloc<CObject *> > ?
	m_sequencer								dword ?					; 52	offset
	m_triple_anim							dword ?					; 56	offset
	m_rotation_jump							dword ?					; 60	offset
	m_jump									dword ?					; 64	offset
	m_run_attack							dword ?					; 68	offset
	m_threaten								dword ?					; 72	offset
	m_melee_jump							dword ?					; 76	offset
	m_critical_wound						dword ?					; 80	offset
	m_rot_jump_data							xr_vector <>			; 84	xr_vector<SControlRotationJumpData,xalloc<SControlRotationJumpData> > ?
	m_melee_jump_data						SControlMeleeJumpData <>; 100
	m_threaten_anim							dword ?					; 104	offset
	m_threaten_time							dword ?					; 108
CControlManagerCustom ends											; 112

SPPInfo@@SDuality struct ; (sizeof=0x8, align=4)
	h										dword ?					; 
	v										dword ?					; 
SPPInfo@@SDuality ends

; ---------------------------------------------------------------------------

SPPInfo@@SNoise struct ; (sizeof=0xC, align=4)
	intensity								dword ?					; 
	grain									dword ?					; 
	fps										dword ?					; 
SPPInfo@@SNoise ends

; ---------------------------------------------------------------------------

SPPInfo@@SColor struct ; (sizeof=0xC, align=4)
	r										dword ?					; 
	g										dword ?					; 
	b										dword ?					; 
SPPInfo@@SColor ends

SPPInfo			struct ; (sizeof=0x40, align=4)
	blur									dword ?					; 0
	gray									dword ?					; 4
	duality									SPPInfo@@SDuality <>	; 8
	noise									SPPInfo@@SNoise <>		; 
	color_base								SPPInfo@@SColor <>		; 
	color_gray								SPPInfo@@SColor <>		; 
	color_add								SPPInfo@@SColor <>		; 
SPPInfo			ends

SAttackEffector struct ; (sizeof=0x5C, align=4)
	ppi										SPPInfo <>
	time									dword ?
	time_attack								dword ?
	time_release							dword ?
	ce_time									dword ?
	ce_amplitude							dword ?
	ce_period_number						dword ?
	ce_power								dword ?
SAttackEffector ends

SMonsterSettings struct ; (sizeof=0xA4, align=4)
	m_fDistToCorpse							dword ?
	m_fDamagedThreshold						dword ?
	m_dwIdleSndDelay						dword ?
	m_dwEatSndDelay							dword ?
	m_dwAttackSndDelay						dword ?
	m_dwDistantIdleSndDelay					dword ?
	m_fDistantIdleSndRange					dword ?
	m_dwDayTimeBegin						dword ?
	m_dwDayTimeEnd							dword ?
	satiety_threshold						dword ?
	m_fSoundThreshold						dword ?
	m_fEatFreq								dword ?
	m_fEatSlice								dword ?
	m_fEatSliceWeight						dword ?
	m_legs_number							byte ?
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_attack_effector						SAttackEffector <>		; 
	m_max_hear_dist							dword ?
	m_run_attack_path_dist					dword ?
	m_run_attack_start_dist					dword ?
SMonsterSettings ends

CControl_Manager struct ; (sizeof=88, align=4)
	m_object								dword ?					; 0		CBaseMonster*
	m_nearest								xr_vector <>			; 4		xr_vector<CObject *,xalloc<CObject *> > ?
	m_listeners								xr_map <>				; 20	xr_map<enum ControlCom::EEventType,xr_vector<CControl_Com *,xalloc<CControl_Com *> >,std::less<enum ControlCom::EEventType>,xalloc<std::pair<enum ControlCom::EEventType,xr_vector<CControl_Com *,xalloc<CControl_Com *> > > > > ?
	m_control_elems							xr_map <>				; 32	xr_map<enum ControlCom::EControlType,CControl_Com *,std::less<enum ControlCom::EControlType>,xalloc<std::pair<enum ControlCom::EControlType,CControl_Com *> > > ?
	m_base_elems							xr_map <>				; 44	xr_map<enum ControlCom::EControlType,CControl_Com *,std::less<enum ControlCom::EControlType>,xalloc<std::pair<enum ControlCom::EControlType,CControl_Com *> > > ?
	m_active_elems							xr_vector <>			; 56	xr_vector<CControl_Com *,xalloc<CControl_Com *> > ?
	m_animation								dword ?					; 72	CControlAnimation*
	m_direction								dword ?					; 76	CControlDirection*
	m_movement								dword ?					; 80	CControlMovement*
	m_path									dword ?					; 84	CControlPathBuilder*
CControl_Manager ends												; 88

ref_smem@SMonsterSettings@ struct ; (sizeof=0x4, align=4)
	p_										dword ?					; SMonsterSettings*
ref_smem@SMonsterSettings@ ends

CControl_ComControlled struct ; (sizeof=12, align=4)
	vfptr								dword ?					; 0		offset
	m_capturer							dword ?					; 4		offset
	m_locked							byte ?					; 8
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
CControl_ComControlled ends

SAnimationPart struct ; (sizeof=16, align=4)
	motion									MotionID <>			; 0
											byte ? ; undefined
											byte ? ; undefined
	blend									dword ?				; 4		offset
	actual									byte ?				; 8
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	time_started							dword ?				; 12
SAnimationPart ends												; 16

SControlAnimationData struct ; (sizeof=52, align=4)
	_speed								dword ?					; 0
	global								SAnimationPart <>		; 4
	legs								SAnimationPart <>		; 20
	torso								SAnimationPart <>		; 36
SControlAnimationData ends										; 52

CControl_ComControlledStorage@SControlAnimationData@ struct ; (sizeof=64, align=4)
	CControl_ComControlled <>									; 0
	m_data								SControlAnimationData <>; 12
CControl_ComControlledStorage@SControlAnimationData@ ends		; 64

CControl_ComPure@SControlAnimationData@ struct ; (sizeof=80, align=4)
	CControl_Com <>												; 0
	CControl_ComControlledStorage@SControlAnimationData@ <>		; 16
CControl_ComPure@SControlAnimationData@ ends					; 80

CControlAnimation struct ; (sizeof=120, align=4)
	CControl_ComPure@SControlAnimationData@ <>					; 0
	m_skeleton_animated						dword ?				; 80	CKinematicsAnimated*
	m_anim_events							xr_map <>			; 84	xr_map<MotionID,xr_vector<CControlAnimation::SAnimationEvent,xalloc<CControlAnimation::SAnimationEvent> >,std::less<MotionID>,xalloc<std::pair<MotionID,xr_vector<CControlAnimation::SAnimationEvent,xalloc<CControlAnimation::SAnimationEvent> > > > > ?
	m_freeze								byte ?				; 100
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_saved_global_speed					dword ?				; 104
	m_saved_legs_speed						dword ?				; 108
	m_saved_torso_speed						dword ?				; 112
	m_global_animation_end					byte ?				; 116
	m_legs_animation_end					byte ?				; 117
	m_torso_animation_end					byte ?				; 118
											byte ? ; undefined
CControlAnimation ends											; 120

CBaseMonster struct ; (sizeof=1880, align=8)
	CCustomMonster <>												; 0
	CStepManager <>													; 1112
	CInventoryOwner <>												; 1208
	m_force_real_speed						byte ?					; 1328
	m_script_processing_active				byte ?					; 1329
	m_script_state_must_execute				byte ?					; 1330
	m_skip_transfer_enemy					byte ?					; 1331
	m_movement_manager						dword ?					; 1332	CControlPathBuilder*
	m_base_settings							ref_smem@SMonsterSettings@ <>; 1336
	m_current_settings						ref_smem@SMonsterSettings@ <>; 1340
	m_pPhysics_support						dword ?					; 1344	CCharacterPhysicsSupport*
	m_corpse_cover_evaluator				dword ?					; 1348	CMonsterCorpseCoverEvaluator*
	m_enemy_cover_evaluator					dword ?					; 1352	CCoverEvaluatorFarFromEnemy*
	m_cover_evaluator_close_point			dword ?					; 1356	CCoverEvaluatorCloseToEnemy*
	StateMan								dword ?					; 1360	IStateManagerBase*
	EnemyMemory								CMonsterEnemyMemory <>	; 1364
	SoundMemory								CMonsterSoundMemory <>	; 1384
	CorpseMemory							CMonsterCorpseMemory <>	; 1420
	HitMemory								CMonsterHitMemory <>	; 1440
	EnemyMan								CMonsterEnemyManager <>	; 1464
	CorpseMan								CMonsterCorpseManager <>; 1540
	hear_dangerous_sound					byte ?					; 1572
	hear_interesting_sound					byte ?					; 1573
											byte ? ; undefined
											byte ? ; undefined
	EventMan								CMonsterEventManager <>	; 1576
	MeleeChecker							CMeleeChecker <>		; 1588
	Morale									CMonsterMorale <>		; 1632
	CoverMan								dword ?					; 1672	offset
	m_controlled							dword ?					; 1676	offset
	m_monster_type							dword ?					; 1680	enum CBaseMonster::EMonsterType
	Home									dword ?					; 1684	offset
	m_anomaly_detector						dword ?					; 1688	offset
	time_berserk_start						dword ?					; 1692
	berserk_always							byte ?					; 1696
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_default_panic_threshold				dword ?					; 1700
	m_bDamaged								byte ?					; 1704
	m_bAngry								byte ?					; 1705
	m_bGrowling								byte ?					; 1706
	m_bAggressive							byte ?					; 1707
	m_bSleep								byte ?					; 1708
	m_bRunTurnLeft							byte ?					; 1709
	m_bRunTurnRight							byte ?					; 1710
											byte ? ; undefined
	m_prev_sound_type						dword ?					; 1712
	state_invisible							byte ?					; 1716
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_time_last_attack_success				dword ?					; 1720
	m_rank									dword ?					; 1724
	m_melee_rotation_factor					dword ?					; 1728
	ignore_collision_hit					byte ?					; 1732
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_control_manager						dword ?					; 1736	CControl_Manager*
	m_anim_base								dword ?					; 1740	offset
	m_move_base								dword ?					; 1744	offset
	m_path_base								dword ?					; 1748	offset
	m_dir_base								dword ?					; 1752	offset
	m_com_manager							CControlManagerCustom <>; 1756
	m_critical_wound_anim_head				dword ?					; 1868	offset
	m_critical_wound_anim_torso				dword ?					; 1872	offset
	m_critical_wound_anim_legs				dword ?					; 1876	offset
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
CBaseMonster ends													; 1880

ACTOR_DEFS@@InterpData struct ; (sizeof=40, align=4)
Pos								Fvector <>				; 0
Vel								Fvector <>				; 12
o_model							dword ?					; 24
o_torso							SRotation <>			; 28
ACTOR_DEFS@@InterpData ends								; 40

ACTOR_DEFS@@net_update struct ; (sizeof=68, align=4)
	dwTimeStamp					dword ?					; 0
	o_model						dword ?					; 4
	o_torso						SRotation <>			; 8
	p_pos						Fvector <>				; 20
	p_accel						Fvector <>				; 32
	p_velocity					Fvector <>				; 44
	mstate						dword ?					; 56
	weapon						dword ?					; 60
	fHealth						dword ?					; 64
ACTOR_DEFS@@net_update ends								; 68

SPHNetState struct 4 ; (sizeof=108, align=4)
	linear_vel					Fvector <>				; 0
	angular_vel					Fvector <>				; 12
	force						Fvector <>				; 24
	torque						Fvector <>				; 36
	position					Fvector <>				; 48
	previous_position			Fvector <>				; 60
	union
		struct
			accel				Fvector <>				; 72
			max_velocity		dword ?					; 84
		ends
		quaternion				Fquaternion <>			; 72
	ends
	previous_quaternion			Fquaternion <>			; 88
	enabled						byte ?					; 104
SPHNetState ends										; 108

CActorCondition struct ; (sizeof=352, align=8)
	CEntityCondition <>									; 0
	m_condition_flags			word ?					; 240	flags16
								byte ? ; undefined
								byte ? ; undefined
	CActorCondition@m_object	dword ?					; 244	offset
	m_fAlcohol					dword ?					; 248
	m_fV_Alcohol				dword ?					; 252
	m_fSatiety					dword ?					; 256
	m_fV_Satiety				dword ?					; 260
	m_fV_SatietyPower			dword ?					; 264
	m_fV_SatietyHealth			dword ?					; 268
	m_fPowerLeakSpeed			dword ?					; 272
	m_fJumpPower				dword ?					; 276
	m_fStandPower				dword ?					; 280
	m_fWalkPower				dword ?					; 284
	m_fJumpWeightPower			dword ?					; 288
	m_fWalkWeightPower			dword ?					; 292
	m_fOverweightWalkK			dword ?					; 296
	m_fOverweightJumpK			dword ?					; 300
	m_fAccelK					dword ?					; 304
	m_fSprintK					dword ?					; 308
	m_MaxWalkWeight				dword ?					; 312
	m_bLimping					byte ?					; 316
	m_bCantWalk					byte ?					; 317
	m_bCantSprint				byte ?					; 318
								byte ? ; undefined
	m_fLimpingPowerBegin		dword ?					; 320
	m_fLimpingPowerEnd			dword ?					; 324
	m_fCantWalkPowerBegin		dword ?					; 328
	m_fCantWalkPowerEnd			dword ?					; 332
	m_fCantSprintPowerBegin		dword ?					; 336
	m_fCantSprintPowerEnd		dword ?					; 340
	m_fLimpingHealthBegin		dword ?					; 344
	m_fLimpingHealthEnd			dword ?					; 348
CActorCondition ends									; 352

CActor struct ; (sizeof=2456, align=8)
;------------------------------Classes-----------------------------------
	CEntityAlive <>													; 0
	IInputReceiver <>												; 568
	Feel@@Touch <>													; 572
	CInventoryOwner <>												; 628	
	CPhraseDialogManager <>											; 748	
	CStepManager <>													; 800	
	Feel@@Sound <>													; 896	
;----------------------------Properties----------------------------------
	m_snd_noise								dword ?					; 900
	m_defferedMessages						xr_vector <>			; 904	xr_vector<CActor::SDefNewsMsg,xalloc<CActor::SDefNewsMsg> > ?
	m_game_task_manager						dword ?					; 920	offset
	m_statistic_manager						dword ?					; 924	offset
	encyclopedia_registry					dword ?					; 928	offset
	game_news_registry						dword ?					; 932	offset
	m_pPhysics_support						dword ?					; 936	offset
	m_HeavyBreathSnd						ref_sound <>			; 940
	m_BloodSnd								ref_sound <>			; 944
	m_ArtefactsOnBelt						xr_vector <>			; 948 xr_vector<CArtefact const *,xalloc<CArtefact const *> > ?
											dword ?					; 964 undefined
	m_dwWakeUpTime							qword ?					; 968
	m_fOldTimeFactor						dword ?					; 976
	m_fOldOnlineRadius						dword ?					; 980
	m_fSleepTimeFactor						dword ?					; 984
	hit_slowmo								dword ?					; 988
	hit_probability							dword ?					; 992
	m_sndShockEffector						dword ?					; 996	offset
	sndHit									xr_vector 11 dup(<>)	; 1000	xr_vector<ref_sound,xalloc<ref_sound> >
	sndDie									ref_sound 4 dup(<>)		; 1176
	m_fLandingTime							dword ?					; 1192
	m_fJumpTime								dword ?					; 1196
	m_fFallTime								dword ?					; 1200
	m_fCamHeightFactor						dword ?					; 1204
	b_DropActivated							dword ?					; 1208
	f_DropPower								dword ?					; 1212
	m_ZoomRndSeed							dword ?					; 1216
	m_ShotRndSeed							dword ?					; 1220
	m_bOutBorder							byte ?					; 1224
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_feel_touch_characters					dword ?					; 1228
	m_bAllowDeathRemove						byte ?					; 1232
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_holder								dword ?					; 1236	offset
	m_holderID								word ?					; 1240
											byte ? ; undefined
											byte ? ; undefined
	m_bAnimTorsoPlayed						dword ?					; 1244
	r_torso									SRotation <>			; 1248
	r_torso_tgt_roll						dword ?					; 1260
	unaffected_r_torso						SRotation <>			; 1264
	r_model_yaw_dest						dword ?					; 1276
	r_model_yaw								dword ?					; 1280
	r_model_yaw_delta						dword ?					; 1284
	m_anims									dword ?					; 1288	offset
	m_vehicle_anims							dword ?					; 1292	offset
	m_current_legs_blend					dword ?					; 1296	offset
	m_current_torso_blend					dword ?					; 1300	offset
	m_current_jump_blend					dword ?					; 1304	offset
	m_current_legs							MotionID <>				; 1308
	m_current_torso							MotionID <>				; 1310
	m_current_head							MotionID <>				; 1312
											byte ? ; undefined
											byte ? ; undefined
	cameras									dword 3 dup(?)			; 1316	offset
	cam_active								dword ?					; 1328	ACTOR_DEFS::EActorCameras
	fPrevCamPos								dword ?					; 1332
	vPrevCamDir								Fvector <>				; 1336
	fCurAVelocity							dword ?					; 1348
	pCamBobbing								dword ?					; 1352	offset
	m_pSleepEffector						dword ?					; 1356	offset
	m_pSleepEffectorPP						dword ?					; 1360	offset
	m_pActorEffector						dword ?					; 1364	offset
	m_pUsableObject							dword ?					; 1368	offset
	m_pPersonWeLookingAt					dword ?					; 1372	offset
	m_pVehicleWeLookingAt					dword ?					; 1376	offset
	m_pObjectWeLookingAt					dword ?					; 1380	offset
	m_pInvBoxWeLookingAt					dword ?					; 1384	offset
	m_sDefaultObjAction						shared_str <>			; 1388
	m_sCharacterUseAction					shared_str <>			; 1392
	m_sDeadCharacterUseAction				shared_str <>			; 1396
	m_sDeadCharacterUseOrDragAction			shared_str <>			; 1400
	m_sCarCharacterUseAction				shared_str <>			; 1404
	m_sInventoryItemUseAction				shared_str <>			; 1408
	m_sInventoryBoxUseAction				shared_str <>			; 1412
	m_bPickupMode							byte ?					; 1416
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_fPickupInfoRadius						dword ?					; 1420
	mstate_wishful							dword ?					; 1424
	mstate_old								dword ?					; 1428
	mstate_real								dword ?					; 1432
	m_bJumpKeyPressed						dword ?					; 1436
	m_fWalkAccel							dword ?					; 1440
	m_fJumpSpeed							dword ?					; 1444
	m_fRunFactor							dword ?					; 1448
	m_fRunBackFactor						dword ?					; 1452
	m_fWalkBackFactor						dword ?					; 1456
	m_fCrouchFactor							dword ?					; 1460
	m_fClimbFactor							dword ?					; 1464
	m_fSprintFactor							dword ?					; 1468
	m_fWalk_StrafeFactor					dword ?					; 1472
	m_fRun_StrafeFactor						dword ?					; 1476
	m_bZoomAimingMode						byte ?					; 1480
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_fDispBase								dword ?					; 1484
	m_fDispAim								dword ?					; 1488
	m_fDispVelFactor						dword ?					; 1492
	m_fDispAccelFactor						dword ?					; 1496
	m_fDispCrouchFactor						dword ?					; 1500
	m_fDispCrouchNoAccelFactor				dword ?					; 1504
	m_vMissileOffset						Fvector <>				; 1508
	m_r_hand								dword ?					; 1520
	m_l_finger1								dword ?					; 1524
	m_r_finger2								dword ?					; 1528
	m_head									dword ?					; 1532
	m_l_clavicle							dword ?					; 1536
	m_r_clavicle							dword ?					; 1540
	m_spine2								dword ?					; 1544
	m_spine1								dword ?					; 1548
	m_spine									dword ?					; 1552
	m_neck									dword ?					; 1556
	NET										xr_deque <>				; 1560	xr_deque<ACTOR_DEFS::net_update,xalloc<ACTOR_DEFS::net_update> > ?
	NET_SavedAccel							Fvector <>				; 1580
	NET_Last								ACTOR_DEFS@@net_update <>; 1592
	NET_WasInterpolating					dword ?					; 1660
	NET_Time								dword ?					; 1664
	NET_A									xr_deque <>				; 1668	xr_deque<ACTOR_DEFS::net_update_A,xalloc<ACTOR_DEFS::net_update_A> > ?
	SCoeff									dword 12 dup(?)			; 1688
	HCoeff									dword 12 dup(?)			; 1736
	IPosS									Fvector <>				; 1784
	IPosH									Fvector <>				; 1796
	IPosL									Fvector <>				; 1808
	LastState								SPHNetState <>			; 1820
	RecalculatedState						SPHNetState <>			; 1928
	PredictedState							SPHNetState <>			; 2036
	IStart									ACTOR_DEFS@@InterpData <>; 2144
	IRec									ACTOR_DEFS@@InterpData <>; 2184
	IEnd									ACTOR_DEFS@@InterpData <>; 2224
	m_bInInterpolation						byte ?					; 2264
	m_bInterpolate							byte ?					; 2265
											byte ? ; undefined
											byte ? ; undefined
	m_dwIStartTime							dword ?					; 2268
	m_dwIEndTime							dword ?					; 2272
	m_dwILastUpdateTime						dword ?					; 2276
	m_States								xr_deque <>				; 2280	xr_deque<SPHNetState,xalloc<SPHNetState> > ?
	m_u16NumBones							word ?					; 2300
											byte ? ; undefined
											byte ? ; undefined
	hFriendlyIndicator						dword ?					; 2304	Cresptr_core<SGeometry,resptrcode_geom> ?
	m_input_external_handler				dword ?					; 2308	offset
	m_time_lock_accel						dword ?					; 2312
	pStatGraph								dword ?					; 2316	offset
	m_DefaultVisualOutfit					shared_str <>			; 2320
	invincibility_fire_shield_3rd			dword ?					; 2324	offset
	invincibility_fire_shield_1st			dword ?					; 2328	offset
	m_sHeadShotParticle						shared_str <>			; 2332
	last_hit_frame							dword ?					; 2336
	m_AutoPickUp_AABB						Fvector <>				; 2340
	m_AutoPickUp_AABB_Offset				Fvector <>				; 2352
	CActor@m_entity_condition				dword ?					; 2364		CActorCondition*
	m_iLastHitterID							word ?					; 2368
	m_iLastHittingWeaponID					word ?					; 2370
	m_s16LastHittedElement					word ?					; 2372
	m_vLastHitDir							Fvector <>				; 2374
	m_vLastHitPos							Fvector <>				; 2386
											byte ? ; undefined
											byte ? ; undefined
	m_fLastHealth							dword ?					; 2400
	m_bWasHitted							byte ?					; 2404
	m_bWasBackStabbed						byte ?					; 2405
											byte ? ; undefined
											byte ? ; undefined
	m_memory								dword ?					; 2408	offset
	RQR										collide@@rq_results <>	; 2412
	ISpatialResult							xr_vector <>			; 2428	xr_vector<ISpatial *,xalloc<ISpatial *> > ?
	m_location_manager						dword ?					; 2444	offset
	m_holder_id								word ?					; 2448
											byte ? ; undefined
											byte ? ; undefined
											dword ? ; undefined 2452
CActor ends															; 2456

CAI_PhraseDialogManager struct ; (sizeof=76, align=4)
	CPhraseDialogManager <>									; 0
	m_sStartDialog						shared_str <>		; 52
	m_sDefaultStartDialog				shared_str <>		; 56
	m_PendingDialogs					xr_vector <>		; 60	xr_vector<intrusive_ptr<CPhraseDialog,intrusive_base>,xalloc<intrusive_ptr<CPhraseDialog,intrusive_base> > > ?
CAI_PhraseDialogManager ends								; 76

CObjectHandler	struct ; (sizeof=152, align=4)
	CInventoryOwner <>										; 0
	m_r_hand							dword ?				; 120
	m_l_finger1							dword ?				; 124
	m_r_finger2							dword ?				; 128
	m_strap_bone0						dword ?				; 132
	m_strap_bone1						dword ?				; 136
	m_strap_object_id					word ?				; 140
	m_hammer_is_clutched				byte ?				; 142
	m_infinite_ammo						byte ?				; 143
	m_planner							dword ?				; 144	offset
	m_inventory_actual					byte ?				; 148
	m_clutched_hammer_enabled			byte ?				; 149
										byte ? ; undefined
										byte ? ; undefined
CObjectHandler	ends										; 152

CBlend struct ; (sizeof=64, align=4)
	blendAmount							dword ?					; 0
	timeCurrent							dword ?					; 4
	timeTotal							dword ?					; 8
	_motionID							MotionID <>				; 12
	bone_or_part						word ?					; 14
	channel								byte ?					; 16
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	blend								dword ?					; 20	enum CBlend::ECurvature
	blendAccrue							dword ?					; 24
	blendFalloff						dword ?					; 28
	blendPower							dword ?					; 32
	speed								dword ?					; 36
	playing								dword ?					; 40
	stop_at_end							dword ?					; 44
	fall_at_end							dword ?					; 48
	Callback							dword ?					; 52	PlayCallback
	CallbackParam						dword ?					; 56	void*
	dwFrame								dword ?					; 60
CBlend ends														; 64

CStalkerAnimationPair struct ; (sizeof=36, align=4)
	m_animation							MotionID <>				; 0		MotionID
										byte ? ; undefined
										byte ? ; undefined
	m_blend								dword ?					; 4		CBlend*
	m_actual							byte ?					; 8		bool
	m_step_dependence					byte ?					; 9		bool
	m_global_animation					byte ?					; 10	bool
										byte ? ; undefined
	m_array								dword ?					; 12	const ANIM_VECTOR
	m_array_animation					MotionID <>				; 16	
										byte ? ; undefined
										byte ? ; undefined
	m_callbacks							xr_vector <>			; 20	xr_vector<fastdelegate::FastDelegate0<void>,xalloc<fastdelegate::FastDelegate0<void>>>?
CStalkerAnimationPair ends										; 36

CStalkerAnimationManager struct ; (sizeof=280, align=4)
	vfptr								dword ?					; 0		offset
	m_data_storage						dword ?					; 4		CStalkerAnimationData*
	m_script_animations					xr_deque <>				; 8		xr_deque<CStalkerAnimationScript,xalloc<CStalkerAnimationScript> > ?
	m_global							CStalkerAnimationPair <>; 28
	m_head								CStalkerAnimationPair <>; 64
	m_torso								CStalkerAnimationPair <>; 100
	m_legs								CStalkerAnimationPair <>; 136
	m_script							CStalkerAnimationPair <>; 172
	m_direction_start					dword ?					; 208
	m_current_direction					dword ?					; 212	enum MonsterSpace::EMovementDirection
	m_target_direction					dword ?					; 216	enum MonsterSpace::EMovementDirection
	m_previous_speed_direction			dword ?					; 220	enum MonsterSpace::EMovementDirection
	m_change_direction_time				dword ?					; 224
	m_looking_back						dword ?					; 228
	m_crouch_state_config				dword ?					; 232
	m_crouch_state						dword ?					; 236
	m_no_move_actual					byte ?					; 240
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_object							dword ?					; 244	CAI_Stalker*
	m_visual							dword ?					; 248	IRender_Visual*
	m_skeleton_animated					dword ?					; 252	CKinematicsAnimated*
	m_weapon							dword ?					; 256	CWeapon*
	m_missile							dword ?					; 260	CMissile*
	m_call_script_callback				byte ?					; 264
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_script_bone_part_mask				dword ?					; 268
	m_previous_speed					dword ?					; 272
	m_current_speed						dword ?					; 276
CStalkerAnimationManager ends									; 280

CAI_Stalker struct ; (sizeof=1816, align=8)
;------------------------------Classes-----------------------------------
	CCustomMonster <>												; 0
	CObjectHandler <>												; 1112
	CAI_PhraseDialogManager <>										; 1264
	CStepManager <>													; 1340
;-----------------------------Properties---------------------------------
	m_animation_manager						dword ?					; 1436	CStalkerAnimationManager*
	m_brain									dword ?					; 1440	CStalkerPlanner*
	m_sight_manager							dword ?					; 1444	CSightManager*
	CAI_Stalker@m_movement_manager			dword ?					; 1448	CStalkerMovementManager*
	m_boneHitProtection						dword ?					; 1452	SBoneProtections*
	m_disp_walk_stand						dword ?					; 1456
	m_disp_walk_crouch						dword ?					; 1460
	m_disp_run_stand						dword ?					; 1464
	m_disp_run_crouch						dword ?					; 1468
	m_disp_stand_stand						dword ?					; 1472
	m_disp_stand_crouch						dword ?					; 1476
	m_disp_stand_stand_zoom					dword ?					; 1480
	m_disp_stand_crouch_zoom				dword ?					; 1484
	m_power_fx_factor						dword ?					; 1488
	m_fRankDisperison						dword ?					; 1492
	m_fRankVisibility						dword ?					; 1496
	m_fRankImmunity							dword ?					; 1500
	m_item_actuality						byte ?					; 1504
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_best_item_to_kill						dword ?					; 1508	CInventoryItem*
	m_best_item_value						dword ?					; 1512
	m_best_ammo								dword ?					; 1516	CInventoryItem*
	m_best_found_item_to_kill				dword ?					; 1520	const CInventoryItem*
	m_best_found_ammo						dword ?					; 1524	const CInventoryItem*
	m_ce_close								dword ?					; 1528	CCoverEvaluatorCloseToEnemy*
	m_ce_far								dword ?					; 1532	CCoverEvaluatorFarFromEnemy*
	m_ce_best								dword ?					; 1536	CCoverEvaluatorBest*
	m_ce_angle								dword ?					; 1540	CCoverEvaluatorAngle*
	m_ce_safe								dword ?					; 1544	CCoverEvaluatorSafe*
	m_ce_random_game						dword ?					; 1548	CCoverEvaluatorRandomGame*
	m_ce_ambush								dword ?					; 1552	CCoverEvaluatorAmbush*
	m_ce_best_by_time						dword ?					; 1556	CCoverEvaluatorBestByTime*
	m_pPhysics_support						dword ?					; 1560	CCharacterPhysicsSupport*
	m_wounded								byte ?					; 1564
	m_can_kill_member						byte ?					; 1565
	m_can_kill_enemy						byte ?					; 1566
											byte ? ; undefined
	m_pick_distance							dword ?					; 1568
	m_pick_frame_id							dword ?					; 1572
	rq_storage								collide@@rq_results <>	; 1576
	m_actor_relation_flags					dword ?					; 1592	flags32
	m_trader_game_object					dword ?					; 1596	CGameObject*
	m_current_trader						dword ?					; 1600	CInventoryOwner*
	m_temp_items							xr_vector <>			; 1604	xr_vector<CAI_Stalker::CTradeItem,xalloc<CAI_Stalker::CTradeItem> > ?
	m_total_money							dword ?					; 1620
	m_sell_info_actuality					byte ?					; 1624
	m_script_not_check_can_kill				byte ?					; 1625	bool NEW Не сменять оружие если кончились патроны.(надо для роботов с интергрированным оружием)
	m_not_drop_wpn_death					byte ?					; 1626	bool NEW Не сбрасывать оружие при смерти сталкера, остаёться в руках.
											byte ? ; undefined
	CAI_Stalker@m_sound_user_data_visitor	dword ?					; 1628	CStalkerSoundDataVisitor*
	m_group_behaviour						byte ?					; 1632
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_weapon_shot_effector					dword ?					; 1636	CWeaponShotEffector*
	m_weapon_shot_random_seed				dword ?					; 1640
	m_min_queue_size_far					dword ?					; 1644
	m_max_queue_size_far					dword ?					; 1648
	m_min_queue_interval_far				dword ?					; 1652
	m_max_queue_interval_far				dword ?					; 1656
	m_min_queue_size_medium					dword ?					; 1660
	m_max_queue_size_medium					dword ?					; 1664
	m_min_queue_interval_medium				dword ?					; 1668
	m_max_queue_interval_medium				dword ?					; 1672
	m_min_queue_size_close					dword ?					; 1676
	m_max_queue_size_close					dword ?					; 1680
	m_min_queue_interval_close				dword ?					; 1684
	m_max_queue_interval_close				dword ?					; 1688
	m_cover_delegates						xr_vector <>			; 1692	xr_vector<fastdelegate::FastDelegate<void __cdecl(CCoverPoint const *,CCoverPoint const *)>,xalloc<fastdelegate::FastDelegate<void __cdecl(CCoverPoint const *,CCoverPoint const *)> > > ?					; 
	m_best_cover							dword ?					; 1708	const CCoverPoint*
	m_best_cover_value						dword ?					; 1712
	m_best_cover_actual						byte ?					; 1716
	m_best_cover_can_try_advance			byte ?					; 1717
											byte ? ; undefined
											byte ? ; undefined
	m_best_cover_advance_cover				dword ?					; 1720	const CCoverPoint*
	m_throw_actual							byte ?					; 1724
	m_computed_object_position				Fvector <>				; 1725
	m_computed_object_direction				Fvector <>				; 1737
	m_throw_target							Fvector <>				; 1749
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_throw_force							dword ?					; 1764
	m_throw_position						Fvector <>				; 1768
	m_throw_direction						Fvector <>				; 1780
	m_critical_wound_weights				xr_vector <>			; 1792	xr_vector<float,xalloc<float> > ?
	m_registered_in_combat_on_migration		byte ?					; 1808
	m_sight_enabled_before_animation_controller	 byte ?				; 1809
	m_can_select_items						byte ?					; 1810
											byte ? ; undefined
	m_script_best_weapon					dword ?					; 1812	CWeapon*	NEW Лучшие оружие заданное скриптовым методом.
CAI_Stalker ends													; 1816

IPhysicShellCreator struct ; (sizeof=4, align=4)
	IPhysicShellCreator@vfptr				dword ?				; offset*
IPhysicShellCreator ends

CPHShellSimpleCreator struct ; (sizeof=4, align=4)
	IPhysicShellCreator <>		
CPHShellSimpleCreator ends

CPhysicItem	struct ; (sizeof=432, align=8)
	CPhysicsShellHolder <>										; 0
	CPHShellSimpleCreator <>									; 424
	m_ready_to_destroy						byte ?				; 428
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
CPhysicItem	ends												; 432

CAttachableItem struct ; (sizeof=80, align=4)
	CAttachableItem@vfptr					dword ?				; 0		offset*
	CAttachableItem@m_item					dword ?				; 4		offset*
	m_bone_name								shared_str <>		; 8		
	CAttachableItem@m_offset				Fmatrix <>			; 12
	m_bone_id								word ?				; 76
	m_enabled								byte ?				; 77
											byte ? ; undefined
CAttachableItem ends											; 80

CHudItem struct ; (sizeof=60, align=4)
	CHudItem@vfptr							dword ?				; 0		offset*
	m_state									dword ?				; 4
	m_nextState								dword ?				; 8
	m_bPending								byte ?				; 12
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_pHUD									dword ?				; 16	CWeaponHUD*
	hud_mode								dword ?				; 20
	hud_sect								shared_str <>		; 24
	m_bRenderHud							byte ?				; 28
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_dwStateTime							dword ?				; 32
	dwFP_Frame								dword ?				; 36
	dwXF_Frame								dword ?				; 40
	m_bInertionEnable						byte ?				; 44
	m_bInertionAllow						byte ?				; 45
											byte ? ; undefined
											byte ? ; undefined
	m_animation_slot						dword ?				; 48
	CHudItem@m_object						dword ?				; 52	offset*
	CHudItem@m_item							dword ?				; 56	offset*
CHudItem ends													; 60

;------------------------------CInventoryItem----------------------------------
virt@@CInventoryItem struct
											dword 66 dup(?)
	cast_CInventoryItem						dword ?		; 264
	cast_CAttachableItem					dword ?		; 268
	cast_CPhysicsShellHolder				dword ?		; 272
	cast_CEatableItem						dword ?		; 276
	cast_CWeapon							dword ?		; 280
	cast_CFoodItem							dword ?		; 284
	cast_CMissile							dword ?		; 288
	cast_CHudItem							dword ?		; 292
	cast_CWeaponAmmo						dword ?		; 296
	cast_CGameObject						dword ?		; 300
virt@@CInventoryItem ends

CInventoryItem struct ; (sizeof=216, align=8)
	CAttachableItem <>											; 0
	CHitImmunity <>												; 80
	m_flags									word ?				; 132	flags16
											byte ? ; undefined
											byte ? ; undefined
	m_pCurrentInventory						dword ?				; 136	offset*
	m_name									shared_str <>		; 140
	m_nameShort								shared_str <>		; 144
	m_nameComplex							shared_str <>		; 148
	m_eItemPlace							dword ?				; 152	enum EItemPlace
	m_slot									dword ?				; 156
	m_cost									dword ?				; 160
	m_weight								dword ?				; 164
	m_fCondition							dword ?				; 168
	m_Description							shared_str <>		; 172
	m_dwItemRemoveTime						qword ?				; 176
	m_dwItemIndependencyTime				qword ?				; 184
	m_fControlInertionFactor				dword ?				; 192
	m_icon_name								shared_str <>		; 196
	m_net_updateData						dword ?				; 200	offset*
	m_holder_range_modifier					dword ?				; 204
	m_holder_fov_modifier					dword ?				; 208
	CInventoryItem@m_object					dword ?				; 212	offset*
CInventoryItem ends												; 216

CInventoryItemObject struct ; (sizeof=648, align=8)
	CInventoryItem <>											; 0
	CPhysicItem <>												; 216
CInventoryItemObject ends										; 648

CEatableItem struct ; (sizeof=256, align=8)
	CInventoryItem <>											; 0
	m_physic_item							dword ?				; 216	offset
	m_fHealthInfluence						real4 ?				; 220
	m_fPowerInfluence						real4 ?				; 224
	m_fSatietyInfluence						real4 ?				; 228
	m_fRadiationInfluence					real4 ?				; 232
	m_fMaxPowerUpInfluence					real4 ?				; 236
	m_fWoundsHealPerc						real4 ?				; 240
	m_iPortionsNum							dword ?				; 244
	m_iStartPortionsNum						dword ?				; 248
	m_bOnEatNotDelete						byte ?				; 252
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
CEatableItem ends												; 256

CEatableItemObject struct ; (sizeof=688, align=8)
	CEatableItem <>												; 0
	CPhysicItem <>												; 256
CEatableItemObject ends											; 688

CHudItemObject struct ; (sizeof=712, align=8)
	CInventoryItemObject <>											; 0
	CHudItem <>														; 648
											dword ? ; undefined
CHudItemObject ends													; 712

CWeaponAmmo struct ; (sizeof=696, align=8)
	CInventoryItemObject <>											; 0
	m_kDist									dword ?					; 648
	m_kDisp									dword ?					; 652
	m_kHit									dword ?					; 656
	m_kImpulse								dword ?					; 660
	m_kPierce								dword ?					; 664
	m_kAP									dword ?					; 668
	m_kAirRes								dword ?					; 672
	m_buckShot								dword ?					; 676
	m_impair								dword ?					; 680
	fWallmarkSize							dword ?					; 684
	m_u8ColorID								byte ?					; 688
											byte ? ; undefined
	m_boxSize								word ?					; 690
	m_boxCurr								word ?					; 692
	m_tracer								byte ?					; 694
											byte ? ; undefined
CWeaponAmmo ends													; 696

CTorch struct ; (sizeof=792, align=8)
	CInventoryItemObject <>											; 0
	fBrightness								dword ?					; 648
	lanim									dword ?					; 652	offset*
	time2hide								dword ?					; 656
	guid_bone								word ?					; 660
											byte ? ; undefined
											byte ? ; undefined
	light_trace_bone						shared_str <>			; 664
	m_delta_h								dword ?					; 668
	m_prev_hp								Fvector2 <>				; 672
	m_switched_on							byte ?					; 680
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	light_render							resptr_core <>			; 684	resptr_core<IRender_Light,resptrcode_light> ?
	light_omni								resptr_core <>			; 688	resptr_core<IRender_Light,resptrcode_light> ?
	glow_render								resptr_core <>			; 692	resptr_core<IRender_Glow,resptrcode_glow> ?
	m_focus									Fvector <>				; 696
	m_bNightVisionEnabled					byte ?					; 708
	m_bNightVisionOn						byte ?					; 709
											byte ? ; undefined
											byte ? ; undefined
	m_NightVisionOnSnd						HUD_SOUND <>			; 712
	m_NightVisionOffSnd						HUD_SOUND <>			; 732
	m_NightVisionIdleSnd					HUD_SOUND <>			; 752
	m_NightVisionBrokenSnd					HUD_SOUND <>			; 772
CTorch ends															; 792

CHangingLamp struct ; (sizeof=496, align=8)
	CPhysicsShellHolder <>											; 0
	CPHSkeleton <>													; 424
	light_bone								word ?					; 460
	ambient_bone							word ?					; 462
	light_render							resptr_core <>			; 464	resptr_core<IRender_Light,resptrcode_light> ?
	light_ambient							resptr_core <>			; 468	resptr_core<IRender_Light,resptrcode_light> ?
	lanim									dword ?					; 472	CLAItem*
	ambient_power							dword ?					; 476
	glow_render								resptr_core <>			; 480	resptr_core<IRender_Glow,resptrcode_glow> ?
	fHealth									dword ?					; 484
	fBrightness								dword ?					; 488
											dword ? ; undefined
CHangingLamp ends													; 496

CScriptObject struct ; (sizeof=436, align=4)
	CGameObject <>													; 0
	CScriptEntity <>												; 360
CScriptObject ends													; 436

CProjector@@SBoneRot struct ; (sizeof=0x8, align=4)
	velocity								dword ?
	id										word ?
											byte ? ; undefined
											byte ? ; undefined
CProjector@@SBoneRot ends

CProjector struct ; (sizeof=0x210, align=4)
	CScriptObject <>												; 0
	fBrightness								dword ?					; 436
	lanim									dword ?					; 440	offset*
	m_pos									Fvector <>				; 444
	light_render							resptr_core <>			; 456	resptr_core<IRender_Light,resptrcode_light> ?
	glow_render								resptr_core <>			; 460	resptr_core<IRender_Glow,resptrcode_glow> ?
	guid_bone								word ?					; 464
											byte ? ; undefined
											byte ? ; undefined
	bone_x									CProjector@@SBoneRot <>	; 468
	bone_y									CProjector@@SBoneRot <>	; 472
	struct _start
		yaw									dword ?					; 476
		pitch								dword ?					; 480
	ends
	struct _current
		yaw									dword ?					; 484
		pitch								dword ?					; 488
	ends
	struct _target
		yaw									dword ?					; 492
		pitch								dword ?					; 496
	ends
CProjector ends														; 500

shared_value struct ; (sizeof=8, align=4)
	vfptr									dword ?					; 0		offset*
	m_ref_cnt								dword ?					; 4
shared_value ends													; 8

weapon_hud_value struct ; (sizeof=116, align=4)
	shared_value <>													; 0
	m_animations							dword ?					; 8		CKinematicsAnimated*
	m_fire_bone								dword ?					; 12	int
	m_fp_offset								Fvector <>				; 16
	m_fp2_offset							Fvector <>				; 28
	m_sp_offset								Fvector <>				; 40
	m_offset								Fmatrix <>				; 52
weapon_hud_value ends												; 116

shared_weapon_hud struct ; (sizeof=4, align=4)
		p_									dword ?					; 0		weapon_hud_value*
shared_weapon_hud ends												; 4

CWeaponHUD struct ; (sizeof=116, align=4)
	m_pParentWeapon							dword ?					; 0		CHudItem*
	m_bHidden								byte ?					; 4
	m_bVisible								byte ?					; 5
	m_Transform								Fmatrix <>				; 6
											byte ? ; undefined
											byte ? ; undefined
	m_shared_data							shared_weapon_hud <>	; 72
	m_dwAnimTime							dword ?					; 76
	m_dwAnimEndTime							dword ?					; 80
	m_bStopAtEndAnimIsRunning				byte ?					; 84
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_startedAnimState						dword ?					; 88
	m_pCallbackItem							dword ?					; 92	CHudItem*
	m_fZoomRotateX							dword ?					; 96	float
	m_fZoomRotateY							dword ?					; 100	float
	m_fZoomOffset							Fvector <>				; 104
CWeaponHUD ends														; 116

CWeapon struct ; (sizeof=1572, align=8)
	CHudItemObject <>												; 0
	CShootingObject <>												; 712
	m_dwWeaponRemoveTime					qword ?					; 912
	m_dwWeaponIndependencyTime				qword ?					; 920
	m_bTriStateReload						byte ?					; 928
	m_sub_state								byte ?					; 929
	bWorking2								byte ?					; 930
	bMisfire								byte ?					; 931
	m_bAutoSpawnAmmo						dword ?					; 932
	m_flagsAddOnState						byte ?					; 936
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_eScopeStatus							dword ?					; 940	enum ALife::EWeaponAddonStatus
	m_eSilencerStatus						dword ?					; 944	enum ALife::EWeaponAddonStatus
	m_eGrenadeLauncherStatus				dword ?					; 948	enum ALife::EWeaponAddonStatus
	m_sScopeName							shared_str <>			; 952
	m_sSilencerName							shared_str <>			; 956
	m_sGrenadeLauncherName					shared_str <>			; 960
	m_iScopeX								dword ?					; 964
	m_iScopeY								dword ?					; 968
	m_iSilencerX							dword ?					; 972
	m_iSilencerY							dword ?					; 976
	m_iGrenadeLauncherX						dword ?					; 980
	m_iGrenadeLauncherY						dword ?					; 984
	m_bScopeDynamicZoom						byte ?					; 988
	m_bZoomEnabled							byte ?					; 989
	m_bNPCBlocked							byte ?					; 990	bool	NEW	// Заблокировать использования оружие НПСом
	m_bIsGrenadeRPG							byte ?					; 991	bool	NEW	// это граната для НПС на классе РПГ-7
	m_fZoomFactor							dword ?					; 992
	m_fZoomRotateTime						dword ?					; 996
	m_UIScope								dword ?					; 1000	offset*
	m_fIronSightZoomFactor					dword ?					; 1004
	m_fScopeZoomFactor						dword ?					; 1008
	m_bZoomMode								byte ?					; 1012
											byte ?					; 
											byte ? ; undefined
											byte ? ; undefined
	m_fZoomRotationFactor					dword ?					; 1016
	m_bHideCrosshairInZoom					byte ?					; 1020
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_strap_bone0							dword ?					; 1024	offset*
	m_strap_bone1							dword ?					; 1028	offset*
	m_StrapOffset							Fmatrix <>				; 1032
	m_strapped_mode							byte ?					; 1096
	m_can_be_strapped						byte ?					; 1097
	CWeapon@m_Offset						Fmatrix <>				; 1098
											byte ? ; undefined
											byte ? ; undefined
	eHandDependence							dword ?					; 1164	enum EHandDependence
	m_bIsSingleHanded						byte ?					; 1168
	vLoadedFirePoint						Fvector <>				; 1169
	vLoadedFirePoint2						Fvector <>				; 1181
	struct m_firedeps						;CWeapon@@_firedeps <>	; 
		m_FireParticlesXForm				Fmatrix <>				; 1193
		vLastFP								Fvector <>				; 1257
		vLastFP2							Fvector <>				; 1269
		vLastFD								Fvector <>				; 1281
		vLastSP								Fvector <>				; 1293
	ends
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	camMaxAngle								dword ?					; 1308
	camRelaxSpeed							dword ?					; 1312
	camRelaxSpeed_AI						dword ?					; 1316
	camDispersion							dword ?					; 1320
	camDispersionInc						dword ?					; 1324
	camDispertionFrac						dword ?					; 1328
	camMaxAngleHorz							dword ?					; 1332
	camStepAngleHorz						dword ?					; 1336
	fireDispersionConditionFactor			dword ?					; 1340
	misfireProbability						dword ?					; 1344
	misfireConditionK						dword ?					; 1348
	conditionDecreasePerShot				dword ?					; 1352
	m_fPDM_disp_base						float ?					; 1356
	m_fPDM_disp_vel_factor					float ?					; 1360
	m_fPDM_disp_accel_factor				float ?					; 1364
	m_fPDM_disp_crouch						float ?					; 1368
	m_fPDM_disp_crouch_no_acc				float ?					; 1372
	m_vRecoilDeltaAngle						Fvector <>				; 1376
	CWeapon@m_fMinRadius					dword ?					; 1388
	CWeapon@m_fMaxRadius					dword ?					; 1392
	m_sFlameParticles2						shared_str <>			; 1396
	m_pFlameParticles2						dword ?					; 1400	offset*
	iAmmoElapsed							dword ?					; 1404
	iMagazineSize							dword ?					; 1408
	iAmmoCurrent							dword ?					; 1412
	m_dwAmmoCurrentCalcFrame				dword ?					; 1416
	m_bAmmoWasSpawned						byte ?					; 1420
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_ammoTypes								xr_vector <>			; 1424	xr_vector<shared_str,xalloc<shared_str> > ?
	m_pAmmo									dword ?					; 1440	offset*
	m_ammoType								dword ?					; 1444
	m_ammoName								shared_str <>			; 1448
	m_bHasTracers							dword ?					; 1452
	m_u8TracerColorID						byte ?					; 1456
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_set_next_ammoType_on_reload			dword ?					; 1460
	m_magazine								xr_vector <>			; 1464	xr_vector<CCartridge,xalloc<CCartridge> > ?					; 
	m_DefaultCartridge						CCartridge <>			; 1480
	m_fCurrentCartirdgeDisp					dword ?					; 1536
	m_ef_main_weapon_type					dword ?					; 1540
	m_ef_weapon_type						dword ?					; 1544
	m_addon_holder_range_modifier			dword ?					; 1548
	m_addon_holder_fov_modifier				dword ?					; 1552
	m_hit_probability						dword 4 dup(?)			; 1556
											dword ? ; 1568	undefined
CWeapon ends														; 1576

svector@MotionID_8@ struct ; (sizeof=20, align=4)
	array									MotionID 8 dup(<>)		; 0
	count									dword ?					; 16
svector@MotionID_8@ ends											; 20

CWeaponMagazined@@SWMmotions struct ; (sizeof=140, align=4)
	mhud_idle								svector@MotionID_8@ <>	; 0
	mhud_idle_aim							svector@MotionID_8@ <>	; 20
	mhud_reload								svector@MotionID_8@ <>	; 40
	mhud_hide								svector@MotionID_8@ <>	; 60
	mhud_show								svector@MotionID_8@ <>	; 80
	mhud_shots								svector@MotionID_8@ <>	; 100
	mhud_idle_sprint						svector@MotionID_8@ <>	; 120
CWeaponMagazined@@SWMmotions ends									; 140

CWeaponMagazined struct ; (sizeof=1960, align=8)
	CWeapon <>															; 0
	sndShow								HUD_SOUND <>					; 1576
	sndHide								HUD_SOUND <>					; 1596
	sndShot								HUD_SOUND <>					; 1616
	sndEmptyClick						HUD_SOUND <>					; 1636
	sndReload							HUD_SOUND <>					; 1656
	m_pSndShotCurrent					dword ?							; 1676	offset*
	m_sSilencerFlameParticles			dword ?							; 1680	offset*
	m_sSilencerSmokeParticles			dword ?							; 1684	offset*
	sndSilencerShot						HUD_SOUND <>					; 1688
	m_eSoundShow						dword ?							; 1708	enum ESoundTypes
	m_eSoundHide						dword ?							; 1712	enum ESoundTypes
	m_eSoundShot						dword ?							; 1716	enum ESoundTypes
	m_eSoundEmptyClick					dword ?							; 1720	enum ESoundTypes
	m_eSoundReload						dword ?							; 1724	enum ESoundTypes
	mhud								CWeaponMagazined@@SWMmotions <> ; 1728
	dwUpdateSounds_Frame				dword ?							; 1868
	m_iQueueSize						dword ?							; 1872
	m_iShotNum							dword ?							; 1876
	m_iShootEffectorStart				dword ?							; 1880
	m_vStartPos							Fvector <>						; 1884
	m_vStartDir							Fvector <>						; 1896
	m_bStopedAfterQueueFired			byte ?							; 1908
	m_bFireSingleShot					byte ?							; 1909
	m_bHasDifferentFireModes			byte ?							; 1910
										byte ? ; undefined
	m_aFireModes						xr_vector <>					; 1912	xr_vector<int,xalloc<int> > ?
	m_iCurFireMode						dword ?							; 1928
	m_sCurFireMode						string16 <>						; 1932
	m_iPrefferedFireMode				dword ?							; 1948
	m_bLockType							byte ?							; 1952
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
										dword ? ; undefined
CWeaponMagazined ends													; 1960

CWeaponCustomPistol struct
	CWeaponMagazined <>
CWeaponCustomPistol ends

CWeaponRPG7 struct
	CWeaponCustomPistol <>												; 0
	m_sGrenadeBoneName					shared_str <>					; 1960
	m_sHudGrenadeBoneName				shared_str <>					; 1964
	m_sRocketSection					shared_str <>					; 1968
										dword ? ; undefined
CWeaponRPG7 ends														; 1976

CRocketLauncher struct ; (sizeof=40, align=4)
	CRocketLauncher@vfptr				dword ?					; offset
	m_rockets							xr_vector <>			; xr_vector<CCustomRocket *,xalloc<CCustomRocket *> > ?
	m_launched_rockets					xr_vector <>			; xr_vector<CCustomRocket *,xalloc<CCustomRocket *> > ?
	m_fLaunchSpeed						real4 ?
CRocketLauncher ends

CWeaponMagazinedWGrenade struct ; (sizeof=2456, align=8)
	CWeaponMagazined <>											; 
	CRocketLauncher <>											; 
	sndShotG							HUD_SOUND <>			; 
	sndReloadG							HUD_SOUND <>			; 
	sndSwitch							HUD_SOUND <>			; 
	mhud_idle_g							svector@MotionID_8@ <>	; 
	mhud_idle_g_aim						svector@MotionID_8@ <>	; 
	mhud_reload_g						svector@MotionID_8@ <>	; 
	mhud_shots_g						svector@MotionID_8@ <>	; 
	mhud_switch_g						svector@MotionID_8@ <>	; 
	mhud_switch							svector@MotionID_8@ <>	; 
	mhud_show_g							svector@MotionID_8@ <>	; 
	mhud_hide_g							svector@MotionID_8@ <>	; 
	mhud_idle_w_gl						svector@MotionID_8@ <>	; 
	mhud_idle_w_gl_aim					svector@MotionID_8@ <>	; 
	mhud_reload_w_gl					svector@MotionID_8@ <>	; 
	mhud_shots_w_gl						svector@MotionID_8@ <>	; 
	mhud_show_w_gl						svector@MotionID_8@ <>	; 
	mhud_hide_w_gl						svector@MotionID_8@ <>	; 
	m_pAmmo2							dword ?					; offset
	m_ammoSect2							shared_str <>			; 
	m_ammoTypes2						xr_vector <>			; xr_vector<shared_str,xalloc<shared_str> > ?
	m_ammoType2							dword ?					; 
	m_ammoName2							shared_str <>			; 
	iMagazineSize2						dword ?					; 
	m_magazine2							xr_vector <>			; xr_vector<CCartridge,xalloc<CCartridge> > ?
	m_bGrenadeMode						byte ?					; 
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_DefaultCartridge2					CCartridge <>			; 
	grenade_bone_name					shared_str <>			; 
CWeaponMagazinedWGrenade ends

resptr_core struct ; (sizeof=4, align=4)
	p_									dword ?					; 
resptr_core ends

svector@int_5@	struct ; (sizeof=24, align=4)
	array								dword 5 dup(?)			; 0
	count								dword ?					; 20
svector@int_5@	ends											; 24

CSpaceRestrictor struct ; (sizeof=412, align=4)
	CGameObject <>												; 0
	m_spheres							xr_vector <>			; 360	xr_vector<_sphere<float>,xalloc<_sphere<float> > >
	m_boxes								xr_vector <>			; 376	xr_vector<CSpaceRestrictor::CPlanes,xalloc<CSpaceRestrictor::CPlanes> > ?
	m_selfbounds						Fsphere <>				; 392
	m_actuality							byte ?					; 408
	m_space_restrictor_type				byte ?					; 409
										byte ? ; undefined
										byte ? ; undefined
CSpaceRestrictor ends											; 412

CCustomZone struct ; (sizeof=876, align=4)
	CSpaceRestrictor <>											; 0
	Feel@@Touch <>												; 412
	m_effector							dword ?					; 468	offset*
	m_owner_id							dword ?					; 472
	m_ttl								dword ?					; 476
	m_zone_flags						dword ?					; 480	_flags<u32>
	m_pLocalActor						dword ?					; 484	offset*
	m_fMaxPower							dword ?					; 488
	m_fAttenuation						dword ?					; 492
	m_fHitImpulseScale					dword ?					; 496
	m_fEffectiveRadius					dword ?					; 500
	m_eHitTypeBlowout					dword ?					; 504	enum ALife::EHitType
	m_eZoneState						dword ?					; 508	enum CCustomZone::EZoneState
	m_iStateTime						dword ?					; 512
	m_iPreviousStateTime				dword ?					; 516
	m_TimeToDisable						dword ?					; 520
	m_TimeToEnable						dword ?					; 524
	m_TimeShift							dword ?					; 528
	m_StartTime							dword ?					; 532
	m_StateTime							svector@int_5@ <>		; 536
	m_dwAffectFrameNum					dword ?					; 560
	m_dwDeltaTime						dword ?					; 564
	m_dwPeriod							dword ?					; 568
	m_bZoneActive						byte ?					; 572
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_dwBlowoutParticlesTime			dword ?					; 576
	m_dwBlowoutLightTime				dword ?					; 580
	m_dwBlowoutSoundTime				dword ?					; 584
	m_dwBlowoutExplosionTime			dword ?					; 588
	m_bBlowoutWindActive				byte ?					; 592	bool
	m_bAllowScriptSpawnArtefact			byte ?					; 593	bool	//NEW включить спавн артефактов скриптом
										byte ? ; undefined
										byte ? ; undefined
	m_dwBlowoutWindTimeStart			dword ?					; 596
	m_dwBlowoutWindTimePeak				dword ?					; 600
	m_dwBlowoutWindTimeEnd				dword ?					; 604
	m_fBlowoutWindPowerMax				dword ?					; 608
	m_fStoreWindPower					dword ?					; 612
	m_iDisableHitTime					dword ?					; 616
	m_iDisableHitTimeSmall				dword ?					; 620
	m_iDisableIdleTime					dword ?					; 624
	m_sIdleParticles					shared_str <>			; 628
	m_sBlowoutParticles					shared_str <>			; 632
	m_sAccumParticles					shared_str <>			; 636
	m_sAwakingParticles					shared_str <>			; 640
	m_sEntranceParticlesSmall			shared_str <>			; 644
	m_sEntranceParticlesBig				shared_str <>			; 648
	m_sHitParticlesSmall				shared_str <>			; 652
	m_sHitParticlesBig					shared_str <>			; 656
	m_sIdleObjectParticlesSmall			shared_str <>			; 660
	m_sIdleObjectParticlesBig			shared_str <>			; 664
	m_bIdleObjectParticlesDontStop		dword ?					; 668
	m_idle_sound						ref_sound <>			; 672
	m_awaking_sound						ref_sound <>			; 676
	m_accum_sound						ref_sound <>			; 680
	m_blowout_sound						ref_sound <>			; 684
	m_hit_sound							ref_sound <>			; 688
	m_entrance_sound					ref_sound <>			; 692
	m_pIdleParticles					dword ?					; 696	offset
	m_pIdleLight						resptr_core <>			; 700	resptr_core<IRender_Light,resptrcode_light> ?
	m_IdleLightColor					Fcolor <>				; 704
	m_fIdleLightRange					dword ?					; 720
	m_fIdleLightHeight					dword ?					; 724
	m_fIdleLightRangeDelta				dword ?					; 728
	m_pIdleLAnim						dword ?					; 732	offset*
	m_pLight							resptr_core <>			; 736	resptr_core<IRender_Light,resptrcode_light> ?
	m_fLightRange						dword ?					; 740
	m_LightColor						Fcolor <>				; 744
	m_fLightTime						dword ?					; 760
	m_fLightTimeLeft					dword ?					; 764
	m_fLightHeight						dword ?					; 768
	m_ObjectInfoMap						xr_vector <>			; 772	xr_vector<SZoneObjectInfo,xalloc<SZoneObjectInfo> > ?
	m_vPrevPos							Fvector <>				; 788
	m_dwLastTimeMoved					dword ?					; 800
	m_SpawnedArtefacts					xr_vector <>			; 804	xr_vector<CArtefact *,xalloc<CArtefact *> > ?
	m_fArtefactSpawnProbability			dword ?					; 820
	m_fThrowOutPower					dword ?					; 824
	m_fArtefactSpawnHeight				dword ?					; 828
	m_sArtefactSpawnParticles			shared_str <>			; 832
	m_ArtefactBornSound					ref_sound <>			; 836
	m_ArtefactSpawn						xr_vector <>			; 840	xr_vector<CCustomZone::ARTEFACT_SPAWN,xalloc<CCustomZone::ARTEFACT_SPAWN> > ?
	m_fDistanceToCurEntity				dword ?					; 856
	m_ef_anomaly_type					dword ?					; 860
	m_ef_weapon_type					dword ?					; 864
	m_b_always_fastmode					dword ?					; 868
	o_fastmode							dword ?					; 872
CCustomZone ends												; 876

SPHImpact	struct ; (sizeof=26, align=2)
	force								Fvector <>				; 0
	point								Fvector <>				; 12
	geom								word ?					; 24
SPHImpact	ends												; 26

CBaseGraviZone	struct ; (sizeof=916, align=4)
	CCustomZone <>												; 0
	m_fThrowInImpulse					dword ?					; 876
	m_fThrowInImpulseAlive				dword ?					; 880
	m_fThrowInAtten						dword ?					; 884
	m_fBlowoutRadiusPercent				dword ?					; 888
	m_fTeleHeight						dword ?					; 892
	m_dwTimeToTele						dword ?					; 896
	m_dwTelePause						dword ?					; 900
	m_dwTeleTime						dword ?					; 904
	m_sTeleParticlesBig					shared_str <>			; 908
	m_sTeleParticlesSmall				shared_str <>			; 912
CBaseGraviZone	ends											; 916

CTelekinesis struct ; (sizeof=52, align=4)
	CPHUpdateObject <>											; 0
	objects								xr_vector <>			; 16	xr_vector<CTelekineticObject *,xalloc<CTelekineticObject *> >
	m_nearest							xr_vector <>			; 32	xr_vector<CObject *,xalloc<CObject *> > ?
	active								byte ?					; 48
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
CTelekinesis ends												; 52

CTeleWhirlwind	struct ; (sizeof=96, align=4)
	CTelekinesis <>												; 0
	m_center							Fvector <>				; 52
	m_keep_radius						dword ?					; 64	float
	m_throw_power						dword ?					; 68	float
	m_owner_object						dword ?					; 72	CGameObject*
	m_saved_impacts						xr_vector <>			; 76	xr_vector<SPHImpact,xalloc<SPHImpact> > ?
	m_destroying_particles				shared_str <>			; 92
CTeleWhirlwind	ends											; 96

CTelekineticObject struct ; (sizeof=56, align=4)
	vfptr								dword ?					; 0		
	state								dword ?					; 4		ETelekineticState
	object								dword ?					; 8		CPhysicsShellHolder*
	telekinesis							dword ?					; 12	CTelekinesis*
	target_height						dword ?					; 16	float
	time_keep_started					dword ?					; 20	u32
	time_keep_updated					dword ?					; 24	u32
	time_raise_started					dword ?					; 28	u32
	time_to_keep						dword ?					; 32	u32
	time_fire_started					dword ?					; 36	u32
	strength							dword ?					; 40	float
	m_rotate							byte ?					; 44	bool
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	sound_hold							ref_sound <>			; 48
	sound_throw							ref_sound <>			; 52
CTelekineticObject ends											; 56

CTeleWhirlwindObject struct ; (sizeof=68, align=4)
	CTelekineticObject <>										; 0
	m_telekinesis						dword ?					; 56	CTeleWhirlwind*
	b_destroyable						byte ?					; 60	bool
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	throw_power							dword ?					; 64	float
CTeleWhirlwindObject ends										; 68

CMincer	struct ; (sizeof=1028, align=4)
	CBaseGraviZone <>											; 0
	CPHDestroyableNotificator <>								; 916
	m_telekinetics						CTeleWhirlwind <>		; 920
	m_torn_particles					shared_str <>			; 1016
	m_tearing_sound						ref_sound <>			; 1020
	m_fActorBlowoutRadiusPercent		dword ?					; 1024
CMincer	ends													; 1028

CArtefact	struct ; (sizeof=952, align=8)
	CHudItemObject <>											; 0
	CPHUpdateObject <>											; 712
	m_CarringBoneID						word ?					; 728
										byte ? ; undefined
										byte ? ; undefined
	m_sParticlesName					shared_str <>			; 732
	m_activationObj						dword ?					; 736	offset*
	m_bLightsEnabled					byte ?					; 740
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_pTrailLight						resptr_core <>			; 744	resptr_core<IRender_Light,resptrcode_light> ?
	m_TrailLightColor					Fcolor <>				; 748
	m_fTrailLightRange					dword ?					; 764
	m_bCanSpawnZone						byte ?					; 768
										byte ? ; undefined
										byte ? ; undefined
										byte ? ; undefined
	m_fHealthRestoreSpeed				dword ?					; 772
	m_fRadiationRestoreSpeed			dword ?					; 776
	m_fSatietyRestoreSpeed				dword ?					; 780
	m_fPowerRestoreSpeed				dword ?					; 784
	m_fBleedingRestoreSpeed				dword ?					; 788
	m_ArtefactHitImmunities				CHitImmunity <>			; 792
	m_anim_idle							svector@MotionID_8@ <>	; 844
	m_anim_idle_sprint					svector@MotionID_8@ <>	; 864
	m_anim_hide							svector@MotionID_8@ <>	; 884
	m_anim_show							svector@MotionID_8@ <>	; 904
	m_anim_activate						svector@MotionID_8@ <>	; 924
	o_render_frame						dword ?					; 944
	o_fastmode							dword ?					; 948
CArtefact	ends												; 952

CGraviArtefact	struct ; (sizeof=960, align=8)
	CArtefact <>												; 0
	m_fJumpHeight						dword ?					; 952
	m_fEnergy							dword ?					; 956
CGraviArtefact	ends											; 960

CMercuryBall	struct ; (sizeof=976, align=8)
	CArtefact <>												; 0
	m_timeLastUpdate					qword ?					; 952
	m_timeToUpdate						qword ?					; 960
	m_fImpulseMin						dword ?					; 968
	m_fImpulseMax						dword ?					; 972
CMercuryBall	ends											; 976

MAX_PARTS			equ 4
MAX_CHANNELS		equ 4
MAX_BLENDED			equ 16
MAX_BLENDED_POOL	equ (MAX_BLENDED*MAX_PARTS*MAX_CHANNELS)	;=256
MAX_ANIM_SLOT		equ 4

CPartDef struct ; (sizeof=20, align=4)
	Name_								shared_str <>			; 0
	bones_								xr_vector <>			; 4		xr_vector<u32,xalloc<u32> > ?
CPartDef ends													; 20

CPartition struct ; (sizeof=80, align=4)
	P									CPartDef MAX_PARTS dup(<>); 0
CPartition ends													; 80

motions_value struct ; (sizeof=152, align=4)
	m_motion_map						xr_map <>				; 0		xr_map<shared_str,u16,accel_str_pred,xalloc<std::pair<shared_str,u16> > > ?
	m_cycle								xr_map <>				; 12	xr_map<shared_str,u16,accel_str_pred,xalloc<std::pair<shared_str,u16> > > ?
	m_fx								xr_map <>				; 24	xr_map<shared_str,u16,accel_str_pred,xalloc<std::pair<shared_str,u16> > > ?
	m_partition							CPartition <>			; 36
	m_dwReference						dword ?					; 116
	m_motions							xr_map <>				; 120	xr_map<shared_str,xr_vector<CMotion,xalloc<CMotion> >,std::less<shared_str>,xalloc<std::pair<shared_str,xr_vector<CMotion,xalloc<CMotion> > > > > ?
	m_mdefs								xr_vector <>			; 132	xr_vector<CMotionDef,xalloc<CMotionDef> > ?
	m_id								shared_str <>			; 148
motions_value ends												; 152

shared_motions	struct ; (sizeof=4, align=4)
	p_									dword ?					; motions_value*
shared_motions	ends

CKinematicsAnimated@@SMotionsSlot struct ; (sizeof=20, align=4)
	motions								shared_motions <>		; 0
	bone_motions						xr_vector <>			; 4		xr_vector<xr_vector<CMotion,xalloc<CMotion> > *,xalloc<xr_vector<CMotion,xalloc<CMotion> > *> > ?
CKinematicsAnimated@@SMotionsSlot ends							; 20

CMotionDef struct ; (sizeof=32, align=4)
	bone_or_part						word ?					; 0
	motion								word ?					; 2
	speed								word ?					; 4
	power								word ?					; 6
	accrue								word ?					; 8
	falloff								word ?					; 10
	flags								word ?					; 12
										byte ? ; undefined
										byte ? ; undefined
	marks								xr_vector <>			; 16	xr_vector<motion_marks,xalloc<motion_marks> > ?
CMotionDef ends													; 32

svector@CBlend_256@ struct ; (sizeof=16388, align=4)
	array								CBlend MAX_BLENDED_POOL dup(<>); 0
	count								dword ?					; 16384
svector@CBlend_256@ ends										; 16388

svector@CBlend__64@ struct ; (sizeof=260, align=4)
	array								dword 64 dup(?)			; 0		CBlend*		MAX_BLENDED*MAX_CHANNELS = 64
	count								dword ?					; 256
svector@CBlend__64@ ends										; 260

;------------------------------IRender_Visual----------------------------------
virt@@IRender_Visual struct
											dword 6 dup(?)
	cast_CKinematics						dword ?		; 24		; CKinematics*
	cast_CKinematicsAnimated				dword ?		; 28		; CKinematicsAnimated*
	cast_IParticleCustom					dword ?		; 32		; IParticleCustom*
virt@@IRender_Visual ends
;------------------------------------------------------------------------------

IRender_Visual	struct ; (sizeof=68, align=4)
	vfptr								dword ?					; 0		offset*
	Type_								dword ?					; 4
	vis									vis_data <>				; 8
	shader								resptr_core <>			; 64	resptr_core<Shader,resptrcode_shader> ?
IRender_Visual	ends											; 68

FHierrarhyVisual struct ; (sizeof=88, align=4)
	IRender_Visual <>											; 0			
	children							xr_vector <>			; 68	xr_vector<IRender_Visual *,xalloc<IRender_Visual *> > ?
	bDontDelete							dword ?					; 84
FHierrarhyVisual ends											; 88

CKinematics		struct ; (sizeof=180, align=4)
	FHierrarhyVisual <>											; 0
	m_lod								dword ?					; 88	offset*
	wallmarks							xr_vector <>			; 92	xr_vector<intrusive_ptr<CSkeletonWallmark,intrusive_base>,xalloc<intrusive_ptr<CSkeletonWallmark,intrusive_base> > > ?
	wm_frame							dword ?					; 108
	children_invisible					xr_vector <>			; 112	xr_vector<IRender_Visual *,xalloc<IRender_Visual *> > ?
	pUserData							dword ?					; 128	offset*
	bone_instances						dword ?					; 132	offset*
	bones								dword ?					; 136	offset*
	iRoot								word ?					; 140
	m_anim_flags						byte ?					; 142	Flag8	NEW
										byte ? ; undefined
	bone_map_N							dword ?					; 144	offset*
	bone_map_P							dword ?					; 148	offset*
	Update_Visibility					dword ?					; 152
	UCalc_Time							dword ?					; 160
	UCalc_Visibox						dword ?					; 164
	visimask							qword ?					; 168	flags64
	Update_Callback						dword ?					; 172	offset*
	Update_Callback_Param				dword ?					; 176	offset*
CKinematics		ends											; 180

CKinematicsAnimated struct ; (sizeof=17916, align=4)
	CKinematics <>												; 0
	Update_LastTime						dword ?					; 180
	blend_instances						dword ?					; 184	CBlendInstance*
	m_Motions							xr_vector <>			; 188	xr_vector<CKinematicsAnimated::SMotionsSlot,xalloc<CKinematicsAnimated::SMotionsSlot> > ?
	m_Partition							dword ?					; 204	CPartition*
	blend_pool							svector@CBlend_256@ <>	; 208
	blend_cycles						svector@CBlend__64@ MAX_PARTS dup(<>); 16596
	blend_fx							svector@CBlend__64@ <>	; 17636
	channel_factors						dword MAX_CHANNELS dup(?);17896	float
CKinematicsAnimated ends										; 17916

CHWCaps@@caps_Geometry struct ; (sizeof=8, align=4)
	_bf0								dword ?						; 
	_bf4								dword ?						; 
CHWCaps@@caps_Geometry ends											; 

CHWCaps@@caps_Raster struct ; (sizeof=8, align=4)
	_bf0								dword ?						; 
	_bf4								dword ?
CHWCaps@@caps_Raster ends											; 

CHWCaps struct ; (sizeof=84, align=4)
	bForceGPU_REF						dword ?						; 0
	bForceGPU_SW						dword ?						; 4
	bForceGPU_NonPure					dword ?						; 8
	SceneMode							dword ?						; 12
	fTarget								dword ?						; 16	enum _D3DFORMAT
	fDepth								dword ?						; 20	enum _D3DFORMAT
	dwRefreshRate						dword ?						; 24
	geometry_major						word ?						; 28
	geometry_minor						word ?						; 30
	geometry							CHWCaps@@caps_Geometry <>	; 32
	raster_major						word ?						; 40
	raster_minor						word ?						; 44
	raster								CHWCaps@@caps_Raster <>		; 48
	id_vendor							dword ?						; 52
	id_device							dword ?						; 56
	bStencil							dword ?						; 60
	bScissor							dword ?						; 64
	bTableFog							dword ?						; 68
	soDec								dword ?						; 72	enum _D3DSTENCILOP
	soInc								dword ?						; 76	enum _D3DSTENCILOP
	dwMaxStencilValue					dword ?						; 80
CHWCaps ends												; 84

_D3DPRESENT_PARAMETERS_ struct ; (sizeof=56, align=4)
	BackBufferWidth						dword ?						; 0
	BackBufferHeight					dword ?						; 4
	BackBufferFormat					dword ?						; 8		enum _D3DFORMAT
	BackBufferCount						dword ?						; 12
	MultiSampleType						dword ?						; 16	enum _D3DMULTISAMPLE_TYPE
	MultiSampleQuality					dword ?						; 20
	SwapEffect							dword ?						; 24	enum _D3DSWAPEFFECT
	hDeviceWindow						dword ?						; 28	offset
	Windowed							dword ?						; 32
	EnableAutoDepthStencil				dword ?						; 36
	AutoDepthStencilFormat				dword ?						; 40	enum _D3DFORMAT
	Flags								dword ?						; 44
	FullScreen_RefreshRateInHz			dword ?						; 48
	PresentationInterval				dword ?						; 52
_D3DPRESENT_PARAMETERS_ ends										; 56

fastdelegate@@DelegateMemento struct ; (sizeof=8, align=4)
	m_pthis								dword ?					; offset
	m_pFunction							dword ?					; offset
fastdelegate@@DelegateMemento ends

fastdelegate@@detail@@ClosurePtr struct ; (sizeof=8, align=4)
	fastdelegate@@DelegateMemento <>
fastdelegate@@detail@@ClosurePtr ends

fastdelegate@@FastDelegate1 struct ; (sizeof=8, align=4)
	m_Closure						fastdelegate@@detail@@ClosurePtr <>	
fastdelegate@@FastDelegate1 ends

xr_resource_flagged struct ; (sizeof=8, align=4)
	xr_resource <>													; 0
	dwFlags								dword ?						; 4
xr_resource_flagged ends											; 8

xr_resource_named struct ; (sizeof=12, align=4)
	xr_resource_flagged <>											; 0
	cName								shared_str <>				; 8
xr_resource_named ends												; 12

_D3DSURFACE_DESC struct ; (sizeof=32, align=4)
	Format								dword ?						; enum _D3DFORMAT
	Type_								dword ?						; enum _D3DRESOURCETYPE
	Usage								dword ?
	Pool								dword ?						; enum _D3DPOOL
	MultiSampleType						dword ?						; enum _D3DMULTISAMPLE_TYPE
	MultiSampleQuality					dword ?
	Width_								dword ?
	Height								dword ?
_D3DSURFACE_DESC ends

_D3DVIEWPORT9 struct ; (sizeof=24, align=4)
	X									dword ?		; 0
	Y									dword ?		; 4				/* Viewport Top left */
	Width_								dword ?		; 8	
	Height_								dword ?		; 12			/* Viewport Dimensions */
	MinZ								dword ?		; 16	float	/* Min/max of clip Volume */
	MaxZ								dword ?		; 20	float
_D3DVIEWPORT9 ends									; 24

;IDirect3DBaseTexture9 struct dword;DECLARE_INTERFACE_(IDirect3DBaseTexture9, IDirect3DResource9)
COMINTERFACE IDirect3DBaseTexture9		;; виртуальные функции
;/*** IUnknown methods ***/
;	CVIRTUAL	QueryInterface			<STDCALL>, <dword>, riid:ptr _GUID, ppvObj:ptr ptr	; 0	 (THIS_ REFIID riid, void** ) PURE;
;	CVIRTUAL	AddRef					<STDCALL>, <dword>		 ; 4		ULONG	(THIS) PURE;
;	CVIRTUAL	Release					<STDCALL>, <dword>		 ; 8		ULONG	(THIS) PURE;
;/*** IDirect3DResource9 methods ***/
	CVIRTUAL	GetDevice,				<STDCALL>, <dword>, ppDevice:ptr ptr IDirect3DDevice9	; 12	(THIS_ ** ) PURE;
	CVIRTUAL	SetPrivateData,			<STDCALL>, <dword>, refguid:ptr _GUID, pData:ptr , SizeOfData:DWORD, Flags:DWORD	; 16
	CVIRTUAL	GetPrivateData,			<STDCALL>, <dword>, refguid:ptr _GUID, pData:ptr , pSizeOfData:ptr DWORD	; 20
	CVIRTUAL	FreePrivateData,		<STDCALL>, <dword>, refguid:ptr _GUID	; 24	(THIS_ REFGUID refguid) PURE;
	CVIRTUAL	SetPriority,			<STDCALL>, <dword>, PriorityNew:DWORD	; 28	DWORD	 (THIS_	 ) PURE;
	CVIRTUAL	GetPriority,			<STDCALL>, <dword>	; 32	DWORD	 (THIS) PURE;
	CVIRTUAL	PreLoad,				<STDCALL>, <dword>	; 36	void	(THIS) PURE;
	CVIRTUAL	GetType,				<STDCALL>, <dword>	; 40	D3DRESOURCETYPE, (THIS) PURE;
	CVIRTUAL	SetLOD,					<STDCALL>, <dword>, LODNew:DWORD	; 44	DWORD	 (THIS_	 ) PURE;
	CVIRTUAL	GetLOD,					<STDCALL>, <dword>	; 48	DWORD	 (THIS) PURE;
	CVIRTUAL	GetLevelCount,			<STDCALL>, <dword>	; 52	DWORD	 (THIS) PURE;
	CVIRTUAL	SetAutoGenFilterType,	<STDCALL>, <dword>, FilterType:dword	; 56	(THIS_ D3DTEXTUREFILTERTYPE ) PURE;
	CVIRTUAL	GetAutoGenFilterType,	<STDCALL>, <dword>	; 60	D3DTEXTUREFILTERTYPE (THIS) PURE;
	CVIRTUAL	GenerateMipSubLevels,	<STDCALL>, <dword>	; 64	void	(THIS) PURE;
	CVIRTUAL	GetLevelDesc,			<STDCALL>, <dword>, Level:dword, pDesc:ptr ;D3DSURFACE_DESC	; 68	(THIS UINT , *) ;
	CVIRTUAL	GetSurfaceLevel,		<STDCALL>, <dword>, Level:dword, ppSurfaceLevel:ptr ;ptr IDirect3DSurface9	; 72
	CVIRTUAL	LockRect,				<STDCALL>, <dword>, Level:dword, pLockedRect:ptr , pRect:ptr _RECT, Flags:DWORD	; 76(THIS ,D3DLOCKED_RECT*)
	CVIRTUAL	UnlockRect,				<STDCALL>, <dword>, Level:dword	; 80	(THIS UINT ) ;
	CVIRTUAL	AddDirtyRect,			<STDCALL>, <dword>, pDirtyRect:ptr _RECT	; 84	(THIS CONST * ) ;
ENDMETHODS
	param1		dword ?
	param2		dword ?
ENDCOMINTERFACE
ptrIDirect3DBaseTexture9	typedef ptr IDirect3DBaseTexture9

CTexture struct ; (sizeof=104, align=4)
	vfptr								dword ?							; 0		offset
	xr_resource_named <>												; 4
	flags								dword ?							; 16
	bind								fastdelegate@@FastDelegate1 <>	; 20
	pSurface							ptrIDirect3DBaseTexture9 ?		; 28	IDirect3DBaseTexture9*
	pAVI								dword ?							; 32	CAviPlayerCustom*
	pTheora								dword ?							; 36	CTheoraSurface*
	m_material							dword ?							; 40	float
	m_bumpmap							shared_str <>					; 44
	union
		m_play_time						dword ?							; 48
		seqMSPF							dword ?							; 48
	ends
	seqDATA								xr_vector <>					; 52	xr_vector<IDirect3DBaseTexture9 *,xalloc<IDirect3DBaseTexture9 *>>?
	desc_cache							dword ?							; 68	IDirect3DBaseTexture9*
	desc								_D3DSURFACE_DESC <>				; 72
CTexture ends															; 104

Shader struct ; (sizeof=32, align=4)
	xr_resource_flagged <>										; 0
	E									resptr_core 6 dup(<>)	; 8		resptr_core<ShaderElement,resptr_base<ShaderElement> >
Shader ends														; 32

svector@SPass_2@ struct ; (sizeof=12, align=4)
	array								resptr_core 2 dup(<>)	; 0		resptr_core<SPass,resptr_base<SPass> > 2
	count								dword ?					; 8
svector@SPass_2@ ends											; 12

ShaderElement	struct ; (sizeof=24, align=4)
	xr_resource_flagged <>									; 0
	flags								dword ?				; 8
	passes								svector@SPass_2@ <>	; 12
ShaderElement	ends										; 24

SPass struct ; (sizeof=32, align=4)
	xr_resource_flagged <>									; 0
	state								resptr_core <>		; 8		resptr_core<SState,resptr_base<SState> > ?
	ps									resptr_core <>		; 12	resptr_core<SPS,resptr_base<SPS> > ?
	vs									resptr_core <>		; 16	resptr_core<SVS,resptr_base<SVS> > ?
	constants							resptr_core <>		; 20	resptr_core<R_constant_table,resptr_base<R_constant_table> > ?
	T									resptr_core <>		; 24	resptr_core<STextureList,resptr_base<STextureList> > ?
	C_									resptr_core <>		; 28	resptr_core<SConstantList,resptr_base<SConstantList> > ?
SPass ends													; 32

STextureList struct ; (sizeof=28, align=4)
	vfptr					dword ?	; 0		offset
	xr_resource_flagged <>	; 4
	xr_vector <>			; 12	xr_vector<std::pair<unsigned int,resptr_core<CTexture,resptrcode_texture>>,xalloc<std::pair<unsigned int,resptr_core<CTexture,resptrcode_texture>>>> ?
STextureList ends			; 28

CTextureDescrMngr struct ; (sizeof=12, align=4)
	m_texture_details		xr_map <>			;xr_map<shared_str,CTextureDescrMngr::texture_desc,std::less<shared_str>,xalloc<std::pair<shared_str,CTextureDescrMngr::texture_desc> > > ?
CTextureDescrMngr ends

CResourceManager struct ; (sizeof=320, align=4)
	m_blenders				xr_map <>			; 0		xr_map<char const *,IBlender *,CResourceManager::str_pred,xalloc<std::pair<char const *,IBlender *> > > ?
	m_textures				xr_map <>			; 12	xr_map<char const *,CTexture *,CResourceManager::str_pred,xalloc<std::pair<char const *,CTexture *> > > ?
	m_matrices				xr_map <>			; 24	xr_map<char const *,CMatrix *,CResourceManager::str_pred,xalloc<std::pair<char const *,CMatrix *> > > ?
	m_constants				xr_map <>			; 36	xr_map<char const *,CConstant *,CResourceManager::str_pred,xalloc<std::pair<char const *,CConstant *> > > ?
	m_rtargets				xr_map <>			; 48	xr_map<char const *,CRT *,CResourceManager::str_pred,xalloc<std::pair<char const *,CRT *> > > ?
	m_rtargets_c			xr_map <>			; 60	xr_map<char const *,CRTC *,CResourceManager::str_pred,xalloc<std::pair<char const *,CRTC *> > > ?
	m_vs					xr_map <>			; 72	xr_map<char const *,SVS *,CResourceManager::str_pred,xalloc<std::pair<char const *,SVS *> > > ?
	m_ps					xr_map <>			; 84	xr_map<char const *,SPS *,CResourceManager::str_pred,xalloc<std::pair<char const *,SPS *> > > ?
	m_td					xr_map <>			; 96	xr_map<char const *,CResourceManager::texture_detail,CResourceManager::str_pred,xalloc<std::pair<char const *,CResourceManager::texture_detail> > > ?
	v_states				xr_vector <>		; 108	xr_vector<SState *,xalloc<SState *> > ?
	v_declarations			xr_vector <>		; 124	xr_vector<SDeclaration *,xalloc<SDeclaration *> > ?
	v_geoms					xr_vector <>		; 140	xr_vector<SGeometry *,xalloc<SGeometry *> > ?
	v_constant_tables		xr_vector <>		; 156	xr_vector<R_constant_table *,xalloc<R_constant_table *> > ?
	lst_textures			xr_vector <>		; 172	xr_vector<STextureList *,xalloc<STextureList *> > ?
	lst_matrices			xr_vector <>		; 188	xr_vector<SMatrixList *,xalloc<SMatrixList *> > ?
	lst_constants			xr_vector <>		; 204	xr_vector<SConstantList *,xalloc<SConstantList *> > ?
	v_passes				xr_vector <>		; 220	xr_vector<SPass *,xalloc<SPass *> > ?
	v_elements				xr_vector <>		; 236	xr_vector<ShaderElement *,xalloc<ShaderElement *> > ?
	v_shaders				xr_vector <>		; 252	xr_vector<Shader *,xalloc<Shader *> > ?
	m_necessary				xr_vector <>		; 268	xr_vector<resptr_core<CTexture,resptrcode_texture>,xalloc<resptr_core<CTexture,resptrcode_texture> > > ?
	m_textures_description	CTextureDescrMngr <>; 284	
	v_constant_setup		xr_vector <>		; 296	xr_vector<std::pair<shared_str,R_constant_setup *>,xalloc<std::pair<shared_str,R_constant_setup *> > > ?
	LSVM					dword ?				; 312	lua_State*
	bDeferredLoad			dword ?				; 316
CResourceManager ends							; 320

BOOL		equ <dword>

;typedef enum D3DTEXTUREFILTERTYPE {
D3DTEXF_NONE			= dword ptr 0		; filtering disabled (valid for mip filter only); фильтрование повреждало (действительный для фильтра mip только)
D3DTEXF_POINT			= dword ptr 1		; nearest; самый близкий
D3DTEXF_LINEAR			= dword ptr 2		; linear interpolation; линейная вставка
D3DTEXF_ANISOTROPIC		= dword ptr 3		; anisotropic; анизотропный
D3DTEXF_PYRAMIDALQUAD	= dword ptr 6		; 4-sample tent; палатка с 4 образцами
D3DTEXF_GAUSSIANQUAD	= dword ptr 7		; 4-sample gaussian; гауссовские 4 образца
D3DTEXF_CONVOLUTIONMONO	= dword ptr 8		; Convolution filter for monochrome textures; фильтр Скручивания для одноцветных структур
;/* -- D3D9Ex only */
D3DTEXF_FORCE_DWORD		= dword ptr 7FFFFFFFh	; force 32-bit size enum; force 32-bit size enum
;}

_GUID struct
	Data1		dword ?			;
	Data2		word ?			;
	Data3		word ?			;
	Data4		byte 8 dup(?)	;
_GUID ends

COMINTERFACE IDirect3D9 
	CVIRTUAL		RegisterSoftwareDevice,			<STDCALL>, <dword>, :PTR 
	CVIRTUAL		GetAdapterCount,				<STDCALL>, <dword> 
	CVIRTUAL		GetAdapterIdentifier,			<STDCALL>, <dword> 
	CVIRTUAL		GetAdapterModeCount,			<STDCALL>, <dword> 
	CVIRTUAL		EnumAdapterModes,				<STDCALL>, <dword> 
	CVIRTUAL		GetAdapterDisplayMode,			<STDCALL>, <dword> 
	CVIRTUAL		CheckDeviceType,				<STDCALL>, <dword> 
	CVIRTUAL		CheckDeviceFormat,				<STDCALL>, <dword> 
	CVIRTUAL		CheckDeviceMultiSampleType,		<STDCALL>, <dword> 
	CVIRTUAL		CheckDepthStencilMatch,			<STDCALL>, <dword> 
	CVIRTUAL		CheckDeviceFormatConversion,	<STDCALL>, <dword> 
	CVIRTUAL		GetDeviceCaps,					<STDCALL>, <dword>, Adapter:DWORD, DeviceType:DWORD, pCaps:PTR 
	CVIRTUAL		GetAdapterMonitor,				<STDCALL>, <dword> 
	CVIRTUAL		CreateDevice,					<STDCALL>, <dword> 
ENDCOMINTERFACE

COMINTERFACE IDirect3DSurface9
	;/*** IDirect3DResource9 methods ***/
	CVIRTUAL		GetDevice,					<STDCALL>, <dword>,		ppDevice:ptr ;ptr IDirect3DDevice9
	CVIRTUAL		SetPrivateData,				<STDCALL>, <dword>,		refguid:ptr _GUID, pData:ptr, SizeOfData:DWORD, Flags:DWORD
	CVIRTUAL		GetPrivateData,				<STDCALL>, <dword>,		refguid:ptr _GUID, pData:ptr, pSizeOfData:ptr DWORD
	CVIRTUAL		FreePrivateData,			<STDCALL>, <dword>,		refguid:ptr _GUID
	CVIRTUAL		SetPriority,				<STDCALL>, <dword>,	PriorityNew:DWORD
	CVIRTUAL		GetPriority,				<STDCALL>, <dword>
	CVIRTUAL		PreLoad,					<STDCALL>, <dword>
	CVIRTUAL		GetType,					<STDCALL>, <dword>
	CVIRTUAL		GetContainer,				<STDCALL>, <dword>,		riid:ptr _GUID, ppContainer:ptr ptr
	CVIRTUAL		GetDesc,					<STDCALL>, <dword>,		pDesc:ptr ;D3DSURFACE_DESC
	CVIRTUAL		LockRect,					<STDCALL>, <dword>,		pLockedRect:ptr , pRect:ptr _RECT, Flags:DWORD;D3DLOCKED_RECT
	CVIRTUAL		UnlockRect,					<STDCALL>, <dword>,
	CVIRTUAL		GetDC,						<STDCALL>, <dword>,		phdc:ptr dword	;HDC
	CVIRTUAL		ReleaseDC,					<STDCALL>, <dword>,		hdc:dword	;HDC
ENDCOMINTERFACE

;IDirect3DDevice9 struct		;, IUnknown)
COMINTERFACE IDirect3DDevice9	;; виртуальные функции
;/*** IUnknown methods ***/
	;CVIRTUAL	QueryInterface,					DWORD, riid:DWORD, ppvObj:PTR	;0 (THIS_ REFIID riid, void** ppvObj) = 0;
	;CVIRTUAL	AddRef,							ULONG							;4 ULONG	(void) = 0;
	;CVIRTUAL	Release,						ULONG							;8 ULONG	(void) = 0;
;/*** IDirect3DDevice9 methods ***/
	CVIRTUAL	TestCooperativeLevel,			<STDCALL>, <dword>		;IInterface_Function0 ?		;12 (void) = 0;
	CVIRTUAL	GetAvailableTextureMem,			<STDCALL>, <dword>	;16 UINT	(void) = 0;
	CVIRTUAL	EvictManagedResources,			<STDCALL>, <dword>	;20 (void) = 0;
	CVIRTUAL	GetDirect3D,					<STDCALL>, <dword>, ppD3D9:ptr ;ptr IDirect3D9	;24 
	CVIRTUAL	GetDeviceCaps,					<STDCALL>, <dword>, pCaps:ptr	;28 (THIS_ D3DCAPS9* pCaps) = 0;
	CVIRTUAL	GetDisplayMode,					<STDCALL>, <dword>	;32 (THIS_ UINT iSwapChain,D3DDISPLAYMODE* pMode) = 0;
	CVIRTUAL	GetCreationParameters,			<STDCALL>, <dword>	;36 (THIS_ D3DDEVICE_CREATION_PARAMETERS *pParameters) = 0;
	CVIRTUAL	SetCursorProperties,			<STDCALL>, <dword>	;40 (THIS_ UINT XHotSpot,UINT YHotSpot,IDirect3DSurface9* pCursorBitmap) = 0;
	CVIRTUAL	SetCursorPosition,				<STDCALL>, <dword>, X:DWORD, Y:DWORD, Flags:DWORD	;44 void	(THIS_ int X,int Y,DWORD Flags) = 0;
	CVIRTUAL	ShowCursor,						<STDCALL>, <dword>, bShow:BOOL	;48 BOOL	(THIS_ BOOL bShow) = 0;
	CVIRTUAL	CreateAdditionalSwapChain,		<STDCALL>, <dword>	;52 (THIS_ D3DPRESENT_PARAMETERS* pPresentationParameters,IDirect3DSwapChain9** pSwapChain) = 0;
	CVIRTUAL	GetSwapChain,					<STDCALL>, <dword>	;56 (THIS_ UINT iSwapChain,IDirect3DSwapChain9** pSwapChain) = 0;
	CVIRTUAL	GetNumberOfSwapChains,			<STDCALL>, <dword>	;60 UINT	(void) = 0;
	CVIRTUAL	Reset,							<STDCALL>, <dword>	;64 (THIS_ D3DPRESENT_PARAMETERS* pPresentationParameters) = 0;
	CVIRTUAL	Present,						<STDCALL>, <dword>	;68 (THIS_ CONST RECT* pSourceRect,CONST RECT* pDestRect,HWND hDestWindowOverride,CONST RGNDATA* pDirtyRegion) = 0;
	CVIRTUAL	GetBackBuffer,					<STDCALL>, <dword>	;72 (THIS_ UINT iSwapChain,UINT iBackBuffer,D3DBACKBUFFER_TYPE Type,IDirect3DSurface9** ppBackBuffer) = 0;
	CVIRTUAL	GetRasterStatus,				<STDCALL>, <dword>	;76 (THIS_ UINT iSwapChain,D3DRASTER_STATUS* pRasterStatus) = 0;
	CVIRTUAL	SetDialogBoxMode,				<STDCALL>, <dword>	;80 (THIS_ BOOL bEnableDialogs) = 0;
	CVIRTUAL	SetGammaRamp,					<STDCALL>, <dword>	;84 void	(THIS_ UINT iSwapChain,DWORD Flags,CONST D3DGAMMARAMP* pRamp) = 0;
	CVIRTUAL	GetGammaRamp,					<STDCALL>, <dword>	;88 void	(THIS_ UINT iSwapChain,D3DGAMMARAMP* pRamp) = 0;
	CVIRTUAL	CreateTexture,					<STDCALL>, <dword>	;92 (THIS_ UINT Width,UINT Height,UINT Levels,DWORD Usage,D3DFORMAT Format,D3DPOOL Pool,IDirect3DTexture9** ppTexture,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	CreateVolumeTexture,			<STDCALL>, <dword>	;96 (THIS_ UINT Width,UINT Height,UINT Depth,UINT Levels,DWORD Usage,D3DFORMAT Format,D3DPOOL Pool,IDirect3DVolumeTexture9** ppVolumeTexture,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	CreateCubeTexture,				<STDCALL>, <dword>	;100 (THIS_ UINT EdgeLength,UINT Levels,DWORD Usage,D3DFORMAT Format,D3DPOOL Pool,IDirect3DCubeTexture9** ppCubeTexture,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	CreateVertexBuffer,				<STDCALL>, <dword>	;104 (THIS_ UINT Length,DWORD Usage,DWORD FVF,D3DPOOL Pool,IDirect3DVertexBuffer9** ppVertexBuffer,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	CreateIndexBuffer,				<STDCALL>, <dword>	;108 (THIS_ UINT Length,DWORD Usage,D3DFORMAT Format,D3DPOOL Pool,IDirect3DIndexBuffer9** ppIndexBuffer,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	CreateRenderTarget,				<STDCALL>, <dword>	;112 (THIS_ UINT Width,UINT Height,D3DFORMAT Format,D3DMULTISAMPLE_TYPE MultiSample,DWORD MultisampleQuality,BOOL Lockable,IDirect3DSurface9** ppSurface,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	CreateDepthStencilSurface,		<STDCALL>, <dword>	;116 (THIS_ UINT Width,UINT Height,D3DFORMAT Format,D3DMULTISAMPLE_TYPE MultiSample,DWORD MultisampleQuality,BOOL Discard,IDirect3DSurface9** ppSurface,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	UpdateSurface,					<STDCALL>, <dword>	;120 (THIS_ IDirect3DSurface9* pSourceSurface,CONST RECT* pSourceRect,IDirect3DSurface9* pDestinationSurface,CONST POINT* pDestPoint) = 0;
	CVIRTUAL	UpdateTexture,					<STDCALL>, <dword>	;124 (THIS_ IDirect3DBaseTexture9* pSourceTexture,IDirect3DBaseTexture9* pDestinationTexture) = 0;
	CVIRTUAL	GetRenderTargetData,			<STDCALL>, <dword>	;128 (THIS_ IDirect3DSurface9* pRenderTarget,IDirect3DSurface9* pDestSurface) = 0;
	CVIRTUAL	GetFrontBufferData,				<STDCALL>, <dword>	;132 (THIS_ UINT iSwapChain,IDirect3DSurface9* pDestSurface) = 0;
	CVIRTUAL	StretchRect,					<STDCALL>, <dword>, pSourceSurface:ptr IDirect3DSurface9, pSourceRect:ptr _RECT, pDestSurface:ptr IDirect3DSurface9, pDestRect:ptr _RECT, Filter:dword	;136 (THIS_ ) = 0;
	CVIRTUAL	ColorFill,						<STDCALL>, <dword>	;140 (THIS_ IDirect3DSurface9* pSurface,CONST RECT* pRect,D3DCOLOR color) = 0;
	CVIRTUAL	CreateOffscreenPlainSurface,	<STDCALL>, <dword>	;144 (THIS_ UINT Width,UINT Height,D3DFORMAT Format,D3DPOOL Pool,IDirect3DSurface9** ppSurface,HANDLE* pSharedHandle) = 0;
	CVIRTUAL	SetRenderTarget,				<STDCALL>, <dword>	;148 (THIS_ DWORD RenderTargetIndex,IDirect3DSurface9* pRenderTarget) = 0;
	CVIRTUAL	GetRenderTarget,				<STDCALL>, <dword>	;152 (THIS_ DWORD RenderTargetIndex,IDirect3DSurface9** ppRenderTarget) = 0;
	CVIRTUAL	SetDepthStencilSurface,			<STDCALL>, <dword>	;156 (THIS_ IDirect3DSurface9* pNewZStencil) = 0;
	CVIRTUAL	GetDepthStencilSurface,			<STDCALL>, <dword>	;160 (THIS_ IDirect3DSurface9** ppZStencilSurface) = 0;
	CVIRTUAL	BeginScene,						<STDCALL>, <dword>	;164 (void) = 0;
	CVIRTUAL	EndScene,						<STDCALL>, <dword>	;168 (void) = 0;
	CVIRTUAL	Clear,							<STDCALL>, <dword>	;172 (THIS_ DWORD Count,CONST D3DRECT* pRects,DWORD Flags,D3DCOLOR Color,float Z,DWORD Stencil) = 0;
	CVIRTUAL	SetTransform,					<STDCALL>, <dword>	;176 (THIS_ D3DTRANSFORMSTATETYPE State,CONST D3DMATRIX* pMatrix) = 0;
	CVIRTUAL	GetTransform,					<STDCALL>, <dword>	;180 (THIS_ D3DTRANSFORMSTATETYPE State,D3DMATRIX* pMatrix) = 0;
	CVIRTUAL	MultiplyTransform,				<STDCALL>, <dword>	;184 (THIS_ D3DTRANSFORMSTATETYPE,CONST D3DMATRIX*) = 0;
	CVIRTUAL	SetViewport,					<STDCALL>, <dword>	;188 (THIS_ CONST D3DVIEWPORT9* pViewport) = 0;
	CVIRTUAL	GetViewport,					<STDCALL>, <dword>	;192 (THIS_ D3DVIEWPORT9* pViewport) = 0;
	CVIRTUAL	SetMaterial,					<STDCALL>, <dword>	;196 (THIS_ CONST D3DMATERIAL9* pMaterial) = 0;
	CVIRTUAL	GetMaterial,					<STDCALL>, <dword>	;200 (THIS_ D3DMATERIAL9* pMaterial) = 0;
	CVIRTUAL	SetLight,						<STDCALL>, <dword>	;204 (THIS_ DWORD Index,CONST D3DLIGHT9*) = 0;
	CVIRTUAL	GetLight,						<STDCALL>, <dword>	;208 (THIS_ DWORD Index,D3DLIGHT9*) = 0;
	CVIRTUAL	LightEnable,					<STDCALL>, <dword>	;212 (THIS_ DWORD Index,BOOL Enable) = 0;
	CVIRTUAL	GetLightEnable,					<STDCALL>, <dword>	;216 (THIS_ DWORD Index,BOOL* pEnable) = 0;
	CVIRTUAL	SetClipPlane,					<STDCALL>, <dword>	;220 (THIS_ DWORD Index,CONST float* pPlane) = 0;
	CVIRTUAL	GetClipPlane,					<STDCALL>, <dword>	;224 (THIS_ DWORD Index,float* pPlane) = 0;
	CVIRTUAL	SetRenderState,					<STDCALL>, <dword>	;228 (THIS_ D3DRENDERSTATETYPE State,DWORD Value) = 0;
	CVIRTUAL	GetRenderState,					<STDCALL>, <dword>	;232 (THIS_ D3DRENDERSTATETYPE State,DWORD* pValue) = 0;
	CVIRTUAL	CreateStateBlock,				<STDCALL>, <dword>	;236 (THIS_ D3DSTATEBLOCKTYPE Type,IDirect3DStateBlock9** ppSB) = 0;
	CVIRTUAL	BeginStateBlock,				<STDCALL>, <dword>	;240 (void) = 0;
	CVIRTUAL	EndStateBlock,					<STDCALL>, <dword>	;244 (THIS_ IDirect3DStateBlock9** ppSB) = 0;
	CVIRTUAL	SetClipStatus,					<STDCALL>, <dword>	;248 (THIS_ CONST D3DCLIPSTATUS9* pClipStatus) = 0;
	CVIRTUAL	GetClipStatus,					<STDCALL>, <dword>	;252 (THIS_ D3DCLIPSTATUS9* pClipStatus) = 0;
	CVIRTUAL	GetTexture,						<STDCALL>, <dword>	;256 (THIS_ DWORD Stage,IDirect3DBaseTexture9** ppTexture) = 0;
	CVIRTUAL	SetTexture,						<STDCALL>, <dword>	;260 (THIS_ DWORD Stage,IDirect3DBaseTexture9* pTexture) = 0;
	CVIRTUAL	GetTextureStageState,			<STDCALL>, <dword>	;264 (THIS_ DWORD Stage,D3DTEXTURESTAGESTATETYPE Type,DWORD* pValue) = 0;
	CVIRTUAL	SetTextureStageState,			<STDCALL>, <dword>	;268 (THIS_ DWORD Stage,D3DTEXTURESTAGESTATETYPE Type,DWORD Value) = 0;
	CVIRTUAL	GetSamplerState,				<STDCALL>, <dword>	;272 (THIS_ DWORD Sampler,D3DSAMPLERSTATETYPE Type,DWORD* pValue) = 0;
	CVIRTUAL	SetSamplerState,				<STDCALL>, <dword>	;276 (THIS_ DWORD Sampler,D3DSAMPLERSTATETYPE Type,DWORD Value) = 0;
	CVIRTUAL	ValidateDevice,					<STDCALL>, <dword>	;280 (THIS_ DWORD* pNumPasses) = 0;
	CVIRTUAL	SetPaletteEntries,				<STDCALL>, <dword>	;284 (THIS_ UINT PaletteNumber,CONST PALETTEENTRY* pEntries) = 0;
	CVIRTUAL	GetPaletteEntries,				<STDCALL>, <dword>	;288 (THIS_ UINT PaletteNumber,PALETTEENTRY* pEntries) = 0;
	CVIRTUAL	SetCurrentTexturePalette,		<STDCALL>, <dword>	;292 (THIS_ UINT PaletteNumber) = 0;
	CVIRTUAL	GetCurrentTexturePalette,		<STDCALL>, <dword>	;296 (THIS_ UINT *PaletteNumber) = 0;
	CVIRTUAL	SetScissorRect,					<STDCALL>, <dword>	;300 (THIS_ CONST RECT* pRect) = 0;
	CVIRTUAL	GetScissorRect,					<STDCALL>, <dword>	;304 (THIS_ RECT* pRect) = 0;
	CVIRTUAL	SetSoftwareVertexProcessing,	<STDCALL>, <dword>	;308 (THIS_ BOOL bSoftware) = 0;
	CVIRTUAL	GetSoftwareVertexProcessing,	<STDCALL>, <dword>	;312 BOOL	(void) = 0;
	CVIRTUAL	SetNPatchMode,					<STDCALL>, <dword>	;316 (THIS_ float nSegments) = 0;
	CVIRTUAL	GetNPatchMode,					<STDCALL>, <dword>	;320 float	(void) = 0;
	CVIRTUAL	DrawPrimitive,					<STDCALL>, <dword>	;324 (THIS_ D3DPRIMITIVETYPE PrimitiveType,UINT StartVertex,UINT PrimitiveCount) = 0;
	CVIRTUAL	DrawIndexedPrimitive,			<STDCALL>, <dword>	;328 (THIS_ D3DPRIMITIVETYPE,INT BaseVertexIndex,UINT MinVertexIndex,UINT NumVertices,UINT startIndex,UINT primCount) = 0;
	CVIRTUAL	DrawPrimitiveUP,				<STDCALL>, <dword>	;332 (THIS_ D3DPRIMITIVETYPE PrimitiveType,UINT PrimitiveCount,CONST void* pVertexStreamZeroData,UINT VertexStreamZeroStride) = 0;
	CVIRTUAL	DrawIndexedPrimitiveUP,			<STDCALL>, <dword>	;336 (THIS_ D3DPRIMITIVETYPE PrimitiveType,UINT MinVertexIndex,UINT NumVertices,UINT PrimitiveCount,CONST void* pIndexData,D3DFORMAT IndexDataFormat,CONST void* pVertexStreamZeroData,UINT VertexStreamZeroStride) = 0;
	CVIRTUAL	ProcessVertices,				<STDCALL>, <dword>	;340 (THIS_ UINT SrcStartIndex,UINT DestIndex,UINT VertexCount,IDirect3DVertexBuffer9* pDestBuffer,IDirect3DVertexDeclaration9* pVertexDecl,DWORD Flags) = 0;
	CVIRTUAL	CreateVertexDeclaration,		<STDCALL>, <dword>	;344 (THIS_ CONST D3DVERTEXELEMENT9* pVertexElements,IDirect3DVertexDeclaration9** ppDecl) = 0;
	CVIRTUAL	SetVertexDeclaration,			<STDCALL>, <dword>	;348 (THIS_ IDirect3DVertexDeclaration9* pDecl) = 0;
	CVIRTUAL	GetVertexDeclaration,			<STDCALL>, <dword>	;352 (THIS_ IDirect3DVertexDeclaration9** ppDecl) = 0;
	CVIRTUAL	SetFVF,							<STDCALL>, <dword>	;356 (THIS_ DWORD FVF) = 0;
	CVIRTUAL	GetFVF,							<STDCALL>, <dword>	;360 (THIS_ DWORD* pFVF) = 0;
	CVIRTUAL	CreateVertexShader,				<STDCALL>, <dword>	;364 (THIS_ CONST DWORD* pFunction,IDirect3DVertexShader9** ppShader) = 0;
	CVIRTUAL	SetVertexShader,				<STDCALL>, <dword>	;368 (THIS_ IDirect3DVertexShader9* pShader) = 0;
	CVIRTUAL	GetVertexShader,				<STDCALL>, <dword>	;372 (THIS_ IDirect3DVertexShader9** ppShader) = 0;
	CVIRTUAL	SetVertexShaderConstantF,		<STDCALL>, <dword>	;376 (THIS_ UINT StartRegister,CONST float* pConstantData,UINT Vector4fCount) = 0;
	CVIRTUAL	GetVertexShaderConstantF,		<STDCALL>, <dword>	;380 (THIS_ UINT StartRegister,float* pConstantData,UINT Vector4fCount) = 0;
	CVIRTUAL	SetVertexShaderConstantI,		<STDCALL>, <dword>	;384 (THIS_ UINT StartRegister,CONST int* pConstantData,UINT Vector4iCount) = 0;
	CVIRTUAL	GetVertexShaderConstantI,		<STDCALL>, <dword>	;388 (THIS_ UINT StartRegister,int* pConstantData,UINT Vector4iCount) = 0;
	CVIRTUAL	SetVertexShaderConstantB,		<STDCALL>, <dword>	;392 (THIS_ UINT StartRegister,CONST BOOL* pConstantData,UINT	 BoolCount) = 0;
	CVIRTUAL	GetVertexShaderConstantB,		<STDCALL>, <dword>	;396 (THIS_ UINT StartRegister,BOOL* pConstantData,UINT BoolCount) = 0;
	CVIRTUAL	SetStreamSource,				<STDCALL>, <dword>	;400 (THIS_ UINT StreamNumber,IDirect3DVertexBuffer9* pStreamData,UINT OffsetInBytes,UINT Stride) = 0;
	CVIRTUAL	GetStreamSource,				<STDCALL>, <dword>	;404 (THIS_ UINT StreamNumber,IDirect3DVertexBuffer9** ppStreamData,UINT* pOffsetInBytes,UINT* pStride) = 0;
	CVIRTUAL	SetStreamSourceFreq,			<STDCALL>, <dword>	;408 (THIS_ UINT StreamNumber,UINT Setting) = 0;
	CVIRTUAL	GetStreamSourceFreq,			<STDCALL>, <dword>	;412 (THIS_ UINT StreamNumber,UINT* pSetting) = 0;
	CVIRTUAL	SetIndices,						<STDCALL>, <dword>	;416 (THIS_ IDirect3DIndexBuffer9* pIndexData) = 0;
	CVIRTUAL	GetIndices,						<STDCALL>, <dword>	;420 (THIS_ IDirect3DIndexBuffer9** ppIndexData) = 0;
	CVIRTUAL	CreatePixelShader,				<STDCALL>, <dword>	;424 (THIS_ CONST DWORD* pFunction,IDirect3DPixelShader9** ppShader) = 0;
	CVIRTUAL	SetPixelShader,					<STDCALL>, <dword>	;428 (THIS_ IDirect3DPixelShader9* pShader) = 0;
	CVIRTUAL	GetPixelShader,					<STDCALL>, <dword>	;432 (THIS_ IDirect3DPixelShader9** ppShader) = 0;
	CVIRTUAL	SetPixelShaderConstantF,		<STDCALL>, <dword>	;436 (THIS_ UINT StartRegister,CONST float* pConstantData,UINT Vector4fCount) = 0;
	CVIRTUAL	GetPixelShaderConstantF,		<STDCALL>, <dword>	;440 (THIS_ UINT StartRegister,float* pConstantData,UINT Vector4fCount) = 0;
	CVIRTUAL	SetPixelShaderConstantI,		<STDCALL>, <dword>	;444 (THIS_ UINT StartRegister,CONST int* pConstantData,UINT Vector4iCount) = 0;
	CVIRTUAL	GetPixelShaderConstantI,		<STDCALL>, <dword>	;448 (THIS_ UINT StartRegister,int* pConstantData,UINT Vector4iCount) = 0;
	CVIRTUAL	SetPixelShaderConstantB,		<STDCALL>, <dword>	;452 (THIS_ UINT StartRegister,CONST BOOL* pConstantData,UINT	BoolCount) = 0;
	CVIRTUAL	GetPixelShaderConstantB,		<STDCALL>, <dword>	;456 (THIS_ UINT StartRegister,BOOL* pConstantData,UINT BoolCount) = 0;
	CVIRTUAL	DrawRectPatch,					<STDCALL>, <dword>	;460 (THIS_ UINT Handle,CONST float* pNumSegs,CONST D3DRECTPATCH_INFO* pRectPatchInfo) = 0;
	CVIRTUAL	DrawTriPatch,					<STDCALL>, <dword>	;464 (THIS_ UINT Handle,CONST float* pNumSegs,CONST D3DTRIPATCH_INFO* pTriPatchInfo) = 0;
	CVIRTUAL	DeletePatch,					<STDCALL>, <dword>	;468 (THIS_ UINT Handle) = 0;
	CVIRTUAL	CreateQuery,					<STDCALL>, <dword>, _Type:dword, ppQuery:ptr ptr ;IDirect3DQuery9	;472 (THIS_ D3DQUERYTYPE Type,IDirect3DQuery9** ppQuery) = 0;
ENDCOMINTERFACE
;ptrIDirect3DDevice9		typedef ptr IDirect3DDevice9

CHW struct ; (sizeof=168, align=4)
	hD3D9								dword ?						; 0
	pD3D								dword ?						; 4		IDirect3D9*
	pDevice								ptrIDirect3DDevice9 ?		; 8		* <>, <dword>
	pBaseRT								dword ?						; 12	IDirect3DSurface9*
	pBaseZB								dword ?						; 16	IDirect3DSurface9*
	Caps								CHWCaps <>, <dword>					; 20
	DevAdapter							dword ?						; 104	UINT
	DevT								dword ?						; 108	enum _D3DDEVTYPE
	DevPP								_D3DPRESENT_PARAMETERS_ <>, <dword>	; 112
CHW ends															; 168
ptrCHW	typedef ptr CHW

SGameMtl struct ; (sizeof=60, align=4)
	ID							dword ?			; 0
	m_Name						shared_str <>	; 4
	m_Desc						shared_str <>	; 8
	Flags						dword ?			; 12	_flags<unsigned int> ?
	fPHFriction					real4 ?			; 16
	fPHDamping					real4 ?			; 20
	fPHSpring					real4 ?			; 24
	fPHBounceStartVelocity		real4 ?			; 28
	fPHBouncing					real4 ?			; 32
	fFlotationFactor			real4 ?			; 36
	fShootFactor				real4 ?			; 40
	fBounceDamageFactor			real4 ?			; 44
	fInjuriousSpeed				real4 ?			; 48
	fVisTransparencyFactor		real4 ?			; 52
	fSndOcclusionFactor			real4 ?			; 56
SGameMtl ends									; 60

pureRender struct ; (sizeof=4, align=4)
	pureRender@vfptr			dword ?			; offset
pureRender ends

pureFrame struct ; (sizeof=4, align=4)
	pureFrame@vfptr				dword ?			; offset
pureFrame ends

IEventReceiver struct ; (sizeof=4, align=4)
	IEventReceiver@vfptr		dword ?			; offset
IEventReceiver ends

MultipacketReciever struct ; (sizeof=4, align=4)
	MultipacketReciever@vfptr	dword ?			; offset
MultipacketReciever ends

NET_Compressor@@SCompressorStats struct ; (sizeof=0x18, align=4)
	total_uncompressed_bytes	dword ?		; 0
	total_compressed_bytes		dword ?		; 4
	m_packets					xr_map <>	; 8
NET_Compressor@@SCompressorStats ends		; 20

NET_Compressor struct ; (sizeof=0x1C, align=4)
	_CS							xrCriticalSection <>				; 0
	m_stats						NET_Compressor@@SCompressorStats <>	; 4
NET_Compressor ends													; 24

CDB@@COLLIDER struct ; (sizeof=28, align=4)
	ray_mode					dword ?			; 0
	box_mode					dword ?			; 4
	frustum_mode				dword ?			; 8
	rd							xr_vector <>	; 12	xr_vector<CDB::RESULT,xalloc<CDB::RESULT> > ?
CDB@@COLLIDER ends								; 28

CDB@@TRI struct ; (sizeof=16, align=4)
	verts						dword 3 dup(?)	; 0
	union
		struct
			union
			material			word ?			; 12	// 14
			suppress_shadows	word ?			; 12	// 1
			suppress_wm			word ?			; 12	// 1
			ends
			sector				word ?			; 14	// 16
		ends
		dummy					dword ?			; 12
	ends
CDB@@TRI ends									; 16
pCDB@@TRI		typedef ptr CDB@@TRI

xrXRC struct ; (sizeof=28, align=4)
	_CL							CDB@@COLLIDER <>		; 0
xrXRC ends

CDB@@MODEL struct ; (sizeof=28, align=4)
	_cs							xrCriticalSection <>	; 0
	tree						dword ?					; 4		offset
	status						dword ?					; 8
	tris						dword ?					; 12	offset
	tris_count					dword ?					; 16
	verts						pCDB@@TRI ?				; 20	CDB@@TRI*
	verts_count					dword ?					; 24
CDB@@MODEL ends											; 28

CObjectList struct ; (sizeof=120, align=4)
	map_NETID					xr_map <>		; 0 xr_map<unsigned int,CObject*,std::less<unsigned int>,xalloc<std::pair<unsigned int,CObject*>>>?
	destroy_queue				xr_vector <>	; 12	xr_vector<CObject *,xalloc<CObject *> > ?
	objects_active				xr_vector <>	; 28	xr_vector<CObject *,xalloc<CObject *> > ?
	objects_sleeping			xr_vector <>	; 44	xr_vector<CObject *,xalloc<CObject *> > ?
	crows_0						xr_vector <>	; 60	xr_vector<CObject *,xalloc<CObject *> > ?
	crows_1						xr_vector <>	; 76	xr_vector<CObject *,xalloc<CObject *> > ?
	crows						dword ?			; 92	offset
	objects_dup					dword ?			; 96	offset
	objects_dup_memsz			dword ?			; 100
	m_relcase_callbacks			xr_vector <>	; 104	xr_vector<CObjectList::SRelcasePair,xalloc<CObjectList::SRelcasePair> > ?
CObjectList ends								; 120

CObjectSpace struct ; (sizeof=116, align=4)
	Lock_						xrCriticalSection <>	; 0
	Static						CDB@@MODEL <>			; 4
	m_BoundingVolume			Fbox <>					; 32
	xrc							xrXRC <>				; 56
	r_temp						collide@@rq_results <>	; 84
	r_spatial					xr_vector <>			; 100	xr_vector<ISpatial *,xalloc<ISpatial *> > ?
CObjectSpace ends										; 116

IGame_Level struct ; (sizeof=352, align=8)
	DLL_Pure <>									; 0
	IInputReceiver <>							; 16
	pureRender <>								; 20
	pureFrame <>								; 24
	IEventReceiver <>							; 28
	pCurrentEntity				dword ?			; 32	offset
	pCurrentViewEntity			dword ?			; 36	offset
	Sounds_Random				xr_vector <>	; 40	xr_vector<ref_sound,xalloc<ref_sound> > ?
	Sounds_Random_dwNextTime	dword ?			; 56
	Sounds_Random_Enabled		dword ?			; 60
	m_pCameras					dword ?			; 64	offset
	snd_ER						xr_vector <>	; 68	xr_vector<ISpatial *,xalloc<ISpatial *> > ?
	Objects						CObjectList <>	; 84
	ObjectSpace					CObjectSpace <>	; 204
	bReady						dword ?			; 320
	pLevel						dword ?			; 324	offset
	pHUD						dword ?			; 328	offset
	snd_Events					xr_vector <>	; 332	xr_vector<IGame_Level::_esound_delegate,xalloc<IGame_Level::_esound_delegate> > ?
								byte ? ; undefined 348
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
IGame_Level ends								; 352

MultipacketSender@@Buffer struct ; (sizeof=8208, align=4)
	buffer			NET_Packet <>				; 0
	last_flags		dword ?						; 8204
MultipacketSender@@Buffer ends					; 8208

MultipacketSender struct ; (sizeof=16424, align=4)
	MultipacketSender@vfptr		dword ?							; 0		offset
	_buf						MultipacketSender@@Buffer <>	; 4
	_gbuf						MultipacketSender@@Buffer <>	; 8212
	_buf_cs						xrCriticalSection <>			; 16420
MultipacketSender ends											; 16424

BattlEyeSystem struct ; (sizeof=20, align=4)
	m_server_path				shared_str <>			; 0
	m_client_path				shared_str <>			; 4
	m_test_load_client			byte ?					; 8
								byte ? ; undefined
								byte ? ; undefined
								byte ? ; undefined
	client						dword ?					; 12	offset
	server						dword ?					; 16	offset
BattlEyeSystem ends										; 20

INetQueue struct ; (sizeof=40, align=4)
	_cs							xrCriticalSection <>	; 0
	ready						xr_deque <>				; 4		xr_deque<NET_Packet *,xalloc<NET_Packet *> > ?
	unused						xr_vector <>			; 24	xr_vector<NET_Packet *,xalloc<NET_Packet *> > ?
INetQueue ends											; 40

_DPN_CONNECTION_INFO struct ; (sizeof=92, align=4)
	dwSize									dword ?		; 0
	dwRoundTripLatencyMS					dword ?		; 4
	dwThroughputBPS							dword ?		; 8
	dwPeakThroughputBPS						dword ?		; 12
	dwBytesSentGuaranteed					dword ?		; 16
	dwPacketsSentGuaranteed					dword ?		; 20
	dwBytesSentNonGuaranteed				dword ?		; 24
	dwPacketsSentNonGuaranteed				dword ?		; 28
	dwBytesRetried							dword ?		; 32
	dwPacketsRetried						dword ?		; 36
	dwBytesDropped							dword ?		; 40
	dwPacketsDropped						dword ?		; 44
	dwMessagesTransmittedHighPriority		dword ?		; 48
	dwMessagesTimedOutHighPriority			dword ?		; 52
	dwMessagesTransmittedNormalPriority		dword ?		; 56
	dwMessagesTimedOutNormalPriority		dword ?		; 60
	dwMessagesTransmittedLowPriority		dword ?		; 64
	dwMessagesTimedOutLowPriority			dword ?		; 68
	dwBytesReceivedGuaranteed				dword ?		; 72
	dwPacketsReceivedGuaranteed				dword ?		; 76
	dwBytesReceivedNonGuaranteed			dword ?		; 80
	dwPacketsReceivedNonGuaranteed			dword ?		; 84
	dwMessagesReceived						dword ?		; 88
_DPN_CONNECTION_INFO ends								; 92

IClientStatistic struct ; (sizeof=128, align=4)
	ci_last						_DPN_CONNECTION_INFO <>	; 0
	mps_recive					dword ?					; 92
	mps_receive_base			dword ?					; 96
	mps_send					dword ?					; 100
	mps_send_base				dword ?					; 104
	dwBaseTime					dword ?					; 108
	device_timer				dword ?					; 112	offset
	dwTimesBlocked				dword ?					; 116
	dwBytesSended				dword ?					; 120
	dwBytesPerSec				dword ?					; 124
IClientStatistic ends									; 128

IPureClient struct ; (sizeof=16684, align=4)
	MultipacketReciever <>								; 0
	MultipacketSender <>								; 4
	device_timer				dword ?					; 16428	offset
	NET							dword ?					; 16432	offset
	net_Address_device			dword ?					; 16436	offset
	net_Address_server			dword ?					; 16440	offset
	net_csEnumeration			xrCriticalSection <>	; 16444
	net_Hosts					xr_vector <>			; 16448	xr_vector<IPureClient::HOST_NODE,xalloc<IPureClient::HOST_NODE> > ?
	net_Compressor				NET_Compressor <>		; 16464
	net_Connected				dword ?					; 16488	enum IPureClient::ConnectionState
	net_Syncronised				dword ?					; 16492
	net_Disconnected			dword ?					; 16496
	net_Queue					INetQueue <>			; 16500
	net_Statistic				IClientStatistic <>		; 16540
	net_Time_LastUpdate			dword ?					; 16668
	net_TimeDelta				dword ?					; 16672
	net_TimeDelta_Calculated	dword ?					; 16676
	net_TimeDelta_User			dword ?					; 16680
IPureClient ends										; 16684

;;;GlobalFeelTouch struct ; (sizeof=56, align=4)
;;;	Feel@@Touch <>										; 0
;;;GlobalFeelTouch ends

CLevel struct ; (sizeof=18000, align=8)
	IGame_Level <>											; 0
	IPureClient <>											; 352
	m_sDemoName						byte 520 dup(?)			; 17036 
	m_bDemoPlayMode					dword ?					; 17556
	m_bDemoPlayByFrame				dword ?					; 17560
	m_sDemoFileName					xr_string <>			; 17564	std::basic_string<char,std::char_traits<char>,xalloc<char> > ?
	m_lDemoOfs						dword ?					; 17592
	struct m_sDemoHeader	; DemoHeaderStruct ; (sizeof=36, align=4)
		bServerClient				byte ?					; 17596
		Head						byte 31 dup(?)			; 17597
		ServerOptions				shared_str <>			; 17628
	ends
	m_aDemoData						xr_deque <>				; 17632	xr_deque<CLevel::DemoDataStruct,xalloc<CLevel::DemoDataStruct> > ?
	m_bDemoStarted					dword ?					; 17652
	m_dwLastDemoFrame				dword ?					; 17656
	m_bDemoSaveMode					dword ?					; 17660 
	DemoCS							xrCriticalSection <>	; 17664
	m_dwStoredDemoDataSize			dword ?					; 17668
	m_pStoredDemoData				dword ?					; 17672	offset
	m_pOldCrashHandler				dword ?					; 17676	offset
	m_we_used_old_crach_handler		byte ?					; 17680 
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_dwCurDemoFrame				dword ?					; 17684
	m_level_sound_manager			dword ?					; 17688	offset
	m_space_restriction_manager		dword ?					; 17692	offset
	m_seniority_hierarchy_holder	dword ?					; 17696	offset
	m_client_spawn_manager			dword ?					; 17700	offset
	m_autosave_manager				dword ?					; 17704	offset
	m_ph_commander					dword ?					; 17708	offset
	m_ph_commander_scripts			dword ?					; 17712	offset
	m_name							shared_str <>			; 17716
	eChangeRP						dword ?					; 17720	offset
	eDemoPlay						dword ?					; 17724	offset
	eChangeTrack					dword ?					; 17728	offset
	eEnvironment					dword ?					; 17732	offset
	eEntitySpawn					dword ?					; 17736	offset
	pStatGraphS						dword ?					; 17740	offset
	m_dwSPC							dword ?					; 17744
	m_dwSPS							dword ?					; 17748
	pStatGraphR						dword ?					; 17752	offset
	m_dwRPC							dword ?					; 17756
	m_dwRPS							dword ?					; 17760
	m_bNeed_CrPr					dword ?					; 17764
	m_dwNumSteps					dword ?					; 17768
	m_bIn_CrPr						byte ?					; 17772
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	pObjects4CrPr					xr_vector <>			; 17776	xr_vector<CGameObject *,xalloc<CGameObject *> > ?
	pActors4CrPr					xr_vector <>			; 17792 xr_vector<CGameObject *,xalloc<CGameObject *> > ?
	pCurrentControlEntity			dword ?					; 17808	offset
	m_connect_server_err			dword ?					; 17812	enum IPureServer::EConnect
	m_dwDeltaUpdate					dword ?					; 17816 
	m_dwLastNetUpdateTime			dword ?					; 17820 
	m_bConnectResultReceived		byte ?					; 17824 
	m_bConnectResult				byte ?					; 17825 
									byte ? ; undefined
									byte ? ; undefined
	m_sConnectResult				xr_string <>			; 17828	std::basic_string<char,std::char_traits<char>,xalloc<char> > ?
	m_StaticParticles				xr_vector <>			; 17852	xr_vector<CParticlesObject *,xalloc<CParticlesObject *> > ?
	game							dword ?					; 17872	game_cl_GameState*
	m_bGameConfigStarted			dword ?					; 17876 
	game_configured					dword ?					; 17880 
	game_events						dword ?					; 17884	offset
	game_spawn_queue				xr_deque <>				; 17888	xr_deque<CSE_Abstract *,xalloc<CSE_Abstract *> > ?
	Server							dword ?					; 17908	offset
;;;	m_feel_deny						GlobalFeelTouch <>		; ????? Добавлен в 1.0007, в 1.0006 НЕТ такого свойства!!!!!!!!
	battleye_system					BattlEyeSystem <>		; 17912 
	sound_registry					xr_map <>				; 17932	<shared_str,ref_sound,std::less<shared_str>,xalloc<std::pair<shared_str,ref_sound>>>?
	net_start_result_total			dword ?					; 17944 
	connected_to_server				dword ?					; 17948
	static_Sounds					xr_vector <>			; 17952	xr_vector<ref_sound *,xalloc<ref_sound *> > ?
	m_caServerOptions				shared_str <>			; 17968
	m_caClientOptions				shared_str <>			; 17972
	m_map_manager					dword ?					; 17976	offset
	m_pBulletManager				dword ?					; 17980	CBulletManager*
	m_dwCL_PingDeltaSend			dword ?					; 17984 
	m_dwCL_PingLastSendTime			dword ?					; 17988 
	m_dwRealPing					dword ?					; 17992 
									byte ? ; undefined		  17996
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
CLevel ends													; 18000

tagRECT struct ; (sizeof=16, align=4)
	left							dword ?
	top								dword ?
	right							dword ?
	bottom							dword ?
tagRECT ends

CTimerBase struct ; (sizeof=32, align=8)
	qwStartTime						qword ?					; 0
	qwPausedTime					qword ?					; 8
	qwPauseAccum					qword ?					; 16
	bPause							dword ?					; 24
									byte ? ; undefined 28
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
CTimerBase ends

CTimer struct ; (sizeof=56, align=8)
	CTimerBase <>											; 0
	m_time_factor					dword ?					; 32
									byte ? ; undefined 36
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_real_ticks					qword ?					; 40
	m_ticks							qword ?					; 48
CTimer ends													; 56

CTimer_paused_ex struct ; (sizeof=72, align=8)
	vfptr							dword ?					; 0		offset
									byte ? ; undefined 4
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	CTimer <>												; 8
	save_clock						qword ?					; 64
CTimer_paused_ex ends										; 72

CTimer_paused struct ; (sizeof=72, align=8)
	CTimer_paused_ex <>
CTimer_paused ends

CGammaControl struct ; (sizeof=28, align=4)
	fGamma							dword ?					; 0
	fBrightness						dword ?					; 4
	fContrast						dword ?					; 8
	cBalance						Fcolor <>				; 12
CGammaControl ends											; 28

CRegistrator@pureRender@ struct ; (sizeof=20, align=4)
	R								xr_vector <>			; 0		xr_vector<_REG_INFO,xalloc<_REG_INFO> > ?
	_bf10							dword ?					; 16
CRegistrator@pureRender@ ends								; 20

CRegistrator@pureAppActivate@ struct ; (sizeof=20, align=4)
	R								xr_vector <>			; 0		xr_vector<_REG_INFO,xalloc<_REG_INFO> > ?
	_bf10							dword ?					; 16
CRegistrator@pureAppActivate@ ends	

CRegistrator@pureAppDeactivate@ struct ; (sizeof=20, align=4)
	R								xr_vector <>			; 0		xr_vector<_REG_INFO,xalloc<_REG_INFO> > ?
	_bf10							dword ?					; 16
CRegistrator@pureAppDeactivate@ ends	

CRegistrator@pureAppStart@ struct ; (sizeof=20, align=4)
	R								xr_vector <>			; 0		xr_vector<_REG_INFO,xalloc<_REG_INFO> > ?
	_bf10							dword ?					; 16
CRegistrator@pureAppStart@ ends	

CRegistrator@pureAppEnd@ struct ; (sizeof=20, align=4)
	R								xr_vector <>			; 0		xr_vector<_REG_INFO,xalloc<_REG_INFO> > ?
	_bf10							dword ?					; 16
CRegistrator@pureAppEnd@ ends	

CRegistrator@pureFrame@ struct ; (sizeof=20, align=4)
	R								xr_vector <>			; 0		xr_vector<_REG_INFO,xalloc<_REG_INFO> > ?
	_bf10							dword ?					; 16
CRegistrator@pureFrame@ ends	

CRegistrator@pureDeviceReset@ struct ; (sizeof=20, align=4)
	R								xr_vector <>			; 0		xr_vector<_REG_INFO,xalloc<_REG_INFO> > ?
	_bf10							dword ?					; 16
CRegistrator@pureDeviceReset@ ends	

CRenderDevice struct ; (sizeof=848, align=8)
	m_dwWindowStyle					dword ?					; 0
	m_rcWindowBounds				tagRECT <>				; 4
	m_rcWindowClient				tagRECT <>				; 20
	Timer_MM_Delta					dword ?					; 36
	Timer							CTimer_paused <>		; 40
	TimerGlobal						CTimer_paused <>		; 112
	TimerMM							CTimer <>				; 184
	m_hWnd							dword ?					; 240	offset
	dwFrame							dword ?					; 244
	dwPrecacheFrame					dword ?					; 248
	dwPrecacheTotal					dword ?					; 252
	dwWidth							dword ?					; 256
	dwHeight						dword ?					; 260
	fWidth_2						dword ?					; 264
	fHeight_2						dword ?					; 268
	b_is_Ready						dword ?					; 272
	b_is_Active						dword ?					; 276
	m_WireShader					resptr_core <>			; 280	resptr_core<Shader,resptrcode_shader> ?
	m_SelectionShader				resptr_core <>			; 284	resptr_core<Shader,resptrcode_shader> ?
	m_bNearer						dword ?					; 288
	seqRender						CRegistrator@pureRender@ <>			; 292
	seqAppActivate					CRegistrator@pureAppActivate@ <>	; 312
	seqAppDeactivate				CRegistrator@pureAppDeactivate@ <>	; 332
	seqAppStart						CRegistrator@pureAppStart@ <>		; 352
	seqAppEnd						CRegistrator@pureAppEnd@ <>			; 372
	seqFrame						CRegistrator@pureFrame@ <>			; 392
	seqFrameMT						CRegistrator@pureFrame@ <>			; 412
	seqDeviceReset					CRegistrator@pureDeviceReset@ <>	; 432
	seqParallel						xr_vector <>			; 452	xr_vector<fastdelegate::FastDelegate0<void>,xalloc<fastdelegate::FastDelegate0<void>>>?
	Resources						dword ?					; 468	offset
	Statistic						dword ?					; 472	offset
	Gamma							CGammaControl <>		; 476
	fTimeDelta						dword ?					; 504
	fTimeGlobal						dword ?					; 508
	dwTimeDelta						dword ?					; 512
	dwTimeGlobal					dword ?					; 516
	dwTimeContinual					dword ?					; 520
	vCameraPosition					Fvector <>				; 524
	vCameraDirection				Fvector <>				; 536
	vCameraTop						Fvector <>				; 548
	vCameraRight					Fvector <>				; 560
	mView							Fmatrix <>				; 572
	mProject						Fmatrix <>				; 636
	mFullTransform					Fmatrix <>				; 700
	mInvFullTransform				Fmatrix <>				; 764
	fFOV							dword ?					; 828
	fASPECT							dword ?					; 832
	mt_csEnter						xrCriticalSection <>	; 836
	mt_csLeave						xrCriticalSection <>	; 840
	mt_bMustExit					dword ?					; 844
CRenderDevice ends											; 848
;% echo @CatStr(%sizeof (CRenderDevice))
ClientID struct ; (sizeof=4, align=4)
	id								dword ?	
ClientID ends

game_GameState struct ; (sizeof=152, align=8)
	DLL_Pure <>												; 0
	m_type							dword ?					; 16
	m_phase							word ?					; 20
									byte ? ; undefined
									byte ? ; undefined
	m_round							dword ?					; 24
	m_start_time					dword ?					; 28
	m_round_start_time				dword ?					; 32
	m_round_start_time_str			byte 64 dup(?)			; 36
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_qwStartProcessorTime			_QWORD <>;qword ?					; 104
	m_qwStartGameTime				_QWORD <>;qword ?					; 112
	m_fTimeFactor					dword ?					; 120
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_qwEStartProcessorTime			_QWORD <>;qword ?					; 128
	m_qwEStartGameTime				_QWORD <>;qword ?					; 136
	m_fETimeFactor					dword ?					; 144
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
game_GameState ends											; 152

game_cl_GameState struct ; (sizeof=200, align=8)
	game_GameState <>										; 0
	ISheduled <>											; 152
	m_game_type_name				shared_str <>			; 160
	m_game_ui_custom				dword ?					; 164	offset
	m_u16VotingEnabled				word ?					; 168
	m_bServerControlHits			byte ?					; 170
									byte ? ; undefined
	players							xr_map <>				; 172	xr_map<ClientID,game_PlayerState*,std::less<ClientID>,xalloc<std::pair<ClientID,game_PlayerState*>>>?
	local_svdpnid					ClientID <>				; 184
	local_player					dword ?					; 188	offset
	m_WeaponUsageStatistic			dword ?					; 192	offset
									dword ? ; undefined
game_cl_GameState ends										; 200

CAI_Space struct ; (sizeof=40, align=4)
	vfptr							dword ?					; 0		offset
	m_game_graph					dword ?					; 4		offset
	m_cross_table					dword ?					; 8		offset
	m_level_graph					dword ?					; 12	offset
	m_graph_engine					dword ?					; 16	offset
	m_ef_storage					dword ?					; 20	offset
	m_alife_simulator				dword ?					; 24	offset
	m_cover_manager					dword ?					; 28	offset
	m_script_engine					dword ?					; 32	offset
	m_patrol_path_storage			dword ?					; 36	offset
CAI_Space ends												; 40

CDialogHolder struct ; (sizeof=44, align=4)
	ISheduled <>											; 0
	pureFrame <>											; 8
	m_input_receivers				xr_vector <>			; 12	xr_vector<recvItem,xalloc<recvItem> > ?
	m_dialogsToRender				xr_vector <>			; 28	xr_vector<dlgItem,xalloc<dlgItem> > ?
CDialogHolder ends											; 44

CUI struct ; (sizeof=64, align=4)
	CDialogHolder <>										; 0
	pUIGame							dword ?					; 44	CUIGameCustom*
	m_bShowGameIndicators			byte ?					; 48	bool
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_Parent						dword ?					; 52	CHUDManager*
	UIMainIngameWnd					dword ?					; 56	CUIMainIngameWnd*
	m_pMessagesWnd					dword ?					; 60	CUIMessagesWindow*
CUI ends													; 64

CCustomHUD struct ; (sizeof=24, align=8)
	DLL_Pure <>												; 0
	IEventReceiver <>										; 16
									byte ? ; undefined 20
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
CCustomHUD ends												; 24

CHitMarker struct ; (sizeof=24, align=4)
	hShader2						resptr_core <>			; 0		resptr_core<Shader,resptrcode_shader> ?
	m_HitMarks						xr_deque <>				; 4		xr_deque<SHitMark *,xalloc<SHitMark *> > ?
CHitMarker ends												; 24

CHUDManager struct ; (sizeof=64, align=8)
	CCustomHUD <>											; 0
	pUI								dword ?					; 24	XREF: CDangerObject::time(void)/r ; offset
	HitMarker						CHitMarker <>			; 28
	m_pHUDTarget					dword ?					; 52	offset
	b_online						byte ?					; 56
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
									dword ? ; undefined 60
CHUDManager ends											; 64

CHUDCrosshair struct ; (sizeof=36, align=4)
	cross_length_perc				dword ?					; 0
	min_radius_perc					dword ?					; 4
	max_radius_perc					dword ?					; 8
	radius							dword ?					; 12
	target_radius					dword ?					; 16
	radius_speed_perc				dword ?					; 20
	hGeomLine						resptr_core <>			; 24	resptr_core<SGeometry,resptrcode_geom> ?
	hShader							resptr_core <>			; 28	resptr_core<Shader,resptrcode_shader> ?
	cross_color						dword ?					; 32
CHUDCrosshair ends											; 36

CHUDTarget struct ; (sizeof=80, align=4)
	hShader							resptr_core <>			; 0		resptr_core<Shader,resptrcode_shader> ?
	hGeom							resptr_core <>			; 4		resptr_core<SGeometry,resptrcode_geom> ?
	fuzzyShowInfo					dword ?					; 8
	RQ								collide__rq_result <>	; 12
	RQR								collide__rq_results <>	; 24
	m_bShowCrosshair				byte ?					; 40
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	HUDCrosshair					CHUDCrosshair <>		; 44
CHUDTarget ends												; 80

IUIMultiTextureOwner struct ; (sizeof=4, align=4)
	IUIMultiTextureOwner@vfptr		dword ?					; offset
IUIMultiTextureOwner ends

IUISimpleTextureControl struct ; (sizeof=4, align=4)
	IUISimpleTextureControl@vfptr	dword ?					; offset
IUISimpleTextureControl ends

CUIMultiTextureOwner struct ; (sizeof=8, align=4)
	IUIMultiTextureOwner <>
	m_bTextureAvailable				byte ?
	m_bTextureVisible				byte ?
									byte ? ; undefined
									byte ? ; undefined
CUIMultiTextureOwner ends

IUISingleTextureOwner struct ; (sizeof=12, align=4)
	CUIMultiTextureOwner <>
	IUISimpleTextureControl <>
IUISingleTextureOwner ends

CUISingleTextureOwner struct ; (sizeof=16, align=4)
	IUISingleTextureOwner <>
	m_bStretchTexture				byte ?
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
CUISingleTextureOwner ends

IUIFontControl struct ; (sizeof=0x4, align=4)
	IUIFontControl@vfptr			dword ?					; offset
IUIFontControl ends

IUITextControl struct ; (sizeof=0x4, align=4)
	IUIFontControl <>
IUITextControl ends

CUICustomItem struct ; (sizeof=56, align=4)
	CUICustomItem@vfptr				dword ?					; 0		offset
	iVisRect						Frect <>				; 4
	iOriginalRect					Frect <>				; 20
	iHeadingPivot					Fvector2 <>				; 36
	uFlags							dword ?					; 44
	uAlign							dword ?					; 48
	eMirrorMode						dword ?					; 52	enum EUIMirroring
CUICustomItem ends											; 56

CUIStaticItem struct ; (sizeof=96, align=4)
	IUISimpleTextureControl <>								; 0
	CUICustomItem <>										; 4
	hShader							resptr_core <>			; 60	resptr_core<Shader,resptrcode_shader> ?
	iPos							Fvector2 <>				; 64
	dwColor							dword ?					; 72
	iTileX							dword ?					; 76
	iTileY							dword ?					; 80
	iRemX							dword ?					; 84
	iRemY							dword ?					; 88
	alpha_ref						dword ?					; 92
CUIStaticItem ends											; 96

lanim_cont struct ; (sizeof=16, align=4)
	m_lanim							dword ?					; offset
	m_lanim_start_time				dword ?
	m_lanim_delay_time				dword ?
	m_lanimFlags					byte ?					;_flags<unsigned char> ?
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
lanim_cont ends

CUIStatic struct ; (sizeof=344, align=4)
	CUIWindow <>											; 0
	CUISingleTextureOwner <>								; 92
	IUITextControl <>										; 108
	m_lanim_clr						lanim_cont <>			; 112
	m_lanim_xform					lanim_cont <>			; 128
	m_pLines						dword ?					; 144	offset
	m_bEnableTextHighlighting		byte ?					; 148
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_HighlightColor				dword ?					; 152
	m_dwTextColor					dword 4 dup(?)			; 156
	m_bUseTextColor					byte 4 dup(?)			; 172
	m_bClipper						byte ?					; 176
	CUIStatic@m_bStretchTexture		byte ?					; 177
	m_bAvailableTexture				byte ?					; 178
	m_bTextureEnable				byte ?					; 179
	m_UIStaticItem					CUIStaticItem <>		; 180
	m_TextOffset					Fvector2 <>				; 276
	m_bHeading						byte ?					; 284
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_fHeading						real4 ?					; 288
	m_pMask							dword ?					; 292	offset
	m_TextureOffset					Fvector2 <>				; 296
	m_ElipsisPos					dword ?					; 304	enum CUIStatic::EElipsisPosition
	m_iElipsisIndent				dword ?					; 308
	m_ClipRect						Frect <>				; 312
	m_xxxRect						Frect <>				; 328
CUIStatic ends												; 344

CUICellItem struct ; (sizeof=392, align=4)
	CUIStatic <>											; 0
	m_childs						xr_vector <>			; 344	xr_vector<CUICellItem *,xalloc<CUICellItem *> > ?
	m_pParentList					dword ?					; 360	offset
	m_grid_size						Fvector2 <>				; 364	_vector2<int> ?
	m_custom_draw					dword ?					; 372	offset
	m_accelerator					dword ?					; 376
	m_pData							dword ?					; 380	offset
	m_index							dword ?					; 384
	m_b_already_drawn				byte ?					; 388
	m_b_destroy_childs				byte ?					; 389
									byte ? ; undefined
									byte ? ; undefined
CUICellItem ends											; 392

_action struct ; (sizeof=12, align=4)
	action_name						dword ?					; offset
	id								dword ?					; enum EGameActions
	key_group						dword ?					; enum _key_group
_action ends

_keyboard struct ; (sizeof=36, align=4)
	key_name						dword ?					; 0		offset
	dik								dword ?					; 4
	key_local_name					xr_string <>			; 8		std::basic_string<char,std::char_traits<char>,xalloc<char> > ?
_keyboard ends

_binding struct ; (sizeof=12, align=4)
	m_action						dword ?					; _action*
	m_keyboard						dword 2 dup(?)			; _keyboard*
_binding ends

SHeliEnemy struct ; (sizeof=0x24, align=4)
	type_							dword ?					; enum EHeliHuntState
	destEnemyPos					Fvector <>
	destEnemyID						dword ?
	fire_trail_length_curr			dword ?
	fire_trail_length_des			dword ?
	bUseFireTrail					byte ?
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	fStartFireTime					dword ?
SHeliEnemy ends

SHeliBodyState struct ; (sizeof=0x34, align=4)
	parent							dword ?					; offset
	type_							dword ?					; enum EHeliBodyState
	model_pitch_k					dword ?
	model_bank_k					dword ?
	model_angSpeedBank				dword ?
	model_angSpeedPitch				dword ?
	currBodyHPB						Fvector <>
	b_looking_at_point				byte ?
	looking_point					Fvector <>
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
SHeliBodyState ends

SHeliMovementState struct ; (sizeof=0x90, align=4)
	parent							dword ?					; offset
	type_							dword ?					; enum EHeilMovementState
	currPatrolPath					dword ?					; offset
	currPatrolVertex				dword ?					; offset
	patrol_begin_idx				dword ?
	patrol_path_name				shared_str <>
	need_to_del_path				byte ?
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	safe_altitude_add				dword ?
	maxLinearSpeed					dword ?
	LinearAcc_fw					dword ?
	LinearAcc_bk					dword ?
	isAdnAcc						dword ?
	HeadingSpK						dword ?
	HeadingSpB						dword ?
	PitchSpK						dword ?
	PitchSpB						dword ?
	AngSP							dword ?
	AngSH							dword ?
	speedInDestPoint				dword ?
	min_altitude					dword ?
	desiredPoint					Fvector <>
	curLinearSpeed					dword ?
	curLinearAcc					dword ?
	currP							Fvector <>
	currPathH						dword ?
	currPathP						dword ?
	round_center					Fvector <>
	round_radius					dword ?
	round_reverse					byte ?
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	onPointRangeDist				dword ?
SHeliMovementState ends

CHelicopter struct ; (sizeof=2136, align=8)
	CEntity <>												; 0
	CShootingObject <>										; 
	CRocketLauncher <>										; 
	CPHSkeleton <>											; 
	CPHDestroyable <>										; 
	CHitImmunity <>											; 
	CExplosive <>											; 
	m_use_rocket_on_attack			byte ?					; 
	m_use_mgun_on_attack			byte ?					; 
									byte ? ; undefined
									byte ? ; undefined
	m_min_rocket_dist				dword ?					; 
	m_max_rocket_dist				dword ?					; 
	m_min_mgun_dist					dword ?					; 
	m_max_mgun_dist					dword ?					; 
	m_time_between_rocket_attack	dword ?					; 
	m_syncronize_rocket				byte ?					; 
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_barrel_dir_tolerance			dword ?					; 
	m_sndShot						HUD_SOUND <>			; 
	m_sndShotRocket					HUD_SOUND <>			; 
	m_fire_dir						Fvector <>				; 
	m_fire_pos						Fvector <>				; 
	m_left_rocket_bone				word ?					; 
	m_right_rocket_bone				word ?					; 
	m_fire_bone						word ?					; 
	m_rotate_x_bone					word ?					; 
	m_rotate_y_bone					word ?					; 
	m_fire_bone_xform				Fmatrix <>				; 
	m_i_bind_x_xform				Fmatrix <>				; 
	m_i_bind_y_xform				Fmatrix <>				; 
	m_lim_x_rot						Fvector2 <>				; 
	m_lim_y_rot						Fvector2 <>				; 
	m_tgt_rot						Fvector2 <>				; 
	m_cur_rot						Fvector2 <>				; 
	m_bind_rot						Fvector2 <>				; 
	m_bind_x						Fvector <>				; 
	m_bind_y						Fvector <>				; 
	m_allow_fire					byte ?					; 
									byte ? ; undefined
	m_last_launched_rocket			word ?					; 
									byte ? ; undefined
									byte ? ; undefined
	m_last_rocket_attack			dword ?					; 
	m_sAmmoType						shared_str <>			; 
	m_sRocketSection				shared_str <>			; 
	m_CurrentAmmo					CCartridge <>			; 1548
	delta_t							dword ?					; 1604
	flag_by_fire					dword ?					; 1608
	m_left_rocket_bone_xform		Fmatrix <>				; 1612
	m_right_rocket_bone_xform		Fmatrix <>				; 
	m_flame_started					byte ?					; 
	m_light_started					byte ?					; 
	m_ready_explode					byte ?					; 
	m_exploded						byte ?					; 
	m_dead							byte ?					; 
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
	m_enemy							SHeliEnemy <>			; 
	m_body							SHeliBodyState <>		; 
	m_movement						SHeliMovementState <>	; 
	m_death_ang_vel					Fvector <>				; 
	m_death_lin_vel_k				dword ?					; 
	m_death_bones_to_hide			shared_str <>			; 
	m_engineSound					ref_sound <>			; 
	m_brokenSound					ref_sound <>			; 
	m_light_render					resptr_core <>			; resptr_core<IRender_Light,resptrcode_light> ?
	m_lanim							dword ?					; offset
	m_light_bone					word ?					; 
	m_smoke_bone					word ?					; 
	m_light_range					dword ?					; 2020
	m_light_brightness				dword ?					; 2024
	m_light_color					Fcolor <>				; 2028
	m_smoke_particle				shared_str <>			; 2044
	m_pParticle						dword ?					; 2048	offset
	m_particleXFORM					Fmatrix <>				; 2052
	m_curState						dword ?					; 2116	enum CHelicopter::EHeliState
	m_hitBones						xr_map <>				; 2120	xr_map<short,float,std::less<short>,xalloc<std::pair<short,float> > > ?
	m_stepRemains					dword ?					; 2132
CHelicopter ends											; 2136

CWeaponMounted struct ; (sizeof=840, align=8)
	CPhysicsShellHolder <>									; 0
	CHolderCustom <>										; 424
	CShootingObject <>										; 436
	camera							dword ?					; 636	offset
	fire_bone						word ?					; 640
	actor_bone						word ?					; 642
	rotate_x_bone					word ?					; 644
	rotate_y_bone					word ?					; 646
	camera_bone						word ?					; 648
	fire_pos						Fvector <>				; 650
	fire_dir						Fvector <>				; 
	fire_bone_xform					Fmatrix <>				; 
	m_dAngle						Fvector2 <>				; 
									byte ? ; undefined
									byte ? ; undefined
	m_sAmmoType						shared_str <>			; 
	m_CurrentAmmo					CCartridge <>			; 
	sndShot							HUD_SOUND <>			; 
	camRelaxSpeed					dword ?					; 
	camMaxAngle						dword ?					; 
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
									byte ? ; undefined
CWeaponMounted ends											; 
