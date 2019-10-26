;======================================================================
;	Project		: XRay - Extensions		
;	Module		: weapon_RPG7_fix.asm
;	Created		: 14.10.2019
;	Modified	: 22.10.2019
;	Author		: NanoBot
;	Description : Гранатомёт РПГ-7, класс CWeaponRPG7
;======================================================================
Fvector4@@rotate_angle90 PROTO vec0:ptr Fvector4, vec1:ptr Fvector4, angle:real4
;
align_proc
CWeaponRPG7@@FireTraceRocket proc uses esi edi ebx P:ptr Fvector4, D:ptr Fvector4
	lea		edi, [ecx-CWeaponRPG7.CRocketLauncher@vfptr]
	ASSUME	edi:ptr CWeaponRPG7, esi:ptr CWeaponHUD, ebx:ptr CKinematics, edx:ptr Fvector4
	.if ([edi].hud_mode)
		;CKinematics*	V = smart_cast<CKinematics*>(m_pHUD->Visual());
		mov		esi, [edi].m_pHUD
		mov		eax, [esi].m_shared_data.p_
		mov		ebx, CKinematics@@dcast_PKinematics([eax].weapon_hud_value.m_animations)
		CKinematics@@CalculateBones(ebx)
		;num_bone	= m_aHudBonesGrenade[iMagazineSize - iAmmoElapsed];
		mov		ecx, [edi].iMagazineSize
		sub		ecx, [edi].iAmmoElapsed
		movzx	eax, [edi].m_aHudBonesGrenade.array[ecx*2]
		;Fvector&	matrix = m_pHUD->Transform();
		lea		esi, [esi].m_Transform
	.else
		;CKinematics*	V = smart_cast<CKinematics*>(Visual());
		mov		ebx, CKinematics@@dcast_PKinematics([edi].Visual_)
		;num_bone	= m_aBonesGrenade[iMagazineSize - iAmmoElapsed];
		mov		ecx, [edi].iMagazineSize
		sub		ecx, [edi].iAmmoElapsed
		movzx	eax, [edi].m_aBonesGrenade.array[ecx*2]
		;Fvector&	matrix = XFORM();
		lea		esi, [edi].XFORM_
	.endif
	ASSUME	esi:ptr Fmatrix4
	;matrix.transform_tiny(P, V->LL_GetTransform(num_bone).c);
	imul	ecx, eax, sizeof CBoneInstance
	add		ecx, [ebx].bone_instances
	mov		edx, P
	Fmatrix4@transform_tiny	[esi], [edx], [ecx].CBoneInstance.mTransform.c_
	xorps	xmm0, xmm0
	.if (xmm0<[edi].m_deflection_angles.x)
		mov		ecx, D
		Fvector4@@rotate_angle90(&[esi].k, &[esi].j, [edi].m_deflection_angles.x)
	.endif
	xorps	xmm0, xmm0
	.if (xmm0<[edi].m_deflection_angles.y)
		mov		ecx, D
		Fvector4@@rotate_angle90(D, &[esi].i, [edi].m_deflection_angles.y)
	.endif
	lea		ecx, [edi].CRocketLauncher@vfptr
	CRocketLauncher@@StartRocket(P, D, false)
	ASSUME	edi:nothing, esi:nothing, ebx:nothing, edx:nothing
	ret
CWeaponRPG7@@FireTraceRocket endp
;----------------------------------------------------------------------

;
align_proc
CWeaponRPG7@@Load_ext proc
local GrenadesBonesName:dword, pVisual:ptr CKinematics, pVector:Fvector2, sItem[128]:byte
;esi	this		CWeaponRPG7*
;edi	section		LPCSTR
	ASSUME	esi:ptr CWeaponRPG7
	mov		pVisual, CKinematics@@dcast_PKinematics([esi].Visual_)
	;загрузка костей в мировой модели
	mov		GrenadesBonesName, @R_STRING(edi, &aGrenade_bone)
	mov		[esi].m_aBonesGrenade.count, _GetItemCount(eax)
	.for (ebx=0: ebx < [esi].m_aBonesGrenade.count: ebx++)
		_GetItem(GrenadesBonesName, ebx, &sItem)
		;m_aBonesGrenade[it] = pVisual->LL_BoneID(sItem);
		mov		[esi].m_aBonesGrenade.array[ebx*2], CKinematics@@LL_BoneID(pVisual, &sItem)
	.endfor
	;загрузка костей в худовой модели
	mov		eax, [esi].m_pHUD
	mov		edx, [eax].CWeaponHUD.m_shared_data.p_
	mov		pVisual, CKinematics@@dcast_PKinematics([edx].weapon_hud_value.m_animations)
	mov		edx, [esi].hud_sect.p_
	mov		GrenadesBonesName, @R_STRING(&[edx].str_value.value, &aGrenade_bone)
	mov		[esi].m_aHudBonesGrenade.count, _GetItemCount(eax)
	.for (ebx=0: ebx < [esi].m_aHudBonesGrenade.count: ebx++)
		_GetItem(GrenadesBonesName, ebx, &sItem)
		;m_aHudBonesGrenade[it] = pVisual->LL_BoneID(sItem);
		mov		[esi].m_aHudBonesGrenade.array[ebx*2], CKinematics@@LL_BoneID(pVisual, &sItem)
	.endfor
	mov		[esi].m_bCanRocketReload, true
	mov		ebx, const_static_str$("deflection_angles")
	.if (@LINE_EXIST(edi, ebx))
		@R_FVECTOR2(&pVector, edi, ebx)
		movss	xmm0, [eax].Fvector2.x
		movss	xmm1, [eax].Fvector2.y
		mulss	xmm0, g_fDeg2rad
		mulss	xmm1, g_fDeg2rad
		movss	[esi].m_deflection_angles.x, xmm0
		movss	[esi].m_deflection_angles.y, xmm1
	.else
		xor		eax, eax
		mov		[esi].m_deflection_angles.x, eax
		mov		[esi].m_deflection_angles.y, eax
	.endif
	ASSUME	esi:nothing
	leave
