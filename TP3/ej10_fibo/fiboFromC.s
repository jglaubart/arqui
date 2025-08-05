	.file	"fibo.c"
	.intel_syntax noprefix
	.text
	.globl	fibo
	.type	fibo, @function
fibo:
	push	ebp
	mov	ebp, esp
	sub	esp, 16
	call	__x86.get_pc_thunk.ax
	add	eax, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	cmp	DWORD PTR 8[ebp], 1
	jg	.L2
	mov	eax, DWORD PTR 8[ebp]
	jmp	.L3
.L2:
	mov	DWORD PTR -16[ebp], 0
	mov	DWORD PTR -12[ebp], 1
	mov	DWORD PTR -4[ebp], 2
	jmp	.L4
.L5:
	mov	edx, DWORD PTR -12[ebp]
	mov	eax, DWORD PTR -16[ebp]
	add	eax, edx
	mov	DWORD PTR -8[ebp], eax
	mov	eax, DWORD PTR -12[ebp]
	mov	DWORD PTR -16[ebp], eax
	mov	eax, DWORD PTR -8[ebp]
	mov	DWORD PTR -12[ebp], eax
	add	DWORD PTR -4[ebp], 1
.L4:
	mov	eax, DWORD PTR -4[ebp]
	cmp	eax, DWORD PTR 8[ebp]
	jle	.L5
	mov	eax, DWORD PTR -8[ebp]
.L3:
	leave
	ret
	.size	fibo, .-fibo
	.section	.rodata
.LC0:
	.string	"Fibo(%d) = %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	lea	ecx, 4[esp]
	and	esp, -16
	push	DWORD PTR -4[ecx]
	push	ebp
	mov	ebp, esp
	push	ebx
	push	ecx
	sub	esp, 16
	call	__x86.get_pc_thunk.bx
	add	ebx, OFFSET FLAT:_GLOBAL_OFFSET_TABLE_
	mov	DWORD PTR -12[ebp], 10
	push	DWORD PTR -12[ebp]
	call	fibo
	add	esp, 4
	sub	esp, 4
	push	eax
	push	DWORD PTR -12[ebp]
	lea	eax, .LC0@GOTOFF[ebx]
	push	eax
	call	printf@PLT
	add	esp, 16
	mov	eax, 0
	lea	esp, -8[ebp]
	pop	ecx
	pop	ebx
	pop	ebp
	lea	esp, -4[ecx]
	ret
	.size	main, .-main
	.section	.text.__x86.get_pc_thunk.ax,"axG",@progbits,__x86.get_pc_thunk.ax,comdat
	.globl	__x86.get_pc_thunk.ax
	.hidden	__x86.get_pc_thunk.ax
	.type	__x86.get_pc_thunk.ax, @function
__x86.get_pc_thunk.ax:
	mov	eax, DWORD PTR [esp]
	ret
	.section	.text.__x86.get_pc_thunk.bx,"axG",@progbits,__x86.get_pc_thunk.bx,comdat
	.globl	__x86.get_pc_thunk.bx
	.hidden	__x86.get_pc_thunk.bx
	.type	__x86.get_pc_thunk.bx, @function
__x86.get_pc_thunk.bx:
	mov	ebx, DWORD PTR [esp]
	ret
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
