	.text
	.global	_main

_main:
	b	_main
	b	-4
	b	v

	.data
	.zero	0x08000000
v:	.zero	1
