
M_CSE_ABSTRACT_REGISTER__VECTOR__RW_PROP MACRO prop_name:REQ, prop_offs:REQ
	push	prop_offs
	push	const_static_str$(prop_name)
	push	eax
	call	cse_abstract_register__vector__rw_prop
ENDM
