;---------------------------------------------------------------------------


;---------------------------------------------------------------------------

_D3DDISPLAYMODE struct ; (sizeof=0x10, align=4)
	Width_								dword ?
	Height_								dword ?
	RefreshRate							dword ?
	Format								dword ?					; enum D3DFORMAT
_D3DDISPLAYMODE ends

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

CHWCaps@@caps_Geometry struct ; (sizeof=8, align=4)
	_bf0								dword ?						; 0
	_bf4								dword ?						; 4
CHWCaps@@caps_Geometry ends											; 8

CHWCaps@@caps_Raster struct ; (sizeof=8, align=4)
	_bf0								dword ?						; 0
	_bf4								dword ?						; 4
CHWCaps@@caps_Raster ends											; 8

CHWCaps struct ; (sizeof=88, align=4)
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
	raster_minor						word ?						; 42
	raster								CHWCaps@@caps_Raster <>		; 44
	id_vendor							dword ?						; 52
	id_device							dword ?						; 56
	bStencil							dword ?						; 60
	bScissor							dword ?						; 64
	bTableFog							dword ?						; 68
	soDec								dword ?						; 72	enum _D3DSTENCILOP
	soInc								dword ?						; 76	enum _D3DSTENCILOP
	dwMaxStencilValue					dword ?						; 80
CHWCaps ends														; 84

CHW struct ; (sizeof=168, align=4)
	hD3D9								dword ?						; 0		HINSTANCE
	pD3D								dword ?						; 4		IDirect3D9*
	pDevice								dword ?						; 8		IDirect3DDevice9*
	pBaseRT								dword ?						; 12	IDirect3DSurface9*
	pBaseZB								dword ?						; 16	IDirect3DSurface9*
	Caps								CHWCaps <>					; 20
	DevAdapter							dword ?						; 104
	DevT								dword ?						; 108	enum _D3DDEVTYPE
	DevPP								_D3DPRESENT_PARAMETERS_ <>	; 112
CHW ends															; 168

IConsole_Command struct ; (sizeof=12, align=4)
	vfptr								dword ?					; 0
	cName								dword ?					; 4
	bEnabled							byte ?					; 8
	bLowerCaseArgs						byte ?					; 9
	bEmptyArgsHandled					byte ?					; 10
										byte ? ; undefined
IConsole_Command ends											; 

CCC_Integer struct ; (sizeof=0x18, align=4)
	IConsole_Command <>											; 0
	value								dword ?					; 12
	min									dword ?					; 16
	max									dword ?					; 20
CCC_Integer ends												; 24

xr_vector struct ; (sizeof=16, align=4)
	_Alval				dword ?				; 0		allocator object for values			; объект{цель} программы распределени€ дл€ значений
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

str_value struct ; (sizeof=12, align=4, variable size)
	dwReference			dword ?				; 0		u32
	dwLength			dword ?				; 4		u32
	dwCRC				dword ?				; 8		u32
	value				byte 0 dup(?)		; 12	char[]
str_value ends

shared_str struct ; (sizeof=4, align=4)
	p_					dword ?				; 4		str_value*
shared_str ends

resptr_core struct ; (sizeof=4, align=4,)
	p_					dword ?				; 4
resptr_core ends

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

xr_resource struct ; (sizeof=4, align=4)
	dwReference							dword ?
xr_resource ends

xr_resource_flagged struct ; (sizeof=8, align=4)
	xr_resource <>													; 
	dwFlags								dword ?						; 
xr_resource_flagged ends

xr_resource_named struct ; (sizeof=12, align=4)
	xr_resource_flagged <>											; 
	cName								shared_str <>				; 
xr_resource_named ends

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

CTexture struct ; (sizeof=104, align=4)
	vfptr								dword ?							; 0		offset
	xr_resource_named <>												; 4
	flags								dword ?							; 16
	bind								fastdelegate@@FastDelegate1 <>	; 20
	pSurface							dword ?							; 28	IDirect3DBaseTexture9*
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

