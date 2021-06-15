	.file	"project1.c"
	.text
	.section	.rodata
.LC0:
	.string	"Input a number: "
.LC1:
	.string	"%d"
	.align 8
.LC2:
	.string	"%i is bigger than the number.\n"
	.align 8
.LC3:
	.string	"%i is smaller than the number.\n"
	.align 8
.LC4:
	.string	"You found the number! Play again? (Y/N)"
.LC5:
	.string	" %c"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movb	$89, -9(%rbp)
	jmp	.L2
.L9:
	movl	$0, %edi
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	movl	$10, %edi
	call	generate_random
	movl	%eax, -4(%rbp)
.L8:
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-16(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-16(%rbp), %eax
	movl	-4(%rbp), %edx
	movl	%edx, %esi
	movl	%eax, %edi
	call	compare
	movl	%eax, -8(%rbp)
	cmpl	$1, -8(%rbp)
	jne	.L3
	movl	-16(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L8
.L3:
	cmpl	$-1, -8(%rbp)
	jne	.L5
	movl	-16(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L8
.L5:
	cmpl	$0, -8(%rbp)
	jne	.L8
.L7:
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-9(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movzbl	-9(%rbp), %eax
	cmpb	$89, %al
	je	.L2
	movzbl	-9(%rbp), %eax
	cmpb	$78, %al
	je	.L2
	jmp	.L7
.L2:
	movzbl	-9(%rbp), %eax
	cmpb	$89, %al
	je	.L9
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.globl	generate_random
	.type	generate_random, @function
generate_random:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	-20(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -4(%rbp)
	call	rand@PLT
	cltd
	idivl	-4(%rbp)
	movl	%edx, -8(%rbp)
	movl	-8(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	generate_random, .-generate_random
	.globl	compare
	.type	compare, @function
compare:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jge	.L14
	movl	$-1, %eax
	jmp	.L15
.L14:
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jne	.L16
	movl	$0, %eax
	jmp	.L15
.L16:
	movl	$1, %eax
.L15:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	compare, .-compare
	.ident	"GCC: (Debian 10.2.1-6) 10.2.1 20210110"
	.section	.note.GNU-stack,"",@progbits
