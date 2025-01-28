# 1

operator: do something to operand
operand: done something by operator

# 5

every executable files has `cffa edfe` on it's head of hexdump format
left most column is represented by hex-decimal

# 7

I wrote simple c program asm_no_volatile.c which basically same to asm.c but not using volatile
with that program, I got assembly below

```asm
	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 2
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w0, #0                          ; =0x0
	str	wzr, [sp, #12]
	adrp	x9, _asm_c@PAGE
	ldr	w8, [x9, _asm_c@PAGEOFF]
	add	w8, w8, #666
	str	w8, [x9, _asm_c@PAGEOFF]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_asm_c                          ; @asm_c
.zerofill __DATA,__common,_asm_c,4,2
.subsections_via_symbols
```

and this is the original version

```asm
	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 2
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w0, #0                          ; =0x0
	str	wzr, [sp, #12]
	adrp	x9, _asm_c@PAGE
	ldr	w8, [x9, _asm_c@PAGEOFF]
	add	w8, w8, #666
	str	w8, [x9, _asm_c@PAGEOFF]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_asm_c                          ; @asm_c
.zerofill __DATA,__common,_asm_c,4,2
.subsections_via_symbols
```

yes, they are exactly the same.
imo, this is due to compiling both without specifying any optimization

# 8

## advantage

human can see ir and easy to optimize

## disadvantage

it takes additional compile time

# 9
