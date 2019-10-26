
;	---===RayPick===---
collide__rq_result struct
	O					dword ? ; CObject *O;
	range				dword ? ;	float range;
	element				dword ? ;	int element;
collide__rq_result ends
;	---===RayPick===---

Fvector struct
	x					dword ? ; 
	y					dword ? ;
	z					dword ? ;
Fvector ends

Fvector4 struct
	x					dword ? ; 
	y					dword ? ;
	z					dword ? ;
	_					dword ?
Fvector4 ends

CCartridge struct 4		; sizeof 60 bytes 
	m_ammoSect			dword ?
	kDist				dword ?
	kDisp				dword ?
	kHit				dword ?
	kImpulse			dword ?
	kAP					dword ?
	kAirRes				dword ?
	buckShot			dword ?
	impair				dword ?
	fWallmarkSize		dword ?
	u8ColorID			byte ?
	align 4
	m_LocalAmmoType		byte ?
	align 4
	bullet_material_idx	word ?
	align 4
	m_flags				byte ?
	align 4
	m_InvShortName		dword ?
	align 4
CCartridge ends

; for m_flags
cfTracer				= byte ptr 1
cfRicochet				= byte ptr 2
cfCanBeUnlimited		= byte ptr 4
cfExplosive				= byte ptr 8
cfMagneticBeam			= byte ptr 16
;-----------
SHit struct ; sizeof 72 bytes
	Time				dword ? 		; u32		  	// 0
	PACKET_TYPE			word ? 			; u16		  	// 4
	DestID				word ? 			; u16		  	// 6
	power				dword ? 		; float			// 8
	dir					Fvector <>		;			  	// 12
	who					dword ? 		; CObject 		// 24
	whoID				word ?			; u16			// 28
	weaponID			word ?			; u16			// 30
	boneID				word ?			; u16			// 32
	p_in_bone_space 	Fvector <>		;			  	// 34
	align 4
	impulse				dword ? 		; float			// 48
	hit_type			dword ? 		; ALife::EHitType // 52
	armor_piercing		dword ? 		; float			// 56
	add_wound			byte ?			; bool			// 60
	aim_bullet			byte ? 			; bool			// 61
	align 4
	BulletID			dword ? 		; u32			// 64
	SenderID			dword ? 		; u32			// 68
SHit ends