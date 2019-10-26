;.text:100024C0                 fstp    [esp+30h+var_2C]
;.text:100024C4                 mov     ecx, offset dword_100E0508
;.text:100024C9                 fld     flt_100CD570
mip_bias proc
	fstp	[esp+30h+var_2C]	; как извлечь из стека FPU значение, никуда его не сохраняя? :)
	fld		ds:[mip_bias_max]
	fstp	[esp+30h+var_2C]
	mov		ecx, offset mipbias_obj
	fld		ds:[mip_bias_min]
	jmp		back_to_mip_bias
mip_bias endp

mip_bias_max dd 3.0
mip_bias_min dd -3.0
var_2C = dword ptr -2Ch

test_CModelPool__Instance_Create proc
;edi - type
	mov		edx, [esp+4]
	PRINT_UINT "return  %08X", edx
	PRINT_UINT "CModelPool::Instance_Create type = %d", edi
	xor		esi, esi
	cmp		edi, 11
	jmp		return_test_CModelPool__Instance_Create
test_CModelPool__Instance_Create endp

log_CModelPool__Instance_Load proc
name_		= -414h
fn_			= -20Ch
	lea		eax, [esp+44Ch+fn_];name_
	PRINT_UINT "name '%s'", eax
	movzx   edi, byte ptr [esp+0Dh]	;вырезаное
	PRINT_UINT "type = %d", edi
	jmp		return_log_CModelPool__Instance_Load
log_CModelPool__Instance_Load endp