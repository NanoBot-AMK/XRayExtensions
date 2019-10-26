
;void Projector::Hit(SHit* pHDS);
align_proc
Projector__Hit proc uses esi ebx pHDS:ptr SHit
	mov		esi, ecx
	mov		ebx, pHDS
	ASSUME	ebx:ptr SHit
	CALLBACK__GO_FLOAT_VECTOR_GO_u16	esi, GameObject__eHit, esi, [ebx].power, [ebx].dir, [ebx].who, [ebx].boneID
	ASSUME	ebx:nothing
	ret
Projector__Hit endp
