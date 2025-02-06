# 2 analyze `strlen`

# 5 reserved bytes of `.ascii "Hello, World!"`

14 bytes

> ***the answer is 13 bytes***
>
> because null terminating character is not appended automatically

# 6 gas reserve to .data section with

1. 1 byte 0x12

```asm
.section
	.data
		.byte 0x12
```

2. 0 with 256 bytes

```asm
.section
	.data
		.zero 256
```

3. 3 characters "HEY" (w/o terminating character)

```asm
.section
	.data
		.ascii "HEY"
```

4. 3 characters "BYE" (w/ terminating character)

```asm
.section
	.data
		.ascii "BYE\0"
```

> or you can also write
>
> ```asm
> .asciz "BYE"
> ```

5. unsigned 16 bits integer 1234

```asm
.section
	.data
		.short 1234
```

6. signed 32 bits integer -57,890

```asm
.section
	.data
		.int -57890
```

7. 32 bits floating point

```asm
.section
	.data
		.float 1.2345
```

# 7 intel syntax

original (AT&T syntax)

```asm
	.global	_start
	.text
_start:
	movl	$12, %eax
	addl	$34, %eax

	movl	%eax, %ebx
	movl	$1,	%eax
	int	$0x80
```

intel syntax

```asm
	.intel_syntax noprefix
	.global	_start
	.text

_start:
	mov	eax,	12
	add	eax,	34

	mov	ebx, eax
	mov	eax, 1
	int	0x80
```