;---------------------
	pop		edi
	pop		esi
	pop		ebp
	pop		ebx
	retn	4
CWeaponRPG7@@Load_ext endp

align_proc
CWeaponRPG7@@UpdateMissileVisibility_fun proc uses esi edi ebx pWeaponVisual:dword, pHudVisual:dword, vis_hud:dword, vis_weap:dword
	mov		ebx, ecx	;CWeaponRPG7*
	ASSUME	ebx:ptr CWeaponRPG7
	.if (pHudVisual)
		mov		esi, [ebx].m_aHudBonesGrenade.count
		.if ([ebx].iMagazineSize>1)	;на случай многозарядного гранатомёта типа М202
			mov		esi, [ebx].iMagazineSize
		.endif
		.for (edi=0: edi<esi: edi++)
			xor		edx, edx	;vis
			mov		eax, [ebx].iMagazineSize
			.if (eax>1)	;на случай многозарядного гранатомёта типа М202
				;((iMagazineSize - iAmmoElapsed) <= num_bone) ? vis_hud : FALSE
				sub		eax, [ebx].iAmmoElapsed
				.if (eax<=edi)
					mov		edx, vis_hud
				.endif
			.else		;на случай многотипозарядного гранатомёта типа РПГ-7 с кучей костей под разные выстрелы.
				;(m_ammoType == num_bone) ? vis_hud : FALSE
				.if ([ebx].m_ammoType==edi)
					mov		edx, vis_hud
				.endif
			.endif
			CKinematics@@LL_SetBoneVisible(pHudVisual, [ebx].m_aHudBonesGrenade.array[edi*2], edx, TRUE)
		.endfor
	.endif
	mov		esi, [ebx].m_aBonesGrenade.count
	.if ([ebx].iMagazineSize>1)	;// на случай многозарядного гранатомёта типа М202
		mov		esi, [ebx].iMagazineSize
	.endif
	.for (edi=0: edi<esi: edi++)
		xor		edx, edx	;vis
		mov		eax, [ebx].iMagazineSize
		.if (eax>1)	;на случай многозарядного гранатомёта типа М202
			;((iMagazineSize - iAmmoElapsed) <= num_bone) ? vis_weap : FALSE
			sub		eax, [ebx].iAmmoElapsed
			.if (eax<=edi)
				mov		edx, vis_weap
			.endif
		.else		;на случай многотипозарядного гранатомёта типа РПГ-7 с кучей костей под разные выстрелы.
			;(m_ammoType == num_bone) ? vis_weap : FALSE
			.if ([ebx].m_ammoType==edi)
				mov		edx, vis_weap
			.endif
		.endif
;;		printf("num_bone = %d, bone = %d, vis = %d", edi, [ebx].m_aBonesGrenade.array[edi*2], edx)
		CKinematics@@LL_SetBoneVisible(pWeaponVisual, [ebx].m_aBonesGrenade.array[edi*2], edx, TRUE)
	.endfor
	ASSUME	ebx:nothing
	ret
CWeaponRPG7@@UpdateMissileVisibility_fun endp

align_proc
CWeaponRPG7@@OnAnimationEnd proc state:dword
	mov		[ecx-CWeaponRPG7.CHudItem@vfptr].CWeaponRPG7.m_bCanRocketReload, true
	CWeaponMagazined@@OnAnimationEnd(ecx, state)
	ret
CWeaponRPG7@@OnAnimationEnd endp