std@@pair struct ; (sizeof=8, align=4)
	first			dword ?				; 0
	second			resptr_core <>		; 4		resptr_core<CTexture,resptrcode_texture> ?
std@@pair ends

std@@pair@u32_ref_texture@ struct ; (sizeof=8, align=4)
	std@@pair <>
std@@pair@u32_ref_texture@ ends

CTextureDescrMngr struct ; (sizeof=12, align=4)
	m_texture_details 		xr_map <>			;xr_map<shared_str,CTextureDescrMngr::texture_desc,std::less<shared_str>,xalloc<std::pair<shared_str,CTextureDescrMngr::texture_desc> > > ?
CTextureDescrMngr ends

CResourceManager struct ; (sizeof=320, align=4)
	m_blenders				xr_map <>			; 0		xr_map<char const*,IBlender*,CResourceManager::str_pred,xalloc<std::pair<char const *,IBlender*>>>?
	m_textures				xr_map <>			; 12	xr_map<char const*,CTexture*,CResourceManager::str_pred,xalloc<std::pair<char const *,CTexture*>>>?
	m_matrices				xr_map <>			; 24	xr_map<char const*,CMatrix*,CResourceManager::str_pred,xalloc<std::pair<char const *,CMatrix*>>>?
	m_constants				xr_map <>			; 36	xr_map<char const*,CConstant*,CResourceManager::str_pred,xalloc<std::pair<char const *,CConstant*>>>?
	m_rtargets				xr_map <>			; 48	xr_map<char const*,CRT*,CResourceManager::str_pred,xalloc<std::pair<char const*,CRT*>>>?
	m_rtargets_c			xr_map <>			; 60	xr_map<char const*,CRTC*,CResourceManager::str_pred,xalloc<std::pair<char const*,CRTC*>>>?
	m_vs					xr_map <>			; 72	xr_map<char const*,SVS*,CResourceManager::str_pred,xalloc<std::pair<char const *,SVS *> > >?
	m_ps					xr_map <>			; 84	xr_map<char const*,SPS*,CResourceManager::str_pred,xalloc<std::pair<char const *,SPS *> > >?
	m_td					xr_map <>			; 96	xr_map<char const *,CResourceManager::texture_detail,CResourceManager::str_pred,xalloc<std::pair<char const *,CResourceManager::texture_detail> > > ?
	v_states				xr_vector <>		; 108	xr_vector<SState *,xalloc<SState *> > ?
	v_declarations			xr_vector <>		; 124	xr_vector<SDeclaration *,xalloc<SDeclaration *> > ?
	v_geoms					xr_vector <>		; 140	xr_vector<SGeometry *,xalloc<SGeometry *> > ?
	v_constant_tables 		xr_vector <>		; 156	xr_vector<R_constant_table *,xalloc<R_constant_table *> > ?
	lst_textures			xr_vector <>		; 172	xr_vector<STextureList *,xalloc<STextureList *> > ?
	lst_matrices			xr_vector <>		; 188	xr_vector<SMatrixList *,xalloc<SMatrixList *> > ?
	lst_constants			xr_vector <>		; 204	xr_vector<SConstantList *,xalloc<SConstantList *> > ?
	v_passes				xr_vector <>		; 220	xr_vector<SPass *,xalloc<SPass *> > ?
	v_elements				xr_vector <>		; 236	xr_vector<ShaderElement *,xalloc<ShaderElement *> > ?
	v_shaders				xr_vector <>		; 252	xr_vector<Shader *,xalloc<Shader *> > ?
	m_necessary				xr_vector <>		; 268	xr_vector<resptr_core<CTexture,resptrcode_texture>,xalloc<resptr_core<CTexture,resptrcode_texture> > > ?
	m_textures_description 	CTextureDescrMngr <>; 284	
	v_constant_setup 		xr_vector <>		; 296	xr_vector<std::pair<shared_str,R_constant_setup *>,xalloc<std::pair<shared_str,R_constant_setup *> > > ?
	LSVM					dword ?				; 312	lua_State*
	bDeferredLoad			dword ?				; 316
CResourceManager ends							; 320
