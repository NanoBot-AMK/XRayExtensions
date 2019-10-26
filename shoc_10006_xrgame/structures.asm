;================================================================================
;		Структуры, структуры классов.
;
; (с) НаноБот
;================================================================================
__LevelExplosive			equ <lalala>

Fvector struct
	x					dword ?
	y					dword ?
	z					dword ?
Fvector ends

Fvector2 struct
	x					dword ?
	y					dword ?
Fvector2 ends

Fvector4 struct
	x					dword ?
	y					dword ?
	z					dword ?
	w					dword ?
Fvector4 ends

Fcolor struct
	r					dword ?
	g					dword ?
	b					dword ?
	a					dword ?
Fcolor ends

Fsphere	 struct ; (sizeof=16, align=4)
	P					Fvector <>		; 0
	R					dword ?			; 12
Fsphere	 ends							; 16

Fmatrix struct
	i					Fvector <>
	_14_				dword ?
	j					Fvector <>
	_24_				dword ?
	k					Fvector <>
	_34_				dword ?
	c_					Fvector <>
	_44_				dword ?
Fmatrix ends

; для регистров xmm 16 байт SSE инструкций
Fmatrix4 struct
	i					Fvector4 <>
	j					Fvector4 <>
	k					Fvector4 <>
	c_					Fvector4 <>
Fmatrix4 ends

Fquaternion struct ; (sizeof=16, align=4)
	x					dword ?					   ; 
	y					dword ?					   ; 
	z					dword ?					   ; 
	w					dword ?					   ; 
Fquaternion ends

collide__rq_result struct
	O				   dword ? ; CObject *O;
	range			   dword ? ;  float range;
	element			   dword ? ;  int element;
collide__rq_result ends

Frect struct ; (sizeof=16, align=4, mappedto_122)
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

SHit struct ; (sizeof=72, align=4)
	Time				dword ?				; 0
	PACKET_TYPE			word ?				; 4
	DestID				word ?				; 6
	power				dword ?				; 8
	dir					Fvector <>			; 12
	who					dword ?				; 24
	whoID				word ?				; 28
	weaponID			word ?				; 30
	boneID				word ?				; 32
	p_in_bone_space		Fvector <>			; 34
	align 4
	impulse				dword ?				; 48
	hit_type			dword ?				; 52
	ap					dword ?				; 56
	aim_bullet			byte ?				; 60
	align 4
	BulletID			dword ?				; 64
	SenderID			dword ?				; 68
SHit ends									; 72

xr_vector struct ; (sizeof=16, align=4)
	_Alval				dword ?				; 0 	allocator object for values			; объект{цель} программы распределения для значений
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

xr_map struct ; (sizeof=12, align=4)
	_Alval				dword ?				; 0
	_Myhead				dword ?				; 4	offset
	_Mysize				dword ?				; 8
xr_map ends									; 12

