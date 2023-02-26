; Compile with: nasm -f elf64 random_seed_test.asm
; Link with (64 bit systems require elf_i386 option): ld random_seed_test.o -o random_seed_test
; Run with: ./random_seed_test


; this is definitely not my idea, this algorithm is amazing! yay
; source:
; https://redirect.cs.umbc.edu/courses/undergraduate/CMSC211/fall01/burt/lectures/Chap14/random.html
; rewritten from IBM pc assembly to x86_64 nasm assembly

%include "print_functions.asm"

section .data
    seed:  dd 8

    A  equ	16807
    S0 equ seed ;	Low order word of seed
    S1 equ seed + 2 ;	High order word of seed

section .text
    global _start

_start:

xor rax, rax
_loop:
    push rax
    call gen_random_seed
    mov rdi, [seed]
    call print_num
    pop rax
    inc rax
    cmp rax, 30
    jne _loop

;exit
mov rax, 60
mov rdi, 0
syscall

gen_random_seed:
push rbp
mov rbp, rsp

;
;	P2|P1|P0 := (S1|S0) * A
;
mov	ax, [S0]
mov	bx, A
mul	bx
mov	si, dx ;	si := pp01  (pp = partial product)
mov	di, ax ;	di := pp00 = P0
mov	ax, [S1]
mul	bx ;	ax := pp11
add	ax, si ;	ax := pp11 + pp01 = P1
adc	dx, 0 ;	dx := pp12 + carry = P2

;
;	P2|P1:P0 = p * 2**31 + q, 0 <= q < 2**31
;
;	p = P2 SHL 1 + sign bit of P1 --> dx
;		(P2:P1|P0 < 2**46 so p fits in a single word)
;	q = (P1 AND 7FFFh)|P0 = (ax AND 7fffh) | di
;
shl	ax, 1
rcl	dx, 1
shr	ax, 1
;
;	dx:ax := p + q
;
add	dx, di ;	dx := p0 + q0
adc	ax, 0 ;	ax := q1 + carry
xchg ax, dx
;
;	if p+q < 2**31 then p+q is the new seed; otherwise whack
;	  off the sign bit and add 1 and THATs the new seed
;
test	dx, 8000h
jz	Store
and	dx, 7fffh
add	ax, 1 ;		inc doesn't set carry bit
adc	dx, 0

Store:
	mov	[S1], dx
	mov	[S0], ax

leave
ret


