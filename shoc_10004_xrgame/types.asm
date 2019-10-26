
TRUE				equ 1
FALSE				equ 0
NULL				= dword ptr 0


; enum ERelationType {
ALife__eRelationTypeFriend			= dword ptr 0
ALife__eRelationTypeNeutral			= dword ptr 1
ALife__eRelationTypeEnemy			= dword ptr 2
ALife__eRelationTypeWorstEnemy		= dword ptr 3
ALife__eRelationTypeLast			= dword ptr 4
ALife__eRelationTypeDummy			= dword ptr -1
;};
;ENGINE_API extern Flags32		psHUD_Flags;
HUD_CROSSHAIR			equ 1 shl 0
HUD_CROSSHAIR_DIST		equ 1 shl 1
HUD_WEAPON				equ 1 shl 2
HUD_INFO				equ 1 shl 3
HUD_DRAW				equ 1 shl 4
HUD_CROSSHAIR_RT		equ 1 shl 5
HUD_WEAPON_RT			equ 1 shl 6
HUD_CROSSHAIR_DYNAMIC	equ 1 shl 7
HUD_CROSSHAIR_RT2		equ 1 shl 9
HUD_DRAW_RT				equ 1 shl 10

;enum {
GE_RESPAWN							= dword ptr 0
GE_OWNERSHIP_TAKE					= dword ptr 1			;// DUAL: Client request for ownership of an item
GE_OWNERSHIP_TAKE_MP_FORCED			= dword ptr 2
GE_OWNERSHIP_REJECT					= dword ptr 3			;// DUAL: Client request ownership rejection
GE_TRANSFER_AMMO					= dword ptr 4			;// DUAL: Take ammo out of weapon for our weapon
GE_HIT								= dword ptr 5			;//
GE_DIE								= dword ptr 6			;//
GE_ASSIGN_KILLER					= dword ptr 7			;//
GE_DESTROY							= dword ptr 8			;// authorative client request for entity-destroy
GE_DESTROY_REJECT					= dword ptr 9			;// GE_DESTROY + GE_OWNERSHIP_REJECT
GE_TELEPORT_OBJECT					= dword ptr 10
GE_ADD_RESTRICTION					= dword ptr 11
GE_REMOVE_RESTRICTION				= dword ptr 12
GE_REMOVE_ALL_RESTRICTIONS			= dword ptr 13
GE_BUY								= dword ptr 14
GE_INFO_TRANSFER					= dword ptr 15			;//transfer _new_ info on PDA
GE_TRADE_SELL						= dword ptr 16
GE_TRADE_BUY						= dword ptr 17
GE_WPN_AMMO_ADD						= dword ptr 18
GE_WPN_STATE_CHANGE					= dword ptr 19
GE_ADDON_ATTACH						= dword ptr 20
GE_ADDON_DETACH						= dword ptr 21
GE_ADDON_CHANGE						= dword ptr 22
GE_GRENADE_EXPLODE					= dword ptr 23
GE_INV_ACTION						= dword ptr 24			;//a action beign taken on inventory
GE_ZONE_STATE_CHANGE				= dword ptr 25
GE_MOVE_ACTOR						= dword ptr 26			;//move actor to desired position instantly
GE_ACTOR_JUMPING					= dword ptr 27			;//actor press jump key
GE_ACTOR_MAX_POWER					= dword ptr 28
GE_CHANGE_POS						= dword ptr 29
GE_GAME_EVENT						= dword ptr 30
GE_CHANGE_VISUAL					= dword ptr 31
GE_MONEY							= dword ptr 32
GEG_PLAYER_ACTIVATE_SLOT			= dword ptr 33
GEG_PLAYER_ITEM2SLOT				= dword ptr 34
GEG_PLAYER_ITEM2BELT				= dword ptr 35
GEG_PLAYER_ITEM2RUCK				= dword ptr 36
GEG_PLAYER_ITEM_EAT					= dword ptr 37
GEG_PLAYER_ITEM_SELL				= dword ptr 38
GEG_PLAYER_ACTIVATEARTEFACT			= dword ptr 39
GEG_PLAYER_WEAPON_HIDE_STATE		= dword ptr 40
GEG_PLAYER_ATTACH_HOLDER			= dword ptr 41
GEG_PLAYER_DETACH_HOLDER			= dword ptr 42
GEG_PLAYER_PLAY_HEADSHOT_PARTICLE	= dword ptr 43
;	//-------------------------------------
GE_HIT_STATISTIC					= dword ptr 44
;	//-------------------------------------
GE_KILL_SOMEONE						= dword ptr 45
GE_FREEZE_OBJECT					= dword ptr 46
GE_LAUNCH_ROCKET					= dword ptr 47
GE_FORCEDWORD						= dword ptr -1
;};

