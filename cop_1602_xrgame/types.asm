
TRUE				equ 1
FALSE				equ 0
NULL				equ 0

;	---===RayPick===---
collide__rq_result struc
O					dd ? ; CObject *O;
range				dd ? ;	float range;
element				dd ? ;	int element;
collide__rq_result ends
;	---===RayPick===---

Fvector struc
x					dd ? ; 
y					dd ? ;
z					dd ? ;
Fvector ends

Fvector4 struc
x					dd ? ; 
y					dd ? ;
z					dd ? ;
_					dd ?
Fvector4 ends

CCartridge struct 4		; sizeof 60 bytes 
	m_ammoSect			dd ?
	kDist				dd ?
	kDisp				dd ?
	kHit				dd ?
	kImpulse			dd ?
	kAP					dd ?
	kAirRes				dd ?
	buckShot			dd ?
	impair				dd ?
	fWallmarkSize		dd ?
	u8ColorID			db ?
	align 4
	m_LocalAmmoType		db ?
	align 4
	bullet_material_idx	dw ?
	align 4
	m_flags				db ?
	align 4
	m_InvShortName		dd ?
	align 4
CCartridge ends

; for m_flags
cfTracer				= byte ptr 1
cfRicochet				= byte ptr 2
cfCanBeUnlimited		= byte ptr 4
cfExplosive				= byte ptr 8
cfMagneticBeam			= byte ptr 16
;-----------

SHit	struc 					; sizeof 72 bytes
	Time			dd ? 		; u32		  	// 0
	PACKET_TYPE		dw ? 		; u16		  	// 4
	DestID			dw ? 		; u16		  	// 6
	power			dd ? 		; float			// 8
	dir				Fvector <>	;			  	// 12
	who				dd ? 		; CObject 		// 24
	whoID			dw ?		; u16			// 28
	weaponID		dw ?		; u16			// 30
	boneID			dw ?		; u16			// 32
	p_in_bone_space Fvector <>	;			  	// 34
	align 4
	impulse			dd ? 		; float			// 48
	hit_type		dd ? 		; ALife::EHitType // 52
	armor_piercing	dd ? 		; float			// 56
	add_wound		db ?		; bool			// 60
	aim_bullet		db ? 		; bool			// 61
	align 4
	BulletID		dd ? 		; u32			// 64
	SenderID		dd ? 		; u32			// 68
SHit	ends
