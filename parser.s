	.file	"parser.c"
	.text
.Ltext0:
	.local	global_scope
	.comm	global_scope,16,16
	.section	.data.rel.local,"aw"
	.align 8
	.type	scopes, @object
	.size	scopes, 8
scopes:
	.quad	global_scope
	.local	locals
	.comm	locals,8,8
	.local	globals
	.comm	globals,8,8
	.text
	.type	enter_scope, @function
enter_scope:
.LFB6:
	.file 1 "parser.c"
	.loc 1 42 31
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.loc 1 43 15
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	.loc 1 44 12
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	.loc 1 45 12
	movq	scopes(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 46 10
	movq	-8(%rbp), %rax
	movq	%rax, scopes(%rip)
	.loc 1 47 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	enter_scope, .-enter_scope
	.type	free_scope, @function
free_scope:
.LFB7:
	.loc 1 50 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 51 13
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 52 8
	jmp	.L3
.L4:
.LBB2:
	.loc 1 54 15
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 55 15
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
	.loc 1 56 5
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
.L3:
.LBE2:
	.loc 1 52 8
	cmpq	$0, -16(%rbp)
	jne	.L4
	.loc 1 58 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	free@PLT
	.loc 1 59 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	free_scope, .-free_scope
	.type	leave_scope, @function
leave_scope:
.LFB8:
	.loc 1 61 31
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	.loc 1 62 10
	movq	scopes(%rip), %rax
	movq	%rax, -8(%rbp)
	.loc 1 63 18
	movq	scopes(%rip), %rax
	movq	(%rax), %rax
	.loc 1 63 10
	movq	%rax, scopes(%rip)
	.loc 1 64 3
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	free_scope
	.loc 1 65 1
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	leave_scope, .-leave_scope
	.type	find_var, @function
find_var:
.LFB9:
	.loc 1 68 46
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
.LBB3:
	.loc 1 69 15
	movq	scopes(%rip), %rax
	movq	%rax, -16(%rbp)
	.loc 1 69 3
	jmp	.L7
.L12:
.LBB4:
	.loc 1 70 26
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	.loc 1 70 5
	jmp	.L8
.L11:
	.loc 1 71 25
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 71 11
	movq	8(%rax), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	equal@PLT
	.loc 1 71 10
	testb	%al, %al
	je	.L9
	.loc 1 72 19
	movq	-8(%rbp), %rax
	movq	8(%rax), %rax
	jmp	.L10
.L9:
	.loc 1 70 51 discriminator 2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -8(%rbp)
.L8:
	.loc 1 70 5 discriminator 1
	cmpq	$0, -8(%rbp)
	jne	.L11
.LBE4:
	.loc 1 69 35 discriminator 2
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -16(%rbp)
.L7:
	.loc 1 69 3 discriminator 1
	cmpq	$0, -16(%rbp)
	jne	.L12
.LBE3:
	.loc 1 76 10
	movl	$0, %eax
.L10:
	.loc 1 77 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	find_var, .-find_var
	.type	push_scope, @function
push_scope:
.LFB10:
	.loc 1 79 39
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 80 18
	movl	$16, %edi
	call	malloc@PLT
	movq	%rax, -8(%rbp)
	.loc 1 81 11
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 82 20
	movq	scopes(%rip), %rax
	movq	8(%rax), %rdx
	.loc 1 82 12
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 83 9
	movq	scopes(%rip), %rax
	.loc 1 83 16
	movq	-8(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 84 10
	movq	-8(%rbp), %rax
	.loc 1 85 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	push_scope, .-push_scope
	.type	new_var, @function
new_var:
.LFB11:
	.loc 1 87 60
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	.loc 1 88 14
	movl	$88, %esi
	movl	$1, %edi
	call	calloc@PLT
	movq	%rax, -8(%rbp)
	.loc 1 89 13
	movq	-8(%rbp), %rax
	movq	-32(%rbp), %rdx
	movq	%rdx, 8(%rax)
	.loc 1 90 20
	movq	-8(%rbp), %rax
	movl	-36(%rbp), %edx
	movl	%edx, 16(%rax)
	.loc 1 91 13
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, 24(%rax)
	.loc 1 92 3
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	push_scope
	.loc 1 93 10
	movq	-8(%rbp), %rax
	.loc 1 94 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	new_var, .-new_var
	.type	new_lvar, @function
new_lvar:
.LFB12:
	.loc 1 96 66
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	.loc 1 97 14
	movl	-36(%rbp), %edx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_var
	movq	%rax, -8(%rbp)
	.loc 1 98 17
	movq	-8(%rbp), %rax
	movb	$1, 32(%rax)
	.loc 1 99 13
	movq	locals(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 100 10
	movq	-8(%rbp), %rax
	movq	%rax, locals(%rip)
	.loc 1 101 10
	movq	-8(%rbp), %rax
	.loc 1 102 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	new_lvar, .-new_lvar
	.type	new_gvar, @function
new_gvar:
.LFB13:
	.loc 1 103 66
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -36(%rbp)
	.loc 1 104 14
	movl	-36(%rbp), %edx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_var
	movq	%rax, -8(%rbp)
	.loc 1 105 13
	movq	globals(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 106 11
	movq	-8(%rbp), %rax
	movq	%rax, globals(%rip)
	.loc 1 107 10
	movq	-8(%rbp), %rax
	.loc 1 108 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	new_gvar, .-new_gvar
	.section	.rodata
.LC0:
	.string	".L..%d"
	.text
	.type	new_unique_name, @function
new_unique_name:
.LFB14:
	.loc 1 110 32
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	.loc 1 112 10
	movl	id.3512(%rip), %eax
	leal	1(%rax), %edx
	movl	%edx, id.3512(%rip)
	movl	%eax, %esi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	format@PLT
	.loc 1 113 1
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	new_unique_name, .-new_unique_name
	.type	new_anon_gvar, @function
new_anon_gvar:
.LFB15:
	.loc 1 115 39
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 116 23
	movl	$0, %eax
	call	new_unique_name
	movq	%rax, -8(%rbp)
	.loc 1 117 38
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	.loc 1 117 10
	movl	%eax, %edx
	movq	-8(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_gvar
	.loc 1 118 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE15:
	.size	new_anon_gvar, .-new_anon_gvar
	.type	new_string_literal, @function
new_string_literal:
.LFB16:
	.loc 1 119 55
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 120 14
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	new_anon_gvar
	movq	%rax, -8(%rbp)
	.loc 1 121 18
	movq	-8(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 122 10
	movq	-8(%rbp), %rax
	.loc 1 123 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE16:
	.size	new_string_literal, .-new_string_literal
	.section	.rodata
.LC1:
	.string	"expected an identifier"
	.text
	.type	get_ident, @function
get_ident:
.LFB17:
	.loc 1 125 48
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 126 10
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 126 6
	cmpl	$35, %eax
	je	.L28
	.loc 1 127 5
	movq	-8(%rbp), %rax
	leaq	.LC1(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	error_tok@PLT
.L28:
	.loc 1 129 31
	movq	-8(%rbp), %rax
	movl	32(%rax), %eax
	.loc 1 129 10
	movslq	%eax, %rdx
	movq	-8(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strndup@PLT
	.loc 1 130 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE17:
	.size	get_ident, .-get_ident
	.section	.rodata
.LC2:
	.string	"expected a number"
	.text
	.type	get_number, @function
get_number:
.LFB18:
	.loc 1 132 41
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 133 10
	movq	-8(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 133 6
	cmpl	$37, %eax
	je	.L31
	.loc 1 134 5
	movq	-8(%rbp), %rax
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	error_tok@PLT
.L31:
	.loc 1 136 13
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	.loc 1 137 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE18:
	.size	get_number, .-get_number
	.type	declspec, @function
declspec:
.LFB19:
	.loc 1 140 61
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 141 7
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movl	$6, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	match@PLT
	.loc 1 141 6
	testb	%al, %al
	je	.L34
	.loc 1 142 12
	movl	$0, %eax
	call	char_type@PLT
	jmp	.L35
.L34:
	.loc 1 144 11
	movq	-16(%rbp), %rax
	movl	$5, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 144 9
	movq	-8(%rbp), %rdx
	movq	%rax, (%rdx)
	.loc 1 145 10
	movl	$0, %eax
	call	int_type@PLT
.L35:
	.loc 1 146 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE19:
	.size	declspec, .-declspec
	.type	func_params, @function
func_params:
.LFB20:
	.loc 1 151 45
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%rdx, -120(%rbp)
	.loc 1 151 45
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 152 8
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -16(%rbp)
	.loc 1 153 9
	leaq	-64(%rbp), %rax
	movq	%rax, -96(%rbp)
	.loc 1 155 9
	jmp	.L37
.L39:
.LBB5:
	.loc 1 156 8
	leaq	-64(%rbp), %rax
	cmpq	%rax, -96(%rbp)
	je	.L38
	.loc 1 157 13
	movq	-112(%rbp), %rax
	movl	$15, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 157 11
	movq	%rax, -112(%rbp)
.L38:
	.loc 1 160 23
	movq	-112(%rbp), %rdx
	leaq	-112(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	declspec
	movq	%rax, -80(%rbp)
	.loc 1 161 18
	movq	-112(%rbp), %rcx
	movq	-80(%rbp), %rdx
	leaq	-112(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	declarator
	movq	%rax, -72(%rbp)
	.loc 1 162 21
	movq	-96(%rbp), %rax
	movq	-72(%rbp), %rdx
	movq	%rdx, 48(%rax)
	.loc 1 162 9
	movq	-96(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -96(%rbp)
.L37:
.LBE5:
	.loc 1 155 11
	movq	-112(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 155 10
	xorl	$1, %eax
	.loc 1 155 9
	testb	%al, %al
	jne	.L39
	.loc 1 165 16
	movq	-120(%rbp), %rax
	movq	%rax, %rdi
	call	func_type@PLT
	movq	%rax, -88(%rbp)
	.loc 1 166 22
	movq	-16(%rbp), %rdx
	.loc 1 166 16
	movq	-88(%rbp), %rax
	movq	%rdx, 40(%rax)
	.loc 1 167 14
	movq	-112(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 167 9
	movq	-104(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 168 10
	movq	-88(%rbp), %rax
	.loc 1 169 1
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L41
	call	__stack_chk_fail@PLT
.L41:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE20:
	.size	func_params, .-func_params
	.type	type_suffix, @function
type_suffix:
.LFB21:
	.loc 1 174 76
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	.loc 1 175 7
	movq	-32(%rbp), %rax
	movl	$11, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 175 6
	testb	%al, %al
	je	.L43
	.loc 1 176 33
	movq	-32(%rbp), %rax
	movq	8(%rax), %rcx
	.loc 1 176 12
	movq	-40(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	func_params
	jmp	.L44
.L43:
	.loc 1 178 7
	movq	-32(%rbp), %rax
	movl	$9, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 178 6
	testb	%al, %al
	je	.L45
.LBB6:
	.loc 1 179 37
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 179 23
	movq	%rax, %rdi
	call	get_number
	movl	%eax, -4(%rbp)
	.loc 1 180 22
	movq	-32(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 180 28
	movq	8(%rax), %rax
	.loc 1 180 11
	movl	$10, %esi
	movq	%rax, %rdi
	call	consume@PLT
	movq	%rax, -32(%rbp)
	.loc 1 181 12
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	type_suffix
	movq	%rax, -40(%rbp)
	.loc 1 182 12
	movl	-4(%rbp), %edx
	movq	-40(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	array_of@PLT
	jmp	.L44
.L45:
.LBE6:
	.loc 1 185 9
	movq	-24(%rbp), %rax
	movq	-32(%rbp), %rdx
	movq	%rdx, (%rax)
	.loc 1 186 10
	movq	-40(%rbp), %rax
.L44:
	.loc 1 187 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE21:
	.size	type_suffix, .-type_suffix
	.section	.rodata
.LC3:
	.string	"expected a variable name"
	.text
	.type	declarator, @function
declarator:
.LFB22:
	.loc 1 190 75
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	.loc 1 191 9
	jmp	.L47
.L48:
	.loc 1 192 12
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	pointer_to@PLT
	movq	%rax, -24(%rbp)
.L47:
	.loc 1 191 10
	movq	-16(%rbp), %rcx
	leaq	-16(%rbp), %rax
	movl	$21, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	match@PLT
	.loc 1 191 9
	testb	%al, %al
	jne	.L48
	.loc 1 195 10
	movq	-16(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 195 6
	cmpl	$35, %eax
	je	.L49
	.loc 1 196 5
	movq	-16(%rbp), %rax
	leaq	.LC3(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	error_tok@PLT
.L49:
	.loc 1 198 31
	movq	-16(%rbp), %rax
	movq	8(%rax), %rcx
	.loc 1 198 10
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	type_suffix
	movq	%rax, -24(%rbp)
	.loc 1 199 14
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, 24(%rax)
	.loc 1 200 10
	movq	-24(%rbp), %rax
	.loc 1 201 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE22:
	.size	declarator, .-declarator
	.type	declaration, @function
declaration:
.LFB23:
	.loc 1 205 69
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$152, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -152(%rbp)
	movq	%rsi, -160(%rbp)
	.loc 1 205 69
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	.loc 1 206 21
	movq	-160(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	declspec
	movq	%rax, -120(%rbp)
	.loc 1 208 8
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	.loc 1 209 9
	leaq	-64(%rbp), %rax
	movq	%rax, -128(%rbp)
	.loc 1 210 7
	movl	$0, -132(%rbp)
	.loc 1 212 9
	jmp	.L52
.L55:
.LBB7:
	.loc 1 213 10
	movl	-132(%rbp), %eax
	leal	1(%rax), %edx
	movl	%edx, -132(%rbp)
	.loc 1 213 8
	testl	%eax, %eax
	jle	.L53
	.loc 1 214 13
	movq	-160(%rbp), %rax
	movl	$15, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 214 11
	movq	%rax, -160(%rbp)
.L53:
	.loc 1 216 18
	movq	-160(%rbp), %rcx
	movq	-120(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	declarator
	movq	%rax, -104(%rbp)
	.loc 1 217 58
	movq	-104(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 217 16
	movl	32(%rax), %ebx
	.loc 1 217 45
	movq	-104(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 217 16
	movq	%rax, %rdi
	call	get_ident
	movq	%rax, %rcx
	movq	-104(%rbp), %rax
	movl	%ebx, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_lvar
	movq	%rax, -96(%rbp)
	.loc 1 219 10
	movq	-160(%rbp), %rax
	movl	$27, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 219 9
	xorl	$1, %eax
	.loc 1 219 8
	testb	%al, %al
	je	.L54
	.loc 1 220 7
	jmp	.L52
.L54:
	.loc 1 222 39
	movq	-104(%rbp), %rax
	movq	24(%rax), %rdx
	.loc 1 222 17
	movq	-96(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	new_var_node@PLT
	movq	%rax, -88(%rbp)
	.loc 1 223 33
	movq	-160(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 223 17
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	assign
	movq	%rax, -80(%rbp)
	.loc 1 224 18
	movq	-160(%rbp), %rcx
	movq	-80(%rbp), %rdx
	movq	-88(%rbp), %rax
	movq	%rax, %rsi
	movl	$8, %edi
	call	new_binary_node@PLT
	movq	%rax, -72(%rbp)
	.loc 1 225 23
	movq	-160(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rax, %rsi
	movl	$3, %edi
	call	new_unary_node@PLT
	.loc 1 225 21
	movq	-128(%rbp), %rdx
	movq	%rax, 8(%rdx)
	.loc 1 225 9
	movq	-128(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -128(%rbp)
.L52:
.LBE7:
	.loc 1 212 11
	movq	-160(%rbp), %rax
	movl	$19, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 212 10
	xorl	$1, %eax
	.loc 1 212 9
	testb	%al, %al
	jne	.L55
	.loc 1 228 21
	movq	-160(%rbp), %rdx
	movq	-56(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	new_block_node@PLT
	movq	%rax, -112(%rbp)
	.loc 1 229 14
	movq	-160(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 229 9
	movq	-152(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 230 10
	movq	-112(%rbp), %rax
	.loc 1 231 1
	movq	-24(%rbp), %rbx
	xorq	%fs:40, %rbx
	je	.L57
	call	__stack_chk_fail@PLT
.L57:
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE23:
	.size	declaration, .-declaration
	.type	is_typename, @function
is_typename:
.LFB24:
	.loc 1 234 43
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	.loc 1 235 10
	movq	-8(%rbp), %rax
	movl	$6, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 235 33
	testb	%al, %al
	jne	.L59
	.loc 1 235 36 discriminator 2
	movq	-8(%rbp), %rax
	movl	$5, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 235 33 discriminator 2
	testb	%al, %al
	je	.L60
.L59:
	.loc 1 235 33 is_stmt 0 discriminator 3
	movl	$1, %eax
	jmp	.L61
.L60:
	.loc 1 235 33 discriminator 4
	movl	$0, %eax
.L61:
	.loc 1 235 33 discriminator 6
	andl	$1, %eax
	.loc 1 236 1 is_stmt 1 discriminator 6
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE24:
	.size	is_typename, .-is_typename
	.type	stmt, @function
stmt:
.LFB25:
	.loc 1 244 57
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$152, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -152(%rbp)
	movq	%rsi, -160(%rbp)
	.loc 1 245 7
	movq	-160(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 245 6
	testb	%al, %al
	je	.L64
.LBB8:
	.loc 1 246 18
	movq	-160(%rbp), %rbx
	.loc 1 246 60
	movq	-160(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 246 18
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rbx, %rdx
	movq	%rax, %rsi
	movl	$5, %edi
	call	new_unary_node@PLT
	movq	%rax, -24(%rbp)
	.loc 1 247 13
	movq	-160(%rbp), %rax
	movl	$19, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 247 11
	movq	-152(%rbp), %rdx
	movq	%rax, (%rdx)
	.loc 1 248 12
	movq	-24(%rbp), %rax
	jmp	.L65
.L64:
.LBE8:
	.loc 1 251 7
	movq	-160(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 251 6
	testb	%al, %al
	je	.L66
.LBB9:
	.loc 1 252 18
	movq	-160(%rbp), %rax
	movq	%rax, -56(%rbp)
	.loc 1 253 22
	movq	-160(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 253 11
	movl	$11, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 253 9
	movq	%rax, -160(%rbp)
	.loc 1 254 23
	movq	-160(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rax, -48(%rbp)
	.loc 1 255 11
	movq	-160(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 255 9
	movq	%rax, -160(%rbp)
	.loc 1 256 23
	movq	-160(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stmt
	movq	%rax, -40(%rbp)
	.loc 1 258 9
	movq	-160(%rbp), %rax
	movl	$2, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 258 8
	testb	%al, %al
	je	.L67
	.loc 1 259 33
	movq	-160(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 259 19
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stmt
	movq	%rax, -144(%rbp)
	jmp	.L68
.L67:
	.loc 1 261 17
	movq	$0, -144(%rbp)
.L68:
	.loc 1 264 18
	movq	-56(%rbp), %rcx
	movq	-144(%rbp), %rdx
	movq	-40(%rbp), %rsi
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	new_if_node@PLT
	movq	%rax, -32(%rbp)
	.loc 1 266 11
	movq	-160(%rbp), %rdx
	movq	-152(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 267 12
	movq	-32(%rbp), %rax
	jmp	.L65
.L66:
.LBE9:
	.loc 1 269 7
	movq	-160(%rbp), %rax
	movl	$3, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 269 6
	testb	%al, %al
	je	.L69
.LBB10:
	.loc 1 270 18
	movq	-160(%rbp), %rax
	movq	%rax, -88(%rbp)
	.loc 1 272 22
	movq	-160(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 272 11
	movl	$11, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 272 9
	movq	%rax, -160(%rbp)
	.loc 1 274 23
	movq	-160(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr_stmt
	movq	%rax, -80(%rbp)
	.loc 1 276 10
	movq	-160(%rbp), %rax
	movl	$19, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 276 9
	xorl	$1, %eax
	.loc 1 276 8
	testb	%al, %al
	je	.L70
	.loc 1 277 19
	movq	-160(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rax, -136(%rbp)
	jmp	.L71
.L70:
	.loc 1 279 17
	movq	$0, -136(%rbp)
.L71:
	.loc 1 281 11
	movq	-160(%rbp), %rax
	movl	$19, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 281 9
	movq	%rax, -160(%rbp)
	.loc 1 284 10
	movq	-160(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 284 9
	xorl	$1, %eax
	.loc 1 284 8
	testb	%al, %al
	je	.L72
	.loc 1 285 18
	movq	-160(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rax, -128(%rbp)
	jmp	.L73
.L72:
	.loc 1 287 16
	movq	$0, -128(%rbp)
.L73:
	.loc 1 288 11
	movq	-160(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 288 9
	movq	%rax, -160(%rbp)
	.loc 1 290 23
	movq	-160(%rbp), %rdx
	movq	-152(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stmt
	movq	%rax, -72(%rbp)
	.loc 1 292 18
	movq	-88(%rbp), %rdi
	movq	-72(%rbp), %rcx
	movq	-128(%rbp), %rdx
	movq	-136(%rbp), %rsi
	movq	-80(%rbp), %rax
	movq	%rdi, %r8
	movq	%rax, %rdi
	call	new_for_node@PLT
	movq	%rax, -64(%rbp)
	.loc 1 293 12
	movq	-64(%rbp), %rax
	jmp	.L65
.L69:
.LBE10:
	.loc 1 295 7
	movq	-160(%rbp), %rax
	movl	$4, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 295 6
	testb	%al, %al
	je	.L74
.LBB11:
	.loc 1 296 18
	movq	-160(%rbp), %rax
	movq	%rax, -120(%rbp)
	.loc 1 298 22
	movq	-160(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 298 11
	movl	$11, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 298 9
	movq	%rax, -160(%rbp)
	.loc 1 299 23
	movq	-160(%rbp), %rdx
	leaq	-160(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rax, -112(%rbp)
	.loc 1 300 11
	movq	-160(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 300 9
	movq	%rax, -160(%rbp)
	.loc 1 301 23
	movq	-160(%rbp), %rdx
	movq	-152(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stmt
	movq	%rax, -104(%rbp)
	.loc 1 303 18
	movq	-120(%rbp), %rcx
	movq	-104(%rbp), %rdx
	movq	-112(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movl	$0, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	new_for_node@PLT
	movq	%rax, -96(%rbp)
	.loc 1 304 12
	movq	-96(%rbp), %rax
	jmp	.L65
.L74:
.LBE11:
	.loc 1 307 7
	movq	-160(%rbp), %rax
	movl	$13, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 307 6
	testb	%al, %al
	je	.L75
	.loc 1 308 43
	movq	-160(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 308 20
	movq	-152(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compound_stmt
	.loc 1 308 12
	jmp	.L65
.L75:
	.loc 1 311 10
	movq	-160(%rbp), %rdx
	movq	-152(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr_stmt
.L65:
	.loc 1 312 1
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE25:
	.size	stmt, .-stmt
	.type	compound_stmt, @function
compound_stmt:
.LFB26:
	.loc 1 315 71
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	.loc 1 315 71
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 316 8
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	.loc 1 317 9
	leaq	-48(%rbp), %rax
	movq	%rax, -64(%rbp)
	.loc 1 319 3
	call	enter_scope
	.loc 1 321 9
	jmp	.L77
.L80:
	.loc 1 322 9
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	is_typename
	.loc 1 322 8
	testb	%al, %al
	je	.L78
	.loc 1 323 33
	movq	-80(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	declaration
	.loc 1 323 23
	movq	-64(%rbp), %rdx
	movq	%rax, 8(%rdx)
	.loc 1 323 11
	movq	-64(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -64(%rbp)
	jmp	.L79
.L78:
	.loc 1 325 25
	movq	-80(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	stmt
	.loc 1 325 23
	movq	-64(%rbp), %rdx
	movq	%rax, 8(%rdx)
	.loc 1 325 11
	movq	-64(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -64(%rbp)
.L79:
	.loc 1 327 5
	movq	-64(%rbp), %rax
	movq	%rax, %rdi
	call	add_type@PLT
.L77:
	.loc 1 321 11
	movq	-80(%rbp), %rax
	movl	$14, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 321 10
	xorl	$1, %eax
	.loc 1 321 9
	testb	%al, %al
	jne	.L80
	.loc 1 330 3
	call	leave_scope
	.loc 1 332 21
	movq	-80(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	new_block_node@PLT
	movq	%rax, -56(%rbp)
	.loc 1 333 14
	movq	-80(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 333 9
	movq	-72(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 334 10
	movq	-56(%rbp), %rax
	.loc 1 335 1
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L82
	call	__stack_chk_fail@PLT
.L82:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE26:
	.size	compound_stmt, .-compound_stmt
	.type	expr_stmt, @function
expr_stmt:
.LFB27:
	.loc 1 338 62
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 339 7
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movl	$19, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	match@PLT
	.loc 1 339 6
	testb	%al, %al
	je	.L84
	.loc 1 341 20
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	new_block_node@PLT
	.loc 1 341 12
	jmp	.L85
.L84:
	.loc 1 343 16
	movq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 345 16
	movq	-32(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rax, -8(%rbp)
	.loc 1 346 10
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	movl	$3, %edi
	call	new_unary_node@PLT
	movq	%rax, -8(%rbp)
	.loc 1 347 11
	movq	-32(%rbp), %rax
	movl	$19, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 347 9
	movq	-24(%rbp), %rdx
	movq	%rax, (%rdx)
	.loc 1 348 10
	movq	-8(%rbp), %rax
.L85:
	.loc 1 349 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE27:
	.size	expr_stmt, .-expr_stmt
	.type	expr, @function
expr:
.LFB28:
	.loc 1 352 57
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 353 10
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	assign
	.loc 1 354 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE28:
	.size	expr, .-expr
	.type	assign, @function
assign:
.LFB29:
	.loc 1 357 59
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	.loc 1 358 16
	movq	-48(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	equality
	movq	%rax, -24(%rbp)
	.loc 1 359 7
	movq	-48(%rbp), %rax
	movl	$27, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 359 6
	testb	%al, %al
	je	.L89
	.loc 1 360 12
	movq	-48(%rbp), %rbx
	.loc 1 360 63
	movq	-48(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 360 12
	movq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	assign
	movq	%rax, %rdx
	movq	-24(%rbp), %rax
	movq	%rbx, %rcx
	movq	%rax, %rsi
	movl	$8, %edi
	call	new_binary_node@PLT
	jmp	.L90
.L89:
	.loc 1 361 9
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 362 10
	movq	-24(%rbp), %rax
.L90:
	.loc 1 363 1
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	assign, .-assign
	.type	equality, @function
equality:
.LFB30:
	.loc 1 366 61
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 367 16
	movq	-32(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	comparison
	movq	%rax, -16(%rbp)
.L96:
.LBB12:
	.loc 1 370 18
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 371 9
	movq	-32(%rbp), %rax
	movl	$28, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 371 8
	testb	%al, %al
	je	.L92
	.loc 1 372 65
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 372 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	comparison
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$4, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 373 7
	jmp	.L93
.L92:
	.loc 1 376 9
	movq	-32(%rbp), %rax
	movl	$26, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 376 8
	testb	%al, %al
	je	.L94
	.loc 1 377 65
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 377 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	comparison
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$5, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 378 7
	jmp	.L93
.L94:
	.loc 1 381 11
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 382 12
	movq	-16(%rbp), %rax
	jmp	.L97
.L93:
.LBE12:
	.loc 1 369 12
	jmp	.L96
.L97:
	.loc 1 384 1 discriminator 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE30:
	.size	equality, .-equality
	.type	comparison, @function
comparison:
.LFB31:
	.loc 1 387 63
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 388 16
	movq	-32(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	term
	movq	%rax, -16(%rbp)
.L105:
.LBB13:
	.loc 1 391 18
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 392 9
	movq	-32(%rbp), %rax
	movl	$31, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 392 8
	testb	%al, %al
	je	.L99
	.loc 1 393 59
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 393 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	term
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$6, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 394 7
	jmp	.L100
.L99:
	.loc 1 397 9
	movq	-32(%rbp), %rax
	movl	$32, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 397 8
	testb	%al, %al
	je	.L101
	.loc 1 398 59
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 398 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	term
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$7, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 399 7
	jmp	.L100
.L101:
	.loc 1 402 9
	movq	-32(%rbp), %rax
	movl	$29, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 402 8
	testb	%al, %al
	je	.L102
	.loc 1 403 53
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 403 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	term
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$6, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 404 7
	jmp	.L100
.L102:
	.loc 1 407 9
	movq	-32(%rbp), %rax
	movl	$30, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 407 8
	testb	%al, %al
	je	.L103
	.loc 1 408 53
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 408 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	term
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rax, %rdx
	movl	$7, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 409 7
	jmp	.L100
.L103:
	.loc 1 412 11
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 413 12
	movq	-16(%rbp), %rax
	jmp	.L106
.L100:
.LBE13:
	.loc 1 390 12
	jmp	.L105
.L106:
	.loc 1 415 1 discriminator 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE31:
	.size	comparison, .-comparison
	.section	.rodata
.LC4:
	.string	"invalid operands"
	.text
	.type	new_add, @function
new_add:
.LFB32:
	.loc 1 422 62
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	.loc 1 423 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	add_type@PLT
	.loc 1 424 3
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	add_type@PLT
	.loc 1 427 21
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 427 7
	movq	%rax, %rdi
	call	is_integer@PLT
	.loc 1 427 6
	testb	%al, %al
	je	.L108
	.loc 1 427 46 discriminator 1
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 427 32 discriminator 1
	movq	%rax, %rdi
	call	is_integer@PLT
	.loc 1 427 29 discriminator 1
	testb	%al, %al
	je	.L108
	.loc 1 428 12
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	new_binary_node@PLT
	jmp	.L109
.L108:
	.loc 1 430 10
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 430 16
	movq	16(%rax), %rax
	.loc 1 430 6
	testq	%rax, %rax
	je	.L110
	.loc 1 430 29 discriminator 1
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 430 35 discriminator 1
	movq	16(%rax), %rax
	.loc 1 430 23 discriminator 1
	testq	%rax, %rax
	je	.L110
	.loc 1 431 5
	movq	-40(%rbp), %rax
	leaq	.LC4(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	error_tok@PLT
.L110:
	.loc 1 434 11
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 434 17
	movq	16(%rax), %rax
	.loc 1 434 6
	testq	%rax, %rax
	jne	.L111
	.loc 1 434 30 discriminator 1
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 434 36 discriminator 1
	movq	16(%rax), %rax
	.loc 1 434 24 discriminator 1
	testq	%rax, %rax
	je	.L111
.LBB14:
	.loc 1 435 11
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 436 9
	movq	-32(%rbp), %rax
	movq	%rax, -24(%rbp)
	.loc 1 437 9
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
.L111:
.LBE14:
	.loc 1 441 56
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 441 62
	movq	16(%rax), %rax
	.loc 1 441 9
	movl	4(%rax), %eax
	movq	-40(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	new_num_node@PLT
	movq	%rax, %rsi
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$2, %edi
	call	new_binary_node@PLT
	movq	%rax, -32(%rbp)
	.loc 1 443 10
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	new_binary_node@PLT
.L109:
	.loc 1 444 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE32:
	.size	new_add, .-new_add
	.type	new_sub, @function
new_sub:
.LFB33:
	.loc 1 447 62
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	.loc 1 448 3
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	add_type@PLT
	.loc 1 449 3
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	add_type@PLT
	.loc 1 452 21
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 452 7
	movq	%rax, %rdi
	call	is_integer@PLT
	.loc 1 452 6
	testb	%al, %al
	je	.L113
	.loc 1 452 46 discriminator 1
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 452 32 discriminator 1
	movq	%rax, %rdi
	call	is_integer@PLT
	.loc 1 452 29 discriminator 1
	testb	%al, %al
	je	.L113
	.loc 1 453 12
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	new_binary_node@PLT
	jmp	.L114
.L113:
	.loc 1 456 10
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 456 16
	movq	16(%rax), %rax
	.loc 1 456 6
	testq	%rax, %rax
	je	.L115
	.loc 1 456 40 discriminator 1
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 456 26 discriminator 1
	movq	%rax, %rdi
	call	is_integer@PLT
	.loc 1 456 23 discriminator 1
	testb	%al, %al
	je	.L115
.LBB15:
	.loc 1 458 56
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 458 62
	movq	16(%rax), %rax
	.loc 1 458 9
	movl	4(%rax), %eax
	movq	-40(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	new_num_node@PLT
	movq	%rax, %rsi
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$2, %edi
	call	new_binary_node@PLT
	movq	%rax, -32(%rbp)
	.loc 1 460 5
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	add_type@PLT
	.loc 1 461 18
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 462 21
	movq	-24(%rbp), %rax
	movq	16(%rax), %rdx
	.loc 1 462 16
	movq	-16(%rbp), %rax
	movq	%rdx, 16(%rax)
	.loc 1 463 12
	movq	-16(%rbp), %rax
	jmp	.L114
.L115:
.LBE15:
	.loc 1 467 10
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 467 16
	movq	16(%rax), %rax
	.loc 1 467 6
	testq	%rax, %rax
	je	.L116
	.loc 1 467 29 discriminator 1
	movq	-32(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 467 35 discriminator 1
	movq	16(%rax), %rax
	.loc 1 467 23 discriminator 1
	testq	%rax, %rax
	je	.L116
.LBB16:
	.loc 1 468 18
	movq	-40(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	new_binary_node@PLT
	movq	%rax, -8(%rbp)
	.loc 1 469 18
	movl	$0, %eax
	call	int_type@PLT
	.loc 1 469 16
	movq	-8(%rbp), %rdx
	movq	%rax, 16(%rdx)
	.loc 1 473 44
	movq	-24(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 473 50
	movq	16(%rax), %rax
	.loc 1 472 12
	movl	4(%rax), %eax
	movq	-40(%rbp), %rdx
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	new_num_node@PLT
	movq	%rax, %rsi
	movq	-40(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$3, %edi
	call	new_binary_node@PLT
	jmp	.L114
.L116:
.LBE16:
	.loc 1 476 3
	movq	-40(%rbp), %rax
	leaq	.LC4(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	error_tok@PLT
	.loc 1 477 10
	movl	$0, %eax
.L114:
	.loc 1 478 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE33:
	.size	new_sub, .-new_sub
	.type	term, @function
term:
.LFB34:
	.loc 1 481 57
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 482 16
	movq	-32(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	factor
	movq	%rax, -16(%rbp)
.L122:
.LBB17:
	.loc 1 485 18
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 487 9
	movq	-32(%rbp), %rax
	movl	$18, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 487 8
	testb	%al, %al
	je	.L118
	.loc 1 488 44
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 488 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	factor
	movq	%rax, %rcx
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_add
	movq	%rax, -16(%rbp)
	.loc 1 489 7
	jmp	.L119
.L118:
	.loc 1 492 9
	movq	-32(%rbp), %rax
	movl	$17, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 492 8
	testb	%al, %al
	je	.L120
	.loc 1 493 44
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 493 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	factor
	movq	%rax, %rcx
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_sub
	movq	%rax, -16(%rbp)
	.loc 1 494 7
	jmp	.L119
.L120:
	.loc 1 497 11
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 498 12
	movq	-16(%rbp), %rax
	jmp	.L123
.L119:
.LBE17:
	.loc 1 484 12
	jmp	.L122
.L123:
	.loc 1 500 1 discriminator 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE34:
	.size	term, .-term
	.type	factor, @function
factor:
.LFB35:
	.loc 1 503 59
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	.loc 1 504 16
	movq	-32(%rbp), %rdx
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	movq	%rax, -16(%rbp)
.L129:
.LBB18:
	.loc 1 507 18
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	.loc 1 508 9
	movq	-32(%rbp), %rax
	movl	$21, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 508 8
	testb	%al, %al
	je	.L125
	.loc 1 509 61
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 509 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$2, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 510 7
	jmp	.L126
.L125:
	.loc 1 513 9
	movq	-32(%rbp), %rax
	movl	$20, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 513 8
	testb	%al, %al
	je	.L127
	.loc 1 514 61
	movq	-32(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 514 14
	leaq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	movq	%rax, %rsi
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rax, %rsi
	movl	$3, %edi
	call	new_binary_node@PLT
	movq	%rax, -16(%rbp)
	.loc 1 515 7
	jmp	.L126
.L127:
	.loc 1 518 11
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 519 12
	movq	-16(%rbp), %rax
	jmp	.L130
.L126:
.LBE18:
	.loc 1 506 12
	jmp	.L129
.L130:
	.loc 1 521 1 discriminator 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE35:
	.size	factor, .-factor
	.type	unary, @function
unary:
.LFB36:
	.loc 1 525 58
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	.loc 1 526 7
	movq	-16(%rbp), %rax
	movl	$18, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 526 6
	testb	%al, %al
	je	.L132
	.loc 1 527 27
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 527 12
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	jmp	.L133
.L132:
	.loc 1 529 7
	movq	-16(%rbp), %rax
	movl	$17, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 529 6
	testb	%al, %al
	je	.L134
	.loc 1 530 52
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 530 12
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$0, %edi
	call	new_unary_node@PLT
	jmp	.L133
.L134:
	.loc 1 531 7
	movq	-16(%rbp), %rax
	movl	$24, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 531 6
	testb	%al, %al
	je	.L135
	.loc 1 532 53
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 532 12
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$1, %edi
	call	new_unary_node@PLT
	jmp	.L133
.L135:
	.loc 1 533 7
	movq	-16(%rbp), %rax
	movl	$21, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 533 6
	testb	%al, %al
	je	.L136
	.loc 1 534 54
	movq	-16(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 534 12
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$2, %edi
	call	new_unary_node@PLT
	jmp	.L133
.L136:
	.loc 1 536 10
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	postfix
.L133:
	.loc 1 537 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE36:
	.size	unary, .-unary
	.type	postfix, @function
postfix:
.LFB37:
	.loc 1 540 60
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	.loc 1 541 16
	movq	-48(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	primary
	movq	%rax, -24(%rbp)
	.loc 1 543 9
	jmp	.L138
.L139:
.LBB19:
	.loc 1 545 18
	movq	-48(%rbp), %rax
	movq	%rax, -16(%rbp)
	.loc 1 546 31
	movq	-48(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 546 17
	leaq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rax, -8(%rbp)
	.loc 1 547 11
	movq	-48(%rbp), %rax
	movl	$10, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 547 9
	movq	%rax, -48(%rbp)
	.loc 1 548 12
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_add
	movq	%rax, %rcx
	movq	-16(%rbp), %rax
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movl	$2, %edi
	call	new_unary_node@PLT
	movq	%rax, -24(%rbp)
.L138:
.LBE19:
	.loc 1 543 10
	movq	-48(%rbp), %rax
	movl	$9, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 543 9
	testb	%al, %al
	jne	.L139
	.loc 1 550 9
	movq	-48(%rbp), %rdx
	movq	-40(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 551 10
	movq	-24(%rbp), %rax
	.loc 1 552 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE37:
	.size	postfix, .-postfix
	.type	funcall, @function
funcall:
.LFB38:
	.loc 1 555 60
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$96, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	.loc 1 555 60
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	.loc 1 556 16
	movq	-112(%rbp), %rax
	movq	%rax, -80(%rbp)
	.loc 1 557 12
	movq	-112(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 557 18
	movq	8(%rax), %rax
	.loc 1 557 7
	movq	%rax, -112(%rbp)
	.loc 1 559 8
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	.loc 1 560 9
	leaq	-64(%rbp), %rax
	movq	%rax, -88(%rbp)
	.loc 1 562 9
	jmp	.L142
.L144:
	.loc 1 563 8
	leaq	-64(%rbp), %rax
	cmpq	%rax, -88(%rbp)
	je	.L143
	.loc 1 564 13
	movq	-112(%rbp), %rax
	movl	$15, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 564 11
	movq	%rax, -112(%rbp)
.L143:
	.loc 1 565 23
	movq	-112(%rbp), %rdx
	leaq	-112(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	assign
	.loc 1 565 21
	movq	-88(%rbp), %rdx
	movq	%rax, 8(%rdx)
	.loc 1 565 9
	movq	-88(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -88(%rbp)
.L142:
	.loc 1 562 11
	movq	-112(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 562 10
	xorl	$1, %eax
	.loc 1 562 9
	testb	%al, %al
	jne	.L144
	.loc 1 568 11
	movq	-112(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 568 9
	movq	-104(%rbp), %rdx
	movq	%rax, (%rdx)
	.loc 1 570 16
	movq	-56(%rbp), %r12
	movq	-80(%rbp), %rax
	movl	32(%rax), %ebx
	.loc 1 570 59
	movq	-80(%rbp), %rax
	movl	32(%rax), %eax
	.loc 1 570 34
	movslq	%eax, %rdx
	movq	-80(%rbp), %rax
	movq	24(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strndup@PLT
	movq	%rax, %rdi
	.loc 1 570 16
	movq	-80(%rbp), %rax
	movq	%rax, %rcx
	movq	%r12, %rdx
	movl	%ebx, %esi
	call	new_fun_call_node@PLT
	movq	%rax, -72(%rbp)
	.loc 1 575 10
	movq	-72(%rbp), %rax
	.loc 1 576 1
	movq	-24(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L146
	call	__stack_chk_fail@PLT
.L146:
	addq	$96, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE38:
	.size	funcall, .-funcall
	.section	.rodata
.LC5:
	.string	"undefined variable"
.LC6:
	.string	"expected an expression"
	.text
	.type	primary, @function
primary:
.LFB39:
	.loc 1 584 60
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	.loc 1 585 7
	movq	-80(%rbp), %rax
	movl	$11, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 585 6
	testb	%al, %al
	je	.L148
	.loc 1 585 48 discriminator 1
	movq	-80(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 585 39 discriminator 1
	movl	$13, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 585 36 discriminator 1
	testb	%al, %al
	je	.L148
.LBB20:
	.loc 1 587 18
	movq	-80(%rbp), %rax
	movq	%rax, -56(%rbp)
	.loc 1 589 52
	movq	-80(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 589 58
	movq	8(%rax), %rdx
	.loc 1 589 29
	leaq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compound_stmt
	movq	%rax, -48(%rbp)
	.loc 1 590 13
	movq	-80(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 590 11
	movq	-72(%rbp), %rdx
	movq	%rax, (%rdx)
	.loc 1 591 12
	movq	-48(%rbp), %rax
	movq	32(%rax), %rax
	movq	-56(%rbp), %rdx
	movq	%rax, %rsi
	movl	$4, %edi
	call	new_unary_node@PLT
	jmp	.L149
.L148:
.LBE20:
	.loc 1 594 7
	movq	-80(%rbp), %rax
	movl	$11, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 594 6
	testb	%al, %al
	je	.L150
.LBB21:
	.loc 1 595 32
	movq	-80(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 595 18
	leaq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	expr
	movq	%rax, -8(%rbp)
	.loc 1 596 13
	movq	-80(%rbp), %rax
	movl	$12, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 596 11
	movq	-72(%rbp), %rdx
	movq	%rax, (%rdx)
	.loc 1 597 12
	movq	-8(%rbp), %rax
	jmp	.L149
.L150:
.LBE21:
	.loc 1 600 7
	movq	-80(%rbp), %rax
	movl	$7, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 600 6
	testb	%al, %al
	je	.L151
.LBB22:
	.loc 1 601 33
	movq	-80(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 601 18
	movq	-72(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	unary
	movq	%rax, -16(%rbp)
	.loc 1 602 5
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	add_type@PLT
	.loc 1 603 12
	movq	-80(%rbp), %rdx
	.loc 1 603 29
	movq	-16(%rbp), %rax
	movq	16(%rax), %rax
	.loc 1 603 12
	movl	4(%rax), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	new_num_node@PLT
	jmp	.L149
.L151:
.LBE22:
	.loc 1 606 7
	movq	-80(%rbp), %rax
	movl	$35, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 606 6
	testb	%al, %al
	je	.L152
.LBB23:
	.loc 1 608 18
	movq	-80(%rbp), %rax
	movq	8(%rax), %rax
	.loc 1 608 9
	movl	$11, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 608 8
	testb	%al, %al
	je	.L153
	.loc 1 609 14
	movq	-80(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	funcall
	jmp	.L149
.L153:
	.loc 1 612 22
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	find_var
	movq	%rax, -24(%rbp)
	.loc 1 613 8
	cmpq	$0, -24(%rbp)
	jne	.L154
	.loc 1 614 7
	movq	-80(%rbp), %rax
	leaq	.LC5(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	error_tok@PLT
.L154:
	.loc 1 616 16
	movq	-80(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 616 11
	movq	-72(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 617 12
	movq	-80(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	new_var_node@PLT
	jmp	.L149
.L152:
.LBE23:
	.loc 1 620 7
	movq	-80(%rbp), %rax
	movl	$36, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 620 6
	testb	%al, %al
	je	.L155
.LBB24:
	.loc 1 621 48
	movq	-80(%rbp), %rax
	movq	40(%rax), %rdx
	.loc 1 621 38
	movq	-80(%rbp), %rax
	.loc 1 621 16
	movq	48(%rax), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	new_string_literal
	movq	%rax, -32(%rbp)
	.loc 1 622 16
	movq	-80(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 622 11
	movq	-72(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 623 12
	movq	-80(%rbp), %rdx
	movq	-32(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	new_var_node@PLT
	jmp	.L149
.L155:
.LBE24:
	.loc 1 626 7
	movq	-80(%rbp), %rax
	movl	$37, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 626 6
	testb	%al, %al
	je	.L156
.LBB25:
	.loc 1 627 18
	movq	-80(%rbp), %rdx
	.loc 1 627 34
	movq	-80(%rbp), %rax
	.loc 1 627 18
	movl	16(%rax), %eax
	movq	%rdx, %rsi
	movl	%eax, %edi
	call	new_num_node@PLT
	movq	%rax, -40(%rbp)
	.loc 1 628 16
	movq	-80(%rbp), %rax
	movq	8(%rax), %rdx
	.loc 1 628 11
	movq	-72(%rbp), %rax
	movq	%rdx, (%rax)
	.loc 1 629 12
	movq	-40(%rbp), %rax
	jmp	.L149
.L156:
.LBE25:
	.loc 1 632 3
	movq	-80(%rbp), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	error_tok@PLT
	.loc 1 633 10
	movl	$0, %eax
.L149:
	.loc 1 634 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE39:
	.size	primary, .-primary
	.type	create_param_lvars, @function
create_param_lvars:
.LFB40:
	.loc 1 636 45
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	.loc 1 637 6
	cmpq	$0, -24(%rbp)
	je	.L159
	.loc 1 638 5
	movq	-24(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, %rdi
	call	create_param_lvars
	.loc 1 639 50
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 639 5
	movl	32(%rax), %ebx
	.loc 1 639 36
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 639 5
	movq	%rax, %rdi
	call	get_ident
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movl	%ebx, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_lvar
.L159:
	.loc 1 641 1
	nop
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	create_param_lvars, .-create_param_lvars
	.type	function, @function
function:
.LFB41:
	.loc 1 643 65
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	.loc 1 644 16
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rdx
	leaq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	declarator
	movq	%rax, -32(%rbp)
	.loc 1 646 55
	movq	-32(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 646 13
	movl	32(%rax), %ebx
	.loc 1 646 42
	movq	-32(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 646 13
	movq	%rax, %rdi
	call	get_ident
	movq	%rax, %rcx
	movq	-32(%rbp), %rax
	movl	%ebx, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_gvar
	movq	%rax, -24(%rbp)
	.loc 1 647 19
	movq	-24(%rbp), %rax
	movb	$1, 40(%rax)
	.loc 1 649 10
	movq	$0, locals(%rip)
	.loc 1 650 3
	call	enter_scope
	.loc 1 651 3
	movq	-32(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, %rdi
	call	create_param_lvars
	.loc 1 652 14
	movq	locals(%rip), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, 56(%rax)
	.loc 1 654 9
	movq	-40(%rbp), %rax
	movl	$13, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 654 7
	movq	%rax, -40(%rbp)
	.loc 1 655 22
	movq	-40(%rbp), %rdx
	leaq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	compound_stmt
	.loc 1 655 12
	movq	-24(%rbp), %rdx
	movq	%rax, 64(%rdx)
	.loc 1 656 14
	movq	locals(%rip), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, 72(%rax)
	.loc 1 657 3
	call	leave_scope
	.loc 1 658 10
	movq	-40(%rbp), %rax
	.loc 1 659 1
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE41:
	.size	function, .-function
	.type	global_variable, @function
global_variable:
.LFB42:
	.loc 1 661 72
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	.loc 1 662 8
	movb	$1, -25(%rbp)
	.loc 1 664 9
	jmp	.L163
.L165:
.LBB26:
	.loc 1 665 9
	movzbl	-25(%rbp), %eax
	xorl	$1, %eax
	.loc 1 665 8
	testb	%al, %al
	je	.L164
	.loc 1 666 13
	movq	-40(%rbp), %rax
	movl	$15, %esi
	movq	%rax, %rdi
	call	consume@PLT
	.loc 1 666 11
	movq	%rax, -40(%rbp)
.L164:
	.loc 1 669 11
	movb	$0, -25(%rbp)
	.loc 1 671 18
	movq	-40(%rbp), %rcx
	movq	-48(%rbp), %rdx
	leaq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	declarator
	movq	%rax, -24(%rbp)
	.loc 1 672 47
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 672 5
	movl	32(%rax), %ebx
	.loc 1 672 34
	movq	-24(%rbp), %rax
	movq	24(%rax), %rax
	.loc 1 672 5
	movq	%rax, %rdi
	call	get_ident
	movq	%rax, %rcx
	movq	-24(%rbp), %rax
	movl	%ebx, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	new_gvar
.L163:
.LBE26:
	.loc 1 664 11
	movq	-40(%rbp), %rcx
	leaq	-40(%rbp), %rax
	movl	$19, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	match@PLT
	.loc 1 664 10
	xorl	$1, %eax
	.loc 1 664 9
	testb	%al, %al
	jne	.L165
	.loc 1 674 10
	movq	-40(%rbp), %rax
	.loc 1 675 1
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE42:
	.size	global_variable, .-global_variable
	.type	is_function, @function
is_function:
.LFB43:
	.loc 1 679 43
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -88(%rbp)
	.loc 1 679 43
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	.loc 1 680 7
	movq	-88(%rbp), %rax
	movl	$19, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 680 6
	testb	%al, %al
	je	.L168
	.loc 1 681 12
	movl	$0, %eax
	jmp	.L170
.L168:
	.loc 1 684 8
	movq	$0, -64(%rbp)
	movq	$0, -56(%rbp)
	movq	$0, -48(%rbp)
	movq	$0, -40(%rbp)
	movq	$0, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -16(%rbp)
	.loc 1 685 16
	movq	-88(%rbp), %rcx
	leaq	-64(%rbp), %rdx
	leaq	-88(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	declarator
	movq	%rax, -72(%rbp)
	.loc 1 686 14
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	.loc 1 686 21
	cmpl	$3, %eax
	sete	%al
.L170:
	.loc 1 687 1 discriminator 1
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L171
	.loc 1 687 1 is_stmt 0
	call	__stack_chk_fail@PLT
.L171:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE43:
	.size	is_function, .-is_function
	.globl	parse
	.type	parse, @function
parse:
.LFB44:
	.loc 1 690 30 is_stmt 1
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	.loc 1 691 11
	movq	$0, globals(%rip)
	.loc 1 693 9
	jmp	.L173
.L175:
.LBB27:
	.loc 1 694 23
	movq	-24(%rbp), %rdx
	leaq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	declspec
	movq	%rax, -8(%rbp)
	.loc 1 697 9
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	is_function
	.loc 1 697 8
	testb	%al, %al
	je	.L174
	.loc 1 698 13
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	function
	.loc 1 698 11
	movq	%rax, -24(%rbp)
	.loc 1 699 7
	jmp	.L173
.L174:
	.loc 1 703 11
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	global_variable
	.loc 1 703 9
	movq	%rax, -24(%rbp)
.L173:
.LBE27:
	.loc 1 693 11
	movq	-24(%rbp), %rax
	movl	$38, %esi
	movq	%rax, %rdi
	call	check@PLT
	.loc 1 693 10
	xorl	$1, %eax
	.loc 1 693 9
	testb	%al, %al
	jne	.L175
	.loc 1 705 10
	movq	globals(%rip), %rax
	.loc 1 706 1
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE44:
	.size	parse, .-parse
	.local	id.3512
	.comm	id.3512,4,4
.Letext0:
	.file 2 "/usr/lib/gcc/x86_64-linux-gnu/9/include/stddef.h"
	.file 3 "tokenizer.h"
	.file 4 "type.h"
	.file 5 "ast_node.h"
	.file 6 "obj.h"
	.file 7 "/usr/include/x86_64-linux-gnu/bits/types.h"
	.file 8 "/usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h"
	.file 9 "/usr/include/x86_64-linux-gnu/bits/types/FILE.h"
	.file 10 "/usr/include/stdio.h"
	.file 11 "/usr/include/x86_64-linux-gnu/bits/sys_errlist.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.long	0x192b
	.value	0x4
	.long	.Ldebug_abbrev0
	.byte	0x8
	.uleb128 0x1
	.long	.LASF210
	.byte	0xc
	.long	.LASF211
	.long	.LASF212
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.long	.Ldebug_line0
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF0
	.uleb128 0x3
	.long	.LASF45
	.byte	0x2
	.byte	0xd1
	.byte	0x17
	.long	0x40
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF1
	.uleb128 0x4
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.byte	0x8
	.byte	0x5
	.long	.LASF2
	.uleb128 0x2
	.byte	0x10
	.byte	0x4
	.long	.LASF3
	.uleb128 0x5
	.byte	0x7
	.byte	0x4
	.long	0x15b
	.byte	0x3
	.byte	0x6
	.byte	0xe
	.long	0x15b
	.uleb128 0x6
	.long	.LASF4
	.byte	0
	.uleb128 0x6
	.long	.LASF5
	.byte	0x1
	.uleb128 0x6
	.long	.LASF6
	.byte	0x2
	.uleb128 0x6
	.long	.LASF7
	.byte	0x3
	.uleb128 0x6
	.long	.LASF8
	.byte	0x4
	.uleb128 0x6
	.long	.LASF9
	.byte	0x5
	.uleb128 0x6
	.long	.LASF10
	.byte	0x6
	.uleb128 0x6
	.long	.LASF11
	.byte	0x7
	.uleb128 0x6
	.long	.LASF12
	.byte	0x8
	.uleb128 0x6
	.long	.LASF13
	.byte	0x9
	.uleb128 0x6
	.long	.LASF14
	.byte	0xa
	.uleb128 0x6
	.long	.LASF15
	.byte	0xb
	.uleb128 0x6
	.long	.LASF16
	.byte	0xc
	.uleb128 0x6
	.long	.LASF17
	.byte	0xd
	.uleb128 0x6
	.long	.LASF18
	.byte	0xe
	.uleb128 0x6
	.long	.LASF19
	.byte	0xf
	.uleb128 0x6
	.long	.LASF20
	.byte	0x10
	.uleb128 0x6
	.long	.LASF21
	.byte	0x11
	.uleb128 0x6
	.long	.LASF22
	.byte	0x12
	.uleb128 0x6
	.long	.LASF23
	.byte	0x13
	.uleb128 0x6
	.long	.LASF24
	.byte	0x14
	.uleb128 0x6
	.long	.LASF25
	.byte	0x15
	.uleb128 0x6
	.long	.LASF26
	.byte	0x16
	.uleb128 0x6
	.long	.LASF27
	.byte	0x17
	.uleb128 0x6
	.long	.LASF28
	.byte	0x18
	.uleb128 0x6
	.long	.LASF29
	.byte	0x19
	.uleb128 0x6
	.long	.LASF30
	.byte	0x1a
	.uleb128 0x6
	.long	.LASF31
	.byte	0x1b
	.uleb128 0x6
	.long	.LASF32
	.byte	0x1c
	.uleb128 0x6
	.long	.LASF33
	.byte	0x1d
	.uleb128 0x6
	.long	.LASF34
	.byte	0x1e
	.uleb128 0x6
	.long	.LASF35
	.byte	0x1f
	.uleb128 0x6
	.long	.LASF36
	.byte	0x20
	.uleb128 0x6
	.long	.LASF37
	.byte	0x21
	.uleb128 0x6
	.long	.LASF38
	.byte	0x22
	.uleb128 0x6
	.long	.LASF39
	.byte	0x23
	.uleb128 0x6
	.long	.LASF40
	.byte	0x24
	.uleb128 0x6
	.long	.LASF41
	.byte	0x25
	.uleb128 0x6
	.long	.LASF42
	.byte	0x26
	.uleb128 0x6
	.long	.LASF43
	.byte	0x27
	.byte	0
	.uleb128 0x2
	.byte	0x4
	.byte	0x7
	.long	.LASF44
	.uleb128 0x3
	.long	.LASF46
	.byte	0x3
	.byte	0x37
	.byte	0x3
	.long	0x5c
	.uleb128 0x3
	.long	.LASF47
	.byte	0x3
	.byte	0x3a
	.byte	0x16
	.long	0x17f
	.uleb128 0x7
	.long	0x16e
	.uleb128 0x8
	.long	.LASF47
	.byte	0x40
	.byte	0x3
	.byte	0x3b
	.byte	0x8
	.long	0x1f5
	.uleb128 0x9
	.long	.LASF48
	.byte	0x3
	.byte	0x3c
	.byte	0xd
	.long	0x162
	.byte	0
	.uleb128 0x9
	.long	.LASF49
	.byte	0x3
	.byte	0x3d
	.byte	0xa
	.long	0x1fa
	.byte	0x8
	.uleb128 0xa
	.string	"val"
	.byte	0x3
	.byte	0x3e
	.byte	0x7
	.long	0x47
	.byte	0x10
	.uleb128 0xa
	.string	"loc"
	.byte	0x3
	.byte	0x3f
	.byte	0xf
	.long	0x200
	.byte	0x18
	.uleb128 0xa
	.string	"len"
	.byte	0x3
	.byte	0x40
	.byte	0x7
	.long	0x47
	.byte	0x20
	.uleb128 0x9
	.long	.LASF50
	.byte	0x3
	.byte	0x41
	.byte	0x10
	.long	0x28d
	.byte	0x28
	.uleb128 0xa
	.string	"str"
	.byte	0x3
	.byte	0x42
	.byte	0x9
	.long	0x293
	.byte	0x30
	.uleb128 0x9
	.long	.LASF51
	.byte	0x3
	.byte	0x44
	.byte	0xa
	.long	0x34
	.byte	0x38
	.byte	0
	.uleb128 0x7
	.long	0x17f
	.uleb128 0xb
	.byte	0x8
	.long	0x16e
	.uleb128 0xb
	.byte	0x8
	.long	0x212
	.uleb128 0x7
	.long	0x200
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF52
	.uleb128 0x7
	.long	0x20b
	.uleb128 0x8
	.long	.LASF53
	.byte	0x38
	.byte	0x4
	.byte	0x10
	.byte	0x8
	.long	0x28d
	.uleb128 0x9
	.long	.LASF48
	.byte	0x4
	.byte	0x11
	.byte	0xc
	.long	0x73c
	.byte	0
	.uleb128 0x9
	.long	.LASF54
	.byte	0x4
	.byte	0x13
	.byte	0x7
	.long	0x47
	.byte	0x4
	.uleb128 0x9
	.long	.LASF55
	.byte	0x4
	.byte	0x16
	.byte	0x7
	.long	0x47
	.byte	0x8
	.uleb128 0x9
	.long	.LASF56
	.byte	0x4
	.byte	0x1f
	.byte	0x9
	.long	0x748
	.byte	0x10
	.uleb128 0x9
	.long	.LASF57
	.byte	0x4
	.byte	0x22
	.byte	0x17
	.long	0x74e
	.byte	0x18
	.uleb128 0x9
	.long	.LASF58
	.byte	0x4
	.byte	0x25
	.byte	0x9
	.long	0x748
	.byte	0x20
	.uleb128 0x9
	.long	.LASF59
	.byte	0x4
	.byte	0x26
	.byte	0x9
	.long	0x748
	.byte	0x28
	.uleb128 0x9
	.long	.LASF49
	.byte	0x4
	.byte	0x27
	.byte	0x9
	.long	0x748
	.byte	0x30
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x217
	.uleb128 0xb
	.byte	0x8
	.long	0x20b
	.uleb128 0x3
	.long	.LASF60
	.byte	0x5
	.byte	0x9
	.byte	0x15
	.long	0x2a5
	.uleb128 0x8
	.long	.LASF60
	.byte	0x20
	.byte	0x5
	.byte	0xa
	.byte	0x8
	.long	0x2e7
	.uleb128 0xa
	.string	"tag"
	.byte	0x5
	.byte	0x14
	.byte	0x5
	.long	0x2e7
	.byte	0
	.uleb128 0x9
	.long	.LASF49
	.byte	0x5
	.byte	0x15
	.byte	0x9
	.long	0x32a
	.byte	0x8
	.uleb128 0x9
	.long	.LASF50
	.byte	0x5
	.byte	0x16
	.byte	0x10
	.long	0x28d
	.byte	0x10
	.uleb128 0xa
	.string	"tok"
	.byte	0x5
	.byte	0x17
	.byte	0x10
	.long	0x330
	.byte	0x18
	.byte	0
	.uleb128 0xc
	.long	.LASF213
	.byte	0x7
	.byte	0x4
	.long	0x15b
	.byte	0x5
	.byte	0xb
	.byte	0x8
	.long	0x32a
	.uleb128 0x6
	.long	.LASF61
	.byte	0
	.uleb128 0x6
	.long	.LASF62
	.byte	0x1
	.uleb128 0x6
	.long	.LASF63
	.byte	0x2
	.uleb128 0x6
	.long	.LASF64
	.byte	0x3
	.uleb128 0x6
	.long	.LASF65
	.byte	0x4
	.uleb128 0x6
	.long	.LASF66
	.byte	0x5
	.uleb128 0x6
	.long	.LASF67
	.byte	0x6
	.uleb128 0x6
	.long	.LASF68
	.byte	0x7
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x299
	.uleb128 0xb
	.byte	0x8
	.long	0x17a
	.uleb128 0x5
	.byte	0x7
	.byte	0x4
	.long	0x15b
	.byte	0x5
	.byte	0x1a
	.byte	0xe
	.long	0x369
	.uleb128 0x6
	.long	.LASF69
	.byte	0
	.uleb128 0x6
	.long	.LASF70
	.byte	0x1
	.uleb128 0x6
	.long	.LASF71
	.byte	0x2
	.uleb128 0x6
	.long	.LASF72
	.byte	0x3
	.uleb128 0x6
	.long	.LASF73
	.byte	0x4
	.uleb128 0x6
	.long	.LASF74
	.byte	0x5
	.byte	0
	.uleb128 0x5
	.byte	0x7
	.byte	0x4
	.long	0x15b
	.byte	0x5
	.byte	0x28
	.byte	0xe
	.long	0x3ae
	.uleb128 0x6
	.long	.LASF75
	.byte	0
	.uleb128 0x6
	.long	.LASF76
	.byte	0x1
	.uleb128 0x6
	.long	.LASF77
	.byte	0x2
	.uleb128 0x6
	.long	.LASF78
	.byte	0x3
	.uleb128 0x6
	.long	.LASF79
	.byte	0x4
	.uleb128 0x6
	.long	.LASF80
	.byte	0x5
	.uleb128 0x6
	.long	.LASF81
	.byte	0x6
	.uleb128 0x6
	.long	.LASF82
	.byte	0x7
	.uleb128 0x6
	.long	.LASF83
	.byte	0x8
	.byte	0
	.uleb128 0x8
	.long	.LASF84
	.byte	0x28
	.byte	0x5
	.byte	0x46
	.byte	0x10
	.long	0x3d6
	.uleb128 0x9
	.long	.LASF85
	.byte	0x5
	.byte	0x47
	.byte	0x8
	.long	0x299
	.byte	0
	.uleb128 0x9
	.long	.LASF86
	.byte	0x5
	.byte	0x48
	.byte	0x9
	.long	0x32a
	.byte	0x20
	.byte	0
	.uleb128 0x3
	.long	.LASF84
	.byte	0x5
	.byte	0x49
	.byte	0x3
	.long	0x3ae
	.uleb128 0xd
	.string	"Obj"
	.byte	0x58
	.byte	0x6
	.byte	0x7
	.byte	0x8
	.long	0x48c
	.uleb128 0x9
	.long	.LASF49
	.byte	0x6
	.byte	0x8
	.byte	0x8
	.long	0x765
	.byte	0
	.uleb128 0x9
	.long	.LASF57
	.byte	0x6
	.byte	0x9
	.byte	0xf
	.long	0x200
	.byte	0x8
	.uleb128 0x9
	.long	.LASF87
	.byte	0x6
	.byte	0xa
	.byte	0x7
	.long	0x47
	.byte	0x10
	.uleb128 0x9
	.long	.LASF50
	.byte	0x6
	.byte	0xb
	.byte	0x10
	.long	0x28d
	.byte	0x18
	.uleb128 0x9
	.long	.LASF88
	.byte	0x6
	.byte	0xc
	.byte	0x8
	.long	0x76b
	.byte	0x20
	.uleb128 0x9
	.long	.LASF89
	.byte	0x6
	.byte	0xf
	.byte	0x7
	.long	0x47
	.byte	0x24
	.uleb128 0x9
	.long	.LASF90
	.byte	0x6
	.byte	0x12
	.byte	0x8
	.long	0x76b
	.byte	0x28
	.uleb128 0x9
	.long	.LASF91
	.byte	0x6
	.byte	0x15
	.byte	0x9
	.long	0x293
	.byte	0x30
	.uleb128 0x9
	.long	.LASF59
	.byte	0x6
	.byte	0x18
	.byte	0x8
	.long	0x765
	.byte	0x38
	.uleb128 0x9
	.long	.LASF86
	.byte	0x6
	.byte	0x19
	.byte	0x10
	.long	0x772
	.byte	0x40
	.uleb128 0x9
	.long	.LASF92
	.byte	0x6
	.byte	0x1a
	.byte	0x8
	.long	0x765
	.byte	0x48
	.uleb128 0x9
	.long	.LASF93
	.byte	0x6
	.byte	0x1b
	.byte	0x7
	.long	0x47
	.byte	0x50
	.byte	0
	.uleb128 0x2
	.byte	0x1
	.byte	0x8
	.long	.LASF94
	.uleb128 0x2
	.byte	0x2
	.byte	0x7
	.long	.LASF95
	.uleb128 0x2
	.byte	0x1
	.byte	0x6
	.long	.LASF96
	.uleb128 0x2
	.byte	0x2
	.byte	0x5
	.long	.LASF97
	.uleb128 0x3
	.long	.LASF98
	.byte	0x7
	.byte	0x98
	.byte	0x19
	.long	0x2d
	.uleb128 0x3
	.long	.LASF99
	.byte	0x7
	.byte	0x99
	.byte	0x1b
	.long	0x2d
	.uleb128 0xe
	.byte	0x8
	.uleb128 0x2
	.byte	0x8
	.byte	0x7
	.long	.LASF100
	.uleb128 0x8
	.long	.LASF101
	.byte	0xd8
	.byte	0x8
	.byte	0x31
	.byte	0x8
	.long	0x650
	.uleb128 0x9
	.long	.LASF102
	.byte	0x8
	.byte	0x33
	.byte	0x7
	.long	0x47
	.byte	0
	.uleb128 0x9
	.long	.LASF103
	.byte	0x8
	.byte	0x36
	.byte	0x9
	.long	0x293
	.byte	0x8
	.uleb128 0x9
	.long	.LASF104
	.byte	0x8
	.byte	0x37
	.byte	0x9
	.long	0x293
	.byte	0x10
	.uleb128 0x9
	.long	.LASF105
	.byte	0x8
	.byte	0x38
	.byte	0x9
	.long	0x293
	.byte	0x18
	.uleb128 0x9
	.long	.LASF106
	.byte	0x8
	.byte	0x39
	.byte	0x9
	.long	0x293
	.byte	0x20
	.uleb128 0x9
	.long	.LASF107
	.byte	0x8
	.byte	0x3a
	.byte	0x9
	.long	0x293
	.byte	0x28
	.uleb128 0x9
	.long	.LASF108
	.byte	0x8
	.byte	0x3b
	.byte	0x9
	.long	0x293
	.byte	0x30
	.uleb128 0x9
	.long	.LASF109
	.byte	0x8
	.byte	0x3c
	.byte	0x9
	.long	0x293
	.byte	0x38
	.uleb128 0x9
	.long	.LASF110
	.byte	0x8
	.byte	0x3d
	.byte	0x9
	.long	0x293
	.byte	0x40
	.uleb128 0x9
	.long	.LASF111
	.byte	0x8
	.byte	0x40
	.byte	0x9
	.long	0x293
	.byte	0x48
	.uleb128 0x9
	.long	.LASF112
	.byte	0x8
	.byte	0x41
	.byte	0x9
	.long	0x293
	.byte	0x50
	.uleb128 0x9
	.long	.LASF113
	.byte	0x8
	.byte	0x42
	.byte	0x9
	.long	0x293
	.byte	0x58
	.uleb128 0x9
	.long	.LASF114
	.byte	0x8
	.byte	0x44
	.byte	0x16
	.long	0x669
	.byte	0x60
	.uleb128 0x9
	.long	.LASF115
	.byte	0x8
	.byte	0x46
	.byte	0x14
	.long	0x66f
	.byte	0x68
	.uleb128 0x9
	.long	.LASF116
	.byte	0x8
	.byte	0x48
	.byte	0x7
	.long	0x47
	.byte	0x70
	.uleb128 0x9
	.long	.LASF117
	.byte	0x8
	.byte	0x49
	.byte	0x7
	.long	0x47
	.byte	0x74
	.uleb128 0x9
	.long	.LASF118
	.byte	0x8
	.byte	0x4a
	.byte	0xb
	.long	0x4a8
	.byte	0x78
	.uleb128 0x9
	.long	.LASF119
	.byte	0x8
	.byte	0x4d
	.byte	0x12
	.long	0x493
	.byte	0x80
	.uleb128 0x9
	.long	.LASF120
	.byte	0x8
	.byte	0x4e
	.byte	0xf
	.long	0x49a
	.byte	0x82
	.uleb128 0x9
	.long	.LASF121
	.byte	0x8
	.byte	0x4f
	.byte	0x8
	.long	0x675
	.byte	0x83
	.uleb128 0x9
	.long	.LASF122
	.byte	0x8
	.byte	0x51
	.byte	0xf
	.long	0x685
	.byte	0x88
	.uleb128 0x9
	.long	.LASF123
	.byte	0x8
	.byte	0x59
	.byte	0xd
	.long	0x4b4
	.byte	0x90
	.uleb128 0x9
	.long	.LASF124
	.byte	0x8
	.byte	0x5b
	.byte	0x17
	.long	0x690
	.byte	0x98
	.uleb128 0x9
	.long	.LASF125
	.byte	0x8
	.byte	0x5c
	.byte	0x19
	.long	0x69b
	.byte	0xa0
	.uleb128 0x9
	.long	.LASF126
	.byte	0x8
	.byte	0x5d
	.byte	0x14
	.long	0x66f
	.byte	0xa8
	.uleb128 0x9
	.long	.LASF127
	.byte	0x8
	.byte	0x5e
	.byte	0x9
	.long	0x4c0
	.byte	0xb0
	.uleb128 0x9
	.long	.LASF128
	.byte	0x8
	.byte	0x5f
	.byte	0xa
	.long	0x34
	.byte	0xb8
	.uleb128 0x9
	.long	.LASF129
	.byte	0x8
	.byte	0x60
	.byte	0x7
	.long	0x47
	.byte	0xc0
	.uleb128 0x9
	.long	.LASF130
	.byte	0x8
	.byte	0x62
	.byte	0x8
	.long	0x6a1
	.byte	0xc4
	.byte	0
	.uleb128 0x3
	.long	.LASF131
	.byte	0x9
	.byte	0x7
	.byte	0x19
	.long	0x4c9
	.uleb128 0xf
	.long	.LASF214
	.byte	0x8
	.byte	0x2b
	.byte	0xe
	.uleb128 0x10
	.long	.LASF132
	.uleb128 0xb
	.byte	0x8
	.long	0x664
	.uleb128 0xb
	.byte	0x8
	.long	0x4c9
	.uleb128 0x11
	.long	0x20b
	.long	0x685
	.uleb128 0x12
	.long	0x40
	.byte	0
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x65c
	.uleb128 0x10
	.long	.LASF133
	.uleb128 0xb
	.byte	0x8
	.long	0x68b
	.uleb128 0x10
	.long	.LASF134
	.uleb128 0xb
	.byte	0x8
	.long	0x696
	.uleb128 0x11
	.long	0x20b
	.long	0x6b1
	.uleb128 0x12
	.long	0x40
	.byte	0x13
	.byte	0
	.uleb128 0x13
	.long	.LASF135
	.byte	0xa
	.byte	0x89
	.byte	0xe
	.long	0x6bd
	.uleb128 0xb
	.byte	0x8
	.long	0x650
	.uleb128 0x13
	.long	.LASF136
	.byte	0xa
	.byte	0x8a
	.byte	0xe
	.long	0x6bd
	.uleb128 0x13
	.long	.LASF137
	.byte	0xa
	.byte	0x8b
	.byte	0xe
	.long	0x6bd
	.uleb128 0x13
	.long	.LASF138
	.byte	0xb
	.byte	0x1a
	.byte	0xc
	.long	0x47
	.uleb128 0x11
	.long	0x206
	.long	0x6f2
	.uleb128 0x14
	.byte	0
	.uleb128 0x7
	.long	0x6e7
	.uleb128 0x13
	.long	.LASF139
	.byte	0xb
	.byte	0x1b
	.byte	0x1a
	.long	0x6f2
	.uleb128 0x3
	.long	.LASF53
	.byte	0x4
	.byte	0x6
	.byte	0x15
	.long	0x217
	.uleb128 0x5
	.byte	0x7
	.byte	0x4
	.long	0x15b
	.byte	0x4
	.byte	0x8
	.byte	0xe
	.long	0x73c
	.uleb128 0x6
	.long	.LASF140
	.byte	0
	.uleb128 0x6
	.long	.LASF141
	.byte	0x1
	.uleb128 0x6
	.long	.LASF142
	.byte	0x2
	.uleb128 0x6
	.long	.LASF143
	.byte	0x3
	.uleb128 0x6
	.long	.LASF144
	.byte	0x4
	.byte	0
	.uleb128 0x3
	.long	.LASF145
	.byte	0x4
	.byte	0xe
	.byte	0x3
	.long	0x70f
	.uleb128 0xb
	.byte	0x8
	.long	0x703
	.uleb128 0xb
	.byte	0x8
	.long	0x1f5
	.uleb128 0x15
	.string	"Obj"
	.byte	0x6
	.byte	0x6
	.byte	0x14
	.long	0x3e2
	.uleb128 0x7
	.long	0x754
	.uleb128 0xb
	.byte	0x8
	.long	0x754
	.uleb128 0x2
	.byte	0x1
	.byte	0x2
	.long	.LASF146
	.uleb128 0xb
	.byte	0x8
	.long	0x2a5
	.uleb128 0x3
	.long	.LASF147
	.byte	0x1
	.byte	0x5
	.byte	0x19
	.long	0x789
	.uleb128 0x7
	.long	0x778
	.uleb128 0x8
	.long	.LASF147
	.byte	0x10
	.byte	0x1
	.byte	0x6
	.byte	0x8
	.long	0x7b1
	.uleb128 0x9
	.long	.LASF49
	.byte	0x1
	.byte	0x7
	.byte	0xd
	.long	0x7b1
	.byte	0
	.uleb128 0xa
	.string	"var"
	.byte	0x1
	.byte	0x8
	.byte	0xe
	.long	0x7b7
	.byte	0x8
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x778
	.uleb128 0xb
	.byte	0x8
	.long	0x760
	.uleb128 0x3
	.long	.LASF148
	.byte	0x1
	.byte	0xc
	.byte	0x16
	.long	0x7c9
	.uleb128 0x8
	.long	.LASF148
	.byte	0x10
	.byte	0x1
	.byte	0xd
	.byte	0x8
	.long	0x7f1
	.uleb128 0x9
	.long	.LASF49
	.byte	0x1
	.byte	0xe
	.byte	0xa
	.long	0x7f1
	.byte	0
	.uleb128 0x9
	.long	.LASF149
	.byte	0x1
	.byte	0xf
	.byte	0xd
	.long	0x7b1
	.byte	0x8
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x7bd
	.uleb128 0x16
	.long	.LASF150
	.byte	0x1
	.byte	0x12
	.byte	0xe
	.long	0x7bd
	.uleb128 0x9
	.byte	0x3
	.quad	global_scope
	.uleb128 0x16
	.long	.LASF151
	.byte	0x1
	.byte	0x13
	.byte	0xf
	.long	0x7f1
	.uleb128 0x9
	.byte	0x3
	.quad	scopes
	.uleb128 0x16
	.long	.LASF92
	.byte	0x1
	.byte	0x17
	.byte	0xd
	.long	0x765
	.uleb128 0x9
	.byte	0x3
	.quad	locals
	.uleb128 0x16
	.long	.LASF152
	.byte	0x1
	.byte	0x18
	.byte	0xd
	.long	0x765
	.uleb128 0x9
	.byte	0x3
	.quad	globals
	.uleb128 0x17
	.long	.LASF215
	.byte	0x1
	.value	0x2b2
	.byte	0x6
	.long	0x765
	.quad	.LFB44
	.quad	.LFE44-.LFB44
	.uleb128 0x1
	.byte	0x9c
	.long	0x8a5
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x2b2
	.byte	0x19
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.quad	.LBB27
	.quad	.LBE27-.LBB27
	.uleb128 0x1a
	.long	.LASF153
	.byte	0x1
	.value	0x2b6
	.byte	0xb
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF90
	.byte	0x1
	.value	0x2a7
	.byte	0xd
	.long	0x76b
	.quad	.LFB43
	.quad	.LFE43-.LFB43
	.uleb128 0x1
	.byte	0x9c
	.long	0x8fc
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x2a7
	.byte	0x26
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x1a
	.long	.LASF154
	.byte	0x1
	.value	0x2ac
	.byte	0x8
	.long	0x703
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x1a
	.long	.LASF50
	.byte	0x1
	.value	0x2ad
	.byte	0x9
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.byte	0
	.uleb128 0x1b
	.long	.LASF155
	.byte	0x1
	.value	0x295
	.byte	0x15
	.long	0x330
	.quad	.LFB42
	.quad	.LFE42-.LFB42
	.uleb128 0x1
	.byte	0x9c
	.long	0x972
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x295
	.byte	0x32
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1c
	.long	.LASF153
	.byte	0x1
	.value	0x295
	.byte	0x3d
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1a
	.long	.LASF156
	.byte	0x1
	.value	0x296
	.byte	0x8
	.long	0x76b
	.uleb128 0x2
	.byte	0x91
	.sleb128 -41
	.uleb128 0x19
	.quad	.LBB26
	.quad	.LBE26-.LBB26
	.uleb128 0x1a
	.long	.LASF50
	.byte	0x1
	.value	0x29f
	.byte	0xb
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF157
	.byte	0x1
	.value	0x283
	.byte	0x15
	.long	0x330
	.quad	.LFB41
	.quad	.LFE41-.LFB41
	.uleb128 0x1
	.byte	0x9c
	.long	0x9d5
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x283
	.byte	0x2b
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1c
	.long	.LASF153
	.byte	0x1
	.value	0x283
	.byte	0x36
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1a
	.long	.LASF50
	.byte	0x1
	.value	0x284
	.byte	0x9
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1d
	.string	"fn"
	.byte	0x1
	.value	0x286
	.byte	0x8
	.long	0x765
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x1e
	.long	.LASF196
	.byte	0x1
	.value	0x27c
	.byte	0xd
	.quad	.LFB40
	.quad	.LFE40-.LFB40
	.uleb128 0x1
	.byte	0x9c
	.long	0xa05
	.uleb128 0x1c
	.long	.LASF158
	.byte	0x1
	.value	0x27c
	.byte	0x26
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x1b
	.long	.LASF159
	.byte	0x1
	.value	0x248
	.byte	0xe
	.long	0x32a
	.quad	.LFB39
	.quad	.LFE39-.LFB39
	.uleb128 0x1
	.byte	0x9c
	.long	0xb3c
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x248
	.byte	0x24
	.long	0xb3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x248
	.byte	0x37
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x1f
	.quad	.LBB20
	.quad	.LBE20-.LBB20
	.long	0xa81
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x24b
	.byte	0x12
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x1a
	.long	.LASF162
	.byte	0x1
	.value	0x24d
	.byte	0x10
	.long	0xb42
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.byte	0
	.uleb128 0x1f
	.quad	.LBB21
	.quad	.LBE21-.LBB21
	.long	0xaa7
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x253
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1f
	.quad	.LBB22
	.quad	.LBE22-.LBB22
	.long	0xacd
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x259
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1f
	.quad	.LBB23
	.quad	.LBE23-.LBB23
	.long	0xaf3
	.uleb128 0x1d
	.string	"var"
	.byte	0x1
	.value	0x264
	.byte	0x10
	.long	0x7b7
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x1f
	.quad	.LBB24
	.quad	.LBE24-.LBB24
	.long	0xb19
	.uleb128 0x1d
	.string	"var"
	.byte	0x1
	.value	0x26d
	.byte	0xa
	.long	0x765
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x19
	.quad	.LBB25
	.quad	.LBE25-.LBB25
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x273
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.byte	0
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x330
	.uleb128 0xb
	.byte	0x8
	.long	0x3d6
	.uleb128 0x1b
	.long	.LASF163
	.byte	0x1
	.value	0x22b
	.byte	0xe
	.long	0x32a
	.quad	.LFB38
	.quad	.LFE38-.LFB38
	.uleb128 0x1
	.byte	0x9c
	.long	0xbd2
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x22b
	.byte	0x24
	.long	0xb3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x22b
	.byte	0x37
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x22c
	.byte	0x10
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x1a
	.long	.LASF164
	.byte	0x1
	.value	0x22f
	.byte	0x8
	.long	0x299
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x1d
	.string	"cur"
	.byte	0x1
	.value	0x230
	.byte	0x9
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x23a
	.byte	0x9
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.byte	0
	.uleb128 0x1b
	.long	.LASF165
	.byte	0x1
	.value	0x21c
	.byte	0xe
	.long	0x32a
	.quad	.LFB37
	.quad	.LFE37-.LFB37
	.uleb128 0x1
	.byte	0x9c
	.long	0xc58
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x21c
	.byte	0x24
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x21c
	.byte	0x37
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x21d
	.byte	0x9
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.quad	.LBB19
	.quad	.LBE19-.LBB19
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x221
	.byte	0x12
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1d
	.string	"idx"
	.byte	0x1
	.value	0x222
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF166
	.byte	0x1
	.value	0x20d
	.byte	0xe
	.long	0x32a
	.quad	.LFB36
	.quad	.LFE36-.LFB36
	.uleb128 0x1
	.byte	0x9c
	.long	0xc9c
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x20d
	.byte	0x22
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x20d
	.byte	0x35
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1b
	.long	.LASF167
	.byte	0x1
	.value	0x1f7
	.byte	0xe
	.long	0x32a
	.quad	.LFB35
	.quad	.LFE35-.LFB35
	.uleb128 0x1
	.byte	0x9c
	.long	0xd12
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x1f7
	.byte	0x23
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x1f7
	.byte	0x36
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x1f8
	.byte	0x9
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.quad	.LBB18
	.quad	.LBE18-.LBB18
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x1fb
	.byte	0x12
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF168
	.byte	0x1
	.value	0x1e1
	.byte	0xe
	.long	0x32a
	.quad	.LFB34
	.quad	.LFE34-.LFB34
	.uleb128 0x1
	.byte	0x9c
	.long	0xd88
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x1e1
	.byte	0x21
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x1e1
	.byte	0x34
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x1e2
	.byte	0x9
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.quad	.LBB17
	.quad	.LBE17-.LBB17
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x1e5
	.byte	0x12
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF169
	.byte	0x1
	.value	0x1bf
	.byte	0xe
	.long	0x32a
	.quad	.LFB33
	.quad	.LFE33-.LFB33
	.uleb128 0x1
	.byte	0x9c
	.long	0xe24
	.uleb128 0x18
	.string	"lhs"
	.byte	0x1
	.value	0x1bf
	.byte	0x1c
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.string	"rhs"
	.byte	0x1
	.value	0x1bf
	.byte	0x27
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x1bf
	.byte	0x39
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1f
	.quad	.LBB15
	.quad	.LBE15-.LBB15
	.long	0xe01
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x1cd
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x19
	.quad	.LBB16
	.quad	.LBE16-.LBB16
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x1d4
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF170
	.byte	0x1
	.value	0x1a6
	.byte	0xe
	.long	0x32a
	.quad	.LFB32
	.quad	.LFE32-.LFB32
	.uleb128 0x1
	.byte	0x9c
	.long	0xe9a
	.uleb128 0x18
	.string	"lhs"
	.byte	0x1
	.value	0x1a6
	.byte	0x1c
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.string	"rhs"
	.byte	0x1
	.value	0x1a6
	.byte	0x27
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x1a6
	.byte	0x39
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x19
	.quad	.LBB14
	.quad	.LBE14-.LBB14
	.uleb128 0x1d
	.string	"tmp"
	.byte	0x1
	.value	0x1b3
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF171
	.byte	0x1
	.value	0x183
	.byte	0xe
	.long	0x32a
	.quad	.LFB31
	.quad	.LFE31-.LFB31
	.uleb128 0x1
	.byte	0x9c
	.long	0xf10
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x183
	.byte	0x27
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x183
	.byte	0x3a
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x184
	.byte	0x9
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.quad	.LBB13
	.quad	.LBE13-.LBB13
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x187
	.byte	0x12
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF172
	.byte	0x1
	.value	0x16e
	.byte	0xe
	.long	0x32a
	.quad	.LFB30
	.quad	.LFE30-.LFB30
	.uleb128 0x1
	.byte	0x9c
	.long	0xf86
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x16e
	.byte	0x25
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x16e
	.byte	0x38
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x16f
	.byte	0x9
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.quad	.LBB12
	.quad	.LBE12-.LBB12
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x172
	.byte	0x12
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x1b
	.long	.LASF173
	.byte	0x1
	.value	0x165
	.byte	0xe
	.long	0x32a
	.quad	.LFB29
	.quad	.LFE29-.LFB29
	.uleb128 0x1
	.byte	0x9c
	.long	0xfda
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x165
	.byte	0x23
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x165
	.byte	0x36
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x166
	.byte	0x9
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x1b
	.long	.LASF174
	.byte	0x1
	.value	0x160
	.byte	0xe
	.long	0x32a
	.quad	.LFB28
	.quad	.LFE28-.LFB28
	.uleb128 0x1
	.byte	0x9c
	.long	0x101e
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x160
	.byte	0x21
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x160
	.byte	0x34
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x1b
	.long	.LASF175
	.byte	0x1
	.value	0x152
	.byte	0xe
	.long	0x32a
	.quad	.LFB27
	.quad	.LFE27-.LFB27
	.uleb128 0x1
	.byte	0x9c
	.long	0x1082
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x152
	.byte	0x26
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x152
	.byte	0x39
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x157
	.byte	0x10
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x159
	.byte	0x9
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x1b
	.long	.LASF176
	.byte	0x1
	.value	0x13b
	.byte	0x13
	.long	0xb42
	.quad	.LFB26
	.quad	.LFE26-.LFB26
	.uleb128 0x1
	.byte	0x9c
	.long	0x10fa
	.uleb128 0x1c
	.long	.LASF160
	.byte	0x1
	.value	0x13b
	.byte	0x2f
	.long	0xb3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x18
	.string	"tok"
	.byte	0x1
	.value	0x13b
	.byte	0x42
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x1a
	.long	.LASF164
	.byte	0x1
	.value	0x13c
	.byte	0x8
	.long	0x299
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1d
	.string	"cur"
	.byte	0x1
	.value	0x13d
	.byte	0x9
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x14c
	.byte	0xe
	.long	0xb42
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.byte	0
	.uleb128 0x20
	.long	.LASF177
	.byte	0x1
	.byte	0xf4
	.byte	0xe
	.long	0x32a
	.quad	.LFB25
	.quad	.LFE25-.LFB25
	.uleb128 0x1
	.byte	0x9c
	.long	0x129a
	.uleb128 0x21
	.long	.LASF160
	.byte	0x1
	.byte	0xf4
	.byte	0x21
	.long	0xb3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -168
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0xf4
	.byte	0x34
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.uleb128 0x1f
	.quad	.LBB8
	.quad	.LBE8-.LBB8
	.long	0x1161
	.uleb128 0x16
	.long	.LASF85
	.byte	0x1
	.byte	0xf6
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x1f
	.quad	.LBB9
	.quad	.LBE9-.LBB9
	.long	0x11c7
	.uleb128 0x16
	.long	.LASF161
	.byte	0x1
	.byte	0xfc
	.byte	0x12
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -72
	.uleb128 0x16
	.long	.LASF178
	.byte	0x1
	.byte	0xfe
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -64
	.uleb128 0x1a
	.long	.LASF179
	.byte	0x1
	.value	0x100
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x1a
	.long	.LASF180
	.byte	0x1
	.value	0x101
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x108
	.byte	0xb
	.long	0x32a
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.byte	0
	.uleb128 0x1f
	.quad	.LBB10
	.quad	.LBE10-.LBB10
	.long	0x1243
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x10e
	.byte	0x12
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x1a
	.long	.LASF181
	.byte	0x1
	.value	0x112
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x1a
	.long	.LASF178
	.byte	0x1
	.value	0x113
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -152
	.uleb128 0x1a
	.long	.LASF182
	.byte	0x1
	.value	0x11b
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x1a
	.long	.LASF183
	.byte	0x1
	.value	0x122
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x124
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.byte	0
	.uleb128 0x19
	.quad	.LBB11
	.quad	.LBE11-.LBB11
	.uleb128 0x1a
	.long	.LASF161
	.byte	0x1
	.value	0x128
	.byte	0x12
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x1a
	.long	.LASF178
	.byte	0x1
	.value	0x12b
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x1a
	.long	.LASF183
	.byte	0x1
	.value	0x12d
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x1a
	.long	.LASF85
	.byte	0x1
	.value	0x12f
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	.LASF184
	.byte	0x1
	.byte	0xea
	.byte	0xd
	.long	0x76b
	.quad	.LFB24
	.quad	.LFE24-.LFB24
	.uleb128 0x1
	.byte	0x9c
	.long	0x12cc
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0xea
	.byte	0x26
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF185
	.byte	0x1
	.byte	0xcd
	.byte	0x13
	.long	0xb42
	.quad	.LFB23
	.quad	.LFE23-.LFB23
	.uleb128 0x1
	.byte	0x9c
	.long	0x13bf
	.uleb128 0x21
	.long	.LASF160
	.byte	0x1
	.byte	0xcd
	.byte	0x2d
	.long	0xb3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -168
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0xcd
	.byte	0x40
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -176
	.uleb128 0x16
	.long	.LASF153
	.byte	0x1
	.byte	0xce
	.byte	0x9
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x16
	.long	.LASF164
	.byte	0x1
	.byte	0xd0
	.byte	0x8
	.long	0x299
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x23
	.string	"cur"
	.byte	0x1
	.byte	0xd1
	.byte	0x9
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -144
	.uleb128 0x23
	.string	"i"
	.byte	0x1
	.byte	0xd2
	.byte	0x7
	.long	0x47
	.uleb128 0x3
	.byte	0x91
	.sleb128 -148
	.uleb128 0x16
	.long	.LASF85
	.byte	0x1
	.byte	0xe4
	.byte	0xe
	.long	0xb42
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x19
	.quad	.LBB7
	.quad	.LBE7-.LBB7
	.uleb128 0x16
	.long	.LASF50
	.byte	0x1
	.byte	0xd8
	.byte	0xb
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x23
	.string	"var"
	.byte	0x1
	.byte	0xd9
	.byte	0xa
	.long	0x765
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x23
	.string	"lhs"
	.byte	0x1
	.byte	0xde
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x23
	.string	"rhs"
	.byte	0x1
	.byte	0xdf
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x16
	.long	.LASF85
	.byte	0x1
	.byte	0xe0
	.byte	0xb
	.long	0x32a
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	.LASF186
	.byte	0x1
	.byte	0xbe
	.byte	0xe
	.long	0x748
	.quad	.LFB22
	.quad	.LFE22-.LFB22
	.uleb128 0x1
	.byte	0x9c
	.long	0x140f
	.uleb128 0x21
	.long	.LASF160
	.byte	0x1
	.byte	0xbe
	.byte	0x27
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0xbe
	.byte	0x3a
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x21
	.long	.LASF50
	.byte	0x1
	.byte	0xbe
	.byte	0x45
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.byte	0
	.uleb128 0x20
	.long	.LASF187
	.byte	0x1
	.byte	0xae
	.byte	0xe
	.long	0x748
	.quad	.LFB21
	.quad	.LFE21-.LFB21
	.uleb128 0x1
	.byte	0x9c
	.long	0x1480
	.uleb128 0x21
	.long	.LASF160
	.byte	0x1
	.byte	0xae
	.byte	0x28
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0xae
	.byte	0x3b
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x21
	.long	.LASF50
	.byte	0x1
	.byte	0xae
	.byte	0x46
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -56
	.uleb128 0x19
	.quad	.LBB6
	.quad	.LBE6-.LBB6
	.uleb128 0x16
	.long	.LASF188
	.byte	0x1
	.byte	0xb3
	.byte	0x9
	.long	0x47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -20
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	.LASF189
	.byte	0x1
	.byte	0x96
	.byte	0xe
	.long	0x748
	.quad	.LFB20
	.quad	.LFE20-.LFB20
	.uleb128 0x1
	.byte	0x9c
	.long	0x1535
	.uleb128 0x21
	.long	.LASF160
	.byte	0x1
	.byte	0x96
	.byte	0x28
	.long	0xb3c
	.uleb128 0x3
	.byte	0x91
	.sleb128 -120
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0x96
	.byte	0x3b
	.long	0x330
	.uleb128 0x3
	.byte	0x91
	.sleb128 -128
	.uleb128 0x21
	.long	.LASF58
	.byte	0x1
	.byte	0x97
	.byte	0x20
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -136
	.uleb128 0x16
	.long	.LASF164
	.byte	0x1
	.byte	0x98
	.byte	0x8
	.long	0x703
	.uleb128 0x3
	.byte	0x91
	.sleb128 -80
	.uleb128 0x23
	.string	"cur"
	.byte	0x1
	.byte	0x99
	.byte	0x9
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -112
	.uleb128 0x16
	.long	.LASF50
	.byte	0x1
	.byte	0xa5
	.byte	0x9
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -104
	.uleb128 0x19
	.quad	.LBB5
	.quad	.LBE5-.LBB5
	.uleb128 0x16
	.long	.LASF153
	.byte	0x1
	.byte	0xa0
	.byte	0xb
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -96
	.uleb128 0x16
	.long	.LASF50
	.byte	0x1
	.byte	0xa1
	.byte	0xb
	.long	0x748
	.uleb128 0x3
	.byte	0x91
	.sleb128 -88
	.byte	0
	.byte	0
	.uleb128 0x20
	.long	.LASF190
	.byte	0x1
	.byte	0x8c
	.byte	0xe
	.long	0x748
	.quad	.LFB19
	.quad	.LFE19-.LFB19
	.uleb128 0x1
	.byte	0x9c
	.long	0x1576
	.uleb128 0x21
	.long	.LASF160
	.byte	0x1
	.byte	0x8c
	.byte	0x25
	.long	0xb3c
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0x8c
	.byte	0x38
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.byte	0
	.uleb128 0x20
	.long	.LASF191
	.byte	0x1
	.byte	0x84
	.byte	0xc
	.long	0x47
	.quad	.LFB18
	.quad	.LFE18-.LFB18
	.uleb128 0x1
	.byte	0x9c
	.long	0x15a8
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0x84
	.byte	0x24
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF192
	.byte	0x1
	.byte	0x7d
	.byte	0x14
	.long	0x200
	.quad	.LFB17
	.quad	.LFE17-.LFB17
	.uleb128 0x1
	.byte	0x9c
	.long	0x15da
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0x7d
	.byte	0x2b
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF193
	.byte	0x1
	.byte	0x77
	.byte	0xd
	.long	0x765
	.quad	.LFB16
	.quad	.LFE16-.LFB16
	.uleb128 0x1
	.byte	0x9c
	.long	0x162a
	.uleb128 0x22
	.string	"str"
	.byte	0x1
	.byte	0x77
	.byte	0x26
	.long	0x293
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.long	.LASF50
	.byte	0x1
	.byte	0x77
	.byte	0x31
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x23
	.string	"var"
	.byte	0x1
	.byte	0x78
	.byte	0x8
	.long	0x765
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF194
	.byte	0x1
	.byte	0x73
	.byte	0xd
	.long	0x765
	.quad	.LFB15
	.quad	.LFE15-.LFB15
	.uleb128 0x1
	.byte	0x9c
	.long	0x166b
	.uleb128 0x21
	.long	.LASF50
	.byte	0x1
	.byte	0x73
	.byte	0x21
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x16
	.long	.LASF195
	.byte	0x1
	.byte	0x74
	.byte	0x9
	.long	0x293
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x24
	.long	.LASF197
	.byte	0x1
	.byte	0x6e
	.byte	0xe
	.long	0x293
	.quad	.LFB14
	.quad	.LFE14-.LFB14
	.uleb128 0x1
	.byte	0x9c
	.long	0x16a3
	.uleb128 0x23
	.string	"id"
	.byte	0x1
	.byte	0x6f
	.byte	0xe
	.long	0x47
	.uleb128 0x9
	.byte	0x3
	.quad	id.3512
	.byte	0
	.uleb128 0x20
	.long	.LASF198
	.byte	0x1
	.byte	0x67
	.byte	0xd
	.long	0x765
	.quad	.LFB13
	.quad	.LFE13-.LFB13
	.uleb128 0x1
	.byte	0x9c
	.long	0x1702
	.uleb128 0x21
	.long	.LASF50
	.byte	0x1
	.byte	0x67
	.byte	0x1c
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.long	.LASF57
	.byte	0x1
	.byte	0x67
	.byte	0x2e
	.long	0x200
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x21
	.long	.LASF199
	.byte	0x1
	.byte	0x67
	.byte	0x38
	.long	0x47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x23
	.string	"var"
	.byte	0x1
	.byte	0x68
	.byte	0x8
	.long	0x765
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF200
	.byte	0x1
	.byte	0x60
	.byte	0xd
	.long	0x765
	.quad	.LFB12
	.quad	.LFE12-.LFB12
	.uleb128 0x1
	.byte	0x9c
	.long	0x1761
	.uleb128 0x21
	.long	.LASF50
	.byte	0x1
	.byte	0x60
	.byte	0x1c
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.long	.LASF57
	.byte	0x1
	.byte	0x60
	.byte	0x2e
	.long	0x200
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x21
	.long	.LASF199
	.byte	0x1
	.byte	0x60
	.byte	0x38
	.long	0x47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x23
	.string	"var"
	.byte	0x1
	.byte	0x61
	.byte	0x8
	.long	0x765
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF201
	.byte	0x1
	.byte	0x57
	.byte	0xd
	.long	0x765
	.quad	.LFB11
	.quad	.LFE11-.LFB11
	.uleb128 0x1
	.byte	0x9c
	.long	0x17c0
	.uleb128 0x21
	.long	.LASF50
	.byte	0x1
	.byte	0x57
	.byte	0x1b
	.long	0x748
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x21
	.long	.LASF57
	.byte	0x1
	.byte	0x57
	.byte	0x2d
	.long	0x200
	.uleb128 0x2
	.byte	0x91
	.sleb128 -48
	.uleb128 0x22
	.string	"len"
	.byte	0x1
	.byte	0x57
	.byte	0x37
	.long	0x47
	.uleb128 0x2
	.byte	0x91
	.sleb128 -52
	.uleb128 0x23
	.string	"var"
	.byte	0x1
	.byte	0x58
	.byte	0x8
	.long	0x765
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF202
	.byte	0x1
	.byte	0x4f
	.byte	0x12
	.long	0x7b1
	.quad	.LFB10
	.quad	.LFE10-.LFB10
	.uleb128 0x1
	.byte	0x9c
	.long	0x1800
	.uleb128 0x22
	.string	"var"
	.byte	0x1
	.byte	0x4f
	.byte	0x22
	.long	0x765
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x23
	.string	"sc"
	.byte	0x1
	.byte	0x50
	.byte	0xd
	.long	0x7b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x20
	.long	.LASF203
	.byte	0x1
	.byte	0x44
	.byte	0x13
	.long	0x7b7
	.quad	.LFB9
	.quad	.LFE9-.LFB9
	.uleb128 0x1
	.byte	0x9c
	.long	0x1873
	.uleb128 0x22
	.string	"tok"
	.byte	0x1
	.byte	0x44
	.byte	0x29
	.long	0x330
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x19
	.quad	.LBB3
	.quad	.LBE3-.LBB3
	.uleb128 0x23
	.string	"sc"
	.byte	0x1
	.byte	0x45
	.byte	0xf
	.long	0x7f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.quad	.LBB4
	.quad	.LBE4-.LBB4
	.uleb128 0x23
	.string	"vsc"
	.byte	0x1
	.byte	0x46
	.byte	0x1a
	.long	0x1873
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0xb
	.byte	0x8
	.long	0x784
	.uleb128 0x25
	.long	.LASF204
	.byte	0x1
	.byte	0x3d
	.byte	0xd
	.quad	.LFB8
	.quad	.LFE8-.LFB8
	.uleb128 0x1
	.byte	0x9c
	.long	0x18a7
	.uleb128 0x16
	.long	.LASF205
	.byte	0x1
	.byte	0x3e
	.byte	0xa
	.long	0x7f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.uleb128 0x25
	.long	.LASF206
	.byte	0x1
	.byte	0x31
	.byte	0xd
	.quad	.LFB7
	.quad	.LFE7-.LFB7
	.uleb128 0x1
	.byte	0x9c
	.long	0x1905
	.uleb128 0x21
	.long	.LASF207
	.byte	0x1
	.byte	0x31
	.byte	0x1f
	.long	0x7f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -40
	.uleb128 0x16
	.long	.LASF208
	.byte	0x1
	.byte	0x33
	.byte	0xd
	.long	0x7b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -32
	.uleb128 0x19
	.quad	.LBB2
	.quad	.LBE2-.LBB2
	.uleb128 0x16
	.long	.LASF209
	.byte	0x1
	.byte	0x36
	.byte	0xf
	.long	0x7b1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.uleb128 0x26
	.long	.LASF216
	.byte	0x1
	.byte	0x2a
	.byte	0xd
	.quad	.LFB6
	.quad	.LFE6-.LFB6
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0x23
	.string	"sc"
	.byte	0x1
	.byte	0x2b
	.byte	0xa
	.long	0x7f1
	.uleb128 0x2
	.byte	0x91
	.sleb128 -24
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1b
	.uleb128 0xe
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x28
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x1c
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x38
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x4
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0x13
	.byte	0x1
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x13
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x21
	.byte	0
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1c
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1d
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1e
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0x5
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x1f
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x20
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x21
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x22
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x23
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x24
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x25
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x26
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x2116
	.uleb128 0x19
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.long	0x2c
	.value	0x2
	.long	.Ldebug_info0
	.byte	0x8
	.byte	0
	.value	0
	.value	0
	.quad	.Ltext0
	.quad	.Letext0-.Ltext0
	.quad	0
	.quad	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF191:
	.string	"get_number"
.LASF65:
	.string	"NODE_TAG_BLOCK"
.LASF194:
	.string	"new_anon_gvar"
.LASF59:
	.string	"params"
.LASF121:
	.string	"_shortbuf"
.LASF185:
	.string	"declaration"
.LASF214:
	.string	"_IO_lock_t"
.LASF168:
	.string	"term"
.LASF180:
	.string	"else_stmt"
.LASF39:
	.string	"TOKEN_IDENT"
.LASF67:
	.string	"NODE_TAG_VAR"
.LASF173:
	.string	"assign"
.LASF110:
	.string	"_IO_buf_end"
.LASF181:
	.string	"init_expr"
.LASF182:
	.string	"inc_expr"
.LASF108:
	.string	"_IO_write_end"
.LASF44:
	.string	"unsigned int"
.LASF49:
	.string	"next"
.LASF210:
	.string	"GNU C17 9.4.0 -mtune=generic -march=x86-64 -g -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection"
.LASF126:
	.string	"_freeres_list"
.LASF177:
	.string	"stmt"
.LASF202:
	.string	"push_scope"
.LASF102:
	.string	"_flags"
.LASF164:
	.string	"head"
.LASF204:
	.string	"leave_scope"
.LASF75:
	.string	"NODE_ADD"
.LASF119:
	.string	"_cur_column"
.LASF13:
	.string	"TOKEN_LEFT_BRACKET"
.LASF154:
	.string	"dummy"
.LASF7:
	.string	"TOKEN_FOR"
.LASF114:
	.string	"_markers"
.LASF6:
	.string	"TOKEN_ELSE"
.LASF97:
	.string	"short int"
.LASF142:
	.string	"TYPE_PTR"
.LASF4:
	.string	"TOKEN_RETURN"
.LASF145:
	.string	"TypeKind"
.LASF46:
	.string	"TokenKind"
.LASF17:
	.string	"TOKEN_LEFT_BRACE"
.LASF203:
	.string	"find_var"
.LASF51:
	.string	"line_no"
.LASF68:
	.string	"NODE_TAG_NUM"
.LASF18:
	.string	"TOKEN_RIGHT_BRACE"
.LASF153:
	.string	"base_type"
.LASF171:
	.string	"comparison"
.LASF25:
	.string	"TOKEN_STAR"
.LASF113:
	.string	"_IO_save_end"
.LASF74:
	.string	"NODE_RETURN"
.LASF10:
	.string	"TOKEN_CHAR"
.LASF133:
	.string	"_IO_codecvt"
.LASF28:
	.string	"TOKEN_AMPERSAND"
.LASF56:
	.string	"base"
.LASF131:
	.string	"FILE"
.LASF9:
	.string	"TOKEN_INT"
.LASF100:
	.string	"long long unsigned int"
.LASF58:
	.string	"return_type"
.LASF64:
	.string	"NODE_TAG_FOR"
.LASF60:
	.string	"Node"
.LASF48:
	.string	"kind"
.LASF200:
	.string	"new_lvar"
.LASF140:
	.string	"TYPE_CHAR"
.LASF139:
	.string	"sys_errlist"
.LASF79:
	.string	"NODE_EQ"
.LASF112:
	.string	"_IO_backup_base"
.LASF123:
	.string	"_offset"
.LASF159:
	.string	"primary"
.LASF186:
	.string	"declarator"
.LASF138:
	.string	"sys_nerr"
.LASF195:
	.string	"unique_name"
.LASF116:
	.string	"_fileno"
.LASF11:
	.string	"TOKEN_SIZEOF"
.LASF27:
	.string	"TOKEN_COLON"
.LASF187:
	.string	"type_suffix"
.LASF20:
	.string	"TOKEN_DOT"
.LASF45:
	.string	"size_t"
.LASF89:
	.string	"offset"
.LASF206:
	.string	"free_scope"
.LASF71:
	.string	"NODE_DEREF"
.LASF105:
	.string	"_IO_read_base"
.LASF146:
	.string	"_Bool"
.LASF213:
	.string	"NodeTag"
.LASF76:
	.string	"NODE_SUB"
.LASF15:
	.string	"TOKEN_LEFT_PAREN"
.LASF88:
	.string	"is_local"
.LASF207:
	.string	"scope"
.LASF63:
	.string	"NODE_TAG_IF"
.LASF16:
	.string	"TOKEN_RIGHT_PAREN"
.LASF198:
	.string	"new_gvar"
.LASF170:
	.string	"new_add"
.LASF35:
	.string	"TOKEN_LESS"
.LASF144:
	.string	"TYPE_ARRAY"
.LASF52:
	.string	"char"
.LASF209:
	.string	"dead_var_scope"
.LASF129:
	.string	"_mode"
.LASF31:
	.string	"TOKEN_EQUAL"
.LASF62:
	.string	"NODE_TAG_BINARY"
.LASF201:
	.string	"new_var"
.LASF69:
	.string	"NODE_NEG"
.LASF132:
	.string	"_IO_marker"
.LASF103:
	.string	"_IO_read_ptr"
.LASF36:
	.string	"TOKEN_LESS_EQUAL"
.LASF84:
	.string	"BlockNode"
.LASF55:
	.string	"array_length"
.LASF90:
	.string	"is_function"
.LASF137:
	.string	"stderr"
.LASF53:
	.string	"Type"
.LASF179:
	.string	"then_stmt"
.LASF30:
	.string	"TOKEN_BANG_EQUAL"
.LASF106:
	.string	"_IO_write_base"
.LASF73:
	.string	"NODE_STMT_EXPR"
.LASF2:
	.string	"long long int"
.LASF38:
	.string	"TOKEN_MINUS_MINUS"
.LASF111:
	.string	"_IO_save_base"
.LASF175:
	.string	"expr_stmt"
.LASF147:
	.string	"VarScope"
.LASF32:
	.string	"TOKEN_EQUAL_EQUAL"
.LASF72:
	.string	"NODE_EXPR_STMT"
.LASF150:
	.string	"global_scope"
.LASF43:
	.string	"TOKEN_TOTAL_COUNT"
.LASF184:
	.string	"is_typename"
.LASF21:
	.string	"TOKEN_MINUS"
.LASF54:
	.string	"size"
.LASF127:
	.string	"_freeres_buf"
.LASF196:
	.string	"create_param_lvars"
.LASF136:
	.string	"stdout"
.LASF19:
	.string	"TOKEN_COMMA"
.LASF158:
	.string	"param"
.LASF128:
	.string	"__pad5"
.LASF66:
	.string	"NODE_TAG_FUNCALL"
.LASF91:
	.string	"init_data"
.LASF40:
	.string	"TOKEN_STR"
.LASF166:
	.string	"unary"
.LASF120:
	.string	"_vtable_offset"
.LASF33:
	.string	"TOKEN_GREATER"
.LASF176:
	.string	"compound_stmt"
.LASF23:
	.string	"TOKEN_SEMICOLON"
.LASF22:
	.string	"TOKEN_PLUS"
.LASF148:
	.string	"Scope"
.LASF3:
	.string	"long double"
.LASF78:
	.string	"NODE_DIV"
.LASF169:
	.string	"new_sub"
.LASF199:
	.string	"name_len"
.LASF163:
	.string	"funcall"
.LASF83:
	.string	"NODE_ASSIGN"
.LASF104:
	.string	"_IO_read_end"
.LASF155:
	.string	"global_variable"
.LASF41:
	.string	"TOKEN_NUM"
.LASF0:
	.string	"long int"
.LASF70:
	.string	"NODE_ADDR"
.LASF212:
	.string	"/home/crspy/cimple"
.LASF14:
	.string	"TOKEN_RIGHT_BRACKET"
.LASF29:
	.string	"TOKEN_BANG"
.LASF208:
	.string	"var_scope"
.LASF211:
	.string	"parser.c"
.LASF192:
	.string	"get_ident"
.LASF143:
	.string	"TYPE_FUNC"
.LASF134:
	.string	"_IO_wide_data"
.LASF85:
	.string	"node"
.LASF82:
	.string	"NODE_LE"
.LASF42:
	.string	"TOKEN_EOF"
.LASF81:
	.string	"NODE_LT"
.LASF215:
	.string	"parse"
.LASF57:
	.string	"name"
.LASF161:
	.string	"start"
.LASF109:
	.string	"_IO_buf_base"
.LASF125:
	.string	"_wide_data"
.LASF162:
	.string	"block_node"
.LASF122:
	.string	"_lock"
.LASF197:
	.string	"new_unique_name"
.LASF1:
	.string	"long unsigned int"
.LASF118:
	.string	"_old_offset"
.LASF135:
	.string	"stdin"
.LASF101:
	.string	"_IO_FILE"
.LASF86:
	.string	"body"
.LASF151:
	.string	"scopes"
.LASF50:
	.string	"type"
.LASF94:
	.string	"unsigned char"
.LASF178:
	.string	"cond_expr"
.LASF157:
	.string	"function"
.LASF189:
	.string	"func_params"
.LASF107:
	.string	"_IO_write_ptr"
.LASF12:
	.string	"TOKEN_KEYWORDS_COUNT"
.LASF80:
	.string	"NODE_NE"
.LASF190:
	.string	"declspec"
.LASF152:
	.string	"globals"
.LASF156:
	.string	"first"
.LASF141:
	.string	"TYPE_INT"
.LASF124:
	.string	"_codecvt"
.LASF172:
	.string	"equality"
.LASF87:
	.string	"name_length"
.LASF188:
	.string	"array_count"
.LASF47:
	.string	"Token"
.LASF174:
	.string	"expr"
.LASF24:
	.string	"TOKEN_SLASH"
.LASF98:
	.string	"__off_t"
.LASF34:
	.string	"TOKEN_GREATER_EQUAL"
.LASF165:
	.string	"postfix"
.LASF8:
	.string	"TOKEN_WHILE"
.LASF96:
	.string	"signed char"
.LASF95:
	.string	"short unsigned int"
.LASF5:
	.string	"TOKEN_IF"
.LASF193:
	.string	"new_string_literal"
.LASF93:
	.string	"stack_size"
.LASF160:
	.string	"rest"
.LASF115:
	.string	"_chain"
.LASF216:
	.string	"enter_scope"
.LASF37:
	.string	"TOKEN_PLUS_PLUS"
.LASF167:
	.string	"factor"
.LASF26:
	.string	"TOKEN_PERCENT"
.LASF149:
	.string	"vars"
.LASF117:
	.string	"_flags2"
.LASF92:
	.string	"locals"
.LASF205:
	.string	"dead_scope"
.LASF183:
	.string	"body_stmt"
.LASF77:
	.string	"NODE_MUL"
.LASF61:
	.string	"NODE_TAG_UNARY"
.LASF99:
	.string	"__off64_t"
.LASF130:
	.string	"_unused2"
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
