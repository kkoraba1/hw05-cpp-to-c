	.file	"hw05.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Car: Applying brakes..."
	.text
	.p2align 4
	.type	carBrake, @function
carBrake:
.LFB26:
	.cfi_startproc
	movl	$.LC0, %edi
	jmp	puts
	.cfi_endproc
.LFE26:
	.size	carBrake, .-carBrake
	.section	.rodata.str1.1
.LC1:
	.string	"Car: Pressing gas pedal..."
	.text
	.p2align 4
	.type	carAccel, @function
carAccel:
.LFB25:
	.cfi_startproc
	movl	$.LC1, %edi
	jmp	puts
	.cfi_endproc
.LFE25:
	.size	carAccel, .-carAccel
	.section	.rodata.str1.1
.LC2:
	.string	"Engine started!"
	.text
	.p2align 4
	.globl	startEngine
	.type	startEngine, @function
startEngine:
.LFB22:
	.cfi_startproc
	movl	$.LC2, %edi
	jmp	puts
	.cfi_endproc
.LFE22:
	.size	startEngine, .-startEngine
	.p2align 4
	.globl	accelerate
	.type	accelerate, @function
accelerate:
.LFB23:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L5
	movq	(%rdi), %rax
	testq	%rax, %rax
	je	.L5
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L5:
	ret
	.cfi_endproc
.LFE23:
	.size	accelerate, .-accelerate
	.p2align 4
	.globl	brake
	.type	brake, @function
brake:
.LFB24:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L13
	movq	8(%rdi), %rax
	testq	%rax, %rax
	je	.L13
	jmp	*%rax
	.p2align 4,,10
	.p2align 3
.L13:
	ret
	.cfi_endproc
.LFE24:
	.size	brake, .-brake
	.p2align 4
	.globl	newCar
	.type	newCar, @function
newCar:
.LFB27:
	.cfi_startproc
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	movq	%rdi, %rbp
	movl	$24, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	call	malloc
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L21
	movq	.LC3(%rip), %xmm0
	movhps	.LC4(%rip), %xmm0
	movups	%xmm0, (%rax)
	testq	%rbp, %rbp
	je	.L24
	movq	%rbp, %rdi
	call	strlen
	leaq	1(%rax), %r12
	movq	%r12, %rdi
	call	malloc
	movq	%rax, 16(%rbx)
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L21
	movq	%r12, %rdx
	movq	%rbp, %rsi
	call	memcpy
.L21:
	movq	%rbx, %rax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	.cfi_restore_state
	movq	$0, 16(%rax)
	movq	%rbx, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE27:
	.size	newCar, .-newCar
	.p2align 4
	.globl	remVech
	.type	remVech, @function
remVech:
.LFB28:
	.cfi_startproc
	testq	%rdi, %rdi
	je	.L30
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movq	%rdi, %rbx
	movq	16(%rdi), %rdi
	call	free
	movq	%rbx, %rdi
	popq	%rbx
	.cfi_restore 3
	.cfi_def_cfa_offset 8
	jmp	free
	.p2align 4,,10
	.p2align 3
.L30:
	ret
	.cfi_endproc
.LFE28:
	.size	remVech, .-remVech
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB29:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	xorl	%edi, %edi
	call	newCar
	movq	%rax, %rbx
	movl	$1, %eax
	testq	%rbx, %rbx
	je	.L35
	movl	$.LC2, %edi
	call	puts
	movq	%rbx, %rdi
	call	accelerate
	movq	%rbx, %rdi
	call	brake
	movq	16(%rbx), %rdi
	call	free
	movq	%rbx, %rdi
	call	free
	xorl	%eax, %eax
.L35:
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE29:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
	.quad	carAccel
	.align 8
.LC4:
	.quad	carBrake
	.ident	"GCC: (GNU) 14.2.1 20240801 (Red Hat 14.2.1-1)"
	.section	.note.GNU-stack,"",@progbits
