
;=================================================================================
;============================= (c) NanoBot =======================================
;=================================================================================
;========================= for Clear Sky 1.5.10 ==================================

eWeaponOnShoot		= dword ptr 181		; колбек на выстрел
eWeaponStartBullet	= dword ptr 182		; колбек на старт пули
eWeaponStopBullet	= dword ptr 183		; колбек на стоп пули

m_dwTotalShots dd 0						; для генератора айдишника пуль.		GLOBAL
aCallback_on db "callback_on", 0		; название булевого параметра в конфиге патрона для включения колбеков для старта и стопа пули.

; колбек на выстрел, вызывается в объекте оружия
CWeapon__CallbackOnShoot proc
;--------------------------------
; edi - weapon
iAmmoElapsed				= dword ptr  0		;1404
m_DefaultCartridge			= dword ptr  1740	;1472
m_ammoName					= dword ptr  1712
m_ammoType					= dword ptr  1708
m_iCurFireMode				= dword ptr  1928	;1928
m_bHasDifferentFireModes	= dword ptr  1914	; bool (sizeof 1 byte)
; ebp - *cartridge
m_ammoSect					= dword ptr  4
m_InvShortName				= dword ptr  60
;--------------------------------
;	push	ecx
;	push	edx
	pusha
	;========================================
;	PRINT_UINT "callback_onShoot start  esp - %d", esp
;	movzx   ecx, word ptr [edi+194h]	; ID()
;	PRINT_UINT "CObject weapon - %d", eax
;	PRINT_UINT "CWeapon weapon - %d", edi
	; callback(eWeaponOnShoot)(l_cartridge.m_ammoSect, m_bHasDifferentFireModes ? m_iCurFireMode+1 : 1);
	xor		eax, eax
	test	byte ptr [edi+m_bHasDifferentFireModes], 1
	jz		lab2
	mov		eax, [edi+m_iCurFireMode]	; тип режима огня
lab2:
	inc		eax
	mov		ecx, [ebp+m_ammoSect]		; секция патрона
	jcxz	lab1
	add		ecx, 10h
lab1:
	push    eax	 						; int
	push    ecx							; str
	push    offset eWeaponOnShoot 		; константа - тип колбека
	mov		ecx, edi 					; this
	add     ecx, 240
	call    CGameObject__callback 		; eax = callback
	push    eax 						; callback
	call    script_callback_str_uint	; script_callback_int_int	; 
;	PRINT_UINT "callback_onShoot end  esp - %d", esp
	;========================================
	popa
;	pop		edx
;	pop 	ecx
	; делаем вырезанное
	mov     eax, [edi+6C4h]	; 6 bytes
	jmp		back_from_CWeapon__CallbackOnShoot
CWeapon__CallbackOnShoot endp
;--------------------------------------------------------------------------

Objects_net_Find proc
	mov     eax, ds:g_pGameLevel 		; IGame_Level * g_pGameLevel
	mov     eax, [eax]
	mov     eax, [eax+ecx*4+4Ch]
	retn
Objects_net_Find endp

;CCar__Enter_log proc
;	PRINT	"CCar__Enter_log"
	; делаем вырезанное
;	mov     ecx, [esi+0ACh]
;	jmp		back_from_CCar__Enter_log
;CCar__Enter_log endp
