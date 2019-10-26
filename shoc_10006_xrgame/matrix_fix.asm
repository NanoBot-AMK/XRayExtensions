include matrix_reg_macro.asm

;;REGISTER__MATRIX__PMATR_PMATR									register__matrix__mul43,	
align_proc
matrix_fix proc
	call	register_matrix__this_float
	;-----------------------------------------------------
	PERFORM_EXPORT__MATRIX__THIS__FLOAT							matrix__transpose,					"transpose"
	PERFORM_EXPORT__MATRIX__THIS__PMATR_PMATR					matrix__mul_43,						"mul_43"
	PERFORM_EXPORT__MATRIX__THIS__FLOAT_FLOAT_FLOAT				matrix__transform_tiny,				"transform_tiny"
	PERFORM_EXPORT__MATRIX__THIS__FLOAT_FLOAT_FLOAT				matrix__transform_dir,				"transform_dir"
	
	;-----------------------------------------------------
	jmp		return_matrix_fix
matrix_fix endp

align_proc
matrix__mul_43 proc pMatrix1:dword, pMatrix2:dword
	mov		eax, pMatrix1
	mov		edx, pMatrix2
	ASSUME	ecx:ptr Fmatrix4, eax:ptr Fmatrix4, edx:ptr Fmatrix4
	Fmatrix4@mul_43	[ecx], [eax], [edx]
	ASSUME	ecx:nothing, eax:nothing, edx:nothing
	ret
matrix__mul_43 endp	
	
SWAP_MATR_CELLS MACRO r1:REQ, c1:REQ, r2:REQ, c2:REQ
	mov		eax, [ecx+((r1-1)*4 + c1 - 1) * 4]
	mov		edx, [ecx+((r2-1)*4 + c2 - 1) * 4]
	mov		[ecx+((r2-1)*4 + c2 - 1) * 4], eax
	mov		[ecx+((r1-1)*4 + c1 - 1) * 4], edx
ENDM

align_proc
matrix__transpose proc param:real4
	SWAP_MATR_CELLS 1,2, 2,1
	SWAP_MATR_CELLS 1,3, 3,1
	SWAP_MATR_CELLS 2,3, 3,2
	ret
matrix__transpose endp

;получаем результат через глобальную переменую g_vector_for_matrix
;которую читам скриптовым методом res_vec:get_result() где res_vec это vector
_static		g_vector_for_matrix		Fvector4 {0.0, 0.0, 0.0, 0.0}
;прототип тут p1:real4, p2:real4, p3:real4
align_proc
matrix__transform_tiny proc	vec:Fvector
	ASSUME	ecx:ptr Fmatrix4
	Fmatrix4@transform_tiny	[ecx], g_vector_for_matrix, vec
	ret
matrix__transform_tiny endp

align_proc
matrix__transform_dir proc	vec:Fvector
	Fmatrix4@transform_dir	[ecx], g_vector_for_matrix, vec
	ASSUME	ecx:nothing
	ret
matrix__transform_dir endp
