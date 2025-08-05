	.file	"main.c"
	.intel_syntax noprefix
	.text
	.globl	puts
	.type	puts, @function
puts:
	push	ebp
	mov	ebp, esp
	push	ebx
	sub	esp, 20
	call	__x86.get_pc_thunk.bx
	add	ebx, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	sub	esp, 12
	push	DWORD PTR 8[ebp]
	call	strlen@PLT
	add	esp, 16
	mov	DWORD PTR -12[ebp], eax
	sub	esp, 4
	push	DWORD PTR -12[ebp]
	push	DWORD PTR 8[ebp]
	push	1
	call	sys_write@PLT
	add	esp, 16
	mov	ebx, DWORD PTR -4[ebp]
	leave
	ret
	.size	puts, .-puts
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
	mov	ebx, DWORD PTR [esp]
	ret
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
