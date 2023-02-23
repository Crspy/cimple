.file 1 "-"
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
	.loc 1 65 0
	.loc 1 37 2
	.loc 1 37 2
	.loc 1 37 9
	mov $0, %rax
	push %rax
	.loc 1 37 12
	mov $0, %rax
	push %rax
	.loc 1 37 15
	lea .L..1(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 38 2
	.loc 1 38 2
	.loc 1 38 9
	mov $42, %rax
	push %rax
	.loc 1 38 13
	mov $42, %rax
	push %rax
	.loc 1 38 17
	lea .L..2(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 39 2
	.loc 1 39 2
	.loc 1 39 9
	mov $21, %rax
	push %rax
	.loc 1 39 17
	.loc 1 39 18
	mov $4, %rax
	push %rax
	.loc 1 39 14
	.loc 1 39 15
	mov $20, %rax
	push %rax
	.loc 1 39 13
	mov $5, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	.loc 1 39 21
	lea .L..3(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 40 2
	.loc 1 40 2
	.loc 1 40 9
	mov $41, %rax
	push %rax
	.loc 1 40 21
	.loc 1 40 23
	mov $5, %rax
	push %rax
	.loc 1 40 16
	.loc 1 40 18
	mov $34, %rax
	push %rax
	.loc 1 40 13
	mov $12, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	.loc 1 40 26
	lea .L..4(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 41 2
	.loc 1 41 2
	.loc 1 41 9
	mov $47, %rax
	push %rax
	.loc 1 41 14
	.loc 1 41 16
	.loc 1 41 17
	mov $7, %rax
	push %rax
	.loc 1 41 15
	mov $6, %rax
	pop %rdi
	imul %rdi, %rax
	push %rax
	.loc 1 41 13
	mov $5, %rax
	pop %rdi
	add %rdi, %rax
	push %rax
	.loc 1 41 20
	lea .L..5(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 42 2
	.loc 1 42 2
	.loc 1 42 9
	mov $15, %rax
	push %rax
	.loc 1 42 14
	.loc 1 42 17
	.loc 1 42 18
	mov $6, %rax
	push %rax
	.loc 1 42 16
	mov $9, %rax
	pop %rdi
	sub %rdi, %rax
	push %rax
	.loc 1 42 13
	mov $5, %rax
	pop %rdi
	imul %rdi, %rax
	push %rax
	.loc 1 42 22
	lea .L..6(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 43 2
	.loc 1 43 2
	.loc 1 43 9
	mov $4, %rax
	push %rax
	.loc 1 43 17
	.loc 1 43 18
	mov $2, %rax
	push %rax
	.loc 1 43 14
	.loc 1 43 15
	mov $5, %rax
	push %rax
	.loc 1 43 13
	mov $3, %rax
	pop %rdi
	add %rdi, %rax
	pop %rdi
	cqo

	idiv %rdi
	push %rax
	.loc 1 43 21
	lea .L..7(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 44 2
	.loc 1 44 2
	.loc 1 44 9
	mov $10, %rax
	push %rax
	.loc 1 44 16
	.loc 1 44 17
	mov $20, %rax
	push %rax
	.loc 1 44 13
	.loc 1 44 14
	mov $10, %rax
	neg %rax
	pop %rdi
	add %rdi, %rax
	push %rax
	.loc 1 44 21
	lea .L..8(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 45 2
	.loc 1 45 2
	.loc 1 45 9
	mov $10, %rax
	push %rax
	.loc 1 45 13
	.loc 1 45 15
	.loc 1 45 16
	mov $10, %rax
	neg %rax
	neg %rax
	push %rax
	.loc 1 45 20
	lea .L..9(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 46 2
	.loc 1 46 2
	.loc 1 46 9
	mov $10, %rax
	push %rax
	.loc 1 46 13
	.loc 1 46 15
	.loc 1 46 18
	mov $10, %rax
	neg %rax
	neg %rax
	push %rax
	.loc 1 46 22
	lea .L..10(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 47 2
	.loc 1 47 2
	.loc 1 47 9
	mov $0, %rax
	push %rax
	.loc 1 47 13
	.loc 1 47 15
	mov $1, %rax
	push %rax
	.loc 1 47 12
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	sete %al
	movzb %al, %rax
	push %rax
	.loc 1 47 18
	lea .L..11(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 48 2
	.loc 1 48 2
	.loc 1 48 9
	mov $1, %rax
	push %rax
	.loc 1 48 14
	.loc 1 48 16
	mov $42, %rax
	push %rax
	.loc 1 48 12
	mov $42, %rax
	pop %rdi
	cmp %rdi, %rax
	sete %al
	movzb %al, %rax
	push %rax
	.loc 1 48 20
	lea .L..12(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 49 2
	.loc 1 49 2
	.loc 1 49 9
	mov $1, %rax
	push %rax
	.loc 1 49 13
	.loc 1 49 15
	mov $1, %rax
	push %rax
	.loc 1 49 12
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setne %al
	movzb %al, %rax
	push %rax
	.loc 1 49 18
	lea .L..13(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 50 2
	.loc 1 50 2
	.loc 1 50 9
	mov $0, %rax
	push %rax
	.loc 1 50 14
	.loc 1 50 16
	mov $42, %rax
	push %rax
	.loc 1 50 12
	mov $42, %rax
	pop %rdi
	cmp %rdi, %rax
	setne %al
	movzb %al, %rax
	push %rax
	.loc 1 50 20
	lea .L..14(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 51 2
	.loc 1 51 2
	.loc 1 51 9
	mov $1, %rax
	push %rax
	.loc 1 51 13
	.loc 1 51 14
	mov $1, %rax
	push %rax
	.loc 1 51 12
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	.loc 1 51 17
	lea .L..15(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 52 2
	.loc 1 52 2
	.loc 1 52 9
	mov $0, %rax
	push %rax
	.loc 1 52 13
	.loc 1 52 14
	mov $1, %rax
	push %rax
	.loc 1 52 12
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	.loc 1 52 17
	lea .L..16(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 53 2
	.loc 1 53 2
	.loc 1 53 9
	mov $0, %rax
	push %rax
	.loc 1 53 13
	.loc 1 53 14
	mov $1, %rax
	push %rax
	.loc 1 53 12
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	.loc 1 53 17
	lea .L..17(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 54 2
	.loc 1 54 2
	.loc 1 54 9
	mov $1, %rax
	push %rax
	.loc 1 54 13
	.loc 1 54 15
	mov $1, %rax
	push %rax
	.loc 1 54 12
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	.loc 1 54 18
	lea .L..18(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 55 2
	.loc 1 55 2
	.loc 1 55 9
	mov $1, %rax
	push %rax
	.loc 1 55 13
	.loc 1 55 15
	mov $1, %rax
	push %rax
	.loc 1 55 12
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	.loc 1 55 18
	lea .L..19(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 56 2
	.loc 1 56 2
	.loc 1 56 9
	mov $0, %rax
	push %rax
	.loc 1 56 13
	.loc 1 56 15
	mov $1, %rax
	push %rax
	.loc 1 56 12
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	.loc 1 56 18
	lea .L..20(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 57 2
	.loc 1 57 2
	.loc 1 57 9
	mov $1, %rax
	push %rax
	.loc 1 57 13
	.loc 1 57 12
	mov $1, %rax
	push %rax
	.loc 1 57 14
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	.loc 1 57 17
	lea .L..21(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 58 2
	.loc 1 58 2
	.loc 1 58 9
	mov $0, %rax
	push %rax
	.loc 1 58 13
	.loc 1 58 12
	mov $1, %rax
	push %rax
	.loc 1 58 14
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	.loc 1 58 17
	lea .L..22(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 59 2
	.loc 1 59 2
	.loc 1 59 9
	mov $0, %rax
	push %rax
	.loc 1 59 13
	.loc 1 59 12
	mov $1, %rax
	push %rax
	.loc 1 59 14
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setl %al
	movzb %al, %rax
	push %rax
	.loc 1 59 17
	lea .L..23(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 60 2
	.loc 1 60 2
	.loc 1 60 9
	mov $1, %rax
	push %rax
	.loc 1 60 13
	.loc 1 60 12
	mov $1, %rax
	push %rax
	.loc 1 60 15
	mov $0, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	.loc 1 60 18
	lea .L..24(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 61 2
	.loc 1 61 2
	.loc 1 61 9
	mov $1, %rax
	push %rax
	.loc 1 61 13
	.loc 1 61 12
	mov $1, %rax
	push %rax
	.loc 1 61 15
	mov $1, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	.loc 1 61 18
	lea .L..25(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 62 2
	.loc 1 62 2
	.loc 1 62 9
	mov $0, %rax
	push %rax
	.loc 1 62 13
	.loc 1 62 12
	mov $1, %rax
	push %rax
	.loc 1 62 15
	mov $2, %rax
	pop %rdi
	cmp %rdi, %rax
	setle %al
	movzb %al, %rax
	push %rax
	.loc 1 62 18
	lea .L..26(%rip), %rax
	push %rax
	pop %rdx
	pop %rsi
	pop %rdi
	mov $0, %rax
	call assert
	.loc 1 63 2
	.loc 1 63 2
	.loc 1 63 9
	lea .L..27(%rip), %rax
	push %rax
	pop %rdi
	mov $0, %rax
	call printf
	.loc 1 64 2
	.loc 1 64 9
	mov $0, %rax
	jmp .L.return.main
.L.return.main:
	ret
