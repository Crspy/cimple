.file 1 "-"
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
	.loc 1 73 0
	.loc 1 61 2
	.loc 1 61 2
	.loc 1 61 9
	mov $3, %rax
	push %rax
	.loc 1 61 12
	mov $0, %rax
	call ret3
	push %rax
	.loc 1 61 20
	lea .L..1(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 62 2
	.loc 1 62 2
	.loc 1 62 9
	mov $8, %rax
	push %rax
	.loc 1 62 12
	.loc 1 62 17
	mov $3, %rax
	push %rax
	.loc 1 62 20
	mov $5, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add2
	push %rax
	.loc 1 62 24
	lea .L..2(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 63 2
	.loc 1 63 2
	.loc 1 63 9
	mov $2, %rax
	push %rax
	.loc 1 63 12
	.loc 1 63 17
	mov $5, %rax
	push %rax
	.loc 1 63 20
	mov $3, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call sub2
	push %rax
	.loc 1 63 24
	lea .L..3(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 64 2
	.loc 1 64 2
	.loc 1 64 9
	mov $21, %rax
	push %rax
	.loc 1 64 13
	.loc 1 64 18
	mov $1, %rax
	push %rax
	.loc 1 64 20
	mov $2, %rax
	push %rax
	.loc 1 64 22
	mov $3, %rax
	push %rax
	.loc 1 64 24
	mov $4, %rax
	push %rax
	.loc 1 64 26
	mov $5, %rax
	push %rax
	.loc 1 64 28
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
	.loc 1 64 32
	lea .L..4(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 65 2
	.loc 1 65 2
	.loc 1 65 9
	mov $66, %rax
	push %rax
	.loc 1 65 13
	.loc 1 65 18
	mov $1, %rax
	push %rax
	.loc 1 65 20
	mov $2, %rax
	push %rax
	.loc 1 65 22
	.loc 1 65 27
	mov $3, %rax
	push %rax
	.loc 1 65 29
	mov $4, %rax
	push %rax
	.loc 1 65 31
	mov $5, %rax
	push %rax
	.loc 1 65 33
	mov $6, %rax
	push %rax
	.loc 1 65 35
	mov $7, %rax
	push %rax
	.loc 1 65 37
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
	.loc 1 65 40
	mov $9, %rax
	push %rax
	.loc 1 65 42
	mov $10, %rax
	push %rax
	.loc 1 65 45
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
	.loc 1 65 50
	lea .L..5(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 66 2
	.loc 1 66 2
	.loc 1 66 9
	mov $136, %rax
	push %rax
	.loc 1 66 14
	.loc 1 66 19
	mov $1, %rax
	push %rax
	.loc 1 66 21
	mov $2, %rax
	push %rax
	.loc 1 66 23
	.loc 1 66 28
	mov $3, %rax
	push %rax
	.loc 1 66 30
	.loc 1 66 35
	mov $4, %rax
	push %rax
	.loc 1 66 37
	mov $5, %rax
	push %rax
	.loc 1 66 39
	mov $6, %rax
	push %rax
	.loc 1 66 41
	mov $7, %rax
	push %rax
	.loc 1 66 43
	mov $8, %rax
	push %rax
	.loc 1 66 45
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
	.loc 1 66 48
	mov $10, %rax
	push %rax
	.loc 1 66 51
	mov $11, %rax
	push %rax
	.loc 1 66 54
	mov $12, %rax
	push %rax
	.loc 1 66 57
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
	.loc 1 66 61
	mov $14, %rax
	push %rax
	.loc 1 66 64
	mov $15, %rax
	push %rax
	.loc 1 66 67
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
	.loc 1 66 72
	lea .L..6(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 67 2
	.loc 1 67 2
	.loc 1 67 9
	mov $7, %rax
	push %rax
	.loc 1 67 12
	.loc 1 67 17
	mov $3, %rax
	push %rax
	.loc 1 67 19
	mov $4, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call add2
	push %rax
	.loc 1 67 23
	lea .L..7(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 68 2
	.loc 1 68 2
	.loc 1 68 9
	mov $1, %rax
	push %rax
	.loc 1 68 12
	.loc 1 68 17
	mov $4, %rax
	push %rax
	.loc 1 68 19
	mov $3, %rax
	push %rax
	pop %rsi
	pop %rdi
	mov $0, %rax
	call sub2
	push %rax
	.loc 1 68 23
	lea .L..8(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 69 2
	.loc 1 69 2
	.loc 1 69 9
	mov $55, %rax
	push %rax
	.loc 1 69 13
	.loc 1 69 17
	mov $9, %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call fib
	push %rax
	.loc 1 69 21
	lea .L..9(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 70 2
	.loc 1 70 2
	.loc 1 70 9
	mov $1, %rax
	push %rax
	.loc 1 70 12
	.loc 1 70 15
	.loc 1 70 15
	.loc 1 70 24
	mov $7, %rax
	push %rax
	.loc 1 70 27
	mov $3, %rax
	push %rax
	.loc 1 70 30
	mov $3, %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call sub_char
	push %rax
	.loc 1 70 38
	lea .L..10(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 71 2
	.loc 1 71 2
	.loc 1 71 9
	lea .L..11(%rip), %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call printf
	.loc 1 72 2
	.loc 1 72 9
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
	.loc 1 59 0
	.loc 1 56 2
	.loc 1 56 7
	.loc 1 56 9
	mov $1, %rax
	push %rax
	.loc 1 56 6
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	cmp $0, %rax
	je  .L.else.1
	.loc 1 57 4
	.loc 1 57 11
	mov $1, %rax
	jmp .L.return.fib
	jmp .L.end.1
.L.else.1:
.L.end.1:
	.loc 1 58 2
	.loc 1 58 18
	.loc 1 58 20
	.loc 1 58 25
	.loc 1 58 26
	mov $2, %rax
	push %rax
	.loc 1 58 24
	lea -8(%rbp), %rax
	mov (%rax), %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call fib
	push %rax
	.loc 1 58 9
	.loc 1 58 14
	.loc 1 58 15
	mov $1, %rax
	push %rax
	.loc 1 58 13
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
	.loc 1 54 0
	.loc 1 53 2
	.loc 1 53 15
	.loc 1 53 17
	lea -3(%rbp), %rax
	movsbq (%rax), %rax
	push %rax
	.loc 1 53 11
	.loc 1 53 13
	lea -2(%rbp), %rax
	movsbq (%rax), %rax
	push %rax
	.loc 1 53 9
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
	.loc 1 51 0
	.loc 1 50 2
	.loc 1 50 12
	.loc 1 50 14
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 50 9
	.loc 1 50 10
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
	.loc 1 48 0
	.loc 1 47 2
	.loc 1 47 27
	.loc 1 47 29
	lea -48(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 47 23
	.loc 1 47 25
	lea -40(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 47 19
	.loc 1 47 21
	lea -32(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 47 15
	.loc 1 47 17
	lea -24(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 47 11
	.loc 1 47 13
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 47 9
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
	.loc 1 45 0
	.loc 1 44 2
	.loc 1 44 11
	.loc 1 44 13
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 44 9
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
	.loc 1 42 0
	.loc 1 41 2
	.loc 1 41 11
	.loc 1 41 13
	lea -16(%rbp), %rax
	mov (%rax), %rax
	push %rax
	.loc 1 41 9
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
	.loc 1 39 0
	.loc 1 37 2
	.loc 1 37 9
	mov $3, %rax
	jmp .L.return.ret3
	.loc 1 38 2
	.loc 1 38 9
	mov $5, %rax
	jmp .L.return.ret3
.L.return.ret3:
	ret