;enum EMoveCommand
mcFwd								= dword ptr (1 shl 0)	; 1			вперёд
mcBack								= dword ptr (1 shl 1)	; 2			назад
mcLStrafe							= dword ptr (1 shl 2)	; 4			влево
mcRStrafe							= dword ptr (1 shl 3)	; 8			вправо
mcCrouch							= dword ptr (1 shl 4)	; 16		в приседе
mcAccel								= dword ptr (1 shl 5)	; 32		идёт
mcTurn								= dword ptr (1 shl 6)	; 64		вращаемся
mcJump								= dword ptr (1 shl 7)	; 128		прыжок
mcFall								= dword ptr (1 shl 8)	; 256		в прыжке
mcLanding							= dword ptr (1 shl 9)	; 512		приземлились
mcLanding2							= dword ptr (1 shl 10)	; 1024		приземлились
mcClimb								= dword ptr (1 shl 11)	; 2048		на леснице
mcSprint							= dword ptr (1 shl 12)	; 4096		спринт
mcLLookout							= dword ptr (1 shl 13)	; 8192		наклон влево
mcRLookout							= dword ptr (1 shl 14)	; 16384		наклон вправо
mcAnyMove							= dword ptr (mcFwd or mcBack or mcLStrafe or mcRStrafe)
mcAnyAction							= dword ptr (mcAnyMove or mcJump or mcFall or mcLanding or mcLanding2) ;//mcTurn or 
mcAnyState							= dword ptr (mcCrouch or mcAccel or mcClimb or mcSprint)
mcLookout							= dword ptr (mcLLookout or mcRLookout)
;=================================================};

