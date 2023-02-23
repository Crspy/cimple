.data
.globl .L..27
.L..27:
	.byte 79
	.byte 75
	.byte 10
	.byte 0
.data
.globl .L..26
.L..26:
	.byte 49
	.byte 62
	.byte 61
	.byte 50
	.byte 0
.data
.globl .L..25
.L..25:
	.byte 49
	.byte 62
	.byte 61
	.byte 49
	.byte 0
.data
.globl .L..24
.L..24:
	.byte 49
	.byte 62
	.byte 61
	.byte 48
	.byte 0
.data
.globl .L..23
.L..23:
	.byte 49
	.byte 62
	.byte 50
	.byte 0
.data
.globl .L..22
.L..22:
	.byte 49
	.byte 62
	.byte 49
	.byte 0
.data
.globl .L..21
.L..21:
	.byte 49
	.byte 62
	.byte 48
	.byte 0
.data
.globl .L..20
.L..20:
	.byte 50
	.byte 60
	.byte 61
	.byte 49
	.byte 0
.data
.globl .L..19
.L..19:
	.byte 49
	.byte 60
	.byte 61
	.byte 49
	.byte 0
.data
.globl .L..18
.L..18:
	.byte 48
	.byte 60
	.byte 61
	.byte 49
	.byte 0
.data
.globl .L..17
.L..17:
	.byte 50
	.byte 60
	.byte 49
	.byte 0
.data
.globl .L..16
.L..16:
	.byte 49
	.byte 60
	.byte 49
	.byte 0
.data
.globl .L..15
.L..15:
	.byte 48
	.byte 60
	.byte 49
	.byte 0
.data
.globl .L..14
.L..14:
	.byte 52
	.byte 50
	.byte 33
	.byte 61
	.byte 52
	.byte 50
	.byte 0
.data
.globl .L..13
.L..13:
	.byte 48
	.byte 33
	.byte 61
	.byte 49
	.byte 0
.data
.globl .L..12
.L..12:
	.byte 52
	.byte 50
	.byte 61
	.byte 61
	.byte 52
	.byte 50
	.byte 0
.data
.globl .L..11
.L..11:
	.byte 48
	.byte 61
	.byte 61
	.byte 49
	.byte 0
.data
.globl .L..10
.L..10:
	.byte 45
	.byte 32
	.byte 45
	.byte 32
	.byte 43
	.byte 49
	.byte 48
	.byte 0
.data
.globl .L..9
.L..9:
	.byte 45
	.byte 32
	.byte 45
	.byte 49
	.byte 48
	.byte 0
.data
.globl .L..8
.L..8:
	.byte 45
	.byte 49
	.byte 48
	.byte 43
	.byte 50
	.byte 48
	.byte 0
.data
.globl .L..7
.L..7:
	.byte 40
	.byte 51
	.byte 43
	.byte 53
	.byte 41
	.byte 47
	.byte 50
	.byte 0
.data
.globl .L..6
.L..6:
	.byte 53
	.byte 42
	.byte 40
	.byte 57
	.byte 45
	.byte 54
	.byte 41
	.byte 0
.data
.globl .L..5
.L..5:
	.byte 53
	.byte 43
	.byte 54
	.byte 42
	.byte 55
	.byte 0
.data
.globl .L..4
.L..4:
	.byte 49
	.byte 50
	.byte 32
	.byte 43
	.byte 32
	.byte 51
	.byte 52
	.byte 32
	.byte 45
	.byte 32
	.byte 53
	.byte 0
.data
.globl .L..3
.L..3:
	.byte 53
	.byte 43
	.byte 50
	.byte 48
	.byte 45
	.byte 52
	.byte 0
.data
.globl .L..2
.L..2:
	.byte 52
	.byte 50
	.byte 0
.data
.globl .L..1
.L..1:
	.byte 48
	.byte 0
.text
.globl main
main:
	mov $0, %rax
	push %rax
	mov $0, %rax
	push %rax
	lea .L..1(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $42, %rax
	push %rax
	mov $42, %rax
	push %rax
	lea .L..2(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $21, %rax
	push %rax
	mov $4, %rax
	push %rax
	mov $20, %rax
	push %rax
	mov $5, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	lea .L..3(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $41, %rax
	push %rax
	mov $5, %rax
	push %rax
	mov $34, %rax
	push %rax
	mov $12, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	lea .L..4(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $47, %rax
	push %rax
	mov $7, %rax
	push %rax
	mov $6, %rax
	pop %rdi
	imul %rdi, %rax
	push %rax
	mov $5, %rax
	pop %rdi
	add %rdi, %rax
	push %rax
	lea .L..5(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $15, %rax
	push %rax
	mov $6, %rax
	push %rax
	mov $9, %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	mov $5, %rax
	pop %rdi
	imul %rdi, %rax
	push %rax
	lea .L..6(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $4, %rax
	push %rax
	mov $2, %rax
	push %rax
	mov $5, %rax
	push %rax
	mov $3, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	cqo

	idiv %rdi
	push %rax
	lea .L..7(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $10, %rax
	push %rax
	mov $20, %rax
	push %rax
	mov $10, %rax
	neg %rax
	pop %rdi
	add %rdi, %rax
	push %rax
	lea .L..8(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $10, %rax
	push %rax
	mov $10, %rax
	neg %rax
	neg %rax
	push %rax
	lea .L..9(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $10, %rax
	push %rax
	mov $10, %rax
	neg %rax
	neg %rax
	push %rax
	lea .L..10(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	sete %al
	movzb %al, %rax
	push %rax
	lea .L..11(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $42, %rax
	push %rax
	mov $42, %rax
	pop %rdi
	cmp %rdi, %rax
	sete %al
	movzb %al, %rax
	push %rax
	lea .L..12(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setne %al
	movzb %al, %rax
	push %rax
	lea .L..13(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $42, %rax
	push %rax
	mov $42, %rax
	pop %rdi
	cmp %rdi, %rax
	setne %al
	movzb %al, %rax
	push %rax
	lea .L..14(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	lea .L..15(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	lea .L..16(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	lea .L..17(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	lea .L..18(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	lea .L..19(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	lea .L..20(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	lea .L..21(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	lea .L..22(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	lea .L..23(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	lea .L..24(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $1, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	lea .L..25(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	mov $0, %rax
	push %rax
	mov $1, %rax
	push %rax
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	lea .L..26(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	lea .L..27(%rip), %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call printf
	mov $0, %rax
	jmp .L.return.main
.L.return.main:
	ret
