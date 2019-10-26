

SMARTCAST_CWeaponMagazinedWGrenade MACRO
	push	0
	push	offset off_10636A7C
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
ENDM

SMARTCAST_CWeaponRPG7 MACRO
	push	0
	push	offset off_10637538
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
ENDM

SMARTCAST_CEliteDetector MACRO
	push	0
	push	offset off_10637B58
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
ENDM

SMARTCAST_CRocketLauncher MACRO
	push	0
	push	offset off_106373E8
	push	offset off_1061842C
	push	0
	push	eax
	call	__RTDynamicCast
	add		esp, 14h
ENDM