;enum	GAME_TYPE {
GAME_UNKNOWN			= 0
GAME_SINGLE				= 1
GAME_DEATHMATCH			= 2
GAME_TEAMDEATHMATCH		= 3
GAME_ARTEFACTHUNT		= 4
GAME_END_LIST			= 5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;DIK_keys {
DIK_0				= 11		;
DIK_1				= 2			;
DIK_2				= 3			;
DIK_3				= 4			;
DIK_4				= 5			;
DIK_5				= 6			;
DIK_6				= 7			;
DIK_7				= 8			;
DIK_8				= 9			;
DIK_9				= 10		;
DIK_A				= 30		;
DIK_ADD				= 78		;
DIK_APOSTROPHE		= 40		;
DIK_APPS			= 221		;
DIK_AT				= 145		;
DIK_AX				= 150		;
DIK_B				= 48		;
DIK_BACK			= 14		;
DIK_BACKSLASH		= 43		;
DIK_C				= 46		;
DIK_CAPITAL			= 58		;
DIK_CIRCUMFLEX		= 144		;
DIK_COLON			= 146		;
DIK_COMMA			= 51		;
DIK_CONVERT			= 121		;
DIK_D				= 32		;
DIK_DECIMAL			= 83		;
DIK_DELETE			= 211		;
DIK_DIVIDE			= 181		;
DIK_DOWN			= 208		;
DIK_E				= 18		;
DIK_END				= 207		;
DIK_EQUALS			= 13		;
DIK_ESCAPE			= 1			;
DIK_F				= 33		;
DIK_F1				= 59		;
DIK_F10				= 68		;
DIK_F11				= 87		;
DIK_F12				= 88		;
DIK_F13				= 100		;
DIK_F14				= 101		;
DIK_F15				= 102		;
DIK_F2				= 60		;
DIK_F3				= 61		;
DIK_F4				= 62		;
DIK_F5				= 63		;
DIK_F6				= 64		;
DIK_F7				= 65		;
DIK_F8				= 66		;
DIK_F9				= 67		;
DIK_G				= 34		;
DIK_GRAVE			= 41		;
DIK_H				= 35		;
DIK_HOME			= 199		;
DIK_I				= 23		;
DIK_INSERT			= 210		;
DIK_J				= 36		;
DIK_K				= 37		;
DIK_KANA			= 112		;
DIK_KANJI			= 148		;
DIK_L				= 38		;
DIK_LBRACKET		= 26		;
DIK_LCONTROL		= 29		;
DIK_LEFT			= 203		;
DIK_LMENU			= 56		;
DIK_LSHIFT			= 42		;
DIK_LWIN			= 219		;
DIK_M				= 50		;
DIK_MINUS			= 12		;
DIK_MULTIPLY		= 55		;
DIK_N				= 49		;
DIK_NEXT			= 209		;
DIK_NOCONVERT		= 123		;
DIK_NUMLOCK			= 69		;
DIK_NUMPAD0			= 82		;
DIK_NUMPAD1			= 79		;
DIK_NUMPAD2			= 80		;
DIK_NUMPAD3			= 81		;
DIK_NUMPAD4			= 75		;
DIK_NUMPAD5			= 76		;
DIK_NUMPAD6			= 77		;
DIK_NUMPAD7			= 71		;
DIK_NUMPAD8			= 72		;
DIK_NUMPAD9			= 73		;
DIK_NUMPADCOMMA		= 179		;
DIK_NUMPADENTER		= 156		;
DIK_NUMPADEQUALS	= 141		;
DIK_O				= 24		;
DIK_P				= 25		;
DIK_PAUSE			= 197		;
DIK_PERIOD			= 52		;
DIK_PRIOR			= 201		;
DIK_Q				= 16		;
DIK_R				= 19		;
DIK_RBRACKET		= 27		;
DIK_RCONTROL		= 157		;
DIK_RETURN			= 28		;
DIK_RIGHT			= 205		;
DIK_RMENU			= 184		;
DIK_RSHIFT			= 54		;
DIK_RWIN			= 220		;
DIK_S				= 31		;
DIK_SCROLL			= 70		;
DIK_SEMICOLON		= 39		;
DIK_SLASH			= 53		;
DIK_SPACE			= 57		;
DIK_STOP			= 149		;
DIK_SUBTRACT		= 74		;
DIK_SYSRQ			= 183		;
DIK_T				= 20		;
DIK_TAB				= 15		;
DIK_U				= 22		;
DIK_UNDERLINE		= 147		;
DIK_UNLABELED		= 151		;
DIK_UP				= 200		;
DIK_V				= 47		;
DIK_W				= 17		;
DIK_X				= 45		;
DIK_Y				= 21		;
DIK_YEN				= 125		;
DIK_Z				= 44		;
MOUSE_1				= 256		;
MOUSE_2				= 512		;
MOUSE_3				= 1024		;
;};

;key_bindings {
kLEFT					= 0
kRIGHT					= 1
kUP						= 2
kDOWN					= 3
kJUMP					= 4
kCROUCH					= 5
kCROUCH_TOGGLE			= 6
kACCEL					= 7
kSPRINT_TOGGLE			= 8
kFWD					= 9
kBACK					= 10
kL_STRAFE				= 11
kR_STRAFE				= 12
kL_LOOKOUT				= 13
kR_LOOKOUT				= 14
kENGINE					= 15
kCAM_1					= 16
kCAM_2					= 17
kCAM_3					= 18
kCAM_4					= 19
kCAM_ZOOM_IN			= 20
kCAM_ZOOM_OUT			= 21
kTORCH					= 22
kNIGHT_VISION			= 23
kWPN_1					= 24
kWPN_2					= 25
kWPN_3					= 26
kWPN_4					= 27
kWPN_5					= 28
kWPN_6					= 29
kARTEFACT				= 30
kWPN_NEXT				= 31
kWPN_FIRE				= 32
kWPN_ZOOM				= 33
kWPN_ZOOM_INC			= 34
kWPN_ZOOM_DEC			= 35
kWPN_RELOAD				= 36
kWPN_FUNC				= 37
kWPN_FIREMODE_PREV		= 38
kWPN_FIREMODE_NEXT		= 39
kPAUSE					= 40
kDROP					= 41
kUSE					= 42
kSCORES					= 43
kCHAT					= 44
kCHAT_TEAM				= 45
kSCREENSHOT				= 46
kQUIT					= 47
kCONSOLE				= 48
kINVENTORY				= 49
kBUY					= 50
kSKIN					= 51
kTEAM					= 52
kACTIVE_JOBS			= 53
kMAP					= 54
kCONTACTS				= 55
kEXT_1					= 56
kVOTE_BEGIN				= 57
kVOTE					= 58
kVOTEYES				= 59
kVOTENO					= 60
kNEXT_SLOT				= 61
kPREV_SLOT				= 62
kSPEECH_MENU_0			= 63
kSPEECH_MENU_1			= 64
kSPEECH_MENU_2			= 65
kSPEECH_MENU_3			= 66
kSPEECH_MENU_4			= 67
kSPEECH_MENU_5			= 68
kSPEECH_MENU_6			= 69
kSPEECH_MENU_7			= 70
kSPEECH_MENU_8			= 71
kSPEECH_MENU_9			= 72
kUSE_BANDAGE			= 73
kUSE_MEDKIT				= 74
kQUICK_SAVE				= 75
kQUICK_LOAD				= 76
kLASTACTION				= 77
kNOTBINDED				= 78
kFORCEDWORD				= -1
;}