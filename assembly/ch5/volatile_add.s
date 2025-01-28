	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 2
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	wzr, [sp, #12]
	adrp	x10, _i@GOTPAGE
	ldr	x10, [x10, _i@GOTPAGEOFF]
	mov	w8, #666                        ; =0x29a
	str	w8, [x10]
	ldr	w8, [x10]
	add	w8, w8, #1
	str	w8, [x10]
	adrp	x8, _j@GOTPAGE
	ldr	x8, [x8, _j@GOTPAGEOFF]
	mov	w9, #777                        ; =0x309
	str	w9, [x8]
	ldr	w9, [x8]
	ldr	w10, [x10]
	subs	w9, w9, w10
	str	w9, [x8]
	ldr	w9, [x8]
	mov	w11, #10                        ; =0xa
	sdiv	w10, w9, w11
	mul	w10, w10, w11
	subs	w9, w9, w10
	str	w9, [x8]
	ldr	w0, [x8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.comm	_i,4,2                          ; @i
	.comm	_j,4,2                          ; @j
.subsections_via_symbols
