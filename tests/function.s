.data
.globl .L..11
.L..11:
	.byte 79
	.byte 75
	.byte 10
	.byte 0
.data
.globl .L..10
.L..10:
	.byte 40
	.byte 123
	.byte 32
	.byte 115
	.byte 117
	.byte 98
	.byte 95
	.byte 99
	.byte 104
	.byte 97
	.byte 114
	.byte 40
	.byte 55
	.byte 44
	.byte 32
	.byte 51
	.byte 44
	.byte 32
	.byte 51
	.byte 41
	.byte 59
	.byte 32
	.byte 125
	.byte 41
	.byte 0
.data
.globl .L..9
.L..9:
	.byte 102
	.byte 105
	.byte 98
	.byte 40
	.byte 57
	.byte 41
	.byte 0
.data
.globl .L..8
.L..8:
	.byte 115
	.byte 117
	.byte 98
	.byte 50
	.byte 40
	.byte 52
	.byte 44
	.byte 51
	.byte 41
	.byte 0
.data
.globl .L..7
.L..7:
	.byte 97
	.byte 100
	.byte 100
	.byte 50
	.byte 40
	.byte 51
	.byte 44
	.byte 52
	.byte 41
	.byte 0
.data
.globl .L..6
.L..6:
	.byte 97
	.byte 100
	.byte 100
	.byte 54
	.byte 40
	.byte 49
	.byte 44
	.byte 50
	.byte 44
	.byte 97
	.byte 100
	.byte 100
	.byte 54
	.byte 40
	.byte 51
	.byte 44
	.byte 97
	.byte 100
	.byte 100
	.byte 54
	.byte 40
	.byte 52
	.byte 44
	.byte 53
	.byte 44
	.byte 54
	.byte 44
	.byte 55
	.byte 44
	.byte 56
	.byte 44
	.byte 57
	.byte 41
	.byte 44
	.byte 49
	.byte 48
	.byte 44
	.byte 49
	.byte 49
	.byte 44
	.byte 49
	.byte 50
	.byte 44
	.byte 49
	.byte 51
	.byte 41
	.byte 44
	.byte 49
	.byte 52
	.byte 44
	.byte 49
	.byte 53
	.byte 44
	.byte 49
	.byte 54
	.byte 41
	.byte 0
.data
.globl .L..5
.L..5:
	.byte 97
	.byte 100
	.byte 100
	.byte 54
	.byte 40
	.byte 49
	.byte 44
	.byte 50
	.byte 44
	.byte 97
	.byte 100
	.byte 100
	.byte 54
	.byte 40
	.byte 51
	.byte 44
	.byte 52
	.byte 44
	.byte 53
	.byte 44
	.byte 54
	.byte 44
	.byte 55
	.byte 44
	.byte 56
	.byte 41
	.byte 44
	.byte 57
	.byte 44
	.byte 49
	.byte 48
	.byte 44
	.byte 49
	.byte 49
	.byte 41
	.byte 0
.data
.globl .L..4
.L..4:
	.byte 97
	.byte 100
	.byte 100
	.byte 54
	.byte 40
	.byte 49
	.byte 44
	.byte 50
	.byte 44
	.byte 51
	.byte 44
	.byte 52
	.byte 44
	.byte 53
	.byte 44
	.byte 54
	.byte 41
	.byte 0
.data
.globl .L..3
.L..3:
	.byte 115
	.byte 117
	.byte 98
	.byte 50
	.byte 40
	.byte 53
	.byte 44
	.byte 32
	.byte 51
	.byte 41
	.byte 0
.data
.globl .L..2
.L..2:
	.byte 97
	.byte 100
	.byte 100
	.byte 50
	.byte 40
	.byte 51
	.byte 44
	.byte 32
	.byte 53
	.byte 41
	.byte 0
.data
.globl .L..1
.L..1:
	.byte 114
	.byte 101
	.byte 116
	.byte 51
	.byte 40
	.byte 41
	.byte 0
