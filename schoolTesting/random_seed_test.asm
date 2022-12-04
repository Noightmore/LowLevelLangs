; Compile with: nasm -f elf64 random_seed_test.asm
; Link with (64 bit systems require elf_i386 option): ld random_seed_test.o -o random_seed_test
; Run with: ./random_seed_test

%include "print_functions.asm"

section .data
    seed:  dq 89
    seed_len: dq 2
    digits_vec: dq 1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000
    x86_64_ptr_byte_size equ 8 ; 64-bit pointers are 8 bytes

section .text
    global _start

_start:

times 2 call gen_random_seed

;exit
mov rax, 60
mov rdi, 0
syscall

gen_random_seed:
 push rbp
     mov rbp, rsp

     ; middle square method for generating random number by seed

     ; square seed
     mov rax, [seed]
     mul rax
     push rax ; back up squared seed on stack

     ; loads trim divider-----------------
     mov rax, [seed_len]
     shr rax, 1 ; rax = rax / 2
     dec rax
     shl rax, 3 ; rdx = rdx * 8
     add rax, digits_vec
     mov rcx, [rax] ; get digit count by the amount of digits in the seed 1, 10, 100, 1000
     ;-------------------------------------
 ;    push rcx
 ;    push rax
 ;
 ;    mov rdi, rcx
 ;    call print_num ; DEBUG
 ;
 ;    pop rax
 ;    pop rcx

     pop rax ;  load squared seed
     div rcx ; rax = rax / rcx ; digits[trim]

     push rcx
     push rax

     mov rdi, rax
     call print_num ; DEBUG

     pop rax
     pop rcx

     xor rbx, rbx ; clear rdx
     xor r10, r10 ; clear r10 ; index of loop
     _foreachDigit:
         push rcx ; backup seed digit count
         push rbx ; backup rbx
         push rax ; backup squared seed

         mov rdi, rax
         mov rsi, rcx
         call get_modulus
         push rax ; backup the modulus product

         ; compute the digit id by loop iteration
         mov rax, r10
         shl rax, 3 ; rax = rax * 8
         add rax, digits_vec
         mov rcx, [rax] ; digit count for current iteration

         pop rax ; modulus product
         mul rcx ; rax = rax * rcx
         mov rcx, rax

         pop rax ; squared seed
         pop rbx ; final product
         ; rbx = rbx + rcx ; final_val + (squared seed % digit count of seed) * digit count of current iteration
         add rbx, rcx
         pop rcx ; restore seed digit count

         push rbx ; backup final product

 ;        push rax
 ;        push r10
 ;        push r11
 ;        push rcx
 ;        mov rdi, rax
 ;        call print_num
 ;        pop rcx
 ;        pop r11
 ;        pop r10
 ;        pop rax

         mov rbx, 10
         div rbx ; rax = rax / r11 == rax = rax / 10
         pop rbx ; load back final product


     inc r10 ; increment index of loop
     cmp r10, [seed_len]
     jnz _foreachDigit

     leave
     ret


