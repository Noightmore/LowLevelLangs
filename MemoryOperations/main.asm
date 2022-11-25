; memory subroutines tester

; compile with: nasm -f elf64 main.asm -o main.o
; link with: ld main.o -o main
; run with: ./main

; written for 64-bit mode
%include "print_functions.asm"
%include "general_functions.asm"
%include "malloc.asm"
%include "free.asm"

section .rodata
    hello_world: db "Hello, world!", 0
    newline: db 10, 0
    number_7: db 7

section .text
    global _start

_start:
    mov rdi, hello_world ; load input arguments for the function
    call print ; call the function
    xor rax, rax ; clear return value

    mov rdi, newline
    call print
    xor rax, rax

    mov rdi, [number_7]
    call print_num
    xor rax, rax

    call exit