.text
.globl main
main:
	mov $3, %rax
	push %rax
	mov $0, %rax
	call ret3
	push %rax
	lea .L..1(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $8, %rax
	push %rax
	mov $3, %rax
	push %rax
	mov $5, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add2
	push %rax
	lea .L..2(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $2, %rax
	push %rax
	mov $5, %rax
	push %rax
	mov $3, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call sub2
	push %rax
	lea .L..3(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $21, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $2, %rax
	push %rax
	mov $3, %rax
	push %rax
	mov $4, %rax
	push %rax
	mov $5, %rax
	push %rax
	mov $6, %rax
	push %rax
	pop %r9
	pop %r8
	pop %rcx
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add6
	push %rax
	lea .L..4(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $66, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $2, %rax
	push %rax
	mov $3, %rax
	push %rax
	mov $4, %rax
	push %rax
	mov $5, %rax
	push %rax
	mov $6, %rax
	push %rax
	mov $7, %rax
	push %rax
	mov $8, %rax
	push %rax
	pop %r9
	pop %r8
	pop %rcx
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add6
	push %rax
	mov $9, %rax
	push %rax
	mov $10, %rax
	push %rax
	mov $11, %rax
	push %rax
	pop %r9
	pop %r8
	pop %rcx
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add6
	push %rax
	lea .L..5(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $136, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $2, %rax
	push %rax
	mov $3, %rax
	push %rax
	mov $4, %rax
	push %rax
	mov $5, %rax
	push %rax
	mov $6, %rax
	push %rax
	mov $7, %rax
	push %rax
	mov $8, %rax
	push %rax
	mov $9, %rax
	push %rax
	pop %r9
	pop %r8
	pop %rcx
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add6
	push %rax
	mov $10, %rax
	push %rax
	mov $11, %rax
	push %rax
	mov $12, %rax
	push %rax
	mov $13, %rax
	push %rax
	pop %r9
	pop %r8
	pop %rcx
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add6
	push %rax
	mov $14, %rax
	push %rax
	mov $15, %rax
	push %rax
	mov $16, %rax
	push %rax
	pop %r9
	pop %r8
	pop %rcx
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add6
	push %rax
	lea .L..6(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $7, %rax
	push %rax
	mov $3, %rax
	push %rax
	mov $4, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add2
	push %rax
	lea .L..7(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $4, %rax
	push %rax
	mov $3, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call sub2
	push %rax
	lea .L..8(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $55, %rax
	push %rax
	mov $9, %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call fib
	push %rax
	lea .L..9(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $7, %rax
	push %rax
	mov $3, %rax
	push %rax
	mov $3, %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call sub_char
	push %rax
	lea .L..10(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	lea .L..11(%rip), %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call printf
	mov $0, %rax
	jmp .L.return.main
.L.return.main:
	ret
.text
.globl fib
fib:
	push %rbp
	mov %rsp, %rbp
	sub $16, %rsp
	mov %rdi, -8(%rbp)
	mov $1, %rax
	push %rax
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	cmp $0, %rax
	je  .L.else.1
	mov $1, %rax
	jmp .L.return.fib
	jmp .L.end.1
.L.else.1:
.L.end.1:
	mov $2, %rax
	push %rax
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call fib
	push %rax
	mov $1, %rax
	push %rax
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call fib
	pop %rdi
	add %rdi, %rax
	jmp .L.return.fib
.L.return.fib:
	mov %rbp, %rsp
	pop %rbp
	ret
.text
.globl sub_char
sub_char:
	push %rbp
	mov %rsp, %rbp
	sub $16, %rsp
	mov %dil, -1(%rbp)
	mov %sil, -2(%rbp)
	mov %dl, -3(%rbp)
	lea -3(%rbp), %rax
	movsbq (%rax), %rax
	push %rax
	lea -2(%rbp), %rax
	movsbq (%rax), %rax
	push %rax
	lea -1(%rbp), %rax
	movsbq (%rax), %rax
	pop %rdi
	sub %rdi, %rax
	pop %rdi
	sub %rdi, %rax
	jmp .L.return.sub_char
.L.return.sub_char:
	mov %rbp, %rsp
	pop %rbp
	ret
.text
.globl addx
addx:
	push %rbp
	mov %rsp, %rbp
	sub $16, %rsp
	mov %rdi, -8(%rbp)
	mov %rsi, -16(%rbp)
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -8(%rbp), %rax
	mov (%rax), %rax
	mov (%rax), %rax
	pop %rdi
	add %rdi, %rax
	jmp .L.return.addx
.L.return.addx:
	mov %rbp, %rsp
	pop %rbp
	ret
.text
.globl add6
add6:
	push %rbp
	mov %rsp, %rbp
	sub $48, %rsp
	mov %rdi, -8(%rbp)
	mov %rsi, -16(%rbp)
	mov %rdx, -24(%rbp)
	mov %rcx, -32(%rbp)
	mov %r8, -40(%rbp)
	mov %r9, -48(%rbp)
	lea -48(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -40(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -32(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -24(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	add %rdi, %rax
	jmp .L.return.add6
.L.return.add6:
	mov %rbp, %rsp
	pop %rbp
	ret
.text
.globl sub2
sub2:
	push %rbp
	mov %rsp, %rbp
	sub $16, %rsp
	mov %rdi, -8(%rbp)
	mov %rsi, -16(%rbp)
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	sub %rdi, %rax
	jmp .L.return.sub2
.L.return.sub2:
	mov %rbp, %rsp
	pop %rbp
	ret
.text
.globl add2
add2:
	push %rbp
	mov %rsp, %rbp
	sub $16, %rsp
	mov %rdi, -8(%rbp)
	mov %rsi, -16(%rbp)
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	add %rdi, %rax
	jmp .L.return.add2
.L.return.add2:
	mov %rbp, %rsp
	pop %rbp
	ret
.text
.globl ret3
ret3:
	mov $3, %rax
	jmp .L.return.ret3
	mov $5, %rax
	jmp .L.return.ret3
.L.return.ret3:
	ret