xr_tree struct ; (sizeof=12, align=4)
	_Alval				dword ?				; 0	_Nodeptr	// allocator object for element values
	_Myhead				dword ?				; 4`size_type	// pointer to head node
	_Mysize				dword ?				; 8	_Alty		// number of elements
xr_tree ends								; 12	_Alnod;	// allocator object for nodes

HUD_SOUND struct			; sizeof 20 bytes 
	m_activeSnd			dword ?				; 0		SSnd*
	sounds				xr_vector <>		; 4		xr_vector<SSnd>
HUD_SOUND ends

SRotation struct ; (sizeof=12, align=4)
	yaw					dword ?				; 0		float
	pitch				dword ?				; 4		float
	roll				dword ?				; 8		float
SRotation ends

shared_str struct ; (sizeof=4, align=4,)
	p_					dword ?				; 4
shared_str ends

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

collide@@rq_results struct
	rq_results					xr_vector <>		; 0		collide::rq_result
collide@@rq_results ends							; 16

string16 struct
								byte 16 dup(?)
string16 ends

CHolderCustom struct	; 12 sizeof
	CHolderCustom@vfptr			dword ?				; 0
	m_owner						dword ?				; 4		CGameObject*
	m_ownerActor				dword ?				; 8		CActor*
CHolderCustom ends									; 12

; объектные переменные класса CShootingObject
CShootingObject struct		; sizeof 200 bytes 
	CShootingObject@vfptr			dword ?		; 0
	m_vCurrentShootDir				Fvector <>	; 4		Fvector	
	m_vCurrentShootPos				Fvector <>	; 16	Fvector	
	m_iCurrentParentID				word  ?		; 28	u16		; ID персонажа который иницировал действие
	bWorking						byte  ?		; 30	bool	; Weapon fires now
	align 4
	fTimeToFire						dword ?		; 32	float	
	fvHitPower						Fvector4 <>	; 36	Fvector4
	fHitImpulse						dword ?		; 52	float	
	m_fStartBulletSpeed				dword ?		; 56	float	; скорость вылета пули из ствола
	fireDistance					dword ?		; 60	float	; максимальное расстояние стрельбы
	fireDispersionBase				dword ?		; 64	float	; рассеивание во время стрельбы
	fTime							dword ?		; 68	float	; счетчик времени, затрачиваемого на выстрел
	; для сталкеров, чтоб они знали эффективные границы использования оружия
	CShootingObject@m_fMinRadius	dword ?		; 72	float	
	CShootingObject@m_fMaxRadius	dword ?		; 76	float	
	; Lights
	light_base_color				Fcolor <>	; 80	Fcolor		
	light_base_range				dword ?		; 96	float		
	light_build_color				Fcolor <>	; 100	Fcolor		
	light_build_range				dword ?		; 116	float		
	light_render					dword ?		; 120	ref_light	
	light_var_color					dword ?		; 124	float		
	light_var_range					dword ?		; 128	float		
	light_lifetime					dword ?		; 132	float		
	light_frame						dword ?		; 136	u32			
	light_time						dword ?		; 140	float		
	m_bLightShotEnabled				byte  ?		; 144	bool				; включение подсветки во время выстрела
	align 4
	m_sShellParticles				dword ?		; 148	shared_str			; имя пратиклов для гильз
	vLoadedShellPoint				Fvector <>	; 152	Fvector					
	m_fPredBulletTime				dword ?		; 164	float					
	m_fTimeToAim					dword ?		; 168	float					
	m_bUseAimBullet					dword ?		; 172	BOOL					
	m_sFlameParticlesCurrent		dword ?		; 176	shared_str			; имя пратиклов для огня
	m_sFlameParticles				dword ?		; 180	shared_str			; для выстрела 1м и 2м видом стрельбы
	m_pFlameParticles				dword ?		; 184	CParticlesObject*	; объект партиклов огня
	m_sSmokeParticlesCurrent		dword ?		; 188	shared_str			; имя пратиклов для дыма
	m_sSmokeParticles				dword ?		; 192	shared_str			
	m_sShotParticles				dword ?		; 196	shared_str			; имя партиклов следа от пули
CShootingObject ends

; class CCarWeapon :public CShootingObject
CCarWeapon struct		; sizeof 564 bytes 
	CShootingObject <>
	m_object					dword ?		; 200	CPhysicsShellHolder*
	m_bActive					byte  ?		; 204	bool
	m_bAutoFire					byte  ?		; 205	bool
	m_bShowCrosshair			byte  ?		; 206	bool	//NEW
	align 4
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
	align 4
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
	idles_num					word  ?		;u16				
	idles						word  MAX_IDLES dup (?)		;MotionID		
	steer_left					word  ?		;MotionID		
	steer_right					word  ?		;MotionID		
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
	file					dword ?			; 0		shared_str
	rect					Frect <>		; 4		Frect
TEX_INFO ends								; 20

cfTracer					= byte ptr (1 shl 0)
cfRicochet					= byte ptr (1 shl 1)
cfCanBeUnlimited			= byte ptr (1 shl 2)
cfExplosive					= byte ptr (1 shl 3)
cfCallbackOn				= byte ptr (1 shl 4)
cfShellExplosive			= byte ptr (1 shl 5)

CCartridge struct	; 56 bytes	// патрон
	m_ammoSect				dword ?			; 0		shared_str
	m_kDist					dword ?			; 4		float
	m_kDisp					dword ?			; 8		float
	m_kHit					dword ?			; 12	float
	m_kImpulse				dword ?			; 16	float
	m_kPierce				dword ?			; 20	float
	m_kAP					dword ?			; 24	float
	m_kAirRes				dword ?			; 28	float
	m_buckShot				dword ?			; 32	int
	m_impair				dword ?			; 36	float
	fWallmarkSize			dword ?			; 40	float
	m_u8ColorID				byte ?			; 44	u8
	m_LocalAmmoType			byte ?			; 45	u8
	bullet_material_idx		word ?			; 46	u16
	m_flags					byte ?			; 48	Flags8
	align	4
	m_InvShortName			dword ?			; 52	shared_str
CCartridge ends	;	// size class CCartridge 56 bytes (038h)

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
	speed					dword ?			; 32	float		//текущая скорость
	parent_id				word ?			; 36	u16			//ID персонажа который иницировал действие
	weapon_id				word ?			; 38	u16			//ID оружия из которого была выпущены пуля
	fly_dist				dword ?			; 40	float		//дистанция которую пуля пролетела
	; //коэфициенты и параметры патрона
	hit_power				dword ?			; 44	float		// power*cartridge
	hit_impulse				dword ?			; 48	float		// impulse*cartridge
	; //-------------------------------------------------------------------
	ap						dword ?			; 52	float
	air_resistance			dword ?			; 56	float
	; //-------------------------------------------------------------------
	max_speed				dword ?			; 60	float		// maxspeed*cartridge
	max_dist				dword ?			; 64	float		// maxdist*cartridge
	pierce					dword ?			; 68	float
	wallmark_size			dword ?			; 72	float
	; //-------------------------------------------------------------------
	m_u8ColorID				byte ?			; 76	u8
	align	4
	; //тип наносимого хита
	hit_type				dword ?			; 80	ALife::EHitType
	; //---------------------------------
	m_dwID					dword ?			; 84	u32
	m_whine_snd				dword ?			; 88	ref_sound
	m_mtl_snd				dword ?			; 92	ref_sound
	; //---------------------------------
	targetID				word ?			; 96	u16
;-------------------------NEW--------------------------
;	align	4
	explosive_id			word ?			; 98	u16		// ID объекта CBulletExplosive
SBullet ends	;	// size	 bytes (100)

_hit struct ; (sizeof=8, mappedto_109)
	first					dword ?						; 
	second					dword ?						; 
_hit ends

_event struct ; (sizeof=160, mappedto_107)
	Type_					byte ?						; 0
	align	4
	dynamic					dword ?						; 4
	Repeated				dword ?						; 8
	result					_hit <>						; 12
	bullet					SBullet <>					; 20
	normal					Fvector <>					; 120
	point					Fvector <>					; 132
	R						collide__rq_result <>		; 144
	tgt_material			word ?						; 156
	align	4
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
	m_aColors					xr_vector <>			; 8		xr_vector<unsigned int,xalloc<unsigned int> >
CTracer ends											; 24

CBulletManager struct ; (sizeof=200, align=4)
	CBulletManager@vfptr						dword ?					; 0	offset
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
	m_fHPMaxDist				dword ?					; 168
	m_fGravityConst				dword ?					; 172
	m_fAirResistanceK			dword ?					; 176
	m_fCollisionEnergyMin		dword ?					; 180
	m_fCollisionEnergyMax		dword ?					; 184
	m_fTracerWidth				dword ?					; 188
	m_fTracerLengthMax			dword ?					; 192
	m_fTracerLengthMin			dword ?					; 196
;------------------------NEW------------------------
	m_explosions				xr_vector2 <>			; 200	xr_vector<CExplosive,xalloc<CExplosive> > ?
	m_explo_ids					dword ?					; 220	указатель на таблицу с айдишниками.
	m_free_id					dword ?					; 224	крайний свободный айдишник
	m_dwTotalShots				dword ?					; 228	суммарное количество пуль, используется для m_dwID пуль.
CBulletManager ends										; 200 232

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
			m_game_object		dword ?					; 48	CGameObject*	New	смещение = m_wallmark_manager.m_owner
		ends
	ends
	m_iCurrentParentID			word ?					; 52	u16
	m_vExplodePos				Fvector <>				; 54
	m_vExplodeSize				Fvector <>				; 66
	m_vExplodeDir				Fvector <>				; 78
								byte ?					; 90	
								byte ?					; 91
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
	m_game_object_id			word ?					; 162	u16		New	ID собственого объекта или оружия из которого выпустили снаряд
	m_bHideInExplosion			dword ?					; 164
	m_bAlreadyHidden			byte ?					; 168
								byte ?					; 169
								byte ?					; 170
								byte ?					; 171
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
	align	8
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
			visual				dword ?					; 68 offset
			pROS				dword ?					; 72 offset
			pROS_Allowed		dword ?					; 76
		ends
		struct
			XFORM_				Fmatrix4 <>				; 4
			Visual_				dword ?					; 68 offset
		ends
	ends
IRenderable	 ends										; 80

ICollidable	 struct ; (sizeof=8, align=4)
	ICollidable@vfptr			dword ?					;  offset
	union
		struct collidable
			model				dword ?					; 4 offset
		ends
		CFORM					dword ?					; 4 offset
	ends
ICollidable	 ends	; 8

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
	NameObject					dword ?					; 168	shared_str
	NameSection					dword ?					; 172	shared_str
	NameVisual					dword ?					; 176	shared_str
	Parent						dword ?					; 180	offset
	struct PositionStack
		array			CObject__SavedPosition 4 dup (<>); 184
		count					dword ?					; 248
	ends
	dwFrame_UpdateCL			dword ?					; 252
	dwFrame_AsCrow				dword ?					; 256
CObject ends											; 260	

CUsableScriptObject struct 4 ; (sizeof=12, align=4)
	CUsableScriptObject@vfptr	dword ?					; 0		offset
	m_sTipText					dword ?					; 4		shared_str
	m_bNonscriptUsable			byte ?					; 8	
	align	4
CUsableScriptObject ends								; 12

CScriptBinder struct ; (sizeof=8, align=4)
	CScriptBinder@vfptr			dword ?					; 0		offset
	CScriptBinder@m_object		dword ?					; 4		CScriptBinderObject*
CScriptBinder ends										; 8

svector_void___stdcall_CKinematics_6 struct
	array						dword 6 dup(?)			; 316 offset
	count						dword ?					; 240
svector_void___stdcall_CKinematics_6 ends

CGameObject struct ; (sizeof=360, align=4)
	CObject <>											; 0
	CUsableScriptObject <>								; 260
	CScriptBinder <>									; 272
	m_spawned					byte ?					; 280
	m_server_flags				dword ?					; 284	Flags32
	align	4
	m_ai_location				dword ?					; 288 offset
	m_story_id					dword ?					; 292
	m_anim_mov_ctrl				dword ?					; 296 offset
	m_bObjectRemoved			byte ?					; 300
	align	4
	m_ini_file					dword ?					; 304 offset
	m_bCrPr_Activated			byte ?					; 308
	m_flCallbackKey				byte ?					; 309	flags8	NEW!!!	флаги на включения колбеков
	align	4
	m_dwCrPr_ActivationStep		dword ?					; 312
	m_visual_callback	svector_void___stdcall_CKinematics_6 <>
	m_lua_game_object			dword ?					; 344 offset
	m_script_clsid				dword ?					; 348
	m_spawn_time				dword ?					; 352
	m_callbacks					dword ?					; 356 offset
CGameObject ends										; 360 

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

CParticlesPlayer struct 8 ; (sizeof=56, align=8)
	CParticlesPlayer@vfptr		dword ?					; 0 offset
	align 8
	bone_mask					qword ?					; 8
	m_Bones						xr_vector <>			; 16
	m_self_object				dword ?					; 32 offset
	m_bActiveBones				byte ?					; 36
	parent_vel					Fvector <>				; 37
	align 8
CParticlesPlayer ends									; 56

CPhysicsShellHolder struct 8 ; (sizeof=424, align=8)
	CGameObject <>										; 0
	CParticlesPlayer <>									; 360
	b_sheduled					byte ?					; 416
	align 4
	m_pPhysicsShell				dword ?					; 420	offset
CPhysicsShellHolder ends								; 424

CDamageManager	struct ; (sizeof=16, align=4)
	CDamageManager@vfptr		dword ?					; 0 offset
	m_default_hit_factor		dword ?					; 4
	m_default_wound_factor		dword ?					; 8
	CDamageManager@m_object		dword ?					; 12	CObject*
CDamageManager	ends									; 16

CAttachmentOwner struct ; (sizeof=36, align=4)
	CAttachmentOwner@vfptr		dword ?					; 0		offset
	m_attach_item_sections		xr_vector <>			; 4		xr_vector<shared_str,xalloc<shared_str> > ?
	m_attached_objects			xr_vector <>			; 20	xr_vector<CAttachableItem *,xalloc<CAttachableItem *> > ?
CAttachmentOwner ends									; 36

CInventoryOwner struct ; (sizeof=120, align=4)
	CAttachmentOwner <>									; 0
	m_inventory					dword ?					; 36	offset
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

CEntity struct 8 ; (sizeof=496, align=8) 
	CPhysicsShellHolder <>								; 0
	CDamageManager <>									; 424
	CEntity@m_entity_condition		dword ?				; 440 CEntityConditionSimple
	align 8
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
	align 8
CEntity ends											; 496

CEntityAlive struct 8 ; (sizeof=568, align=8)
	CEntity <>											; 0
	m_bMobility						byte ?				; 496
	align 4
	m_fAccuracy						dword ?				; 500
	m_fIntelligence					dword ?				; 504
	m_ParticleWounds				xr_vector <>		; 508	xr_vector<CWound *,xalloc<CWound *> >
	m_BloodWounds					xr_vector <>		; 524	xr_vector<CWound *,xalloc<CWound *> >
	monster_community				dword ?				; 540	offset
	CEntityAlive@m_entity_condition	dword ?				; 544	CEntityCondition
	m_material_manager				dword ?				; 548	offset
	m_ef_creature_type				dword ?				; 552
	m_ef_weapon_type				dword ?				; 556
	m_ef_detector_type				dword ?				; 560
CEntityAlive ends										; 568

CScriptEntity	struct 4 ; (sizeof=76, align=4)
	CScriptEntity@vfptr			dword ?					; 0		offset
	CScriptEntity@m_object		dword ?					; 4		CGameObject*
	m_monster					dword ?					; 8		offset
	m_initialized				byte ?					; 12
	m_can_capture				byte ?					; 13
	align 4
	m_tpActionQueue				xr_deque <>				; 16	xr_deque<CScriptEntityAction *,xalloc<CScriptEntityAction *> >
	m_bScriptControl			byte ?					; 36
	align 4
	m_caScriptName				dword ?					; 40	shared_str
	m_tpNextAnimation			word ?					; 44	MotionID
	m_use_animation_movement_controller byte ?			; 46
	align 4
	m_tpCurrentEntityAction		dword ?					; 48	offset
	m_tpScriptAnimation			word ?					; 52	MotionID
	align 4
	m_current_sound				dword ?					; 56	offset
	m_saved_sounds				xr_vector <>			; 60	xr_vector<CScriptEntity::CSavedSound,xalloc<CScriptEntity::CSavedSound> >
CScriptEntity	ends									; 76

CPHUpdateObject struct 4 ; (sizeof=16, align=4)
	CPHUpdateObject@vfptr		dword ?					; 0
	next						dword ?					; 4	offset
	tome						dword ?					; 8	offset
	b_activated					byte ?					; 12
CPHUpdateObject ends									; 16

CPHDestroyableNotificate struct ; (sizeof=4, align=4)
	CPHDestroyableNotificate@vfptr	dword ?				; 0 offset
CPHDestroyableNotificate ends							; 4

CPHSkeleton	struct 4 ; (sizeof=36, align=4)
	CPHDestroyableNotificate <>							; 0
	b_removing					byte ?					; 4
	align 4
	m_remove_time				dword ?					; 8
	m_unsplited_shels			xr_vector <>			; 12	xr_vector<std::pair<CPhysicsShell *,unsigned short>,xalloc<std::pair<CPhysicsShell *,unsigned short> > >
	m_startup_anim				dword ?					; 28	shared_str
	m_flags						byte ?					; 32	_flags<unsigned char>
CPHSkeleton	ends										; 36

CDamagableItem	struct 4 ; (sizeof=16, align=4)
	CDamagableItem@vfptr			dword ?					; 0 offset
	m_levels_num				word ?					; 4
	align 4
	m_max_health				dword ?					; 8
	m_level_applied				word ?					; 12
CDamagableItem	ends									; 16

CPHDestroyableNotificator struct ; (sizeof=4, align=4)
	CPHDestroyableNotificator@vfptr	dword ?				; 0 offset
CPHDestroyableNotificator ends							; 4

CPHDestroyable	struct ; (sizeof=112, align=4)
	CPHDestroyableNotificator <>						; 0
	m_destroyed_obj_visual_names xr_vector <>			; 4		xr_vector<shared_str,xalloc<shared_str> > 
	m_notificate_objects		xr_vector <>			; 20	xr_vector<CPHDestroyableNotificate *,xalloc<CPHDestroyableNotificate *> >
	m_depended_objects			word ?					; 36
	m_flags1					byte ?					; 38	_flags<unsigned char>
	align 4
	m_fatal_hit					SHit <>					; 40
CPHDestroyable	ends									; 112

CPHCollisionDamageReceiver struct ; (sizeof=20, align=4)
	CPHCollisionDamageReceiver@vfptr	dword ?				; 0 offset
	m_controled_bones			xr_vector<>				; 4		xr_vector<std::pair<unsigned short,float>,xalloc<std::pair<unsigned short,float> > > ?
CPHCollisionDamageReceiver ends							; 20

svector@float_11@ struct ; (sizeof=48, align=4)
	array						dword 11 dup(?)			; 0
	count						dword ?					; 44
svector@float_11@ ends							; 48

CHitImmunity struct ; (sizeof=52, align=4)
	CHitImmunity@vfptr			dword ?					; 0 offset
	m_HitTypeK					svector@float_11@ <>	; 4		HitImmunity::HitTypeSVec
CHitImmunity ends										; 52

CDelayedActionFuse struct ; (sizeof=16, align=4)
	CDelayedActionFuse@vfptr		dword ?					; 0 offset
	m_dafflags					byte ?					; 4		_flags<unsigned char>
	align 4
	m_fTime						dword ?					; 8
	m_fSpeedChangeCondition		dword ?					; 12
CDelayedActionFuse ends									; 16

CCarDamageParticles struct ; (sizeof=48, align=4)
	bones1						xr_vector <>			; 0		xr_vector<unsigned short,xalloc<unsigned short> >
	bones2						xr_vector <>			; 16	xr_vector<unsigned short,xalloc<unsigned short> >
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
	async_calls					word ?					; 1100	Flag16_flags<unsigned short>
	align 4
	m_damage_particles			CCarDamageParticles <>	; 1104
	rsp							byte ?					; 1152
	lsp							byte ?					; 1153
	fwp							byte ?					; 1154
	bkp							byte ?					; 1155
	brp							byte ?					; 1156
	m_root_transform			Fmatrix <>				; 1157
	m_exit_position				Fvector <>				; 1221
	align 4
	e_state_drive				dword ?					; 1236	enum CCar::eStateDrive
	e_state_steer				dword ?					; 1240	enum CCar::eStateSteer
	b_wheels_limited			byte ?					; 1248
	b_engine_on					byte ?					; 1249
	b_clutch					byte ?					; 1250
	b_starting					byte ?					; 1251
	b_stalling					byte ?					; 1252
	b_breaks					byte ?					; 1253
	b_transmission_switching	byte ?					; 1254
	align 4
	m_dwStartTime				dword ?					; 1252
	m_fuel						dword ?					; 1256
	m_fuel_tank					dword ?					; 1260
	m_fuel_consumption			dword ?					; 1264
	m_driver_anim_type			word ?					; 1268
	align 4
	m_break_start				dword ?					; 1272
	m_break_time				dword ?					; 1276
	m_breaks_to_back_rate		dword ?					; 1280
	m_power_neutral_factor		dword ?					; 1284
	b_exploded					byte ?					; 1288
	align 4
	m_car_sound					dword ?					; 1292	offset
	m_car_weapon				dword ?					; 1296	offset
	m_steer_angle				dword ?					; 1300
	m_repairing					byte ?					; 1304
	align 2
	m_bone_steer				word ?					; 1306
	camera						dword 3 dup(?)			; 1308	[3]CCameraBase*
	active_camera				dword ?					; 1320	CCameraBase*
	m_camera_position			Fvector <>				; 1324
	m_wheels_map				xr_map <>				; 1336	xr_map<unsigned short,CCar::SWheel,std::less<unsigned short>,xalloc<std::pair<unsigned short,CCar::SWheel> > >
	m_driving_wheels			xr_vector <>			; 1348	xr_vector<CCar::SWheelDrive,xalloc<CCar::SWheelDrive> > 
	m_steering_wheels			xr_vector <>			; 1364	xr_vector<CCar::SWheelSteer,xalloc<CCar::SWheelSteer> >
	m_breaking_wheels			xr_vector <>			; 1380	xr_vector<CCar::SWheelBreak,xalloc<CCar::SWheelBreak> >
	m_exhausts					xr_vector <>			; 1396	xr_vector<CCar::SExhaust,xalloc<CCar::SExhaust> >
	m_exhaust_particles			dword ?					; 1412	shared_str
	m_doors						xr_map <>				; 1416	xr_map<unsigned short,CCar::SDoor,std::less<unsigned short>,xalloc<std::pair<unsigned short,CCar::SDoor> > >
	m_doors_update				xr_vector <>			; 1428	xr_vector<CCar::SDoor *,xalloc<CCar::SDoor *> >
	m_gear_ratious				xr_vector <>			; 1444	xr_vector<_vector3<float>,xalloc<_vector3<float> > >
	m_sits_transforms			xr_vector <>			; 1460	xr_vector<_matrix<float>,xalloc<_matrix<float> > >
	m_current_gear_ratio		dword ?					; 1476
	b_auto_switch_transmission	byte ?					; 1480
	align 4
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
	align 4
	m_height_pos				dword ?					; 1614	float		// высота от нижней части до position, метры
	align 8
CCar ends												; 1616	new sizeof

MotionID struct; (sizeof=2, align=2)
	union
		;struct
		idx						word ?					; 0		:14
		slot					word ?					; 0		:2
		;ends
		val						word ?					; 0	u16
	ends
MotionID ends

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
	m_bones_body_parts						associative_vector <>	; 1084	associative_vector<unsigned short,unsigned int,std::less<unsigned short> > ?
	m_invulnerable							byte ?					; 1104
	m_update_rotation_on_frame				byte ?					; 1105
	m_movement_enabled_before_animation_controller byte ?			; 1106
											byte ? ; undefined
											dword ?					; 1108	undefined
CCustomMonster	ends												; 1112

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
	r_torso_tgt_roll						dword ?					; 000004FC
	unaffected_r_torso						SRotation <>			; 00000500
	r_model_yaw_dest						dword ?					; 0000050C
	r_model_yaw								dword ?					; 00000510
	r_model_yaw_delta						dword ?					; 00000514
	m_anims									dword ?					; 00000518	offset
	m_vehicle_anims							dword ?					; 0000051C	offset
	m_current_legs_blend					dword ?					; 00000520	offset
	m_current_torso_blend					dword ?					; 00000524	offset
	m_current_jump_blend					dword ?					; 00000528	offset
	m_current_legs							MotionID <>				; 0000052C
	m_current_torso							MotionID <>				; 0000052E
	m_current_head							MotionID <>				; 00000530
											byte ? ; undefined
											byte ? ; undefined
	cameras									dword 3 dup(?)			; 00000534	offset
	cam_active								dword ?					; 00000540	ACTOR_DEFS::EActorCameras
	fPrevCamPos								dword ?					; 00000544
	vPrevCamDir								Fvector <>				; 00000548
	fCurAVelocity							dword ?					; 00000554
	pCamBobbing								dword ?					; 00000558	offset
	m_pSleepEffector						dword ?					; 0000055C	offset
	m_pSleepEffectorPP						dword ?					; 00000560	offset
	m_pActorEffector						dword ?					; 00000564	offset
	m_pUsableObject							dword ?					; 00000568	offset
	m_pPersonWeLookingAt					dword ?					; 0000056C	offset
	m_pVehicleWeLookingAt					dword ?					; 00000570	offset
	m_pObjectWeLookingAt					dword ?					; 00000574	offset
	m_pInvBoxWeLookingAt					dword ?					; 00000578	offset
	m_sDefaultObjAction						shared_str <>			; 0000057C
	m_sCharacterUseAction					shared_str <>			; 00000580
	m_sDeadCharacterUseAction				shared_str <>			; 00000584
	m_sDeadCharacterUseOrDragAction			shared_str <>			; 00000588
	m_sCarCharacterUseAction				shared_str <>			; 0000058C
	m_sInventoryItemUseAction				shared_str <>			; 00000590
	m_sInventoryBoxUseAction				shared_str <>			; 00000594
	m_bPickupMode							byte ?					; 00000598
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_fPickupInfoRadius						dword ?					; 0000059C
	mstate_wishful							dword ?					; 000005A0
	mstate_old								dword ?					; 000005A4
	mstate_real								dword ?					; 000005A8
	m_bJumpKeyPressed						dword ?					; 000005AC
	m_fWalkAccel							dword ?					; 000005B0
	m_fJumpSpeed							dword ?					; 000005B4
	m_fRunFactor							dword ?					; 000005B8
	m_fRunBackFactor						dword ?					; 000005BC
	m_fWalkBackFactor						dword ?					; 000005C0
	m_fCrouchFactor							dword ?					; 000005C4
	m_fClimbFactor							dword ?					; 000005C8
	m_fSprintFactor							dword ?					; 000005CC
	m_fWalk_StrafeFactor					dword ?					; 000005D0
	m_fRun_StrafeFactor						dword ?					; 000005D4
	m_bZoomAimingMode						byte ?					; 000005D8
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_fDispBase								dword ?					; 000005DC
	m_fDispAim								dword ?					; 000005E0
	m_fDispVelFactor						dword ?					; 000005E4
	m_fDispAccelFactor						dword ?					; 000005E8
	m_fDispCrouchFactor						dword ?					; 000005EC
	m_fDispCrouchNoAccelFactor				dword ?					; 000005F0
	m_vMissileOffset						Fvector <>				; 000005F4
	m_r_hand								dword ?					; 00000600
	m_l_finger1								dword ?					; 00000604
	m_r_finger2								dword ?					; 00000608
	m_head									dword ?					; 0000060C
	m_l_clavicle							dword ?					; 00000610
	m_r_clavicle							dword ?					; 00000614
	m_spine2								dword ?					; 00000618
	m_spine1								dword ?					; 0000061C
	m_spine									dword ?					; 00000620
	m_neck									dword ?					; 00000624
	NET										xr_deque <>				; 00000628	xr_deque<ACTOR_DEFS::net_update,xalloc<ACTOR_DEFS::net_update> > ?
	NET_SavedAccel							Fvector <>				; 00000640
	NET_Last								ACTOR_DEFS@@net_update <>; 0000064C
	NET_WasInterpolating					dword ?					; 00000690
	NET_Time								dword ?					; 00000694
	NET_A									xr_deque <>				; 00000698	xr_deque<ACTOR_DEFS::net_update_A,xalloc<ACTOR_DEFS::net_update_A> > ?
	SCoeff									dword 12 dup(?)			; 000006B0
	HCoeff									dword 12 dup(?)			; 000006E0
	IPosS									Fvector <>				; 00000710
	IPosH									Fvector <>				; 0000071C
	IPosL									Fvector <>				; 00000728
	LastState								SPHNetState <>			; 00000734
	RecalculatedState						SPHNetState <>			; 000007A0
	PredictedState							SPHNetState <>			; 0000080C
	IStart									ACTOR_DEFS@@InterpData <>; 00000878
	IRec									ACTOR_DEFS@@InterpData <>; 000008A0
	IEnd									ACTOR_DEFS@@InterpData <>; 000008C8
	m_bInInterpolation						byte ?					; 000008F0
	m_bInterpolate							byte ?					; 000008F1
											byte ? ; undefined
											byte ? ; undefined
	m_dwIStartTime							dword ?					; 000008F4
	m_dwIEndTime							dword ?					; 000008F8
	m_dwILastUpdateTime						dword ?					; 000008FC
	m_States								xr_deque <>				; 00000900	xr_deque<SPHNetState,xalloc<SPHNetState> > ?
	m_u16NumBones							word ?					; 00000918
											byte ? ; undefined
											byte ? ; undefined
	hFriendlyIndicator						dword ?					; 0000091	Cresptr_core<SGeometry,resptrcode_geom> ?
	m_input_external_handler				dword ?					; 0000920	offset
	m_time_lock_accel						dword ?					; 00000924
	pStatGraph								dword ?					; 00000928	offset
	m_DefaultVisualOutfit					shared_str <>			; 0000092C
	invincibility_fire_shield_3rd			dword ?					; 00000930	offset
	invincibility_fire_shield_1st			dword ?					; 00000934	offset
	m_sHeadShotParticle						shared_str <>			; 00000938
	last_hit_frame							dword ?					; 0000093C
	m_AutoPickUp_AABB						Fvector <>				; 00000940
	m_AutoPickUp_AABB_Offset				Fvector <>				; 0000094C
	CActor@m_entity_condition				dword ?					; 00000958	CActorCondition*
	m_iLastHitterID							word ?					; 0000095C
	m_iLastHittingWeaponID					word ?					; 0000095E
	m_s16LastHittedElement					word ?					; 00000960
	m_vLastHitDir							Fvector <>				; 00000962
	m_vLastHitPos							Fvector <>				; 0000096E
											byte ? ; undefined
											byte ? ; undefined
	m_fLastHealth							dword ?					; 0000097C
	m_bWasHitted							byte ?					; 00000980
	m_bWasBackStabbed						byte ?					; 00000981
											byte ? ; undefined
											byte ? ; undefined
	m_memory								dword ?					; 00000984	offset
	RQR										collide@@rq_results <>	; 00000988	
	ISpatialResult							xr_vector <>			; 00000998xr_vector<ISpatial *,xalloc<ISpatial *> > ?
	m_location_manager						dword ?					; 000009A8	offset
	m_holder_id								word ?					; 000009AC
											byte ? ; undefined
											byte ? ; undefined
											dword ? ; undefined
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

CAI_Stalker struct ; (sizeof=1816, align=8)
;------------------------------Classes-----------------------------------
	CCustomMonster <>												; 0
	CObjectHandler <>												; 1112
	CAI_PhraseDialogManager <>										; 1264
	CStepManager <>													; 1340
;-----------------------------Properties---------------------------------
	m_animation_manager						dword ?					; 1436	offset
	m_brain									dword ?					; 1440	offset
	m_sight_manager							dword ?					; 1444	offset
	CAI_Stalker@m_movement_manager			dword ?					; 1448	offset
	m_boneHitProtection						dword ?					; 1452	offset
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
	m_best_item_to_kill						dword ?					; 1508	offset
	m_best_item_value						dword ?					; 1512
	m_best_ammo								dword ?					; 1516	offset
	m_best_found_item_to_kill				dword ?					; 1520	offset
	m_best_found_ammo						dword ?					; 1524	offset
	m_ce_close								dword ?					; 1528	offset
	m_ce_far								dword ?					; 1532	offset
	m_ce_best								dword ?					; 1536	offset
	m_ce_angle								dword ?					; 1540	offset
	m_ce_safe								dword ?					; 1544	offset
	m_ce_random_game						dword ?					; 1548	offset
	m_ce_ambush								dword ?					; 1552	offset
	m_ce_best_by_time						dword ?					; 1556	offset
	m_pPhysics_support						dword ?					; 1560	offset
	m_wounded								byte ?					; 1564
	m_can_kill_member						byte ?					; 1565
	m_can_kill_enemy						byte ?					; 1566
											byte ? ; undefined
	m_pick_distance							dword ?					; 1568
	m_pick_frame_id							dword ?					; 1572
	rq_storage								collide@@rq_results <>	; 1576
	m_actor_relation_flags					dword ?					; 1592	flags32
	m_trader_game_object					dword ?					; 1596	offset
	m_current_trader						dword ?					; 1600	offset
	m_temp_items							xr_vector <>			; 1604	xr_vector<CAI_Stalker::CTradeItem,xalloc<CAI_Stalker::CTradeItem> > ?
	m_total_money							dword ?					; 1620
	m_sell_info_actuality					byte ?					; 1624
	m_script_not_check_can_kill				byte ?					; 1625	bool NEW Не сменять оружие если кончились патроны.(надо для роботов с интергрированным оружием)
	m_not_drop_wpn_death					byte ?					; 1626	bool NEW Не сбрасывать оружие при смерти сталкера, остаёться в руках.
											byte ? ; undefined
	CAI_Stalker@m_sound_user_data_visitor	dword ?					; 1628	offset
	m_group_behaviour						byte ?					; 1632
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_weapon_shot_effector					dword ?					; 1636	offset
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
	m_best_cover							dword ?					; 1708	offset
	m_best_cover_value						dword ?					; 1712
	m_best_cover_actual						byte ?					; 1716
	m_best_cover_can_try_advance			byte ?					; 1717
											byte ? ; undefined
											byte ? ; undefined
	m_best_cover_advance_cover				dword ?					; 1720	offset
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
	IPhysicShellCreator@vfptr				dword ?				; offset
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
	CAttachableItem@vfptr					dword ?				; 0		offset
	CAttachableItem@m_item					dword ?				; 4		offset
	m_bone_name								shared_str <>		; 8		
	CAttachableItem@m_offset				Fmatrix <>			; 12
	m_bone_id								word ?				; 76
	m_enabled								byte ?				; 77
											byte ? ; undefined
CAttachableItem ends											; 80

CHudItem struct ; (sizeof=60, align=4)
	CHudItem@vfptr							dword ?				; 0		offset
	m_state									dword ?				; 4
	m_nextState								dword ?				; 8
	m_bPending								byte ?				; 12
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_pHUD									dword ?				; 16	offset
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
	CHudItem@m_object						dword ?				; 52	offset
	CHudItem@m_item							dword ?				; 56	offset
CHudItem ends													; 60

CInventoryItem struct ; (sizeof=216, align=8)
	CAttachableItem <>											; 0
	CHitImmunity <>												; 80
	m_flags									word ?				; 132	flags16
											byte ? ; undefined
											byte ? ; undefined
	m_pCurrentInventory						dword ?				; 136	offset
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
	m_net_updateData						dword ?				; 200	offset
	m_holder_range_modifier					dword ?				; 204
	m_holder_fov_modifier					dword ?				; 208
	CInventoryItem@m_object					dword ?				; 212	offset
CInventoryItem ends												; 216

CInventoryItemObject struct ; (sizeof=648, align=8)
	CInventoryItem <>											; 0
	CPhysicItem <>												; 216
CInventoryItemObject ends										; 648

CHudItemObject struct ; (sizeof=712, align=8)
	CInventoryItemObject <>											; 0
	CHudItem <>														; 648
											dword ? ; undefined
CHudItemObject ends													; 712

CWeapon@@_firedeps struct ; (sizeof=112, align=4)
	m_FireParticlesXForm					Fmatrix <>				; 0
	vLastFP									Fvector <>				; 64
	vLastFP2								Fvector <>				; 76
	vLastFD									Fvector <>				; 88
	vLastSP									Fvector <>				; 100
CWeapon@@_firedeps ends												; 112

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
											byte ? ; undefined
											byte ? ; undefined
	m_fZoomFactor							dword ?					; 992
	m_fZoomRotateTime						dword ?					; 996
	m_UIScope								dword ?					; 1000	offset
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
	m_strap_bone0							dword ?					; 1024	offset
	m_strap_bone1							dword ?					; 1028	offset
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
	m_firedeps								CWeapon@@_firedeps <>	; 1193
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
	m_fPDM_disp_base						dword ?					; 1356
	m_fPDM_disp_vel_factor					dword ?					; 1360
	m_fPDM_disp_accel_factor				dword ?					; 1364
	m_fPDM_disp_crouch						dword ?					; 1368
	m_fPDM_disp_crouch_no_acc				dword ?					; 1372
	m_vRecoilDeltaAngle						Fvector <>				; 1376
	CWeapon@m_fMinRadius					dword ?					; 1388
	CWeapon@m_fMaxRadius					dword ?					; 1392
	m_sFlameParticles2						shared_str <>			; 1396
	m_pFlameParticles2						dword ?					; 1400	offset
	iAmmoElapsed							dword ?					; 1404
	iMagazineSize							dword ?					; 1408
	iAmmoCurrent							dword ?					; 1412
	m_dwAmmoCurrentCalcFrame				dword ?					; 1416
	m_bAmmoWasSpawned						byte ?					; 1420
											byte ? ; undefined
											byte ? ; undefined
											byte ? ; undefined
	m_ammoTypes								xr_vector <>			; 1424	xr_vector<shared_str,xalloc<shared_str> > ?
	m_pAmmo									dword ?					; 1440	offset
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
	m_pSndShotCurrent					dword ?							; 1676	offset
	m_sSilencerFlameParticles			dword ?							; 1680	offset
	m_sSilencerSmokeParticles			dword ?							; 1684	offset
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


